function G = gravity_with_observer(theta,phi,W,W_o,B,Position_G,Position_B,L0,L1)
delta1 = W-B;
xG = Position_G(1);
yG = Position_G(2);
zG = Position_G(3);

xB = Position_B(1);
yB = Position_B(2);
zB = Position_B(3);
G(1) = delta1*sin(theta);
G(2) = -delta1*cos(theta)*sin(phi);
G(3) = -delta1*cos(theta)*sin(theta);
G(4) = -(yG*W - yB*B)*cos(theta)*cos(phi) + (zG*W - zB*B)*cos(theta)*sin(phi);
G(5) = (zG*W - zB*B)*sin(theta) + (xG*W - xB*B)*cos(theta)*cos(phi);
G(6) = -(xG*W - xB*B)*cos(theta)*sin(phi)-(yG*W - yB*B)*sin(theta);
G(7) = W_o*(-L0*cos(theta)*sin(phi) - L0*sin(theta) -L1*cos(theta)*cos(phi) + L1*cos(theta)*sin(phi));
end
