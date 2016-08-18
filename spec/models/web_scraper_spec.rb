require 'rails_helper'

RSpec.describe WebScraper do

  let(:scraper) { WebScraper.new(html_page) }

  describe '#page_info' do

    describe 'parsing title' do

      context 'when page has no title' do
        let(:html_page) { '<html><head></head></html>' }
        it { expect(scraper.page_info.title).to be_empty }
      end

      context 'when page has <title> tag' do
        let(:html_page) do
          %{
            <html>
              <head>
                <title>The Twelve-Factor App</title>
              </head>
            </html>
          }
        end

        it { expect(scraper.page_info.title).to eq('The Twelve-Factor App') }
      end

      context 'when page has <meta name="title"> tag' do
        let(:html_page) do
          %{
            <html>
              <head>
                <meta name="title" content="Ruby">
              </head>
            </html>
          }
        end

        it { expect(scraper.page_info.title).to eq('Ruby') }
      end

      context 'when page has <meta property="og:title"> tag' do
        let(:html_page) do
          %{
            <html>
              <head>
                <meta property="og:title" content="Skore" />
              </head>
            </html>
          }
        end

        it { expect(scraper.page_info.title).to eq('Skore') }
      end

    end


    describe 'parsing description' do

      context 'when page has no description' do
        let(:html_page) { '<html><head></head></html>' }
        it { expect(scraper.page_info.description).to be_empty }
      end

      context 'when page has <meta name="description"> tag' do
        let(:html_page) do
          %{
            <html>
              <head>
                <meta name="description" content="A methodology for building modern, scalable, maintainable software-as-a-service apps.">
              </head>
            </html>
          }
        end

        it { expect(scraper.page_info.description).to eq('A methodology for building modern, scalable, maintainable software-as-a-service apps.') }
      end

      context 'when page has <meta property="og:description"> tag' do
        let(:html_page) do
          %{
            <html>
              <head>
                <meta property="og:description" content="The world’s easiest introduction to Machine Learning">
              </head>
            </html>
          }
        end

        it { expect(scraper.page_info.description).to eq('The world’s easiest introduction to Machine Learning') }
      end
    end

    describe 'parsing image' do

      context 'when page has <meta property="og:image"> tag' do
        let(:html_page) do
          %{
            <html>
              <head>
                <meta property="og:image" content="https://mysite.com/image.jpg">
              </head>
            </html>
          }
        end

        it { expect(scraper.page_info.image).to eq('https://mysite.com/image.jpg') }
      end

      context 'when page has <meta property="og:image"> tag' do
        let(:html_page) do
          %{
            <html>
              <head>
                <meta property="twitter:image" content="https://mysite.com/image.jpg">
              </head>
            </html>
          }
        end

        it { expect(scraper.page_info.image).to eq('https://mysite.com/image.jpg') }
      end

    end

    describe 'parsing youtube video duration' do

      context 'when there is no <meta itemprop="duration"> tag' do
        let(:html_page) { '<html><head></head></html>' }
        it { expect(scraper.page_info.duration).to be_empty }
      end

      context 'when page has <meta itemprop="duration"> tag' do
        let(:html_page) do
          %{
            <html>
              <head>
              </head>
              <body>
                <meta itemprop="duration" content="PT6M45S">
              </body>
            </html>
          }
        end

        it { expect(scraper.page_info.duration).to eq('PT6M45S') }
      end

    end
  end

  describe '#parse(name)' do

    context 'when there is no content' do
      let(:html_page) { '<html><head></head></html>' }
      it { expect(scraper.send(:parse, :duration)).to be_empty }
    end

    context 'when there are blank and special characteres' do
      let(:html_page) do
        %{
          <html>
            <head>
              <title>

                The Twelve-Factor App

              </title>
            </head>
          </html>
        }
      end

      it { expect(scraper.send(:parse, :title)).to eq('The Twelve-Factor App') }
    end
    
  end

end
