var layer = new L.StamenTileLayer("toner-background");

var map = new L.Map("map", {center: [37.8, -96.9], zoom: 4})
    .addLayer(layer);

var svg = d3.select(map.getPanes().overlayPane).append("svg");

var g = svg.append("g").attr("class", "leaflet-zoom-hide");

var browns = colorbrewer.YlOrBr[5];

var color = d3.scale.linear()
    .domain([-0.1, 1.9])
    .range(["#ffffd4", "#8c2d04"]);

var style_color = d3.scale.linear()
    .domain([95, 103])
    .range(["#ffffd4", "#8c2d04"]);

var abv_color = d3.scale.linear()
    .domain([3.2, 8.1])
    .range(["#ffffd4", "#8c2d04"]);

var tip = d3.tip()
      .attr('class', 'd3-tip')
      .html(function(d) { return d.properties.name + "</br><p>BAR: " + d.properties.BAR + "</p>"; })
      .direction('n')
      .offset([-10, 0]);

var transform = d3.geo.transform({point: projectPoint});
var path = d3.geo.path().projection(transform);

var feature = g.selectAll("path")
  .data(states.features)
  .enter().append("path").call(tip);

g.selectAll("path")
          .style("fill", function(d, i) {
              // console.log(d.properties.size)
              return color(d.properties.BAR);
          })
          .on("mouseover", tip.show)
          .on("mouseout", tip.hide);

map.on("viewreset", reset);

reset();

function projectPoint(x, y) {
  var point = map.latLngToLayerPoint(new L.LatLng(y, x));
  this.stream.point(point.x, point.y);
}

function reset() {
  feature.attr("d", path);
  var bounds = path.bounds(states);
  var topLeft = bounds[0];
  var bottomRight = bounds[1];

  svg.attr("width", bottomRight[0] - topLeft[0])
    .attr("height", bottomRight[1] - topLeft[1])
    .style("left", topLeft[0] + "px")
    .style("top", topLeft[1] + "px");

  g.attr("transform", "translate(" + -topLeft[0] + "," + -topLeft[1] + ")");

}

$('#bar-state').on('click', function(){
  g.selectAll("path").transition()
    .style("fill", function(d) {
        return color(d.properties.BAR);
    })
    .ease('linear')
    .delay(100);
    tip.html(function(d) { return d.properties.name + "</br><p>BAR: " + d.properties.BAR + "</p>"; });
});

$('#styleplus-state').on('click', function(){
  g.selectAll("path").transition()
    .style("fill", function(d) {
        return style_color(d.properties.styleplus);
    })
    .ease('linear')
    .delay(100);
    tip.html(function(d) { return d.properties.name + "</br><p>Style+: " + d.properties.styleplus + "</p>"; });
});

$('#abv-state').on('click', function(){
  g.selectAll("path").transition()
    .style("fill", function(d) {
        return abv_color(d.properties.ABV);
    })
    .ease('linear')
    .delay(100);
    tip.html(function(d) { return d.properties.name + "</br><p>ABV: " + d.properties.ABV + "%</p>"; });
});