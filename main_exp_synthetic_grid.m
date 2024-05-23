clear;close all;clc
count_eps = 1;
count_delta = 1;
for i_eps =  [1e-6 1e-5 1e-4 1e-3 1e-2 1e-1]%logspace(-6,-1,10)%
    for j_delta = [1e-6 1e-5 1e-4 1e-3 1e-2 1e-1]%logspace(-6,-1,10) %
        %%%code for i_eps and j_delta
        D = diag([1 j_delta 1 j_delta 1 j_delta]);
        Wtrue(:,1) = [0.8 0.1 0.1];
        Wtrue(:,2) = [0.1 0.8 0.1];
        Wtrue(:,3) = [0.1 0.1 0.8];
        Htrue = [1-i_eps 1-i_eps i_eps i_eps i_eps i_eps; i_eps i_eps 1-i_eps 1-i_eps i_eps i_eps; i_eps i_eps i_eps i_eps 1-i_eps 1-i_eps];

        Mtrue = Wtrue*Htrue;
        Mfog = Mtrue*D;

        [m,r] = size(Wtrue);
        [m,n] = size(Mfog);

        flag = true;
        while flag
            [Wini, Hini] = iniWH(Mfog,r,n); % inizialization
            Fini         = squared_chord_matrices(Mfog,Wini*Hini); % initial object value
            Iter         = 1e4;   % max iteration %-->change the number of iteration
            %% Run Methods
            %Fro
            [Wfro,Hfro] = FroNMF(Mfog,r);

            %RE:=RMU_EPG
            o.algoH = 'RMU';
            o.algoW = 'EPG';
            [Wre,Hre,Fre,Tre,o] = Chordal(Mfog,Wini,Hini,Iter,o); % Chordal-NMF by BCD

            if abs(abs(log(squared_chord_matrices(Mfog,Wfro*Hfro)))- abs(log(squared_chord_matrices(Mfog,Wre*Hre))))<1
                flag = false;
            end
        end


        for j = 1:n
            [~,largestfro(j)] = max( Hfro(:,j));
            [~,largestre(j)] = max( Hre(:,j));

        end

        [~, idfro] = sort(largestfro);
        sortedHfro =  Hfro(:,idfro);

        [~, idre] = sort(largestre);
        sortedHre =  Hre(:,idre);


        numberfroH = norm(Htrue-sortedHfro,'fro')/norm(Htrue,'fro');
        numberreH = norm(Htrue-sortedHre,'fro')/norm(Htrue,'fro');

        gridfro(count_eps,count_delta) = numberfro;
        gridre(count_eps,count_delta) = numberre;

        H_true{count_eps,count_delta} = Htrue;
        H_fro{count_eps,count_delta} = sortedHfro;
        H_re{count_eps,count_delta} = sortedHre;

        % W_true{count_eps,count_delta} = Wtrue;
        % W_fro{count_eps,count_delta} = Wfro;
        % W_re{count_eps,count_delta} = Wre;

    end
    count_delta = count_delta+1;
end
count_delta = 1;
count_eps = count_eps+1;

main_grid = [gridfro gridre];
imagesc(main_grid)





