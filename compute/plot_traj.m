length = 200;
load('../data/raw_all');
tmp = raw_all';
hand_record = tmp(1:6, :);
joint_record = tmp(7:end, :);

hand_regress = zeros(length, 6);
joint_regress = zeros(length, 6);

for time = 1 : length
    hand_regress(time,:) = GMR(time, 1, [2:7]);
    %hand_regress(time, :) = hand;
    %hand_regress(time, :) = forward_kinematics(joint);
end

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
% plot all hand, attention: use dot plotting!!!
% plot3(hand_record(1,:), hand_record(2,:), hand_record(3,:),'r.');hold on;

%% recorded hand trajectory - each dimension
% for d = 1 : 6
%     figure;
%     for start = 1 : 200 : 800
%         plot(hand_record(d, start:start + length-1)); hold on;
%     end
%     title(['hand ' num2str(d)]);
% end
 
%% recorded hand trajectory - each dimension
% for d = 1 : 2
%     figure;
%     for start = 1 : 200 : 800
%         plot(joint_record(d, start:start + length-1)); hold on;
%     end
%     plot(joint_regress(:, d), 'r'); hold on;
%     title(['joint ' num2str(d)]);
% end


%% simulated 3D hand traj, regressed joint feed into forward_kinematics     
% figure;
% plot3(hand_regress(:, 1), hand_regress(:, 2), hand_regress(:, 3),'r');hold on;
% %plot3(hand_regress(t1:t2, 1), hand_regress(t1:t2, 2), hand_regress(t1:t2, 3),'r');hold on;
% %plot3(hand_regress(1:t1, 1), hand_regress(1:t1, 2), hand_regress(1:t1, 3));
% %plot3(hand_regress(t2:end, 1), hand_regress(t2:end, 2), hand_regress(t2:end, 3));
% grid on; 
% xlabel('x');
% ylabel('y');
% zlabel('z');
% title('Regressed hand trajectory')
    
%% Each dimension in task space 
%     % simulated Z
%     %figure;
%     
%     %plot(hand(:, 3), 'r')
%     
%     %simulated 2D -N parte only
%     figure;
%     plot(hand(t1:t2, 1), 'r');hold on;
%     figure;
%     plot(hand(t1:t2, 2), 'g');
%     figure;
%     plot(hand(t1:t2, 3), 'b');grid on;
%     
%     
%     quiver3(hand(:,1), hand(:,2), hand(:, 3), hand(:, 4), hand(:, 5), hand(:,6)); hold on;
%     quiver3(hand_sim(:,1), hand_sim(:,2), hand_sim(:, 3), hand_sim(:, 4), hand_sim(:, 5), hand_sim(:,6))

    
    pause;
    close all;