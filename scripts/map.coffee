(() ->
  # TODO: Draw width and height from DOM?
  width  = 800
  height = 600

  # svg element to draw the map and data to.
  svg = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height)

  # Projection for scaling up the map to it's proper magnificence.
  projection = d3.geo.mercator()
    .scale(2000)
    .center([-120, 36])
    .translate([width / 2, height / 2])

  d3.json "ca_counties.json", (error, ca) ->
    if error
      console.error error
    else
      subunits = topojson.feature(ca, ca.objects.subunits);
      path     = d3.geo.path().projection(projection)

      # Draw the map subunits.
      svg.append("path")
        .datum(subunits)
        .attr("d", path)
        .attr("class", "subunit")

      svg.append("path")
        .datum(topojson.mesh(ca, ca.objects.subunits, (a, b) -> a == b))
        .attr("d", path)
        .attr("class", "exterior-boundary")
)()
