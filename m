Return-Path: <linux-kernel+bounces-737987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF82B0B2E5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 02:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0EC3C0684
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712CD174EE4;
	Sun, 20 Jul 2025 00:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqDloBrT"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BD884D13
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 00:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752969738; cv=none; b=Bt2YAQPBVm52bV6L++QkIFESYlqRMpmYInuhub6CxDHWuVx351Ft9voN+zpGWwRd5ZcR7XyjrwtZEC/i7gZhmaJmBEeI2VGBsoAhBtCo+hJLS6K1P6BSln0zYmH/3ij9Fa/TqO0v74xxNHrS3eWCMVF6nIw3YFT2Ju8XD4fuopY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752969738; c=relaxed/simple;
	bh=joTG/gyzlU12QP6ZdQeWZiq6PIvE8HoH+TkNL7bb6ZI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1docHbMO566w1yND+cdR1GnpO8oeE2QNcm8r/Pn0Xf1Hg+1IdLNCXgOgONVX9UL1IU+BIylBbOOQ36ubGaFv0AtboK/ut6AFuPI2heAy7N/E8X+M+hpIurVUeiXIfZvNBDzXYbJK2CGveEFYs4xK2gWTmjT5ZIf9r0YT/RghqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqDloBrT; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3134c67a173so3205311a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752969736; x=1753574536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58f3tD8aPkmsl5w2Gd3Jc7Y+VkmK8hdA51D4qILTFqg=;
        b=IqDloBrTkDdAEru62qIVraULov7UcRMgNPtaxYJTBPwfBk6nqscsynRxwbNcMDgoh1
         Vi5GFJ1JZXdx8AgPVZL9e3LTQ3uL16XdvMBtH/WFZB1DIvVxu9hE3XixJcquiN51a/3b
         7CnhNNFGn4IxvEJ6x20yP2D3mfY8aik7GBjASCj8VZl/fCKpVwAKPNkgflCRyYtpJbPM
         Aa/pmTQuVakNSuJU/1hdiLX8e3og4R1LoRgnBrBT7MunrJRHUOen2F1kFdU8n6nD2H2D
         FA+IgUgW8ZiGVr2LaJpDUUWkOnrygBdCx3SnKlhuHPJDHNoY0Gkv2xC7ggs5kKnxBL7S
         Rd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752969736; x=1753574536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58f3tD8aPkmsl5w2Gd3Jc7Y+VkmK8hdA51D4qILTFqg=;
        b=k73Vh++w3AXuhvlPVLjjFd4bzL15VkoyEVHu08BkeDSBNlIIpk1TN1zw9f2UG4Eb6Y
         y/NTetHdz2D8IzGDwylCS84VuCYaTfhxwKVWPzC8kknS2ZT/L34Wd5csGthdlsi8m4aI
         uaqcbtCDySp2MhB8yHyDPFIeYq0er8n0sOvjvPRuX2gEIiTg0On+01DVa0+nPWv2Y2XC
         nofrQroMouZSsVhmzmqsaWYaUyMLUOS77UzpIcZ3NsMawBxMvMQiajQQdhh9xeGL/7+X
         GE501ucrQD/k968j4AEE1uI+yUak4uz9DXbq42kohXPgpHqoB8b0P4K4LCAbbCvlQMY5
         dDgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8YysjP8wUAWC7xYidyoDZ7kUq259ID3foIaMU8gd+LDCZn5miO0moj6xJcqkLOcHjAc4hZ/AzwIpMpwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMJl2O9mGHwiTjWZuB/46HSHhyvB/kZOmHl/AKTnoEqDOMeY8F
	BnlHDUt/1Qdjf0V6voUE4xTsQdqxT9CSwBcKmz6gNApR5B3b8CEHRvPm
