function [output] = allpairXYZ(input)
    [n m] = size(input);
    output = [];
    for k = 1 : m
        temp = [];
        for i = 1 : n
            for j = i + 1 : n
                temp = [temp input(i,k) - input(j,k)];
            end
        end
        mx = max(max(temp));
        temp = temp/mx;
        output = [output temp];
    end
    
end

