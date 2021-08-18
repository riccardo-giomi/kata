# rubocop:disable Style/BlockDelimiters
require 'rspec'
require_relative '../lib/library'

RSpec.describe Library do
  before(:example) do
      @publications = Library.import()
  end

  it 'imports data from csv data-files' do
    expect(@publications).not_to be_nil
  end

  it 'contains a list of authors' do
    expect(@publications.authors).not_to be_nil
    expect(@publications.authors).to be_a Hash
  end

  it 'indexes authors by email' do
    element = @publications.authors.first
    email = element.first
    author = element[1]

    expect(email).to eq author[:email]
  end

  it 'contains a list of books and magazines' do
    expect(@publications.all).not_to be_nil
  end

  it 'indexes books and magazines by isbn' do
    expect(@publications.all).not_to be_nil
  end
end
