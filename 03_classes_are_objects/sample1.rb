class User
end

user1 = User.new
user2 = User.new

puts "user1.class: #{user1.class}"
puts "user2.class: #{user2.class}"
puts "同じオブジェクト？: #{user1.equal?(user2)}"
puts "User.class: #{User.class}"
puts "User.superclass: #{User.superclass}"
