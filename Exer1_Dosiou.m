% Askisi 1, Geomontelopoihsh, 2023
% Anna Dosiou, 222305
clear all;
close all;
clc;
%% 1. loads and reads the files %%
file1 = 'askhsh_a (1).xls';
file2 = 'apogr_2011.xlsx';
[num1,txt1,raw1] = xlsread(file1);
[num2,txt2,raw2] = xlsread(file2);

%% 2. finds and prints the positions and names of each district in the file 'apogr_2011' %%
% column for cells with >5 characters
column1 = 4;
% column for cells with 3 characters
column2 = 3;
% selection of cells to which both conditions apply 
periferies = {};
periferies_code = {};
for i = 1:length(raw2)
    cellValue1 = raw2{i, column1};
    cellValue2 = raw2{i, column2};
    if ischar(cellValue1) && length(cellValue1) > 5 && ischar(cellValue2) && length(cellValue2) == 3
        periferies = [periferies;{num2str(i), cellValue1, cellValue2};];
        periferies_code = [periferies_code;{cellValue2}];
    end
end

disp('District Position, District Name, District Code: ');
disp(periferies);

%% 3. calculates max, min, mean, and std for the sum of ages of men and for the sum of ages of women by district %%
%% 3. calculates the ages of the maximum population of men and women by district %%
men_min_populs = [];
men_max_populs = [];
men_mean_populs = [];
men_std_populs = [];
men_max_ages = [];

women_min_populs = [];
women_max_populs = [];
women_mean_populs = [];
women_std_populs = [];
women_max_ages = [];

column4 = raw2(:, 4);
column14 = raw2(:, 14);
column23 = raw2(:, 23);

men_ages_popul = zeros(1,101);
women_ages_popul = zeros(1,101);

for i = 1:length(periferies)
    
    index = str2double(periferies(i,1));
    ages = [column4(index+1:index+101)];
    men_populs = cell2mat([column14(index+1:index+101)]);
    women_populs = cell2mat([column23(index+1:index+101)]);
    
    % max men
    men_max_populs = [men_max_populs,max(men_populs)];
    age_index = find(men_populs == max(men_populs));
    men_max_ages = [men_max_ages,ages(age_index(1))];
 
    % min men
    men_min_populs = [men_min_populs,min(men_populs)];
    
    % mean men
    men_mean_populs = [men_mean_populs,mean(men_populs)];
    
    % std men
    men_std_populs = [men_std_populs,std(men_populs)];
    
    % get ages population for men
    for j = 1:length(men_populs)
        men_ages_popul(j) = men_ages_popul(j) + men_populs(j);
    end
  
    % max women
    women_max_populs = [women_max_populs,max(women_populs)];
    age_index = find(women_populs == max(women_populs));
    women_max_ages = [women_max_ages,ages(age_index(1))];
    
    % min women
    women_min_populs = [women_min_populs,min(women_populs)];
    
    % mean women
    women_mean_populs = [women_mean_populs,mean(women_populs)];
    
    % std women
    women_std_populs = [women_std_populs,std(women_populs)];
    
    % get ages population for women
    for j = 1:length(women_populs)
        women_ages_popul(j) = women_ages_popul(j) + women_populs(j);
    end
    
end

% Men messages
disp('Men maximum populations:');
disp(men_max_populs);
disp('Men maximum population ages:');
disp(men_max_ages);
 
disp('Men minimum populations:');
disp(men_min_populs);

disp('Men mean populations:');
disp(men_mean_populs);

disp('Men std populations:');
disp(men_std_populs);

% Women messages
disp('Women maximum populations:');
disp(women_max_populs);
disp('Women maximum population ages:');
disp(women_max_ages);

disp('Women minimum populations:');
disp(women_min_populs);
 
disp('Women mean populations:');
disp(women_mean_populs);
 
disp('Women std populations:');
disp(women_std_populs);

