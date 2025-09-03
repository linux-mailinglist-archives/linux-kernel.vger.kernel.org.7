Return-Path: <linux-kernel+bounces-799519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3DAB42D15
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B87B3B89D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC4A2FC003;
	Wed,  3 Sep 2025 22:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rn+o8JU6"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F312EF65E;
	Wed,  3 Sep 2025 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756940113; cv=none; b=fTgylLd95ac5MDpT+kPMUb8WC+p4OhM7DI1ksmgsnTdsG5aubP8WkayeUQW6W4hsuLCgkn0hjheoBCShfyqjUuf5PKiYf8s+Sn/z0ULswwPTy6VYRvw0x6SwJc34KaVoX4/MXKHOmeNHLVObaDQhDOGC+NhSjNSBMDzvysaRa68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756940113; c=relaxed/simple;
	bh=bHjlElqh2sITnXIGt/WRLyRptUY/BYwndzGM+ghLrfA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tU1Suiyi4432U/an+5nkHQSOtmPIBijyiYO0UMBnKVpA/vblSx56+ciDT8vtZWiw7Rbc0zlSA1QBYefkh6UxuiGAohSakk8V3N3ZhQMYXiFg621J5Kk40Wm61pFeZo3T+b+40Y+MXHNYb5EaCzd9yzSDlnWgRGiIqma+zZY8lqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rn+o8JU6; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-772488c78bcso441464b3a.1;
        Wed, 03 Sep 2025 15:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756940111; x=1757544911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DrlQU7DJzhqfes9DRlgKy/K0KdWM3hZbJrlRWvaOQOk=;
        b=Rn+o8JU6FevaMPTx/4SZdpmoxxVb+lLsG9QHlGVk+qZkAQ6lUDgETotA42V3F8T3dJ
         RBxJnNPd7kVeo8QWTN51bcU664VVGcJQbi2s0cU5LpTJ/Gq7OmqAlP8lY2FK42AElHHe
         R7/Ql147i5wPdNgFCcVVODHDVGGMpmvo1xlNytyu46/Bwfv7pHJZQDQExQQE2CND0sow
         emEvxp3F1LSKIa4JURUBU8MCR69iCSbyNABbtjM9cdmj6vzukH/rlw+4F6M8WCGRKCsc
         aw/mJGB4uZncqdXXkupgm2YAE8YoLKL/OJPPoLYZ6f0q3FffKHa1fe4XoSshZKBbk6CV
         OfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756940111; x=1757544911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrlQU7DJzhqfes9DRlgKy/K0KdWM3hZbJrlRWvaOQOk=;
        b=YkeSCuNfwi+mbGu+x/IYt2wwrEEXBE1o3DWiwttbNFyZg1/TRPJUy4grgvtqJ3QnDC
         z9CFq4HGBPPnYWnsOAL7CzKWuPRFlx+ldAJLUB39n5PJ5bHMpOfqbP+9eJETqb7LQlbN
         YTbIWNMQiah+A7wLFTJ2PMDPodb0japvLwZE0zlCo75AlTBUCvxC6Df8wx2RMUd1MR0V
         ncmbnfRUNNl8IUlaWRCoiguDXQ3NNxl3k7vwSHaqP60aMuerhAZkOzaO7C3xeC7ODbnK
         siY3Mk9pigT+gJD4mZkaz2zl9QpFZE9BMCoTFNi2SJtydgLgLChcp42yzm/dR5XJ2AP0
         n9VA==
X-Forwarded-Encrypted: i=1; AJvYcCV40M55sKgPnGkxJMKtvkfVgcRMcs6r+kyelnNprt4sAWAfQ39JY1g8+xbfApeFf2ruA24i3IaeEBDKRS2B@vger.kernel.org, AJvYcCWx0Ab4NLhJfdweKhFagYKk6FAcgWgUIk1JNtVNj2IWtv8ZC/83RyuiVdoWyMCvoGhoJUg2i5nUel24@vger.kernel.org
X-Gm-Message-State: AOJu0YxM8SVg1codilXtsCwRzUXjkxfrWQmO3qlioFGpu+0u/6uXh98R
	QNkeadQdZroYydUtSwe1bLeJHXgSETXr3sAYd3uKaWR2qzP+HYHF0L2m
