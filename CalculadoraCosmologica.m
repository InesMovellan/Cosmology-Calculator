% Calculadora Cosmologica
classdef CalculadoraCosmologica
    properties 
        H0 = 0.0674; % Constante de Hubble en el momento actual en Gy^-1
		OMat = 0.315; % Parametro de densidad de materia
		OA = 0.685; % Parametro de densidad de energia oscura
		ORd = 0; % Parametro de densidad de radiacion
		OK = 0; % Parametro de densidad de curvatura (se inicializa en 0)
        c = 306.571; % Velocidad de la luz en Mpc/Gy
        a0 = 1; % factor de escala en el tiempo actual
        
        % Se definen otros parámetros cosmológicos para estudiar distintos 
        % tipos de universos (para a(t) y H(t))
        OMat1 = 1.0;
        OA1 = 0;
        ORd1 = 0;
        OK1 = 0;
        
        OMat2 = 0;
        OA2 = 0;
        ORd2 = 1.0;
        OK2 = 0;
       
        OMat3 = 0;
        OA3 = 1.0;
        ORd3 = 0;
        OK3 = 0;
        
        OMat4 = 0;
        OA4 = 0;
        ORd4 = 0;
        OK4 = 0;
	end

    methods
        % Constructor
		function self = CalculadoraCosmologica(~)
            self.OK = 1-(self.OMat+self.OA+self.ORd); 
            self.OK1 = 1-(self.OMat1+self.OA1+self.ORd1); 
            self.OK2 = 1-(self.OMat2+self.OA2+self.ORd2);
            self.OK3 = 1-(self.OMat3+self.OA3+self.ORd3);
            self.OK4 = 1-(self.OMat4+self.OA4+self.ORd4);
        end
       
        % Se define la funcion E(z)
		function E = E(self, z)
            E = sqrt(self.OA + self.OMat.*(1+z).^3 + self.ORd.*(1+z).^4 + self.OK.*(1+z).^2);
        end
        % E(z) para los distintos tipos de universos
        function E1 = E1(self, z)
            E1 = sqrt(self.OA1 + self.OMat1.*(1+z).^3 + self.ORd1.*(1+z).^4 + self.OK1.*(1+z).^2);
        end
        function E2 = E2(self, z)
            E2 = sqrt(self.OA2 + self.OMat2.*(1+z).^3 + self.ORd2.*(1+z).^4 + self.OK2.*(1+z).^2);
        end
        function E3 = E3(self, z)
            E3 = sqrt(self.OA3 + self.OMat3.*(1+z).^3 + self.ORd3.*(1+z).^4 + self.OK3.*(1+z).^2);
        end
        function E4 = E4(self, z)
            E4 = sqrt(self.OA4 + self.OMat4.*(1+z).^3 + self.ORd4.*(1+z).^4 + self.OK4.*(1+z).^2);
        end
       
       % Se define el factor de escala en funcion del redshift
       function a = a(~, z)
           a = 1./(1+z);
	   end
       
       % Se define la coordenada radial sigma en funcion del redshift
       function sigma = s(self,z)
           % Se inicializa el array sigma
           sigma = zeros(1,length(z));
           % Se calcula sigma para cada valor de z
           % Con el siguiente bucle if se contemplan las opciones de k=0 o
           % que k distinto de 0
           if (self.OK==0)
               for i=1:length(z)
                   integ1 = integral(@(z) 1./self.E(z), 0, z(i));
                   sigma(i) = self.c.*integ1./(self.a0*self.H0);
               end
           else
               for i=1:length(z)
                   integ1 = integral(@(z) 1./self.E(z), 0, z(i));
                   sigma(i) = self.c./(self.a0*self.H0*sqrt(self.OK))*sinh(sqrt(self.OK)*integ1);
               end
           end           
       end
      
       % DISTACIA DE LUMINOSIDAD
       function distL = dL(self,z)
           % Se inicializa el array distL
           distL = zeros(1,length(z));
           % Se calcula la distancia de luminosidad para cada z
           for i=1:length(z)
               distL(i) = self.a0.*(1+z(i)).*self.s(z(i));
           end
       end
       
       % DISTANCIA DE DIÁMETRO ANGULAR
       function distA = dA(self,z)
           % Se inicializa el array distA
           distA = zeros(1,length(z));
           % Se calcula la distancia angular para cada z
           for i=1:length(z)
               distA(i) = self.a0.*self.s(z(i))./(1+z(i));
           end
       end
       
       % Para obtener a(t) y H(t) es necesario tener redefinir E(z) en funcion 
       % del factor de escala a.
       % Redefiniendo la funcion E(z) en funcion del factor de escala, y se realizando el
       % producto a*H0*E(a), se obtiene la EDO a partir de la cual se
       % determina a(t)
       % FACTOR DE ESCALA
       function at = at(self)
           E1 = @(t, a) self.H0.*sqrt(self.OA.*(a.^2) + self.OMat./a + self.ORd./(a.^2)+ self.OK);
           [t1,a1] = ode45(E1,[0 50],1);
           at = [t1,a1];
           % El output es una matriz cuya primera columna son los tiempos,
           % y la segunda los factores de escala
       end
       
       % PARÁMETRO DE HUBBLE
       function Ht = Ht(self)
           % Se obtiene el factor de escala a partir de la función at
           FEscala = self.at();
           a = FEscala(:,2);
           % Se calcula el parámetro de Hubble
           Ht = self.H0.*sqrt(self.OA + self.OMat./(a.^3) + self.ORd./(a.^4)+ self.OK./(a.^2));
       end
       
       % Se definen funciones equivalentes para otros parámetros
       % cosmológicos
       function at1 = at1(self)
           E11 = @(t, a) self.H0.*sqrt(self.OA1.*(a.^2) + self.OMat1./a + self.ORd1./(a.^2)+ self.OK1);
           [t11,a11] = ode45(E11,[0 50],1);
           at1 = [t11,a11];
       end 
       function Ht1 = Ht1(self)
           % Se obtiene el factor de escala a partir de la función at
           FEscala1 = self.at1();
           a1 = FEscala1(:,2);
           % Se calcula el parámetro de Hubble
           Ht1 = self.H0.*sqrt(self.OA1 + self.OMat1./(a1.^3) + self.ORd1./(a1.^4)+ self.OK1./(a1.^2));
       end
       function at2 = at2(self)
           E2 = @(t, a) self.H0.*sqrt(self.OA2.*(a.^2) + self.OMat2./a + self.ORd2./(a.^2)+ self.OK2);
           [t2,a2] = ode45(E2,[0 50],1);
           at2 = [t2,a2];
       end
       function Ht2 = Ht2(self)
           % Se obtiene el factor de escala a partir de la función at
           FEscala2 = self.at2();
           a2 = FEscala2(:,2);
           % Se calcula el parámetro de Hubble
           Ht2 = self.H0.*sqrt(self.OA2 + self.OMat2./(a2.^3) + self.ORd2./(a2.^4)+ self.OK2./(a2.^2));
       end
       function at3 = at3(self)
           E3 = @(t, a) a*self.H0.*(sqrt(self.OA3 + self.OMat3./(a.^3) + self.ORd3./(a.^4)+ self.OK3./(a.^2)));
           [t3,a3] = ode45(E3,[0 50],1);
           at3 = [t3,a3];
       end
       function Ht3 = Ht3(self)
           % Se obtiene el factor de escala a partir de la función at
           FEscala3 = self.at3();
           a3 = FEscala3(:,2);
           % Se calcula el parámetro de Hubble
           Ht3 = self.H0.*sqrt(self.OA3 + self.OMat3./(a3.^3) + self.ORd3./(a3.^4)+ self.OK3./(a3.^2));
       end
       function at4 = at4(self)
           E4 = @(t, a) a*self.H0.*(sqrt(self.OA4 + self.OMat4./(a.^3) + self.ORd4./(a.^4)+ self.OK4./(a.^2)));
           [t4,a4] = ode45(E4,[0 50],1);
           at4 = [t4,a4];
       end
       function Ht4 = Ht4(self)
           % Se obtiene el factor de escala a partir de la función at
           FEscala4 = self.at4();
           a4 = FEscala4(:,2);
           % Se calcula el parámetro de Hubble
           Ht4 = self.H0.*sqrt(self.OA4 + self.OMat4./(a4.^3) + self.ORd4./(a4.^4)+ self.OK4./(a4.^2));
       end
       
       % RADIO DE HUBBLE
       function R = R(self)
           R = self.c./self.Ht();
       end
       
       %Radio de Hubble en los demás universos
       function R1 = R1(self)
           R1 = self.c./self.Ht1();
       end
       function R2 = R2(self)
           R2 = self.c./self.Ht2();
       end
       function R3 = R3(self)
           R3 = self.c./self.Ht3();
       end
       function R4 = R4(self)
           R4 = self.c./self.Ht4();
       end
       
       % HORIZONTE DE PARTÍCULAS
       function HP = HP(self)
           FE = self.at();
           t = FE(:,1);
           a = FE(:,2);
           HP = zeros(1, length(t));
           for i=1:length(t)
               int = 0;
               for j=1:i-1
                   dt = t(j+1)-t(j);
                   int = int+(dt./a(j));
               end
               HP(i) = self.c*int;
           end

       end
       % Horizonte de partículas para los demás tipos de universo
       function HP1 = HP1(self)
           FE1 = self.at1();
           t = FE1(:,1);
           a = FE1(:,2);
           HP1 = zeros(1, length(t));
           for i=1:length(t)
               int = 0;
               for j=1:i-1
                   dt = t(j+1)-t(j);
                   int = int+(dt./a(j));
               end
               HP1(i) = self.c*int;
           end
       end
       function HP2 = HP2(self)
           FE2 = self.at2();
           t = FE2(:,1);
           a = FE2(:,2);
           HP2 = zeros(1, length(t));
           for i=1:length(t)
               int = 0;
               for j=1:i-1
                   dt = t(j+1)-t(j);
                   int = int + (dt./a(j));
               end
               HP2(i) = self.c*int;
           end
       end
       function HP3 = HP3(self)
           FE3 = self.at3();
           t = FE3(:,1);
           a = FE3(:,2);
           HP3 = zeros(1, length(t));
           for i=1:length(t)
               int = 0;
               for j=1:i-1
                   dt = t(j+1)-t(j);
                   int = int + (dt./a(j));
               end
               HP3(i) = self.c*int;
           end
       end
       function HP4 = HP4(self)
           FE4 = self.at4();
           t = FE4(:,1);
           a = FE4(:,2);
           HP4 = zeros(1, length(t));
           for i=1:length(t)
               int = 0;
               for j=1:i-1
                   dt = t(j+1)-t(j);
                   int = int + (dt./a(j));
               end
               HP4(i) = self.c*int;
           end
       end
       
       % EDAD DEL UNIVERSO
       % Se define el tiempo en función del redshift t(z)
       function tiempo = t(self, z)
           % Se inicializa el array de tiempo
           tiempo = zeros(1, length(z));
           % Se calcula el tiempo para cada valor de z
			    for i=1:length(z)
                    integ = integral(@(z) 1./((1+z).*self.E(z)), 0,z(i));
				    tiempo(i) = (1/self.H0).*integ;
                end
       end
       % Edad del universos para los demás casos
       function tiempo1 = t1(self, z)
           % Se inicializa el array de tiempo
           tiempo1 = zeros(1, length(z));
           % Se calcula el tiempo para cada valor de z
			    for i=1:length(z)
                    integ = integral(@(z) 1./((1+z).*self.E1(z)), 0,z(i));
				    tiempo1(i) = (1/self.H0).*integ;
                end
       end
       function tiempo2 = t2(self, z)
           % Se inicializa el array de tiempo
           tiempo2 = zeros(1, length(z));
           % Se calcula el tiempo para cada valor de z
			    for i=1:length(z)
                    integ = integral(@(z) 1./((1+z).*self.E2(z)), 0,z(i));
				    tiempo2(i) = (1/self.H0).*integ;
                end
       end
       function tiempo3 = t3(self, z)
           % Se inicializa el array de tiempo
           tiempo3 = zeros(1, length(z));
           % Se calcula el tiempo para cada valor de z
			    for i=1:length(z)
                    integ = integral(@(z) 1./((1+z).*self.E3(z)), 0,z(i));
				    tiempo3(i) = (1/self.H0).*integ;
                end
       end
       function tiempo4 = t4(self, z)
           % Se inicializa el array de tiempo
           tiempo4 = zeros(1, length(z));
           % Se calcula el tiempo para cada valor de z
			    for i=1:length(z)
                    integ = integral(@(z) 1./((1+z).*self.E4(z)), 0,z(i));
				    tiempo4(i) = (1/self.H0).*integ;
                end
       end
    end
end
