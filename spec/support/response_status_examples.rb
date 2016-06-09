shared_examples 'http code' do |code|
  it "returns http #{code}" do
    expect(response.response_code).to eq(code)
  end
end
