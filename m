Return-Path: <linux-kernel+bounces-841993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5584DBB8BEC
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 11:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7C503472C1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 09:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DB0274B3C;
	Sat,  4 Oct 2025 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gTfOgpbc"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2097F26C3BC
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759570271; cv=none; b=Qbenn5f3lhkB/vqL9UGKlhK7kaUkv2+qbQnR0+FHO6BuC+uI2m+4Bxkuh6NsxKVQWmvJcMNNJTc65MrCeQRbMtoP2GUhN1YFJIDTQSdR8yvFvf83yBBjTvl2y1UCOaw5jc+W4U53Yf+Dyqr595bcDlerDlZfTGs6DGr6wHomLc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759570271; c=relaxed/simple;
	bh=bkezbEIN/CbG2AcIdbv+bXA+rrfF61uiuooCZCIYORU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CsrdI6xxCKOQEj7Jnr0MEX3jLsyEkd/YtsqfakymuEeDQBJ5zI2h+ufTBTFhU78qWLDg7GHIsKCJrKXW320Mpt1paxmCYBlaCSOsLO96UlVJkohyhrEYwFrFD58W/7M5iGWlY4SmClEXU68zyEm15V5QvZDZC6Y00maNifSnUZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gTfOgpbc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759570267;
	bh=bkezbEIN/CbG2AcIdbv+bXA+rrfF61uiuooCZCIYORU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gTfOgpbc2mhdiKwL0QkXhhnQMxpRluL2jTWjXjiHfykK3DN7GUiJFAq5UIEOgDbZo
	 tyv80u/mFf6qran+3pqQjT4Ay88OvsQaFJTeYFVq4dxyjTQQeClUal6cV7XskE1FVc
	 7VFmayDoK+oml/1maIcKCLZdlQVPRpC+mFARigxPebPvYTpbKTWQHghyaOEMUBaxm8
	 KOEop5dzprh6vCNiaNVNDSIU4Sqai08EBCCsvJD/8Epsg+zmQg+WfNFzZXmRE38qSn
	 OzkY5zogMoCiUQfA25GUEGMDgyUCCAMKJcPsqxtlLK5P42Zzv1zghyzvPDLS/mLYUu
	 ep9lFudV5vPTg==
