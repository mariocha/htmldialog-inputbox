require 'json'

require 'F3D_Lib/argument_parser'

module F3D_HtmlInput
  module HtmlUI
    # Class that uses UI::HtmlDialog to create a dialog box
    # similar to UI.messagebox.
    class MessageBox

      def initialize(*args)
        defaults = {
          title: Sketchup.app_name,
          accept_button: 'Accept',
          inputs: [],
        }
 
        options = ArgumentParser.new.parse(*args)
        @options = defaults.merge(options)
      end

      def prompt
        message_file = File.join(__dir__, 'html', 'messagebox.html')
        window_options = {
          :dialog_title => @options[:title],
          :preferences_key => 'com.example.html-input',
          :scrollable => true,
          :resizable => true,
          :width  => 300,
          :height => 300,
          :min_width  => 230,
          :min_height => 200,
          :max_width  => 400,
          :style => UI::HtmlDialog::STYLE_DIALOG
        }
        window = UI::HtmlDialog.new(window_options)
        window.set_file(message_file)

        window.add_action_callback('accept') { |action_context, values|
          window.close
        }
 
        window.center
        window.show_modal
      end

    end # class

 
    def self.messagebox(options)
      window = MessageBox.new(options)
      window.prompt
    end

  end # module
end # module
