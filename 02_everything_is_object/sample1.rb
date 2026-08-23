values = [
  1,
  3.14,
  "Hello",
  true,
  nil
]

values.each do |value|
  puts "value: #{value.inspect}"
  puts "class: #{value.class}"
  puts "object_id: #{value.object_id}"
  puts
end

