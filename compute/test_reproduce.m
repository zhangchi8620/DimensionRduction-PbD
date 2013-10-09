function [hand, joint] = test_reproduce()
    length = 200;
    hand = zeros(length, 6);
    joint = zeros(length, 6);
    
    for time = 1 : length
        regressed(time, :) = GMR(time, 1, [2:9]);
        %hand_regress(time, :) = forward_kinematics(joint);
    end
    
    
    load('../data/raw_all');
    tmp = raw_all';
    hand_record = tmp(1:6, :);
    joint_record = tmp(7:end, :);

    
%% recorded hand trajectory - 3D
figure;
plot3(hand_record(1,1:200), hand_record(2,1:200), hand_record(3,1:200),'b');hold on;
plot3(hand_record(1,201:400), hand_record(2,201:400), hand_record(3,201:400),'k');
plot3(hand_record(1,401:600), hand_record(2,401:600), hand_record(3,401:600),'g');
plot3(hand_record(1,601:800), hand_record(2,601:800), hand_record(3,601:800),'m');
xlabel('x');
ylabel('y');
zlabel('z');
title('Recorded hand trajectory');
grid on;

    %plot(hand(:,3));
    %save('../data/reproduce.mat', 'hand');
end