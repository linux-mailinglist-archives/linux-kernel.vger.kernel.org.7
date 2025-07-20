Return-Path: <linux-kernel+bounces-737982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 703D3B0B2DE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 02:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3E53BE2B6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56430376;
	Sun, 20 Jul 2025 00:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThrpivbG"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BBF173
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 00:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752969728; cv=none; b=fWdKA1dfLKhcmHzW8EVhjCsIPJG1kk0f3Ptrjv2ysEUVjN+hrHsCnX8ggsBgfP3umzSKFoWKwfVYJ11tcPVKQp6ZiJqgw52Mk5hF6OG9x//4zGvKaZgDIGrhaOySOm7s9442t+MeWqRC189nJdOsR9rnuerMlsTZZPmHJYPNtoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752969728; c=relaxed/simple;
	bh=8yJUJ2DDyiQAgECxiARFB6PAas4OoaWYicZbQbx+bbU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COKIQ6vwKbwrkHHoh1J2nK1t0ojNEe8JOurBpS88QQiuvFZjrZstPANJu7cf24bxCk2V4Q+2OatippMOHl8dJ9vIfwqabAeoRds8/7/WAF/xtp4z0YzyjBTdZKk5m4SFPCjqIGefaOKLQ/0xCOfb2dJRBrmIhk6M6g/8HWU/ZeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThrpivbG; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b3226307787so2474536a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752969726; x=1753574526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kw76Jz9i353hbrop8cGWiVe9vi282Q4+/utlvXSv3b8=;
        b=ThrpivbGydbri7RWmkBc2nxNjlKvuvwXZgT1wB2oXbbrUFt+P/hWntmjHnz6CS8SiA
         HBf4EKgXSWgejhilQh8SHAte6NkfUTtEMr26ZKZx3wgBGIvJzoRXCX+vmlsuF1Ti+Xor
         p/P3eWdl/2cskYIe4Dbsl9H79pSOaVvK7YXyguo2Q/pdC/01WUeWaZfI6N9tsKsiyyel
         x1ns/friyUQbQUw9Z5bGNsPXmAUC6IcEa+3R4DPn393VSEddixGmbZiBgsL/bTnrITw2
         n+jb4s243cbaEKxMG3/2GXPsY2kiMlHUVxeM5hmIiVpR2geuFIgNQxN4sIJfIypOQ5bT
         GDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752969726; x=1753574526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kw76Jz9i353hbrop8cGWiVe9vi282Q4+/utlvXSv3b8=;
        b=mE+lTwQM0Q7cBhajBsg3lPPjZ/QxfLAEdYGMocBAblBNx1hT3Hv5Tx4X0wZZgQdTHl
         uPAJoolEk+p7zqREcRHMSHSQ+fOkGpaDUhn0vyp/Vckihvcw3P8rCas474QIxyEk/8Zx
         sjj2FbTqX9Nsn1Kprw+6vRlv4KW3zrfx9ZfJOpV5czBxohFgkdr/8QUxQBg85dDs1iUC
         I42I5PEQaG+0kt7+tMkbODhve9b/ATDYlvPKfQ29rsy+7Osn9QGLTVgduUDorN3nebv2
         rS8IhQazDxDCx0J+baCZPOHpohQUyXOvhksvmIIAj127zMLga9VmChZZ12nmYGj2+yIo
         oqqg==
X-Forwarded-Encrypted: i=1; AJvYcCXuSJCttOLiIjXqbHUe6iKczuftQwbYQXz+thltpEFitvZCH01Yf1PpHolu1LzSGNyfJt58fpt0UDMjsP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySBRWzQ8URhGbhfRedidTC5CK0/apDvdn7n90IPJwBfLLxRMok
	6RBneUPvz6bLsqenjP8gc6iLBWSPXTeCBft4hmFtCo2sJ9W2iK2/hbXU
