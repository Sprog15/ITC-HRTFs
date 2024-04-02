function [rmu] = HRTF_err_comp2(sub,test)
% Uses functions from the Wierstorf localisation model to calcualte the
% localisation error for a listener (hrtfo) when another person's HRTF is
% used (hrtft)
%   Detailed explanation goes here

conf = SFS_config;
conf.N = 4096;

% load lookup table
lookup = itd2angle_lookuptable(sub);

x0 = SOFAcalculateAPV(sub);
% generate noise signal
fs = test.Data.SamplingRate;
sig_noise = noise(round(fs/5),1,'white');
% azimuth angles
phi = -60:10:60;
phi_auditory_event = zeros(1,length(phi));
phi_sound_event = zeros(1,length(phi));

for ii=1:length(phi)
    % generate noise coming from the given direction
    ir = get_ir(test,[0 0 0],[0 0],[rad(phi(ii)) 0 x0(ii,3)], ...
                'spherical',conf);
    sig = auralize_ir(ir,sig_noise,1,conf);
    phi_auditory_event(ii) = wierstorf2013_estimateazimuth(sig,lookup,'dietz2011');
    phi_sound_event(ii) = phi(ii);
end

ownerr = phi_auditory_event - phi_sound_event;
rmu = rms(ownerr);

end