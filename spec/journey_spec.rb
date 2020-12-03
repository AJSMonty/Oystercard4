require 'journey'
describe Journey do
  let(:entry_station) { double :entry_station, zone: 1}
  let(:exit_station) { double :entry_station, zone: 2}

  it "knows if a journey is not complete" do
    expect(subject.complete).to eq false
  end

  it 'has a penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it "returns itself when exiting a journey" do
    expect(subject.finish(exit_station)).to eq(subject)
  end

  context 'given an entry station' do
    subject {described_class.new(entry_station)}

    it 'has an entry station' do
      expect(subject.entry_station).to eq(entry_station)
    end

    it "returns a penalty fare if no exit station given" do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    context 'given an exit station' do

      before do
        subject.finish(exit_station)
      end

      it 'calculates a fare' do
        expect(subject.fare).to eq 1
      end

    end
  end
end


=begin
require 'journey'

describe Journey do
    
    let(:entry_station) { double :entry_station }

    it { expect(Journey).to respond_to(:new) }

    it { expect(subject).to respond_to(:in_journey?) }

    it 'can start a journey' do
        expect(subject.start_journey).to eq true
    end

    it 'can finish a journey' do
        expect(subject.finish_journey).to eq true
    end

    it 'can calculate journey fare' do
        expect()
    it 'returns whether a journey is complete or incomplete' do

        expect(subject)
    end
end
=end


