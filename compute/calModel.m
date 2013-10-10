% Main computation function
function calModel()
    clc;
    clear;
    
    path = '../data/';
    numDemo = 4;
    numDim = 12;    % 6 hand pos + 8 dim angles (RSholderPitch, RShoulderRoll, RElbowYaw, RElbowRoll, RwristYaw, RHand)

    %% Step 1: read raw data to .mat
    %delete([path, '*.mat']);
    %read2mat(path, numDemo, numDim);
    
    %% Step 2: assemble raw to raw_all to the same length
    length = 200;
    raw_all = assemble2one(path, numDemo, numDim, length);
    
    tmp_all = raw_all';
    [nbVar, nbData] = size(tmp_all);
    fprintf('size of all data: [%d, %d]\n',nbVar, nbData);
    hand = tmp_all(1:3, :);
    joint = tmp_all(7:end, :);
    dim = joint;
    
    %% Step 3: compute number of PCA for dim
    % normalize
    tmp = dim';
    m = mean(tmp);
    s = std(tmp);
    dim = (dim - repmat(m', 1, length*numDemo)) ./ repmat(s', 1, length*numDemo); 
    
    threshold = 0.95;
    [nbPC, percent] = numPCA(dim, threshold);
    fprintf('percent %f%%\n', percent'*100);
    
    %% Step 4: DTW aligenment
    flagDTW = 1;
    if flagDTW == 1
        dim = DTW(dim, length);
    end
    
    %% Step 5: dimension extration by PCA
    [prinDim, unprinDim, dim2, A] = DR(dim, nbPC);
    prinDim
    unprinDim
    
    %% Step 6: compute # of GMM by BIC
    maxStates =  3;
    nbStates = BIC(dim2, maxStates);
    fprintf('nbStates %d\n', nbStates);

    %% Step 7: train GMMData_mean
    onetime = [1:length];
    timeDim = repmat(onetime, [1, numDemo]);
    Data = [timeDim; dim];
    Data2 = [timeDim; dim2];
    %fprintf('size of Data %d\t\t Data2 %d\n',size(Data), size(Data2));
    [Priors, Mu, Sigma] = GMMwithReproject(Data, Data2, nbStates, A);

    %% Step 8: save params
    save([path, 'Priors.mat'], 'Priors');
    save([path, 'Mu.mat'], 'Mu');
    save([path, 'Sigma.mat'], 'Sigma');
    
    %% Step 8: regress
    for time = 1 : length
        tmp = GMR(time, 1, [2:7]);
        %tmp2 = tmp;
        tmp2 = tmp .* s' + m'; 
        hand_regress(time, :)  = forward_kinematics(tmp2);
    end
    hand_regress = hand_regress';
    % regressed traj
    figure;
    plot3(hand_regress(1,:), hand_regress(2,:), hand_regress(3,:),'r');hold on;
    grid on;
    % plot recorded traj     
    plot_recorded_data();
    

    pause;
    close all;

end        
