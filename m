Return-Path: <linux-kernel+bounces-876214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 24826C1ACF2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 95EDD34E357
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F378354716;
	Wed, 29 Oct 2025 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PRVKiN4s"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B581E351FA1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744678; cv=none; b=mbbywHnVjSyGlVjgXAHE8nm6KbeP9KITa4MY8Ue11ErL118EXTqw90SWvZKan/pur5DArEe/OmEqjb0iAIMDwnX5ki8tlRug6eiZdpuE1IFztHRxh0/XLiRGHcZI/4kjiUpGTTkKWHYvvx1E952k6LBRGlObQPKtPulNUqr9EUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744678; c=relaxed/simple;
	bh=GNdCT1aWfEW/qQlyX1iY1PDslsm0v0L9+mabaSCFgjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XFhHwTM2DliK3sg+hQ9RQYfNKTvqobHeCtdFznqzkGhvQQQPxXxVhpijK5mwyUjpTFikAxYbiDjlp5l/8joPTbwY7ZVQ/zkKi1rzNuWAi1Z8HBM152tMFgPNsfXPJrBrftfXpphfc27o6anoI/nQZHUnLTZvKq/oZdvoGZpHKtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PRVKiN4s; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3F09F1A1748;
	Wed, 29 Oct 2025 13:31:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 15B6B606E8;
	Wed, 29 Oct 2025 13:31:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0C232117F809B;
	Wed, 29 Oct 2025 14:31:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744674; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1ieovVEGpwnQqb90fB7Ngr7zVzD1mSM9AkeaTdc+irk=;
	b=PRVKiN4sYjGGj+/vc8VbR43izW7xNzU+hii72kVDVm8BAwPuOl8G+ajGFot0RPNXKyO6fX
	yzhC64ef9rBB6sPdftIdANX5cB/zeR7ecoGqGtruTacc3p/o36z5oaMOs+biHQR+GSOUkQ
	xEkVOvEHQCAAmQi0CzF6nQVsbm8QB0LPcZsdFjprHC3PvKJEFqRR4J+K+1dd/bF6ypQ6Hy
	oRuMHu/VBiO2w49Crww9bVGABrS0+inIQhDT9ZyHGGVEd8Xj6ob62w23HDcf2VvTlzi69Q
	RPAyaFU1hnonSKGclEQhsTsietqjtd/4JHLiBBUshC0gRzmrVbi7/i/FBTNK8g==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 14:30:39 +0100
Subject: [PATCH v2 29/32] drm/vkms: Rename vkms_connector_init to
 vkms_connector_init_static
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-29-be20b9bf146e@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3042;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=GNdCT1aWfEW/qQlyX1iY1PDslsm0v0L9+mabaSCFgjo=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAhbs5NWJ3H/klU5NCpNmrHDhXpnph0/9+Ic6u
 DiEN3R00MWJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQIW7AAKCRAgrS7GWxAs
 4gfuD/9t1FOb5+ixWdur4XrQ3eEmeXmDInJf/sPhw3STC57hL7aTiD0/XqZUjBbp3rstUKJxTQj
 8ESDgHo0Cr+G62tM+/d0XzLuvWFeyHSgu1Tvz8kxOTKHxlQcxR0kWhNWYKwhc6aEaIS3HdDQFPk
 A9LDFjWWFjUoY50CFuL29Vp+gJvSCv4pCHg4K/TtXqWy+q7Nm2tKS3t/k8fBACU9WtzmIdv5utU
 fEoS7dUS7y683ENbgMBt/PbEdHc1P1ArsP6CUQyXu8pVsN0fwZXKGumFgN7mU2Ej4fX1xK/rMBb
 tYYxhJ92X4xBs4JyfwuQmBUAEA49SX0L0KUhOOV4Kt5aoFDyzBFuzfsd1tpnD+k8TIJsIx73PW1
 3olPHGe7pKCJgT3Trv9T/FzV9GB8bJZFwEzC/u3QwORyeS8Q/pRQ8cxR9MxBFrRcjxgRdLIXBwA
 fKteTwyqfs9p4qSy5FBlAlqXgWlvPQKVc1hd06oDuxXA/P14LJ2xfWz4Jak3Uzor2DyDo/9uqAm
 Os9Sg1bS4kU11CG7RTTtZ8QdGXXzcZLne6TCpcxc7NZ1203TJhCHuh2B6iRvk44TLwq9O9SywT8
 41Av+YroDBQhBXVm8Akw4IRz5GVKstBcxs8vZFpceT8QooA8P83Mtz+TCLoZdM5uUWFLMql3M/Y
 +JbK4mVmCWnuvvg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

With the introduction of dynamic connectors we will have two way of
initializing a VKMS connector. Rename the current function to clarify
the case.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_connector.c | 4 ++--
 drivers/gpu/drm/vkms/vkms_connector.h | 7 ++++---
 drivers/gpu/drm/vkms/vkms_output.c    | 4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index 699b6779a46c..1b7ccca2abc0 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -108,8 +108,8 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
 	.best_encoder = vkms_conn_best_encoder,
 };
 
-struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
-					   struct vkms_config_connector *connector_cfg)
+struct vkms_connector *vkms_connector_init_static(struct vkms_device *vkmsdev,
+						  struct vkms_config_connector *connector_cfg)
 {
 	struct drm_device *dev = &vkmsdev->drm;
 	struct vkms_connector *connector;
diff --git a/drivers/gpu/drm/vkms/vkms_connector.h b/drivers/gpu/drm/vkms/vkms_connector.h
index a124c5403697..85f9082c710e 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.h
+++ b/drivers/gpu/drm/vkms/vkms_connector.h
@@ -4,6 +4,7 @@
 #define _VKMS_CONNECTOR_H_
 
 #include "vkms_drv.h"
+#include "vkms_config.h"
 
 #define drm_connector_to_vkms_connector(target) \
 	container_of(target, struct vkms_connector, base)
@@ -18,14 +19,14 @@ struct vkms_connector {
 };
 
 /**
- * vkms_connector_init() - Initialize a connector
+ * vkms_connector_init_static() - Initialize a connector
  * @vkmsdev: VKMS device containing the connector
  *
  * Returns:
  * The connector or an error on failure.
  */
-struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
-					   struct vkms_config_connector *connector_cfg);
+struct vkms_connector *vkms_connector_init_static(struct vkms_device *vkmsdev,
+						  struct vkms_config_connector *connector_cfg);
 
 /**
  * vkms_trigger_connector_hotplug() - Update the device's connectors status
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 217f054d9598..44f8f53c9194 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -92,11 +92,11 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 		}
 	}
 
-	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
+	vkms_config_for_each_connector_static(vkmsdev->config, connector_cfg) {
 		struct vkms_config_encoder *possible_encoder;
 		unsigned long idx = 0;
 
-		connector_cfg->connector = vkms_connector_init(vkmsdev, connector_cfg);
+		connector_cfg->connector = vkms_connector_init_static(vkmsdev, connector_cfg);
 		if (IS_ERR(connector_cfg->connector)) {
 			DRM_ERROR("Failed to init connector\n");
 			return PTR_ERR(connector_cfg->connector);

-- 
2.51.0


