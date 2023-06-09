%% Initiate conditions
global SETTINGS
%
if ~exist('dyn','var') || dyn.trialNumber == 1
    % esperimentazione        = {'calibration'};
    % esperimentazione     = {'Direct_Sac'};
    % esperimentazione      = {'Delay_Sac'};
    % esperimentazione        = {'Delay diss_saccade'};par_eye
    % esperimentazione        = {'Delay free_gaze'};
    % esperimentazione        = {'Delay free_gaze','rest','Delay free_gaze','rest'};
    esperimentazione        = {'rest'};
    si_counter=0;
    for n_exp = 1:numel(esperimentazione)
        experiment=esperimentazione{n_exp};
        shuffle_conditions                  = 2;
        force_conditions                    = 3;
        task.calibration                    = 0;
        SETTINGS.GUI_in_acquisition         = 0;
        SETTINGS.check_motion_jaw           = 0;
        SETTINGS.check_motion_body          = 0;
        SETTINGS.RewardSound                = 1;
        %         fix_eye_y                           = -2.5;
        %         fix_hnd_y                           = -6.5;
        %         pool_of_angles                      = [40,0,320,220,180,140]; %[20,0,340,200,180,160];
        
        fix_eye_y                           = -8;
        fix_hnd_y                           = -12;
        pool_of_angles                      = [40,0,320,220,180,140]; %[20,0,340,200,180,160];
        %         fix_eye_y                           = -2;
        %         fix_hnd_y                           = -5;
        %         pool_of_angles                      = [20,0,340,160,180,200];
        
        
        task.reward.time_neutral            = [0.25 0.25]; % 0.6s -> 0.2ml per hit
        task.rest_hand                      = [0 0]; % which hands on the sensor to start the trial
        task.check_screen_touching          = 1;
        %% IMPORTANT TO CHECK!!!
        %         if strcmp(experiment,'calibration') || strcmp(experiment,'Baseline stim project direct saccades') || strcmp(experiment,'Baseline stim project memory saccades')
        %             SETTINGS.take_angles_con        = 1;
        %         else
        %             SETTINGS.take_angles_con        = 0;
        %         end
        
        %% Order of fields here defines the order of parameters to be sent to TDT as the trial_classifiers
        All = struct('angle_cases',0,'instructed_choice_con',0,'type_con',0,'effector_con',0,'reach_hand_con',0,'excentricities',0,'stim_con',0,'timing_con',0,'size_con',0,...
            'tar_dis_con',0,'mat_dis_con',0,'cue_pos_con',0,'shape_con',0,'offset_con',0,'invert_con',0,'exact_excentricity_con_x',NaN,'exact_excentricity_con_y',NaN,'reward_con',1,'reward_sound_con',1,'rest_hands_con',1,'var_x',0,'var_y',0);
        
        switch experiment
            
            case 'calibration'
                SETTINGS.GUI_in_acquisition         = 1;
                SETTINGS.take_angles_con            = 1;
                
                N_repetitions                       = 100;
                
                task.calibration                    = 1;
                %task.reward.time_neutral            = [0.1 0.1];
                reward_time                         =  0.1;
                task.rest_hand                      = [0 0];
                All.rest_hands_con                  = 0;
                
                All.offset_con                      = 0;
                All.reach_hand_con                  = 2;
                All.type_con                        = 1;
                All.effector_con                    = 0;
                All.reach_hand_con                  = 2;
                All.timing_con                      = 0;
                All.size_con                        = 0;
                All.instructed_choice_con           = 0;
                All.var_x                           = 0;
                All.var_y                           = 0;
                
                All.excentricities              = 12;
                All.angle_cases                 = [1,2,3,4,5,6];
                
                PEST_ON                             = 0;
                SETTINGS.GUI_in_acquisition         = 1;
                
            case 'rest'
                SETTINGS.take_angles_con            = 1;
                N_repetitions                       = 47; %47 36 %100
                task.rest_hand                      = [0 0];
                
                All.offset_con                      = 0;
                All.reach_hand_con                  = 2;
                All.type_con                        = 1;
                All.effector_con                    = 0;
                All.timing_con                      = 3; % rest
                All.size_con                        = 3; % rest
                All.instructed_choice_con           = 0;
                All.var_x                           = 0;
                All.var_y                           = 0;
                All.reward_con                      = 0;
                All.reward_sound_con                = 0;
                All.rest_hands_con                  = 0;
                
                All.excentricities              = 2;
                All.angle_cases                 = 1;
                
                
            case 'Delay_Sac'
                SETTINGS.take_angles_con            = 1;
                
                N_repetitions                       = 10; % N trials for each condition
                
                All.offset_con                      = 0;
                All.reach_hand_con                  = [0];
                All.type_con                        = 4; % 2 direct  % 3 memory  % 4 delay
                All.effector_con                    = 0; % 0 only eye  % 1 only hand  % 3 dissociated saccade %4 dissociated reach  %6 free gaze reach
                All.timing_con                      = 2; %timing
                All.size_con                        = 2; % target size
                All.instructed_choice_con           = [0];%[0 1]
                All.var_x                           = 0;
                All.var_y                           = 0;
                
                All.excentricities              = [15];
                All.angle_cases                 = [1,2,3,4,5,6];
                
                All.stim_con                        = 0;
                
            case 'Delay free_gaze'
                SETTINGS.VisFeedback_rest_hand = 1;
                task.hnd.ini(1).x = 0;
                task.hnd.ini(2).x = task.hnd.ini(1).x;
                task.hnd.ini(1).y = -12;
                task.hnd.ini(2).y = task.hnd.ini(1).y;
                task.hnd.ini(1).shape = 'square_frame';
                task.hnd.ini(2).shape = 'square';
                
                task.hnd.ini(1).size = 1;
                task.hnd.ini(2).size = task.hnd.ini(1).size;
                task.hnd.ini(1).color = [60 60 60];
                task.hnd.ini(2).color = task.hnd.ini(1).color;
                
                SETTINGS.take_angles_con            = 1;
                SETTINGS.check_motion_jaw           = 0;
                
                N_repetitions                       = 10;%5
                
                
                %task.reward.time_neutral            = [0.24 0.24]; % 0.2s -> 0.2ml per hit
                reward_time                         =  0.24;
                task.rest_hand                      = [1 1]; % which hands on the sensor to start the trial
                
                % All.offset_con                      = [-15 0 15];
                All.offset_con                      = 0;
                All.reach_hand_con                  = [1 2]; % 1 left 2 right hand
                All.type_con                        = 4;
                All.effector_con                    = 6; %6
                
                
                All.timing_con                      = 31;
                All.size_con                        = 2;
                All.instructed_choice_con           = [0 1]; %  0 instr  1 choice
                All.var_x                           = 0;
                All.var_y                           = 0;
                
                All.excentricities              = [15]; % 16
                All.angle_cases                 = [1,2,3,4,5,6]; %1,2,3,4,5,6
                All.stim_con                        = 0;
                
                
            case 'Direct_Sac'
                SETTINGS.take_angles_con            = 1;
                
                N_repetitions                       = 10; % N trials for each condition
                
                %task.reward.time_neutral            = [0.2 0.2]; % 0.6s -> 0.2ml per hit
                reward_time                         =  0.2;
                task.rest_hand                      = [0 0];
                
                All.offset_con                      = 0;
                All.reach_hand_con                  = [0];
                All.type_con                        = 2;
                All.effector_con                    = 0; % 3 4 6
                All.timing_con                      = 1; %timing
                All.size_con                        = 1; % target size
                All.instructed_choice_con           = [0];
                All.var_x                           = 0;
                All.var_y                           = 0;
                
                
                All.excentricities              = [12];
                All.angle_cases                 = [1,2,3];
                All.stim_con                        = 0;
                
                
            case 'Delay diss_saccade'
                SETTINGS.take_angles_con            = 1;
                N_repetitions                       = 10;
                %task.reward.time_neutral            = [0.2 0.2]; % 0.6s -> 0.2ml per hit
                reward_time                         =  0.2;
                task.rest_hand                      = [1 1];
                
                All.offset_con                      = 0;
                All.reach_hand_con                  = [1 2];
                All.type_con                        = 4;
                All.effector_con                    = 3;
                All.timing_con                      = 31;  % 31 or 33
                All.size_con                        = 20;
                All.instructed_choice_con           = [0 1];
                All.var_x                           = 0;
                All.var_y                           = 0;
                
                All.excentricities              = [15]; % 16
                All.angle_cases                 = [1,2,3,4,5,6];
                All.stim_con                        = 0;
        end
        
        all_fieldnames=fieldnames(All);
        N_total_conditions       =1;
        sequence_cell            ={};
        for FN=1:numel(all_fieldnames)
            N_total_conditions=N_total_conditions*numel(All.(all_fieldnames{FN}));
            sequence_cell=[sequence_cell, {All.(all_fieldnames{FN})}];
        end
        
        sequence_matrix_exp_temp          = repmat(combvec(sequence_cell{:}),1,N_repetitions);
        
        
        idx_var_x=find(ismember(all_fieldnames,'var_x'));
        idx_var_y=find(ismember(all_fieldnames,'var_y'));
        
        sequence_matrix_exp{n_exp}          = sequence_matrix_exp_temp;
        ordered_sequence_indexes_exp{n_exp} = (1:N_total_conditions*N_repetitions) + si_counter;
        si_counter                          = numel(ordered_sequence_indexes_exp{n_exp}) +si_counter;
    end
    
    
    sequence_matrix          = [sequence_matrix_exp{:}];
    idx_exact_x=ismember(all_fieldnames,'exact_excentricity_con_x');
    idx_exact_y=ismember(all_fieldnames,'exact_excentricity_con_y');
    conditions_to_remove=(sequence_matrix(idx_exact_y,:)==0 & sequence_matrix(idx_exact_x,:)==0);
    sequence_matrix(:,conditions_to_remove)=[];
    ordered_sequence_indexes = 1:(numel([ordered_sequence_indexes_exp{:}])-sum(conditions_to_remove));
