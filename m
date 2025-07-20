Return-Path: <linux-kernel+bounces-737981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9900CB0B2DA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 02:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABCEA3BADFC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBADC13D;
	Sun, 20 Jul 2025 00:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGnv63t8"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2394A0C
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 00:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752969726; cv=none; b=AyVhe5kfFjW4OFoSh4S0nhCdZ6B/0v2GRRHkrapjbbnSrkNurisUdO1ClpmBvMWfAZznXorlxEerUEoVl2g5ux6Dr2CjEWfhd/R/bKrEAxMesjHzowxcRKK96jywwPgoao68vg6o9udMUOHPx67II6R+C0bRfjjzn+Htc70rmJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752969726; c=relaxed/simple;
	bh=f3sPNOmbz1cAUjjRTAPczKdJrJRbDvuZnqA6J4bL/HY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9JNxnsaTqTPZbUf7PoXuEU+9ZcZB2AtRsAmf8U6CRWRI8Qe5vaKTHAPdj41JFU0wdRVeZHe5Y7wHKdHYXYqH+HcQe8svNk5oS91JuPVA1IWgbhApOtYpceKUjRGXl2CIZyOVqKg1IhLbm8ORFyAv/gOkY94lZEGfr4zN9vgsIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGnv63t8; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7494999de5cso2217119b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752969724; x=1753574524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qbck2cXbd/qwtXMK5uvo6QmQLG1NWHGRr9q0m8lydtU=;
        b=jGnv63t8lF68FpZ1WQaPJrk0p5/7eSdsuLU5AElWSPr/OjJMq0R6NbBVDHhntxLvSD
         a8HuSqlDfPlfEcT/HtFcGp1WUTNhS7gwaFjt9ft8CZ2V4MHJ13EbReVacuVIhcTTgxh+
         OTShJcvEWw9sNKH/fgkgt4EXJ+LMqwq05HCXq+LtOy2RXcvMew36Oo/xQ66HrJZO/TmH
         mFJraopyi2tBQb6QJ7DsWTDAwLFLf03MellrYjjmsTkURb4e+tAqPdLKDWJ2aKZT5xFG
         guB3NA+n3jl1Z9s5HwSDwHcEPZQCqRXKFks3FZv5EVEVS2B5AZEO9bHDUFY5S/6EehMR
         g7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752969724; x=1753574524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qbck2cXbd/qwtXMK5uvo6QmQLG1NWHGRr9q0m8lydtU=;
        b=rpF1BFYtIgAXDbG59pdzNJSg8quxE6eHiwJp18hErQrUr4NsWxX0j94THEqfzVrcMP
         vVJtQU6q93CV6WGzItMbWcS48oxr/jLpYxAwJLxl1z4J7lojNZtZdwyu53flvsUpddDU
         fwgT5e++HJlUbcr8cJSTjf7gmA2H+FriXMlYzL+xVV2l0IGh2h0Jy2XPwTOZxRMgnq9Y
         EGQeSgAA4G7QdpR7nrMDqhYGIzVfK+milIG6YJ8Y/Cbv7nEL+xci0W39g8AmvC6YYU4Y
         Sg7OO76EZouHGGZvjhskuwZ+CqJh6bmBYNbg/vTPW40cqM06DzCRq80GVvxuaXQFmMzc
         NaHg==
X-Forwarded-Encrypted: i=1; AJvYcCU26t5r307oi9HNqzIY8KIjN8QJXhtmy5mYhPZqybL/Bb0ZI+C03WdDQQQK0a1rjx8cDXrFW+lkwcgYtTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywDjVEfNYu+ry8YWxMwcD1dNUW1skM57Z7gPX5TSNrfuofvwx5
	Bq5zT3mqhZCSfFtNsx43rkBOlxWyuraSLxPAwRjdSxzXpRGZc4hnxmUz
