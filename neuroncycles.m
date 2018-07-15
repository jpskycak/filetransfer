%% Parameters %%
N = 10; % cycle size
R = 5; % refractory period
tmax = 1000; % simulation length
rho = 25; % stimulus period
lambda = 0.0001; % weight decay
gamma = 0.05; % learning rate

%% Initialize %%
W = exp(1)*ones(1,N); % weight vector
S = 10000*ones(1,N); % last-spike vector
A = zeros(1,N); % activity vector
plotW = [];

figure
% subplot(2,2,1)
% bar(log(W));
% title('Current Weights');
% xlabel('ith neuron');
% ylabel('log(weight i)');

% subplot(2,2,2)
plotW = [plotW; W exp(1)];
for i=1:N+1
  plot(log(plotW(:,i)));
  hold on
end
plot(log(plotW(:,N)),'r');
hold on
plot(log(plotW(:,N+1)),'k');
hold on
title('Weights over Time');
xlabel('timestep');
ylabel('log(weight i)');

% subplot(2,2,3)
% bar(A);
% title('Activity');
% xlabel('ith neuron');
% ylabel('activity');

% subplot(2,2,4)
% bar(S);
% axis([0 N+1 0 R+rho]);
% title('Last Spike Time');
% xlabel('ith neuron');
% ylabel('timesteps');

%% Simulate %%
for t = 0:tmax-1
 
  %% increment S
  S = S + 1;

  %% updates
  Anew = zeros(1,N);
  Snew = S;
  for i = 1:N
    nextNeuron = i+1;
    if nextNeuron > N
        nextNeuron = 1;
    end
    priorNeuron = i-1;
    if priorNeuron < 1
        priorNeuron = N;
    end
    if A(i) == 1 % if i is active
      Snew(i) = 0; % i spikes
      W(priorNeuron) = W(priorNeuron) * (1 + gamma*exp(-S(priorNeuron)/N) ); % STDP: increase due to prediction
      W(i) = W(i) * (1 - gamma*exp(-S(nextNeuron)/N) ); % STDP: decrease due to nonprediction
      if W(i) > 0 && S(nextNeuron) >= R % if i's forward connection exists and the next neuron is not in its refractory period
        Anew(nextNeuron) = 1; % the next neuron becomes active
      end
    end
  end
        
  A = Anew;
  S = Snew;
 
  %% stimulate the first neuron
  if mod(t,rho) == 0 && S(1) >= R
    A(1) = 1;
  end
 
  %% weight decay
  for i = 1:N
    if W(i) > 0 % if connection exists
      W(i) = W(i) - lambda * W(i)^2; % decay weight
      if W(i) < 0.001 % if connection is small
        W(i) = 0; % break weight
      end
    end
  end
  
%   subplot(2,2,1)
%   bar(log(W));
%   title('Current Weights');
%   xlabel('ith neuron');
%   ylabel('log(weight i)');

%   subplot(2,2,2)
  plotW = [plotW; W exp(1)];
  for i=1:N-1
    plot(log(plotW(:,i)));
    hold on
  end
  plot(log(plotW(:,N)),'r');
  hold on
  plot(log(plotW(:,N+1)),'k');
  hold on
  title('Weights over Time');
  xlabel('timestep');
  ylabel('log(weight i)');

%   subplot(2,2,3)
%   bar(A);
%   title('Activity');
%   xlabel('ith neuron');
%   ylabel('activity');
  
%   subplot(2,2,4)
%   bar(S);
%   axis([0 N+1 0 R+rho]);
%   title('Last Spike Time');
%   xlabel('ith neuron');
%   ylabel('timesteps');
  
  pause(.01)
end