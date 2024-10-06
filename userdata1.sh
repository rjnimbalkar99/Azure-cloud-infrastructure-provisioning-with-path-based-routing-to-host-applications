#!/bin/bash
apt update
apt install -y nginx

# Install the Azure CLI
apt install -y azure-cli

# Create a directory and an HTML file with content
mkdir -p /var/www/html/profile-card

# Download the image using curl (replace with your actual image URL)
curl -o /var/www/html/profile-card/Rahul.jpeg "https://drive.google.com/uc?export=download&id=10LJp_52P6-99I73CIdi0cRyTI9e0lbVv"

# Create a simple HTML file with the portfolio content and display the images
cat <<EOF > /var/www/html/profile-card/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="./style.css">
</head>
<body>
    <div class="card">
        <img src="./Rahul.jpeg" alt="profile">
        <div>

            <h2>Rahul Nimbalkar</h2>
            <h3>DevOps Engineer</h3>
            <p>Empowering users through captivating interfaces, turning ideas into pixel-perfect realities.</p>
            <a href="https://www.linkedin.com/in/rahul-nimbalkar-a87715303/">Follow Account</a>
        </div>
    </div>
</body>
</html>
EOF

cat <<EOF > /var/www/html/profile-card/style.css
@import url('https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap');

body {
    display: grid;
    place-items: center;
    margin: 0;
    height: 100vh;
    background: #221d2d;
    color: #fdfcfd;
    font-family: "Poppins";
}

.card {
    display: flex;
    align-items: center;
    width: 75vw;
    max-width: 650px;
    padding: 50px 30px 50px 20px;
    background: #121017;
    border-radius: 24px;
}

.card img {
    max-width: 280px;
    width: 75vw;
    height: 300px;
    object-fit: cover;
    margin-left: -60px;
    margin-right: 30px;
    border-radius: inherit;
    box-shadow: 0 60px 40px rgb(0 0 0 / 8%);

}

.card h2 {
    font-size: 26px;
    font-weight: 400;
    margin-top: 0;
    margin-right: 30px;
    margin-bottom: 10px;

}

.card h3 {
    font-size: 16px;
    font-weight: 400;
    margin: 0;
    opacity: 0.75;
}

.card p {
    font-size: 14px;
    font-weight: 400;
    margin-bottom: 30px;
    opacity: 0.5;

}

.card a {
    display: grid;
    place-items: center;
    border: 0;
    background: #6939ff;
    color: #f8f8f8;
    padding: 16px 26px;
    font-size: 16px;
    border-radius: 40px;
}

@media(width <=600px) {
    .card {
        margin: 0 40px;
        padding-left: 50px;
        padding-right: 50px;
        padding-bottom: 60px;
        width: 100%;
        text-align: center;
        flex-direction: column;
    }

    .card h2 {
        margin-right: 0;
    }

    .card img {
        margin: -1000px 0 30px 0;
        width: 100%;
        max-width: 1000px;
    }

    .card p {
        max-width: 360px;
    }
}

@media (width <=440px) {
    .card img {
        height: 45vw;
        width: 45vw;
        border-radius: 50%;
        margin-top: -140px;
    }
}
EOF


# Update the Nginx configuration file
cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 80;
    server_name localhost;

    root /var/www/html/profile-card;
    index index.html;

    location / {
        try_files /$uri /$uri/ =404;
    }

    location /profile-card/ {
        alias /var/www/html/profile-card/;
        index index.html;
    }
}
EOF

# Test the Nginx configuration
nginx -t

# Restart Nginx to apply changes
systemctl restart nginx
systemctl enable nginx
