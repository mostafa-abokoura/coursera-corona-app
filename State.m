classdef State < Country
    properties
       % State
       state
    end
    
    methods 
        function obj = State(c)
            obj@Country(c);
            obj.state = string(c{2});
        end
    end
end
            