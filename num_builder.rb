class NumBuilder
	LetterSize = 3
	NumSize = 9
	IllegalChar = '?'

	attr_reader :step
	attr_accessor :result, :illegal

	def initialize
		@step = 0
		@illegal =false
		@result = init_number
	end

	def init_number
		[MapsFactory.get_map] * NumSize
	end

	def make_step_with(line)
		chars = line.each_char
		NumSize.times do |i|
			letter = parse_letter(chars)
			@result[i] = process_letter(@result[i], letter)
		end
	end

	def parse_letter(chars)
		letter = ""
		LetterSize.times do
			letter += chars.next
		end

		letter
	end

	def process_letter(original, addition)
		if original.is_a?(Hash) 
			original[addition] || IllegalChar
		else 
			IllegalChar
		end
	end
end



