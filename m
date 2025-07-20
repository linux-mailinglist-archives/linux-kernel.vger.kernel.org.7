Return-Path: <linux-kernel+bounces-737989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD15B0B2E6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 02:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3549E1AA0600
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3AF1A0711;
	Sun, 20 Jul 2025 00:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2m8MpzV"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0619E195811
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 00:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752969743; cv=none; b=kUyJzstp+BxwadywLBM0ZPkfLPwrOB1wlCYJVu1oztr/SmSJgSus7bB8+O/jezOaJf30OMesYm+N/kjUrr9BW7NTRrJC58eHDA/hnxu6Wi5WzJ+x42SLfyqMq6ccz4P8pOoAEpkP8SDLcWGPgQMzspr9ZUFOqrSp2BkLKcC4Uxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752969743; c=relaxed/simple;
	bh=gxOUApwD6a6hVLA4HlyQvzWI6akY3VWjxBUdWvLj68E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRtDke4/VeglyjPwHbqgqFm3vI+W4c+WbdlVAP1m2sex+EJgNvQGpv8neE1CwLzI96JzFjAVV50TQrsyYVs04E8rTAxIZPATFHmaUN0NZyDALvQUSQt80vgVfGbBERNU7vzv9aO9j+IfKOmAoZPGI510wJFgpSfy1XiK0F2EoMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2m8MpzV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-235ef62066eso38565045ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752969740; x=1753574540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84kX2XXjEmF3ERut/9hhHijiazxXV8Nw4X0UoQzs5OY=;
        b=M2m8MpzVmzD6N5UgJXWT2fTbPEszK7cV6gQq7vXxaqxDNWcJi+PEGHBQW4poHBItbl
         p4eiXgwrIivXbM1P/460pa0qM5YWxVlLo0Wim+RoaxfxTWToj1H0lyMm7VmYD1OQlLAf
         sQzdSt1Zukw74XPlBXpIBXV1UFBe5Q+Rs1VfpobBlaVE8s32PCMF8EpsWFgmeWq1Tn9r
         qFQD0H6MqlKjkE3Acc5yWCkxRONnY5DH7sH0cDFjvDrvLOE7o7zdQ4eoATWdVLNE0ebE
         f6B0dFJXkmL3aCjeUyy+f2ifrSGUtdZvchYh/CPDVUi46hTHvI6Lubl3nC/DBypdBVLd
         H9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752969740; x=1753574540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84kX2XXjEmF3ERut/9hhHijiazxXV8Nw4X0UoQzs5OY=;
        b=AosfmW+jwniVkAXpo2yIfOYiEn2sr46VSko5ble2PR0fPS2mBmptaKTeJiQzel3JGF
         Yduf35btrr0kwzmQmj+spaJrbqOVT/k0iKTvAxGR0Avr9OlLBpoe/vMBY9pocPGqs9JE
         2o+mjNUhMco78FydyoYuxu+I5l9IK97C7iQJWVKtVs1OnA/2MK+NB3Z6of0nszqoaxxR
         78EekF0eVsOZfKccvmNkoijwos/q9MEWGs46J0UtgipSOzMMOTuVUUwV0wcPvA1xpvSx
         Bnn2agd0xR4Vk+rIxtDqfKLn4Ij5e2Jri2hPoRrz3N8Aiu5uIfVrjymSVQr2hHJ/jwTH
         C8Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUp8eYqCMIDRo6Yv+48OLS9IQ9EURz6u86RxWqbNKIZoGGb5sW/K4QgMWGSLOmJTTOMjGIy9u98jxI8P00=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYRgpd0R/Kp4/PDWaz7y9rkWS0PB/Gu1VZNno8BaQb0WEWPdJn
	l7Qhgr5Rto9DtH8UlUfzA+kK6iSZ+aNHr66768x8UMC31tzM3RmccTwy
X-Gm-Gg: ASbGncvTX2nwDGofVHWfvWLHxHLhsuCdBDjPslHrSGSwNQWmX7SeqO/2lBOWp0I7jhV
	bkpL4YdEQ8fEFo024hN4r0EdlYIprrdqYzS/EVvT1sPZEC5M7MhpkK5uM6ijgEPGPhUT1U+4bKt
	ulDgdiZfg9b4Okulu1g0G36k1S52J5IvYX7sWmVHfxRj3gIq53lNqBLTPg8cFQoqYEgglpfyGcu
	HvUe9l5rdZL3ZWBPDlSyGWZKjsKHaYcGiAekWR5sX6Epxof8vI3iSwik38RWYeasgZvCmbpusc7
	nP8RThTj2JwkYiFgQuiye+f7H8o5A/9Z2ITz57HlUUFQ9ZbXBTk+3u3JEb6ezmpnocUqxbGrpEK
	t/JImbApWy4Q7LHHDUMq62njGTmbWj5Rzd+2qvZ43r5l8hOJo7cc8
X-Google-Smtp-Source: AGHT+IGrdnG0OWJunucDj7yzg7E2yLnTs0LAdIZYU4n36wPhEob7h9C1DqLDA0cQ6ZgUGwr9uA3FPQ==
X-Received: by 2002:a17:903:8c5:b0:23d:da20:1685 with SMTP id d9443c01a7336-23e302821f4mr152125815ad.4.1752969740108;
        Sat, 19 Jul 2025 17:02:20 -0700 (PDT)
