Return-Path: <linux-kernel+bounces-789159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77770B391C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481AD3B5B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938C1264636;
	Thu, 28 Aug 2025 02:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Ic46tJvh"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64E325BEF8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756348539; cv=pass; b=joeXj82dl7sQU9Jw5hCqmr+rjd7VSOdW0B2KCaDsl0ueq1XxZaN2/4r1LO46MyEFN5W+sFVO1zr2BZLFIc2rJrgdi0dbGwO5tt3IwDhEm0fXPori1oMXEFnpDRPf1Cj0YIiYfTaV0Unnhtu+PSKRvT3R6FrNjX/vZ4Nm9unnIyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756348539; c=relaxed/simple;
	bh=j1Gitwkm4En+JoTojCmV16fbmEt2ycquiz14lw46/jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V52mSMjTxzVpmClanpIvg6kGgVFAHd+Ntc+Kg7lOXKYyspDYdy2+JTL507vp0Wfo8RR3Djd/XcNE5N1+18u+Mmcr4iKoyJODWr8Dv5bPGZwodwBx3nWXk0c9kzmtUqDDumD+FAORRxSHvw0JkwdBhct7TP+iuvrLsVu9VOvnSYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=Ic46tJvh; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756348517; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FZHPNHJuaJ/ya76DB++rRFwIXmXyFCHu7xddqfci852BHbOEvvcA9xMqOtmK2EflDjHU3/tqg3GSW9cr8VwPWhuWKXe/d9zRlE0ki2XWpju407e5KE2h+LTp+oKMx0H5aWBaILVEq6TrqlpbF48KkSbSblBCnCt46g7m9iiKztg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756348517; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ahg0uZ2g/6UpbHdYm0+DfmTgyMu38iJj+ckHrZ7WQDs=; 
	b=eOc0o6HSm5bPfU/RTbDlENwOaw84pKj2Xm/rSE+jY1uT9J35AODNzfdl3jCbdGQp5l7Jqs8GovdJ844Q2bxwM4XPnHJ4MN3rWqdEw+zw6BSEOMPhXGsxciiDJCQhWZEKvvuvj5Mvhpt39cwJs0sduNjyuw1+hPvhLenhiUmLryQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756348517;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Ahg0uZ2g/6UpbHdYm0+DfmTgyMu38iJj+ckHrZ7WQDs=;
	b=Ic46tJvh8E/kUfX3M/bWifavhfM1zyWUJmE0zcn7o5ZgjhOghd4ZKJbdgbgJQbKg
	TPqCAV/b67/VgBuzidoyLTIGljJcduulWS0zgOf8KrV4EH5JgOvi+L84jKr+oNJsBKH
	fU09x7e1mIM3Hrjy0GSrNUtlN0h9FGPfXcdR96FE=
Received: by mx.zohomail.com with SMTPS id 1756348515901842.2094297680466;
	Wed, 27 Aug 2025 19:35:15 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 4/5] drm/panfrost: Expose JM context IOCTLs to UM
Date: Thu, 28 Aug 2025 03:34:07 +0100
Message-ID: <20250828023422.2404784-5-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250828023422.2404784-1-adrian.larumbe@collabora.com>
References: <20250828023422.2404784-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Boris Brezillon <boris.brezillon@collabora.com>

Minor revision of the driver must be bumped because this expands the
uAPI. On top of that, let user know the available priorities so that
they can create contexts with legal priority values.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 398c067457d9..b54cdd589ec4 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <drm/panfrost_drm.h>
+#include <drm/drm_auth.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_ioctl.h>
@@ -109,6 +110,15 @@ static int panfrost_ioctl_get_param(struct drm_device *ddev, void *data, struct
 #endif
 		break;
 
+	case DRM_PANFROST_PARAM_ALLOWED_JM_CTX_PRIORITIES:
+		param->value = BIT(PANFROST_JM_CTX_PRIORITY_LOW) |
+			       BIT(PANFROST_JM_CTX_PRIORITY_MEDIUM);
+
+		/* High prio require CAP_SYS_NICE or DRM_MASTER */
+		if (capable(CAP_SYS_NICE) || drm_is_current_master(file))
+			param->value |= BIT(PANFROST_JM_CTX_PRIORITY_HIGH);
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -547,6 +557,24 @@ static int panfrost_ioctl_set_label_bo(struct drm_device *ddev, void *data,
 	return ret;
 }
 
+static int panfrost_ioctl_jm_ctx_create(struct drm_device *dev, void *data,
+					struct drm_file *file)
+{
+	return panfrost_jm_ctx_create(file, data);
+}
+
+static int panfrost_ioctl_jm_ctx_destroy(struct drm_device *dev, void *data,
+					 struct drm_file *file)
+{
+	const struct drm_panfrost_jm_ctx_destroy *args = data;
+
+	/* We can't destroy the default context created when the file is opened. */
+	if (!args->handle)
+		return -EINVAL;
+
+	return panfrost_jm_ctx_destroy(file, args->handle);
+}
+
 int panfrost_unstable_ioctl_check(void)
 {
 	if (!unstable_ioctls)
@@ -614,6 +642,8 @@ static const struct drm_ioctl_desc panfrost_drm_driver_ioctls[] = {
 	PANFROST_IOCTL(PERFCNT_DUMP,	perfcnt_dump,	DRM_RENDER_ALLOW),
 	PANFROST_IOCTL(MADVISE,		madvise,	DRM_RENDER_ALLOW),
 	PANFROST_IOCTL(SET_LABEL_BO,	set_label_bo,	DRM_RENDER_ALLOW),
+	PANFROST_IOCTL(JM_CTX_CREATE,	jm_ctx_create,	DRM_RENDER_ALLOW),
+	PANFROST_IOCTL(JM_CTX_DESTROY,	jm_ctx_destroy,	DRM_RENDER_ALLOW),
 };
 
 static void panfrost_gpu_show_fdinfo(struct panfrost_device *pfdev,
@@ -710,6 +740,8 @@ static void panfrost_debugfs_init(struct drm_minor *minor)
  * - 1.3 - adds JD_REQ_CYCLE_COUNT job requirement for SUBMIT
  *       - adds SYSTEM_TIMESTAMP and SYSTEM_TIMESTAMP_FREQUENCY queries
  * - 1.4 - adds SET_LABEL_BO
+ * - 1.5 - adds JM_CTX_{CREATE,DESTROY} ioctls and extend SUBMIT to allow
+ *	   context creation with configurable priorities/affinity
  */
 static const struct drm_driver panfrost_drm_driver = {
 	.driver_features	= DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ,
-- 
2.50.0


