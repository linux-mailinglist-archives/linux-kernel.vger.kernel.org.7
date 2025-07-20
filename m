Return-Path: <linux-kernel+bounces-737986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1268FB0B2E3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 02:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7283B32A3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2BB136348;
	Sun, 20 Jul 2025 00:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bcnj9pMr"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E116BFCE
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 00:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752969736; cv=none; b=hD2Buh+v3y3dC2o7+CcTREPlTebDMi6TCNNM8pa4wojRD29ztt36qyfJOo441EGeCzrvFtDLpY4eUi6Zg7AfA5JMtEifbhFfkH0ruIabfnCzc/JBKutkJ4UN7e1NtCtgTgmnZQ+f2HNIHQ0BJ0z0//arbRb5wrvQvB5HtAj59Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752969736; c=relaxed/simple;
	bh=uRAdNF6Jy9+amgIWPSgHQ0mMj0tXsU8HG62Urzi3/UU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zo8apjWgLFfi/ifk2iN9U0/4ApPF4DGbChHhfm5CAVrvZRAGrKEGhfIVm0SFxe/8e7SjQ2MybfYnUd5gdL0n73fEgd5r3btFHNZM6YZ+TmFagarE+p/5WVnSsXi8aVfCO2ZuBpH+FLjcKzAeHkYDgJewHxaZMYx2AJiJuheLGLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bcnj9pMr; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso2758968a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752969734; x=1753574534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AIIypzxyxw4ilus6tCRx6o71Sqrl2VuTVaY8aIA09xM=;
        b=Bcnj9pMrg4Bgbih0A3vfEvVZilfFYGPCzdnHcAIowFJGgxvp957Zrqd7w3dI8UqRYA
         s8jE7BI+UydtZ7GCkI2EmCsdAn+6Ix3eCSt8piiIasigdHyb0hW7+R7n62A4bF038XoZ
         ssAx++e0JndLzjHf58/HikYnnSeZJznbExpF9Eaeew+BUEjZLT042zY72qK/fY2XEvT7
         hD16FH/6kb89N7NQ4u6K43eL2FUkcldgdn3NmH+XB3MXbXi4+vDB5H/HfxdhhGHD56/q
         gBob1m7Yz8IyEH2n0kagTylQMr4rnENhi9IZG6HBtZXRQY04etzOnku+iluBvyeLkPQG
         X2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752969734; x=1753574534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIIypzxyxw4ilus6tCRx6o71Sqrl2VuTVaY8aIA09xM=;
        b=Fi20jU0YnFMhzW4zWnr/zmncw6y9yR3dkGcD4hXfMmhiqCPZKYpYm80BY575v3QDQ4
         n6e5HcQbr85f1tWmI+PQq4bU2K89lMl/W2/AC/VeGRyIH+G0/F7von5D0GrTQXuvrlDD
         2zemkOjaj3l37eE9i84o8ifB1Vrk77NRp35gqkLre3jAV4+y70kWilCgzsoTLF5PmX5P
         0zkZbxqZZsM07ChZsEPh6GP849FN79raK+eFkfYxOxW+xVpSZOtsJOyaCrDfoYipY6yk
         Wex0gwfQUZiw7s+cDHWoAhZxGMXi8tE6h4zeoKvA82Ui7hUr8h9STkgE3piu2h09Nb/S
         aaFA==
X-Forwarded-Encrypted: i=1; AJvYcCWajp71FNtqMrhWmeUObYC0J7MoIoWoi9N7rR3tBntvHoRb/+egLPSDNPIDuySfzwLQ8SoPZw8LoSwCThg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcgep8gosW4K98aOJQH0XUurDfmXdSM4vSAspPXSWsyQRCqpKT
	gC63+VRngbDmbnBfspTVlw69k+8ABF4ALE9YfDk4hgaJEqEloPzbTtoQ
