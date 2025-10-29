Return-Path: <linux-kernel+bounces-876374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BECC1B9CB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3C46443A9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FEE2D0C9D;
	Wed, 29 Oct 2025 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aNtObgBU"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DB52D8DC2
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748624; cv=none; b=KRgbNSd/bUOUl37h4msQCreTSF58/m/PK08iMxYpAo8nftctvWOJpEAqXi7WukeEmQQaVoxPcpBJ/ao8phLDgfSlYzaK+P5g3uGQ8ADyJl6/Fn6o3CejEXrpyQ7ms5ab+gETm07JtdZOr1b/HYRAa3ISxCumVcTBvYHfIeDpAqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748624; c=relaxed/simple;
	bh=e8ElyHXcVk0AWYJ7dGjNKx8CrM9WhxXKeDzUlhTH99U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ee8qWyjHg9dxI/waaB1ZEd+ZCkPzJ/10OCGRloo9YPfeLDaimdzpkmYp8qrT+OusIoZdeeP70vQ8//GI3PqhwzF8Goo54805WFvW21SNz6oBOIb3HB7LgWF1QGjUMA0pGX5HWt4CICVMeYXTxoFFfJ5faVL4Q/9oaP69s3EfLvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aNtObgBU; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 477021A1749;
	Wed, 29 Oct 2025 14:37:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 12E31606E8;
	Wed, 29 Oct 2025 14:37:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1E1F6117F813D;
	Wed, 29 Oct 2025 15:36:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761748620; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fs9ni9DRQ5vnDzOwoZttmqZ202xPMAoGkKss/mz8Bp4=;
	b=aNtObgBUqBfEVGe3YUXERK9A4Q/G/fZjyFWpi8cy/cyv8XjtEJemC8xKrSbEed/vDL5Zlk
	ipb2aPm9O+6aEAw8vNPCSfK6RbceU1URxuGZX3XFLv7PfvrEsECv7+44jHMhW2hVMvKI8w
	QoVE7LuaenMkRuuSGRK4YwYV6LecQHggGNYBBDiN3oPto+aFL7HF1ZVzydolg9f9E0JqMQ
	mvhy5mKTQbBqJ4VnlUcGGCJQ9cxYk0g569mEZxpNiaufMlyIbA72Gjr8WDwjfVs0ToeEso
	14S6txPyuhQKKVYxjy6P8fxEmtBTJklfi4tHCDiw4xuE4lRzwFtr7Q9wGWrvlQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 15:36:43 +0100
Subject: [PATCH RESEND v2 06/32] drm/vkms: Introduce configfs for plane
 name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-6-a49a2d4cba26@bootlin.com>
References: <20251029-vkms-all-config-v2-0-a49a2d4cba26@bootlin.com>
In-Reply-To: <20251029-vkms-all-config-v2-0-a49a2d4cba26@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>
Cc: victoria@system76.com, sebastian.wick@redhat.com, victoria@system76.com, 
 airlied@gmail.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2206;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=e8ElyHXcVk0AWYJ7dGjNKx8CrM9WhxXKeDzUlhTH99U=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAiZ7DeWijwgu8w0+XAYahQ0JhE7wgQrw2FSOQ
 z2DnIYmwaiJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQImewAKCRAgrS7GWxAs
 4plnD/9rrq0m9lCn81z0Dx7fNwZFsWHbbKXEJ/5WisbKDljauUG7SL6XjblGWEIbDdyPBooqfe+
 KC/qKNld+W1TUPwYj/+fGkZR43g1xr2sKTlhtkmmkJKlF7t8foW+9Vdp1gy1qkxQBXxSJyWxNxr
 yhPEmUypJFd2eCVrdSGSCQMZ6xKMFioScweBrrmp5Ys7Ek80gKZryZLZmp96m850rUdPfUR7q98
 3mAKSL8Pjg3iAiLx0kEbxkHp5NDJdR1J5AFP4R2HBL1zHn0oOjioWPnHlqhL0gcNaKPaN72APMf
 t99S/ZF5T47bRpYkzUdHKv1bGGTroWDIWHMpl0XaQHRp/YvipZcU/RGy1VX01Uv36SyynMM0/ar
 phDDJ3YvwIJFejBkkTPGPPF1nfOu8rcmBtuRvvY9VxeMRiSZIaQwsOI5Zxg8gdUbuQ/yTb6VNf4
 SuNAoHZ4YW/ZpR+rX+bxQXb1I3/9fQNtvsezjJdDuXeyKNmJvgiUn0t0lRzWILLfZoaygnBzdkQ
 tt8Yc6udvqM5h+hqcQS+IUFPCjt1nezZtjHrO20aug7jHIkfZYdmesNIkuobDFQwRN0n5YqRNGT
 oYoyflIN5DvVsp63E8wW1qBsfvL6EIVpfKGRx4M0h+laHhZDpRJHWSrK3Kle+FLXshlFB0YwcxL
 e4tfGtTsLhKFP9w==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

Planes can have name, create a plane attribute to configure it. Currently
plane name is mainly used in logs.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/gpu/vkms.rst           |  3 ++-
 drivers/gpu/drm/vkms/vkms_configfs.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 3574e01b928d..1fe6e420c963 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -87,10 +87,11 @@ Start by creating one or more planes::
 
   sudo mkdir /config/vkms/my-vkms/planes/plane0
 
-Planes have 1 configurable attribute:
+Planes have 2 configurable attributes:
 
 - type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
   exposed by the "type" property of a plane)
+- name: Name of the plane
 
 Continue by creating one or more CRTCs::
 
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 07ab794e1052..be6c3ba998b9 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -322,10 +322,42 @@ static ssize_t plane_type_store(struct config_item *item, const char *page,
 	return (ssize_t)count;
 }
 
+static ssize_t plane_name_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+	const char *name;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	scoped_guard(mutex, &plane->dev->lock)
+		name = vkms_config_plane_get_name(plane->config);
+
+	return sprintf(page, "%s\n", name);
+}
+
+static ssize_t plane_name_store(struct config_item *item, const char *page,
+				size_t count)
+{
+	struct vkms_configfs_plane *plane;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		if (plane->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_plane_set_name(plane->config, page);
+	}
+
+	return (ssize_t)count;
+}
+
 CONFIGFS_ATTR(plane_, type);
+CONFIGFS_ATTR(plane_, name);
 
 static struct configfs_attribute *plane_item_attrs[] = {
 	&plane_attr_type,
+	&plane_attr_name,
 	NULL,
 };
 

-- 
2.51.0


