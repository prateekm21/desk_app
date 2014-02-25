class Desk

  def self.token_handler_get _url
    TokenHandler.new.get_data(_url)
  end

  def self.token_handler_post(_url, data)
    TokenHandler.new.post_data(_url, data)
  end

  def self.token_handler_put(_url, data)
    TokenHandler.new.put_data(_url, data)
  end

  def self.retrive_all_cases
    _url     =  "https://pmcompany.desk.com/api/v2/cases"
    response = token_handler_get _url

    if response.present?
      _tmp = ""
      response.entries.map do |ech_case|
        #extract cases from reponse
        if ech_case.include?("_embedded")
           _tmp = ech_case[1]['entries']
        end
      end
      data = {info: _tmp, status: 200}
    else
      data = {info: {error: "Could not retrive case info"}, status: 400}
    end

    data
  end

  def self.retrive_all_labels
    _url     =  "https://pmcompany.desk.com/api/v2/labels"
    response = token_handler_get _url

    if response.present?
      #extract label name and description from reponse
      _tmp = response['_embedded']['entries'].map do |ech_label|
        {name: ech_label['name'], description: ech_label['description']}
      end
      data = {info: _tmp, status: 200}
    else
      data = {info: {error: "Could not retrive labels info"}, status: 400}
    end

    data
  end

  def self.add_label params
    _url   =  "https://pmcompany.desk.com/api/v2/labels"
    _color = ['default', 'blue', 'white', 'yellow', 'red', 'orange',
              'green', 'black', 'purple', 'brown', 'grey', 'pink',nil]

    #check for valid type
    if (params[:type].blank? or ['case','macro','article'].include? params[:type])
      type = params[:types]
    else
      return {info: {error: "invalid label type"}, status: 422}
    end


    #check for valid color
    if _color.include? params[:color]
      color = params[:color]
    else
      return {info: {error: "invalid label color"}, status: 422}
    end

    data = {
      name:        params[:label],
      description: params[:description],
      types:       type,
      color:       color
    }

    response = token_handler_post(_url, data)

    if response.instance_of?(Net::HTTPClientError)
      return {info:{error: JSON.parse(response.body)}, status: 422}
    else
      self.update_case(params[:label])
      return {info:{success: "label added and applied to case#1"}, status: 200}
    end
  end

  def self.update_case label
    _url   =  "https://pmcompany.desk.com/api/v2/cases/1"
    data   = {
      labels: [label]
    }
    response = token_handler_put(_url, data)
    response
  end  

end