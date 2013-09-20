namespace :librarian do

  desc "Initialize Librarian-Chef environment"
  task :init do 
  end

  desc "Install cookbooks"
  task :install do 
    sh "librarian-chef install"
  end
end
