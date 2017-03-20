module ApplicationHelper

  def asset_exists?(subdirectory, filename)
    File.exists?(File.join(Rails.root, 'app', 'assets', subdirectory, filename))
  end

  def stylesheet_exists?(stylesheet)
    extensions = %w(.scss .erb .scss.erb .css) + [""]
    extensions.inject(false) do |truth, extension|
      truth || asset_exists?('stylesheets', "#{stylesheet}#{extension}")
    end
  end

  def javascript_exists?(script)
    extensions = %w(.coffee .erb .coffee.erb .js) + [""]
    extensions.inject(false) do |truth, extension|
      truth || asset_exists?('javascripts', "#{script}#{extension}")
    end
  end
end
