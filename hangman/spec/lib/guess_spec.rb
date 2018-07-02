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

    context 'when letter is neither in misses nor in running guess' do
      it 'should return false' do
        res = guess_in_neither.(running_guess, misses)
        expect(res).to eq(false)
      end
    end

    context 'when letter in misses' do
      context 'and lowercase' do
        it 'should return true' do
          res = guess_lowercase_in_misses.(running_guess, misses)
          expect(res).to eq(true)
        end
      end

      context 'and uppercase' do
        it 'should return true' do
          res = guess_uppercase_in_misses.(running_guess, misses)
          expect(res).to eq(true)
        end
      end
    end

    context 'when letter in running guesses' do
      context 'and lowercase' do
        it 'should return true' do
          res = guess_lowercase_in_running.(running_guess, misses)
          expect(res).to eq(true)
        end
      end

      context 'and uppercase' do
        it 'should return true' do
          res = guess_uppercase_in_running.(running_guess, misses)
          expect(res).to eq(true)
        end
      end
    end

  end
end