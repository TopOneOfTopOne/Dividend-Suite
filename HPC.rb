# hypothesis price calculator 

# hypothesis price: The highest price in which all liquid stocks reach at ex dividend date

# formula: hypo_price = pcum - after tax personal dividend
 # after tax personal dividend = before corporate tax dividend * (highest personal tax rate)
 # before corpoorate tax dividend = dividend/(1 - real tax rate) 
 # real tax rate = franking(%) * corporate tax rate 

module HPC
	HPTR = 0.45
	CTR  = 0.3 

	def self.hpc(pcum, div, frank)
		(pcum - (((div/100.0)/( 1 - ( (frank/100.0)*CTR ) )) * (1-HPTR))).round(4)
	end

end