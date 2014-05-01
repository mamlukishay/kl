class Parser
	LinesPerNumber = 4

	def initialize(filename)
		@lines = File.open(filename).read.each_line
	end

	def go
		@steps = (1..LinesPerNumber).cycle

		loop do
			step = @steps.next
			line = @lines.next
			break if line.nil?
			@numbuilder = NumBuilder.new if step == 1

		  if step == LinesPerNumber
		  	print_result
		  else
				@numbuilder.make_step_with line
			end
		end
	end

	def print_result
		str_res = @numbuilder.result.join
		str_res += " ILLEGAL" if str_res.include?("?")
		p str_res
	end
end