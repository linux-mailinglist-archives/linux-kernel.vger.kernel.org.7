Return-Path: <linux-kernel+bounces-856739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7352CBE4F38
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59221A66D14
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CFE328B6A;
	Thu, 16 Oct 2025 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T081cgN0"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494A930507B
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637415; cv=none; b=i0NRdHu18COGdkwUjYgmNlSd3+8G2UDWxS3gAofkJQUgLZB4yqTztx18SDgtt6FNh9AD2V63maPOY69qm8MLp2gJmUCWepewpCu08gNKkKftPapazffs8FRNmf6wCpFAjezImYusE6p6D9qcQkoFPD8cWp90/EZ4n8wKdgrzNtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637415; c=relaxed/simple;
	bh=1BD/vMhc5C4/KXDPH3UtYDcqVdBuQ7g4AdOmewpNI0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXSxTMQUoElKNDnVgYzhuKIdSjuCIfcAi7pcucy4LTjv4Vv7e3L7PuGYkfq8GwWZa57mxoIpL1X+rQ4jrZUZoUe4UNMQYcxwFDi5Dt8rEfHzz6LiwgF6VIVarF993JFQvLBBy6MjZ9/o6X/+q10ysCA/WAMcRODyKnBd9WCiuDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T081cgN0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-471131d6121so7986765e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760637412; x=1761242212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGUtCgFFoXd45FbRxgjbsSLBSJAtFLMTFGzAm8+mRmI=;
        b=T081cgN0DXeMjN1xqQkeX9JeW+TJyiu/IJz7tKW60kJrfuGOtP9OF8huB/Z/dhJFw1
         iW1yB7CE/fewK3fPCXeY3FekT8DQfOeFbxbVmH6mM/YOcyNjtPmH7Ftkjzr72O9VduFq
         /WXiD8cqw7SXAPFQYIccsrNNHg0XXHsZ2oQdbYnwsolKYg5mQXf9t3v7SHGRh6FG17Kb
         0l5omw+nLUj03hEx12sTc+eZL13yCLXjQCjTaFTkxPYk4Gaiyj0bnkD1bX76TcedyyZS
         9L8TM65UVoEkibT+Bs+teGpE2Ny8vSIAvqudLqVdEe7VDjeCSpBpLlyI5cnEcYUk7IJ2
         Iv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637412; x=1761242212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGUtCgFFoXd45FbRxgjbsSLBSJAtFLMTFGzAm8+mRmI=;
        b=KrQAKwajB8/3k+j+q75b6RnJMFySySiL4oeDneD2UTe5OHof60Z+vU9jL/BozEiBkZ
         iqup3fc0IMGA3oTr19V7lDoUkMS7XvSSsbL9GDhtrf4UtpCK6XHTgCZgXXbua5XanGIg
         mfVw6QEoOr1av4FWXzCB7AhjsYvPQy5r4s/79Y5fT2xwFvuvTyjEE+akp9QyzTd41HdE
         mVmlNRHfJ92pxi2mbUZbya2J+D8I3Q+sGPaXDTl3+yC+i6YDGU+mvOEBVBdGqOEsJMAL
         6yeX9ye0/f4fn0w83nxe55AWn1X8UD1SONBm8qNmVSU7eCcoq1hOclwXc0O87G1WVbZQ
         AJPA==
X-Forwarded-Encrypted: i=1; AJvYcCVv1caDed/lim0+8sJuAVb1nsuDU4R0BQLkdWxcgrw7insA5ShhrnJ9maYcCXLjjn2FpvGVkQBqCBtoTc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs2AFl+jenB4QabWdUYTh7wW58t/PfV/lCnyzoLxmgSs3kfFB6
	JPP5VUCWavQopkfPdKdvMmeDA8u4NID61S0M0UpsgQI+DdKrpDZG+JOH
X-Gm-Gg: ASbGnctYMTvChJDArEVDPSJHN1mn1FT208Jtp3doKt/EbtntjuGDlJMfj4IA0fR8ZFd
	dwcFJWhj3jF+rQeRfjU70IoBm8Zr68NVK9djuwHeMxsZn+6nIhoLIZfNHYnlP6IcB+XH5dCKWpK
	La8wcZ3XhIOHo7bFEKxbxDiEcbZYc5BxYVF52EeGrWxGopQn9Bkv4hs42HJlLM5Av9jm8yfaR0H
	juA43XIQcxAYavk5vet8ioDY5G0m6uWiXpU3tm0Fl+X9xcY8RZK4GP2Uov9RovxvFJVDrtl6ih+
	Cx0woYIl2eSEMi5l5xks81/ld1ZZrIjs/85Sdh1rujlZZ2d9Js08DmoFvneuPKOHGYkm+5M2WC+
	s9QgX/LvaXhdhZmB66RUdYQA50cesMILeswWwo0OjBSZij115+8UPZAPo7f5My72UM24AA5HryQ
	U=
X-Google-Smtp-Source: AGHT+IFEhkEP2rWhFXfs1BfUbqPK66UYyDsccgDeF2I7iSGE0nEET1+OiE6yftP/lfqlaezeKSA7GA==
X-Received: by 2002:a05:600c:450a:b0:46e:442c:f5e1 with SMTP id 5b1f17b1804b1-4711791cb1fmr6649095e9.35.1760637411559;
        Thu, 16 Oct 2025 10:56:51 -0700 (PDT)
Received: from fedora ([94.73.33.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm35344023f8f.35.2025.10.16.10.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:56:51 -0700 (PDT)
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
Subject: [PATCH v7 08/16] drm/vkms: Allow to configure multiple encoders via configfs
Date: Thu, 16 Oct 2025 19:56:10 +0200
Message-ID: <20251016175618.10051-9-jose.exposito89@gmail.com>
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

Create a default subgroup at /config/vkms/encoders to allow to create as
many encoders as required.

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
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


