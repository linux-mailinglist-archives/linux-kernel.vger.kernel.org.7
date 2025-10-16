Return-Path: <linux-kernel+bounces-856747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DCDBE4F50
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696005E2B08
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08213321C3;
	Thu, 16 Oct 2025 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzmNhNuu"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD87532B994
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637425; cv=none; b=jWRcT/z0iyDqKg/eVjDXeNJzYP+qAHaBhSOuH60OSU5TpAvry2hWQAR8mWtGByUFafAME5FtXBpXDSESsUXf3iEpORAcEI5uowmfnGLuz8GaXkofPBFKHWOi5syzt1IeCh5n9RVa2s54ZGwOnNW30oTtuUrtsdlkjrdaJ50Zs34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637425; c=relaxed/simple;
	bh=9e1TIPN8/Y9PfCOEwmK8PGcA4SPQ18uPd9sxQu2V7PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnkoZYnV3UU40QXqGMCCkGsTN2D/o+tUjEthFdhsN2kiiDOCDjhaOKiP46gWU16u8D4+J61BQ/2iH+fQbsBFQ00emqIwJUKNwJFDXNDhOjBlncM8289L/R6JoXwFkY3mU2titSZyaDo7Wx/3R6kDHORD9WzkgSeHFgYcXnzfN14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzmNhNuu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47112a73785so7507885e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760637421; x=1761242221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GWwM20gq7xOoxyKkWmC1LXSVhNHxFS/9ynoMAJqd3o=;
        b=kzmNhNuujSq6FZwBXJjOxMW5E+g4AMR6pKUn0Bdl5d1bu0TwsAiz8pAB/s5VKXAI4x
         zyammSisff7H+nDuTZarVJTOYRE3uEzdZRs8nAX0i0MHCKGDvHiyggyu7E43rzWVbnsS
         IHAdEG2SsZ9OD7uufGA3TP2H1aRd+ouB5uJlXdB+YLD/y1aRli63xTY6chWrJj7YP4yx
         c7eLwm2QbqzbnhDAjD+N3WEnT5IuOXD5BonFUv+ZAtDyf9EwpH51NII5cuvf43AAv0dU
         4C09MAfTuRfMWBksGmHVmbHJFuB5WwEXYeNbwtQNOlLSwIBFjgys0/TMA99mUF4c//4J
         muSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637421; x=1761242221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GWwM20gq7xOoxyKkWmC1LXSVhNHxFS/9ynoMAJqd3o=;
        b=w/a16pq3NkwN0sIezfdojAmPPGFUsG5/z1M3xj8ovNJC/Z0gtzKyuS3eI9bBTLnL4t
         0/oD9HF0ZwNptUHGCjdY3IfvAirBPKHA3GWf9dTCSbeozb6DQ7XDKE/VzoI6w8IVLIFO
         dtv1+NlDhvrgk5wX4rEg7jz9oG479F+Rw5v4hz94/mZRjH2Jke5QrfzlmYrbX0JmvqsV
         t1Fbdx1JcxSQpMCsWUS8fekqEJ0l5zWPrXK1zuyjdix1JoD3OV54zyXC7zCPbTaYd0Eu
         4bsk+8+I1C4ElhCc5Yu8/C38egotv5bQl3ryuRNMaSUQvdRsDkZ7wzapgsuKbdLHvOjT
         UJEw==
X-Forwarded-Encrypted: i=1; AJvYcCU88NnzcEgtduM1zb+8F/H25945dj2QvOVG47vd/VneOH3ahwNNnnc8+sWS0Ok0QVH4cn82dWkgARXSPa0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4shujEHbyyNewE/CsWq3X0409E8wtgCERtQiTg7lQkICwTuX8
	bGBLkHdf9bH0EMhgtBU6Q6yS1XFtN+oeKkbJWdJsKFaPigqU+lfpSIPG
X-Gm-Gg: ASbGnct4TULeCqCnHRiO95p67nBP0Sutqm8/CMbm/SIrQqYbwUfdX6HbrESv8O9e0vK
	HFmOqPbrQALW1mL1ZT079HXraxe7khthBYHvSBI4Oddk2iqn90APgPvuGiEUyJhH80IywHiHfDo
	eAKwcKBsXHmKccQn6HLD4qd6B6aKxYzZc4ZDK7vAz7gYp2zBYZtXC6ZbclBbqe+R6b+BHoVZG76
	MOqbJW06Gkw45m/H4a1hPGSlfQ8cPljch/ysf2rOya/03Nrqwt7gXQ0yNlf6eTkfNaN43Yvhobv
	9FobCJlbEe+hosmjos66RDEF08pTOFAwv5Wm6obs6f8H+ZC5HLKIaWl7nGtzpXaWqK31E/hbT55
	cG3kS9p+hydEkeFx2eWemJTSntXwsM0vYpd5KcdQzyUDO5UWjXvhTFJHFVuJpEYAMStB7beDBHz
	e2AHuduJ2JPQ==
