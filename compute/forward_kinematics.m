function result = forward_kinematics(thetasR)
    global shoulderOffsetY
    global elbowOffsetY
    global upperArmLength
    global shoulderOffsetZ
    global LowerArmLength
    global HandOffsetX
    global HandOffsetZ

    shoulderOffsetY = 98;
    elbowOffsetY = 15;
    LowerArmLength = 55.95;
    upperArmLength = 105;
    shoulderOffsetZ = 100;
    HandOffsetX = 57.75;
    HandOffsetZ = 12.31;

    result = my_fRightHand(thetasR);
    result(1:3) = result(1:3)/1000;
end


%% My right hand
function [right] = my_fRightHand(thetas)
    global shoulderOffsetY
    global LowerArmLength
    global elbowOffsetY
    global shoulderOffsetZ
    global HandOffsetX
    global upperArmLength
    global HandOffsetZ
    
    base = eye(4,4);
    base(2,4) = -shoulderOffsetY;
    base(3,4) = shoulderOffsetZ;

    T1 = T(0,-pi/2,0,thetas(1));
    T2 = T(0,pi/2,0,thetas(2)+pi/2); 
    T3 = T(-elbowOffsetY,pi/2,upperArmLength,thetas(3));  %Add elbowOffsetY
    T4 = T(0,-pi/2,0,thetas(4));
    T5 = T(0,pi/2,LowerArmLength,thetas(5));

    R = Rofl(-pi/2,0,-pi/2);  %modify here
    Tend1 = eye(4,4);
    Tend1(1,4) = HandOffsetX;
    Tend1(3,4) = -HandOffsetZ;
    Tend = R*Tend1;
    Tendend = base*T1*T2*T3*T4*T5*Tend; %Delete last Rofl(0,0,pi)

    %Remove Temp here
    
    rotZ = atan2(Tendend(2,1),Tendend(1,1));
    rotY = atan2(-Tendend(3,1),sqrt(Tendend(3,2)^2 + Tendend(3,3)^2));
    rotX = atan2(Tendend(3,2),Tendend(3,3));
    right = [Tendend(1:3,4);rotX;rotY;rotZ];
end

function [Taf] = T(a,alpha,d,theta)
    Taf = [cos(theta),            -sin(theta),            0,              a;
    sin(theta)*cos(alpha), cos(theta)*cos(alpha),  -sin(alpha),    -sin(alpha)*d;
    sin(theta)*sin(alpha), cos(theta)*sin(alpha),  cos(alpha),     cos(alpha)*d;
    0,                     0,                      0,              1;];
end

function [Ro] = Rofl(xAngle,yAngle,zAngle)
        Rx = [1,                0,          0;
        0,                cos(xAngle), -sin(xAngle);
        0,                sin(xAngle), cos(xAngle);];

        Ry = [cos(yAngle),       0,          sin(yAngle);
            0,                1,          0;
            -sin(yAngle),      0,          cos(yAngle);];

        Rz = [cos(zAngle),       -sin(zAngle),0;
            sin(zAngle)        cos(zAngle), 0;
            0,                0,          1;];
        R = Rx*Ry*Rz;

        R = [R, [0;0;0];
            [0,0,0],1];
        Ro = R;
end

function [Ro] = Rofl2(xAngle,yAngle,zAngle)
    Rx = [1,                0,          0;
        0,                cos(xAngle), -sin(xAngle);
        0,                sin(xAngle), cos(xAngle);];

    Ry = [cos(yAngle),       0,          sin(yAngle);
        0,                1,          0;
        -sin(yAngle),      0,          cos(yAngle);];

    Rz = [cos(zAngle),       -sin(zAngle),0;
        sin(zAngle)        cos(zAngle), 0;
        0,                0,          1;];
    R = Rz*Ry*Rx;

    R = [R, [0;0;0];
        [0,0,0],1];
    Ro = R;
end

