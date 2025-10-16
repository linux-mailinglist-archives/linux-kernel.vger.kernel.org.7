Return-Path: <linux-kernel+bounces-856734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB743BE4F29
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935445E2FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C61231A41;
	Thu, 16 Oct 2025 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtBdAuNQ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9166122424E
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637409; cv=none; b=cABWQ2bVbEB1+5p1Sj5jhp42X5XtFtxOwF36k9fkwFFobZnENMxAYeQdTC3oGsP0y3pz8AwQRaRt3bGN6b5guq97/JILaiL7DNd8euQkTd2WEhU6jSzfgGAbf+EGWw1PCa2fbbL2ebOhRs9WNHksFNqrOg5UT7mJDYJE6f5XSl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637409; c=relaxed/simple;
	bh=5yKZuBoi7Bm9NZw3eA5YJHSvJngrwe7IYTYpbPBYYWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHy2C9CT49RbX/3LxvseljKDbPv3wK1K9WhLMscwu1G6+j41tHY4VdEW+IikZ31Nlv5Cw7FLekcL+kclesB8WBuvedw1Xk7uXCMIoeoL6l4k7CF+/abkcxW9dL223QJva3d8bcpTr6f6ErHqon2O/ZiX8dz4FJMMLK8FsjJ1K1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtBdAuNQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-471131d6121so7986025e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760637406; x=1761242206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLtrTTPFfD+8IrWwSmDlmKNovc5NDcW2sakE1jdQk8A=;
        b=DtBdAuNQfHbzc5j4BuZHNZnIgBggsEpf9IFJ22RnHgG/sinXaGfHkOvubRG2rgFvs4
         k24+X8+5lzkKUIS2zIRU5woSRnX+8TPePsV7a/Erja6S0zQiwae8TTjXx9slowFuMiYX
         4lDyg4sXuDA0+mk9kgt3viUy9QQf+u5K869FJKJz5JAjRJaw4KIbf8ej5NF2Wg+9EXfc
         49okTU7pJAn9NMcj/1Ebzm9zqlzsdndMTJ7Tg87ZvbTmMbWW40/1+H85tqPn3vT+JqzJ
         GkrQ8KWPKXFLJZdoKbsMb0H37XneU4FRpqr8Uto7AartXI5vbdvana8ehH7NMYo+wKzU
         j6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637406; x=1761242206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLtrTTPFfD+8IrWwSmDlmKNovc5NDcW2sakE1jdQk8A=;
        b=TR78qNXpvcpNchRACJOcDOdkZUzV9ZLq7+3qNYdeb1z9BROhnYCftr9L1471JDALAN
         6+zyTWoSCi2+BgFHoKZ7PrIdL0Q2GOSpYi1Eb9yajU3kasfOF0qZ4qj7TuMB4+QFRRED
         q9i/WMNYbejy8RcrtxqizVzreGFZmdPH7ICbmW+LQ6tbaxG29pRGB807E3mRQBuwH3nW
         oJGLNwK8WKRInpY+jLDD9kbT8tQA1olWd/xvT+mTRk8r+3H74ngLb/OCKNB9Q9kMUgv+
         jadIWXGqvBNxpUuYcw4lOEWhoPn8M+xIjRKMp4/1/INl7dE/JUC47xmteMqly2u8VQiI
         EenQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyqhxajLLQdKujEbZztozSS1E5bVAObxk11XgwL9+Lppv6VtL2coMeWSvg/9Os4CNlaZ64HuPHs1rSgQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrwgZD6E3dtCdF0EcwnSUQv/Ip28Alvnm3RDNkJUaKitwYiWuU
	1BOoCUQ+xegkHXPXbYBAuItRFhNtTPBiEwBBJfERUzuhHAePtgC4DzW8
X-Gm-Gg: ASbGncuBg3unmi8ncBhjs7vH/I22+wRPAZF49+AQJjuryhM7K4DbS94y3XkpekHwyc0
	Kkbk9arx9KhGpCozwv9X0JEX1JR6rimVfQ59A4xEEhEccLK2dehjXCLGHCu/JuNt9l3uFCmuf3B
	bOckUHPtT7K7FB++cwZT07+ZISaKU/bjkefdHBnEf3PveAY02MGB9CqsfGXlv8B35qEc6f1deZt
	A/PCGQcEOJyAz2MHL3xQMnwuEOprbEzC8qNL0cC77a6ktnNqEskmTIH6VkhgqLLGXaYwizQBZVG
	KlyhMj5LrZSyy398PQp3uE2F2+oBfruUHywMjRX/HE8zrOfnOfq5/J0mi4zkmS75DGNzJ+MlIip
	0t2aoC1BcqkrKpOae9s7slpfEOmeug2oaiGZzsS8nMBuK+JtvPUkIgDIX5svYg1vwm0rfDw8tH4
	RCrgmr5NAYvg==
X-Google-Smtp-Source: AGHT+IGtwT28xaTfBbSA0ncBa8fMQXZ02eYudn1PjoUHPrsoK1OdwE/M5iIpxKcnyWXvcIqcJ5fHSA==
X-Received: by 2002:a05:600c:548a:b0:471:ff3:7514 with SMTP id 5b1f17b1804b1-47117877736mr6435215e9.12.1760637405530;
        Thu, 16 Oct 2025 10:56:45 -0700 (PDT)