end




%% Shuffling conditions
if ~exist('dyn','var') || (dyn.trialNumber == 1 && shuffle_conditions==0)
    sequence_indexes = ordered_sequence_indexes;
    shuffled_sequence_indexes_exp=ordered_sequence_indexes_exp;
elseif dyn.trialNumber == 1 && (shuffle_conditions==1)
    sequence_indexes = Shuffle(ordered_sequence_indexes);
    shuffled_sequence_indexes_exp=ordered_sequence_indexes_exp;
elseif dyn.trialNumber == 1 && (shuffle_conditions==2) %% shuffling within experiment (for blocked designs!)
    
    shuffled_sequence_indexes_exp = cellfun(@Shuffle,ordered_sequence_indexes_exp,'UniformOutput',false);
    sequence_indexes = [shuffled_sequence_indexes_exp{:}];
end
if exist('dyn','var') && dyn.trialNumber > 1,
    if force_conditions==1
        if sum([trial.success])==length(sequence_indexes),
            dyn.state = STATE.CLOSE; return
        else
            custom_trial_condition = sequence_indexes(sum([trial.success])+1);
        end
        
    elseif force_conditions==2 % semi-forced: if trial is unsuccessful, the condition is put back into the pool
        if trial(end-1).success==1
            sequence_indexes=sequence_indexes(2:end);
        else
            sequence_indexes=Shuffle(sequence_indexes);
        end
        if numel(sequence_indexes)==0
            dyn.state = STATE.CLOSE; return
        else
            custom_trial_condition = sequence_indexes(1);
        end
    elseif force_conditions==3  %% semi-forced, but keeping blocks
        if trial(end-1).success==1
            if isempty(shuffled_sequence_indexes_exp{1}) && numel(shuffled_sequence_indexes_exp)>1
                shuffled_sequence_indexes_exp=shuffled_sequence_indexes_exp(2:end);
            end
            shuffled_sequence_indexes_exp{1}(1)=[];
        else
            shuffled_sequence_indexes_exp = cellfun(@Shuffle,shuffled_sequence_indexes_exp,'UniformOutput',false);
        end
        sequence_indexes = [shuffled_sequence_indexes_exp{:}];
        if numel(sequence_indexes)==0
            dyn.state = STATE.CLOSE; return
        else
            custom_trial_condition = sequence_indexes(1);
        end
    else
        if numel(trial)-1==length(sequence_indexes),
            dyn.state = STATE.CLOSE; return
        else
            custom_trial_condition = sequence_indexes(numel(trial));
        end
    end
