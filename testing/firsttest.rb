require "java"

java_import "java.util.TreeSet"

puts "Hello from ruby"

class CallJava

  def initialize
    super
    @count = 0
  end

  def say(msg)
    puts "Ruby saying #{msg}"
  end
end