Received: from fedora ([94.73.33.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm35344023f8f.35.2025.10.16.10.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:56:44 -0700 (PDT)
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
Subject: [PATCH v7 03/16] drm/vkms: Allow to configure multiple planes via configfs
Date: Thu, 16 Oct 2025 19:56:05 +0200
Message-ID: <20251016175618.10051-4-jose.exposito89@gmail.com>
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

Create a default subgroup at /config/vkms/planes to allow to create as
many planes as required.

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           | 16 ++++-
 drivers/gpu/drm/vkms/vkms_configfs.c | 88 ++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 73521b9ff0c3..c0c892e4e27c 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -71,6 +71,19 @@ By default, the instance is disabled::
   cat /config/vkms/my-vkms/enabled
   0
 
+And directories are created for each configurable item of the display pipeline::
+
+  tree /config/vkms/my-vkms
+  ├── enabled
+  └── planes
+
+To add items to the display pipeline, create one or more directories under the
+available paths.
+
+Start by creating one or more planes::
+
+  sudo mkdir /config/vkms/my-vkms/planes/plane0
+
 Once you are done configuring the VKMS instance, enable it::
 
   echo "1" | sudo tee /config/vkms/my-vkms/enabled
@@ -79,8 +92,9 @@ Finally, you can remove the VKMS instance disabling it::
 
   echo "0" | sudo tee /config/vkms/my-vkms/enabled
 
-And removing the top level directory::
+And removing the top level directory and its subdirectories::
 
+  sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms
 
 Testing With IGT
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index ee186952971b..a7c705e00e4c 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -16,6 +16,7 @@ static bool is_configfs_registered;
  *
  * @group: Top level configuration group that represents a VKMS device.
  * Initialized when a new directory is created under "/config/vkms/"
+ * @planes_group: Default subgroup of @group at "/config/vkms/planes"
  * @lock: Lock used to project concurrent access to the configuration attributes
  * @config: Protected by @lock. Configuration of the VKMS device
  * @enabled: Protected by @lock. The device is created or destroyed when this
@@ -23,16 +24,99 @@ static bool is_configfs_registered;
  */
 struct vkms_configfs_device {
 	struct config_group group;
+	struct config_group planes_group;
 
 	struct mutex lock;
 	struct vkms_config *config;
 	bool enabled;
 };
 
+/**
+ * struct vkms_configfs_plane - Configfs representation of a plane
+ *
+ * @group: Top level configuration group that represents a plane.
+ * Initialized when a new directory is created under "/config/vkms/planes"
+ * @dev: The vkms_configfs_device this plane belongs to
+ * @config: Configuration of the VKMS plane
+ */
+struct vkms_configfs_plane {
+	struct config_group group;
+	struct vkms_configfs_device *dev;
+	struct vkms_config_plane *config;
+};
+
 #define device_item_to_vkms_configfs_device(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_device, \
 		     group)
 
+#define child_group_to_vkms_configfs_device(group) \
+	device_item_to_vkms_configfs_device((&(group)->cg_item)->ci_parent)
+
+#define plane_item_to_vkms_configfs_plane(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_plane, group)
+
+static void plane_release(struct config_item *item)
+{
+	struct vkms_configfs_plane *plane;
+	struct mutex *lock;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+	lock = &plane->dev->lock;
+
+	scoped_guard(mutex, lock) {
+		vkms_config_destroy_plane(plane->config);
+		kfree(plane);
+	}
+}
+
+static struct configfs_item_operations plane_item_operations = {
+	.release	= &plane_release,
+};
+
+static const struct config_item_type plane_item_type = {
+	.ct_item_ops	= &plane_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group *make_plane_group(struct config_group *group,
+					     const char *name)
+{
+	struct vkms_configfs_device *dev;
+	struct vkms_configfs_plane *plane;
+
+	dev = child_group_to_vkms_configfs_device(group);
+
+	scoped_guard(mutex, &dev->lock) {
+		if (dev->enabled)
+			return ERR_PTR(-EBUSY);
+
+		plane = kzalloc(sizeof(*plane), GFP_KERNEL);
+		if (!plane)
+			return ERR_PTR(-ENOMEM);
+
+		plane->dev = dev;
+
+		plane->config = vkms_config_create_plane(dev->config);
+		if (IS_ERR(plane->config)) {
+			kfree(plane);
+			return ERR_CAST(plane->config);
+		}
+
+		config_group_init_type_name(&plane->group, name, &plane_item_type);
+	}
+
+	return &plane->group;
+}
+
+static struct configfs_group_operations planes_group_operations = {
+	.make_group	= &make_plane_group,
+};
+
+static const struct config_item_type plane_group_type = {
+	.ct_group_ops	= &planes_group_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
 static ssize_t device_enabled_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_device *dev;
@@ -128,6 +212,10 @@ static struct config_group *make_device_group(struct config_group *group,
 	config_group_init_type_name(&dev->group, name, &device_item_type);
 	mutex_init(&dev->lock);
 
+	config_group_init_type_name(&dev->planes_group, "planes",
+				    &plane_group_type);
+	configfs_add_default_group(&dev->planes_group, &dev->group);
+
 	return &dev->group;
 }
 
-- 
2.51.0


