/******************
    User custom JS
    ---------------

   Put JS-functions for your template here.
   If possible use a closure, or add them to the general Template Object "Template"
*/


$(document).on('ready pjax:scriptcomplete',function(){
    (function animateGroup() {
        var $group = $('#limesurvey');
        $group.hide();
        console.log($group);
        
        $("#ls-button-submit").on('click', function(event) {
            console.log(checkFormValidity());
            if (checkFormValidity()) {
                $group.slideUp(); // animate hide
            }
        });
        function checkFormValidity() {
            var formValid = true;
            $('#limesurvey input').each(function() {
                if (!this.validity.valid) formValid = false;
            });
            return formValid;
        }
        $group.slideDown(); // animate show

    })();
});

