	local M = {};

	local bases_map = {}
	bases_map["2"] = "01"
	bases_map["8"] = "01234567"
	bases_map["10"] = "0123456789"
	bases_map["16"] = "0123456789ABCDEF"
	bases_map["36"] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	bases_map["62"] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

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

	function M.regiest(base,key)
		bases_map[base..""] = key;
	end

	function M.encode(interger,base)
		local key = bases_map[tostring(base or 62)]
		local hexn,radix = "",key:len();
		
		repeat
			local r = interger % radix;
			interger = (interger - r) / radix
			hexn = key:charAt(r) .. hexn;
		until interger == 0
		
		return  hexn
	end

	function M.decode(string,base)
		local key = bases_map[tostring(base or 62)]
		local radix,strlen = key:len(),string:len();

		local n,i = 0,0;
		while i < strlen do
			local p = key:index(string:charAt(i));
			if p < 0 then return -1 end
			n =n + p * math.pow(radix, strlen - i - 1);
			i = i+1;
		end

		return n;
	end

	print(M.decode(M.encode(288,2),2));
	print(M.decode(M.encode(288)))

	return M;