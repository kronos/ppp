#!/usr/bin/env ruby
$LOAD_PATH << './lib'

require 'ppp'
require 'json'

USAGE = 'Usage: ./script.rb file_name.pdf'.freeze

if ARGV.empty?
  puts USAGE
  exit(0)
end

unless File.exist?(ARGV[0])
  puts "Error: file #{ARGV[0]} not found"
  exit(1)
end

begin
  text  = PPP::PDFDataProvider.new(ARGV[0]).text
  order = PPP::OrderConfirmationParser.new(text).parsed_order
  puts PPP::GabiFormatter.new(order).formatted_text.to_json
rescue PPP::OrderConfirmationParser::UnknownReceiptFormat
  puts 'Error: invalid receipt format'
  exit(1)
end
