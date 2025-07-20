Return-Path: <linux-kernel+bounces-737983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1B6B0B2DB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 02:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443E91AA0338
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B24C25761;
	Sun, 20 Jul 2025 00:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9V2oK1E"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D043112B73
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752969730; cv=none; b=gzrxQs+DPWOfRUj1jvn22wU4UVSFC1T0aNdIbKPcqY5d93V7hn4ZpXoYYzKfLrRO93hbb0P0isOPKKxZTBo6vD+HhJq48fgrFrNdeH7G14q5eqnd/uQeB/4bjzvE4+OpCXDso4A2qR1KcefbIa0XeVAV+dpLbui0gnkQ7hMIGdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752969730; c=relaxed/simple;
	bh=2/UP4Rkp4EWjlgeu7OzH5YrA8dxVfBIEjU7ZCeuNtZM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPk6+JLABS5jlE/R1b4uoXl9DXBKIkvPgKKy8oV6c+xQA4LPsQTF/Xv04hPn1BeRSdeeFqotR6vK+NGSxTNdYsvBhmQcLHt/vQ+4Eq8NF9Mw2k+k1B950BmoULfZGiiUGMLHfA1EUeZLHjLZWzYCygMDSKp4Tzjw6ztysptjQT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9V2oK1E; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-749068b9b63so2210545b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752969728; x=1753574528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZeYcpA6IdS13N6yNi+0iixf2PMyZBsbsEjnpcTFZhg=;
        b=e9V2oK1ERQ7U5AU0Eo9KKUUv6oNPlhpMka7wKihejlH8NIFSISm+FZqTzQqMhPVaU/
         X1JgNg1D3XnMTc6k9qfj/EDuGZkXn6w5tWzmZ51m8Proo9O5CaOaDj256IWBx2VJmlQV
         WMXciZ88VBoeKDjliSUCFHY8MQwb+rFUDOpYOAAnvW0jhzWJTQslZmmFqrzYtAmh76fn
         uyw/oGGRDO+6Ygs6AADrcTlAmom/Ze/RKRDFZRpdJoI/ozjG4Jq7fP1nzKXvV3PRuiJO
         EQAm14wU9PkL7734k83VPr9V/qduqwcar8fJ3y0Y+1cwn3sy0AufSDv3uVoZf8UM1GA4
         7Abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752969728; x=1753574528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZeYcpA6IdS13N6yNi+0iixf2PMyZBsbsEjnpcTFZhg=;
        b=oATt5/bzEpqED8HuFd4b2IOIuRMlh91kFPa/+13waz03U5R1asq1RZc6l1iQuskkBM
         ntXlERowxQCj+3HVGlOAAf13k7W5V3nDGY2sPGbO2P8gZegJZYvtdl9D+0TOZ1IKQ12M
         aq2j/2uibnGzbNdR1QeaCAKHuHXv+DCVH/ja4lizOYkHXPD9d2IyS8of4vffc0D4Y011
         +d8lq3w4zhinDUerluwlwlInAZFnnTPAkPdPn6CgLJWdXmKnXqQFlTKoC5wCdiTqg04s
         gzZKBsqUJ0x6MR13RtfOB0yco/Pnpr7MNzAI+MYrdG4HwgmGr873oPdnsXE/GjlFBKst
         7DOw==
X-Forwarded-Encrypted: i=1; AJvYcCWnIxnwTQHBza0ALK2XAwXSujngEVwldIPDA15kfrO+Qzt+7RUGnTm28QllGyhaWFsD1do1LZFECbpZfv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTe0EoP7t3I347b9rlg3X72WaqUbXvC3FbRYFdTYX1fBLYDX+T
	rrri1m9U4kwaqFv1WWDFIdky8ZYrKx/gQkTFj34AYJjd+N44CcjdLmp9
X-Gm-Gg: ASbGnct3bHNu3GfsqqKjZxhOmXrfKskCbBZf3oY/4M+xgHHhAsa96lOaQuVdspvjWrg
	yMQdsUlUl8RPc6gLtz2MufgF/pvFAe/QOI+Vu881Y9z/ESZQLBIhSlO1rlyBIjnMgA25vE9FQkX
	PlPNXYkRoFu/ilClkZu6WWk4qpLYE+ArCUn+7b24SIrNsDvT86mmsQopgKLIi8IUCu48LLXvChB
	rJ9pj3bZ4eYqE2xFZ+o1g46yDGVVEYaa3g9ii0VgPCzSLxabRl+rT2osRsUMgf6LvnjSH3qFvJ4
	bBInHRrupJxw9Xx0NGw67pOJPgG58VD0CRexAQFYi323qLOR7Jp5YY3xulbrerKBjaGwMlQoUqa
	CjXiw0AvbbPnxX8b6Y7bB2mdA72zA3avLWAOcIHOMIQZyKNc/vsT3
X-Google-Smtp-Source: AGHT+IE0yL2u0gWC2G8gFvnVzCy8pgRZN9a5E7q265PK7M+9WprYx0FEIcD+l9N/ZjvdqeMkM4NFCQ==
X-Received: by 2002:a05:6a00:1248:b0:748:f6a0:7731 with SMTP id d2e1a72fcca58-756ea6c7d8amr23238232b3a.23.1752969728038;
        Sat, 19 Jul 2025 17:02:08 -0700 (PDT)
