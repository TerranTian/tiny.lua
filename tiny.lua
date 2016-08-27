	local M = {};

	local base_set= "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_"

	function M.set_base(value) 
		base_set = value or base_set;
	end

	function M.tonumber(e,base)
		base = base or 10;
		if base == 10 then return  tonumber(e) end
		if tonumber(e) ~= nil then return M.encode(e,base) end

		return M.decode(e,base);
	end

	function M.encode(interger,base)
		base = base or 62;
		local key = base_set:sub(1,base);
		local hexn,radix = "",key:len();
		if base <=36 then key:lower();end
		
		repeat
			local r = interger % radix;
			interger = (interger - r) / radix
			hexn = key:charAt(r) .. hexn;
		until interger == 0
		
		return  hexn
	end

	function M.decode(string,base)
		base = base or 62;
		local key = base_set:sub(1,base);
		local radix,strlen = key:len(),string:len();
		if base <=36 then key:lower();string:lower() end

		local n,i = 0,0;
		while i < strlen do
			local p = key:index(string:charAt(i));
			if p < 0 then return -1 end
			n =n + p * math.pow(radix, strlen - i - 1);
			i = i+1;
		end

		return n;
	end

	function string.fromhex(self)
	    return (self:gsub('..', function (cc)
	        return string.char(tonumber(cc, 16))
	    end))
	end

	function string.tohex(self)
	    return (self:gsub('.', function (c)
	        return string.format('%02X', string.byte(c))
	    end))
	end

	-- index range [0,len-1]
	function string.charAt(self,index)
		return self:sub(index+1,index+1)
	end

	-- index range [-1,len-1]
	-- -1 returned if not find.
	function string.index(self,str)
		local index,_ = self:find(str);
		index = index or 0;
		return index - 1
	end

	print(M.tonumber(2834438,2));
	print(M.tonumber(2834438,8));
	print(M.tonumber(2834438,16));
	print(M.tonumber(2834438,33));
	print(M.tonumber(2834438,61));

	print(M.decode(M.encode(288,2),2));
	print(M.decode(M.encode(288)))

	return M;