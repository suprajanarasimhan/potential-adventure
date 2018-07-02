describe Checker do
  describe '::run' do
    let(:word) {'carrot'}
    let(:running_guess) { "_" * (word*size)}
    let(:guess) {'a'}
    let(:guess_included_lowercase) {guess}
    let(:guess_included_uppercase) {guess.upcase}
    let(:guess_missing) {'z'}
    let(:guess_exact) {word}
    let(:guess_exact_mixed_case) {'CaRRoT'}
    let(:guess_substring) {'arr'}
    let(:guess_nonchar) {1}

    it 'should exist' do
      Checker.run(word, guess)
    end

    context 'when guess exactly matches word' do
      context 'and is lowercase' do
        it 'should return Checker::ExactMatch' do
          res = Checker.run(word, guess_exact)
          expect(res).to eq(Checker::ExactMatch)
        end
      end
      context 'and is mixed case' do
        it 'should return Checker::ExactMatch' do
          res = Checker.run(word, guess_exact_mixed_case)
          expect(res).to eq(Checker::ExactMatch)
        end
      end
    end

    context 'when guess is a substring of word' do
      it 'should return Checker::Missing' do
        res = Checker.run(word, guess_substring)
        expect(res).to eq(Checker::Missing)
      end
    end

    context 'when guessed char included in word' do

      context 'and is lowercase' do
        it 'should return Checker::Included' do
          res = Checker.run(word, guess_included_lowercase)
          expect(res).to eq(Checker::Included)
        end
      end

      context 'and is uppercase' do
        it 'should return Checker::Included' do
          res = Checker.run(word, guess_included_uppercase)
          expect(res).to eq(Checker::Included)
        end
      end

    end

    context 'when guess missing from word' do
      it 'should return Checker::Missing' do
        res = Checker.run(word, guess_missing)
        expect(res).to eq(Checker::Missing)
      end
    end

    context 'when guess is not a character' do
      it 'should return false' do
        expect{
          Checker.run(word, guess_nonchar)
        }.to raise_error(ArgumentError)
      end
    end

  end
end
