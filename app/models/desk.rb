class Desk

  def self.token_handler_obj _url
    TokenHandler.new.data(_url)
  end

  def self.retrive_all_cases
    _url     =  "https://pmcompany.desk.com/api/v2/cases"
    response = token_handler_obj _url

    if response.present?
      _tmp = ""
      response.entries.map do |ech_case|
        if ech_case.include?("_embedded")
           _tmp = ech_case[1]['entries']
        end
      end
      data = {info: _tmp, status: 200}
    else
      data = {info: {error: "Could not retrive case info"}, status: 422}
    end

    data
  end

  def self.retrive_all_labels
    _url     =  "https://pmcompany.desk.com/api/v2/labels"
    response = token_handler_obj _url

    if response.present?
      _tmp = response['_embedded']['entries'].map do |ech_label|
        {name: ech_label['name'], description: ech_label['description']}
      end
      data = {info: _tmp, status: 200}
    else
      data = {info: {error: "Could not retrive labels info"}, status: 422}
    end

    data
  end

end