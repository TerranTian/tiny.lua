# tiny.lua

An tool to encode/decode a unsigned number to a string. Highly inspired by [tiny](https://github.com/kylebragger/tiny)

### demo code
```lua
print(tiny.tonumber(2834438,2));
print(tiny.tonumber(2834438,8));
print(tiny.tonumber(2834438,16));
print(tiny.tonumber(2834438,33));
print(tiny.tonumber(2834438,61));

```
the result is:
```lua
1010110100000000000110
12640006
2B4006
2CSQ2
CTjC
```
## set_base(value)

Set the default letters which will be used to do encode/decode, the default is 

    0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_

you can reorder these charactors for self format purpose.

## tonumber(e,[base])

similar with gloable function tonumber,but can use different letters set. 
An optional argument specifies the base to interpret the numeral. The base may be any integer between 2 and the length of the letters set. each letter represents the index of it in the charactors. for use the default letters set，"A" represents 10,"a" represents 37.
