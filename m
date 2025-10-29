Return-Path: <linux-kernel+bounces-876195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3141DC1ADAF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4331A63F5D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3090343D6D;
	Wed, 29 Oct 2025 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nd0edYDU"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DF333F8BC
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744646; cv=none; b=sH0Lt6dndJAubh31axsFl1suEm4DgmK9gnV3ZjQzsutgn2vYwRiCz1Qt3uBozfUYkYdR6eutSGtLxCqZTnD/M+JcRgVYXNRQ+oWtlZ/LDRMqXT3vdVv6+3FdAVay3YxHv/CJiuN3uEhugp42IrUb9PVlVmwU+83LkuPKs6JBn40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744646; c=relaxed/simple;
	bh=9TfPsJICnyPE31+Hej6T7C008mQBIxzh3S131zfeBZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cWWNQOG0iVjBP4TFqjAkz8rgdruY4KA8UMWYLBaouH+vhNAml2gQITSaU4nXhrhLhwzTXVvAbdQhLUQtdEn0mNtK13Uo0eUu3knrreIZAUGEajOZrunR7RTRIPIiNODCfrHwWdajI634PBi74OiiMAVw2Q675tzkeUdqIB1yNPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nd0edYDU; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7F7421A1744;
	Wed, 29 Oct 2025 13:30:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 56185606E8;
	Wed, 29 Oct 2025 13:30:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 40876117F80A0;
	Wed, 29 Oct 2025 14:30:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744641; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gKwfA60Mu6/uVfL7AHgIja/er1PeHgmxn0F8i6czpgo=;
	b=nd0edYDUyhm0q21E8iKTihi2iZswyf7BnghCGXvwb9eIllTR3lDotEWIOcsN+aynvYiBxC
	25SVOc4fbJVBiIVBChaCOBpQBuUh7olJ+51VIygU5aWDIhTcKKPvBWSZd9k8ohyYVuQps1
	LrMOogMQLnoilWcI3veEkarPJxV5OZmXo7zkGIlX+hWuWYuDLQpaLZuK6+qxjpoFKETcYt
	25SlToP9ZyauEI2NraVHYBaXJwqcaPWnUmjIRCuYjX798Qfo9OzUW+2p078Cqtdxqw8XjL
	7HpGsjEHLVeAJip8g/fc4J19GS80m/UJELGKjWl3eKJv8gyQxROM0zfrrJsphA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 14:30:20 +0100
Subject: [PATCH v2 10/32] drm/drm_color_mgmt: Expose
 drm_get_color_encoding_name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-10-be20b9bf146e@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2102;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=9TfPsJICnyPE31+Hej6T7C008mQBIxzh3S131zfeBZs=;
 b=kA0DAAoBIK0uxlsQLOIByyZiAGkCFuqgN+18wfzpaScwMhagWzteA4B+KM/YnSsMmbLFhILPw
 IkCMwQAAQoAHRYhBE+PuD++eDwxDFBZBCCtLsZbECziBQJpAhbqAAoJECCtLsZbECzi7Q8P/3hH
 LUu8mAen8jCzESUz8mO3pazAQ/8qNhHa9t8DN5nFKrIqEiEg2va3wZ+vsBWOktFDY294b+zfqUA
 Cfb8cHYJrEE8s1MG2jF1LjmO0zoCsi2NwQTkl019YlNa9f/Tbp3xGk0pyTvD3YsX8vPveWvGiMN
 Mnqer09UNqCgTQSMooK8VCvaqwJI4xFELq1Sh0W4IoOIyLJ1DvVuEdyC1+IDxKKaOBifTjsyNHr
 gDsCsJi1aFG8gIpkSP15c/R4xppxGrQDhL97Qz2PXHm3MRBqo67cp1dfd/9of6posEn8CERDGXy
 V08hNLFSmNxRL9gKC2MpeODr6REo0LrRdqdEgmBO2lhA0iJYHkxeMwQ1wM6rRDQZ2qo+B5lN3vG
 pLvr29T0rt+867C2PSd2IF2cnh48bMdFCnEZuhrjbApw2JRMiO/gWqgpO5t8Nrow6muIpfX4w5z
 7jsfxdxHVx/s0lj4Knvn2oovg+j5ReUnSfDSPAbEzr/dkXCLD/uLv08h+o8M55yz1u1nDSLCSb+
 jL3YyIsA+cmulRUgykXQXKsC4MO0YWR11t5/k1vUEOmjQkNQ4l2Dw5/9WY3cVK1NIdYkdzllvjj
 nezFP8SUBSJHjH0GxwSHdat5++NEO+di/xd+gWOzSbDVIH5sFslctiLC5QbKvh2TAzuh56ZJDHU
 jMVxS
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

drm_get_color_encoding_name can be useful to display debug information
outside drm core. Export it so it could be used for VKMS

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/drm_color_mgmt.c    | 2 +-
 drivers/gpu/drm/drm_crtc_internal.h | 2 --
 include/drm/drm_color_mgmt.h        | 2 ++
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
index 131c1c9ae92f..b0a3be3cc016 100644
--- a/drivers/gpu/drm/drm_color_mgmt.c
+++ b/drivers/gpu/drm/drm_color_mgmt.c
@@ -496,7 +496,7 @@ const char *drm_get_color_encoding_name(enum drm_color_encoding encoding)
 
 	return color_encoding_name[encoding];
 }
-EXPORT_SYMBOL_IF_KUNIT(drm_get_color_encoding_name);
+EXPORT_SYMBOL(drm_get_color_encoding_name);
 
 /**
  * drm_get_color_range_name - return a string for color range
diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
index 89706aa8232f..68fd5385917f 100644
--- a/drivers/gpu/drm/drm_crtc_internal.h
+++ b/drivers/gpu/drm/drm_crtc_internal.h
@@ -38,7 +38,6 @@
 #include <linux/err.h>
 #include <linux/types.h>
 
-enum drm_color_encoding;
 enum drm_color_range;
 enum drm_connector_force;
 enum drm_mode_status;
@@ -121,7 +120,6 @@ int drm_mode_destroy_dumb_ioctl(struct drm_device *dev,
 				void *data, struct drm_file *file_priv);
 
 /* drm_color_mgmt.c */
-const char *drm_get_color_encoding_name(enum drm_color_encoding encoding);
 const char *drm_get_color_range_name(enum drm_color_range range);
 
 /* IOCTLs */
diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
index eccb71ab335a..eb55bdd33f50 100644
--- a/include/drm/drm_color_mgmt.h
+++ b/include/drm/drm_color_mgmt.h
@@ -85,6 +85,8 @@ enum drm_color_range {
 	DRM_COLOR_RANGE_MAX,
 };
 
+const char *drm_get_color_encoding_name(enum drm_color_encoding encoding);
+
 int drm_plane_create_color_properties(struct drm_plane *plane,
 				      u32 supported_encodings,
 				      u32 supported_ranges,

-- 
2.51.0


