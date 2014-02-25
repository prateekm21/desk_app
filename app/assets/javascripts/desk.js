var add_label = function(_api,name,desc,type,color) {
    targetEle = $(document.body).find('div#add_label_result');
    data_obj = {
      label: name,
      description: desc,
      type: type,
      color: color
    }

    $.post(_api, data_obj, function(data) {
       targetEle.append('<strong>'+data.success+'</strong>')
    }).error(function(xhr, status, error){
        err = xhr.responseText
        targetEle.append('<strong>'+err+'</strong>')
    });
  }

  var renderCase = function(_api) {
    targetEle = $(document.body).find('div#information ul.result-items');
    targetEle.empty();

    targetEle.append("<b>ALL CASES DESCRIPTION and There LABEL ARE LISTED<b>");
    targetEle.append('<br><br>');
    var ele = ""
    ele = '<table border="1" style="width:800px">';
    ele = ele + '<tr>';
    ele = ele + '<td><b>Description</b></td>';
    ele = ele + '<td><b>Label</b></td>';
    ele = ele + '</tr>';
    $.get(_api, function(data) {
      $.each(data, function() {
        ele = ele + '<tr>';
        ele = ele + '<td>'+  this.blurb +'</td>';
        ele = ele + '<td>'+  this.labels +'</td>';
        ele = ele + '</tr>';
      });
      ele = ele + "</table>"
      targetEle.append(ele);
      

    })
  }

  var renderLable = function(_api) {
    targetEle = $(document.body).find('div#information ul.result-items');

    $.get(_api, function(data) {
      targetEle.append("<b>ONLY LABLES NAME ARE LISTED</b>");
      targetEle.append('<br><br>');
      $.each(data, function() {
        console.log(this)
        var ele = '<li>' + this.name + '</li>';
        targetEle.append(ele);
        targetEle.append('<br>');
      });
    })
  }