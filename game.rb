require 'colorize'
require_relative 'hint'
class Game
    attr_accessor :colors
    
    @@possible = ['r','b','g','y','w','m']
    def initialize() 
        @colors = []   
        @solved = false
        @guesses = 0
        @current = []
    end

    def init(answer)
        if answer == 1
            0.upto(3) do |index|
                @colors[index] = @@possible[rand(6)]
            end
            @role = 'breaker'
        elsif answer == 2
            0.upto(3) do |index|
                @colors[index] = gets.chomp
            end
            @role = 'master'
        end
    end
    def get_input
        array = []
        print "Guess #{@guesses}: "
        input = gets.chomp
        0.upto(3) do |index|
            array[index] = input[index]
        end
        @guesses += 1
        @current = array
    end

        
    def print_current(arr)
        print "Your guess is: "
        arr.each do |item|
            print_color(item)
        end
        print "  "
    end

    def print_comp(arr)
        print "Computer's guess is: "
        arr.each do |item|
            print_color(item)
        end
        print "  "
    end

    def print_color(c)
        case c
        when 'r'
            print "■".red
        when 'b'
            print "■".blue
        when 'g'
            print "■".green
        when 'y'
            print "■".yellow
        when 'w'
            print "■".white
        when 'm'
            print "■".magenta
        end
    end

    def check
        if @current == @colors
            @solved = true
        end
    end

    def play_breaker
        while @solved == false
            get_input
            print_current(@current)
            hint = Hint.new(@colors,@current)
            print hint.to_s
            print "\n"
            check
        end
        print 'Congrats! You won, the correct order was '
        @colors.each do |item|
            print_color item
        end
        puts
    end

    def play_master
        while @solved == false
            (@guesses == 0) ? guess_first : guess
            @guesses += 1
            print_comp(@current)
            i = gets
            hint = Hint.new(@colors,@current)
            print hint.to_s
            print "\n"
            check
        end
        print 'Congrats! Computer won, the correct order was '
        @colors.each do |item|
            print_color item
        end
        puts
    end

    def guess_first
        print 'first'
        0.upto(3) do |index|
            @current[index] = @@possible[rand(6)]
        end
    end

    def guess
        0.upto(3) do |index|
            if @current[index] != @colors[index]
                @current[index] = @@possible[rand(6)]
            end
        end
    end

    def play
        puts "Hello, welcome to mastermind, would you like to play as the code breaker or the code master?"
        puts "Input 1 for code breaker"
        puts "Input 2 for code master"
        answer = gets.chomp.to_i
        init(answer)
        @role == 'breaker' ? play_breaker : play_master
    end
end

ar = Game.new()
ar.play