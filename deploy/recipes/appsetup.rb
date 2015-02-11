node[:deploy].each do |app_name, deploy|
  template "#{deploy[:deploy_to]}/current/application/configs/settings.php" do
    source "settings.php.erb"
    mode 0644
    group deploy[:group]

    if platform?("ubuntu")
        owner "www-data"
    elsif platform?("amazon")   
    	owner "deploy"
    end

    variables(
      :host =>     (deploy[:database][:host] rescue nil),
      :user =>     (deploy[:database][:username] rescue nil),
      :password => (deploy[:database][:password] rescue nil),
      :db =>       (deploy[:database][:database] rescue nil),
      :db_encryption_key => (deploy[:database][:db_encryption_key] rescue nil),
      :smtphost =>  (deploy[:smtp][:host] rescue nil),
      :smtpuser => (deploy[:smtp][:username] rescue nil),
      :smtppassword => (deploy[:smtp][:password] rescue nil),
      
      :aws_access_key => (deploy[:aws][:access_key] rescue nil),
      :aws_secret_key => (deploy[:aws][:secret_key] rescue nil),
      :client_buket => (deploy[:aws][:client_buket] rescue nil),
      :cache_cluster_host => (deploy[:aws][:cache_cluster_host] rescue nil)
      
      )
      
   
  end
end