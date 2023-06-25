#!/usr/bin/ruby

require 'colorize'

dir_path = ""

if ARGV.length == 0
  dir_path = "."
else
  dir_path = ARGV[0]
end


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
      prefix = "├──"
      prefix_last = "└──"
      prefix_stem = "│   "
      vis.push(dir)
      padding = ""
      
      pre = prefix
      entries = Dir.glob("*")

      for x in 1..depth-1 do
        padding += prefix_stem
        # padding += "──"
      end

      entries.each_with_index do |e, idx|
        if File.directory? e
          # Only traverse to the directory if it hasn't been visited yet,
          # ignore relative paths as well.
          if !vis.include? e and e != '.' and e != '..'
            # print the directory name
            puts "#{padding}#{pre}" + " #{e}".colorize(:light_magenta)
            # "push" the upper dir to the stack
            chdir(e)
            list_folder(e, depth+1, vis)
            # "pop" the dir from the stack to come back
            chdir('..')
          end
        else
          if idx == entries.length - 1
            pre = prefix_last
          end
          # print the file name
          if File.executable? e
            puts "#{padding}#{pre}" + " #{e}".colorize(:light_green)
          else
            puts "#{padding}#{pre} #{e}"
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

