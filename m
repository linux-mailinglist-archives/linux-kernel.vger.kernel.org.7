Return-Path: <linux-kernel+bounces-737717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CA6B0AFB6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 14:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34D63A823E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F604233136;
	Sat, 19 Jul 2025 12:11:41 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD0772629;
	Sat, 19 Jul 2025 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752927101; cv=none; b=gDiaOADmHDJ4EManh/bo35wwUXsXsIYXfmJNWh3RNSVeSnocpJGekmUgdOinx50OYBkp747aTBy2HdEC+KwoGSVTHez1V0b1S3E19FQbGUrsVhAxR/gzudohARosh4n/XX/OnDpEt0SAtJKAz2Wgz8TdvrVDTL1QZlf9+ERsENc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752927101; c=relaxed/simple;
	bh=kr+TQICQmSvr2tUxu8FfTrpZgZmmd/XMHzDkNKDPs5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IYDL8fBPMKYgcV+Ln/zvYyqEPxCXDOghz5q+cx1xd7YcEMu45/ogzfSmEv3h0r8oZO/Hblpd/siOsvMixjMSA/jqsNUDHYnEdvT9A+5MnzBuHyyXaGPBqOgTyDfZvtEbCAz0tqpRHdKsejMDto/3+UfsowmDJUMModVsLSpsYgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 32FB11C233F;
	Sat, 19 Jul 2025 14:11:35 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdf7:4000:ceae:3606:9020:cd4f])
	by srv01.abscue.de (Postfix) with ESMTPSA id 96D8A1C233E;
	Sat, 19 Jul 2025 14:11:34 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Sat, 19 Jul 2025 14:09:47 +0200
Subject: [PATCH 11/12] drm: sprd: add fbdev support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250719-ums9230-drm-v1-11-e4344a05eb3d@abscue.de>
References: <20250719-ums9230-drm-v1-0-e4344a05eb3d@abscue.de>
In-Reply-To: <20250719-ums9230-drm-v1-0-e4344a05eb3d@abscue.de>
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
 drivers/gpu/drm/sprd/sprd_drm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/sprd/sprd_drm.c b/drivers/gpu/drm/sprd/sprd_drm.c
index ceacdcb7c566d00b98d83c27dbab80523bc6a7d5..db6b3790d29ac324a88ecb57a66247f55d40a794 100644
--- a/drivers/gpu/drm/sprd/sprd_drm.c
+++ b/drivers/gpu/drm/sprd/sprd_drm.c
@@ -11,8 +11,10 @@
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
 
+#include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_fbdev_dma.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_of.h>
@@ -55,6 +57,7 @@ static struct drm_driver sprd_drm_drv = {
 
 	/* GEM Operations */
 	DRM_GEM_DMA_DRIVER_OPS,
+	DRM_FBDEV_DMA_DRIVER_OPS,
 
 	.name			= DRIVER_NAME,
 	.desc			= DRIVER_DESC,
@@ -106,6 +109,8 @@ static int sprd_drm_bind(struct device *dev)
 	if (ret < 0)
 		goto err_kms_helper_poll_fini;
 
+	drm_client_setup(drm, NULL);
+
 	return 0;
 
 err_kms_helper_poll_fini:

-- 
2.50.0