X-Google-Smtp-Source: AGHT+IH53BhaYro8jyKEDI34s3L9q4RglYQK6QZS8yLxmdbAtqWCu455uCzIhrqElW+V6d1h6xnYuQ==
X-Received: by 2002:a05:600c:3492:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-4711791cadfmr9916985e9.32.1760637420904;
        Thu, 16 Oct 2025 10:57:00 -0700 (PDT)
Received: from fedora ([94.73.33.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm35344023f8f.35.2025.10.16.10.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:57:00 -0700 (PDT)
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
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
	Mark Yacoub <markyacoub@google.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v7 16/16] drm/vkms: Allow to configure connector status via configfs
Date: Thu, 16 Oct 2025 19:56:18 +0200
Message-ID: <20251016175618.10051-17-jose.exposito89@gmail.com>
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

When a connector is created, add a `status` file to allow to update the
connector status to:

 - 1 connector_status_connected
 - 2 connector_status_disconnected
 - 3 connector_status_unknown

If the device is enabled, updating the status hot-plug or unplugs the
connector.

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst            |  5 +++
 drivers/gpu/drm/vkms/vkms_configfs.c  | 48 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_connector.c |  7 ++++
 drivers/gpu/drm/vkms/vkms_connector.h |  6 ++++
 4 files changed, 66 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 364b574a8cae..3574e01b928d 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -108,6 +108,11 @@ Last but not least, create one or more connectors::
 
   sudo mkdir /config/vkms/my-vkms/connectors/connector0
 
+Connectors have 1 configurable attribute:
+
+- status: Connection status: 1 connected, 2 disconnected, 3 unknown (same values
+  as those exposed by the "status" property of a connector)
+
 To finish the configuration, link the different pipeline items::
 
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 8e90acbebd6a..07ab794e1052 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -7,6 +7,7 @@
 #include "vkms_drv.h"
 #include "vkms_config.h"
 #include "vkms_configfs.h"
+#include "vkms_connector.h"
 
 /* To avoid registering configfs more than once or unregistering on error */
 static bool is_configfs_registered;
@@ -512,6 +513,52 @@ static const struct config_item_type encoder_group_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static ssize_t connector_status_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_connector *connector;
+	enum drm_connector_status status;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	scoped_guard(mutex, &connector->dev->lock)
+		status = vkms_config_connector_get_status(connector->config);
+
+	return sprintf(page, "%u", status);
+}
+
+static ssize_t connector_status_store(struct config_item *item,
+				      const char *page, size_t count)
+{
+	struct vkms_configfs_connector *connector;
+	enum drm_connector_status status;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	if (kstrtouint(page, 10, &status))
+		return -EINVAL;
+
+	if (status != connector_status_connected &&
+	    status != connector_status_disconnected &&
+	    status != connector_status_unknown)
+		return -EINVAL;
+
+	scoped_guard(mutex, &connector->dev->lock) {
+		vkms_config_connector_set_status(connector->config, status);
+
+		if (connector->dev->enabled)
+			vkms_trigger_connector_hotplug(connector->dev->config->dev);
+	}
+
+	return (ssize_t)count;
+}
+
+CONFIGFS_ATTR(connector_, status);
+
+static struct configfs_attribute *connector_item_attrs[] = {
+	&connector_attr_status,
+	NULL,
+};
+
 static void connector_release(struct config_item *item)
 {
 	struct vkms_configfs_connector *connector;
@@ -531,6 +578,7 @@ static struct configfs_item_operations connector_item_operations = {
 };
 
 static const struct config_item_type connector_item_type = {
+	.ct_attrs	= connector_item_attrs,
 	.ct_item_ops	= &connector_item_operations,
 	.ct_owner	= THIS_MODULE,
 };
diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index 89fa8d9d739b..b0a6b212d3f4 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -87,3 +87,10 @@ struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev)
 
 	return connector;
 }
+
+void vkms_trigger_connector_hotplug(struct vkms_device *vkmsdev)
+{
+	struct drm_device *dev = &vkmsdev->drm;
+
+	drm_kms_helper_hotplug_event(dev);
+}
diff --git a/drivers/gpu/drm/vkms/vkms_connector.h b/drivers/gpu/drm/vkms/vkms_connector.h
index 90f835f70b3b..ed312f4eff3a 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.h
+++ b/drivers/gpu/drm/vkms/vkms_connector.h
@@ -26,4 +26,10 @@ struct vkms_connector {
  */
 struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev);
 
+/**
+ * vkms_trigger_connector_hotplug() - Update the device's connectors status
+ * @vkmsdev: VKMS device to update
+ */
+void vkms_trigger_connector_hotplug(struct vkms_device *vkmsdev);
+
 #endif /* _VKMS_CONNECTOR_H_ */
-- 
2.51.0


