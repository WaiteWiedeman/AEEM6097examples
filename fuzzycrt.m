%----------------------------------------------------------------------------
%                   STAGE ONE: DEFINE FUZZY SETS
%-----------------------------------------------------------------------------------  
 function [y]=fuzzycrt(x)
 % Defining Three Membership functions: S, M, and B for Input x

 x_S = triangle(x,0.25,0.5,0);
 x_M = triangle(x,0.5,0.75,0.25);
 x_B = rshlder(x,1.0,1.0,0.5);
 
 % Defining the two Membership functions, SM and L, of the Output y

 y_SM_l = 0;
 y_SM_c = 0.25;
 y_SM_r = 0.5;

 y_L_l = 0.25;
 y_L_c = 1.0;
 y_L_r = 1.0;

 %----------------------------------------------------------------------------
 %     STAGE TWO: RULE BASE AND INFERENCE USING SCALED OUTPUT APPROACH
 %----------------------------------------------------------------------------
 % Rule 1 
 % IF x is S THEN y is SM
   Mu_y_SM=x_S

 % Rule 2
 % IF x is M or B THEN y is L
   Mu_y_L=max(x_M,x_B)

 % Rule 3
 % IF x is B THEN y is L
   %Mu_y_L=x_B;
     
  % Inference using Scaled Output Approach
  
  % In the Product implication method, the fuzzy logic inference system scales the output 
  % membership functions at the value of the corresponding rule weights.
  
  % We find the Areas of each output membership function separately
  
     A_y_SM=0.5*Mu_y_SM*(y_SM_r-y_SM_l);

     A_y_L=0.5*Mu_y_L*(y_L_r-y_L_l);
     
  % The Union of the Output membership functions fired is simply the sum of the areas
   
     Union_Areas=A_y_L+A_y_SM;
%----------------------------------------------------------------------------
%    STAGE THREE: DEFUZZIFICATION 
%----------------------------------------------------------------------------
% We use center of Area Approach which is popular and simple to realize

  y=(A_y_L*y_L_c+A_y_SM*y_SM_c)/Union_Areas; 

end
%
%*****************************************************************************
%                               END OF PROGRAM
%*****************************************************************************