else
    custom_trial_condition = sequence_indexes(1);
    
    
    
    
    %     %% bar plot for conditions
    %
    % conditions_to_plot=1:6;
    %
    % sequence_matrix_inverted=sequence_matrix';
    % unique_sequence=unique(sequence_matrix_inverted(:,conditions_to_plot),'rows');
    % current_con_index=find(ismember(unique_sequence,sequence_matrix_inverted(sequence_indexes(1),conditions_to_plot),'rows'));
    % experiment_fieldnames=all_fieldnames(conditions_to_plot);
    %
    % cond=1:6;
    %
    % idx_con=ismember(cond,current_con_index);
    % if dyn.trialNumber==1
    %     hist_cond=[0 0 0 0 0 0];
    % else
    %     hist_cond=hist_cond+idx_con;
    % end
    %
    % figure
    % bar(1:6, hist_cond)
    % % for n=1:numel(experiment_fieldnames)
    % %     FN=experiment_fieldnames{n};
    % %    All_experiment.(FN) = unique(unique_sequence(:,n));
    % % end
    
    
    
    
end

%dyn.trial_classifier(1)=numel(All.tar_pos_con);
for field_index=1:numel(all_fieldnames)
    Current_con.(all_fieldnames{field_index})=sequence_matrix(field_index,custom_trial_condition);
    dyn.trial_classifier(field_index) = abs(round(Current_con.(all_fieldnames{field_index})));
