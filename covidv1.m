classdef covidv1
    properties 
        coviddata     % To store the extracted data
        Date          % To store dates
        Country       % To store Countries
        Country_index % To store indexes of countries
        State         % To store states
        State_index   % To store indexes of states 
        Cases_Matrix  % Matrix of Cases
        Deaths_Matrix % Matrix of Deaths
        global_cases  % Global Cases Vector
        global_deaths % Global Deaths Vector
    end
    methods
        function obj=covidv1(in)
        load covid_data.mat covid_data
        obj.coviddata=covid_data;
        obj.Country=covid_data(:,1);
        obj.Date=covid_data(1,3:end);
        obj.Country{1}='Global';
        [~, n]=ismember(obj.Country,in);
        [~,obj.Country_index]=max(n);
        obj.State_index=obj.Country_index:(obj.Country_index+sum(n)-1);
        obj.State=covid_data(obj.State_index,2);
        obj.State{1}='All';
        %% Creating Matrix of Cases and Deaths so that further calculations can be done
         for ii=1:length(obj.Country)
            for jj=3:length(obj.Date)+2
                obj.Cases_Matrix(ii,jj-2)=obj.coviddata{ii,jj}(1,1);
                obj.Deaths_Matrix(ii,jj-2)=obj.coviddata{ii,jj}(1,2);
            end
         end
         %% Finding Global Cases and Deaths
            states=obj.coviddata(:,2);
            All=zeros(1,length(states));
            global_Cases=zeros(length(states),length(obj.Date));
            global_Deaths=zeros(length(states),length(obj.Date));
            for i=1:length(states)
                if isempty(states{i})
                    All(i)=i; %Storing the index of countries whose states are not given
                end
            end
            
            All=nonzeros(All)-1;  %removing zeros from A 
            for ii=1:length(All)
               
             for j=3:length(obj.Date)+2 %finding global cases and deaths
                global_Cases(ii,j-2)=obj.coviddata{ii,j}(1,1);
                global_Deaths(ii,j-2)=obj.coviddata{ii,j}(1,2);
             end
            end
            obj.global_cases=sum(global_Cases); %final global Cases
            obj.global_deaths=sum(global_Deaths); %final global Deaths
         end
       
        
        %%  This function is to select the cases of a particular state or a country from the Cases Matrix as a whole.
        function obj=Cases_Vector(obj,a)
            [m n]=size(obj.Cases_Matrix);
           Cases=zeros(1,length(obj.Date));
            for ii=1:n
                Cases(ii)=obj.Cases_Matrix(a,ii);
            end
       obj=Cases;
       end
        %%  This function is to select the cases of a particular state or a country from the Cases Matrix as a whole.
        function obj=Deaths_Vector(obj,a)
            [m n]=size(obj.Deaths_Matrix);
           Deaths=zeros(1,length(obj.Date));
            for ii=1:n
                Deaths(ii)=obj.Deaths_Matrix(a,ii);
            end
       obj=Deaths;
        end 
    end
    end



        
                
                    

        