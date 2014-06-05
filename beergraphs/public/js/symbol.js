var layer_2 = new L.StamenTileLayer("toner-background");

var map_2 = new L.Map('map2', {center: [37.8, -96.9], zoom: 4})
    .addLayer(layer_2);

/* Initialize the SVG layer */
map_2._initPathRoot();

/* We simply pick up the SVG from the map object */
var svg_2 = d3.select("#map2").select("svg"),
g_2 = svg_2.append("g");

var tip_2 = d3.tip()
      .attr('class', 'd3-tip')
      .html(function(d) { return d.Brewery + "</br>" + d.city +", " + d.state + "</br>BAR: " + d.BAR; })
      .direction('n')
      .offset([-10, 0]);

var scale_styleplus = d3.scale.linear()
                    .domain([70, 120])
                    .range([1, 15]);

var scale_bar = d3.scale.linear()
                .domain([-3,9])
                .range([1,15]);

var scale_abv = d3.scale.linear()
                .domain([0,10])
                .range([1,15]);

var current_filter = "BAR";
var current_scale = scale_bar;
var current_size = 1;

/* Add a LatLng object to each item in the dataset */
breweries.breweries.forEach(function(d) {
  d.LatLng = new L.LatLng(d.lat,
              d.long);
});

var feature_2 = g_2.selectAll("circle")
  .data(breweries.breweries)
  .enter().append("circle")
  .style("stroke", "black")
  .style("opacity", 0.7)
  .style("fill", "steelblue")
  .attr("r", 20)
  .call(tip_2);

map_2.on("viewreset", update_2);
update_2();

function update_2() {
  // console.log(current_filter)
  // console.log(window.current_filter)
  feature_2.attr("transform",
  function(d) {
    return "translate("+
      map_2.latLngToLayerPoint(d.LatLng).x +","+
      map_2.latLngToLayerPoint(d.LatLng).y +")";
    }
  )
  .attr("r", function(d){
    return current_scale(d[current_filter])*(Math.sqrt(map_2.getZoom()-3));
    // return current_size;
  })
  .on("mouseover", tip_2.show)
  .on("mouseout", tip_2.hide);
}


$('#styleplus').on('click', function(){
  current_filter = "styleplus";
  current_scale = scale_styleplus;
  current_size = 25;
  g_2.selectAll("circle").transition()
    .attr("r", function(d){
      // console.log(d.BAR +" " + scale_styleplus(d.styleplus));
      // return 25;
      return current_scale(d[current_filter])*(Math.sqrt(map_2.getZoom()-3));
    })
    .ease('linear')
    .delay(100);
    tip_2.html(function(d) { return d.Brewery + "</br>" + d.city +", " + d.state + "</br>Style+: " + d.styleplus; });
});

$('#abv').on('click', function(){
  current_filter = "ABV";
  current_scale = scale_abv;
  g_2.selectAll("circle").transition()
    .attr("r", function(d){
      // console.log(d.BAR +" " + scale_styleplus(d.styleplus));
      // return 50;
      return current_scale(d[current_filter])*(Math.sqrt(map_2.getZoom()-3));
    })
    .ease('linear')
    .delay(100);
  tip_2.html(function(d) { return d.Brewery + "</br>" + d.city +", " + d.state + "</br>ABV: " + d.ABV + "%"; });

});

$('#bar').on('click', function(){
  current_filter = "BAR";
  current_scale = scale_bar;
  g_2.selectAll("circle").transition()
    .attr("r", function(d){
      // console.log(d.BAR +" " + scale_styleplus(d.styleplus));
      // return 100;
      return current_scale(d[current_filter])*(Math.sqrt(map_2.getZoom()-3));
    })
    .ease('linear')
    .delay(100);
    tip_2.html(function(d) { return d.Brewery + "</br>" + d.city +", " + d.state + "</br>BAR: " + d.BAR; });
});