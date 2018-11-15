
var defaultURL = '/names/940'
d3.json(defaultURL).then(function(data) {
  var data = [data];
  var layout = { margin: { t: 30, b: 100 } };
  Plotly.plot("#pie", data, layout);
  Plotly.plot("#bubble,data,layout")
});

// Update the plot with new data
function updatePlotly(newdata) {
  Plotly.restyle("#pie", "values", [newdata.pie.values]);
  Plotly.restyle("#pie", "labels", [newdata.pie.labels]);
  Plotly.restyle("#bubble", "x", [newdata.bubble.x]);
  Plotly.restyle("#bubble", "y", [newdata.bubble.y]);
  Plotly.restyle("#bubble", "marker", [newdata.bubble.marker.size]);

}

// Get new data whenever the dropdown selection changes
function getData(route) {
  console.log(route);
  d3.json(`/names/${route}`).then(function(data) {
    console.log("newdata", data);
    updatePlotly(data);
  });
}


// charts desired =  bubble, pie,



// function buildMetadata(sample) {

//   // @TODO: Complete the following function that builds the metadata panel

//   // Use `d3.json` to fetch the metadata for a sample
//     // Use d3 to select the panel with id of `#sample-metadata`

//     // Use `.html("") to clear any existing metadata

//     // Use `Object.entries` to add each key and value pair to the panel
//     // Hint: Inside the loop, you will need to use d3 to append new
//     // tags for each key-value in the metadata.

//     // BONUS: Build the Gauge Chart
//     // buildGauge(data.WFREQ);
// }

// function buildCharts(sample) {

//   // @TODO: Use `d3.json` to fetch the sample data for the plots

//     // @TODO: Build a Bubble Chart using the sample data

//     // @TODO: Build a Pie Chart
//     // HINT: You will need to use slice() to grab the top 10 sample_values,
//     // otu_ids, and labels (10 each).
// }

// function init() {
//   // Grab a reference to the dropdown select element
//   var selector = d3.select("#selDataset");
//
//   // Use the list of sample names to populate the select options
//   d3.json("/names").then((sampleNames) => {
//     sampleNames.forEach((sample) => {
//       selector
//         .append("option")
//         .text(sample)
//         .property("value", sample);
//     });

//     // Use the first sample from the list to build the initial plots
//     const firstSample = sampleNames[0];
//     buildCharts(firstSample);
//     buildMetadata(firstSample);
//   });
// }

// function optionChanged(newSample) {
//   // Fetch new data each time a new sample is selected
//   buildCharts(newSample);
//   buildMetadata(newSample);
// }

// Initialize the dashboard
// init();


// var data = [{
//   values: [19, 26, 55],
//   labels: ['Residential', 'Non-Residential', 'Utility'],
//   type: 'pie'
// }];

// var layout = {
//   height: 400,
//   width: 500
// };

// Plotly.newPlot('pie', data, layout);
