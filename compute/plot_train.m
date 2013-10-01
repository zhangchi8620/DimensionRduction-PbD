
function hand = plot_train(goal, s, nbAct)
    load('../data/Mu.mat');
    Mu_new = Mu;

    %gap = 0.04;
    %gap = (max(Mu(2,:)) - min(Mu(2,:)) )/6;
    gap = 0.03;
    
    for i = 1 : 6
            s(i) = s(i) - floor(nbAct/3);
    end
    
    Mu_new(2, 1) = Mu(2, 1) + s(1) * gap;
    Mu_new(2, 2) = Mu(2, 2) + s(2) * gap;
    Mu_new(2, 3) = Mu(2, 3) + s(3) * gap;
    Mu_new(2, 4) = Mu(2, 4) + s(4) * gap;
    Mu_new(2, 5) = Mu(2, 5) + s(5) * gap;
    Mu_new(2, 6) = Mu(2, 6) + s(6) * gap;
    
    Mu_new
    
    length = 200;
    
    Jacobian = forwardKinect();
    hand_std = zeros(length, 6);
    for time = 1 : length
        joint = GMRwithParam(time, 1, [2:9], Mu);
        joint_new = GMRwithParam(time, 1, [2:9], Mu_new);
        
        hand_std(time, :) = testForwardKinect([joint]', Jacobian);
        hand_new(time, :) = testForwardKinect([joint_new]', Jacobian);

    end
    %goal = hand_std(:, 3) - 0.03;
    %    goal = (mean(hand_std(80:100, 3)) - 0.02) * ones(1, 200);
    %goa = 0.3288 * ones(1, 200);

    diff = hand_new(:,3) - hand_std(:,3);
    
    s
    plot(hand_std(:,3), 'g'); hold on;
    plot(hand_new(:,3), 'bo'); 
    plot(goal*ones(1,200), 'r'); 
    plot((goal+0.008)*ones(1,200), 'r-.'); 
    plot((goal-0.008)*ones(1,200), 'r-.');grid on;
    %save('../data/reproduce.mat', 'hand');
    %save('../data/Mu_new.mat', 'Mu_new');
    
 %simulated 3D
%     t1 = 32;
%     t2 = 172;
%     figure;
%     plot3(hand_std(t1:t2, 1), hand_std(t1:t2, 2), hand_std(t1:t2, 3),'r', 'LineWidth', 5);hold on;
%     plot3(hand_std(1:t1, 1), hand_std(1:t1, 2), hand_std(1:t1, 3));
%     plot3(hand_std(t2:end, 1), hand_std(t2:end, 2), hand_std(t2:end, 3));
%     
%     plot3(hand_new(t1:t2, 1), hand_new(t1:t2, 2), hand_new(t1:t2, 3),'g', 'LineWidth', 5);hold on;
%     plot3(hand_new(1:t1, 1), hand_new(1:t1, 2), hand_new(1:t1, 3));
%     plot3(hand_new(t2:end, 1), hand_new(t2:end, 2), hand_new(t2:end, 3));
%     
%     
%     grid on; 
%     xlabel('hand_1');
%     ylabel('hand_2');
%     zlabel('hand_3');
    
end