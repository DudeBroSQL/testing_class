// var data2 = [{
//     values: [19, 26, 55],
//     labels: ['Residential', 'Non-Residential', 'Utility'],
//     type: 'pie'
//   }];
var data5 = [19, 26, 55]
var defaultURL = "/";
// d3.json(defaultURL).then(function(data) {
//   var data = [data];
//   var layout = { margin: { t: 30, b: 100 } };
//   Plotly.plot("bar", data, layout);
// });
d3.json(defaultURL).then(function(data){
  console.log(data)
})

var layout = {
    height: 400,
    width: 500
  };

var dropdown = d3.select("select#selDataset");
var options = dropdown.selectAll('option')
  .data(data5)
  .enter()
  .append('option');
options.text(function(d){
  return d;
})
    .attr('value', function(d){
      return d
    });

// console.log(data5)


  // Plotly.newPlot( '.mydiv', data, layout);


  // <!-- <option value="/names">names</option>
  // <option value="/metadata/<sample>">metadata</option>
  // <option value="/samples/<sample>">samples</option> - -->
