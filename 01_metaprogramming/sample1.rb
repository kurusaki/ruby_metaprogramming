class User
  define_method(:hello) do
    puts "Hello"
  end
end

user = User.new

user.hello