X-Gm-Gg: ASbGncuxpIseE+xJXVwMnWEY6M+y6VbQoRCKG9Rk61kpaGOoX6QZs4CqkjGG3NSDdm1
	6gbq4//Rnyy5Wb3CzsbZXmo4TdlCtjNm56JPruqzUINWkTqsom80GFoZkPfzMmDZ3yQEXPvAEXV
	zn3EnSh2QEcsyoHI5zF9a4mzVSkrvSpJZrfGNBO3VgiSeKqJc9wWVQia65kRm3ImJ7O+A9hAmdM
	0EXr3kqzPigos9DBi2f5bWdU9uYPavl/yv1pchShZgtYToy4Byd2AjhSo+6+0zG44jm8h9RSTon
	C3/OQ1ny/6d8YIMgzSlsr+19NQbzZv4/0JM8iuWkRL+gnnj5fx+ZtZ84chKTep9LvuvKFNUL8IL
	iGWlfYoLoyNNk+rJDyO7xl6crcakvzy5Mk1kqbx3ahGmRB5jtrpIv
X-Google-Smtp-Source: AGHT+IENKAtKxiYYD9bXkKzeXW2rcn+4YIt1xanpaUa2JbcOsT+ugDOwm9jl0S5A1UNw1ayq7YzY0g==
X-Received: by 2002:a17:90b:4fcc:b0:312:e1ec:de44 with SMTP id 98e67ed59e1d1-31c9e77050fmr23930785a91.27.1752969733978;
        Sat, 19 Jul 2025 17:02:13 -0700 (PDT)
Received: from localhost (111-252-5-201.dynamic-ip.hinet.net. [111.252.5.201])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31cc3f2dbd9sm3583595a91.32.2025.07.19.17.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 17:02:13 -0700 (PDT)
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
Subject: [PATCH 6/9] drm/panthor: capture AS state for devcoredump
Date: Sat, 19 Jul 2025 17:01:43 -0700
Message-ID: <20250720000146.1405060-7-olvaffe@gmail.com>
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

Capture interesting MMU_AS_CONTROL regs for devcoredump.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_coredump.c | 33 ++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_coredump.h | 11 ++++++++
 drivers/gpu/drm/panthor/panthor_sched.c    |  5 ++++
 drivers/gpu/drm/panthor/panthor_sched.h    |  2 ++
 4 files changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_coredump.c b/drivers/gpu/drm/panthor/panthor_coredump.c
index 60d651a8468a..acc8ad4cc498 100644
--- a/drivers/gpu/drm/panthor/panthor_coredump.c
+++ b/drivers/gpu/drm/panthor/panthor_coredump.c
@@ -14,6 +14,7 @@
 #include "panthor_coredump.h"
 #include "panthor_device.h"
 #include "panthor_fw.h"
+#include "panthor_mmu.h"
 #include "panthor_regs.h"
 #include "panthor_sched.h"
 
@@ -26,6 +27,7 @@ enum panthor_coredump_mask {
 	PANTHOR_COREDUMP_GLB = BIT(2),
 	PANTHOR_COREDUMP_CSG = BIT(3),
 	PANTHOR_COREDUMP_CS = BIT(4),
+	PANTHOR_COREDUMP_AS = BIT(5),
 };
 
 /**
@@ -57,6 +59,7 @@ struct panthor_coredump {
 	struct panthor_coredump_glb_state glb;
 	struct panthor_coredump_csg_state csg;
 	struct panthor_coredump_cs_state cs[MAX_CS_PER_CSG];
+	struct panthor_coredump_as_state as;
 
 	/* @data: Serialized coredump data. */
 	void *data;
@@ -89,6 +92,15 @@ static const char *reason_str(enum panthor_coredump_reason reason)
 	}
 }
 
+static void print_as(struct drm_printer *p,
+		     const struct panthor_coredump_as_state *as, u32 as_id)
+{
+	drm_printf(p, "as%d:\n", as_id);
+	drm_printf(p, "  FAULTSTATUS: 0x%x\n", as->faultstatus);
+	drm_printf(p, "  FAULTADDRESS: 0x%llx\n", as->faultaddress);
+	drm_printf(p, "  FAULTEXTRA: 0x%llx\n", as->faultextra);
+}
+
 static void print_cs(struct drm_printer *p,
 		     const struct panthor_coredump_cs_state *cs, u32 cs_id)
 {
@@ -259,6 +271,12 @@ static void print_cd(struct drm_printer *p, const struct panthor_coredump *cd)
 		for (u32 i = 0; i < cd->group.queue_count; i++)
 			print_cs(p, &cd->cs[i], i);
 	}
