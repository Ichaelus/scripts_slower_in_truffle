# The Computer Language Benchmarks Game
# http://benchmarksgame.alioth.debian.org
#
# Contributed by Peter Bjarke Olsen
# Modified by Doug King
# Modified by Joseph LaFata
# Modified by Michael Leimstädtner

CODES =       'wsatugcyrkmbdhvnATUGCYRKMBDHVN'
COMPLEMENTS = 'WSTAACGRYMKVHDBNTAACGRYMKVHDBN'

def revcomp_segment(seq, output_file)
  seq.reverse!.tr!(CODES, COMPLEMENTS)
  stringlen=seq.length-1
  0.step(stringlen,60) {|x|
    output_file.print seq[x,60] , "\n"
  }
end

def revcomp(input_path, output_file)
  seq = ""
  lines = File.readlines(input_path)
  lines.each do |line|
    if line[0] == '>'
      unless seq.empty?
        revcomp_segment(seq, output_file)
        seq=""
      end
      output_file.puts line
    else
      line.chomp!
      seq << line
    end
  end
  revcomp_segment(seq, output_file) unless seq.empty?
end

def run(size)
  input_path = "#{size}_sequence.txt"
  output_path = "#{size}_rev_sequence.txt"
  output_file = File.open(output_path, "w")
  revcomp(input_path, output_file)
  output_file.close
end

run(1000000)
