function [Priors2, Mu, Sigma] = GMMwithReproject(Data, Data2, nbStates, A)
[nbVar,nbData] = size(Data);
[nbVar2, nbData] = size(Data2);

Data_mean = repmat(mean(Data(2:end, :),2), 1, nbData);

%% Training of GMM by EM algorithm, initialized by k-means clustering.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Priors0, Mu0, Sigma0] = EM_init_kmeans(Data2, nbStates);
[Priors2, Mu2, Sigma2] = EM(Data2, Priors0, Mu0, Sigma0);

%% Re-project the GMM components in the original data space.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Project the centers of the Gaussian distributions, using only the spatial components 

Mu(1,:) = Mu2(1,:);
Mu(2:nbVar,:) = A*Mu2(2:end,:) + Data_mean(:,1:nbStates);
%Project the covariance matrices, using only the spatial components
for i=1:nbStates
  A_tmp = [1 zeros(1,nbVar2-1); zeros(nbVar-1,1) A];
  Sigma(:,:,i) = A_tmp * Sigma2(:,:,i) * A_tmp';
  %Add a tiny variance to avoid numerical instability
  Sigma(:,:,i) = Sigma(:,:,i) + 1E-10.*diag(ones(nbVar,1));
end

%% Plot of the GMM encoding results.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('position',[50,50,1000,400]);
%plot 1D original data space
for n=1:nbVar-1
  subplot(nbVar-1,2,(n-1)*2+1); hold on;
  plotGMM(Mu([1,n+1],:), Sigma([1,n+1],[1,n+1],:), [0 .8 0], 1);
  plot(Data(1,:), Data(n+1,:), 'x', 'markerSize', 3, 'color', [.1 .1 .1]);
  axis([min(Data(1,:)) max(Data(1,:)) min(Data(n+1,:))-0.01 max(Data(n+1,:))+0.01]);
  xlabel('t','fontsize',16); ylabel(['x_' num2str(n)],'fontsize',18);
end
%plot 1D latent space
for n=1:nbVar2-1
  subplot(nbVar-1,2,(n-1)*2+2); hold on;
  plotGMM(Mu2([1,n+1],:), Sigma2([1,n+1],[1,n+1],:), [.8 0 0], 1);
  plot(Data2(1,:), Data2(n+1,:), 'x', 'markerSize', 3, 'color', [.3 .3 .3]);
  axis([min(Data2(1,:)) max(Data2(1,:)) min(Data2(n+1,:))-0.01 max(Data2(n+1,:))+0.01]);
  xlabel('t','fontsize',16); ylabel(['$\xi_' num2str(n) '$'],'fontsize',16, 'Interpreter', 'Latex');
  %xlabel('t','fontsize',16); ylabel(['\xi_' num2str(n)],'fontsize',16);

end
%print('-depsc2','data/GMM-latentSpace-graph01.eps');