X-Gm-Gg: ASbGncukLztXxprtBQMiv/pd4HKbWwd9Y93lK70dCBfJbAXDT0HectFijPUOPF2VXvN
	EfkqncOn8p2zjXVLa/9CyxCsEe/+BpQ4uqjdXWuXUgSPehSDqVJjboMha+z+EkAcqdnRiLMQvid
	GfzrbHFT+IixEmiGvQdv9gjfCpLK/vuGfwMMMpubHXG17jO08n1UZDKHkBB/CExWz971n4s3vck
	RPhj7WinFJ+3cmRSD/K3qtjlgUI5ole7DNjWZAsgn8BogIu04UEt1pYFqKnxBYtQgXeIq9HiAH5
	2bNAmbZ3oTI3Zj7J+44gFSSO5GI3aSOK5fqx/0a4bt9Lxkfm2orI+QphbEuXMD7D4lB7QY5HDPq
	K4HN6Qk8V+EI/ObloL8ajLie29eIG5YELviJjk1VF5U2TkN8JSIjpghJ/0g1ejCnCq5y9cPu1HN
	yo3r8WroaiLQ==
X-Google-Smtp-Source: AGHT+IFlDq2Qsn6j7X4Ynu7LubxbAsFYhg6GM5TR++pB6soDJoI0HSplg1yL36/BooPWOdImex7hkA==
X-Received: by 2002:a05:6a20:3c8f:b0:249:d3d:a4d4 with SMTP id adf61e73a8af0-2490d3db2e4mr4287081637.26.1756940110633;
        Wed, 03 Sep 2025 15:55:10 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b4fb15f50d6sm2243371a12.0.2025.09.03.15.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 15:55:10 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [RFC PATCH 2/2] drm/panthor: add initial mt8196 support
Date: Wed,  3 Sep 2025 15:55:04 -0700
Message-ID: <20250903225504.542268-3-olvaffe@gmail.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
In-Reply-To: <20250903225504.542268-1-olvaffe@gmail.com>
References: <20250903225504.542268-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add panthor_soc_data to control custom ASN_HASH. Add compatible string
for "mediatek,mt8196-mali" and enable custom ASN_HASH for the soc.

Without custom ASN_HASH, FW fails to boot

  panthor 48000000.gpu: [drm] *ERROR* Unhandled Page fault in AS0 at VA 0x0000000000000000
  panthor 48000000.gpu: [drm] *ERROR* Failed to boot MCU (status=fatal)
  panthor 48000000.gpu: probe with driver panthor failed with error -110

With custom ASN_HASH, panthor probes fine and userspace boots to ui just
fine as well

  panthor 48000000.gpu: [drm] clock rate = 0
  panthor 48000000.gpu: EM: created perf domain
  panthor 48000000.gpu: [drm] Mali-G925-Immortalis id 0xd830 major 0x0 minor 0x1 status 0x5
  panthor 48000000.gpu: [drm] Features: L2:0x8130306 Tiler:0x809 Mem:0x301 MMU:0x2830 AS:0xff
  panthor 48000000.gpu: [drm] shader_present=0xee0077 l2_present=0x1 tiler_present=0x1
  panthor 48000000.gpu: [drm] Firmware protected mode entry not be supported, ignoring
  panthor 48000000.gpu: [drm] Firmware git sha: 27713280172c742d467a4b7d11180930094092ec
  panthor 48000000.gpu: [drm] CSF FW using interface v3.13.0, Features 0x10 Instrumentation features 0x71
  [drm] Initialized panthor 1.5.0 for 48000000.gpu on minor 1

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/Kconfig              |  6 +++++
 drivers/gpu/drm/panthor/Makefile             |  2 ++
 drivers/gpu/drm/panthor/panthor_device.c     |  2 ++
 drivers/gpu/drm/panthor/panthor_device.h     |  4 +++
 drivers/gpu/drm/panthor/panthor_drv.c        |  4 +++
 drivers/gpu/drm/panthor/panthor_gpu.c        | 26 +++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_regs.h       |  4 +++
 drivers/gpu/drm/panthor/panthor_soc.h        | 26 ++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_soc_mt8196.c |  9 +++++++
 9 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_soc.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_soc_mt8196.c

