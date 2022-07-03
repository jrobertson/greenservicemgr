#!/usr/bin/env ruby

# file: greenservicemgr.rb
# description: Intended for running within a Docker container to control daemonised GoGreen services.

require 'onedrb'


class Server

  def initialize(services=[])

    @service_list = services

  end

  def service_list()
    @service_list
  end

  def status_list()

    h = @service_list.map do |x|

      file = x + '_control.rb'
      if File.exists? file
        r = `ruby #{file} status`
        [x.to_sym, r =~ /running \[pid/ ? :running : nil]
      else
        nil
      end

    end.compact.to_h
  end

  def restart(service)
    return service.to_s
    return unless @service_list.include? service.to_s

    filename = service.to_s + '_control.rb'

    if File.exists? filename then
      `ruby #{filename} restart`
      'restarting service ' + service
    else
      'service not found'
    end

  end

  alias restart2 restart

  def run(service)

    return unless @service_list.include? service.to_s
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

    return unless @service_list.include? service.to_s
    filename = service.to_s + '_control.rb'

    puts 'Dir.pwd:  ' + Dir.pwd.inspect

    if File.exists? filename then
      `ruby #{filename} status`
    else
      'service not found'
    end

  end

  def stop(service)

    return unless @service_list.include? service.to_s
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

class GreenClient

  def initialize(host: '127.0.0.1', port: '57900')
    @server = OneDrb::Client.new host: host, port: port
  end

  def restart(service)
    @server.restart2 service
  end

  def service_list
    @server.service_list
  end

  def status_list
    @server.status_list
  end

  def start(service)
    @server.start service
  end

  def stop(service)
    @server.stop service
  end

  def status(service)
    @server.status service
  end

end
