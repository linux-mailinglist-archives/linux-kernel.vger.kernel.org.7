Return-Path: <linux-kernel+bounces-794505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16496B3E2C6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B57D1A82FDE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA4532143E;
	Mon,  1 Sep 2025 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9UggVtP"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD40831DD9A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729560; cv=none; b=JeriBar9LsKio2q5khmDvE2/t1dTHxcgagpu0bgGGIlopc1CWp3hOpIaJUuMNHZzQ9OYhiLgPbYnIQTnCXllcUKagT7Medu/YXXgYQwZVrwtBziTeOv7EbcCuNV61TafMjWOJ106iNPjp1ejD2NL8YsC6pwIBkJz+cz5WH+nTIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729560; c=relaxed/simple;
	bh=CD/qBdhKGiVF4m6YjtdHR/qx2YHcGOL9PE1MTy/qwGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRmCTiiNQi9/aG7ETecTFoGAvEbDCBZYiyGIzKRAAZ2L3YZ6VUcZsR3X4hqxK6rKbn9gVSTJCFFPVvd+/g69jf/Noz2LfdwBuutJws+jvsKdHRVkVJt01LAzRzs1PZmqLqFBai1Zvu+d7Rnc0fxRKC04RTeHcKBxwytynpJMEEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9UggVtP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b87a13242so14553275e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756729557; x=1757334357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6J822DCG0Tagx+YMQrYzj9nyMAeQiPi53HWBRRFDX8=;
        b=g9UggVtPhDiG8dml7iPKJVxrfti54taMuMo0EcwCxYaBddcou5RzoGUBwzK87cEWjR
         ecgVW+LKLKd+s23HfSX0tp961p2dZLQBGuh8ujaVr8MmMZXj5Xt7eEwt9k8SzjGTWUL2
         vzPbj/Mbqo0FncBLr7sMx+VK061Ne6+Rn+RMzHCzOB9Qqgjn2+gcCatcHEzEc8W27s9+
         jiZSz+IUK8YU/bpKKBuv4fpjlmpOL937H5a7FQ32YvLijJiPmg31DWRKvY9I5oXDNy8v
         o27QJMdBfKD/hPQo9m61UHY/YFuomWITgWCt0MkD9NGLm1w1iHGlPJaywIRcqgjKuxk3
         0p1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729557; x=1757334357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6J822DCG0Tagx+YMQrYzj9nyMAeQiPi53HWBRRFDX8=;
        b=IhukUmbNapPxsCz7FVdoLvBMkcP5tDMJuZPU6IGnnhgiTnMU3VWz9qceVQwFU9JPx0
         ftBXnDk2OVm8KErDMiLrcnE6cgKHGdVrtxQ3PKfxVnZJACFuSL+HLvqMXOqTVVTunKDm
         QpoTTlj276G2Wz4Tjb8YZHJzUwxYmLOT3g5X0oBnAf1ucEkevlC4o6Dga8sL7O1gj4BR
         xIYO/TbdVL7NBUOrtFnwZhl93ixNKRp/q0Q7fldM8ucKdkLaTOuRXLkxSnqFGr5MOgtx
         e+NZdT1L0dJieHc+Td+gIXTtDQ6MLpvLdKK/atowtkEACujfvdGqFHv1tK74ZaffGVsJ
         yggw==
X-Forwarded-Encrypted: i=1; AJvYcCXcqApuW4GBFa03RwUPj/X1hyMOb8qhVgZ0ANCnIlkkWxmQQQQqUfpBuyTNLlhcs5u1Tr9JBU5hWCltkBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBXEyEst3QuYwEJf6NPsQ1oNfPlTM+FVWnNW4t6jGfN56PAukZ
	BMQKUvAVDxrV/BVqfXrPvHGM4KfhfQiXF681+Dr6D9cjzKCL6ekb+sY1
X-Gm-Gg: ASbGncuAGrp515mClff/1YvkMRydPdnlfko2HUW3qh6mTjW9A89cHdsppuhX0TiSDBQ
	t+PA4QGr/BX9f0Rm0HluC7imxlMdl4i5ZSW03JkC3Xz5AAkw/JcBlSJfw/yVVHAcKw3i6dYP56w
	1P08izz92wktGaxSLFb2bkoHyPiY5Ft+/Jk/nbHwL3xu9rZjffiWJoRhXY5Zb3WpPAhsfuXENu3
	ti9WmXOE1wTmFTGycOPOgGRykfV8xzyf+/C4/Vssr5Hw4URa8gYFnQ4o9rg9Lki0JcF9fCrwZUZ
	jb9ePJRXEd6JWT4J6ScFjIUyH033M4ZYvSALH2eDBDy3qmgYxO4wDeWjXN2gKcz366SYR5N2poQ
	U6ScQI4K6PrsGxF2ts53TWWuYu1BX
X-Google-Smtp-Source: AGHT+IFrYs0xdumtDpy/wbHYYgQBN8SFLjE3tN0WJJPP30ut3Q3K4yClWwur8tCR8k25h5oQDUgrRg==
X-Received: by 2002:a05:600c:a41:b0:45b:627a:60cf with SMTP id 5b1f17b1804b1-45b8559b8edmr77708035e9.24.1756729557000;
        Mon, 01 Sep 2025 05:25:57 -0700 (PDT)
Received: from fedora ([94.73.32.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b74950639sm207297055e9.17.2025.09.01.05.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:25:56 -0700 (PDT)
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
Subject: [PATCH v6 03/16] drm/vkms: Allow to configure multiple planes via configfs
Date: Mon,  1 Sep 2025 14:25:28 +0200
Message-ID: <20250901122541.9983-4-jose.exposito89@gmail.com>
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

Create a default subgroup at /config/vkms/planes to allow to create as
many planes as required.

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
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


