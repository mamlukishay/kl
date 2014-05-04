require 'parser'
require 'stringio'

describe Parser do
	before(:each) { 
		File.stub(:open) { StringIO.new(test_input) } 
	}
	let(:parser) { Parser.new "source_path" }
	let(:test_input) {
		"1
		2
		3
		4
		5
		6
		7
		8"
	}

	describe ".parse" do
		it "should process all input lines besides separator lines" do
			parser.stub(:process_line) { true }
			parser.parse
			parser.should have_received(:process_line).with("1").once
			parser.should have_received(:process_line).with("2").once
			parser.should have_received(:process_line).with("3").once
			parser.should have_received(:process_line).with("5").once
			parser.should have_received(:process_line).with("6").once
			parser.should have_received(:process_line).with("7").once

			parser.should_not have_received(:process_line).with("4")
			parser.should_not have_received(:process_line).with("8")
		end
	end
end