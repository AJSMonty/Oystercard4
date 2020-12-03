require 'oystercard'

describe Oystercard do
let(:entry_station){ double :entry_station }
let(:exit_station){ double :exit_station }

  it { is_expected.to respond_to(:balance) }

  it 'has a starting balance of zero' do
    expect(subject.balance).to eq Oystercard::DEFAULT_BALANCE
  end

  describe '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'should add amount to balance' do
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end

    it 'should raise an error if balance is already at maximum limit' do
      subject.top_up(Oystercard::MAXIMUM_LIMIT)
      expect { subject.top_up(1) }.to raise_error "balance exceeds £#{Oystercard::MAXIMUM_LIMIT}"
    end
  end

  describe "#touch_in" do
    it { is_expected.to respond_to(:touch_in).with(1).argument }

    it 'should not allow touch_in if balance is under minimum amount' do
      subject.top_up(0.5)
      expect { subject.touch_in(entry_station) }.to raise_error "balance under £#{Oystercard::MINIMUM_AMOUNT}"
    end

  end

  describe "#touch_out" do
    it { is_expected.to respond_to(:touch_out).with(1).argument }

    it 'should deduct minimum fare from balance' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-1)
    end
  end

  describe '#history' do
    it { is_expected.to respond_to(:history) }

    it 'starts with an empty list of journeys' do
      expect(subject.history).to be_empty
    end

    it 'displays history of journeys' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.history).to include( :entry_station => entry_station, :exit_station => exit_station )
    end
  end
end
