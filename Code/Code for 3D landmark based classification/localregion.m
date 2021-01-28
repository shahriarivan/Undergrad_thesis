function [output] = localregion(input)
    [n m] = size(input);
    
    factor = zeros(68);
    for i = 1 : 17
        factor(i) = 1;
    end
    for i = 18 : 27
        factor(i) = 2;
    end
    for i = 37 : 48
        factor(i) = 2;
    end
    
    for i = 28 : 36
        factor(i) = 3;
    end           
    
    for i = 49 : 88
        factor(i) = 4;
    end       
    
    output = [];
    
    distances = [];
    

    for i = 1 : n
        for j = i + 1 : n
            D = 0;
            if factor(i) == factor(j)
                
                for k = 1 : m
                    D = D + (input(i,k) - input(j,k)).^2; 
                end
            end
            distances = [distances D];    
        end

    end


    
    for i = 1 : length(distances)

        for j = i + 1 : length(distances)
            output = [output distances(j)/distances(i)];
        end

    end
end

