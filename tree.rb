#!/usr/bin/ruby

require 'colorize'
require 'optparse'

# ternary operator in ruby
ARGV.length == 0 ? (dir_path = ".") : (dir_path = ARGV[0])

class TreeNav
  def initializer
    @cwd = "#{Dir.pwd}"
  end

  def chdir(dir)
    @cwd = dir
    Dir.chdir(@cwd)
  end

  def show(dir)
    chdir(dir)
    def list_folder(dir, depth=1, vis=[])
      PREFIX = "├── "
      PREFIX_LAST = "└── "
      PREFIX_STEM = "│   "
      
      # pre will either be set to PREFIX or PREFIX_LAST depending
      # on if it's the last element in its directory.
      pre = PREFIX 
      vis.push(dir)
      padding = ""
      entries = Dir.glob("*")

      for x in 1..depth-1 do
        padding += PREFIX_STEM
      end

      entries.each_with_index do |e, idx|
        if File.directory? e
          # Only traverse to the directory if it hasn't been visited yet,
          # ignore relative paths as well.
          if !vis.include? e and e != '.' and e != '..'
            # print the directory name
            puts "#{padding}#{pre}" + "#{e}".colorize(:light_magenta)
            # "push" the upper dir to the stack
            chdir(e)
            list_folder(e, depth+1, vis)
            # "pop" the dir from the stack to come back
            chdir('..')
          end
        else
          # print the L-angle connector piece since we are at the bottom of the "branch"
          if idx == entries.length - 1
            pre = PREFIX_LAST
          end
          # print the file name
          if File.executable? e
            # color the executable files green
            puts "#{padding}#{pre}" + "#{e}".colorize(:light_green)
          else
            # leave the other files white
            puts "#{padding}#{pre}#{e}"
          end
        end
      end
    end

    puts "#{dir}".colorize(:light_magenta)
    list_folder(dir)
  end

  attr_accessor :cwd
end




t = TreeNav.new.show(dir_path)

