Return-Path: <linux-kernel+bounces-794513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FEFB3E2D1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 227D87ACE65
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9378D3375DA;
	Mon,  1 Sep 2025 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoVtFxxO"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05287327793
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729571; cv=none; b=PTRJ+33Rx4e0KgTQLLxivFW+MffGKSUNZHu2hgTddHXqwbvUuTRRdQvODhxSRJFXFlU7kz2zXEtQwETqBCKsFJ6ug6mkDvUqgVbCu3EpkJtU8chVIeEVBUb7O+kBLL03Zs/WXB8v+5Sbof9IHa/AWlXklbUrQX2h2VjMUslXn9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729571; c=relaxed/simple;
	bh=XFSBXaaD6OaoZco136/dUGDK+RiVWSWCvGFUfvxzcnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=av1wMCSmi7BHI6NMXW0j1QVNgYNyi3iSP0Cu+BLk6XEku3exKZnrETdnDc3qdH9HGvsH+AVpNWqQDGeHXdevRFDeaFLSTZoLP6vHhqHnS4bdL7SC9cqdI2dNwwfCr3HpCc52I+A1c+lqkt3KzvtHmmoW21PhiTC92Tw58lfM3VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoVtFxxO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b84367affso19200625e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756729567; x=1757334367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EdjA0vhrNddd+9i5gDB5y7gnZlz2SruMLXGVcghljI=;
        b=QoVtFxxOUPmiNykZx+yoXRZv7Q2trNODMVYqmKieAzCpH3CQa7bWu+MEGLva9SbZCi
         +Ie9cD3cNCdK2A3/oIYOUa8gIIj2pvu3WlQEYcs85tOX6bJy8yIZHvX7VSUY8RzLsatV
         Jv/NaH0n8as71HznCVNsGB2DrVZx8NzXBy5s0exFmQPgPZTgyAtKMC0kV1UnhlB6Pabh
         rM2PDi+YiHq9V1FXgUVCaYrk4bCY3ttJi8vQw8s6CQ3kbo+GzWPVBarQ7ZGVbhPM1r8p
         FSf1scpMasqih4Te7awz4yBDJV+zofxbb3SNE9w53sB8L6JMvX3FRGHvOlFHueyie9VJ
         RNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729567; x=1757334367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+EdjA0vhrNddd+9i5gDB5y7gnZlz2SruMLXGVcghljI=;
        b=MEadAYgt2Yv/qSunRjF1NTrJ0CdJmei0RvGHbbiJIzoKUR+QXcCBeuJzmPqUGxjKdY
         jKIAHq7XwZGIiBSJx60a9AVH+znQIwOS/cQa3gSoAlgaLqDj+PBqIk+cAb2WMOtPUIsc
         e2UH8Bn/tq02CxHNnZx2jU4GLdTjR1n328SCvA3jWXpCRCnWyuzkz4zitk4LLJP8447V
         QxiypEDvp7dRSpXYFFQ/ToD/0lEdBfZMe51c/+3BbiqrIlD/gp4H9to9ASo1Ymqm46do
         CQNgZFsZ4zDzHIPZLikZtQL3CGtyPr0LeireaNQUTpW55NLVHOh/Wq3V7Wh4vJm4Rl86
         ZKEA==
X-Forwarded-Encrypted: i=1; AJvYcCX4NCdfJ14JbLeIE1hve/CRmqfNPYkZ0kUxGiJvd4t8TyrNmyJZdwxEdLFFJOfzNiI7OI3sY0mot8OW1a4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4b3IhiH4+HnS90Cj9/GfllFV4u+6rQ6UrGmsiYBsbUx0jZf3I
	y+VYIQuvHLJ6YRJsOGW4MVa7PaQClGI6OcqAY/f9y6JdbUE7wUJ2uaCj8IKDzQ2PSa8=
X-Gm-Gg: ASbGncuJbUNza+/1q66Tbu2mZpG4XobVfYt6sLZqfb7cUgPFw4Otnbwjb/0vGbIS+v/
	Ro4CJVWf/gaHUQkNa1Ptrzj2B2p8X3Qz4+YpkIgG0QwF3G+C2/dEz3vUjBUp6NJmxt4W7tZ1Po4
	cVyowv+ZOmVeTiFRkPiVU7Mv+g0t747RpWiBurhl6uSrcD1A/2i4tJkjHNid3WNaoIDeCGQFi1o
	XGKzWp4W01/MpIo4kDEJsvySgzYoxpXcE64+8h40J69Kc3kZECBUSMscARiBThh1+5bc9Z8YmpC
	j/WlSaUK1lB9RtqfHFVvnQl/UTLbcf2SkfnMJLdnngfU6hEjF6lLgq0skBQzmTICQKu+xE9DbAv
	p9wEnPVPJ7VSm/ZBE3A==
X-Google-Smtp-Source: AGHT+IHOAqp/LTkHn6qqCuhKN9S0f6/aF1NMMUjbDRqd5pkFBV9AV+5lbxu0lm/Ili6PnKTocBLI3w==
X-Received: by 2002:a05:600c:3115:b0:45b:81b4:1917 with SMTP id 5b1f17b1804b1-45b8555c359mr65565965e9.10.1756729566932;
        Mon, 01 Sep 2025 05:26:06 -0700 (PDT)
