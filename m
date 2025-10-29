Return-Path: <linux-kernel+bounces-876185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 353F2C1AB84
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D2B21349C0A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1820B244687;
	Wed, 29 Oct 2025 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZG0ZDUEg"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037192747B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744631; cv=none; b=rqC5oLrPEOqejUPhZ/vOtHajNNpeHQz6Pa8jbwB3teV5eO4ssgsMgveEcJDJOySM0TQ5irDVtgJ2nZIfVUXinOMm/7C5ucbpk8PVPfLicig+2Ug700RqFvjcVFe5sQZTzSpYu5ftVAmKbW29xzpeKFjUX+Mlpx4pavnuvH/uhIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744631; c=relaxed/simple;
	bh=Wsj1m7hVEtg7sU79/U1qOzzdUOMLj+fgjBm3lz+0CaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dZfRZf/zESadxFIND2WHyntOOSbywbGXosIEbDOay04sxfCS07u5lDfdg8gbF5wNNcyeEZlaHK5mBRLMCaqTElJOM5w72R7LlmrBf4jhrCQfgTQcmJxXsxpKQ8nLIwDJUnZFKKtYj8RSXJi5n27w7xn2FpM9SX9ouKAN1WHpx5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZG0ZDUEg; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 457141A1744;
	Wed, 29 Oct 2025 13:30:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 19A2B606E8;
	Wed, 29 Oct 2025 13:30:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2575F117F8047;
	Wed, 29 Oct 2025 14:30:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744626; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZbJg/Ukh5zMJtkFjzl+I9BgVwlaHjwOBuN87NBSPDvA=;
	b=ZG0ZDUEgr2O8ICslHQvKj8Ix3OEKIsdFTpEz6SH2K9XocAGnscuv558BOAvbLrjpXOK3YX
	f+5oUnzL3w9M3cBPgxOVXLUKLiA2++zjdn7nkoOejqDAgbOb8O/xPhoo01bBbpivIrVJ0P
	n1tnHVtMzXQq6YaVoy3chbvE24DGYKDvk4uflItbXibLuApj4g3VknOoT+QGgABHw4IBK7
	DaEQ1Lwav3wILUtLSDByoFg+aw5VWmBAOCeb114uLNkOkvzKzBJlcgBbpLz5iOlL3ddOVK
	NkaaZVqaoqvHAk7rn08c0Q1TFlZlpQuvmseYZPMFQeW9ldAcMHwQUSiVGA/9bQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 14:30:11 +0100
Subject: [PATCH v2 01/32] drm/drm_mode_config: Add helper to get plane type
 name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-1-be20b9bf146e@bootlin.com>
References: <20251029-vkms-all-config-v2-0-be20b9bf146e@bootlin.com>
In-Reply-To: <20251029-vkms-all-config-v2-0-be20b9bf146e@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1796;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Wsj1m7hVEtg7sU79/U1qOzzdUOMLj+fgjBm3lz+0CaE=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAhbp3Mc7H5kFQMRLxwe1wNXkyaS10zALrsFIR
 MqDLsJwgeWJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQIW6QAKCRAgrS7GWxAs
 4tGQD/9zUGwEKbAaXVececP+MM8sKKz+3nqPN7s6HFWjyquKqx4lIPoMKgIZIwOuSvsD5ciNi9/
 4F9HIMjcTeumK+HVX1YPj62K0QGx0GDe08XCgqtxQiHzKRJfv1elZg4cFSdT1M7Vs4/ptneyTE8
 FZ9nf1hh5bOTj8dYfazs0n5GlJUJ0pq3TjAg24SZqQbPGQ9hbFDBmKCyRezTZKqcQCEuFApPsqh
 Sh6S8yLmQS5szhdCKRBnodPfLkBNqxt41HPfxoZgxbCq1n7wUeufg2yx1LQifhYc66FyJ8feST+
 LJ5jRs4FeKX4Et8reEEQcXBK4b9dbpZdxWghwVBgTKBR+vWfB81lerNbIegncoZNdJuXxjEh3Av
 E0cxUnG/R9pormg1Ku0HvRYuk4e0hmwR6+BSt3ApUlGULGGcvBaav7UjZ+NXlW/BD17AVJHQ62G
 1IGZ4NgkDtzv7jC8ATL6yDZ6wj9QmafkGywwFzMlHfNkt8jSZXfUNPny8U+sZ6ueyPRB5lonnKv
 ZxcoStkeOqRR/ASdm2PCXXPVvELDg1kuZ196gwDY6FcoQUbTB+JiNnOWLl0nQhZ8ujpnXEl5sLo
 o2Z5qYyDy/cfI0AnRuka0OeRw3M2PpcOVFYUpT4nL0mqB0ESgzp8tOSN9z7Hi6BFtHLCVlNHdfG
 ogRMj3WwaKuiMyg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

Create and export an helper to display plane type using the
property string. This could be used to display debug
information in VKMS.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/drm_mode_config.c | 13 +++++++++++++
 include/drm/drm_mode_config.h     |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 25f376869b3a..1a1a3f43db4d 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -226,6 +226,19 @@ static const struct drm_prop_enum_list drm_plane_type_enum_list[] = {
 	{ DRM_PLANE_TYPE_CURSOR, "Cursor" },
 };
 
+/**
+ * drm_get_plane_type_name - return a string for plane name
+ * @type: plane type to compute name of
+ */
+const char *drm_get_plane_type_name(enum drm_plane_type type)
+{
+	if (type < ARRAY_SIZE(drm_plane_type_enum_list))
+		return drm_plane_type_enum_list[type].name;
+	else
+		return "(unknown)";
+}
+EXPORT_SYMBOL(drm_get_plane_type_name);
+
 static int drm_mode_create_standard_properties(struct drm_device *dev)
 {
 	struct drm_property *prop;
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 2e848b816218..89f3dd46178d 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -30,6 +30,7 @@
 #include <linux/llist.h>
 
 #include <drm/drm_modeset_lock.h>
+#include <drm/drm_plane.h>
 
 struct drm_file;
 struct drm_device;
@@ -983,4 +984,6 @@ static inline int drm_mode_config_init(struct drm_device *dev)
 void drm_mode_config_reset(struct drm_device *dev);
 void drm_mode_config_cleanup(struct drm_device *dev);
 
+const char *drm_get_plane_type_name(enum drm_plane_type type);
+
 #endif

-- 
2.51.0


