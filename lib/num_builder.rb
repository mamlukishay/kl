require 'maps_factory'
class NumBuilder
	CharsPerLetter = 3
	NumSize = 9
	IllegalChar = '?'
	StrIllegalNumber = "ILLEGAL"

	attr_reader :total_steps, :current_step, :is_illegal, :result

	def initialize(total_steps)
		@total_steps = total_steps
		@current_step = 0
		@illegal = false
		@result = init_number
	end

	def completed?
		@current_step == @total_steps
	end

	def process_line(line)
		chars = line.each_char
		NumSize.times do |i|
			letter = parse_letter(chars)
			process_letter letter, i
		end

		@current_step += 1
	end

	def to_s
		if completed?
			retval = @result.join
			retval += " #{StrIllegalNumber}" if is_illegal
		else
			retval ="Incomplete number"
		end

		retval
	end

	protected
		def init_number
			[MapsFactory.get_map] * NumSize
		end

		def parse_letter(chars)
			letter = ""
			CharsPerLetter.times do
				letter += chars.next
			end

			letter
		end

		def process_letter(letter, index)
			if not completed? 
				@result[index] = @result[index][letter] || IllegalChar
			else 
				@result[index] = IllegalChar
			end

			@is_illegal = true if @result[index] == IllegalChar
		end
end