Received: from localhost (111-252-5-201.dynamic-ip.hinet.net. [111.252.5.201])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23e3b708763sm33826375ad.230.2025.07.19.17.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 17:02:19 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 9/9] drm/panthor: add DRM_PANTHOR_VM_BIND_OP_MAP_DUMPABLE
Date: Sat, 19 Jul 2025 17:01:46 -0700
Message-ID: <20250720000146.1405060-10-olvaffe@gmail.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250720000146.1405060-1-olvaffe@gmail.com>
References: <20250720000146.1405060-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the flag is set, bo data is captured for devcoredump.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_coredump.c | 36 ++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_drv.c      |  3 +-
 drivers/gpu/drm/panthor/panthor_mmu.c      |  7 +++--
 include/uapi/drm/panthor_drm.h             |  7 +++++
 4 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_coredump.c b/drivers/gpu/drm/panthor/panthor_coredump.c
index 5502452a5baa..db5695b38c2d 100644
--- a/drivers/gpu/drm/panthor/panthor_coredump.c
+++ b/drivers/gpu/drm/panthor/panthor_coredump.c
@@ -5,6 +5,7 @@
 #include <drm/drm_print.h>
 #include <drm/drm_managed.h>
 #include <generated/utsrelease.h>
+#include <linux/ascii85.h>
 #include <linux/devcoredump.h>
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
@@ -99,6 +100,26 @@ static const char *reason_str(enum panthor_coredump_reason reason)
 	}
 }
 
+static void print_bo(struct drm_printer *p, struct panthor_gem_object *bo,
+		     u64 offset, u64 size)
+{
+	struct iosys_map map;
+	const u32 *vals;
+	u64 count;
+	char buf[ASCII85_BUFSZ];
+
+	if (drm_gem_vmap(&bo->base.base, &map))
+		return;
+
+	/* offset and size are aligned to panthor_vm_page_size, which is SZ_4K */
+	vals = map.vaddr + offset;
+	count = size / sizeof(u32);
+	for (u64 i = 0; i < count; i++)
+		drm_puts(p, ascii85_encode(vals[i], buf));
+
+	drm_gem_vunmap(&bo->base.base, &map);
+}
+
 static void print_vma(struct drm_printer *p,
 		      const struct panthor_coredump_vma_state *vma, u32 vma_id,
 		      size_t *max_dyn_size)
@@ -129,6 +150,21 @@ static void print_vma(struct drm_printer *p,
 			}
 		}
 	}
+
+	if (vma->flags & DRM_PANTHOR_VM_BIND_OP_MAP_DUMPABLE) {
+		drm_puts(p, "    data: |\n");
+		drm_puts(p, "      ");
+
+		/* bo data is dynamic */
+		if (max_dyn_size) {
+			*max_dyn_size +=
+				vma->size / sizeof(u32) * (ASCII85_BUFSZ - 1);
+		} else {
+			print_bo(p, bo, vma->bo_offset, vma->size);
+		}
+
+		drm_puts(p, "\n");
+	}
 }
 
 static void print_as(struct drm_printer *p,
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 1116f2d2826e..6c4de1e73cd1 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1608,6 +1608,7 @@ static void panthor_debugfs_init(struct drm_minor *minor)
  * - 1.3 - adds DRM_PANTHOR_GROUP_STATE_INNOCENT flag
  * - 1.4 - adds DRM_IOCTL_PANTHOR_BO_SET_LABEL ioctl
  * - 1.5 - adds DRM_PANTHOR_SET_USER_MMIO_OFFSET ioctl
+ * - 1.6 - adds DRM_PANTHOR_VM_BIND_OP_MAP_DUMPABLE flag
  */
 static const struct drm_driver panthor_drm_driver = {
 	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
@@ -1621,7 +1622,7 @@ static const struct drm_driver panthor_drm_driver = {
 	.name = "panthor",
 	.desc = "Panthor DRM driver",
 	.major = 1,
-	.minor = 5,
+	.minor = 6,
 
 	.gem_create_object = panthor_gem_create_object,
 	.gem_prime_import_sg_table = drm_gem_shmem_prime_import_sg_table,
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 7862c99984b6..72b1b2799b65 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2045,10 +2045,11 @@ static void panthor_vma_init(struct panthor_vma *vma, u32 flags)
 	vma->flags = flags;
 }
 
-#define PANTHOR_VM_MAP_FLAGS \
+#define PANTHOR_VM_MAP_FLAGS                   \
 	(DRM_PANTHOR_VM_BIND_OP_MAP_READONLY | \
-	 DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC | \
-	 DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED)
+	 DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC |   \
+	 DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED | \
+	 DRM_PANTHOR_VM_BIND_OP_MAP_DUMPABLE)
 
 static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
 {
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index e1f43deb7eca..c4c5e38365e9 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -496,6 +496,13 @@ enum drm_panthor_vm_bind_op_flags {
 	 */
 	DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED = 1 << 2,
 
+	/**
+	 * @DRM_PANTHOR_VM_BIND_OP_MAP_DUMPABLE: Dump the VMA for devcoredump.
+	 *
+	 * Only valid with DRM_PANTHOR_VM_BIND_OP_TYPE_MAP.
+	 */
+	DRM_PANTHOR_VM_BIND_OP_MAP_DUMPABLE = 1 << 3,
+
 	/**
 	 * @DRM_PANTHOR_VM_BIND_OP_TYPE_MASK: Mask used to determine the type of operation.
 	 */
-- 
2.50.0.727.gbf7dc18ff4-goog