diff --git a/drivers/gpu/drm/panthor/Kconfig b/drivers/gpu/drm/panthor/Kconfig
index 55b40ad07f3b0..a207962cb518d 100644
--- a/drivers/gpu/drm/panthor/Kconfig
+++ b/drivers/gpu/drm/panthor/Kconfig
@@ -21,3 +21,9 @@ config DRM_PANTHOR
 
 	  Note that the Mali-G68 and Mali-G78, while Valhall architecture, will
 	  be supported with the panfrost driver as they are not CSF GPUs.
+
+config DRM_PANTHOR_SOC_MT8196
+	bool "Enable MediaTek MT8196 support"
+	depends on DRM_PANTHOR
+	help
+	  Enable SoC-specific code for MediaTek MT8196.
diff --git a/drivers/gpu/drm/panthor/Makefile b/drivers/gpu/drm/panthor/Makefile
index 02db21748c125..75e92c461304b 100644
--- a/drivers/gpu/drm/panthor/Makefile
+++ b/drivers/gpu/drm/panthor/Makefile
@@ -12,4 +12,6 @@ panthor-y := \
 	panthor_mmu.o \
 	panthor_sched.o
 
+panthor-$(CONFIG_DRM_PANTHOR_SOC_MT8196) += panthor_soc_mt8196.o
+
 obj-$(CONFIG_DRM_PANTHOR) += panthor.o
diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 81df49880bd87..c7033d82cef55 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -172,6 +172,8 @@ int panthor_device_init(struct panthor_device *ptdev)
 	struct page *p;
 	int ret;
 
+	ptdev->soc_data = of_device_get_match_data(ptdev->base.dev);
+
 	init_completion(&ptdev->unplug.done);
 	ret = drmm_mutex_init(&ptdev->base, &ptdev->unplug.lock);
 	if (ret)
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 4fc7cf2aeed57..160977834e017 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -28,6 +28,7 @@ struct panthor_job;
 struct panthor_mmu;
 struct panthor_fw;
 struct panthor_perfcnt;
+struct panthor_soc_data;
 struct panthor_vm;
 struct panthor_vm_pool;
 
@@ -93,6 +94,9 @@ struct panthor_device {
 	/** @base: Base drm_device. */
 	struct drm_device base;
 
+	/** @soc_data: Optional SoC data. */
+	const struct panthor_soc_data *soc_data;
+
 	/** @phys_addr: Physical address of the iomem region. */
 	phys_addr_t phys_addr;
 
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 9256806eb6623..061ba38dd1bad 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -33,6 +33,7 @@
 #include "panthor_mmu.h"
 #include "panthor_regs.h"
 #include "panthor_sched.h"
+#include "panthor_soc.h"
 
 /**
  * DOC: user <-> kernel object copy helpers.
@@ -1683,6 +1684,9 @@ static struct attribute *panthor_attrs[] = {
 ATTRIBUTE_GROUPS(panthor);
 
 static const struct of_device_id dt_match[] = {
+#ifdef CONFIG_DRM_PANTHOR_SOC_MT8196
+	{ .compatible = "mediatek,mt8196-mali", .data = &panthor_soc_data_mediatek_mt8196, },
+#endif
 	{ .compatible = "rockchip,rk3588-mali" },
 	{ .compatible = "arm,mali-valhall-csf" },
 	{}
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index db69449a5be09..e68001a330790 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -19,6 +19,7 @@
 #include "panthor_device.h"
 #include "panthor_gpu.h"
 #include "panthor_regs.h"
+#include "panthor_soc.h"
 
 /**
  * struct panthor_gpu - GPU block management data.
@@ -52,6 +53,28 @@ static void panthor_gpu_coherency_set(struct panthor_device *ptdev)
 		ptdev->coherent ? GPU_COHERENCY_PROT_BIT(ACE_LITE) : GPU_COHERENCY_NONE);
 }
 
+static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
+{
+	const struct panthor_soc_data *data = ptdev->soc_data;
+	u32 l2_config;
+	u32 i;
+
+	if (!data || !data->asn_hash_enable)
+		return;
+
+	if (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) < 11) {
+		drm_err(&ptdev->base, "Custom ASN hash not supported by the device");
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(data->asn_hash); i++)
+		gpu_write(ptdev, GPU_ASN_HASH(i), data->asn_hash[i]);
+
+	l2_config = gpu_read(ptdev, GPU_L2_CONFIG);
+	l2_config |= GPU_L2_CONFIG_ASN_HASH_ENABLE;
+	gpu_write(ptdev, GPU_L2_CONFIG, l2_config);
+}
+
 static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
 {
 	gpu_write(ptdev, GPU_INT_CLEAR, status);
@@ -241,8 +264,9 @@ int panthor_gpu_l2_power_on(struct panthor_device *ptdev)
 			      hweight64(ptdev->gpu_info.shader_present));
 	}
 
-	/* Set the desired coherency mode before the power up of L2 */
+	/* Set the desired coherency mode and L2 config before the power up of L2 */
 	panthor_gpu_coherency_set(ptdev);
+	panthor_gpu_l2_config_set(ptdev);
 
 	return panthor_gpu_power_on(ptdev, L2, 1, 20000);
 }
