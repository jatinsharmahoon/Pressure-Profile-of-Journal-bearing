clc;
clear;
close all;
Nx = input('enter no. of nodes in x- direction')
%Nx stands for no. of nodes in x direction
Nz = input('enter no. of nodes in z- direction')
%Nz stands for no. of nodes in z direction
deltheta=1.0/(Nx-1)
delzb = 1.0/(Nz-1);
D=0.10; % this is journal diameter in meter
L=0.10;%this is journal length in meter
h=1e-3;%film thickness in meter
CR=1e-4
ecc=0.7
U=1.0;%sliding velocity(m/s)
eta0=0.1;%viscosity of oil(pa-s) of lubricatong oil at feeding temperature(T0)
rho0=850; %density of lubricating oil at feeding temperature(TT)

%Assigning the values to the variable parameters

for i=1:1:Nx
      for k=1:1:Nz
      pb(i,k)=0;
      etab(i,k)=1.0;
      rhob(i,k)=1.0;
      theta(i)=(i-1)*deltheta;
      zb(k)=-0.5+(k-1)*delzb;
      hb(i,k)=1+(ecc*cos(theta(i)));
      end
end
     error=1;
     while error>=1e-3
         sumpbdiff=0;
         sumpb=0;
         for i=2:1:Nx-1
             for k=2:1:Nz-1
             JJ1=(rhob(i+1,k)*hb(i+1,k)^3)/(2*etab(i+1,k)*(deltheta));
             JJ2=(rhob(i-1,k)*hb(i-1,k)^3)/(2*etab(i-1,k)*(deltheta));
             JJ3=pb(i+1,k)/(2*deltheta);
             JJ4=pb(i-1,k)/(2*deltheta);
             JJ5=(rhob(i,k)*(hb(i,k)^3))/etab(i,k);
             JJ6=pb(i+1,k)/(deltheta^2);
             JJ7=pb(i-1,k)/(deltheta^2);
             JJ8=(rhob(i,k+1)*hb(i,k+1)^3)/(2*etab(i,k+1)*(delzb));
             JJ9=(rhob(i,k-1)*hb(i,k-1)^3)/(2*etab(i,k-1)*(delzb));
             JJ10=pb(i,k+1)/(2*delzb);
             JJ11=pb(i,k-1)/(2*delzb);
             JJ12=((D/L)^2)*(rhob(i,k)*hb(i,k)^3)/(etab(i,k));
             JJ13=pb(i,k+1)/(delzb^2);
             JJ14=pb(i,k-1)/(delzb^2);
             JJ15=6*rhob(i,k)*((hb(i+1,k)-hb(i-1,k))/(2*deltheta));
             JJ16=6*hb(i,k)*((rhob(i+1,k)-rhob(i-1,k))/(2*deltheta));
             JJ17=(JJ1-JJ2)*(JJ3-JJ4);
             JJ18=JJ5*(JJ6+JJ7);
             JJ19=((D/L)^2)*(JJ8-JJ9)*(JJ10-JJ11);
             JJ20=JJ12*(JJ13+JJ14);
             JJ21=JJ15+JJ16;
             JJ22=JJ17+JJ18+JJ19+JJ20-JJ21;
             JJ23=((2*JJ5)/(deltheta^2))+((2*JJ12)/(delzb^2));
             JJ24=JJ22/JJ23;
             pbnew(i,k)=JJ24;
             sumpbdiff=sumpbdiff+abs(pbnew(i,k)-pb(i,k));
             sumpb=sumpb+abs(pbnew(i,k));
             pb(i,k)=pbnew(i,k);
             end
         end

         error=sumpbdiff/sumpb;
     end
     for i=1:1:Nx
         for k=1:1:Nz
             p(i,k)=pb(i,k)*((eta0*U*D)/(CR*CR));
         end
     end
     [x,z]=meshgrid(i,k);
     y=p(x,z);
     surfc(p)
     view(170,50)
     ylabel('Nx')
     xlabel('Nz')
     zlabel('Pressure')



