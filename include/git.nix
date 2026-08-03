{ ... }:

{
    programs.git = {
        enable = true;
        settings = {
            user = {
                name  = "AdelieEye";
                email = "adelie.eye@gmail.com";
            };
            init.defaultbranch = "main";
        };
    };
}