X-Gm-Gg: ASbGncsSpryjtNBsLRyvJ7a1uHGc05nMTkRiYb0LvW2X0LT69dw4Zab02NToTMh3lzN
	NmfsUhyJ/NFb/LqFhzmwHc5JNe1o+2/GPQ+dnFqEMXy29fTO9ok9GTCmK7z9z6+EofXsQv3P3Qq
	sZ0zF3Xjurc+CNf5IlzppwhVARPx2wMV5dA6ZdOS6YfQv0MPHVlY8bU76zkwFYJOrt+Jmzh/PWW
	K1TNyHxJIpCyQL5n1kO8O+Pr2PvIYkXHy1+UPmK3SySdzThGJhoHCgqPxd3mMl8JDJpczjQCxmj
	m2qiBc+ndn7sQRRfpIExSxMsiJNE0oHNe5yb7voq87WZ7eiEsXDzCWQ3k0kl3unfNyQ0Ln4D3TA
	kw4v6+D+NGR0mr2N9OQJun/Q5Nhnug8mKLUUgiEIiPefsJz2YTbWd
X-Google-Smtp-Source: AGHT+IGlu7vwH4vb6IK8SrRyjdHZdH5dvylEyVKd3I8vsGLrRQ7fxBW5rkDN3rKRn6mncsVcnVib+Q==
X-Received: by 2002:a17:903:166e:b0:234:c5c1:9b63 with SMTP id d9443c01a7336-23e256b73f3mr172523095ad.18.1752969725966;
        Sat, 19 Jul 2025 17:02:05 -0700 (PDT)
Received: from localhost (111-252-5-201.dynamic-ip.hinet.net. [111.252.5.201])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23e3b5e2e3bsm34010605ad.31.2025.07.19.17.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 17:02:05 -0700 (PDT)
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
Subject: [PATCH 2/9] drm/panthor: capture GPU state for devcoredump
Date: Sat, 19 Jul 2025 17:01:39 -0700
Message-ID: <20250720000146.1405060-3-olvaffe@gmail.com>
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

Capture interesting GPU_CONTROL regs for devcoredump.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_coredump.c | 85 ++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_coredump.h | 16 ++++
 drivers/gpu/drm/panthor/panthor_regs.h     |  6 ++
 drivers/gpu/drm/panthor/panthor_sched.c    |  6 ++
 4 files changed, 113 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_coredump.c b/drivers/gpu/drm/panthor/panthor_coredump.c
index 767f3327e3e8..a41d0bbcb4f1 100644
--- a/drivers/gpu/drm/panthor/panthor_coredump.c
+++ b/drivers/gpu/drm/panthor/panthor_coredump.c
@@ -7,11 +7,13 @@
 #include <generated/utsrelease.h>
 #include <linux/devcoredump.h>
 #include <linux/err.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/timekeeping.h>
 
 #include "panthor_coredump.h"
 #include "panthor_device.h"
+#include "panthor_regs.h"
 #include "panthor_sched.h"
 
 /**
@@ -19,6 +21,7 @@
  */
 enum panthor_coredump_mask {
 	PANTHOR_COREDUMP_GROUP = BIT(0),
+	PANTHOR_COREDUMP_GPU = BIT(1),
 };
 
 /**
@@ -46,6 +49,7 @@ struct panthor_coredump {
 	u32 mask;
 
 	struct panthor_coredump_group_state group;
+	struct panthor_coredump_gpu_state gpu;
 
 	/* @data: Serialized coredump data. */
 	void *data;
@@ -78,6 +82,63 @@ static const char *reason_str(enum panthor_coredump_reason reason)
 	}
 }
 
