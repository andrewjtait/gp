# frozen_string_literal: true

require 'socket'

PORT = 8000

server = TCPServer.new(PORT)

puts "Listening on port #{PORT}..."

while (session = server.accept)
  search = false
  request = session.gets
  puts request

  if request.start_with?('POST / ')
    session.print "HTTP/1.1 200\r\n"
    session.print "Content-Type: application/json\r\n"
    session.print "\r\n"
    session.print '{"status":"ok"}'
    search = true
  else
    session.print "HTTP/1.1 403\r\n"
    session.print "Content-Type: text/html\r\n"
    session.print "\r\n"
    session.print 'Forbidden'
  end

  session.close

  system 'ruby search.rb' if search
end
