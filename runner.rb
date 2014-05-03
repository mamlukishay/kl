load 'lib/parser.rb'
load 'lib/num_builder.rb'

source_path = ARGV[0] || raise("Missing source file")
target_path = ARGV[1] || raise("Missing target file")

parser = Parser.new source_path
parser.parse
parser.result_to_file target_path