Received: from fedora ([94.73.32.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b74950639sm207297055e9.17.2025.09.01.05.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:26:05 -0700 (PDT)
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
Subject: [PATCH v6 10/16] drm/vkms: Allow to configure multiple connectors via configfs
Date: Mon,  1 Sep 2025 14:25:35 +0200
Message-ID: <20250901122541.9983-11-jose.exposito89@gmail.com>
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

Create a default subgroup at
/config/vkms/connectors to allow to create as many connectors as
required.

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
index 585effe90550..b799102d54ac 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -74,6 +74,7 @@ By default, the instance is disabled::
 And directories are created for each configurable item of the display pipeline::
 
   tree /config/vkms/my-vkms
+  ├── connectors
   ├── crtcs
   ├── enabled
   ├── encoders
@@ -103,6 +104,10 @@ Next, create one or more encoders::
 
   sudo mkdir /config/vkms/my-vkms/encoders/encoder0
 
+Last but not least, create one or more connectors::
+
+  sudo mkdir /config/vkms/my-vkms/connectors/connector0
+
 To finish the configuration, link the different pipeline items::
 
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
@@ -127,6 +132,7 @@ And removing the top level directory and its subdirectories::
   sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms/crtcs/*
   sudo rmdir /config/vkms/my-vkms/encoders/*
+  sudo rmdir /config/vkms/my-vkms/connectors/*
   sudo rmdir /config/vkms/my-vkms
 
 Testing With IGT
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 7de601e39d2b..692e1b708012 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -19,6 +19,7 @@ static bool is_configfs_registered;
  * @planes_group: Default subgroup of @group at "/config/vkms/planes"
  * @crtcs_group: Default subgroup of @group at "/config/vkms/crtcs"
  * @encoders_group: Default subgroup of @group at "/config/vkms/encoders"
+ * @connectors_group: Default subgroup of @group at "/config/vkms/connectors"
  * @lock: Lock used to project concurrent access to the configuration attributes
  * @config: Protected by @lock. Configuration of the VKMS device
  * @enabled: Protected by @lock. The device is created or destroyed when this
@@ -29,6 +30,7 @@ struct vkms_configfs_device {
 	struct config_group planes_group;
 	struct config_group crtcs_group;
 	struct config_group encoders_group;
+	struct config_group connectors_group;
 
 	struct mutex lock;
 	struct vkms_config *config;
@@ -81,6 +83,20 @@ struct vkms_configfs_encoder {
 	struct vkms_config_encoder *config;
 };
 
+/**
+ * struct vkms_configfs_connector - Configfs representation of a connector
+ *
+ * @group: Top level configuration group that represents a connector.
+ * Initialized when a new directory is created under "/config/vkms/connectors"
+ * @dev: The vkms_configfs_device this connector belongs to
+ * @config: Configuration of the VKMS connector
+ */
+struct vkms_configfs_connector {
+	struct config_group group;
+	struct vkms_configfs_device *dev;
+	struct vkms_config_connector *config;
+};
+
 #define device_item_to_vkms_configfs_device(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_device, \
 		     group)
@@ -106,6 +122,10 @@ struct vkms_configfs_encoder {
 	container_of(to_config_group((item)), struct vkms_configfs_encoder, \
 		     possible_crtcs_group)
 
+#define connector_item_to_vkms_configfs_connector(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_connector, \
+		     group)
+
 static ssize_t crtc_writeback_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_crtc *crtc;
@@ -485,6 +505,69 @@ static const struct config_item_type encoder_group_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static void connector_release(struct config_item *item)
+{
+	struct vkms_configfs_connector *connector;
+	struct mutex *lock;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+	lock = &connector->dev->lock;
+
+	scoped_guard(mutex, lock) {
+		vkms_config_destroy_connector(connector->config);
+		kfree(connector);
+	}
+}
+
+static struct configfs_item_operations connector_item_operations = {
+	.release	= &connector_release,
+};
+
+static const struct config_item_type connector_item_type = {
+	.ct_item_ops	= &connector_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group *make_connector_group(struct config_group *group,
+						 const char *name)
+{
+	struct vkms_configfs_device *dev;
+	struct vkms_configfs_connector *connector;
+
+	dev = child_group_to_vkms_configfs_device(group);
+
+	scoped_guard(mutex, &dev->lock) {
+		if (dev->enabled)
+			return ERR_PTR(-EBUSY);
+
+		connector = kzalloc(sizeof(*connector), GFP_KERNEL);
+		if (!connector)
+			return ERR_PTR(-ENOMEM);
+
+		connector->dev = dev;
+
+		connector->config = vkms_config_create_connector(dev->config);
+		if (IS_ERR(connector->config)) {
+			kfree(connector);
+			return ERR_CAST(connector->config);
+		}
+
+		config_group_init_type_name(&connector->group, name,
+					    &connector_item_type);
+	}
+
+	return &connector->group;
+}
+
+static struct configfs_group_operations connectors_group_operations = {
+	.make_group	= &make_connector_group,
+};
+
+static const struct config_item_type connector_group_type = {
+	.ct_group_ops	= &connectors_group_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
 static ssize_t device_enabled_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_device *dev;
@@ -592,6 +675,10 @@ static struct config_group *make_device_group(struct config_group *group,
 				    &encoder_group_type);
 	configfs_add_default_group(&dev->encoders_group, &dev->group);
 
+	config_group_init_type_name(&dev->connectors_group, "connectors",
+				    &connector_group_type);
+	configfs_add_default_group(&dev->connectors_group, &dev->group);
+
 	return &dev->group;
 }
 
-- 
2.51.0


