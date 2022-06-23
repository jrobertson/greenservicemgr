#!/usr/bin/env ruby

# file: greenservicemgr.rb
# description: Intended for running within a Docker container to control daemonised GoGreen services.

require 'onedrb'


class Server

  def initialize(services=[])

    @services = services

  end

  def services()
    @services 
  end

  def status_list()

    h = @services.map do |x|

      file = x + '_control.rb'
      if File.exists? file
        r = `ruby #{file} status`
        [x.to_sym, r =~ /running \[pid/ ? :running : nil]
      else
        nil
      end

    end.compact.to_h
  end

  def run(service)

    return unless @services.include? service.to_s
    filename = service.to_s + '_control.rb'
    if File.exists? filename then
      `ruby #{filename} start`
      'running service ' + service
    else
      'service not found'
    end

  end

  alias start run

  def status(service)

    return unless @services.include? service.to_s
    filename = service.to_s + '_control.rb'

    if File.exists? filename then
      `ruby #{filename} status`
    else
      'service not found'
    end

  end

  def stop(service)

    return unless @services.include? service.to_s
    filename = service.to_s + '_control.rb'

    if File.exists? filename then
      `ruby #{filename} stop`
      'stopping service ' + service
    else
      'service not found'
    end

  end

end

class GreenServerMgr

  def initialize(host: '127.0.0.1', port: '57900', services: [])
    @server = OneDrb::Server.new host: host, port: port, obj: Server.new(services)
  end

  def start()
    @server.start
  end
end

