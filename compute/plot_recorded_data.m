function plot_recorded_data()
    load('../data/raw_all.mat');
    tmp = raw_all';
    hand_record = tmp(1:6, :);
    joint_record = tmp(7:end, :);
    
    length = 200;
    cc=['b', 'g', 'k', 'm'];
    for i = 1 : 200: 800
        c = floor(i/200)+1;
        plot3(hand_record(1,i:i+length-1-10), hand_record(2,i:i+length-1-10), hand_record(3,i:i+length-1-10), cc(c));hold on;
    end
    xlabel('x');
    ylabel('y');
    zlabel('z');
    title('Recorded hand trajectory');
    grid on;
end