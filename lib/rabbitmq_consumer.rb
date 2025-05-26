require "bunny"
require "json"

# Establish connection with RabbitMQ server.
connection = Bunny.new(hostname: "localhost", username: "guest", password: "guest")
connection.start

channel = connection.create_channel
queue = channel.queue("applications_created", durable: true)

puts " [*] Waiting for messages in 'applications_created'. To exit press CTRL+C"

queue.subscribe(block: true) do |_delivery_info, _properties, payload|
  application = JSON.parse(payload)
  puts " [x] Received application data:"
  puts application.inspect

  # Process the application data, for example:
  # AgentApplicationProcessor.process(application)
end

# When you are done, close connection:
connection.close
