% Calculadora Cosmologica
classdef CalculadoraCosmologica
	  properties
       H0 = 71.0; % Constante de Hubble en el momento actual en km/s/Mpc
		   OMat = 0.23; % Parametro de densidad de materia
		   OA = 0.76; % Parametro de densidad de energia oscura
		   ORd = 0; % Parametro de densidad de radiacion
		   OK = 0; % Parametro de densidad de curvatura
       c = 300000; % Velocidad de la luz en el vacio
       a0 = 1; % factor de escala en el tiempo actual
	  end

    methods
       % Constructor
		   function self = CalculadoraCosmologica(self)
			     self.OK = 1-(self.OMat+self.OA+self.ORd); % Se le da el valor correcto 
           % al parametro de densidad de curvatura	
		   end
       
       % Se define la funcion E(z)
		   function E = E(self, z)
			     E = sqrt(self.OA + self.OMat*(1+z)^3 + self.ORd*(1+z)^4 + self.OK*(1+z)^2);
		   end
       
       % Se define el tiempo en funcion del redshift t(z)
		   function tiempo = t(self, z)
           % Se inicializa el array de tiempo
			     tiempo = zeros(1, length(z));
           % Se calcula el tiempo para cada valor de z
			     for i=1:length(z)
				       integ = quadv(@(z) 1/((1+z)*self.E(z)), 0, z(i));
				       tiempo(i) = (1/self.H0)*integ;
			     end
		   end
       
       % Se define el factor de escala en funcion del redshift
		   function a = a(self, z)
			     a = 1/(1+z);
		   end
       
       % Se define la coordenada radial sigma en funcion del redshift
       function sigma = s(self,z)
           % Se inicializa el array sigma
           sigma = zeros(1,length(z));
           % Se calcula sigma para cada valor de z
           for i=1:length(z)
               integ1 = quadv(@(z) 1/self.E(z), 0, z(i));
               sigma(i) = self.c/(self.a0*self.H0*sqrt(self.OK))*sinh(sqrt(self.OK)*integ1);
           end
       end
       
       % Distancia de luminosidad
       function distL = dL(self,z)
           % Se inicializa el array distL
           distL = zeros(1,length(z));
           
       end
    end
end
