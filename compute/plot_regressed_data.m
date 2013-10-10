function plot_regressed_data()
    length = 200;
    
    for time = 1 : length
        regressed(time, :) = GMR(time, 1, [2:7]);
        %hand_regress(time, :) = forward_kinematics(regressed(time, :));
    end
    hand_regress = hand_regress';
    
    plot3(hand_regress(1,:), hand_regress(2,:), hand_regress(3,:),'b');hold on;
    
    pause;
    close all;
end