X-Gm-Gg: ASbGncv6LovwNihU3ECbqWdlz3n8UKnfL5O0EU5TZW9FoNDXtis0NXHQ/b9OqWH1Ka4
	sZ6WmSwOmxKt3TcSiP7mLPtdLI+W+PAozh9/n4VvziipuYot/0Lg7soqVXNS1P39RKupzrO3gex
	iRYQDuZdRW1WgNcuKie5ubgZwLLbO0SUU6C20vycB9e6hQNGHYoXs/nzL9RbHMi4RvUyZ5YVSiD
	j64n/v9cbLWjphgzAh4quRLyNWoN5qPogR2gC9hHlHjJMjfTv89dbOzaoXxRyo1Fl1yx5q6PmWF
	LWpFYD476AFD11X5elfJlTKCIroxORnmUG00OBl9dsk5BfAl79r3qzud5GvHrdf+iOUe7zxRBHe
	XpOXuamWmXVColbmGmWyJUkw2tC2qsUIGAZ9NWwdxL5ZqBLRayQFO
X-Google-Smtp-Source: AGHT+IG7aiwX/LxwDcgqsWHtJ3RqmQqG9q/LvmOIMnalP+OJlsLNCbZzZqEvjL/4wT5Ii8TtkPIJvw==
X-Received: by 2002:a17:90b:2650:b0:311:baa0:89ce with SMTP id 98e67ed59e1d1-31c9f3fc33bmr23604543a91.12.1752969736028;
        Sat, 19 Jul 2025 17:02:16 -0700 (PDT)
Received: from localhost (111-252-5-201.dynamic-ip.hinet.net. [111.252.5.201])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31cc3f2e1fesm3575853a91.31.2025.07.19.17.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 17:02:15 -0700 (PDT)
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
Subject: [PATCH 7/9] drm/panthor: capture VMA state for devcoredump
Date: Sat, 19 Jul 2025 17:01:44 -0700
Message-ID: <20250720000146.1405060-8-olvaffe@gmail.com>
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

Capture interesting panthor_vma fields for devcoredump.

Because bo->label can change at anytime, we cap it to 32 chars to
simplify size estimation.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_coredump.c | 78 ++++++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_coredump.h | 15 +++++
 drivers/gpu/drm/panthor/panthor_mmu.c      | 43 ++++++++++++
 drivers/gpu/drm/panthor/panthor_mmu.h      |  4 ++
 4 files changed, 135 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_coredump.c b/drivers/gpu/drm/panthor/panthor_coredump.c
index acc8ad4cc498..5502452a5baa 100644
--- a/drivers/gpu/drm/panthor/panthor_coredump.c
+++ b/drivers/gpu/drm/panthor/panthor_coredump.c
@@ -14,6 +14,7 @@
 #include "panthor_coredump.h"
 #include "panthor_device.h"
 #include "panthor_fw.h"
+#include "panthor_gem.h"
 #include "panthor_mmu.h"
 #include "panthor_regs.h"
 #include "panthor_sched.h"
@@ -28,6 +29,7 @@ enum panthor_coredump_mask {
 	PANTHOR_COREDUMP_CSG = BIT(3),
 	PANTHOR_COREDUMP_CS = BIT(4),
 	PANTHOR_COREDUMP_AS = BIT(5),
+	PANTHOR_COREDUMP_VMA = BIT(6),
 };
 
 /**
@@ -45,6 +47,9 @@ struct panthor_coredump {
 	/** @ptdev: Device. */
 	struct panthor_device *ptdev;
 
+	/** @gfp: Allocation flags for panthor_coredump_capture. */
+	gfp_t gfp;
+
 	/** @work: Bottom half of panthor_coredump_capture. */
 	struct work_struct work;
 
@@ -60,6 +65,8 @@ struct panthor_coredump {
 	struct panthor_coredump_csg_state csg;
 	struct panthor_coredump_cs_state cs[MAX_CS_PER_CSG];
 	struct panthor_coredump_as_state as;
+	struct panthor_coredump_vma_state *vma;
+	u32 vma_count;
 
 	/* @data: Serialized coredump data. */
 	void *data;
@@ -92,6 +99,38 @@ static const char *reason_str(enum panthor_coredump_reason reason)
 	}
 }
 
