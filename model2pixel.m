function [pixel] = model2pixel(input,Zbed,ZTool,lim)
    % Transfer models into pixel-based models
    % input: 1 x nLayers, Resistivity vector
    % Zbed: 1 x nLayers-1, Zbed vector
    % ZTool: tool location, should set it to 0 by default.
    % lim: positive number, the output model is in range [-lim, lim].
    npixels = size(Zbed,2)+1;
    dim = size(input,2);
    np = size(input,1);
    numLayers = (dim+1)/2;
    out = zeros(np,npixels);
    for ip = 1:np
        for i = 1:npixels-1
            out(ip,i) = input(ip,numLayers);  
    %         if out(ip,i) < 0
    %             printf('error');
    %         end
            for j = 1:numLayers-1
                if Zbed(i) <= input(ip,j+numLayers)
                    out(ip,i) = input(ip,j); 
    %                 if out(ip,i) < 0
    %                     printf('error');
    %                 end
                    break; 
                end
            end
        end
        out(ip,npixels) = input(ip,numLayers);
    %     if out(ip,npixels) < 0
    %         printf('error');
    %     end
    end

    for i = 1:np
        for j = 1:npixels-1
            if Zbed(j)>ZTool(i)-lim
                upID(i)=j;
                break;
            end
        end
    end

    for i = 1:np
        for j = npixels-1:-1:1
            if Zbed(j)<ZTool(i)+lim
                botID(i)=j;
                break;
            end
        end
    end
    % tol=0.1;
    for i = 1:np
        out(i,1:upID(i)) = zeros(1,upID(i))+input(i,1);
        out(i,botID(i):end) = zeros(1,npixels-botID(i)+1)+input(i,numLayers);
    end
    pixel = out;
    loc=find(pixel<0);
    % if size(loc) >0
    %     printf("error");
    % end


