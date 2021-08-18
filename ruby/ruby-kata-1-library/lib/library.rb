# rubocop:disable Style/BlockDelimiters, Metrics/MethodLength
require 'csv'

class Library
  attr_reader :authors, :publications

  @@options = {data_dir: 'data/', csv: {encoding: 'UTF-8', col_sep: ';'}}
  def self.import
    arguments = {}
    %w[authors books magazines].each do |filename|
      arguments[filename.to_sym] = self.read_csv("#{filename}.csv")
    end

    return self.new(**arguments)
  end

  def initialize(books:, magazines:, authors:)
    @authors = authors.reduce({}) do |result, author|
      result[author[:email]] = author
      result
    end

    @publications = {}
    magazines.each do |magazine|
      emails = magazine[:authors].split(',')
      magazine[:authors] = @authors.values_at(*emails)
      @publications[magazine[:isbn]] = Magazine.new(**magazine)
    end
    books.each do |book|
      emails = book[:authors].split(',')
      book[:authors] = @authors.values_at(*emails)
      @publications[book[:isbn]] = Book.new(**book)
    end
  end

  def all
    @publications.values
  end

  def find(isbn)
    @publications[isbn]
  end

  def magazines
    all.filter { |p| p.is_a? Magazine }
  end

  def books
    all.filter { |p| p.is_a? Book }
  end

  private

  def self.read_csv(filename)
    results = []

    data_dir = __dir__ + "/../#{@@options[:data_dir]}/"
    filepath = data_dir + filename
    csv = CSV.foreach(filepath, headers: true, header_converters: [:symbol, :underscore], **@@options[:csv]) do |row|
      results << row.to_h
    end

    results
  end
end

class Publication
  attr_accessor :isbn, :title, :authors

  def initialize(isbn: '', title: '', authors: [], **rest)
    @isbn = isbn
    @title = @title
    @authors = authors
  end
end

class Magazine < Publication
  attr_accessor :publishedat

  def initialize(isbn: '', title: '', authors: [], publishedat: nil)
    super
    @publishedat = publishedat
  end
end

class Book < Publication
  attr_accessor :description

  def initialize(isbn: '', title: '', authors: [], description: '')
    super
    @description = description
  end
end
