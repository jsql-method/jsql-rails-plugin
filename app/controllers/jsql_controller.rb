require 'digest'
require 'timeout'
class JSQLController < ActionController::API
  @@transaction = Array.new
  @@database_type = nil

  def perform_method(method)
    manager = nil
    puts Jsql.configuration.member_key
    puts Jsql.configuration.api_key
    puts "@database_type"
    puts @@database_type
    puts "@@transaction"
    puts @@transaction
    puts Time::now.tv_sec
    begin

      request_body = JSON.parse(request.body.string)
      delete_manager_time
      manager = transaction_control

      query = create_query(request_body)

      query = params_switcher(query, request_body)
      query_method_compare(query, method)

    rescue Timeout::Error
      rollback_manager(manager)
    end
  end

  def delete_manager_time()
    @@transaction.delete_if {|a| a[2] < Time::now.tv_sec - 10}
  end

  def delete_manager(manager)
    @@transaction.delete_if {|y| y[1] == manager}
  end


  def transaction_control
    request_headers = request.headers
    transactional = request_headers['TX']
    transaction_id = request_headers['TXID']
    puts transactional
    puts transaction_id
    if transactional
      puts "This should be trasnacttional!"
      now = Time.now.to_s
      if transaction_id == nil || transaction_id.size < 1
        transaction_id = Digest::MD5.new.update(now)
        puts transaction_id
        manager = ActiveRecord::Base.connection.transaction_manager
        @@transaction.push([transaction_id, manager, Time::now.tv_sec])
        puts "31"
      else
        puts "33"
        puts manager.class
        puts manager.class
        manager = find_manager(transaction_id)
        if manager == nil
          manager = ActiveRecord::Base.connection.transaction_manager
          @@transaction.push([transaction_id, manager, Time::now.tv_sec])
        end
      end
      puts "ManageR"
      puts manager
      puts "ManageR"
      puts "@@transaction"
      puts @@transaction
      manager.begin_transaction
    end
    manager
  end

  def find_manager(transaction_id)
    begin
      puts "+++++====++++"
      puts "@@transaction.select{|(x, y)| x == transaction_id}"
      manager = @@transaction.select {|(x, y)| x == transaction_id}
      manager = manager[0][1]
      puts manager
      manager
      puts "+++++====++++"
    rescue NoMethodError
      manager = nil
    end

    manager
  end

  def create_query(request_body)
    query = ""
    token = request_body['token']

    if token.class == Array

      for i in 0..token.size - 1
        if i > 0
          query += " "
        end
        query += get_queries(token[i])
        puts "query.class"
        puts query.class
        puts "query"
        puts query
        if query.include? "code"
          query
          break
        end
      end


    else
      query = get_queries(token.to_s)
      puts query
    end

    query
  end

  def get_queries(token)
#url and headers
    base_url = 'http://softwarecartoon.com:'
    port = '9291'
    queries = '/api/request/queries'
    member_key = Jsql.configuration.member_key
    api_key = Jsql.configuration.api_key
    url = base_url + port + queries
    database_type((base_url + port), member_key, api_key)
#parsing token into right regex
    token = "[\"" + token + "\"]"

    query = HTTP
                .headers('Content-Type' => 'application/json', 'memberKey' => member_key, 'apiKey' => api_key)
                .post(url, :body => token).body.to_s
    puts "query"
    puts query
#parsing response to json

    header = HTTP
                 .headers('Content-Type' => 'application/json', 'memberKey' => member_key, 'apiKey' => api_key)
                 .post(url, :body => token).headers
    puts header.class

    no_such_hash = "Cannot get property 'query' on null object"
    begin
      if (JSON.parse(query)[0] == nil || JSON.parse(query)[0]['query'] == nil) && JSON.parse(query)['message'] == no_such_hash
        puts query
        render_error_msg("No such hash for given ApiKey and MemberKey")
      elsif JSON.parse(query)['code'] != 200
        query
      else
        (JSON.parse(query)[0]['query'])
      end
    rescue
      (JSON.parse(query)[0]['query'])
    end
  end

  def database_type(base, member_key, api_key)
    if @@database_type == nil
      url = base + "/api/request/options/all"
      response = HTTP
                     .headers('Content-Type' => 'application/json', 'memberKey' => member_key, 'apiKey' => api_key)
                     .get(url).body.to_s
      puts response
      if JSON.parse(response)['code'] != 200
        render_error_msg(JSON.parse(response)['description'])
      else
        @@database_type = JSON.parse(response)['data']['databaseDialect']
      end

    end
  end

  def params_switcher(query, request_body)
