classdef RoboBug < handle
    properties(SetAccess=public)
        URL = ''
    end
    properties(SetAccess=private)
        ID % ID of the robobug
        Speed=0 % Last known speed
        Distance=0 % Last known distance
        DrvFact=0.5
        StopDist=3.5
        AutomaticMode=0
        RequestID=0 
        Sensors = [0 0 0 0 0]
    end
    properties(SetAccess=private, Hidden)
        Client % WSClient instance
    end
    
    methods

        function obj = RoboBug(addr)
            
            base_url = ['ws://' addr ':8888/w/'];
            obj.URL = base_url;
            obj.ID = base_url(length(base_url)-8);
            decoder = @(raw) obj.decode(raw);
            obj.Client = WSClient(base_url, 'Decoder', decoder);
        end

        function connect(obj)
            obj.Client.connect();
            if isequal(obj.Client.getState(), 'OPEN')
               disp('Connection established.');
            end
        end
        
        function close(obj)
            obj.Client.close();
        end
        
        function index = whoami(obj)
            index = obj.ID;
            disp(obj.Client.Server);
        end
        
        function speed = getSpeed(obj)
            % Returns the bug's last set speed
            
            speed = obj.Speed;
        end
        
        function setSpeed(obj, speed)
            % Sets the bug's speed as an integer from 0 to 255
            
            assert(isequal(obj.Client.getState(), 'OPEN'), 'Client is not connected.');
            
            %speed = min(max(0, round(speed)), 255);
            msg = sprintf('{"speed":%d, "maxSpeed":255}', ...
                speed);
            obj.Client.sendRaw(msg);
            obj.Speed = speed;
        end
        
        function setDrvFact(obj, drvFact)
            assert(isequal(obj.Client.getState(), 'OPEN'), 'Client is not connected.');
            msg = sprintf('{"drvFact":%0.2f}',drvFact);
            obj.Client.sendRaw(msg);
            obj.DrvFact = drvFact;
        end
        
        function setAuto(obj, auto)
            
            assert(isequal(obj.Client.getState(), 'OPEN'), 'Client is not connected.');
            msg = sprintf('{"auto":%d}',auto);
            obj.Client.sendRaw(msg);
            obj.AutomaticMode = auto;
        end
        
        function setStopDist(obj, stopDist)
            
            assert(isequal(obj.Client.getState(), 'OPEN'), 'Client is not connected.');
            msg = sprintf('{"stopDist":%0.2f}',stopDist+0.01);
            obj.Client.sendRaw(msg);
            obj.StopDist = stopDist;
        end
        
        function distance = getDistance(obj)
            % Reads the distance from the object in front of us

            assert(isequal(obj.Client.getState(), 'OPEN'), 'Client is not connected.');
            
            % ask for distance measurements (the decode() method will
            % decode the reply and update the Distance property)
            obj.Client.sendRaw('{"reqId": 1}');
            pause(0.01); % wait for the reply
            
            distance = obj.Distance;
        end
        
        function s = getSensors(obj)
            % Reads the distance from the object in front of us

            assert(isequal(obj.Client.getState(), 'OPEN'), 'Client is not connected.');
            
            % ask for distance measurements (the decode() method will
            % decode the reply and update the Distance property)
            obj.Client.sendRaw('{"reqId": 1}');
            pause(0.01); % wait for the reply
            

            s = obj.Sensors;
        end
        
        function stop(obj)
            % Stops the robobug
            
            assert(isequal(obj.Client.getState(), 'OPEN'), 'Client is not connected.');
            
            obj.setSpeed(0);
        end
    end
    
    methods (Access = private)
        
        function [distance,s1,s2,s3,s4,s5] = decode(obj, raw)
            % Takes JSON, returns distance
            
            distance = -1;
            pattern = '"([\w_])+":[ ]*(-?\d+\.?\d*)[,"\}]?';
            r = regexp(raw, pattern, 'tokens');
            for i = 1:length(r)
                id = r{i}{1};
                value = r{i}{2};
                if isequal(id, 'distance')
                    distance = str2double(value);
                end
                if isequal(id, 'S1')
                    s1 = str2double(value);
                end
                if isequal(id, 'S2')
                    s2 = str2double(value);
                end
                if isequal(id, 'S3')
                    s3 = str2double(value);
                end
                if isequal(id, 'S4')
                    s4 = str2double(value);
                end
                if isequal(id, 'S5')
                    s5 = str2double(value);
                end
            end
            obj.Distance = distance;
            obj.Sensors = [s1 s2 s3 s4 s5]; 
        end
        
    end
    
end