+static void print_gpu(struct drm_printer *p,
+		      const struct panthor_coredump_gpu_state *gpu,
+		      const struct drm_panthor_gpu_info *info)
+{
+	drm_puts(p, "gpu:\n");
+	drm_printf(p, "  GPU_ID: 0x%x\n", info->gpu_id);
+	drm_printf(p, "  L2_FEATURES: 0x%x\n", info->l2_features);
+	drm_printf(p, "  CORE_FEATURES: 0x%x\n", info->core_features);
+	drm_printf(p, "  TILER_FEATURES: 0x%x\n", info->tiler_features);
+	drm_printf(p, "  MEM_FEATURES: 0x%x\n", info->mem_features);
+	drm_printf(p, "  MMU_FEATURES: 0x%x\n", info->mmu_features);
+	drm_printf(p, "  AS_PRESENT: 0x%x\n", info->as_present);
+	drm_printf(p, "  CSF_ID: 0x%x\n", info->csf_id);
+	drm_printf(p, "  MMU_FEATURES: 0x%x\n", info->mmu_features);
+
+	if (gpu) {
+		drm_printf(p, "  GPU_STATUS: 0x%x\n", gpu->gpu_status);
+		drm_printf(p, "  GPU_FAULTSTATUS: 0x%x\n",
+			   gpu->gpu_faultstatus);
+		drm_printf(p, "  GPU_FAULTADDRESS: 0x%llx\n",
+			   gpu->gpu_faultaddress);
+		drm_printf(p, "  L2_CONFIG: 0x%x\n", gpu->l2_config);
+	}
+
+	drm_printf(p, "  THREAD_MAX_THREADS: 0x%x\n", info->max_threads);
+	drm_printf(p, "  THREAD_MAX_WORKGROUP_SIZE: 0x%x\n",
+		   info->thread_max_workgroup_size);
+	drm_printf(p, "  THREAD_MAX_BARRIER_SIZE: 0x%x\n",
+		   info->thread_max_barrier_size);
+	drm_printf(p, "  THREAD_FEATURES: 0x%x\n", info->thread_features);
+	drm_printf(p, "  TEXTURE_FEATURES_0: 0x%x\n",
+		   info->texture_features[0]);
+	drm_printf(p, "  TEXTURE_FEATURES_1: 0x%x\n",
+		   info->texture_features[1]);
+	drm_printf(p, "  TEXTURE_FEATURES_2: 0x%x\n",
+		   info->texture_features[2]);
+	drm_printf(p, "  TEXTURE_FEATURES_3: 0x%x\n",
+		   info->texture_features[3]);
+
+	if (gpu) {
+		drm_printf(p, "  DOORBELL_FEATURES: 0x%x\n",
+			   gpu->doorbell_features);
+	}
+
+	drm_printf(p, "  SHADER_PRESENT: 0x%llx\n", info->shader_present);
+	drm_printf(p, "  TILER_PRESENT: 0x%llx\n", info->tiler_present);
+	drm_printf(p, "  L2_PRESENT: 0x%llx\n", info->l2_present);
+	drm_printf(p, "  REVIDR: 0x%x\n", info->gpu_rev);
+	drm_printf(p, "  AMBA_FEATURES: 0x%x\n", info->coherency_features);
+
+	if (gpu) {
+		drm_printf(p, "  AMBA_ENABLE: 0x%x\n", gpu->amba_enable);
+		drm_printf(p, "  MCU_STATUS: 0x%x\n", gpu->mcu_status);
+		drm_printf(p, "  MCU_FEATURES: 0x%x\n", gpu->mcu_features);
+	}
+}
+
 static void print_group(struct drm_printer *p,
 			const struct panthor_coredump_group_state *group)
 {
@@ -111,6 +172,10 @@ static void print_cd(struct drm_printer *p, const struct panthor_coredump *cd)
 
 	if (cd->mask & PANTHOR_COREDUMP_GROUP)
 		print_group(p, &cd->group);
+
+	/* many gpu states are static and are captured in drm_panthor_gpu_info */
+	print_gpu(p, cd->mask & PANTHOR_COREDUMP_GPU ? &cd->gpu : NULL,
+		  &cd->ptdev->gpu_info);
 }
 
 static void process_cd(struct panthor_device *ptdev,
@@ -137,6 +202,19 @@ static void process_cd(struct panthor_device *ptdev,
 	print_cd(&p, cd);
 }
 
+static void capture_gpu(struct panthor_device *ptdev,
+			struct panthor_coredump_gpu_state *gpu)
+{
+	gpu->gpu_status = gpu_read(ptdev, GPU_STATUS);
+	gpu->gpu_faultstatus = gpu_read(ptdev, GPU_FAULT_STATUS);
+	gpu->gpu_faultaddress = gpu_read64(ptdev, GPU_FAULT_ADDR);
+	gpu->l2_config = gpu_read(ptdev, GPU_L2_CONFIG);
+	gpu->doorbell_features = gpu_read(ptdev, GPU_DOORBELL_FEATURES);
+	gpu->amba_enable = gpu_read(ptdev, GPU_COHERENCY_PROTOCOL);
+	gpu->mcu_status = gpu_read(ptdev, MCU_STATUS);
+	gpu->mcu_features = gpu_read(ptdev, MCU_FEATURES);
+}
+
 static void capture_cd(struct panthor_device *ptdev,
 		       struct panthor_coredump *cd, struct panthor_group *group)
 {
@@ -146,6 +224,13 @@ static void capture_cd(struct panthor_device *ptdev,
 		panthor_group_capture_coredump(group, &cd->group);
 		cd->mask |= PANTHOR_COREDUMP_GROUP;
 	}
+
+	/* remaining states require the device to be powered on */
+	if (!pm_runtime_active(ptdev->base.dev))
+		return;
+
+	capture_gpu(ptdev, &cd->gpu);
+	cd->mask |= PANTHOR_COREDUMP_GPU;
 }
 
 static void panthor_coredump_free(void *data)
diff --git a/drivers/gpu/drm/panthor/panthor_coredump.h b/drivers/gpu/drm/panthor/panthor_coredump.h
index dd1fe1c2e175..9e30c02ab962 100644
--- a/drivers/gpu/drm/panthor/panthor_coredump.h
+++ b/drivers/gpu/drm/panthor/panthor_coredump.h
@@ -40,6 +40,22 @@ struct panthor_coredump_group_state {
 	int csg_id;
 };
 
+/**
+ * struct panthor_coredump_gpu_state - Coredump GPU state
+ *
+ * Interesting GPU_CONTROL regs.
+ */
+struct panthor_coredump_gpu_state {
+	u32 gpu_status;
+	u32 gpu_faultstatus;
+	u64 gpu_faultaddress;
+	u32 l2_config;
+	u32 doorbell_features;
+	u32 amba_enable;
+	u32 mcu_status;
+	u32 mcu_features;
+};
+
 #ifdef CONFIG_DEV_COREDUMP
 
 struct panthor_coredump *
diff --git a/drivers/gpu/drm/panthor/panthor_regs.h b/drivers/gpu/drm/panthor/panthor_regs.h
index 48bbfd40138c..062f939e075c 100644
--- a/drivers/gpu/drm/panthor/panthor_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_regs.h
@@ -65,6 +65,8 @@
 #define GPU_FAULT_STATUS				0x3C
 #define GPU_FAULT_ADDR					0x40
 
+#define GPU_L2_CONFIG					0x48
+
 #define GPU_PWR_KEY					0x50
 #define  GPU_PWR_KEY_UNLOCK				0x2968A819
 #define GPU_PWR_OVERRIDE0				0x54
@@ -81,6 +83,8 @@
 
 #define GPU_TEXTURE_FEATURES(n)				(0xB0 + ((n) * 4))
 
+#define GPU_DOORBELL_FEATURES				0xC0
+
 #define GPU_SHADER_PRESENT				0x100
 #define GPU_TILER_PRESENT				0x110
 #define GPU_L2_PRESENT					0x120
@@ -126,6 +130,8 @@
 #define MCU_STATUS_HALT					2
 #define MCU_STATUS_FATAL				3
 
+#define MCU_FEATURES					0x708
+
 /* Job Control regs */
 #define JOB_INT_RAWSTAT					0x1000
 #define JOB_INT_CLEAR					0x1004
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index eb45b5ad9774..a9fd71fa984b 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3670,6 +3670,7 @@ static void panthor_sched_coredump_locked(struct panthor_device *ptdev,
 					  struct panthor_group *group)
 {
 	struct panthor_coredump *cd;
+	int pm_active;
 
 	lockdep_assert_held(&ptdev->scheduler->lock);
 
@@ -3678,7 +3679,12 @@ static void panthor_sched_coredump_locked(struct panthor_device *ptdev,
 	if (!cd)
 		return;
 
+	pm_active = pm_runtime_get_if_active(ptdev->base.dev);
+
 	panthor_coredump_capture(cd, group);
+
+	if (pm_active == 1)
+		pm_runtime_put(ptdev->base.dev);
 }
 
 void panthor_group_capture_coredump(const struct panthor_group *group,
-- 
2.50.0.727.gbf7dc18ff4-goog


