describe Guess do
  let(:guess_nil) { Guess.new(nil) }
  let(:guess_empty_str) { Guess.new('') }
  let(:guess_fixnum) { Guess.new(4) }
  let(:guess_letter_upcased) { Guess.new('G') }
  let(:guess_letter_downcased) { Guess.new('g') }
  let(:guess_multi_letter) {Guess.new('ga')}
  let(:guess_multi_w_non_letters) {Guess.new('g5')}

  describe '.valid?' do
    context 'when nil' do
      it { expect(guess_nil.valid?).to eq(false) }
    end

    context 'when empty' do
      it { expect(guess_empty_str.valid?).to eq(false) }
    end

    context 'when non-character (e.g. Fixnum)' do
      it { expect(guess_fixnum.valid?).to eq(false) }
    end

    context 'when upper case letter' do
      it { expect(guess_letter_upcased.valid?).to eq(true) }
    end

    context 'when lower case letter' do
      it { expect(guess_letter_downcased.valid?).to eq(true) }
    end

    context 'when multi-letter' do
      it { expect(guess_multi_letter.valid?).to eq(true) }
    end

    context 'when word containing non-letter chars' do
      it { expect(guess_multi_w_non_letters.valid?).to eq(false) }
    end
  end

  describe '.repeated?' do
    let(:running_guess) { "_a_a_a" } # banana
    let(:misses) { ['c'] }

    def run_repeated?(guessed_char)
      Guess.repeated?(
        guessed_char, running_guess, misses)
    end

    context 'when letter is neither in misses nor in running guess' do
      let(:guess_in_neither) { 'b' }
      it 'should return false' do
        expect( 
            run_repeated?(guess_in_neither)
          ).to eq(false)
      end
    end

    context 'when letter in misses' do
      let(:guess_lowercase_in_misses) { 'c' }
      let(:guess_uppercase_in_misses) { 'C' }

      context 'and lowercase' do
        it 'should return true' do
          expect( 
              run_repeated?(guess_lowercase_in_misses)
            ).to eq(true)
        end
      end

      context 'and uppercase' do
        it 'should return true' do
          expect( 
              run_repeated?(guess_uppercase_in_misses)
            ).to eq(true)
        end
      end
    end

    context 'when letter in running guesses' do
      let(:guess_lowercase_in_running) { 'a' }
      let(:guess_uppercase_in_running) { 'A' }

      context 'and lowercase' do
        it 'should return true' do
          expect( 
              run_repeated?(guess_lowercase_in_running)
            ).to eq(true)
        end
      end

      context 'and uppercase' do
        it 'should return true' do
          expect( 
              run_repeated?(guess_uppercase_in_running)
            ).to eq(true)
        end
      end
    end

  end
end
