$(".projects-view_piechart").ready(function() {
  google.charts.load('current', {'packages':['corechart']});
  
  function drawChart(piechart_data) {

    var data = google.visualization.arrayToDataTable(piechart_data);

    var options = {
      title: 'Project Todos Status'
    };

    var chart = new google.visualization.PieChart(document.getElementById('piechart_div'));

    chart.draw(data, options);
  }

  $.ajax({
    url: 'piechart_data',
    method: 'GET',
    success: function(response) {
      drawChart(response.piechart_data);
    }
  });

});