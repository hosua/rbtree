#!/usr/bin/ruby

require 'colorize'
require 'optparse'

<<<<<<< HEAD
# ternary operator in ruby
ARGV.length == 0 ? (dir_path = ".") : (dir_path = ARGV[0])
=======
# Used for making the output pretty
PREFIX = "├── "
PREFIX_LAST = "└── "
PREFIX_STEM = "│   "

# ternary operator in ruby, sets DIR_PATH
ARGV.length == 0 ? (DIR_PATH = ".") : (DIR_PATH = ARGV[0])
>>>>>>> 8fd6757 (tree.rb: Some cleaning up)

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
<<<<<<< HEAD
      PREFIX = "├── "
      PREFIX_LAST = "└── "
      PREFIX_STEM = "│   "
=======
>>>>>>> 8fd6757 (tree.rb: Some cleaning up)
      
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
        # is a directory
        if File.directory? e
          # Only traverse to the directory if it hasn't been visited yet,
          # ignore relative paths as well.
          if !vis.include? e and e != '.' and e != '..'
            # print the directory name
            puts "#{padding}#{pre}" + "#{e}".colorize(:light_magenta)
<<<<<<< HEAD
            # "push" the upper dir to the stack
=======
            # "push" the parent dir to the stack
>>>>>>> 8fd6757 (tree.rb: Some cleaning up)
            chdir(e)
            # recursively list the parent
            list_folder(e, depth+1, vis)
            # "pop" the dir from the stack to come back to the current dir
            chdir('..')
          end
<<<<<<< HEAD
        else
          # print the L-angle connector piece since we are at the bottom of the "branch"
=======

        # is a file
        else 
          # print the bottom L-angle connector piece since we are at the bottom of the "branch"
>>>>>>> 8fd6757 (tree.rb: Some cleaning up)
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

<<<<<<< HEAD



t = TreeNav.new.show(dir_path)
=======
t = TreeNav.new.show(DIR_PATH)
>>>>>>> 8fd6757 (tree.rb: Some cleaning up)

