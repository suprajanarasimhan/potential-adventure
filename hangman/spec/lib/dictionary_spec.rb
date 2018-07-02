describe Dictionary do
  describe '::get_random_word' do
    it 'should retun a word' do
      expect(Dictionary.get_word).to be_an_instance_of String
    end
  end
end
