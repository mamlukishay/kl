require 'num_builder'

describe NumBuilder do
	let(:total_steps) { 3 }
	let(:builder) { NumBuilder.new total_steps }

	describe ".process_line" do
		before(:each) { 
			stub_const("NumBuilder::NumSize", 2) 
			MapsFactory.stub(:get_map) { map }
		}
		let!(:original_step) { builder.current_step }
		let(:map) { 
			{
				'|_|' => {'  |' => 4},
				' _|' => {' _|' => 3},
			}
	  }
		let(:line) { "|_| _|" }
		
		subject { 
			builder.process_line line 
			builder
		}

		its(:current_step) { should eq original_step + 1 }

		it "should process all letters of the line with their correct index" do
			builder.stub(:process_letter) { true }
			builder.process_line line
			builder.should have_received(:process_letter).with("|_|", 0)
			builder.should have_received(:process_letter).with(" _|", 1)
		end

		context "when a letter is not on the map" do
			let(:line) { "| | _|" }
			its("result.first") { should eq NumBuilder::IllegalChar }
			its("result.last") { should eq ' _|' => 3 }
		end
	end
end