Received: from localhost (111-252-5-201.dynamic-ip.hinet.net. [111.252.5.201])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-759c89d31c1sm3386221b3a.48.2025.07.19.17.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 17:02:07 -0700 (PDT)
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
Subject: [PATCH 3/9] drm/panthor: capture GLB state for devcoredump
Date: Sat, 19 Jul 2025 17:01:40 -0700
Message-ID: <20250720000146.1405060-4-olvaffe@gmail.com>
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

Capture interesting panthor_fw_global_iface fields for devcoredump.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_coredump.c | 33 ++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_coredump.h | 13 +++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_coredump.c b/drivers/gpu/drm/panthor/panthor_coredump.c
index a41d0bbcb4f1..44d711e2f310 100644
--- a/drivers/gpu/drm/panthor/panthor_coredump.c
+++ b/drivers/gpu/drm/panthor/panthor_coredump.c
@@ -13,6 +13,7 @@
 
 #include "panthor_coredump.h"
 #include "panthor_device.h"
+#include "panthor_fw.h"
 #include "panthor_regs.h"
 #include "panthor_sched.h"
 
@@ -22,6 +23,7 @@
 enum panthor_coredump_mask {
 	PANTHOR_COREDUMP_GROUP = BIT(0),
 	PANTHOR_COREDUMP_GPU = BIT(1),
+	PANTHOR_COREDUMP_GLB = BIT(2),
 };
 
 /**
@@ -50,6 +52,7 @@ struct panthor_coredump {
 
 	struct panthor_coredump_group_state group;
 	struct panthor_coredump_gpu_state gpu;
+	struct panthor_coredump_glb_state glb;
 
 	/* @data: Serialized coredump data. */
 	void *data;
@@ -82,6 +85,17 @@ static const char *reason_str(enum panthor_coredump_reason reason)
 	}
 }
 
+static void print_glb(struct drm_printer *p,
+		      const struct panthor_coredump_glb_state *glb)
+{
+	drm_puts(p, "glb:\n");
+	drm_printf(p, "  GLB_VERSION: 0x%x\n", glb->version);
+	drm_printf(p, "  GLB_FEATURES: 0x%x\n", glb->features);
+	drm_printf(p, "  GLB_GROUP_NUM: 0x%x\n", glb->group_num);
+	drm_printf(p, "  GLB_REQ: 0x%x\n", glb->req);
+	drm_printf(p, "  GLB_ACK: 0x%x\n", glb->ack);
+}
+
 static void print_gpu(struct drm_printer *p,
 		      const struct panthor_coredump_gpu_state *gpu,
 		      const struct drm_panthor_gpu_info *info)
@@ -176,6 +190,9 @@ static void print_cd(struct drm_printer *p, const struct panthor_coredump *cd)
 	/* many gpu states are static and are captured in drm_panthor_gpu_info */
 	print_gpu(p, cd->mask & PANTHOR_COREDUMP_GPU ? &cd->gpu : NULL,
 		  &cd->ptdev->gpu_info);
+
+	if (cd->mask & PANTHOR_COREDUMP_GLB)
+		print_glb(p, &cd->glb);
 }
 
 static void process_cd(struct panthor_device *ptdev,
@@ -202,6 +219,19 @@ static void process_cd(struct panthor_device *ptdev,
 	print_cd(&p, cd);
 }
 
+static void capture_glb(struct panthor_device *ptdev,
+			struct panthor_coredump_glb_state *glb)
+{
+	const struct panthor_fw_global_iface *glb_iface =
+		panthor_fw_get_glb_iface(ptdev);
+
+	glb->version = glb_iface->control->version;
+	glb->features = glb_iface->control->features;
+	glb->group_num = glb_iface->control->group_num;
+	glb->req = glb_iface->input->req;
+	glb->ack = glb_iface->output->ack;
+}
+
 static void capture_gpu(struct panthor_device *ptdev,
 			struct panthor_coredump_gpu_state *gpu)
 {
@@ -231,6 +261,9 @@ static void capture_cd(struct panthor_device *ptdev,
 
 	capture_gpu(ptdev, &cd->gpu);
 	cd->mask |= PANTHOR_COREDUMP_GPU;
+
+	capture_glb(ptdev, &cd->glb);
+	cd->mask |= PANTHOR_COREDUMP_GLB;
 }
 
 static void panthor_coredump_free(void *data)
diff --git a/drivers/gpu/drm/panthor/panthor_coredump.h b/drivers/gpu/drm/panthor/panthor_coredump.h
index 9e30c02ab962..e578298e9b57 100644
--- a/drivers/gpu/drm/panthor/panthor_coredump.h
+++ b/drivers/gpu/drm/panthor/panthor_coredump.h
@@ -56,6 +56,19 @@ struct panthor_coredump_gpu_state {
 	u32 mcu_features;
 };
 
+/**
+ * struct panthor_coredump_glb_state - Coredump GLB state
+ *
+ * Interesting panthor_fw_global_iface fields.
+ */
+struct panthor_coredump_glb_state {
+	u32 version;
+	u32 features;
+	u32 group_num;
+	u32 req;
+	u32 ack;
+};
+
 #ifdef CONFIG_DEV_COREDUMP
 
 struct panthor_coredump *
-- 
2.50.0.727.gbf7dc18ff4-goog