X-Gm-Gg: ASbGncuj7HfIEgme872W6x8OoMrN+VjGEWDDNhh0tsor9l6sP0xQJdQwSrxxQ7LcCXo
	2SmFUdIQQKqo6afHoyNr31vjEPN+h56HGXjRocWEYUlbuKsqsOEALT7mm1vfcB9DBu2QMRe8Bob
	SIkuiItk4bm9/ohv3xOzME2iN77J98ZNr0eon6fJCv5W6j5uUqbyGjWaTRZ0cQV4d9aJ7tQBQ6a
	ERDbhPSXoHyIbRZunfK7dQa8gAHRP3u7gA0CFGimB3kej7LY9s5p4FwSoVoI+BMUQfuUB3rlAY4
	G2uF4TI0zDw92KEttEuVabxazppBr0cDWx3INeeXqFJDeryLblOzrc1HdkdwbbmmgLVC8P3fDGx
	0+J/2gzzytdlWiuscs9uvrVsCBPEUZ9I8jFyptVNAC/y0A4j6or2S
X-Google-Smtp-Source: AGHT+IGTyHeal7qpSuk24k+kmdTSfU/jDB9NEhtXDS5aRUxd2kJfVqKFdl+w9iLB63bRKZ/TZkcysA==
X-Received: by 2002:a05:6a00:189b:b0:736:4e67:d631 with SMTP id d2e1a72fcca58-756eacb7658mr24256274b3a.23.1752969723929;
        Sat, 19 Jul 2025 17:02:03 -0700 (PDT)
Received: from localhost (111-252-5-201.dynamic-ip.hinet.net. [111.252.5.201])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-759cb76de4fsm3300978b3a.114.2025.07.19.17.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 17:02:03 -0700 (PDT)
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
Subject: [PATCH 1/9] drm/panthor: add devcoredump support
Date: Sat, 19 Jul 2025 17:01:38 -0700
Message-ID: <20250720000146.1405060-2-olvaffe@gmail.com>
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

Create a devcoredump on any faulty or fatal event. The coredump data is
in YAML format for readability and flexibility.

Only panthor_group state is captured for now.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/Makefile           |   2 +
 drivers/gpu/drm/panthor/panthor_coredump.c | 225 +++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_coredump.h |  68 +++++++
 drivers/gpu/drm/panthor/panthor_device.h   |   6 +
 drivers/gpu/drm/panthor/panthor_sched.c    |  69 +++++++
 drivers/gpu/drm/panthor/panthor_sched.h    |   5 +
 6 files changed, 375 insertions(+)
 create mode 100644 drivers/gpu/drm/panthor/panthor_coredump.c
 create mode 100644 drivers/gpu/drm/panthor/panthor_coredump.h

diff --git a/drivers/gpu/drm/panthor/Makefile b/drivers/gpu/drm/panthor/Makefile
index 15294719b09c..9fd1e74af1df 100644
--- a/drivers/gpu/drm/panthor/Makefile
+++ b/drivers/gpu/drm/panthor/Makefile
@@ -11,4 +11,6 @@ panthor-y := \
 	panthor_mmu.o \
 	panthor_sched.o
 
+panthor-$(CONFIG_DEV_COREDUMP) += panthor_coredump.o
+
 obj-$(CONFIG_DRM_PANTHOR) += panthor.o
