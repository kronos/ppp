require 'pdf-reader'

module PPP
  class PDFDataProvider
    def initialize(pdf_file_name)
      @pdf_file = PDF::Reader.new(pdf_file_name)
    end

    def text
      @pdf_file.pages.map(&:text).join("\n\n")
    end
  end
end
