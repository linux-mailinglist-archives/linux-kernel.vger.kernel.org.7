Return-Path: <linux-kernel+bounces-737985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FEAB0B2E0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 02:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253EE3B4C70
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF12941AAC;
	Sun, 20 Jul 2025 00:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkQnKe/m"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A652EAE5
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 00:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752969734; cv=none; b=h4kySDPSg1gVpL9S46vfD0+fv0I5LONLk7pSZDJBPxnKDgSHoqN29co5CtGn8bdw41/R1193KLGKJpWW3TJrL+ASQv0lQnzTxEFx+pstYxUCoAGBiodsJDxZzdXaxkDsUmdB7Qf4OUFKRb8iVtwTzLShuuTrBC9/93zlr8ZtErQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752969734; c=relaxed/simple;
	bh=co8fM46et2XKKPzi9MfgCvG3Np+xylx1AxLZfq6r8tc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhJKVrXNM5aoZ6ityeuEcw/jajTpjK8aenGMzice5qDZpTXhm5F8H9O9emSCfNu2JykxpB5TUBKp8WkUNHqC68FxaJpvdkzf9Y/ZXvPdGL8//hK7QmhTPu2o9luS75+tUtckB3gvnuD/RmHdijBUVKScdH7g6joJdLqN0kFiumA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkQnKe/m; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2353a2bc210so29131785ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752969732; x=1753574532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CVtZY+hbxyEft7E0UMwAw5SSHtVdumRHG0qI/Dby8iI=;
        b=lkQnKe/mlIpxt27snzYPAQ87ZrHRXMn6F5nFGFERUZVsTufRZ1QR5eAA9godt7IOFY
         1s4ZjR430a2uBXSXD3wN1mLgnWYk9dHfSrNcSNLQ8VwEyV9BhsjC/uXz6oMfC+Ayd271
         Mzk/Y9krHj5gHQyYmx/fkjU0hIwShLb74mDEekaYrGOIxRtFZgLJZECHNtgXyiU9HUJ7
         7eK2Uta9Pt5WQZzdcZNOznaQ6pkZ4jQFRINo47Iq2gzTqjZr56ZarN8g+B8nYuFzLFS7
         4ndVkccNu1phTWQ1SqnviRIW+RVBtbvohdsDRnY0axGsQFg0/3QFXsw4YpOfRCi+u9RU
         Re/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752969732; x=1753574532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVtZY+hbxyEft7E0UMwAw5SSHtVdumRHG0qI/Dby8iI=;
        b=Utr3N+il3ljJl0e5x3HCfuD5fF8BH4c5ums4/mTy7J1bv1QbxPUPuDZTLZf0GgxF28
         mScvcxYb8Oxlc6OT39qnon2iKHtDRGR/qHSQEQE1dBq+3MdOZgokQcD1CU6ELFN3vgP5
         DA8wK/J6v2Dndjo9IlhcInyghPPW4CtE4Uc4ekPIpUJmfW5XbX5/p3l5tJaBNN3t107G
         q2/A4l6F7I40zQn5Rd/7YFnWpVTwn8bvJwD1MfSBo5YtXR3G2qciv7xJeAbOgbyg/GLd
         kx8VEa27NRphExKpYQZ5HlERSz0GUeeQKuAs6R5/GuA2CJ2x7VtIaDw6SIgCj/XPtjMu
         CZ/w==
X-Forwarded-Encrypted: i=1; AJvYcCXRytaz+5oGTxjZp02VNzgm46iXTagUB3MZl03a6ZXebbrVLV+XSwwhM9d9hrpBVritznKSVbZfgsn80Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcY94aynlBz3rBgjl+d4C169+T6BmxhsCBXI/Khrm3XBpvj/OI
	nwCZ//7DLXqpJMUZFrzLw/SOTi1eWpfo6n82fyTTUVBc26mkgBYaw/ZR