end


%% Fixation offset
fix_eye_x             = Current_con.offset_con;
fix_hnd_x             = fix_eye_x;

%% CHOICE\INSTRUCTED
task.choice                 = Current_con.instructed_choice_con;

%% TYPE
task.type                   = Current_con.type_con;

%% EFFECTOR
task.effector               = Current_con.effector_con;

%% REACH hand
task.reach_hand             = Current_con.reach_hand_con;

%% reward
if Current_con.reward_con==0
    task.reward.time_neutral            = [0 0];
elseif Current_con.reward_con==1
    task.reward.time_neutral            = [reward_time reward_time];
end
if Current_con.reward_sound_con==0
    SETTINGS.RewardSound                = 0;
elseif Current_con.reward_sound_con==1
    SETTINGS.RewardSound                = 1;
end
if Current_con.rest_hands_con==0
    task.rest_hand                      = [0 0];
elseif Current_con.rest_hands_con==1
    task.rest_hand                      = [1 1];
end


%% TIMING
switch Current_con.timing_con
    case 0 % 'calibration'
        task.rest_sensors_ini_time              = 0.5; % s, time to hold sensor(s) in initialize_trial before trial starts
        
        task.timing.wait_for_reward             = 0.2;
        task.timing.ITI_success                 = 1;
        task.timing.ITI_success_var             = 0;
        task.timing.ITI_fail                    = 1;
        task.timing.ITI_fail_var                = 0;
        task.timing.grace_time_eye              = 0;
        task.timing.grace_time_hand             = 0;
        task.timing.fix_time_to_acquire_hnd     = 1; %1
        task.timing.tar_time_to_acquire_hnd     = 1.5; % 1.5
        task.timing.tar_inv_time_to_acquire_hnd = 1;
        task.timing.fix_time_to_acquire_eye     = 0.5;
        task.timing.tar_time_to_acquire_eye     = 0.5;
        task.timing.tar_inv_time_to_acquire_eye = 0.5;
        task.timing.fix_time_hold               = 0.8;
        task.timing.fix_time_hold_var           = 0.2;
        task.timing.cue_time_hold               = 0.5;
        task.timing.cue_time_hold_var           = 0;
        task.timing.mem_time_hold               = 0;
        task.timing.mem_time_hold_var           = 0;
        task.timing.del_time_hold               = 0;
        task.timing.del_time_hold_var           = 0;
        task.timing.tar_inv_time_hold           = 0;
        task.timing.tar_inv_time_hold_var       = 0;
        task.timing.tar_time_hold               = 0.5;
        task.timing.tar_time_hold_var           = 0;
        
    case 1 %'direct'
        task.rest_sensors_ini_time              = 0.5; % s, time to hold sensor(s) in initialize_trial before trial starts
        task.timing.wait_for_reward             = 0.3;
        task.timing.ITI_success                 = 2; % 3 inter trial interval
        task.timing.ITI_success_var             = 0;
        task.timing.ITI_fail                    = 3; % 3 inter trial interval
        task.timing.ITI_fail_var                = 0;
        task.timing.grace_time_eye              = 0;
        task.timing.grace_time_hand             = 0;
        task.timing.fix_time_to_acquire_hnd     = 1.5;
        task.timing.tar_time_to_acquire_hnd     = 0.7;
        task.timing.tar_inv_time_to_acquire_hnd = 2;
        task.timing.fix_time_to_acquire_eye     = 0.7;
        task.timing.tar_time_to_acquire_eye     = 0.5;
        task.timing.tar_inv_time_to_acquire_eye = 0.5; %3
        task.timing.fix_time_hold               = 0.8; % 0.5
        task.timing.fix_time_hold_var           = 0.5; % 0
        task.timing.cue_time_hold               = 0.300; % 0.28
        task.timing.cue_time_hold_var           = 0; % 0
        task.timing.mem_time_hold               = 1;
        task.timing.mem_time_hold_var           = 0;
        task.timing.del_time_hold               = 0.7; % 1
        task.timing.del_time_hold_var           = 0.5; % 0
        task.timing.tar_inv_time_hold           = 0.2;
        task.timing.tar_inv_time_hold_var       = 0.0;
        task.timing.tar_time_hold               = 0.5;
        task.timing.tar_time_hold_var           = 0.0;
        
    case 2 %'delay'
        task.rest_sensors_ini_time              = 0.5; % s, time to hold sensor(s) in initialize_trial before trial starts
        task.timing.wait_for_reward             = 0.3;
        task.timing.ITI_success                 = 3; % 2 inter trial interval
        task.timing.ITI_success_var             = 0;
        task.timing.ITI_fail                    = 4; % 3 inter trial interval
        task.timing.ITI_fail_var                = 0;
        task.timing.grace_time_eye              = 0;
        task.timing.grace_time_hand             = 0;
        task.timing.fix_time_to_acquire_hnd     = 1.5;
        task.timing.tar_time_to_acquire_hnd     = 0.7;
        task.timing.tar_inv_time_to_acquire_hnd = 2;
        task.timing.fix_time_to_acquire_eye     = 1.5;
        task.timing.tar_time_to_acquire_eye     = 0.8;
        task.timing.tar_inv_time_to_acquire_eye = 0.5; %3
        task.timing.fix_time_hold               = 0.4; % 0.5
        task.timing.fix_time_hold_var           = 0; % 0
        task.timing.cue_time_hold               = 0.300; % 0.28
        task.timing.cue_time_hold_var           = 0.1; % 0
        task.timing.mem_time_hold               = 1;
        task.timing.mem_time_hold_var           = 0;
        task.timing.del_time_hold               = 0.5; % 1
        task.timing.del_time_hold_var           = 0.2; % 0
        task.timing.tar_inv_time_hold           = 0.2;
        task.timing.tar_inv_time_hold_var       = 0.0;
        task.timing.tar_time_hold               = 0.100;
        task.timing.tar_time_hold_var           = 0.0;
        
    case 3 %'rest'
        task.rest_sensors_ini_time              = 0.5; % s, time to hold sensor(s) in initialize_trial before trial starts
        task.timing.wait_for_reward             = 0.3;
        task.timing.ITI_success                 = 1; % 2 inter trial interval
        task.timing.ITI_success_var             = 0;
        task.timing.ITI_fail                    = 1; % 3 inter trial interval
        task.timing.ITI_fail_var                = 0;
        task.timing.fix_time_to_acquire_eye     = 1.5;
        task.timing.fix_time_hold               = 10; % 300
        task.timing.fix_time_hold_var           = 0; % 0
        
    case 31 %'memory ephys'  'Delay'
        
        task.rest_sensors_ini_time              = 0.5; % s, time to hold sensor(s) in initialize_trial before trial starts
        task.timing.wait_for_reward             = 0.3;
        task.timing.ITI_success                 = 2; % 3 inter trial interval
        task.timing.ITI_success_var             = 0;
        task.timing.ITI_fail                    = 3; % 3 inter trial interval
        task.timing.ITI_fail_var                = 0;
        task.timing.grace_time_eye              = 0;
        task.timing.grace_time_hand             = 0;
        task.timing.fix_time_to_acquire_hnd     = 1.5;%1.5
        task.timing.tar_time_to_acquire_hnd     = 0.8; %0.8
        task.timing.tar_inv_time_to_acquire_hnd = 2;
        task.timing.fix_time_to_acquire_eye     = 1;%0.5
        task.timing.tar_time_to_acquire_eye     = 1;%0.5
        task.timing.tar_inv_time_to_acquire_eye = 0.5; %3
        task.timing.fix_time_hold               = 0.5; % 0.5
        task.timing.fix_time_hold_var           = 0.1; % 0.5
        task.timing.cue_time_hold               = 0.3; % 0.28
        task.timing.cue_time_hold_var           = 0; % 0
        task.timing.mem_time_hold               = 1;
        task.timing.mem_time_hold_var           = 0;
        task.timing.del_time_hold               = 0.5; % 1
        task.timing.del_time_hold_var           = 0.1; % 0.5
        task.timing.tar_inv_time_hold           = 0.2;
        task.timing.tar_inv_time_hold_var       = 0.0;
        task.timing.tar_time_hold               = 0.25;
        task.timing.tar_time_hold_var           = 0.0;
