Return-Path: <linux-kernel+bounces-794507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 000FDB3E2C8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC4817A9F7B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699BD32BF22;
	Mon,  1 Sep 2025 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAKxGbdR"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3F2326D5B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729563; cv=none; b=TBs9Nhrq5+O/PASPxasv7+iPImEWpi16+9A+arRhdyt5uNBi+AKAdoHHaaWLWCUnyIpG8qLdBTVFcJEGzeNaa135vKQS7c/7Mow8A/BZtkpXwyPRCnNJ1XUocbT7tRM4V+8IgAnbEf/w7f8kWLk8PhOr01KPJd6Wf2Ho1bl9JOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729563; c=relaxed/simple;
	bh=N7jfKW0HejF8V/f2I/ck26ZqZpC29vYRSlYZ0Zq3I3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvCqf/MRv8EhvMNXSBLVjXo0RFfbgAU8Ry9h6vAlR36TLxihwlx2u2kQpGajceRReufotTqTDetqQzoU8Jbi4yvvRqWZUy8TX2XiKg3CQThdGNfYb58UCXsbEGok7VFh+doibe8DXOztIch8O0nKWwlTJeevJnLCpNVsLw5NCAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAKxGbdR; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3d0dd9c9229so2200954f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756729560; x=1757334360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Kd+8v+lNqUBf/GT3Tpl70jL5RnUvrkjCq/aFbg8lmY=;
        b=EAKxGbdReRRJCLVasMHz1ZWngkVWLMVZLSoTD9oOSpCTMqkSMloCJmh+Hui6abCin3
         dnEt/NeTV0RpFOd9aP6Z9f/nI4HYTBOoTaZSpLEJbtWqOI+g0l6yMfqukSsjRMETSBJu
         DkyFoF7jpyq3XUw+IXW//JvHXVQKjYlm0dlfxA6BxNEbjK/LwavDfk4PTuDYtxKbMUIv
         2fAgwEcMtpEweAvU/Q+gMYDgrGkLoCA3hpprCeSmrCxsH6ifc5RdJbWelPNyzYB2WT7x
         Juk3ozMOcjHB/vd5zfKq+u31DOtxLD2AXA9IPqpTVB3mSpsLH+Z1VpYJ2SQH0NAuOuAq
         JpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729560; x=1757334360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Kd+8v+lNqUBf/GT3Tpl70jL5RnUvrkjCq/aFbg8lmY=;
        b=gOS/ykre/M/UasQ+PO9Z+29YvX2YMn9sytOnnoXdnguWT6h/ihvmj0678fEZRZSLMo
         NCPi5AE9KX2SbIBjEH0OQBR+j+39CjMT/JL8dz9XD5qpX6Gz2YsFW4eloc/gDOgMwdU/
         hNF7nGhvXEsKev8NJ5acKF/ujXwLab2/PxVF2xIMKOiz4+kvLnsiJn1ggW5hi6gKe/jD
         ZM8P8Vca9n6t9adV9VrAUO4AcLS0djhIoJV2FRpg9bIyGaKI5z3SR2/6Yz4qDDsqM2IZ
         OU6DhSiiZmCKyaWlRklAnPocmLvAMJj6me36FWQl2xGTEP18soQUlN2wS8f4HMXvk++Z
         SgyA==
X-Forwarded-Encrypted: i=1; AJvYcCWMQA+9MWvWSbCoHDMQYDpRyPWWtRhTvWGdhNMfcK9Vox+DTV6xUzR08Vpy5jeWNhzJ1dxqivHrQsC03rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVpTnpmB2Yhbb4a9AEVy9m6mgQzN6XftSYLVuR7mfWNyDBMtDe
	gFo2iN7Ju9gW4LzdHUKi+emzCcSL9/pQJ1GkIAnPgWuq/cSZhs4CVZw0
X-Gm-Gg: ASbGncuyYyx8/2v53MfufG211zL6CnqxqI3pxwYMPr5djRc4Cjp3mQ0qUOyEH+I9T2d
	H+uCzR5cEkQsMkm35pmGy88Ux7DHDaLgHaL6Pwa3Gbv05Eof46Qgtr+LHoNnKGGWvu0UBS0g1Sv
	7rGaCP8umc3+dUNk+IA6bQ0YairYNrQ0M7hRfNI78UdStAt3K7TyPAeSg44VgdF2SRzTSgmq9Xn
	07yLdTq9MDegUmft8sao56kJf8K1QdPpaRQr+NRevpDmX41ZxnGlxCKHGnGnQPgc+eXoPTqMAbG
	g8Fr7WojKLcV7tQjVZ4jFrYkg6+ngEVQ8AQouVwAKeFVRC2wQWtyezVdYV/EjBDuFkaVaM2uM2q
	oip8txCcRbAvWwLrKvw==
X-Google-Smtp-Source: AGHT+IGuuEBOjNbXGYS5rZ0vDEw96Ox0pQNqekC/kGf/n5YBjqljMAsIMyYDoKNWBmt/er9Fy0jYKA==
X-Received: by 2002:a05:6000:420e:b0:3ca:3b3f:ec8e with SMTP id ffacd0b85a97d-3d1dfc072bamr8174078f8f.39.1756729559914;
        Mon, 01 Sep 2025 05:25:59 -0700 (PDT)
