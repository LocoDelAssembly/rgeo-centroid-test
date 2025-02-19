require 'rgeo'
require 'rgeo/proj4'

factory = RGeo::Geographic.projected_factory(srid: 4326, projection_srid: 4326, projection_proj4: 'EPSG:4326', has_z_coordinate: true)

polygon = factory.polygon(factory.linear_ring([[0,0], [10,0], [10,10], [0,10], [0,0]].map { |p| factory.point(p.first, p.last) }))
expected_centroid = factory.point(5, 5)

puts polygon.inspect
puts "PROJECTED CENTROID: #{polygon.projection.centroid.inspect}"
puts "UNPROJECTED CENTROID: #{factory.unproject(polygon.projection.centroid).inspect}"
puts "EXPECTED CENTROID: #{expected_centroid.inspect}"
puts "ACTUAL CENTROID: #{polygon.centroid.inspect}"
puts "EXPECTED CENTROID PROJECTION: #{expected_centroid.projection.inspect}"
puts "EXPECTED CENTROID PROJECTION UNPROJECTED: #{factory.unproject(expected_centroid.projection).inspect}"

raise "INVALID CENTROID" unless polygon.centroid == expected_centroid
puts "polygon.centroid == expected_centroid TEST PASSED"
