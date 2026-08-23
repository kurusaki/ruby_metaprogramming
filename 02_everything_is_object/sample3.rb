message = "hello"

puts message.upcase

puts message.send(:upcase)

method_name = :upcase
puts message.send(method_name)