X-Gm-Gg: ASbGncskwz0NFBI8+Q+tnRPoH6U4Rh6VSo3ePIuQraS3a3d1xQFVOYk392cWqxMAa6C
	wyuqCKHYjb8wXm4Mxrpy1tIuvmORPcNH+sKIL+875sPOM3KHz7v29cnq/rVIIZABSGKyNS/l8Le
	eRLzR3ffaN0qpKnF3sLmi5J5QFFXBM+DTxZ8suoCZDveYAexDrOJ+fFYqSYoSG3WT827byzGWco
	1tqGRi5Vxuzzg0rk8JogAJUN4LZ/Fnbg/uvp1Kp/B66my3WhzwEhxDP0IDlhlDBqaQB1bp3HVkb
	qivVM4FE16YU663sVkwpFALFHPzrMOexSwHuNmtfq+z1VoIv8oMbdw1dh1hYcHTy6BEpYXe29aP
	xSoK6/O1OiCjgPI6mOFfzS3beFCZLTgCLXwTIBMa3SWnPbP/BHLs7CK/ePBSpdCU=
X-Google-Smtp-Source: AGHT+IE3g0H2IGEty7OhpxZ667vS3887RUste0udZafjm+IR47P3+I/iGpe0nwovRH288hXuWM64KA==
X-Received: by 2002:a17:903:acb:b0:215:8d49:e2a7 with SMTP id d9443c01a7336-23e25791562mr203157935ad.50.1752969731631;
        Sat, 19 Jul 2025 17:02:11 -0700 (PDT)
Received: from localhost (111-252-5-201.dynamic-ip.hinet.net. [111.252.5.201])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23e3b6d672asm33905825ad.178.2025.07.19.17.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 17:02:11 -0700 (PDT)
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
Subject: [PATCH 5/9] drm/panthor: capture CS state for devcoredump
Date: Sat, 19 Jul 2025 17:01:42 -0700
Message-ID: <20250720000146.1405060-6-olvaffe@gmail.com>
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

Capture interesting panthor_fw_cs_iface, panthor_fw_ringbuf_input_iface,
and panthor_fw_ringbuf_output_iface fields for devcoredump.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_coredump.c | 79 ++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_coredump.h | 32 +++++++++
 drivers/gpu/drm/panthor/panthor_sched.c    | 11 +++
 drivers/gpu/drm/panthor/panthor_sched.h    |  7 ++
 4 files changed, 129 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_coredump.c b/drivers/gpu/drm/panthor/panthor_coredump.c
index e08bd33b3554..60d651a8468a 100644
--- a/drivers/gpu/drm/panthor/panthor_coredump.c
+++ b/drivers/gpu/drm/panthor/panthor_coredump.c
@@ -25,6 +25,7 @@ enum panthor_coredump_mask {
 	PANTHOR_COREDUMP_GPU = BIT(1),
 	PANTHOR_COREDUMP_GLB = BIT(2),
 	PANTHOR_COREDUMP_CSG = BIT(3),
+	PANTHOR_COREDUMP_CS = BIT(4),
 };
 
 /**
@@ -55,6 +56,7 @@ struct panthor_coredump {
 	struct panthor_coredump_gpu_state gpu;
 	struct panthor_coredump_glb_state glb;
 	struct panthor_coredump_csg_state csg;
+	struct panthor_coredump_cs_state cs[MAX_CS_PER_CSG];
 
 	/* @data: Serialized coredump data. */
 	void *data;
@@ -87,6 +89,37 @@ static const char *reason_str(enum panthor_coredump_reason reason)
 	}
 }
 
