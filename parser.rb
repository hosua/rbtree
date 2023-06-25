#!/usr/bin/ruby

require 'optparse'

$options = {}

class Parser

  def self.parse(args)
    $options = {:directory_only => false}
    opt_parser = OptionParser.new do |opts|
      opts.banner = "Thank you for using rbtree!"
      opts.separator "\t\t\t-hosua"

      opts.on('-d', '--directory', 'Only show directories') do
        $options[:directory_only] = true
      end

      opts.on('-h', '--help', 'Prints this help menu') do
        puts "Some helpful text will go here at some point"
        exit 0
      end
    end

    opt_parser.parse!(args)
    return $options
  end

  def get_options
    return $options
  end

  def show_options
    puts "Showing options:"
    $options.each do |k,v|
      puts "\t#{k} = #{v}"
    end
  end
end

begin
  $options = Parser.parse ARGV
rescue Exception => e
  puts "Exception occurred: #{e}"
  exit 1
end

# Print the usage if there are no arguments. 
# (rbtree does not require any arguments, so we will leave this out)
# Good to know how it's done though.
# Parser.parse %w[--help] if ARGV.empty?

# Print the $options
# puts $options
