# Get lat and long coordinates for the beer dataset we're working with
require 'geocoder'
require 'pry'

Geocoder.configure(lookup: :google)
# Geocoder.configure(lookup: :dstk)

file = File.new("beertable.txt", "r")
locations = {}

while (line = file.gets)
  line_array = line.split(';')
  locations[line_array[4]] = []
end

file.close

locations.each do |k,v|
  begin
    result = Geocoder.search(k)
    v << result[0].data["geometry"]["location"]["lat"]
    v << result[0].data["geometry"]["location"]["lng"]
  rescue
    v << nil
    v << nil
  end
  sleep 1
end

second_read = File.new("beertable.txt", "r")
write_file = File.new("beer_with_coordinates_take_two.txt", "w")

counter = 1
while counter < 25394
  line = second_read.gets
  line_array = line.split(';')
  write_file.write(line.chomp + locations[line_array[4]][0].to_s + ";" + locations[line_array[4]][1].to_s + "\n")
  counter += 1
end

second_read.close
write_file.close

binding.pry