function [x,t] = synthesize_sin(frequencyVec,complxAmps,samplingRate,duration,start_time)
    if nargin < 5           % If user does not pass 5th argument (start_time), assume it 0.
        start_time = 0;
    end
    
    N = length(frequencyVec);
    
    if N ~= length(complxAmps)
        % LateX Interpreter to show custom dialog box
        CreateStruct.Interpreter = 'tex';
        CreateStruct.WindowStyle = 'modal';
        msgHandle = msgbox('\fontsize{14} Error! Dimensions of frequencies vector (1st arg) and complex amplitudes vector (2nd arg) must be the same.','ERROR','Error', CreateStruct);
        fontHandle = findall(msgHandle,'Type','Text');
        set(fontHandle, 'FontName', 'Calibri');
        uiwait(msgHandle)       % Pause before displaying next dialog box
        msgbox('\fontsize{13} Try Again With equal frequency f and Amplitudes A args','Solution','help',CreateStruct);
        x=0;
        t=0;
    else
          t = start_time:1/(samplingRate):duration;     % Set given sample rate (sampels per period)
          fourierSum=zeros(N,length(t));                % Initialize sum to 0s matrix
          for a = 1:N
              fourierSum(a,:) = real(complxAmps(a)*exp(1j*2*pi*frequencyVec(a)*t)); % Assign one cosine component at each index
              fourierSum(1,:) = fourierSum(1,:)+fourierSum(a,:);                    % Add sum to the first index
          end
          x = fourierSum(1,:);
          plot(t,x,'r')
          title('\fontsize{15} Fourier Synthesis of Complex Exponentials')
          xlabel('\fontsize{17} time(s)')
          ylabel('\fontsize{17} Real( \Sigma X_{k}e^{\it j2\bf\pi f_{k}t} ) ')      % LateX scripting for Math Symbols Display
          grid on  
    end
end