RSpec.describe PPP::GabiFormatter do
  def formatter(data)
    PPP::GabiFormatter.new(data)
  end

  subject { formatter(data) }

  describe '.formatted_text' do
    context 'formats time object' do
      let(:time) { Time.at(0).getutc.to_datetime }
      let(:data) { { date: time } }

      it { expect(subject.formatted_text).to eq('date' => '<DateTime> [01/01/70 00:00]') }
    end

    context 'formats array object' do
      let(:data) { { my_array: [{ b: 'c' }, { c: 1 }] } }

      it do
        expect(subject.formatted_text).to
        eq('my_array <Array>' => [{ b: '<String> c' }, { c: '<Fixnum> 1' }])
      end
    end

    context 'formats numbers' do
      let(:data) { { int: 1, real: 2.0 } }

      it { expect(subject.formatted_text).to eq(int: '<Fixnum> 1', real: '<Float> 2.0') }
    end
  end
end
