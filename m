Return-Path: <linux-kernel+bounces-868741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DE0C06094
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169F53BDEC8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D4130C359;
	Fri, 24 Oct 2025 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y5hLClOT"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D967483
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761304531; cv=none; b=lia55oW0nS3UFdXfDixsyoW5kepN4z1jDeCue7txet71R+zh2xb7/jIv6fvej8OOk6aYZ74J8N7RNbwQjhz6pomTNuHQqpi9eR2qJxEdy/iNuGMDRXRu6jK2TSj1asZcHLQvS4keefSQjoF32tsSPu2es+4otZ7Oemj1rw6Cp2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761304531; c=relaxed/simple;
	bh=O0Yq9b0ntIV2rXwmu5CJkLogXD7qjpje5XMHRfj6JVE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZjHQ8sHFwKtUBgCAghNTYlSf1NGDRIXbkQZ/LJ9XsEJuEZtoKHVjRtJw89O1v+eDoo4kmdw5va6Lr8aBU0F1nIMOPeN+HcZgwlGT78izU/62F4R0/s9hoCqB0K2eQecStI14g5ytKGekcfCyKIYpl6kpJkDAlmHklGzcp1Qequs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y5hLClOT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4711810948aso14566435e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761304528; x=1761909328; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjnWrdwJJM6Xkd6ejbGWp0lF4mtBxwGKExhzOcwx4QM=;
        b=Y5hLClOTg1UL71XBvkW8/po2xRWzMClQMp9JrbL/Lz3mlMCyE69j10hJCGrpnSz3oK
         tExai27nKFNjcHXOkjK406JWs5UuosvuLLNyD8csfMpk5wpZLrMh1K1rrKVx2Cp+5iwf
         m3fYtTUCawTlRa2iuF1WiPcnZHzJuWmNut60pEgjQxXs16QYPx6YZIuILkj5JLjsA+uk
         O9vVNyhgy+CKNezJbeRifmsvmQNRr2WXKcEmNLhYducHgjYY8JBPhfRcoQezf6/OoDDl
         38AZh3NMBwGhP4peaTiefBcpU/g+fz5wOdMoCjWusoHkzV4BJRLWytXEFZRn1nsU5xyG
         SuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761304528; x=1761909328;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tjnWrdwJJM6Xkd6ejbGWp0lF4mtBxwGKExhzOcwx4QM=;
        b=HmX7/1x0C47gn9NlO8G9a+NFa9ao+cPv1BwMvAKrzFahc1vHJ3jzDs/DiKq0Od8Txz
         oXwrvt6+wWCY96nml5UQmJplwyRcifiYJR9TBHSpP9C+lGOBUJ/doMHiRBFP5jQUr9Da
         Mq7RbR955OQY04Xz2uygPHoPrygpl1N+iXa5xWDlj1H26TRGfkEdfdxYsJ7He7riy9xA
         hXSePRU5Iu9fGioKaIpSvPdUrzpNLbt+UjmHDqNX7on/hIwgfm+KDKdvfdcj+e2QU0fl
         ij5ldq5WEGvktAc28X+9VH55oQ1OoqOjm8V1ZN1W3W/HazkjVx7UK3FpObs/ZWfEKUQT
         Kveg==
X-Forwarded-Encrypted: i=1; AJvYcCUzMOIQc4wAK3POfE6QtzIGxwsk6fxWjU1zu3ts3TuMDCgGZ4eoLHifnm9cZnofxODSIy2G/rfdjWEoADc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9qO5N0YxxRmiXJD9A1uvSKGw4Ov5QDxpT4JoOJY62Q5Z94h8u
	wY72eWQrfvxot0y1U8n2IFp164RgBnNzudQFA5AmgDVUBujFCWjfeBK1JLp47Q6seCA=
X-Gm-Gg: ASbGnctVfi0o/cWmYMO2ZcjWxotSeHjVxdLbG0kcHijEnM/2Ay7cGw8Yw6qwv7S2qgl
	0inR6yGU7FEmXNj2lKgCj8m7wVDXYcBIvkw6qibI2fY3I9wVYBAXROtxltmW/jtKHQGO0vCfipy
	tTVjF09sYBhrrTSeiA4NO1ajJa6OhT1fg/rvv+Ee9aqDLdRkYJYvxhrUs5XfqnS29/VegSDrtMd
	Rn02Kr6tthDkP9xgLqqMwhvJSVk3JEYDT8uwaF6z0RqgNDF+KXP6IJE2zig2cPZUNBLAL8YzbhW
	/C5BIyqwApGJjWgDaCjUNRCtfi+FToz38waevVqPAZM3iXiQl2lnIUMKPTe4X+ToNu2avBV48q+
	Hsm36djtu/oaIHAvsc+z+yUfr177Pp016KEQnUIitDpJTKexuD5weBpmFU1vBjDQNH5w18R2mDs
	PJ+JGa2A==
