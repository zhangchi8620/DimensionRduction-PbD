function test_forward_kinect(data)       
    hand = data(1:6, :);
    joint = data(7:12, :);
    
    for i = 1 : size(data, 2)  
        sim_hand(:, i) = forward_kinematics(joint(:, i)); 
    end
    %sim_hand(1:3, :) = sim_hand(1:3, :) /1000;
    
    for i = 1 : 6
        subplot(6, 1, i)
        plot(hand(i, :)); hold on;
        plot(sim_hand(i, :), 'r'); 
    end
    
    pause;
    close all;
end