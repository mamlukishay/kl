require 'num_builder'
	
class Parser
	LinesPerNumber = 4

	def initialize(filename)
		@steps_per_number = LinesPerNumber - 1
		@lines = File.open(filename).read.each_line
		@result = []
	end

	def parse
		@steps = (1..LinesPerNumber).cycle

		loop do
			step = @steps.next
			line = @lines.next
			break if line.nil?

			@num_builder = NumBuilder.new(@steps_per_number) if step == 1

		  if step > @steps_per_number
		  	@result << @num_builder
		  else
				@num_builder.process_line line
			end
		end
	end

	def result_to_file target_path
		@target_file = File.open target_path, "w"
		@result.each do |num_builder|
			@target_file.puts num_builder.to_s
		end
	end
end