#method replaces all question marks with params
    if (query.include? '?')
      query = question_mark_switcher(query, request_body)
      puts "query.include? '?'"
      puts query
    elsif (query.include? ':')
      query = colon_switcher(query, request_body)
      puts "query.include? ':'"
    end
    query
  end

  def question_mark_switcher(query, request_body)
    if (request_body['params'].class == Array) && (query.include? "?") && (query.count('?') - request_body['params'].size < 1)
      puts " posiada '?'"
      question_marks = query.count('?')
      puts question_marks
      params = request_body['params']
      puts params
      puts "(query.count('?') - request_body['params'].size)"
      puts (query.count('?') - request_body['params'].size)
      puts "question_marks"
      puts query.count('?')
      puts "query"
      puts query
      puts "request_body['params'].size"
      puts request_body['params'].size
      for i in 0..question_marks
        puts query.sub!('?', "'" + params[i].to_s + "'")
        request_body['params'].delete_if {|e| e[i] == params[i]}
      end
    else
      begin
        missing_params = (query.count('?') - request_body['params'].size).to_s
      rescue
        missing_params = query.count('?').to_s
      end
      query = render_error_msg("There are " + missing_params + " missing parameters")
      puts query
    end
    puts query
    query
  end


  def missing_params_collector(missing_params, param)
    if missing_params.size > 1
      missing_params += ", "
    end
    missing_params += ":" + param
  end

  def query_method_compare(query, method)
    puts "query_method_compare(" + query.to_s + ", " + method.to_s + ")"
    if query.to_s.downcase.start_with?(method)
      begin
        if method == 'insert'
          if @@database_type == 'POSTGRES'
            query += " returning *"
          end
          #puts response.class
          #puts response
          response = ActiveRecord::Base.connection.execute(query).as_json
          # manager.commit_transaction
          last_id = response[0]['id']
          render json: {status: 'OK', lastId: last_id}, status: :ok
        elsif method == 'delete'
          if @@database_type == 'POSTGRES'
            query += " returning *"
          end
          response = ActiveRecord::Base.connection.execute(query).as_json
          if response.empty?
            render_error_msg('given column does not exist')
          else
            render json: {status: 'OK', response: JSON.parse(response.to_json)}, status: :ok
          end

        else
          response = ActiveRecord::Base.connection.execute(query).as_json
          render json: {status: 'OK', response: JSON.parse(response.to_json)}, status: :ok
        end
      rescue
        msg = "#{$!}"
        render_error_msg(msg.split("\n")[0])
      end
    elsif query.start_with?("{")
      query
    else
      render json: {code: 400, response: "Only " + method.upcase + " queries allowed"}, status: :ok
    end
  end

  def render_error_msg(message)
    render json: {code: 400, response: message}, status: :ok
  end

  def colon_switcher(query, request_body)
    splited_query = query.to_s.gsub('(', ' ').gsub(')', ' ').gsub(',', ' ').gsub('=', ' ').split
    words = splited_query.size
    missing_params_flag = false
    missing_params = "["
    params_array = request_body['params']
=begin
    puts "request_body['params'].class"
    puts request_body['params'].class
=end
    #puts "params_array: " + params_array.to_s
    puts "words"
    puts words
    for i in 0..words
      puts "params_array.class != Hash"
      puts params_array.class != Hash
      if splited_query[i].to_s.start_with?(':')
        param = splited_query[i].split(/:/)[1]
        puts "params_array.class != Hash"
        puts params_array.class != Hash
        if (params_array.class != Hash) || (params_array == nil) || (request_body['params'][param] == nil)
          missing_params = missing_params_collector(missing_params, param)
          puts "Missing Params!"
          missing_params_flag = true
        else
          query.gsub!(':' + param.to_s, "'" + params_array[param].to_s + "'")
        end
      end

    end
    if missing_params_flag
      missing_params += "]"
      query = render_error_msg('There are missing parameters: ' + missing_params)
    end
    query
  end

  def rollback_manager(manager)
    delete_manager(manager)
    manager.rollback_transaction
  end
end
