// from data.js
var tableData = data;
var tbody = d3.select("#ufo-table");
var submit = d3.select("#filter-btn");
//var filteredData = tableData.filter(tdat => tdat.shape === 'circle');

tableData.forEach((truth) => {
    var row = tbody.append("tr");
    Object.entries(truth).forEach(([key, value]) => {
      var cell = tbody.append("td");
      cell.text(value);
    });
  });

submit.on("click", function() {
    d3.event.preventDefault();  
    var button = d3.select("#filter-btn");
    var inputField = d3.select("#datetime");
    var inputValue =  inputField.property("value");
    var newFilteredData = tableData.filter(tdat2 => tdat2.datetime === inputValue)

    tbody.text("");
    var header = tbody.append("thead").append("tr");
    //var cols = ['Date','City','State','Country','Shape','Duration','Comments']
    header.append('th').text("Date");
    header.append('th').text("City");
    header.append('th').text("State");
    header.append('th').text("Country");
    header.append('th').text("Shape");
    header.append('th').text("Duration");
    header.append('th').text("Comments");

    newFilteredData.forEach((newtruth) => {
        var row = tbody.append("tr");
        Object.entries(newtruth).forEach(([key, value]) => {
          var cell = tbody.append("td");
          cell.text(value);
        });
      });
    })













