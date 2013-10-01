function [solution, Q, bad] = rl()
    clc;
    clear;
    
    for run = 1 : 10
        one_run();
    end
end


function one_run()
goal = 0.32;

    %[bestMu, Q] = trainAllGMM(goal);
    %    solution = testRL(gmm, goal-0.01, Q(:,:,gmm))
    
    solution = zeros(1, 6);
    gmm = 1;
    
    j = 1;
    color = {'k', 'b', 'r', 'g', 'm', 'c'};
    
    while(1)
            [solution(gmm), Q(:,:, gmm), one_rwd] = trainGMM(gmm, goal);
       
%             plot(one_rwd); hold on;
% 
%             bad(gmm, j) = solution(gmm); 
%             j = j + 1;
%            
                  
            if solution(gmm) ~= 0 
                plot(one_rwd, 'color', color{gmm}, 'LineWidth', 3); hold on;
                legend('G1', 'G2', 'G3', 'G4', 'G5', 'G6');
                legend boxoff;
                %success, go to next gmm
                gmm = gmm + 1;
                if gmm == 7
                    return;
                end

            end
        
    end
%     counter = 0;
%     gmm = 1;
%     
%     while (1)
%         [sol, Q(:,:, gmm), one_rwd] = trainGMM(gmm, goal);
%         if sol ~= 0
%             plot(one_rwd); hold on;
%             counter = counter + 1;
%             if counter == 10
%                 return ;
%             end
%         end
%     end

end

