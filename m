Return-Path: <linux-kernel+bounces-794520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F45B3E2D7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B8B202833
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA7433EB03;
	Mon,  1 Sep 2025 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Joz+1PML"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8828F33CE82
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729579; cv=none; b=OUGu1RvvHg24VtuSxQwiqHIiVVe0VQVYLgEmvJWfFQzNIbg78y23R9qlg1gYpEePdwTYcXVWeLxC9uXXerKtSknP5YhUFmu+7gwVE7vk7YjjB3CNk9w+1uil8cY2b3y3zQbygH1VVyBGL3Qv8kvyw/Iqfmd0/q6ukD/lmpZYLt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729579; c=relaxed/simple;
	bh=PA3nO4SDlcJg1noaBgSUXupGno9tFbj2hd30HZ0Iy84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/h5XD48jf+6DxqTTeE551UoiJZCKNOL+TX1KURL/DfzaXsJGEmFe5iT7iOZCQhaYBsJ6oh/3DFFGlzQ1tDR07p9PYEEwIav6cG588pMOhpeqQH1dorLUammavPr6Nl/AL48l8aIEN8tvIDwgvBeoaMAL3oNEnbPxyt+Arrpxlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Joz+1PML; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso25672135e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756729576; x=1757334376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXpqkTrNBx08nghW1HrOC6W4PRw4l0CpXqaM8e/MDOo=;
        b=Joz+1PMLoYzM4oPHJ9FAdyTCFQtThKqBo2sz1kByKRqeFl1P38Lhnl6UU9H7hNT0r3
         WP1tMaQv6gpmE0hw0Q/83yFmf9Y8/5RegADVCUoZMfyWMDpwlnkHX1Zu145/bWy1ry0W
         loN26YYeznZM/OwJzZPbMBtyrJn/LOKW6YpmrHmiqPYluQ/mcLfAWASNfzO2mf0S9sC1
         DakjkI5bBlidPAoi/n7T3UsFZe0mks4kBi6ddc0ZiUPnR/DtJo7I5/Z/8TIf0LbGfKhG
         MYjK66abU1aEM6vpGwOTXk7zIUc2UTBMHqAX1dRl4k9Lf9xfxoH09tHEVfJjokT8Hq/l
         WmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729576; x=1757334376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXpqkTrNBx08nghW1HrOC6W4PRw4l0CpXqaM8e/MDOo=;
        b=SI51oBPyTTDOgKDcs4IhkdQoJluEtazPkzV1lkiJwKH7QFkavGuxoooQWQLY630Lq3
         uWqMKDRvc4MCFJD3ia1O3tLfJKKbiFEHATG+dk9qEOVaGM4lEknxfzLAyCScMRXUkVs4
         UFZ9NEQ28JpADCO2O8WvucASo/C7nyxkW5e+PlTqGDIN/MR6m7Xgml7rOjIBRwWx492F
         0z5DJ5tbNdMw3tFJ8PAH9Cbb2Es+hEAjHaJRCqpctT9gAuIvrza8n9nDJjrGPqZdzoMS
         iRacE4UFmlTeRDwksO287AY8jMEfZIyGr+gCtI0lQacGerBwP8qyc8VKcfFqoC6PCiwN
         llMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRk8LcIlcXQIjyXaGMbyqI40EfAV33Ov1/5DyZNagErakTUjqA/6ZhAicd6iaJXd4HdV62JHumhChX9tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf/6FivX7+p88h9OJMg9/Aqcln6FKflOhgVXQuYuRYniHgFuBz
	s1WfxtPVzzTVSequI+LGrpZUWRwWD48Pcob06q5eK2BNsNJJNWDzkbrZ
X-Gm-Gg: ASbGncudGO/HlR0k17YLkj2L7UHsLWjSIS0QYZJv8AjdAbv9pOFI5fwLCPiyBqKkYUA
	kB7meWLRobxBHuytBaYlueTq/A5EWw6ZQWa2nWF0H5PmnVVZuyosUpFumQVuOhfQgAJMdXzolSI
	VLbhgPOukCdUOtnTtG0H/quIee46CWd9JAqyhzPain6raUqNhWdVHxSIDAemiVMsBm/QerazcWL
	VLpiiwQO1cK9ojb26HARnhYMWyz1Us2WDsZXawT1nd29vtHl4TMmiNRFEcN4XEu09amvXxn8fRY
	cFq1RhLnWyBXFOtfYz7sIGfRwCqPNpIy8WrEhzMl8Y52F9QMCifR74eY/dpZvzOShaN2gUo8g59
	3cLFUI1XGleFdKI6RPzM/4mOHP7m0rKjgOkTwXVw=
X-Google-Smtp-Source: AGHT+IE2HSu7KIwEmoxMq08mYeKHKtIF4UHvpucYUvO+CqTQKiYTLe6Jd3B2jaPQ+EeAvqZvZUA7Bw==
X-Received: by 2002:a05:600c:45c9:b0:458:bbed:a81a with SMTP id 5b1f17b1804b1-45b877be05bmr69423465e9.10.1756729575670;
        Mon, 01 Sep 2025 05:26:15 -0700 (PDT)
Received: from fedora ([94.73.32.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b74950639sm207297055e9.17.2025.09.01.05.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:26:14 -0700 (PDT)
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
	Mark Yacoub <markyacoub@google.com>
Subject: [PATCH v6 16/16] drm/vkms: Allow to configure connector status via configfs
Date: Mon,  1 Sep 2025 14:25:41 +0200
Message-ID: <20250901122541.9983-17-jose.exposito89@gmail.com>
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

When a connector is created, add a `status` file to allow to update the
connector status to:

 - 1 connector_status_connected
 - 2 connector_status_disconnected
 - 3 connector_status_unknown

If the device is enabled, updating the status hot-plug or unplugs the
connector.

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
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
index 90f835f70b3b..35f2adf97e32 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.h
+++ b/drivers/gpu/drm/vkms/vkms_connector.h
@@ -26,4 +26,10 @@ struct vkms_connector {
  */
 struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev);
 
+/**
+ * struct vkms_device *vkmsdev() - Update the device's connectors status
+ * @vkmsdev: VKMS device to update
+ */
+void vkms_trigger_connector_hotplug(struct vkms_device *vkmsdev);
+
 #endif /* _VKMS_CONNECTOR_H_ */
-- 
2.51.0


