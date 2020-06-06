class Hint
    attr_reader :correct, :incorrect

    def initialize(colors,current)
        
        cor = 0
        incor = 0
        them = colors[0..-1]
        me = current[0..-1]
        arr = []
        for index in 0..3 do
            if me[index] == them[index]
                cor += 1
                arr.push(index)
            end
        end
        0.upto((arr.length) - 1) do |index|
            them[arr[index]] = ""
            me[arr[index]] = ""
        end
        them.delete("")
        me.delete("")
        0.upto((me.length) - 1) do |index|
            if them.include?(me[index])
                incor += 1
            end
        end
        @correct = cor
        @incorrect = incor
    end

    def to_s
        hints = []

        @correct.times do
            hints.push('●'.yellow + ' ')
        end

        @incorrect.times do
            hints.push("●".white + " ")
        end

        hints.join
    end
end