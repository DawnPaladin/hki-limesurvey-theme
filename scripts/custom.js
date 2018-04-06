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

        $("#ls-button-submit").on('click', function(event) {
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
    (function animateShowHideQuestions() {
        // overriding \\192.168.25.134\htdocs\sites\limesurvey\assets\packages\limesurvey\survey.js
        $("[id^='question']")
            .off('relevance:on')
            .off('relevance:off')
            .on('relevance:on', function(event, data) {
                if (event.target != this) return;
                $(this).slideDown();
            })
            .on('relevance:off', function(event, data) {
                if (event.target != this) return;
                $(this).slideUp();
            })
        ;
    })();

});