X-Google-Smtp-Source: AGHT+IHppQw7OhXyE1vh506SaVqjXNUIJ+8VzvhstGEr4RfM3xhdsHlPAMgvjfWhOUYwQyK4GXMIgQ==
X-Received: by 2002:a05:600c:5287:b0:46e:6a6a:5cec with SMTP id 5b1f17b1804b1-47117876738mr245432555e9.2.1761304527664;
        Fri, 24 Oct 2025 04:15:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429897f5696sm9120866f8f.14.2025.10.24.04.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 04:15:27 -0700 (PDT)
Date: Fri, 24 Oct 2025 14:15:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	=?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	Harry Wentland <harry.wentland@amd.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/vkms: Fix use after frees on error paths
Message-ID: <aPtfy2jCI_kb3Df7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

These error paths free a pointer and then dereference it on the next line
to get the error code.  Save the error code first and then free the
memory.

Fixes: 3e4d5b30d2b2 ("drm/vkms: Allow to configure multiple CRTCs via configfs")
Fixes: 2f1734ba271b ("drm/vkms: Allow to configure multiple planes via configfs")
Fixes: 67d8cf92e13e ("drm/vkms: Allow to configure multiple encoders via configfs")
Fixes: 272acbca96a3 ("drm/vkms: Allow to configure multiple connectors via configfs")
Fixes: 13fc9b9745cc ("drm/vkms: Add and remove VKMS instances via configfs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/vkms/vkms_configfs.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 07ab794e1052..506666e21c91 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -204,6 +204,7 @@ static struct config_group *make_crtc_group(struct config_group *group,
 {
 	struct vkms_configfs_device *dev;
 	struct vkms_configfs_crtc *crtc;
+	int ret;
 
 	dev = child_group_to_vkms_configfs_device(group);
 
@@ -219,8 +220,9 @@ static struct config_group *make_crtc_group(struct config_group *group,
 
 		crtc->config = vkms_config_create_crtc(dev->config);
 		if (IS_ERR(crtc->config)) {
+			ret = PTR_ERR(crtc->config);
 			kfree(crtc);
-			return ERR_CAST(crtc->config);
+			return ERR_PTR(ret);
 		}
 
 		config_group_init_type_name(&crtc->group, name, &crtc_item_type);
@@ -358,6 +360,7 @@ static struct config_group *make_plane_group(struct config_group *group,
 {
 	struct vkms_configfs_device *dev;
 	struct vkms_configfs_plane *plane;
+	int ret;
 
 	dev = child_group_to_vkms_configfs_device(group);
 
@@ -373,8 +376,9 @@ static struct config_group *make_plane_group(struct config_group *group,
 
 		plane->config = vkms_config_create_plane(dev->config);
 		if (IS_ERR(plane->config)) {
+			ret = PTR_ERR(plane->config);
 			kfree(plane);
-			return ERR_CAST(plane->config);
+			return ERR_PTR(ret);
 		}
 
 		config_group_init_type_name(&plane->group, name, &plane_item_type);
@@ -472,6 +476,7 @@ static struct config_group *make_encoder_group(struct config_group *group,
 {
 	struct vkms_configfs_device *dev;
 	struct vkms_configfs_encoder *encoder;
+	int ret;
 
 	dev = child_group_to_vkms_configfs_device(group);
 
@@ -487,8 +492,9 @@ static struct config_group *make_encoder_group(struct config_group *group,
 
 		encoder->config = vkms_config_create_encoder(dev->config);
 		if (IS_ERR(encoder->config)) {
+			ret = PTR_ERR(encoder->config);
 			kfree(encoder);
-			return ERR_CAST(encoder->config);
+			return ERR_PTR(ret);
 		}
 
 		config_group_init_type_name(&encoder->group, name,
@@ -637,6 +643,7 @@ static struct config_group *make_connector_group(struct config_group *group,
 {
 	struct vkms_configfs_device *dev;
 	struct vkms_configfs_connector *connector;
+	int ret;
 
 	dev = child_group_to_vkms_configfs_device(group);
 
@@ -652,8 +659,9 @@ static struct config_group *make_connector_group(struct config_group *group,
 
 		connector->config = vkms_config_create_connector(dev->config);
 		if (IS_ERR(connector->config)) {
+			ret = PTR_ERR(connector->config);
 			kfree(connector);
-			return ERR_CAST(connector->config);
+			return ERR_PTR(ret);
 		}
 
 		config_group_init_type_name(&connector->group, name,
@@ -756,6 +764,7 @@ static struct config_group *make_device_group(struct config_group *group,
 					      const char *name)
 {
 	struct vkms_configfs_device *dev;
+	int ret;
 
 	if (strcmp(name, DEFAULT_DEVICE_NAME) == 0)
 		return ERR_PTR(-EINVAL);
@@ -766,8 +775,9 @@ static struct config_group *make_device_group(struct config_group *group,
 
 	dev->config = vkms_config_create(name);
 	if (IS_ERR(dev->config)) {
+		ret = PTR_ERR(dev->config);
 		kfree(dev);
-		return ERR_CAST(dev->config);
+		return ERR_PTR(ret);
 	}
 
 	config_group_init_type_name(&dev->group, name, &device_item_type);
-- 
2.51.0


