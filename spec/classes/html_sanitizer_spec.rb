require 'spec_helper'

describe HTMLSanitizer do
  let(:sanitizer) { described_class.new }
  subject { sanitizer.sanitize(text) }

  describe '#sanitize' do
    describe 'delete tag script' do
      let(:text) { "<script>Text</script>" }

      it { should == "Text" }
    end

    describe 'delete unresolved tags' do
      let(:text) { "<article>Text</article> <big>Text</big>" }

      it { should == " Text Text" }
    end

    describe 'delete unresolved attributes for a' do
      let(:text) { "<a href='http://ya.ru' oncklick='let();'>Link</a>" }

      it { should == '<a href="http://ya.ru">Link</a>' }
    end

    describe 'delete unresolved protocols for a' do
      let(:text) { "<a href='script:let();'>Link</a>" }

      it { should == "<a>Link</a>" }
    end

    describe 'delete unresolved attributes for img' do
      let(:text) { "<img src='/image.jpg' alt='image' onclick='let();'>" }

      it { should == '<img src="/image.jpg" alt="image">' }
    end

    describe 'save allowed tags' do
      let(:text) { "<p class='big'><a><strong>Text</strong></a></p>" }

      it { should == "<p><a><strong>Text</strong></a></p>" }
    end
  end
end