%% 4. Create a graph showing the maximum values of the male and female population (y-axis) by region (x-axis) %%
h = figure;
plot(men_max_populs,'b','LineWidth',0.8);
set(gca, 'XTick', 1:length(periferies_code));
set(gca,'XTickLabel',periferies_code);
hold on;
plot(women_max_populs,'r','LineWidth',0.8);
% axis names
xlabel('Districts');
ylabel('Max population');
legend('men','women');
title('Max population per gender and per district');
grid on;
print(h,'-dtiff','Population_Districts'); % for 7th question

%% 5. Create a bar plot of the population of men and women (y-axis) by age (x-axis) for the whole country %%
h1 = figure;
bar(women_ages_popul,'r');
set(gca, 'XTick', 1:length(ages));
set(gca,'XTickLabel',ages);
set(gca, 'XTickLabelRotation', 90);
hold on;
bar(men_ages_popul,'b');
% axis names
xlabel('Ages');
ylabel('Population');
legend('women','men');
title('Max population per gender and per age');
grid on;
print(h1,'-dtiff','Population_Ages');  % for 7th question

%% 6. Identify the minimum ages of occurrence of married men and women by region. %%

column16 = raw2(:, 16);
column25 = raw2(:, 25);
periferies_min_ages_married_men = [];
periferies_min_ages_married_women = [];

for i = 1:length(periferies)
    
    index = str2double(periferies(i,1));
    ages = [column4(index+1:index+101)];
    married_men = cell2mat([column16(index+1:index+101)]);
    married_women = cell2mat([column25(index+1:index+101)]);
    
    min_value = min(married_men(married_men ~= 0));
    age_index = find(married_men == min_value);
    periferies_min_ages_married_men = [periferies_min_ages_married_men,ages(age_index(1))];
    
    min_value = min(married_women(married_women ~= 0));
    age_index = find(married_women == min_value);
    periferies_min_ages_married_women = [periferies_min_ages_married_women,ages(age_index(1))];
    
end

disp('Minimum ages for married men per region: ');
disp(periferies_min_ages_married_men);

disp('Minimum ages for married women per region: ');
disp(periferies_min_ages_married_women);

% Create a graph showing the minimum ages of occurrence of married men and women (y-axis) by region (x-axis) %
h2 = figure;
plot(str2double(periferies_min_ages_married_men),'b');
set(gca, 'XTick', 1:length(periferies_code));
set(gca,'XTickLabel',periferies_code);
hold on;
plot(str2double(periferies_min_ages_married_women),'r');
% axis names
xlabel('Districts');
ylabel('Min ages married population');
legend('men','women');
title('Min ages married population per gender and per district');
grid on;
print(h2,'-dtiff','Married_Population_Districts'); % for 7th question

%% 8. From the files askhsh_a (1).xls and apogr_2011.xlsx to estimate the total population of Greece for the years 1995, 2000 and 2007
column2 = raw1(:, 2);
column3 = raw1(:, 3);
% population of given years
popul_1991 = column2(13:67);
popul_2001 = column3(13:67);
popul_1991_sum = sum(cell2mat(popul_1991));
popul_2001_sum = sum(cell2mat(popul_2001));
column5 = raw2(:, 5);
popul_2011_sum = cell2mat(column5(5));

years_to_be_estimated = [1995,2000,2007];
given_years = [1991,2001,2011];
given_populations = [popul_1991_sum, popul_2001_sum, popul_2011_sum];

for i = 1:numel(years_to_be_estimated)
    
    % Year for estimation
    year_to_be_estimated = years_to_be_estimated(i);
    if (year_to_be_estimated == 1995)
        % Example dataset
        years = [1991,2001];
        populations = [popul_1991_sum,popul_2001_sum];

    elseif (year_to_be_estimated == 2000)
        % Example dataset
        years = [1991,2001];
        populations = [popul_1991_sum,popul_2001_sum];
 
    elseif (year_to_be_estimated == 2007)
        % Example dataset
        years = [2001,2011];
        populations = [popul_2001_sum,popul_2011_sum];  
    end

    % Perform linear interpolation
    estimated_population = interp1(years, populations, year_to_be_estimated);
    % Display the estimated population
    disp(['For ', num2str(year_to_be_estimated), ': ', num2str(estimated_population)]);
end
    