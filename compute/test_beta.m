function [min, max] = test_beta(Mu)

    for i = 1 : 200
        result(:, i) = select(i);
        beta(:, i) = selectBeta(i);
    end
    
    for i = 1 : 6
        plot(beta(i, :)); hold on;
    end
    
    for i = 2 : 2
        min = 1000;
        max = -1;
        for step = 1 : 200
            %i
            %step
            %beta(i, step)
            if beta(i ,step) > 0.5
                %fprintf('%d, step %d\n', i, step);
                if beta(i, step) > max
                    max = step;
                end
                if beta(i, step) < min
                    min = step;
                end
            end
        end
    end
end

function [selectDim, beta] = select(step)
    beta = GMR_influence(step, [1], [2:9]);
    
    beta =[[1:6]',beta];
    
    tt = sortrows(beta, 2);
    selectDim = tt(end-1:end, 1);
    selectDim = sort(selectDim);
end

function beta = selectBeta(step)
    beta = GMR_influence(step, [1], [2:9]);
end