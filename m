Return-Path: <linux-kernel+bounces-794510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5654DB3E2CB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8AFE16B2C7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D3E334399;
	Mon,  1 Sep 2025 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEe1Unwy"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F983314AC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729567; cv=none; b=SvX9iUlxi3bkFlPiavMvyiFvQYCBfbOcKuS+UhIw0NCCTy17fBVZC4meleQbtZ9gl8ELLRH41TLtzfMhgIRc6JOVzrckaQcYX8IdjUdIiyb2PRjJ3Cyy3FTxz50RSgkJZsPV/crydkVi1++3LQIgh0ZSfs9yQDOTNZ1fbUEEmGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729567; c=relaxed/simple;
	bh=jGsDChNXv0/9j479UC2z0QgXhpmuNpLFQDf9xY4pnp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4Kxrws6dCfVAqC4CI3+q7BWkwXQ6pv0Auh9RGoMe+OAPJKAAfRdSfJYxGRf8g0vid11KEF9v5FCSg+jws9HrDhoK5APU0gqjTA+MxawjCP59zUvWM9IsB/B4OGMOKWfbm2Spp2zDxVVsrniHJ6Mm/hLpwIFpnetX45gKXkwbiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEe1Unwy; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ce47d1f1f8so2881406f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756729564; x=1757334364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JgtE5NuuXHXwQbDBEsNd3TAksX6P3TmTjBg+zdfY+I=;
        b=WEe1UnwyJfoCrZLbE1hNEE+9f6dW9y5xwqRd9BP2f0iYH8f698dg74bZ0RFgPfQY3w
         SgrtkqIrSTO00JvhB+rrcz3UyUm82AGFhA3jv3an/or5CQMABaxj4kr8NJcRPfLWhhoz
         VUsw8ZCMdaMvVNAMhAQ0gJXVSFrvTkX9WXa5wbt5zz8L3+hVTKjlcmC9SrwPwZ4aCEHi
         i5fHGh6je7LXAg71iIkHCZ245WpaZrMdhN1WneNR4IpMzO1MStlC0ROyvDdMtsQpHy65
         MMoaeBcBZPI1V+FzSDVaNr1Qe7Ies7xSC4FoIsK6zVUof+wjqGclBhK5kJGRTNcqqJLF
         aeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729564; x=1757334364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JgtE5NuuXHXwQbDBEsNd3TAksX6P3TmTjBg+zdfY+I=;
        b=U+21q8Y2ljTI4mXUe2ljOwh1rTmygtmqht/eLA1nsJK9SCpzvUyr4vTncl8arei7S9
         7QLQP2Pt5I93ddn1nH/LGWlHKuBXM0vy/7Z5EwqAPlPEpEWj97G7iYIWB++bK+lVDsqG
         6gOd4ejNY7LcpbSF4xnGs+VNEVxlLm5KxmvBsO/bN/ZkzB/C5psJQIf5p+gWX1f9pG/8
         5WLbDOo/QHrloBNRpT3FQGGjZzfzkYXNOFBV7kWvlODBNsVzHFZS2Q16eTBCfi4mKNfE
         gmfwvGjyRmn9FJJ8lsnFDRakpIjKe0nNjpWrxXLy9ZO2Qya9V9f8wfgjMj91O/FbXkam
         NQTw==
X-Forwarded-Encrypted: i=1; AJvYcCVLocQ2sU6JRVOq17j1OJ4X723nQZdBMP4HJgg1KH/iBOKjFOjylSQvxTeDlTSkPoFkaR7r/UBq7ecYjVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjCAxgdJF0nC/u13V+y6VROxKwfvoq8xuKJPKWM6/ZmM0Wd6G1
	PO/rsJSP5HiSXv4GXLetBXPnzn2LKRQMMTJXeehUneVQIkXj3APU8inQ
X-Gm-Gg: ASbGncvqnOX6dJaL8FizKOfFFV3yo9XOHDCKCxMT88XQBJAzxSzCCTq3pd5igof+xOO
	5so4Zi4pcItBOoxHfIIoK7ylPQ5hf54tDMNk3J76fet3FYNptG9dU4mBRRONc7mR9af4uxpLgk6
	bpTQ6czdb6+sMbJTM2kHhVe5dk6IAC9pLCxcneqNu3VzAr/hJJqMQF97p2xFsoJUiNeMVlG1XCs
	k3eNRBmyd+gfaARgDvXy7MMPs+wPPZ+3AGnW5EWGzAXa47kddW9T9espyQhqHkcpn9W3PxKz+vs
	uX4nBFa2J2hwckOiJt8rrnMEvO80fTc/Y9/xLKEda/ZCidJ0zswB7oE9DXZvzmSICnJIk6WGBON
	ePWllj320QaE6q+45eor0TKec/a4EWnpPQZgrb3g=
X-Google-Smtp-Source: AGHT+IFUS9N82v4LejUCnaAT3ShRWZlyXqFT/fzgSHXZJE0Z1sfiw8nQGQijs8Remh450z6mWmsI/g==
X-Received: by 2002:adf:f10c:0:b0:3d2:45f0:45bd with SMTP id ffacd0b85a97d-3d245f04afbmr4208349f8f.23.1756729563972;
        Mon, 01 Sep 2025 05:26:03 -0700 (PDT)
