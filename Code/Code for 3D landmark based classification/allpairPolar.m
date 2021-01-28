function [output] = allpairPolar(input)
    [n m] = size(input);
    output = [];

    for i = 1 : n
        for j = i + 1 : n
            difference = input(i,:) - input(j,:); %difference vector of a single pair
            distance = sqrt(sum(difference .^ 2)); %squaring, then summing, then taking the root
            
            %cos(theta) = dot(a,b)/(mag(a) * mag(b))
            dotproduct = dot(input(i,:),input(j,:));
            absolutevalues = dot(input(i,:),input(i,:)) * dot(input(j,:),input(j,:)); %dot product with itself to get the magnitude
            cosineangle = dotproduct/absolutevalues;

            output = [output distance cosineangle];
        end
    end
    
end
