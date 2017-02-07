program JEUX;

uses SDL2, SDL2_image;

var
sdlWindow1 : PSDL_Window;
sdlRenderer : PSDL_Renderer;
sdlTexture1 : PSDL_Texture;

begin

  //initilization of video subsystem
  if SDL_Init( SDL_INIT_VIDEO ) < 0 then HALT;//si il renvoie rien on ferme le programme
	
	//creation de la fenetre
  sdlWindow1 := SDL_CreateWindow( 'Jeux', 100{x}, 100{y}, 500{hauteur}, 500{largeur}, SDL_WINDOW_MAXIMIZED );
  if sdlWindow1 = nil then HALT;
	
	//on fait un rendu
  sdlRenderer := SDL_CreateRenderer( sdlWindow1, -1{driver}, 0{mode utiliser} );
  if sdlRenderer = nil then HALT;
	
	//on affiche la texture
  sdlTexture1 := IMG_LoadTexture( sdlRenderer, 'wolf2.bmp' );
  if sdlTexture1 = nil then HALT;
	
  SDL_RenderCopy( sdlRenderer, sdlTexture1, nil, nil );
  SDL_RenderPresent (sdlRenderer);
  SDL_Delay( 2000 );


  SDL_DestroyTexture( sdlTexture1 );
  SDL_DestroyRenderer( sdlRenderer );
  SDL_DestroyWindow ( sdlWindow1 );


  //shutting down video subsystem
  SDL_Quit;

end.


