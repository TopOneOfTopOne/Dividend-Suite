require_relative '..HPC'
require 'rspec'
describe '.HPC::hpc' do 
	it 'is 100% frank' do
		expect(HPC::hpc(10, 1, 100)).to eq(9.9921)
	end
	it 'is 50% frank' do 
		expect(HPC::hpc(10, 1, 50)).to eq(9.9935)
	end
	it 'is 0% frank' do
		expect(HPC::hpc(10, 1, 0)).to eq(9.9945)
	end
end
