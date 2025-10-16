Return-Path: <linux-kernel+bounces-856736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FE6BE4F2F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D4C1A66C79
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1212E2822;
	Thu, 16 Oct 2025 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePwwUShp"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F3E23184A
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637412; cv=none; b=Z4D347OMkYSIAtQ4tmY16S27EjHfJgvuhlcHJ2XZnsbISCeauvjZpwhJ3J6VHpYHSAZDQnJQRdE8vQ23dQUpiJitPpknd9HSPvr2eiAm0xfrB5TcBHO8ZX1ykjI2PbYLVQHhADD3L7bGBZYdncALOoUrtMnf1jvJBGvKFuRlHWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637412; c=relaxed/simple;
	bh=J1Nzzoca4/yyZZCTsha/JR1pQ1mNUiLyRWjyrF7sQF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHX3V+uRFlV63EskP9f6IxFxVrnFZoleIK2zxxAASQRp5eBnqVJeYCUQ8zkJx60JUvEyZV07F5DTCRvW7MJOrNerpUZKtdaIeZ1bmRYNvxql+eg5BmgLHoHavuss91Nu8MJB2yV+v+op8k3oYlFse8nsb0S7/92rjWiA4bOXs+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePwwUShp; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4060b4b1200so930576f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760637408; x=1761242208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gre0hLy87h83qf778dekTlWQHTtBdhwlJ9xEAc8W+IY=;
        b=ePwwUShplA1LgeZRZzmO3gewV82chMvdrucpRDufLBknYnMPdHBbBNxwURO/eaHS+P
         ARx6nuUU0b1cse74pKP30+FzADtsE0gGQ0UzReumapQB/g6QUE8hJt+/WtTlp7xBylx8
         nkQcq58n4S/LRtrp9GhYhhfJdDugg3RwydnpIUXES0QRb/q0oMnV0fiOugkEOfozhQXT
         rEtCU7ylwHi80VGB/XBIEgWW4n03Rg8dRLcj92OvgfUJVzRe4JJcv+4cdSheUYXevhng
         PhFYMUEoTOvdf/mzGLJ1q8eFKSlN941LVpdVCA7yPj+UJSBjG5Y13LUdLP3R81OMovlh
         6wFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637408; x=1761242208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gre0hLy87h83qf778dekTlWQHTtBdhwlJ9xEAc8W+IY=;
        b=Pr//mVWNtFsy1Sl4OUPtPPc19wBz0ZXxfAryvxbXO5c+AwMR49sbjs8w94u+F4Gb1P
         E8uqlTH5RWrOFE7ceFjRV409M8LROezzGFA/KgEi5cw+lA7x0fwAggiI7LnbWdcfznbl
         5x2cDFG5Iaq7W+utoFd0Lpqx4QqC3JcwC7QQzwOMC6iMMs/ZGBBNP4wWZ7yHlW++sOZD
         uXS+S3PYrn2AGvEOrDyrXTEXpkpfTkX1d9gIZ2t3XfWp3c3OSrUfYi5CqsgxXqWGxPk5
         R6EH2PZJF9vl8Gg2shIPJmSM9Vny6qd5Eb+R21EUGcH6bIcwUzevwQdhGsCzoi8CFL0X
         SujQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxyacZOiM4hQalw8gZVjcwkZPF91AEkiRRg4C087Bb6YbXtXODIflofS2jfr1UFOh1vyaJ6wYWYjclWvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx51a/Jdoee/vRCJTG49/sBb/tzjuDpj/mGgPVjByKPREs+s8vH
	r8x17aYdwXhdSKvJ7BlU3sFgUBFmHIdOSd4y8mAZJ8lOoMF0CAwH5nsT
X-Gm-Gg: ASbGncuJ36vOQVrUEfzta9aF+SJ03CWD0Cv0hCba+lis1Rwb4lFf9umFNLyK3ZdN/7e
	u2z+7tVSNYYfmyc279voYGtN5gh8AHnG85OBRAbvF45JrJrdV3zgC6jETOj+yPK/ax0Jp5gsf5/
	vXQB3vh+CZ6mGfcui21BjFFiUY/+sCaeEV5VTpr2avPmJohKfZvadKJ1pADydPQOE9lu9HG3Cqb
	BOOn9Tx4kPde69swlQpgsTIwRKxyG9Wr+th8i97XNstZlZY0cCtTYzB/3jQT+ml4BmL+n8qcx+Q
	m8ErzOWCrrQ9266czwJhtz4t0BFOOhtVXqBS/wGWFQTTiB1rZny/0PSS5Y94ZzOu3LKD1um8Zxz
	xUp5ys5k+4nEQUMmR5UlsqgdRNo1c+UXZ4+ha02I/B452emzS8P33Z4L136JuAP93B63iPwqXFk
	o=
X-Google-Smtp-Source: AGHT+IEMrIcCCPx1egEJk/xcCf7qUPRTvLrGolE5Y+y/fcEGOEgUDziNz/gt1rNFE8EOQYTWRi0o5A==
X-Received: by 2002:a5d:5d13:0:b0:427:45f:ee1a with SMTP id ffacd0b85a97d-42704d7b5ddmr804030f8f.25.1760637408141;
        Thu, 16 Oct 2025 10:56:48 -0700 (PDT)
Received: from fedora ([94.73.33.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm35344023f8f.35.2025.10.16.10.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:56:47 -0700 (PDT)
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
	Harry Wentland <harry.wentland@amd.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v7 05/16] drm/vkms: Allow to configure multiple CRTCs via configfs
Date: Thu, 16 Oct 2025 19:56:07 +0200
Message-ID: <20251016175618.10051-6-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016175618.10051-1-jose.exposito89@gmail.com>
References: <20251016175618.10051-1-jose.exposito89@gmail.com>
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
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
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