+static void print_vma(struct drm_printer *p,
+		      const struct panthor_coredump_vma_state *vma, u32 vma_id,
+		      size_t *max_dyn_size)
+{
+	struct panthor_gem_object *bo = vma->bo;
+
+	if (!vma_id)
+		drm_puts(p, "vma:\n");
+
+	drm_printf(p, "  - flags: 0x%x\n", vma->flags);
+	drm_printf(p, "    iova: 0x%llx\n", vma->iova);
+	drm_printf(p, "    size: 0x%llx\n", vma->size);
+
+	if (!bo)
+		return;
+
+	/* bo->label is dynamic */
+	if (max_dyn_size) {
+		drm_puts(p, "    label: |\n");
+		drm_puts(p, "      \n");
+		*max_dyn_size += 32;
+	} else {
+		scoped_guard(mutex, &bo->label.lock)
+		{
+			if (bo->label.str) {
+				drm_puts(p, "    label: |\n");
+				drm_printf(p, "      %.32s\n", bo->label.str);
+			}
+		}
+	}
+}
+
 static void print_as(struct drm_printer *p,
 		     const struct panthor_coredump_as_state *as, u32 as_id)
 {
@@ -247,7 +286,8 @@ static void print_header(struct drm_printer *p,
 	drm_printf(p, "  timestamp: %lld\n", ktime_to_ns(header->timestamp));
 }
 
-static void print_cd(struct drm_printer *p, const struct panthor_coredump *cd)
+static void print_cd(struct drm_printer *p, const struct panthor_coredump *cd,
+		     size_t *max_dyn_size)
 {
 	/* in YAML format */
 	drm_puts(p, "---\n");
@@ -277,6 +317,11 @@ static void print_cd(struct drm_printer *p, const struct panthor_coredump *cd)
 
 		print_as(p, &cd->as, as_id);
 	}
+
+	if (cd->mask & PANTHOR_COREDUMP_VMA) {
+		for (u32 i = 0; i < cd->vma_count; i++)
+			print_vma(p, &cd->vma[i], i, max_dyn_size);
+	}
 }
 
 static void process_cd(struct panthor_device *ptdev,
@@ -286,10 +331,13 @@ static void process_cd(struct panthor_device *ptdev,
 		.remain = SSIZE_MAX,
 	};
 	struct drm_printer p = drm_coredump_printer(&iter);
+	size_t max_dyn_size = 0;
 
-	print_cd(&p, cd);
+	print_cd(&p, cd, &max_dyn_size);
+	if (max_dyn_size > iter.remain)
+		return;
 
-	iter.remain = SSIZE_MAX - iter.remain;
+	iter.remain = SSIZE_MAX - iter.remain + max_dyn_size;
 	iter.data = kvmalloc(iter.remain, GFP_USER);
 	if (!iter.data)
 		return;
@@ -297,10 +345,25 @@ static void process_cd(struct panthor_device *ptdev,
 	cd->data = iter.data;
 	cd->size = iter.remain;
 
-	drm_info(&ptdev->base, "generating coredump of size %zu\n", cd->size);
+	drm_info(&ptdev->base, "generating coredump of estimated size %zu\n",
+		 cd->size);
 
 	p = drm_coredump_printer(&iter);
-	print_cd(&p, cd);
+	print_cd(&p, cd, NULL);
+
+	cd->size -= iter.remain;
+
+	/* free vma now */
+	if (cd->mask & PANTHOR_COREDUMP_VMA) {
+		for (u32 i = 0; i < cd->vma_count; i++) {
+			struct panthor_coredump_vma_state *vma = &cd->vma[i];
+
+			drm_gem_object_put(&vma->bo->base.base);
+		}
+		kfree(cd->vma);
+
+		cd->mask &= ~PANTHOR_COREDUMP_VMA;
+	}
 }
 
 static void capture_as(struct panthor_device *ptdev,
@@ -434,6 +497,10 @@ static void capture_cd(struct panthor_device *ptdev,
 
 	capture_as(ptdev, &cd->as, panthor_vm_as(vm));
 	cd->mask |= PANTHOR_COREDUMP_AS;
+
+	cd->vma = panthor_vm_capture_coredump(vm, &cd->vma_count, cd->gfp);
+	if (cd->vma_count)
+		cd->mask |= PANTHOR_COREDUMP_VMA;
 }
 
 static void panthor_coredump_free(void *data)
@@ -504,6 +571,7 @@ panthor_coredump_alloc(struct panthor_device *ptdev,
 	}
 
 	cd->ptdev = ptdev;
+	cd->gfp = gfp;
 	INIT_WORK(&cd->work, panthor_coredump_process_work);
 
 	cd->header.reason = reason;
diff --git a/drivers/gpu/drm/panthor/panthor_coredump.h b/drivers/gpu/drm/panthor/panthor_coredump.h
index 8aceb0c7d0d4..8a89c39cf2f5 100644
--- a/drivers/gpu/drm/panthor/panthor_coredump.h
+++ b/drivers/gpu/drm/panthor/panthor_coredump.h
@@ -10,6 +10,7 @@
 
 struct panthor_coredump;
 struct panthor_device;
+struct panthor_gem_object;
 struct panthor_group;
 
 /**
@@ -135,6 +136,20 @@ struct panthor_coredump_as_state {
 	u64 faultextra;
 };
 
+/**
+ * struct panthor_coredump_vma_state - Coredump VMA state
+ *
+ * Interesting panthor_vma fields.
+ */
+struct panthor_coredump_vma_state {
+	u32 flags;
+	u64 iova;
+	u64 size;
+
+	struct panthor_gem_object *bo;
+	u64 bo_offset;
+};
+
 #ifdef CONFIG_DEV_COREDUMP
 
 struct panthor_coredump *
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index b39ea6acc6a9..a857a0dd1099 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -27,6 +27,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/sizes.h>
 
+#include "panthor_coredump.h"
 #include "panthor_device.h"
 #include "panthor_gem.h"
 #include "panthor_heap.h"
@@ -2694,6 +2695,48 @@ int panthor_vm_prepare_mapped_bos_resvs(struct drm_exec *exec, struct panthor_vm
 	return drm_gpuvm_prepare_objects(&vm->base, exec, slot_count);
 }
 
+struct panthor_coredump_vma_state *
+panthor_vm_capture_coredump(struct panthor_vm *vm, u32 *vma_count, gfp_t gfp)
+{
+	struct drm_gpuva *gpuva;
+	u32 count;
+
+	guard(mutex)(&vm->op_lock);
+
+	count = 0;
+	drm_gpuvm_for_each_va(gpuva, &vm->base)
+		count++;
+
+	struct panthor_coredump_vma_state *states =
+		kcalloc(count, sizeof(*states), gfp);
+	if (!states) {
+		*vma_count = 0;
+		return NULL;
+	}
+
+	count = 0;
+	drm_gpuvm_for_each_va(gpuva, &vm->base) {
+		const struct panthor_vma *vma =
+			container_of(gpuva, struct panthor_vma, base);
+		struct panthor_coredump_vma_state *state = &states[count];
+
+		state->flags = vma->flags;
+		state->iova = vma->base.va.addr;
+		state->size = vma->base.va.range;
+		if (vma->base.gem.obj) {
+			state->bo = to_panthor_bo(vma->base.gem.obj);
+			state->bo_offset = vma->base.gem.offset;
+			drm_gem_object_get(&state->bo->base.base);
+		}
+
+		count++;
+	}
+
+	*vma_count = count;
+
+	return states;
+}
+
 /**
  * panthor_mmu_unplug() - Unplug the MMU logic
  * @ptdev: Device.
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
index fc274637114e..c775b92d0502 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu.h
@@ -10,6 +10,7 @@
 struct drm_exec;
 struct drm_sched_job;
 struct drm_memory_stats;
+struct panthor_coredump_vma_state;
 struct panthor_gem_object;
 struct panthor_heap_pool;
 struct panthor_vm;
@@ -97,6 +98,9 @@ void panthor_vm_update_resvs(struct panthor_vm *vm, struct drm_exec *exec,
 			     enum dma_resv_usage private_usage,
 			     enum dma_resv_usage extobj_usage);
 
+struct panthor_coredump_vma_state *
+panthor_vm_capture_coredump(struct panthor_vm *vm, u32 *vma_count, gfp_t gfp);
+
 int panthor_mmu_pt_cache_init(void);
 void panthor_mmu_pt_cache_fini(void);
 
-- 
2.50.0.727.gbf7dc18ff4-goog