end

%% RADIUS & SIZES
switch Current_con.size_con
    case 0 %'calibration'
        task.eye.fix.size       = 1;
        task.eye.fix.radius     = 55;
        task.eye.tar(1).size    = 1;
        task.eye.tar(1).radius  = 55;
        
        task.hnd.fix.radius     = 4;
        task.hnd.fix.size       = 4;
        task.hnd.tar(1).size    = 4;
        task.hnd.tar(1).radius  = 4;
    case 1 %'direct'
        task.eye.fix.size       = 2;
        task.eye.fix.radius     = 7;
        task.eye.tar(1).size    = 2;
        task.eye.tar(1).radius  = 10;
        
        task.hnd.fix.radius     = 4;
        task.hnd.fix.size       = 4;
        task.hnd.tar(1).size    = 4;
        task.hnd.tar(1).radius  = 4;
        
    case 2 %'delay'
        task.eye.fix.size       = 1;
        task.eye.fix.radius     = 11;
        task.eye.tar(1).size    = 3;
        task.eye.tar(1).radius  = 7;
        
        task.hnd.fix.radius     = 8; %8
        task.hnd.fix.size       = 4; %4
        task.hnd.tar(1).size    = 4;
        task.hnd.tar(1).radius  = 8;
        
    case 3 %'rest'
        task.eye.fix.size       = 0;
        task.eye.fix.radius     = 300;
        task.eye.tar(1).size    = 0;
        task.eye.tar(1).radius  = 300;
        
        task.hnd.fix.radius     = 0;
        task.hnd.fix.size       = 0;
        task.hnd.tar(1).size    = 0;
        task.hnd.tar(1).radius  = 0;
        