Received: from debian-rockchip-rock5b-rk3588.. (unknown [IPv6:2a01:e0a:5e3:6100:2e0:4cff:fe03:d8c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A4F6F17E13D5;
	Sat,  4 Oct 2025 11:31:06 +0200 (CEST)
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
	Christopher Healy <healych@amazon.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-mm@kvack.org,
	kernel@collabora.com
Subject: [PATCH v3 04/10] drm/i915: Use huge tmpfs mount point helper
Date: Sat,  4 Oct 2025 11:30:47 +0200
Message-ID: <20251004093054.21388-5-loic.molinari@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251004093054.21388-1-loic.molinari@collabora.com>
References: <20251004093054.21388-1-loic.molinari@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make use of the new drm_gem_huge_mnt_create() helper to avoid code
duplication. Now that it's just a few lines long, the single function
in i915_gemfs.c is moved into v3d_gem_shmem.c.

v3:
- use huge tmpfs mountpoint in drm_device
- move i915_gemfs.c into i915_gem_shmem.c

Signed-off-by: Loïc Molinari <loic.molinari@collabora.com>
---
 drivers/gpu/drm/i915/Makefile                 |  3 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c     | 52 +++++++++----
 drivers/gpu/drm/i915/gem/i915_gemfs.c         | 74 -------------------
 drivers/gpu/drm/i915/gem/i915_gemfs.h         | 14 ----
 .../gpu/drm/i915/gem/selftests/huge_pages.c   | 10 +--
 drivers/gpu/drm/i915/i915_drv.h               |  5 --
 6 files changed, 45 insertions(+), 113 deletions(-)
 delete mode 100644 drivers/gpu/drm/i915/gem/i915_gemfs.c
 delete mode 100644 drivers/gpu/drm/i915/gem/i915_gemfs.h

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 853543443072..716291c3dcd3 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -162,8 +162,7 @@ gem-y += \
 	gem/i915_gem_ttm_move.o \
 	gem/i915_gem_ttm_pm.o \
 	gem/i915_gem_userptr.o \
-	gem/i915_gem_wait.o \
-	gem/i915_gemfs.o
+	gem/i915_gem_wait.o
 i915-y += \
 	$(gem-y) \
 	i915_active.o \
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index e3d188455f67..3344d6f5846e 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -9,14 +9,15 @@
 #include <linux/uio.h>
 
 #include <drm/drm_cache.h>
+#include <drm/drm_gem.h>
 
 #include "gem/i915_gem_region.h"
 #include "i915_drv.h"
 #include "i915_gem_object.h"
 #include "i915_gem_tiling.h"
-#include "i915_gemfs.h"
 #include "i915_scatterlist.h"
 #include "i915_trace.h"
+#include "i915_utils.h"
 
 /*
  * Move folios to appropriate lru and release the batch, decrementing the
@@ -506,9 +507,9 @@ static int __create_shmem(struct drm_i915_private *i915,
 	if (BITS_PER_LONG == 64 && size > MAX_LFS_FILESIZE)
 		return -E2BIG;
 
-	if (i915->mm.gemfs)
-		filp = shmem_file_setup_with_mnt(i915->mm.gemfs, "i915", size,
-						 flags);
+	if (i915->drm.huge_mnt)
+		filp = shmem_file_setup_with_mnt(i915->drm.huge_mnt, "i915",
+						 size, flags);
 	else
 		filp = shmem_file_setup("i915", size, flags);
 	if (IS_ERR(filp))
@@ -628,21 +629,46 @@ i915_gem_object_create_shmem_from_data(struct drm_i915_private *i915,
 
 static int init_shmem(struct intel_memory_region *mem)
 {
-	i915_gemfs_init(mem->i915);
-	intel_memory_region_set_name(mem, "system");
+	struct drm_i915_private *i915 = mem->i915;
+	int err;
 
-	return 0; /* We have fallback to the kernel mnt if gemfs init failed. */
-}
+	/*
+	 * By creating our own shmemfs mountpoint, we can pass in
+	 * mount flags that better match our usecase.
+	 *
+	 * One example, although it is probably better with a per-file
+	 * control, is selecting huge page allocations ("huge=within_size").
+	 * However, we only do so on platforms which benefit from it, or to
+	 * offset the overhead of iommu lookups, where with latter it is a net
+	 * win even on platforms which would otherwise see some performance
+	 * regressions such a slow reads issue on Broadwell and Skylake.
+	 */
 
-static int release_shmem(struct intel_memory_region *mem)
-{
-	i915_gemfs_fini(mem->i915);
-	return 0;
+	if (GRAPHICS_VER(i915) < 11 && !i915_vtd_active(i915))
+		goto no_thp;
+
+	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+		goto no_thp;
+
+	err = drm_gem_huge_mnt_create(&i915->drm, "within_size");
+	if (err && err != -EEXIST) {
+		drm_notice(&i915->drm,
+			   "Transparent Hugepage support is recommended for optimal performance%s\n",
+			   GRAPHICS_VER(i915) >= 11 ? " on this platform!" :
+						      " when IOMMU is enabled!");
+		goto no_thp;
+	}
+
+	drm_info(&i915->drm, "Using Transparent Hugepages\n");
+
+ no_thp:
+	intel_memory_region_set_name(mem, "system");
+
+	return 0; /* We have fallback to the kernel mnt if huge mnt failed. */
 }
 
 static const struct intel_memory_region_ops shmem_region_ops = {
 	.init = init_shmem,
-	.release = release_shmem,
 	.init_object = shmem_object_init,
 };
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gemfs.c b/drivers/gpu/drm/i915/gem/i915_gemfs.c
deleted file mode 100644
index a09e2eb47175..000000000000
--- a/drivers/gpu/drm/i915/gem/i915_gemfs.c
+++ /dev/null
@@ -1,74 +0,0 @@
-// SPDX-License-Identifier: MIT
-/*
- * Copyright © 2017 Intel Corporation
- */
-
-#include <linux/fs.h>
-#include <linux/mount.h>
-#include <linux/fs_context.h>
-
-#include "i915_drv.h"
-#include "i915_gemfs.h"
-#include "i915_utils.h"
-
-static int add_param(struct fs_context *fc, const char *key, const char *val)
-{
-	return vfs_parse_fs_string(fc, key, val, strlen(val));
-}
-
-void i915_gemfs_init(struct drm_i915_private *i915)
-{
-	struct file_system_type *type;
-	struct fs_context *fc;
-	struct vfsmount *gemfs;
-	int ret;
-
-	/*
-	 * By creating our own shmemfs mountpoint, we can pass in
-	 * mount flags that better match our usecase.
-	 *
-	 * One example, although it is probably better with a per-file
-	 * control, is selecting huge page allocations ("huge=within_size").
-	 * However, we only do so on platforms which benefit from it, or to
-	 * offset the overhead of iommu lookups, where with latter it is a net
-	 * win even on platforms which would otherwise see some performance
-	 * regressions such a slow reads issue on Broadwell and Skylake.
-	 */
-
-	if (GRAPHICS_VER(i915) < 11 && !i915_vtd_active(i915))
-		return;
-
-	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
-		goto err;
-
-	type = get_fs_type("tmpfs");
-	if (!type)
-		goto err;
-
-	fc = fs_context_for_mount(type, SB_KERNMOUNT);
-	if (IS_ERR(fc))
-		goto err;
-	ret = add_param(fc, "source", "tmpfs");
-	if (!ret)
-		ret = add_param(fc, "huge", "within_size");
-	if (!ret)
-		gemfs = fc_mount_longterm(fc);
-	put_fs_context(fc);
-	if (ret)
-		goto err;
-
-	i915->mm.gemfs = gemfs;
-	drm_info(&i915->drm, "Using Transparent Hugepages\n");
-	return;
-
-err:
-	drm_notice(&i915->drm,
-		   "Transparent Hugepage support is recommended for optimal performance%s\n",
-		   GRAPHICS_VER(i915) >= 11 ? " on this platform!" :
-					      " when IOMMU is enabled!");
-}
-
-void i915_gemfs_fini(struct drm_i915_private *i915)
-{
-	kern_unmount(i915->mm.gemfs);
-}
diff --git a/drivers/gpu/drm/i915/gem/i915_gemfs.h b/drivers/gpu/drm/i915/gem/i915_gemfs.h
deleted file mode 100644
index 16d4333c9a4e..000000000000
--- a/drivers/gpu/drm/i915/gem/i915_gemfs.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-/*
- * Copyright © 2017 Intel Corporation
- */
-
-#ifndef __I915_GEMFS_H__
-#define __I915_GEMFS_H__
-
-struct drm_i915_private;
-
-void i915_gemfs_init(struct drm_i915_private *i915);
-void i915_gemfs_fini(struct drm_i915_private *i915);
-
-#endif
diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
index bd08605a1611..b41a38af63fd 100644
--- a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
+++ b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
@@ -1316,7 +1316,7 @@ typedef struct drm_i915_gem_object *
 
 static inline bool igt_can_allocate_thp(struct drm_i915_private *i915)
 {
-	return i915->mm.gemfs && has_transparent_hugepage();
+	return i915->drm.huge_mnt && has_transparent_hugepage();
 }
 
 static struct drm_i915_gem_object *
@@ -1761,7 +1761,7 @@ static int igt_tmpfs_fallback(void *arg)
 	struct drm_i915_private *i915 = arg;
 	struct i915_address_space *vm;
 	struct i915_gem_context *ctx;
-	struct vfsmount *gemfs = i915->mm.gemfs;
+	struct vfsmount *huge_mnt = i915->drm.huge_mnt;
 	struct drm_i915_gem_object *obj;
 	struct i915_vma *vma;
 	struct file *file;
@@ -1782,10 +1782,10 @@ static int igt_tmpfs_fallback(void *arg)
 	/*
 	 * Make sure that we don't burst into a ball of flames upon falling back
 	 * to tmpfs, which we rely on if on the off-chance we encounter a failure
-	 * when setting up gemfs.
+	 * when setting up a huge mountpoint.
 	 */
 
-	i915->mm.gemfs = NULL;
+	i915->drm.huge_mnt = NULL;
 
 	obj = i915_gem_object_create_shmem(i915, PAGE_SIZE);
 	if (IS_ERR(obj)) {
@@ -1819,7 +1819,7 @@ static int igt_tmpfs_fallback(void *arg)
 out_put:
 	i915_gem_object_put(obj);
 out_restore:
-	i915->mm.gemfs = gemfs;
+	i915->drm.huge_mnt = huge_mnt;
 
 	i915_vm_put(vm);
 out:
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 2f3965feada1..49987f4c6ffe 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -142,11 +142,6 @@ struct i915_gem_mm {
 	 */
 	atomic_t free_count;
 
-	/**
-	 * tmpfs instance used for shmem backed objects
-	 */
-	struct vfsmount *gemfs;
-
 	struct intel_memory_region *regions[INTEL_REGION_UNKNOWN];
 
 	struct notifier_block oom_notifier;
-- 
2.47.3


