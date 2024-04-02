% Step 2: All HRTFs against others - Done on remote desktop. Subjects 96
% and 88 should be removed before comparing all HRTFs against each other.
% Subject 1 is also removed to be used as test data.

% Sound Field Synthesis Toolbox settings
%p = parpool(10);


parfor o = 83:95
    err_row = zeros(1,93);
    amt_start;
    
    if o ~= 88
        for t = 2:95            
            if t < 88
                hrtfo = SOFAload("C:\Users\simon\OneDrive\Documents\Senior Thesis\Code\Datasets\HUTUBS\simu\pp"+o+"_HRIRs_simulated.sofa");
                hrtft = SOFAload("C:\Users\simon\OneDrive\Documents\Senior Thesis\Code\Datasets\HUTUBS\simu\pp"+t+"_HRIRs_simulated.sofa");
                err_row(t-1) = HRTF_err_comp2(hrtfo, hrtft);

            elseif t > 88
                hrtfo = SOFAload("C:\Users\simon\OneDrive\Documents\Senior Thesis\Code\Datasets\HUTUBS\simu\pp"+o+"_HRIRs_simulated.sofa");
                hrtft = SOFAload("C:\Users\simon\OneDrive\Documents\Senior Thesis\Code\Datasets\HUTUBS\simu\pp"+t+"_HRIRs_simulated.sofa");               
                err_row(t-2) = HRTF_err_comp2(hrtfo, hrtft);

            end
        end

        fn = "C:\Users\simon\OneDrive\Documents\Senior Thesis\Code\Datasets\HUTUBS\simu\Err_rows\" + o + ".txt"
        writematrix(err_row, fn,'Delimiter','tab')
    end


end