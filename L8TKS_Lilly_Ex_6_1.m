%************************************************************************
% Prepared by Prof. Kelly Cohen for Soft Computing Based AI Class
%        Univeristy of Cincinnati, July 18 2020
%************************************************************************
clc
clear all

% Defining a 2 input (x1 and x2) and one output (y) Takagi-Sugeno Fuzzy System  

% x1 (x)and x2 (y) between range [-1.5 1.5] as defined as follows:
x = -1.5:0.01:1.5; y = -1.5:0.01:1.5;

% Membership functions for the two input variables, x1 and x2 using
% matlab's Z and S spilne based membership functions
% 
for Q=1:301
    x1=x(Q); x2=y(Q); 
      Mu11(Q)=zmf(x1,[-1 1.5]);  Mu12(Q)=smf(x1,[-1.5 1]);
      Mu21(Q)=zmf(x2,[-1 1.5]);  Mu22(Q)=smf(x2,[-1.5 1]);
end

% Plotting the Input variable Membership functions for variables x1 and x2
figure(1)
subplot(2,1,1),plot(x,Mu11,x,Mu12)
xlabel('Input variable "x1"')
ylabel('Membership Function')
subplot(2,1,2),plot(x,Mu21,x,Mu22)
xlabel('Input variable "x2"')
ylabel('Membership Function')

%*************************************************************************
% Calculate the Fuzzy function Apprioximatin using Takagi-Sugeno Approach
%*************************************************************************

for N=1:301
   for M=1:301
      x1=x(N); x2=y(M);
% Define Membership functions for the input 'x'
        Mu11(N)=zmf(x1,[-1 1.5]);  Mu12(N)=smf(x1,[-1.5 1]);
        Mu21(M)=zmf(x2,[-1 1.5]);  Mu22(M)=smf(x2,[-1.5 1]);

% Calculating product T-norm using using Lilly equation (6.6a) for fuzzy Inference on page 90   
%      T1=Mu11(N)*Mu21(M);  T2=Mu11(N)*Mu22(M);
%      T3=Mu12(N)*Mu21(M);  T4=Mu12(N)*Mu22(M);

% The output level zi of each rule is weighted by the firing strength Ti of
% the ith rule. Using MIN operator for AND in premise of Rule 
      T1=min(Mu11(N),Mu21(M));  T2=min(Mu11(N),Mu22(M));
      T3=min(Mu12(N),Mu21(M));  T4=min(Mu12(N),Mu22(M));
      
% The equations given for each of the 4 Rules as a linear function of
% inputs x1 and x2
      R1=1+x1+x2;      R2=2*x1+x2; 
      R3=-1+x1-2*x2;   R4=-2-x1+0.5*x2;
      
% The final output of the system is the weighted average of all rule outputs
% as described in teh MATLAB Fuzzy Logic User's guide Page 2-84

% Defuzzification Calculation using Takagi-Sugeno (T-S) approach
      Defuzz_Output=(R1*T1+R2*T2+R3*T3+R4*T4)/(T1+T2+T3+T4); 
      Output(N,M)=Defuzz_Output;
 % Another Defuzzification approach is weighted sum     
%        Defuzz_Output=(R1*T1+R2*T2+R3*T3+R4*T4); 
%       Output(N,M)=Defuzz_Output;
   end
end

% 3-D Surf  Plot of the T-S crisp Output  
figure(2)
surf(x,y,Output)
%mesh(x,y,Output)
shading INTERP
grid ON
colorbar
xlabel('Input variable "x1"')
ylabel('Input variable "x2"')
zlabel('Ouput variable')