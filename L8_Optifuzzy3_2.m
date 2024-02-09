%************************************************************************
% Prepared by Prof. Kelly Cohen for Soft Computing Based AI Class
%        University of Cincinnati, July 16 2020
%************************************************************************
clc
clear all

x1 = -15:0.1:15;
y=.03*x1.^3+.2*x1.^2-.5*x1-3;
% Where y is the function we wish to approximate using fuzzy logic
figure(1)
plot(x1,y)
xlabel('Input variable "x"')
ylabel('Ouput variable "y"')

% Defining the 7 Triangle shaped membership functions for the input variable
% Using MATLAB Fuzzy ToolBox's trimf command
% Mu1 = trimf(x1,[-22 -17.5 -13]);Mu2 = trimf(x1,[-17.5 -13 -8.5]);
% Mu3 = trimf(x1,[-13 -8.5 -1]);Mu4 = trimf(x1,[-8.5 -1 10]);
% Mu5 = trimf(x1,[-1 10 12]);Mu6 = trimf(x1,[10 12 15]);
% Mu7 = trimf(x1,[12 15 20]);

% Defining the 7 Triangle shaped membership functions for the input variable
% Using Kelly Cohen's ToolBox's triangle command

for N=1:301
    x=x1(N);
Mu1(N) = triangle(x,-17.5,-13,-22); Mu2(N) = triangle(x,-13,-8.5,-17.5);
Mu3(N) = triangle(x,-8.5,-1,-13);   Mu4(N) = triangle(x,-1,10,-8.5);
Mu5(N) = triangle(x,10,12,-1);      Mu6(N) = triangle(x,12,15,10);
Mu7(N) = triangle(x,15,20,12); 
end

% Plotting the Inout variable Membership functions
figure(2)
plot(x1,Mu1,x1,Mu2,x1,Mu3,x1,Mu4,x1,Mu5,x1,Mu6,x1,Mu7)
xlabel('Input variable "x"')

%**************************************************************************
% Supervised Learning to obtain the Takagi-Sugeno Rule Base
%**************************************************************************
% Finding the Equation of the line for Rule 1
% x1=x(1:40); y1=y(1:40);
% fit(x1',y1','poly1');
% %   Linear model Poly1:
% %      ans(x) = p1*x + p2
% %      Coefficients (with 95% confidence bounds):
% %        p1 =       9.679  (9.349, 10.01)
% %        p2 =       95.93  (91.6, 100.3)
% f1=9.679*x+95.93; % Equation of the line for Rule 1
% 
% Finding the Equation of the line for Rule 2
% x2=x(41:100); y2=y(41:100);
% fit(x2',y2','poly1')
% %      Linear model Poly1:
% %      ans(x) = p1*x + p2
% %      Coefficients (with 95% confidence bounds):
% %        p1 =       2.274  (2.06, 2.488)
% %        p2 =       15.07  (13.31, 16.83)
% f2=2.274*x+15.07; % Equation of the line for Rule 2
% 
% Finding the Equation of the line for Rule 3
% x3=x(101:200); y3=y(101:200);
% fit(x3',y3','poly1')
% %  Linear model Poly1:
% %      ans(x) = p1*x + p2
% %      Coefficients (with 95% confidence bounds):
% %        p1 =    -0.06988  (-0.1784, 0.03867)
% %        p2 =      -1.349  (-1.662, -1.036)
% f3=0.06988*x-1.349; % Equation of the line for Rule 3
% 
% Finding the Equation of the line for Rule 4
% x4=x(201:260); y4=y(201:260);
% fit(x4',y4','poly1')
% %    Linear model Poly1:
% %      ans(x) = p1*x + p2
% %      Coefficients (with 95% confidence bounds):
% %        p1 =        8.53  (8.157, 8.903)
% %        p2 =      -44.33  (-47.36, -41.29)
% f4=8.53*x-44.33; % Equation of the line for Rule 4
% 
% Finding the Equation of the line for Rule 5
% x5=x(261:301); y5=y(261:301);
% fit(x5',y5','poly1')
% % Linear model Poly1:
% %      ans(x) = p1*x + p2
% %      Coefficients (with 95% confidence bounds):
% %        p1 =       19.99  (19.52, 20.45)
% %        p2 =      -167.7  (-173.8, -161.6)
% f5=19.99*x-167.7;% Equation of the line for Rule 5

%*************************************************************************
% Calculate the Fuzzy function Apprioximatin using Takagi-Sugeno Approach
%*************************************************************************

for N=1:301
    x=x1(N);
% Define Membership functions for the input 'x'
Mu1 = trimf(x,[-22 -17.5 -13]);Mu2 = trimf(x,[-17.5 -13 -8.5]);
Mu3 = trimf(x,[-13 -8.5 -1]);Mu4 = trimf(x,[-8.5 -1 10]);
Mu5 = trimf(x,[-1 10 12]);Mu6 = trimf(x,[10 12 15]);
Mu7 = trimf(x,[12 15 20]);

% Calculate the Membership Function of each of the 5 Rules
Mu_R1=max([Mu1,Mu2]); Mu_R2=Mu3;
Mu_R3=Mu4; Mu_R4=Mu5;
Mu_R5=max([Mu6 Mu7]); 

% Using Supervised learning (Linear Curve Fit) to Calculate the formula for
% each Rule based on Takagi-Sugeno Fuzzy System Architecture
f1=9.679*x+95.93; f2=2.274*x+15.07; 
f3=0.06988*x-1.349; f4=8.53*x-44.33;
f5=19.99*x-167.7;

% Defuzzification Calculation using Takagi-Sugeno (T-S) approach (Page 88 of John
% H. Lilly book "Fuzzy Control and Identification", Wiley, 2010)

Defuzz_Output=(f1*Mu_R1+f2*Mu_R2+f3*Mu_R3+f4*Mu_R4+f5*Mu_R5)/(Mu_R1+Mu_R2+Mu_R3+Mu_R4+Mu_R5); 

DF(N)=Defuzz_Output;
end
% Comparing the T-S Fuzzy Approximator with the Original Function
figure(3)
plot(x1,DF,x1,y)
xlabel('Input variable "x"')
ylabel('Ouput variable')