+
+	if (cd->mask & PANTHOR_COREDUMP_AS) {
+		const u32 as_id = cd->csg.config & 0xf;
+
+		print_as(p, &cd->as, as_id);
+	}
 }
 
 static void process_cd(struct panthor_device *ptdev,
@@ -285,6 +303,14 @@ static void process_cd(struct panthor_device *ptdev,
 	print_cd(&p, cd);
 }
 
+static void capture_as(struct panthor_device *ptdev,
+		       struct panthor_coredump_as_state *as, u32 as_id)
+{
+	as->faultstatus = gpu_read(ptdev, AS_FAULTSTATUS(as_id));
+	as->faultaddress = gpu_read64(ptdev, AS_FAULTADDRESS(as_id));
+	as->faultextra = gpu_read64(ptdev, AS_FAULTEXTRA(as_id));
+}
+
 static void capture_cs(struct panthor_device *ptdev,
 		       struct panthor_coredump_cs_state *cs, u32 csg_id,
 		       u32 cs_id, const struct panthor_group *group)
@@ -374,6 +400,8 @@ static void capture_gpu(struct panthor_device *ptdev,
 static void capture_cd(struct panthor_device *ptdev,
 		       struct panthor_coredump *cd, struct panthor_group *group)
 {
+	struct panthor_vm *vm;
+
 	drm_info(&ptdev->base, "capturing coredump states\n");
 
 	if (group) {
@@ -401,6 +429,11 @@ static void capture_cd(struct panthor_device *ptdev,
 	for (u32 i = 0; i < cd->group.queue_count; i++)
 		capture_cs(ptdev, &cd->cs[i], cd->group.csg_id, i, group);
 	cd->mask |= PANTHOR_COREDUMP_CS;
+
+	vm = panthor_group_vm(group);
+
+	capture_as(ptdev, &cd->as, panthor_vm_as(vm));
+	cd->mask |= PANTHOR_COREDUMP_AS;
 }
 
 static void panthor_coredump_free(void *data)
diff --git a/drivers/gpu/drm/panthor/panthor_coredump.h b/drivers/gpu/drm/panthor/panthor_coredump.h
index 44402c6142cb..8aceb0c7d0d4 100644
--- a/drivers/gpu/drm/panthor/panthor_coredump.h
+++ b/drivers/gpu/drm/panthor/panthor_coredump.h
@@ -124,6 +124,17 @@ struct panthor_coredump_cs_state {
 	u32 active;
 };
 
+/**
+ * struct panthor_coredump_as_state - Coredump AS state
+ *
+ * Interesting MMU_AS_CONTROL regs.
+ */
+struct panthor_coredump_as_state {
+	u32 faultstatus;
+	u64 faultaddress;
+	u64 faultextra;
+};
+
 #ifdef CONFIG_DEV_COREDUMP
 
 struct panthor_coredump *
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 4bc31c5f667d..82e43b7ca7aa 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3726,6 +3726,11 @@ void panthor_group_get_ringbuf_iface(
 	*output_iface = queue->iface.output;
 }
 
+struct panthor_vm *panthor_group_vm(struct panthor_group *group)
+{
+	return group->vm;
+}
+
 int panthor_group_pool_create(struct panthor_file *pfile)
 {
 	struct panthor_group_pool *gpool;
diff --git a/drivers/gpu/drm/panthor/panthor_sched.h b/drivers/gpu/drm/panthor/panthor_sched.h
index 284ba39f958a..0cb58212fd44 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.h
+++ b/drivers/gpu/drm/panthor/panthor_sched.h
@@ -38,6 +38,8 @@ void panthor_group_get_ringbuf_iface(
 	const struct panthor_fw_ringbuf_input_iface **input_iface,
 	const struct panthor_fw_ringbuf_output_iface **output_iface);
 
+struct panthor_vm *panthor_group_vm(struct panthor_group *group);
+
 struct drm_sched_job *
 panthor_job_create(struct panthor_file *pfile,
 		   u16 group_handle,
-- 
2.50.0.727.gbf7dc18ff4-goog