end

task.eye.tar(2).size    = task.eye.tar(1).size;
task.hnd.tar(2).size    = task.hnd.tar(1).size ; % deg
task.eye.tar(2).radius  = task.eye.tar(1).radius;
task.hnd.tar(2).radius  = task.hnd.tar(1).radius; % deg

%% POSITIONS

if SETTINGS.take_angles_con
    current_angle=pool_of_angles(Current_con.angle_cases); %
    tar_dis_x   = Current_con.excentricities*cos(current_angle*2*pi/360);
    tar_dis_y   = Current_con.excentricities*sin(current_angle*2*pi/360);
else
    tar_dis_x   = Current_con.exact_excentricity_con_x;
    tar_dis_y   = Current_con.exact_excentricity_con_y;
end

tar_dis_1x = + tar_dis_x + Current_con.var_x;
tar_dis_1y = + tar_dis_y + Current_con.var_y;
tar_dis_2x = - tar_dis_x + Current_con.var_x;  %%%%% CHANGE HERE TO (-) FOR SYMETRIC CONTRACTION EXPANSION OR (+) FOR SYMETRIC LEFT RIGHT
tar_dis_2y = + tar_dis_y + Current_con.var_y;


if task.type==1
    
    task.eye.fix.x    = fix_eye_x  + tar_dis_1x;
    task.eye.fix.y    = fix_eye_y  + tar_dis_1y;
    task.hnd.fix.x    = fix_hnd_x  + tar_dis_1x;
    task.hnd.fix.y    = fix_hnd_y  + tar_dis_1y;