diff --git a/drivers/gpu/drm/panthor/panthor_coredump.c b/drivers/gpu/drm/panthor/panthor_coredump.c
new file mode 100644
index 000000000000..767f3327e3e8
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_coredump.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2025 Google LLC */
+
+#include <drm/drm_drv.h>
+#include <drm/drm_print.h>
+#include <drm/drm_managed.h>
+#include <generated/utsrelease.h>
+#include <linux/devcoredump.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/timekeeping.h>
+
+#include "panthor_coredump.h"
+#include "panthor_device.h"
+#include "panthor_sched.h"
+
+/**
+ * enum panthor_coredump_mask - Coredump state
+ */
+enum panthor_coredump_mask {
+	PANTHOR_COREDUMP_GROUP = BIT(0),
+};
+
+/**
+ * struct panthor_coredump_header - Coredump header
+ */
+struct panthor_coredump_header {
+	enum panthor_coredump_reason reason;
+	ktime_t timestamp;
+};
+
+/**
+ * struct panthor_coredump - Coredump
+ */
+struct panthor_coredump {
+	/** @ptdev: Device. */
+	struct panthor_device *ptdev;
+
+	/** @work: Bottom half of panthor_coredump_capture. */
+	struct work_struct work;
+
+	/** @header: Header. */
+	struct panthor_coredump_header header;
+
+	/** @mask: Bitmask of captured states. */
+	u32 mask;
+
+	struct panthor_coredump_group_state group;
+
+	/* @data: Serialized coredump data. */
+	void *data;
+
+	/* @size: Serialized coredump size. */
+	size_t size;
+};
+
+static const char *reason_str(enum panthor_coredump_reason reason)
+{
+	switch (reason) {
+	case PANTHOR_COREDUMP_REASON_MMU_FAULT:
+		return "MMU_FAULT";
+	case PANTHOR_COREDUMP_REASON_CSG_REQ_TIMEOUT:
+		return "CSG_REQ_TIMEOUT";
+	case PANTHOR_COREDUMP_REASON_CSG_UNKNOWN_STATE:
+		return "CSG_UNKNOWN_STATE";
+	case PANTHOR_COREDUMP_REASON_CSG_PROGRESS_TIMEOUT:
+		return "CSG_PROGRESS_TIMEOUT";
+	case PANTHOR_COREDUMP_REASON_CS_FATAL:
+		return "CS_FATAL";
+	case PANTHOR_COREDUMP_REASON_CS_FAULT:
+		return "CS_FAULT";
+	case PANTHOR_COREDUMP_REASON_CS_TILER_OOM:
+		return "CS_TILER_OOM";
+	case PANTHOR_COREDUMP_REASON_JOB_TIMEOUT:
+		return "JOB_TIMEOUT";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+static void print_group(struct drm_printer *p,
+			const struct panthor_coredump_group_state *group)
+{
+	drm_puts(p, "group:\n");
+	drm_printf(p, "  priority: %d\n", group->priority);
+	drm_printf(p, "  queue_count: %u\n", group->queue_count);
+	drm_printf(p, "  pid: %d\n", group->pid);
+	drm_printf(p, "  comm: %s\n", group->comm);
+	drm_printf(p, "  destroyed: %d\n", group->destroyed);
+	drm_printf(p, "  csg_id: %d\n", group->csg_id);
+}
+
+static void print_header(struct drm_printer *p,
+			 const struct panthor_coredump_header *header,
+			 const struct drm_driver *drv)
+{
+	drm_puts(p, "header:\n");
+	drm_puts(p, "  kernel: " UTS_RELEASE "\n");
+	drm_puts(p, "  module: " KBUILD_MODNAME "\n");
+	drm_printf(p, "  driver_version: %d.%d\n", drv->major, drv->minor);
+
+	drm_printf(p, "  reason: %s\n", reason_str(header->reason));
+	drm_printf(p, "  timestamp: %lld\n", ktime_to_ns(header->timestamp));
+}
+
+static void print_cd(struct drm_printer *p, const struct panthor_coredump *cd)
+{
+	/* in YAML format */
+	drm_puts(p, "---\n");
+	print_header(p, &cd->header, cd->ptdev->base.driver);
+
+	if (cd->mask & PANTHOR_COREDUMP_GROUP)
+		print_group(p, &cd->group);
+}
+
+static void process_cd(struct panthor_device *ptdev,
+		       struct panthor_coredump *cd)
+{
+	struct drm_print_iterator iter = {
+		.remain = SSIZE_MAX,
+	};
+	struct drm_printer p = drm_coredump_printer(&iter);
+
+	print_cd(&p, cd);
+
+	iter.remain = SSIZE_MAX - iter.remain;
+	iter.data = kvmalloc(iter.remain, GFP_USER);
+	if (!iter.data)
+		return;
+
+	cd->data = iter.data;
+	cd->size = iter.remain;
+
+	drm_info(&ptdev->base, "generating coredump of size %zu\n", cd->size);
+
+	p = drm_coredump_printer(&iter);
+	print_cd(&p, cd);
+}
+
+static void capture_cd(struct panthor_device *ptdev,
+		       struct panthor_coredump *cd, struct panthor_group *group)
+{
+	drm_info(&ptdev->base, "capturing coredump states\n");
+
+	if (group) {
+		panthor_group_capture_coredump(group, &cd->group);
+		cd->mask |= PANTHOR_COREDUMP_GROUP;
+	}
+}
+
+static void panthor_coredump_free(void *data)
+{
+	struct panthor_coredump *cd = data;
+	struct panthor_device *ptdev = cd->ptdev;
+
+	kvfree(cd->data);
+	kfree(cd);
+
+	atomic_set(&ptdev->coredump.pending, 0);
+}
+
+static ssize_t panthor_coredump_read(char *buffer, loff_t offset, size_t count,
+				     void *data, size_t datalen)
+{
+	const struct panthor_coredump *cd = data;
+
+	if (offset >= cd->size)
+		return 0;
+
+	if (count > cd->size - offset)
+		count = cd->size - offset;
+
+	memcpy(buffer, cd->data + offset, count);
+
+	return count;
+}
+
+static void panthor_coredump_process_work(struct work_struct *work)
+{
+	struct panthor_coredump *cd =
+		container_of(work, struct panthor_coredump, work);
+	struct panthor_device *ptdev = cd->ptdev;
+
+	process_cd(ptdev, cd);
+
+	dev_coredumpm(ptdev->base.dev, THIS_MODULE, cd, 0, GFP_KERNEL,
+		      panthor_coredump_read, panthor_coredump_free);
+}
+
+void panthor_coredump_capture(struct panthor_coredump *cd,
+			      struct panthor_group *group)
+{
+	struct panthor_device *ptdev = cd->ptdev;
+
+	capture_cd(ptdev, cd, group);
+
+	queue_work(system_unbound_wq, &cd->work);
+}
+
+struct panthor_coredump *
+panthor_coredump_alloc(struct panthor_device *ptdev,
+		       enum panthor_coredump_reason reason, gfp_t gfp)
+{
+	struct panthor_coredump *cd;
+
+	/* reject all but the first coredump until it is handled */
+	if (atomic_cmpxchg(&ptdev->coredump.pending, 0, 1)) {
+		drm_dbg(&ptdev->base, "skip subsequent coredump\n");
+		return NULL;
+	}
+
+	cd = kzalloc(sizeof(*cd), gfp);
+	if (!cd) {
+		atomic_set(&ptdev->coredump.pending, 0);
+		return NULL;
+	}
+
+	cd->ptdev = ptdev;
+	INIT_WORK(&cd->work, panthor_coredump_process_work);
+
+	cd->header.reason = reason;
+	cd->header.timestamp = ktime_get_real();
+
+	return cd;
+}
diff --git a/drivers/gpu/drm/panthor/panthor_coredump.h b/drivers/gpu/drm/panthor/panthor_coredump.h
new file mode 100644
index 000000000000..dd1fe1c2e175
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_coredump.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2019 Collabora ltd. */
+
+#ifndef __PANTHOR_COREDUMP_H__
+#define __PANTHOR_COREDUMP_H__
+
+#include <drm/panthor_drm.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+
+struct panthor_coredump;
+struct panthor_device;
+struct panthor_group;
+
+/**
+ * enum panthor_coredump_reason - Coredump reason
+ */
+enum panthor_coredump_reason {
+	PANTHOR_COREDUMP_REASON_MMU_FAULT,
+	PANTHOR_COREDUMP_REASON_CSG_REQ_TIMEOUT,
+	PANTHOR_COREDUMP_REASON_CSG_UNKNOWN_STATE,
+	PANTHOR_COREDUMP_REASON_CSG_PROGRESS_TIMEOUT,
+	PANTHOR_COREDUMP_REASON_CS_FATAL,
+	PANTHOR_COREDUMP_REASON_CS_FAULT,
+	PANTHOR_COREDUMP_REASON_CS_TILER_OOM,
+	PANTHOR_COREDUMP_REASON_JOB_TIMEOUT,
+};
+
+/**
+ * struct panthor_coredump_group_state - Coredump group state
+ *
+ * Interesting panthor_group fields.
+ */
+struct panthor_coredump_group_state {
+	enum drm_panthor_group_priority priority;
+	u32 queue_count;
+	pid_t pid;
+	char comm[TASK_COMM_LEN];
+	bool destroyed;
+	int csg_id;
+};
+
+#ifdef CONFIG_DEV_COREDUMP
+
+struct panthor_coredump *
+panthor_coredump_alloc(struct panthor_device *ptdev,
+		       enum panthor_coredump_reason reason, gfp_t gfp);
+
+void panthor_coredump_capture(struct panthor_coredump *cd,
+			      struct panthor_group *group);
+
+#else /* CONFIG_DEV_COREDUMP */
+
+static inline struct panthor_coredump *
+panthor_coredump_alloc(struct panthor_device *ptdev,
+		       enum panthor_coredump_reason reason, gfp_t gfp)
+{
+	return NULL;
+}
+
+static inline void panthor_coredump_capture(struct panthor_coredump *cd,
+					    struct panthor_group *group)
+{
+}
+
+#endif /* CONFIG_DEV_COREDUMP */
+
+#endif /* __PANTHOR_COREDUMP_H__ */
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 4fc7cf2aeed5..766e53c25cfa 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -197,6 +197,12 @@ struct panthor_device {
 		atomic_t recovery_needed;
 	} pm;
 
+	/** @coredump: Coredump-related data. */
+	struct {
+		/** @pending: True if there is a pending coredump. */
+		atomic_t pending;
+	} coredump;
+
 	/** @profile_mask: User-set profiling flags for job accounting. */
 	u32 profile_mask;
 
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index a2248f692a03..eb45b5ad9774 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
+#include "panthor_coredump.h"
 #include "panthor_devfreq.h"
 #include "panthor_device.h"
 #include "panthor_fw.h"
@@ -1031,6 +1032,10 @@ group_unbind_locked(struct panthor_group *group)
 	return 0;
 }
 
+static void panthor_sched_coredump_locked(struct panthor_device *ptdev,
+					  enum panthor_coredump_reason reason,
+					  struct panthor_group *group);
+
 /**
  * cs_slot_prog_locked() - Program a queue slot
  * @ptdev: Device.
@@ -1249,6 +1254,10 @@ csg_slot_sync_state_locked(struct panthor_device *ptdev, u32 csg_id)
 		drm_err(&ptdev->base, "Invalid state on CSG %d (state=%d)",
 			csg_id, csg_state);
 		new_state = PANTHOR_CS_GROUP_UNKNOWN_STATE;
+
+		panthor_sched_coredump_locked(
+			ptdev, PANTHOR_COREDUMP_REASON_CSG_UNKNOWN_STATE,
+			group);
 		break;
 	}
 
@@ -1378,6 +1387,9 @@ cs_slot_process_fatal_event_locked(struct panthor_device *ptdev,
 		 panthor_exception_name(ptdev, CS_EXCEPTION_TYPE(fatal)),
 		 (unsigned int)CS_EXCEPTION_DATA(fatal),
 		 info);
+
+	panthor_sched_coredump_locked(ptdev, PANTHOR_COREDUMP_REASON_CS_FATAL,
+				      group);
 }
 
 static void
@@ -1426,6 +1438,9 @@ cs_slot_process_fault_event_locked(struct panthor_device *ptdev,
 		 panthor_exception_name(ptdev, CS_EXCEPTION_TYPE(fault)),
 		 (unsigned int)CS_EXCEPTION_DATA(fault),
 		 info);
+
+	panthor_sched_coredump_locked(ptdev, PANTHOR_COREDUMP_REASON_CS_FAULT,
+				      group);
 }
 
 static int group_process_tiler_oom(struct panthor_group *group, u32 cs_id)
@@ -1480,6 +1495,10 @@ static int group_process_tiler_oom(struct panthor_group *group, u32 cs_id)
 		drm_warn(&ptdev->base, "Failed to extend the tiler heap\n");
 		group->fatal_queues |= BIT(cs_id);
 		sched_queue_delayed_work(sched, tick, 0);
+
+		panthor_sched_coredump_locked(
+			ptdev, PANTHOR_COREDUMP_REASON_CS_TILER_OOM, group);
+
 		goto out_put_heap_pool;
 	}
 
@@ -1639,6 +1658,9 @@ csg_slot_process_progress_timer_event_locked(struct panthor_device *ptdev, u32 c
 		group->timedout = true;
 
 	sched_queue_delayed_work(sched, tick, 0);
+
+	panthor_sched_coredump_locked(
+		ptdev, PANTHOR_COREDUMP_REASON_CSG_PROGRESS_TIMEOUT, group);
 }
 
 static void sched_process_csg_irq_locked(struct panthor_device *ptdev, u32 csg_id)
@@ -1858,8 +1880,16 @@ static int csgs_upd_ctx_apply_locked(struct panthor_device *ptdev,
 
 		if (ret && acked != req_mask &&
 		    ((csg_iface->input->req ^ csg_iface->output->ack) & req_mask) != 0) {
+			struct panthor_csg_slot *csg_slot =
+				&sched->csg_slots[csg_id];
+			struct panthor_group *group = csg_slot->group;
+
 			drm_err(&ptdev->base, "CSG %d update request timedout", csg_id);
 			ctx->timedout_mask |= BIT(csg_id);
+
+			panthor_sched_coredump_locked(
+				ptdev, PANTHOR_COREDUMP_REASON_CSG_REQ_TIMEOUT,
+				group);
 		}
 	}
 
@@ -2027,6 +2057,10 @@ tick_ctx_init(struct panthor_scheduler *sched,
 		 * CSG IRQs, so we can flag the faulty queue.
 		 */
 		if (panthor_vm_has_unhandled_faults(group->vm)) {
+			panthor_sched_coredump_locked(
+				ptdev, PANTHOR_COREDUMP_REASON_MMU_FAULT,
+				group);
+
 			sched_process_csg_irq_locked(ptdev, i);
 
 			/* No fatal fault reported, flag all queues as faulty. */
@@ -3237,6 +3271,10 @@ queue_timedout_job(struct drm_sched_job *sched_job)
 
 		group_queue_work(group, term);
 	}
+
+	panthor_sched_coredump_locked(
+		ptdev, PANTHOR_COREDUMP_REASON_JOB_TIMEOUT, group);
+
 	mutex_unlock(&sched->lock);
 
 	queue_start(queue);
@@ -3627,6 +3665,37 @@ int panthor_group_get_state(struct panthor_file *pfile,
 	return 0;
 }
 
+static void panthor_sched_coredump_locked(struct panthor_device *ptdev,
+					  enum panthor_coredump_reason reason,
+					  struct panthor_group *group)
+{
+	struct panthor_coredump *cd;
+
+	lockdep_assert_held(&ptdev->scheduler->lock);
+
+	/* GFP_NOWAIT because this may be called from fence signaling path */
+	cd = panthor_coredump_alloc(ptdev, reason, GFP_NOWAIT);
+	if (!cd)
+		return;
+
+	panthor_coredump_capture(cd, group);
+}
+
+void panthor_group_capture_coredump(const struct panthor_group *group,
+				    struct panthor_coredump_group_state *state)
+{
+	const struct panthor_device *ptdev = group->ptdev;
+
+	/* this is called from panthor_coredump_capture */
+	lockdep_assert_held(&ptdev->scheduler->lock);
+
+	state->priority = group->priority;
+	state->queue_count = group->queue_count;
+	/* TODO state->pid and state->comm */
+	state->destroyed = group->destroyed;
+	state->csg_id = group->csg_id;
+}
+
 int panthor_group_pool_create(struct panthor_file *pfile)
 {
 	struct panthor_group_pool *gpool;
diff --git a/drivers/gpu/drm/panthor/panthor_sched.h b/drivers/gpu/drm/panthor/panthor_sched.h
index 742b0b4ff3a3..6c564153133e 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.h
+++ b/drivers/gpu/drm/panthor/panthor_sched.h
@@ -14,8 +14,10 @@ struct drm_panthor_group_create;
 struct drm_panthor_queue_create;
 struct drm_panthor_group_get_state;
 struct drm_panthor_queue_submit;
+struct panthor_coredump_group_state;
 struct panthor_device;
 struct panthor_file;
+struct panthor_group;
 struct panthor_group_pool;
 struct panthor_job;
 
@@ -26,6 +28,9 @@ int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle);
 int panthor_group_get_state(struct panthor_file *pfile,
 			    struct drm_panthor_group_get_state *get_state);
 
+void panthor_group_capture_coredump(const struct panthor_group *group,
+				    struct panthor_coredump_group_state *state);
+
 struct drm_sched_job *
 panthor_job_create(struct panthor_file *pfile,
 		   u16 group_handle,
-- 
2.50.0.727.gbf7dc18ff4-goog


