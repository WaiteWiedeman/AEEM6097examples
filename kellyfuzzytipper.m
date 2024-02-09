 %****************************************************************************
 % A 'GENERIC' ALGORITHM IN MATLAB CODE THAT RETURNS DEFUZZIFIED Decision Applied
 
 % to MATLAB's Tipper Problem. THIS PROGRAM WAS WRITTEN BY KELLY COHEN WITHIN THE FRAMEWORK 
 
 % The SOFT COMPUTING BASED AI Class Taught at UC/CEAS
 
 
 %               -------------------------------------
 %             -  LAST UPDATE : September 14, 2019     -
 %               -------------------------------------
 %****************************************************************************
 %
 % This m file kellyfuzzytipper.m  RETURNS THE DEFUZZIFIED Tip   
 
 % Amount in %. THE INPUTS ARE:
 
 % FQ      - Food Quality having a range [1, 10]
 
 % SV      - Quality fo Service having a range [1, 10]
 
 % The Single Output is Tip Amount, defined as TIP, having a Range [5%, 25%]

 %----------------------------------------------------------------------------
%                   STAGE ONE: DEFINE FUZZY SETS
 %-----------------------------------------------------------------------------------  
 function [TIP]=kellyfuzzytipper(FQ,SV);
 
 % Defining Two Membership functions, Rancid and Delicious, for Input "Food Quality", FQ
 
 FQ_Rancid=lshlder(FQ,1,3,0);
 
 FQ_Delicious=rshlder(FQ,9,10,7);
 
 
 % Defining Three Membership functions, Poor, Good and Excellent, for Input "Service", SV
 
 SV_Poor=lshlder(SV,1,4,0);
 
 SV_Good=triangle(SV,5,9,1);
 
 SV_Excellent=rshlder(SV,9,10,6);
 
 % Defining the Three Membership functions, Cheap, Average and Generous, of the Output TIP
 
 Tip_Cheap_l=0;
 Tip_Cheap_c=5;
 Tip_Cheap_r=10;
 %
 Tip_Average_l=10;
 Tip_Average_c=15;
 Tip_Average_r=20;
%
 Tip_Generous_l=20;
 Tip_Generous_c=25;
 Tip_Generous_r=30;

 %----------------------------------------------------------------------------
 %     STAGE TWO: RULE BASE AND INFERENCE USING SCALED OUTPUT APPROACH
 %----------------------------------------------------------------------------
 % Rule 1 
 % IF Food Quality is Rancid OR IF Service is Poor THEN Tip is Cheap
   Mu_Tip_Cheap=max(FQ_Rancid,SV_Poor);

 % Rule 2
 % IF Service is Good THEN Tip is Average
   Mu_Tip_Average=SV_Good;
 
  % Rule 3
  % IF Food Quality is Delicious OR Service is Excellent THEN Tip is
  % Generous
   Mu_Tip_Generous=max(FQ_Delicious,SV_Excellent);
   
  % Inference using Scaled Output Approach
  
  % In the Product implication method, the fuzzy logic inference system scales the output 
  % membership functions at the value of the corresponding rule weights.
  
  % We find the Areas of each output membership function separately
  
     A_Tip_Cheap=0.5*Mu_Tip_Cheap*(Tip_Cheap_r-Tip_Cheap_l);

     A_Tip_Average=0.5*Mu_Tip_Average*(Tip_Average_r-Tip_Average_l);

     A_Tip_Generous=0.5*Mu_Tip_Generous*(Tip_Generous_r-Tip_Generous_l);
     
   % Note that in this example the Output Membership Functions do not intersect 

   % The Union of the Output membership functions fired is simply the sum of the areas
   
     Union_Areas=A_Tip_Cheap+A_Tip_Average+A_Tip_Generous;
%----------------------------------------------------------------------------
%    STAGE THREE: DEFUZZIFICATION 
%----------------------------------------------------------------------------
% We use center of Area Approach which is popular and simple to realize

  TIP=(A_Tip_Cheap*Tip_Cheap_c+A_Tip_Average*Tip_Average_c+...
     A_Tip_Generous*Tip_Generous_c)/Union_Areas; 

end
%
%*****************************************************************************
%                               END OF PROGRAM
%*****************************************************************************
