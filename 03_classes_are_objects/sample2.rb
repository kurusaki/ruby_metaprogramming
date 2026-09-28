Greeter = Class.new do
  def hello
    "こんにちは！"
  end
end

greeter = Greeter.new

puts "Greeter.class: #{Greeter.class}"
puts "Greeter.superclass: #{Greeter.superclass}"
puts "greeter.class: #{greeter.class}"
puts greeter.hello