+static void print_cs(struct drm_printer *p,
+		     const struct panthor_coredump_cs_state *cs, u32 cs_id)
+{
+	drm_printf(p, "cs%d:\n", cs_id);
+	drm_printf(p, "  STREAM_FEATURES: 0x%x\n", cs->features);
+
+	drm_printf(p, "  CS_REQ: 0x%x\n", cs->req);
+	drm_printf(p, "  CS_CONFIG: 0x%x\n", cs->config);
+	drm_printf(p, "  CS_BASE: 0x%llx\n", cs->base);
+	drm_printf(p, "  CS_SIZE: 0x%x\n", cs->size);
+
+	drm_printf(p, "  CS_ACK: 0x%x\n", cs->ack);
+	drm_printf(p, "  CS_STATUS_CMD_PTR: 0x%llx\n", cs->status_cmd_ptr);
+	drm_printf(p, "  CS_STATUS_WAIT: 0x%x\n", cs->status_wait);
+	drm_printf(p, "  CS_STATUS_REQ_RESOURCE: 0x%x\n",
+		   cs->status_req_resource);
+	drm_printf(p, "  CS_STATUS_SCOREBOARDS: 0x%x\n",
+		   cs->status_scoreboards);
+	drm_printf(p, "  CS_STATUS_BLOCKED_REASON: 0x%x\n",
+		   cs->status_blocked_reason);
+	drm_printf(p, "  CS_FAULT: 0x%x\n", cs->fault);
+	drm_printf(p, "  CS_FATAL: 0x%x\n", cs->fatal);
+	drm_printf(p, "  CS_FAULT_INFO: 0x%llx\n", cs->fault_info);
+	drm_printf(p, "  CS_FATAL_INFO: 0x%llx\n", cs->fatal_info);
+
+	drm_printf(p, "  CS_INSERT: 0x%llx\n", cs->insert);
+	drm_printf(p, "  CS_EXTRACT_INIT: 0x%llx\n", cs->extract_init);
+	drm_printf(p, "  CS_EXTRACT: 0x%llx\n", cs->extract);
+	drm_printf(p, "  CS_ACTIVE: 0x%x\n", cs->active);
+}
+
 static void print_csg(struct drm_printer *p,
 		      const struct panthor_coredump_csg_state *csg, u32 csg_id)
 {
@@ -221,6 +254,11 @@ static void print_cd(struct drm_printer *p, const struct panthor_coredump *cd)
 	if (cd->mask & PANTHOR_COREDUMP_CSG) {
 		print_csg(p, &cd->csg, cd->group.csg_id);
 	}
+
+	if (cd->mask & PANTHOR_COREDUMP_CS) {
+		for (u32 i = 0; i < cd->group.queue_count; i++)
+			print_cs(p, &cd->cs[i], i);
+	}
 }
 
 static void process_cd(struct panthor_device *ptdev,
@@ -247,6 +285,43 @@ static void process_cd(struct panthor_device *ptdev,
 	print_cd(&p, cd);
 }
 
+static void capture_cs(struct panthor_device *ptdev,
+		       struct panthor_coredump_cs_state *cs, u32 csg_id,
+		       u32 cs_id, const struct panthor_group *group)
+{
+	const struct panthor_fw_cs_iface *cs_iface =
+		panthor_fw_get_cs_iface(ptdev, csg_id, cs_id);
+	const struct panthor_fw_ringbuf_input_iface *input_iface;
+	const struct panthor_fw_ringbuf_output_iface *output_iface;
+
+	cs->features = cs_iface->control->features;
+
+	cs->req = cs_iface->input->req;
+	cs->config = cs_iface->input->config;
+	cs->base = cs_iface->input->ringbuf_base;
+	cs->size = cs_iface->input->ringbuf_size;
+
+	cs->ack = cs_iface->output->ack;
+	cs->status_cmd_ptr = cs_iface->output->status_cmd_ptr;
+	cs->status_wait = cs_iface->output->status_wait;
+	cs->status_req_resource = cs_iface->output->status_req_resource;
+	cs->status_scoreboards = cs_iface->output->status_scoreboards;
+	cs->status_blocked_reason = cs_iface->output->status_blocked_reason;
+	cs->fault = cs_iface->output->fault;
+	cs->fatal = cs_iface->output->fatal;
+	cs->fault_info = cs_iface->output->fault_info;
+	cs->fatal_info = cs_iface->output->fatal_info;
+
+	panthor_group_get_ringbuf_iface(group, cs_id, &input_iface,
+					&output_iface);
+
+	cs->insert = input_iface->insert;
+	cs->extract_init = input_iface->extract;
+
+	cs->extract = output_iface->extract;
+	cs->active = output_iface->active;
+}
+
 static void capture_csg(struct panthor_device *ptdev,
 			struct panthor_coredump_csg_state *csg, u32 csg_id)
 {
@@ -322,6 +397,10 @@ static void capture_cd(struct panthor_device *ptdev,
 
 	capture_csg(ptdev, &cd->csg, cd->group.csg_id);
 	cd->mask |= PANTHOR_COREDUMP_CSG;
+
+	for (u32 i = 0; i < cd->group.queue_count; i++)
+		capture_cs(ptdev, &cd->cs[i], cd->group.csg_id, i, group);
+	cd->mask |= PANTHOR_COREDUMP_CS;
 }
 
 static void panthor_coredump_free(void *data)
diff --git a/drivers/gpu/drm/panthor/panthor_coredump.h b/drivers/gpu/drm/panthor/panthor_coredump.h
index d965ebc545d3..44402c6142cb 100644
--- a/drivers/gpu/drm/panthor/panthor_coredump.h
+++ b/drivers/gpu/drm/panthor/panthor_coredump.h
@@ -92,6 +92,38 @@ struct panthor_coredump_csg_state {
 	u32 resource_dep;
 };
 
+/**
+ * struct panthor_coredump_cs_state - Coredump CS state
+ *
+ * Interesting panthor_fw_cs_iface, panthor_fw_ringbuf_input_iface, and
+ * panthor_fw_ringbuf_output_iface fields.
+ */
+struct panthor_coredump_cs_state {
+	u32 features;
+
+	u32 req;
+	u32 config;
+	u64 base;
+	u32 size;
+
+	u32 ack;
+	u64 status_cmd_ptr;
+	u32 status_wait;
+	u32 status_req_resource;
+	u32 status_scoreboards;
+	u32 status_blocked_reason;
+	u32 fault;
+	u32 fatal;
+	u64 fault_info;
+	u64 fatal_info;
+
+	u64 insert;
+	u64 extract_init;
+
+	u64 extract;
+	u32 active;
+};
+
 #ifdef CONFIG_DEV_COREDUMP
 
 struct panthor_coredump *
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 504fc097ebfe..4bc31c5f667d 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3715,6 +3715,17 @@ void panthor_group_capture_coredump(const struct panthor_group *group,
 	state->csg_id = group->csg_id;
 }
 
+void panthor_group_get_ringbuf_iface(
+	const struct panthor_group *group, u32 cs_id,
+	const struct panthor_fw_ringbuf_input_iface **input_iface,
+	const struct panthor_fw_ringbuf_output_iface **output_iface)
+{
+	const struct panthor_queue *queue = group->queues[cs_id];
+
+	*input_iface = queue->iface.input;
+	*output_iface = queue->iface.output;
+}
+
 int panthor_group_pool_create(struct panthor_file *pfile)
 {
 	struct panthor_group_pool *gpool;
diff --git a/drivers/gpu/drm/panthor/panthor_sched.h b/drivers/gpu/drm/panthor/panthor_sched.h
index 6c564153133e..284ba39f958a 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.h
+++ b/drivers/gpu/drm/panthor/panthor_sched.h
@@ -17,6 +17,8 @@ struct drm_panthor_queue_submit;
 struct panthor_coredump_group_state;
 struct panthor_device;
 struct panthor_file;
+struct panthor_fw_ringbuf_input_iface;
+struct panthor_fw_ringbuf_output_iface;
 struct panthor_group;
 struct panthor_group_pool;
 struct panthor_job;
@@ -31,6 +33,11 @@ int panthor_group_get_state(struct panthor_file *pfile,
 void panthor_group_capture_coredump(const struct panthor_group *group,
 				    struct panthor_coredump_group_state *state);
 
+void panthor_group_get_ringbuf_iface(
+	const struct panthor_group *group, u32 cs_id,
+	const struct panthor_fw_ringbuf_input_iface **input_iface,
+	const struct panthor_fw_ringbuf_output_iface **output_iface);
+
 struct drm_sched_job *
 panthor_job_create(struct panthor_file *pfile,
 		   u16 group_handle,
-- 
2.50.0.727.gbf7dc18ff4-goog