Received: from fedora ([94.73.32.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b74950639sm207297055e9.17.2025.09.01.05.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:25:59 -0700 (PDT)
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
Subject: [PATCH v6 05/16] drm/vkms: Allow to configure multiple CRTCs via configfs
Date: Mon,  1 Sep 2025 14:25:30 +0200
Message-ID: <20250901122541.9983-6-jose.exposito89@gmail.com>
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

Create a default subgroup at /config/vkms/crtcs to allow to create as
many CRTCs as required.

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  6 ++
 drivers/gpu/drm/vkms/vkms_configfs.c | 85 ++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index dd880ce6811c..7396447b5e58 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -74,6 +74,7 @@ By default, the instance is disabled::
 And directories are created for each configurable item of the display pipeline::
 
   tree /config/vkms/my-vkms
+  ├── crtcs
   ├── enabled
   └── planes
 
@@ -89,6 +90,10 @@ Planes have 1 configurable attribute:
 - type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
   exposed by the "type" property of a plane)
 
+Continue by creating one or more CRTCs::
+
+  sudo mkdir /config/vkms/my-vkms/crtcs/crtc0
+
 Once you are done configuring the VKMS instance, enable it::
 
   echo "1" | sudo tee /config/vkms/my-vkms/enabled
@@ -100,6 +105,7 @@ Finally, you can remove the VKMS instance disabling it::
 And removing the top level directory and its subdirectories::
 
   sudo rmdir /config/vkms/my-vkms/planes/*
+  sudo rmdir /config/vkms/my-vkms/crtcs/*
   sudo rmdir /config/vkms/my-vkms
 
 Testing With IGT
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 398755127759..62a82366791d 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -17,6 +17,7 @@ static bool is_configfs_registered;
  * @group: Top level configuration group that represents a VKMS device.
  * Initialized when a new directory is created under "/config/vkms/"
  * @planes_group: Default subgroup of @group at "/config/vkms/planes"
+ * @crtcs_group: Default subgroup of @group at "/config/vkms/crtcs"
  * @lock: Lock used to project concurrent access to the configuration attributes
  * @config: Protected by @lock. Configuration of the VKMS device
  * @enabled: Protected by @lock. The device is created or destroyed when this
@@ -25,6 +26,7 @@ static bool is_configfs_registered;
 struct vkms_configfs_device {
 	struct config_group group;
 	struct config_group planes_group;
+	struct config_group crtcs_group;
 
 	struct mutex lock;
 	struct vkms_config *config;
@@ -45,6 +47,20 @@ struct vkms_configfs_plane {
 	struct vkms_config_plane *config;
 };
 
+/**
+ * struct vkms_configfs_crtc - Configfs representation of a CRTC
+ *
+ * @group: Top level configuration group that represents a CRTC.
+ * Initialized when a new directory is created under "/config/vkms/crtcs"
+ * @dev: The vkms_configfs_device this CRTC belongs to
+ * @config: Configuration of the VKMS CRTC
+ */
+struct vkms_configfs_crtc {
+	struct config_group group;
+	struct vkms_configfs_device *dev;
+	struct vkms_config_crtc *config;
+};
+
 #define device_item_to_vkms_configfs_device(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_device, \
 		     group)
@@ -55,6 +71,71 @@ struct vkms_configfs_plane {
 #define plane_item_to_vkms_configfs_plane(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_plane, group)
 
+#define crtc_item_to_vkms_configfs_crtc(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_crtc, group)
+
+static void crtc_release(struct config_item *item)
+{
+	struct vkms_configfs_crtc *crtc;
+	struct mutex *lock;
+
+	crtc = crtc_item_to_vkms_configfs_crtc(item);
+	lock = &crtc->dev->lock;
+
+	scoped_guard(mutex, lock) {
+		vkms_config_destroy_crtc(crtc->dev->config, crtc->config);
+		kfree(crtc);
+	}
+}
+
+static struct configfs_item_operations crtc_item_operations = {
+	.release	= &crtc_release,
+};
+
+static const struct config_item_type crtc_item_type = {
+	.ct_item_ops	= &crtc_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group *make_crtc_group(struct config_group *group,
+					    const char *name)
+{
+	struct vkms_configfs_device *dev;
+	struct vkms_configfs_crtc *crtc;
+
+	dev = child_group_to_vkms_configfs_device(group);
+
+	scoped_guard(mutex, &dev->lock) {
+		if (dev->enabled)
+			return ERR_PTR(-EBUSY);
+
+		crtc = kzalloc(sizeof(*crtc), GFP_KERNEL);
+		if (!crtc)
+			return ERR_PTR(-ENOMEM);
+
+		crtc->dev = dev;
+
+		crtc->config = vkms_config_create_crtc(dev->config);
+		if (IS_ERR(crtc->config)) {
+			kfree(crtc);
+			return ERR_CAST(crtc->config);
+		}
+
+		config_group_init_type_name(&crtc->group, name, &crtc_item_type);
+	}
+
+	return &crtc->group;
+}
+
+static struct configfs_group_operations crtcs_group_operations = {
+	.make_group	= &make_crtc_group,
+};
+
+static const struct config_item_type crtc_group_type = {
+	.ct_group_ops	= &crtcs_group_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
 static ssize_t plane_type_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_plane *plane;
@@ -262,6 +343,10 @@ static struct config_group *make_device_group(struct config_group *group,
 				    &plane_group_type);
 	configfs_add_default_group(&dev->planes_group, &dev->group);
 
+	config_group_init_type_name(&dev->crtcs_group, "crtcs",
+				    &crtc_group_type);
+	configfs_add_default_group(&dev->crtcs_group, &dev->group);
+
 	return &dev->group;
 }
 
-- 
2.51.0


