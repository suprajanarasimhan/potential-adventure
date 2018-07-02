describe Secret do
  let(:word) {'cucumber'}
  let(:eight_underscores) {'________'}
  let(:eight_underscores_spaced) {'_ _ _ _ _ _ _ _'}
  let(:secret) {Secret.new(word)}

  it 'should store a secret word' do
  	expect(secret.word).to eq(word)	
  end

  it 'should initialize the running guess with the correct number of blanks' do
  	expect(secret.running_guess).to eq(eight_underscores)
  end

  it 'should initialize the printable running guess with the correct number of blanks' do
    expect(secret.printable_guess).to eq(eight_underscores_spaced)
  end

  describe '.get_indices_for_char' do
  	it 'should return the indices of the input character' do
  	  res = secret.get_indices_for_char('c')
  	  expect( res ).to eq([0, 2])
  	end
  end

  describe '.revealed?' do
    context 'when running guess matches secret' do
      it 'should return true' do
        allow(secret).to receive(:running_guess).and_return(secret.word)
        expect(secret.revealed?).to eq(true)
      end
    end

    context 'when running guess does not match secret' do
      it 'should return false' do
        expect(secret.revealed?).to eq(false)
      end
    end

  end
end