else
    
    task.eye.fix.x    = fix_eye_x;
    task.eye.fix.y    = fix_eye_y;
    task.hnd.fix.x    = fix_hnd_x;
    task.hnd.fix.y    = fix_hnd_y;
end

if task.effector==3
    
    task.eye.tar(1).x = fix_eye_x  + tar_dis_1x;
    task.eye.tar(1).y = fix_eye_y  + tar_dis_1y;
    task.eye.tar(2).x = fix_eye_x  + tar_dis_2x;
    task.eye.tar(2).y = fix_eye_y  + tar_dis_2y;
    
    task.hnd.tar(1).x = fix_hnd_x;
    task.hnd.tar(1).y = fix_hnd_y;
    task.hnd.tar(2).x = fix_hnd_x;
    task.hnd.tar(2).y = fix_hnd_y;
elseif task.effector==4 || task.effector==6
    
    task.eye.tar(1).x = fix_eye_x;
    task.eye.tar(1).y = fix_eye_y;
    task.eye.tar(2).x = fix_eye_x;
    task.eye.tar(2).y = fix_eye_y;
    
    task.hnd.tar(1).x = fix_hnd_x  + tar_dis_1x;
    task.hnd.tar(1).y = fix_hnd_y  + tar_dis_1y;
    task.hnd.tar(2).x = fix_hnd_x  + tar_dis_2x;
    task.hnd.tar(2).y = fix_hnd_y  + tar_dis_2y;
else
    
    task.eye.tar(1).x = fix_eye_x  + tar_dis_1x;
    task.eye.tar(1).y = fix_eye_y  + tar_dis_1y;
    task.eye.tar(2).x = fix_eye_x  + tar_dis_2x;
    task.eye.tar(2).y = fix_eye_y  + tar_dis_2y;
    
    task.hnd.tar(1).x = fix_hnd_x  + tar_dis_1x;
    task.hnd.tar(1).y = fix_hnd_y  + tar_dis_1y;
    task.hnd.tar(2).x = fix_hnd_x  + tar_dis_2x;
    task.hnd.tar(2).y = fix_hnd_y  + tar_dis_2y;
end

%% COLORS
task.eye.fix.color_dim          = [128 0 0]; %
task.eye.fix.color_bright       = [255 0 0];
task.eye.tar(1).color_dim       = [128 0 0];  % 2.5 or 3
task.eye.tar(1).color_bright    = [255 0 0];
task.eye.tar(2).color_dim       = [128 0 0]; %  % 2.5 or 3
task.eye.tar(2).color_bright    = [255 0 0];

task.hnd_right.color_dim        = [0 128 0]; %[0 128 0]
task.hnd_right.color_bright     = [0 255 0]; %[0 255 0]
task.hnd_right.color_cue_dim    = [0 128 0];
task.hnd_right.color_cue_bright = [0 255 0];
task.hnd_left.color_dim         = [39 109 216]; %
task.hnd_left.color_bright      = [119 230 253];
task.hnd_left.color_cue_dim     = [39 109 216];
task.hnd_left.color_cue_bright  = [119 230 253];
task.hnd_stay.color_dim         = [128 129 0];
task.hnd_stay.color_bright      = [255 255 0];

%% CUE assignment (Positions and colors !)
task.eye.cue                                        = task.eye.tar;
task.hnd.cue                                        = task.hnd.tar;
%
% switch Current_con.cue_pos_con
%     case 1
%         task.cue_pos                                = {[-ex_cue,fix_height],[ex_cue,fix_height]};
%     case 2
%         task.cue_pos                                = {[ex_cue,fix_height],[-ex_cue,fix_height]};
% end

if task.effector==0 || task.effector==1 || task.effector==2
    task.eye.cue(1).color_dim                       = [128 0 0];
    task.eye.cue(1).color_bright                    = [255 0 0];
    task.eye.cue(2).color_dim                       = [128 0 0];
    task.eye.cue(2).color_bright                    = [255 0 0];
end


