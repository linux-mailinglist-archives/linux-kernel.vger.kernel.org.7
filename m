Return-Path: <linux-kernel+bounces-862748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECC3BF611B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854BE189C7EF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8681332E72E;
	Tue, 21 Oct 2025 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LT69Zf2w"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EAC32E6B6;
	Tue, 21 Oct 2025 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046268; cv=none; b=c+o4O/5ooAN027UBJcLVcjg4U2HWqnl25zBdqPVbV5pTQjWK9bpOLXHZaaWBEiTj2Iu9iblDV7f8VimJ/kNw/Upv0K3NJJGhHN7VelEaap3P6eKVvPFX2yzo85rLrv3jCZGZ0ktEP+JIXpaeQwwy/YndI5G/Ut/PLSZouzC6xmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046268; c=relaxed/simple;
	bh=2kxORnZqohgg59LcjkC0YKU2FwOgFG+Y1Wny731E5Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBs9qQN/YfCPUTSoyGCIjKIIpGsWcL0Hv6/UvPxqdpaSHCY+fK8RSCDWkELAY2gE0o4cWvqdsLuoGRdb69sVzgm1N6W2RwmO/VzMThy1nLDgOEJvQ/21VAqQrZV0qiTbEFS1o1OP7oKzmr20VTcU1gvh647J2bvslN1UOGVqUAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LT69Zf2w; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761046264;
	bh=2kxORnZqohgg59LcjkC0YKU2FwOgFG+Y1Wny731E5Eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LT69Zf2w4TjxCdii1GpVv2a3BuH10tcI7NrWGD5Bywi7YPXTBKhBVaYw4xQtMPeCN
	 2BEv6lmbL+xjJdEIZBCT2wpBj4UlLMzE3NAlhX7l3l7toy+jWwuGkVom1ZuPr1tEpw
	 0S1Yc2IoSMbLNyRF7S0aumzj2bW0wY6ofu6/d6JnfEURR+/CoZGN2jCZRCE06LXiGY
	 6h0L3kMFyFKyG4t/Y6TySbCOu6sViiEQP0cEdYIF8Y1H+VBmAJjt3Va1u/2CwcNITL
	 1hWYfVnutc4BSUJp157gZY0vtymfGmhapc0yKlAKAUqZKU+OjgaONs5WOmsbSYzylW
	 J/62fMysE6CUg==
