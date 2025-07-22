Return-Path: <linux-kernel+bounces-741048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F24B0DF66
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721BF563B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047452EE963;
	Tue, 22 Jul 2025 14:41:59 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF362ED149;
	Tue, 22 Jul 2025 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195318; cv=none; b=cf5YFXWMCaJ1FVmVLQc4ip/ru+dIFBn8u/hATNxZKqKcxhtH1cxnWsJTuywtJNvXii3R4tTEkRrqDxTFRGLPzoXBo2pfEsJz2yXcBl2hUaHyEzGX6IMiLde+6i+9a8A4pC2eX5c7fTGx63w0x7S6bNYCVRs9mi/PLbA2EzcdNyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195318; c=relaxed/simple;
	bh=KE2Qre5vhvSQZvizKoXFSBgmGwTIQRLA2fyIdbp60f8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cUOF29HcLWWGbbewTOz7afLwIxMG07b8bzun06qUy3tyYUFexSGEgndIYNYEbyEngojd+zIsuzQ2wk3Eisrvxjbm7916QT6UlzAMqLYRcT1Ym9HYS3J7mb8vTzFnRxgiyju1JYcaTgM/p/fSrPYsklO9TRXPwC0nRdw/1HvzpGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 7F48B1C07C3;
	Tue, 22 Jul 2025 16:41:46 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdcb:3c00:ce39:8bff:5db4:1ef8])
	by srv01.abscue.de (Postfix) with ESMTPSA id E615F1C07FA;
	Tue, 22 Jul 2025 16:41:45 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Tue, 22 Jul 2025 16:41:17 +0200
Subject: [PATCH v2 15/15] drm: sprd: add fbdev support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250722-ums9230-drm-v2-15-054276ec213d@abscue.de>
References: <20250722-ums9230-drm-v2-0-054276ec213d@abscue.de>
In-Reply-To: <20250722-ums9230-drm-v2-0-054276ec213d@abscue.de>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Kevin Tang <kevin.tang@unisoc.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.2

Set up the internal fbdev client in the Unisoc DRM driver. This is
needed to make the framebuffer console work.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/gpu/drm/sprd/sprd_drm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/sprd/sprd_drm.c b/drivers/gpu/drm/sprd/sprd_drm.c
index 4abc0b0b14f46ced91ea4478d861931db83dc87c..6153c06573a355457f897c66c91ece409aba62bf 100644
--- a/drivers/gpu/drm/sprd/sprd_drm.c
+++ b/drivers/gpu/drm/sprd/sprd_drm.c
@@ -12,8 +12,10 @@
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
 
+#include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_fbdev_dma.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_of.h>
@@ -59,6 +61,8 @@ static struct drm_driver sprd_drm_drv = {
 	.dumb_create		= sprd_gem_dumb_create,
 	.gem_prime_import_sg_table = sprd_gem_prime_import_sg_table,
 
+	DRM_FBDEV_DMA_DRIVER_OPS,
+
 	.name			= DRIVER_NAME,
 	.desc			= DRIVER_DESC,
 	.major			= DRIVER_MAJOR,
@@ -152,6 +156,8 @@ static int sprd_drm_bind(struct device *dev)
 	if (ret < 0)
 		goto err_kms_helper_poll_fini;
 
+	drm_client_setup(drm, NULL);
+
 	return 0;
 
 err_kms_helper_poll_fini:

-- 
2.50.0

