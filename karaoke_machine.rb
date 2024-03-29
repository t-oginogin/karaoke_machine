# coding: utf-8

class KaraokeMachine
  attr_accessor :melody

  def initialize(melody)
    @melody = melody
  end

  def transpose(amount)
    return melody if melody.empty?

    # codeに分解（ただし'#'があれば一つ前のcodeにくっつける）
    separated_codes = melody.each_char.each_with_object([]) do |code, codes|
      code == '#' ? codes[-1] += code : codes << code
    end

    # キー変換
    separated_codes.each.map do |code|
      KeyChanger.transpose(code, amount)
    end.join
  end

  class KeyChanger
    KEY_PATTERN = %w[C C# D D# E F F# G G# A A# B].freeze

    class << self
      def transpose(code, amount)
        return code unless KEY_PATTERN.include?(code)

        index = KEY_PATTERN.find_index(code)
        new_index = (index + amount) % KEY_PATTERN.size
        KEY_PATTERN[new_index]
      end
    end
  end
end

describe KaraokeMachine do
  it "メロディ無し" do
    melody = ""
    answer = melody
    expect(KaraokeMachine.new(melody).transpose(0)).to eq answer
  end

   it "変更無し" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = melody
     expect(KaraokeMachine.new(melody).transpose(0)).to eq answer
   end
  
   it "2上げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = "D E F# G |F# E D   |F# G A B |A G F#   |D   D   |D   D   |DDEEF#F#GG|F# E D   "
     expect(KaraokeMachine.new(melody).transpose(2)).to eq answer
   end
  
   it "7上げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = "G A B C |B A G   |B C D E |D C B   |G   G   |G   G   |GGAABBCC|B A G   "
     expect(KaraokeMachine.new(melody).transpose(7)).to eq answer
   end
  
   it "1下げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = "B C# D# E |D# C# B   |D# E F# G# |F# E D#   |B   B   |B   B   |BBC#C#D#D#EE|D# C# B   "
     expect(KaraokeMachine.new(melody).transpose(-1)).to eq answer
   end
  
   it "7下げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = "F G A A# |A G F   |A A# C D |C A# A   |F   F   |F   F   |FFGGAAA#A#|A G F   "
     expect(KaraokeMachine.new(melody).transpose(-7)).to eq answer
   end
  
   it "1オクターブ上げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = melody
     expect(KaraokeMachine.new(melody).transpose(12)).to eq answer
   end
  
   it "1オクターブ下げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = melody
     expect(KaraokeMachine.new(melody).transpose(-12)).to eq answer
   end
  
   it "14上げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = "D E F# G |F# E D   |F# G A B |A G F#   |D   D   |D   D   |DDEEF#F#GG|F# E D   "
     expect(KaraokeMachine.new(melody).transpose(14)).to eq answer
   end
  
   it "13下げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = "B C# D# E |D# C# B   |D# E F# G# |F# E D#   |B   B   |B   B   |BBC#C#D#D#EE|D# C# B   "
     expect(KaraokeMachine.new(melody).transpose(-13)).to eq answer
   end
  
   it "2オクターブ上げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = melody
     expect(KaraokeMachine.new(melody).transpose(24)).to eq answer
   end
  
   it "2オクターブ下げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = melody
     expect(KaraokeMachine.new(melody).transpose(-24)).to eq answer
   end
  
   it "26上げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = "D E F# G |F# E D   |F# G A B |A G F#   |D   D   |D   D   |DDEEF#F#GG|F# E D   "
     expect(KaraokeMachine.new(melody).transpose(26)).to eq answer
   end
  
   it "25上げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = "B C# D# E |D# C# B   |D# E F# G# |F# E D#   |B   B   |B   B   |BBC#C#D#D#EE|D# C# B   "
     expect(KaraokeMachine.new(melody).transpose(-25)).to eq answer
   end
  
   it "6上げる(メロディはF#から開始)" do
     melody = "F# G# A# B |A# G# F#   |A# B C# D# |C# B A#   |F#   F#   |F#   F#   |F#F#G#G#A#A#BB|A# G# F#   "
     answer = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     expect(KaraokeMachine.new(melody).transpose(6)).to eq answer
   end
  
   it "6下げる(メロディはF#から開始)" do
     melody = "F# G# A# B |A# G# F#   |A# B C# D# |C# B A#   |F#   F#   |F#   F#   |F#F#G#G#A#A#BB|A# G# F#   "
     answer = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     expect(KaraokeMachine.new(melody).transpose(-6)).to eq answer
   end
  
   it "連続してtransposeを呼び出す" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     karaoke = KaraokeMachine.new(melody)
  
     answer = melody
     expect(karaoke.transpose(0)).to eq answer
  
     answer = "D E F# G |F# E D   |F# G A B |A G F#   |D   D   |D   D   |DDEEF#F#GG|F# E D   "
     expect(karaoke.transpose(2)).to eq answer
  
     answer = "B C# D# E |D# C# B   |D# E F# G# |F# E D#   |B   B   |B   B   |BBC#C#D#D#EE|D# C# B   "
     expect(karaoke.transpose(-1)).to eq answer
   end
end