diff --git a/drivers/gpu/drm/panthor/panthor_regs.h b/drivers/gpu/drm/panthor/panthor_regs.h
index 8bee76d01bf83..8fa69f33e911e 100644
--- a/drivers/gpu/drm/panthor/panthor_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_regs.h
@@ -64,6 +64,8 @@
 
 #define GPU_FAULT_STATUS				0x3C
 #define GPU_FAULT_ADDR					0x40
+#define GPU_L2_CONFIG					0x48
+#define   GPU_L2_CONFIG_ASN_HASH_ENABLE			BIT(24)
 
 #define GPU_PWR_KEY					0x50
 #define  GPU_PWR_KEY_UNLOCK				0x2968A819
@@ -110,6 +112,8 @@
 
 #define GPU_REVID					0x280
 
+#define GPU_ASN_HASH(n)					(0x2C0 + ((n) * 4))
+
 #define GPU_COHERENCY_FEATURES				0x300
 #define GPU_COHERENCY_PROT_BIT(name)			BIT(GPU_COHERENCY_  ## name)
 
diff --git a/drivers/gpu/drm/panthor/panthor_soc.h b/drivers/gpu/drm/panthor/panthor_soc.h
new file mode 100644
index 0000000000000..784f4f359f0bb
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_soc.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2025 Google LLC */
+
+#ifndef __PANTHOR_SOC_H__
+#define __PANTHOR_SOC_H__
+
+#include <linux/types.h>
+
+struct panthor_device;
+
+/**
+ * struct panthor_soc_data - Panthor SoC Data
+ */
+struct panthor_soc_data {
+	/** @asn_hash_enable: True if GPU_L2_CONFIG_ASN_HASH_ENABLE must be set. */
+	bool asn_hash_enable;
+
+	/** @asn_hash: ASN_HASH values when asn_hash_enable is true. */
+	u32 asn_hash[3];
+};
+
+#ifdef CONFIG_DRM_PANTHOR_SOC_MT8196
+extern const struct panthor_soc_data panthor_soc_data_mediatek_mt8196;
+#endif
+
+#endif /* __PANTHOR_SOC_H__ */
diff --git a/drivers/gpu/drm/panthor/panthor_soc_mt8196.c b/drivers/gpu/drm/panthor/panthor_soc_mt8196.c
new file mode 100644
index 0000000000000..d85b2168c158c
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_soc_mt8196.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2025 Google LLC */
+
+#include "panthor_soc.h"
+
+const struct panthor_soc_data panthor_soc_data_mediatek_mt8196 = {
+	.asn_hash_enable = true,
+	.asn_hash = { 0xb, 0xe, 0x0, },
+};
-- 
2.51.0.338.gd7d06c2dae-goog


