ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recent Recordings" do
          ul do
            Recording.last(5).map do |recording|
              li link_to(recording.created_at.to_s, admin_recording_path(recording)) + raw("<audio controls><source src='/#{recording.audio}' type='audio/wav' /></audio>")
            end
          end
        end
      end

      column do
        panel "Info" do
          para "Welcome to Listeing-to.us!"
        end
      end
    end
  end # content
end
