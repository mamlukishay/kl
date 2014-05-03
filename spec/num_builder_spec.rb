require 'num_builder'

describe NumBuilder do
	let(:total_steps) { 2 }
	let(:builder) { NumBuilder.new total_steps }

	describe ".process_line" do
		before(:each) { 
			stub_const("NumBuilder::NumSize", 2) 
			stub_const("NumBuilder::CharsPerLetter", 1) 
			MapsFactory.stub(:get_map) { map }
		}
		let!(:original_step) { builder.current_step }
		let(:line1) { "ac" }
		let(:line2) { "bd" }
		let(:map) { 
			{
				'a' => {'b' => 1},
				'c' => {'d' => 2},
			}
	  }

		subject(:builder_after_processing) { 
			builder.process_line line1 
			builder.process_line line2 
			builder
		}

	  its(:result) { should be_an Array }
		its(:current_step) { should eq original_step + 2 }
		its(:completed?) { should be_true }

	  context "when the given lines correspond to values in the map" do
			let(:line1) { "ac" }
			let(:line2) { "bd" }
			its("result.first") { should eq 1 }
			its("result.last") { should eq 2 }
			its(:is_illegal) { should be_false }
	  end

	  context "when the given lines DONT correspond to values in the map" do
			let(:line1) { "ac" }
			let(:line2) { "bx" }
			its("result.first") { should eq 1 }
			its("result.last") { should eq NumBuilder::IllegalChar }
			its(:is_illegal) { should be_true }
	  end

	  context "when in the middle of processing a number" do
			subject(:builder_after_processing) { 
				builder.process_line line1 
				builder
			}
	  	
			its(:current_step) { should eq original_step + 1 }
			its(:completed?) { should be_false }
	  end	  
	end
end