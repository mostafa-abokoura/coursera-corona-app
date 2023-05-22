classdef Country < handle
    properties
       % Country Casses Data
       casses_mat
       casses
       dly_casses
       
       % Country Deaths Data
       deaths_mat
       deaths
       dly_deaths
       
       % Returned organised data
       country 
    end
    properties (Access = private)
       % State & regions objects
       state_obj = State.empty(1, 0)
    end
    
    methods
        function obj = Country(c)
            obj.country = string(c{1});
            tmp = cell2mat(c(1, 3:end));
            
            obj.casses_mat = tmp(1:2:end);
            obj.casses = obj.casses_mat(end);
            obj.dly_casses = obj.daily(obj.casses_mat);
            
            obj.deaths_mat = tmp(2:2:end);
            obj.deaths = obj.deaths_mat(end);
            obj.dly_deaths = obj.daily(obj.deaths_mat);
        end
        
        function [avr_casses, avr_deaths] = Avr_Casses_Deaths(obj, n, type)
            if string(type) == "Daily"
                used_casses_mat = obj.dly_casses;
                used_deaths_mat = obj.dly_deaths;
            else
                used_casses_mat = obj.casses_mat;
                used_deaths_mat = obj.deaths_mat;
            end
            
            avr_casses = zeros(size(used_casses_mat(n:end)));
            avr_deaths = zeros(size(used_deaths_mat(n:end)));
            for i = n:size(used_casses_mat, 2)
                avr_casses(i-n+1) = sum(used_casses_mat(i-n+1:i))./n;
                avr_deaths(i-n+1) = sum(used_deaths_mat(i-n+1:i))./n;
            end
        end 
        
        function set_state_obj(obj, o)
            obj.state_obj = o;
        end
        
        function States = get_state_obj(obj)
            States = obj.state_obj;
        end
    end
    
    methods (Static)
        function dl = daily(mat)
            dl = mat;
            for i = 2:length(mat)
                dl(i) = abs(mat(i) - mat(i-1));
            end
        end
    end
end
 
            
            
            
            
            
            
       