Received: from fedora ([94.73.32.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b74950639sm207297055e9.17.2025.09.01.05.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:26:03 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	sebastian.wick@redhat.com,
	xaver.hugl@kde.org,
	victoria@system76.com,
	a.hindborg@kernel.org,
	leitao@debian.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Mark Yacoub <markyacoub@google.com>,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v6 08/16] drm/vkms: Allow to configure multiple encoders via configfs
Date: Mon,  1 Sep 2025 14:25:33 +0200
Message-ID: <20250901122541.9983-9-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901122541.9983-1-jose.exposito89@gmail.com>
References: <20250901122541.9983-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Louis Chauvet <louis.chauvet@bootlin.com>

Create a default subgroup at /config/vkms/encoders to allow to create as
many encoders as required.

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  6 ++
 drivers/gpu/drm/vkms/vkms_configfs.c | 87 ++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index c79fca3d3a11..622fbfa12a84 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -76,6 +76,7 @@ And directories are created for each configurable item of the display pipeline::
   tree /config/vkms/my-vkms
   ├── crtcs
   ├── enabled
+  ├── encoders
   └── planes
 
 To add items to the display pipeline, create one or more directories under the
@@ -98,6 +99,10 @@ CRTCs have 1 configurable attribute:
 
 - writeback: Enable or disable writeback connector support by writing 1 or 0
 
+Next, create one or more encoders::
+
+  sudo mkdir /config/vkms/my-vkms/encoders/encoder0
+
 To finish the configuration, link the different pipeline items::
 
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
@@ -119,6 +124,7 @@ And removing the top level directory and its subdirectories::
   sudo rm /config/vkms/my-vkms/planes/*/possible_crtcs/*
   sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms/crtcs/*
+  sudo rmdir /config/vkms/my-vkms/encoders/*
   sudo rmdir /config/vkms/my-vkms
 
 Testing With IGT
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 2cf97c2b6203..0df86e63570a 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -18,6 +18,7 @@ static bool is_configfs_registered;
  * Initialized when a new directory is created under "/config/vkms/"
  * @planes_group: Default subgroup of @group at "/config/vkms/planes"
  * @crtcs_group: Default subgroup of @group at "/config/vkms/crtcs"
+ * @encoders_group: Default subgroup of @group at "/config/vkms/encoders"
  * @lock: Lock used to project concurrent access to the configuration attributes
  * @config: Protected by @lock. Configuration of the VKMS device
  * @enabled: Protected by @lock. The device is created or destroyed when this
@@ -27,6 +28,7 @@ struct vkms_configfs_device {
 	struct config_group group;
 	struct config_group planes_group;
 	struct config_group crtcs_group;
+	struct config_group encoders_group;
 
 	struct mutex lock;
 	struct vkms_config *config;
@@ -63,6 +65,20 @@ struct vkms_configfs_crtc {
 	struct vkms_config_crtc *config;
 };
 
+/**
+ * struct vkms_configfs_encoder - Configfs representation of a encoder
+ *
+ * @group: Top level configuration group that represents a encoder.
+ * Initialized when a new directory is created under "/config/vkms/encoders"
+ * @dev: The vkms_configfs_device this encoder belongs to
+ * @config: Configuration of the VKMS encoder
+ */
+struct vkms_configfs_encoder {
+	struct config_group group;
+	struct vkms_configfs_device *dev;
+	struct vkms_config_encoder *config;
+};
+
 #define device_item_to_vkms_configfs_device(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_device, \
 		     group)
@@ -80,6 +96,10 @@ struct vkms_configfs_crtc {
 #define crtc_item_to_vkms_configfs_crtc(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_crtc, group)
 
+#define encoder_item_to_vkms_configfs_encoder(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_encoder, \
+		     group)
+
 static ssize_t crtc_writeback_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_crtc *crtc;
@@ -344,6 +364,69 @@ static const struct config_item_type plane_group_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static void encoder_release(struct config_item *item)
+{
+	struct vkms_configfs_encoder *encoder;
+	struct mutex *lock;
+
+	encoder = encoder_item_to_vkms_configfs_encoder(item);
+	lock = &encoder->dev->lock;
+
+	scoped_guard(mutex, lock) {
+		vkms_config_destroy_encoder(encoder->dev->config, encoder->config);
+		kfree(encoder);
+	}
+}
+
+static struct configfs_item_operations encoder_item_operations = {
+	.release	= &encoder_release,
+};
+
+static const struct config_item_type encoder_item_type = {
+	.ct_item_ops	= &encoder_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group *make_encoder_group(struct config_group *group,
+					       const char *name)
+{
+	struct vkms_configfs_device *dev;
+	struct vkms_configfs_encoder *encoder;
+
+	dev = child_group_to_vkms_configfs_device(group);
+
+	scoped_guard(mutex, &dev->lock) {
+		if (dev->enabled)
+			return ERR_PTR(-EBUSY);
+
+		encoder = kzalloc(sizeof(*encoder), GFP_KERNEL);
+		if (!encoder)
+			return ERR_PTR(-ENOMEM);
+
+		encoder->dev = dev;
+
+		encoder->config = vkms_config_create_encoder(dev->config);
+		if (IS_ERR(encoder->config)) {
+			kfree(encoder);
+			return ERR_CAST(encoder->config);
+		}
+
+		config_group_init_type_name(&encoder->group, name,
+					    &encoder_item_type);
+	}
+
+	return &encoder->group;
+}
+
+static struct configfs_group_operations encoders_group_operations = {
+	.make_group	= &make_encoder_group,
+};
+
+static const struct config_item_type encoder_group_type = {
+	.ct_group_ops	= &encoders_group_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
 static ssize_t device_enabled_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_device *dev;
@@ -447,6 +530,10 @@ static struct config_group *make_device_group(struct config_group *group,
 				    &crtc_group_type);
 	configfs_add_default_group(&dev->crtcs_group, &dev->group);
 
+	config_group_init_type_name(&dev->encoders_group, "encoders",
+				    &encoder_group_type);
+	configfs_add_default_group(&dev->encoders_group, &dev->group);
+
 	return &dev->group;
 }
 
-- 
2.51.0


