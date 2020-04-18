# encoding: utf-8
# frozen_string_literal: true
root = "#{Dir.getwd}"
activate_control_app "tcp://127.0.0.1:9292"
bind "unix://#{root}/tmp/puma.sock"
pidfile "#{root}/tmp/pids/puma.pid"
rackup "#{root}/config.ru"
state_path "#{root}/tmp/pids/puma.state"
daemonize true