Received: from debian-rockchip-rock5b-rk3588.. (unknown [IPv6:2a01:e0a:5e3:6100:826d:bc07:e98c:84a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DC2EA17E159D;
	Tue, 21 Oct 2025 13:31:03 +0200 (CEST)
From: =?UTF-8?q?Lo=C3=AFc=20Molinari?= <loic.molinari@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Melissa Wen <mwen@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Lo=C3=AFc=20Molinari?= <loic.molinari@collabora.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	=?UTF-8?q?Miko=C5=82aj=20Wasiak?= <mikolaj.wasiak@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Nitin Gote <nitin.r.gote@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Christopher Healy <healych@amazon.com>,
	Matthew Wilcox <willy@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v5 09/12] drm/panthor: Introduce huge tmpfs mountpoint option
Date: Tue, 21 Oct 2025 13:30:46 +0200
Message-ID: <20251021113049.17242-10-loic.molinari@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021113049.17242-1-loic.molinari@collabora.com>
References: <20251021113049.17242-1-loic.molinari@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce the 'panthor.transparent_hugepage' boolean module parameter
(false by default). When the parameter is set to true, a new tmpfs
mountpoint is created and mounted using the 'huge=within_size'
option. It's then used at GEM object creation instead of the default
'shm_mnt' mountpoint in order to enable Transparent Hugepage (THP) for
the object (without having to rely on a system wide parameter).

v3:
- use huge tmpfs mountpoint in drm_device

v4:
- fix builds with CONFIG_TRANSPARENT_HUGEPAGE=n
- clean up mountpoint creation error handling
- print negative error value

v5:
- use drm_gem_has_huge_tmp() helper
- get rid of CONFIG_TRANSPARENT_HUGEPAGE ifdefs

Signed-off-by: Loïc Molinari <loic.molinari@collabora.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c |  3 +++
 drivers/gpu/drm/panthor/panthor_drv.c    |  7 +++++++
 drivers/gpu/drm/panthor/panthor_drv.h    |  9 +++++++++
 drivers/gpu/drm/panthor/panthor_gem.c    | 18 ++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_gem.h    |  2 ++
 5 files changed, 39 insertions(+)
 create mode 100644 drivers/gpu/drm/panthor/panthor_drv.h

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index c7033d82cef5..4ced0bef22e8 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -17,6 +17,7 @@
 #include "panthor_devfreq.h"
 #include "panthor_device.h"
 #include "panthor_fw.h"
+#include "panthor_gem.h"
 #include "panthor_gpu.h"
 #include "panthor_hw.h"
 #include "panthor_mmu.h"
@@ -271,6 +272,8 @@ int panthor_device_init(struct panthor_device *ptdev)
 	if (ret)
 		goto err_unplug_fw;
 
+	panthor_gem_init(ptdev);
+
 	/* ~3 frames */
 	pm_runtime_set_autosuspend_delay(ptdev->base.dev, 50);
 	pm_runtime_use_autosuspend(ptdev->base.dev);
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index fb4b293f17f0..9e49af1d0959 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1556,6 +1556,7 @@ static const struct file_operations panthor_drm_driver_fops = {
 	.read = drm_read,
 	.llseek = noop_llseek,
 	.mmap = panthor_mmap,
+	.get_unmapped_area = drm_gem_get_unmapped_area,
 	.show_fdinfo = drm_show_fdinfo,
 	.fop_flags = FOP_UNSIGNED_OFFSET,
 };
@@ -1623,6 +1624,12 @@ static const struct drm_driver panthor_drm_driver = {
 #endif
 };
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+bool panthor_transparent_hugepage;
+module_param_named(transparent_hugepage, panthor_transparent_hugepage, bool, 0400);
+MODULE_PARM_DESC(transparent_hugepage, "Use a dedicated tmpfs mount point with Transparent Hugepage enabled (false = default)");
+#endif
+
 static int panthor_probe(struct platform_device *pdev)
 {
 	struct panthor_device *ptdev;
diff --git a/drivers/gpu/drm/panthor/panthor_drv.h b/drivers/gpu/drm/panthor/panthor_drv.h
new file mode 100644
index 000000000000..79dccd289881
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_drv.h
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2025 Amazon.com, Inc. or its affiliates */
+
+#ifndef __PANTHOR_DRV_H__
+#define __PANTHOR_DRV_H__
+
+extern bool panthor_transparent_hugepage;
+
+#endif
diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 156c7a0b62a2..b5326b29417c 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 /* Copyright 2019 Linaro, Ltd, Rob Herring <robh@kernel.org> */
 /* Copyright 2023 Collabora ltd. */
+/* Copyright 2025 Amazon.com, Inc. or its affiliates */
 
 #include <linux/cleanup.h>
 #include <linux/dma-buf.h>
@@ -11,10 +12,27 @@
 #include <drm/panthor_drm.h>
 
 #include "panthor_device.h"
+#include "panthor_drv.h"
 #include "panthor_fw.h"
 #include "panthor_gem.h"
 #include "panthor_mmu.h"
 
+void panthor_gem_init(struct panthor_device *ptdev)
+{
+	int err;
+
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
+	    !panthor_transparent_hugepage)
+		return;
+
+	err = drm_gem_huge_mnt_create(&ptdev->base, "within_size");
+	if (drm_gem_has_huge_mnt(&ptdev->base))
+		drm_info(&ptdev->base, "Using Transparent Hugepage\n");
+	else if (err)
+		drm_warn(&ptdev->base, "Can't use Transparent Hugepage (%d)\n",
+			 err);
+}
+
 #ifdef CONFIG_DEBUG_FS
 static void panthor_gem_debugfs_bo_init(struct panthor_gem_object *bo)
 {
diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
index 80c6e24112d0..2eefe9104e5e 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.h
+++ b/drivers/gpu/drm/panthor/panthor_gem.h
@@ -136,6 +136,8 @@ struct panthor_gem_object *to_panthor_bo(struct drm_gem_object *obj)
 	return container_of(to_drm_gem_shmem_obj(obj), struct panthor_gem_object, base);
 }
 
+void panthor_gem_init(struct panthor_device *ptdev);
+
 struct drm_gem_object *panthor_gem_create_object(struct drm_device *ddev, size_t size);
 
 int
-- 
2.47.3


