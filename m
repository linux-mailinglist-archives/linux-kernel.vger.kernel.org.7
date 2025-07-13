Return-Path: <linux-kernel+bounces-728894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC018B02E8E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 05:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A05F17FBEC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 03:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE0219CC3D;
	Sun, 13 Jul 2025 03:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiPyft4X"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977F5189B8C
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 03:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752376130; cv=none; b=FGenzLoFa15Z3Gz6bDKrJWj4y6PXXiJo5Q/s6xMW+OYs7R9iNUSCB3RWHhqnD5LEFUf93cemP8c+Jd7+4PMX97Y/q4fUEbDOiy7+PcebqN01Noiw+YYltac07CVrhMcnEVev6/NRBgshW7urPRnDJ/ahZbIj0ER5Oy7+tWvf96w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752376130; c=relaxed/simple;
	bh=I8BPng6gbQOJExCTFTVIzy2Qx6eJmwv38TKFE1CnP+I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pW4mvoOJCyuxpcCTVXjOjejydPcSCu6JflnkTcmSK2+AjB+4s0M6LiduXvdfZq1H//ER/7AnrCsShZeVIdbMuDgP6ST5wI8M4eEW4MEWUqvrt59Crpcmco7dFv/8jb8aWuFZJERy9N59GUX4B8zePlwVaJSI71QqD3VxKiiqLaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiPyft4X; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2366e5e4dbaso34318015ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 20:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752376128; x=1752980928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOwnLqSs1rW2UYmEVELRGgX3h26kVH+s5TT74bf5das=;
        b=WiPyft4XB/wTIQjPz5udNXOAbaUOmy3l8jw0RvwKV3ND4lZ0VQdYomFFiMj7w+A1n4
         zKpA5sImFjicrYYhZS3BfWkUup/2xqh7mWZ7vazM4RdBnXDaP6S/3QgdlUl1VZHIMN5n
         XDckK0Rm098fxfPrfKEMFw0pLAk86ruK+8UeoOt5sPAJj67kl3dtDNRKfbELFHOp0G3x
         8N6As3865c9CDih11lpNHpnqYe/5McPvrJGk0Xmrswtam12zrtIaaGplvMJurwF55fql
         eATTO8R1caUuG8JlW3bkeTzydnQnPmEwNocdtVOqgIOFAkOCPBH+ZGQOD/bvOMWYxoyV
         GuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752376128; x=1752980928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOwnLqSs1rW2UYmEVELRGgX3h26kVH+s5TT74bf5das=;
        b=sUrrEo9q8yxczdsoOXZSJGcWqsNANDwAuyhmLtVaw6kY/bPgq5PoVz0y6P4kJjApVj
         Up391UzoeMyJPomKqz8tABe8zhhJUSj+9Q1DIcMQLP6R6GwAXpJKN6sTZ5OqFJfJwk0b
         GqsEErsQjUKQYcgngDd9Jem3wsvzW7nESAchiLI6kuA409Y++v+bkbab1LAMb64EkFYS
         1FHwOV2D4CPJfDDXLy4XT+X2qrzFMu8ADOseLtjh6q++/XGkN/grneS+fpIzYhpt0w8l
         lZSX+FNLunjU8TAgf9RG19bc0phEwXrAbnrjo3j0pCnjppRykWIk8wpnU0tW4SvbEHz5
         0VnA==
X-Forwarded-Encrypted: i=1; AJvYcCUrma6MnYZ6Y9cwjTDlhpU6iMqrIP5ZzJvsUnuK80X1mbfqAsg9LRwdkA3O/R4grL/LyXn08nyyd7v62sM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW6c+F4UwJADLRydqmApRJQ29/FXkdje4giX9cA6CfvhT7aN3Y
	Q4SpFHBo/cRCVLcAhCdTo9l55phgcNETX46+IWDChLxUEBsLV9M3npv0
X-Gm-Gg: ASbGncvKLPURTI4LzKt1KU8eGgJH3E+dKHJ0FvJ1XaSeIUVLoO7+R/8EBRJZV7HPJlS
	NhkwY55fkjoSflo1cLBYbC9zs//zI2EPypHeXaxoQ7u+J1e0x3puFKhRbdFXR/a5GDA9pp/IHPg
	atCZsmMNtEK6rBkqFqxHQ3zbhNR7QcAN7QN6M0RtHD6h61PfRHQk2cxD7bcMFlfi/fU7CCmbz6O
	rsvbsL19xTx7dAvSzqzSHE8OEox6vTU9J5tPxWJ2equB1Cpw+E5WYrP4iPYSRtjWb2KI3j63YiW
	yU77M284r0/FL8MOzgjKg6YLr1SZOYlIo/1g5KkfkHFmLTJ15JtR7uWFEh2Oh1aIsjaH3xvkXb8
	BH+B9LJpMv50B+Od+QFnzAXP7vy+0kv0UzyqtxnUaKdfRlI5EX34Dih42
X-Google-Smtp-Source: AGHT+IHEjvSrvB+9387zR5i0O6g6zaBHfqOrSnLb9UWk7X06QM857ZJw7NrfsXYDnkcxFugrnXKMhQ==
X-Received: by 2002:a17:902:d58d:b0:235:e1e4:edb0 with SMTP id d9443c01a7336-23de2ff102emr196227525ad.22.1752376127944;
        Sat, 12 Jul 2025 20:08:47 -0700 (PDT)
Received: from localhost (212.18.125.34.bc.googleusercontent.com. [34.125.18.212])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de4322b0csm72162565ad.113.2025.07.12.20.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 20:08:47 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] panthor: dump task pid and comm on gpu errors
Date: Sat, 12 Jul 2025 20:08:31 -0700
Message-ID: <20250713030831.3227607-4-olvaffe@gmail.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250713030831.3227607-1-olvaffe@gmail.com>
References: <20250713030831.3227607-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is useful to know which tasks cause gpu errors.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 823b0fe678ba6..47912b06ec9d3 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1364,8 +1364,12 @@ cs_slot_process_fatal_event_locked(struct panthor_device *ptdev,
 	fatal = cs_iface->output->fatal;
 	info = cs_iface->output->fatal_info;
 
-	if (group)
+	if (group) {
+		drm_warn(&ptdev->base, "CS_FATAL: pid=%d, comm=%s\n",
+			 group->task_info.pid, group->task_info.comm);
+
 		group->fatal_queues |= BIT(cs_id);
+	}
 
 	if (CS_EXCEPTION_TYPE(fatal) == DRM_PANTHOR_EXCEPTION_CS_UNRECOVERABLE) {
 		/* If this exception is unrecoverable, queue a reset, and make
@@ -1425,6 +1429,11 @@ cs_slot_process_fault_event_locked(struct panthor_device *ptdev,
 		spin_unlock(&queue->fence_ctx.lock);
 	}
 
+	if (group) {
+		drm_warn(&ptdev->base, "CS_FAULT: pid=%d, comm=%s\n",
+			 group->task_info.pid, group->task_info.comm);
+	}
+
 	drm_warn(&ptdev->base,
 		 "CSG slot %d CS slot: %d\n"
 		 "CS_FAULT.EXCEPTION_TYPE: 0x%x (%s)\n"
@@ -1641,11 +1650,15 @@ csg_slot_process_progress_timer_event_locked(struct panthor_device *ptdev, u32 c
 
 	lockdep_assert_held(&sched->lock);
 
-	drm_warn(&ptdev->base, "CSG slot %d progress timeout\n", csg_id);
-
 	group = csg_slot->group;
-	if (!drm_WARN_ON(&ptdev->base, !group))
+	if (!drm_WARN_ON(&ptdev->base, !group)) {
+		drm_warn(&ptdev->base, "CSG_PROGRESS_TIMER_EVENT: pid=%d, comm=%s\n",
+			 group->task_info.pid, group->task_info.comm);
+
 		group->timedout = true;
+	}
+
+	drm_warn(&ptdev->base, "CSG slot %d progress timeout\n", csg_id);
 
 	sched_queue_delayed_work(sched, tick, 0);
 }
@@ -3227,7 +3240,8 @@ queue_timedout_job(struct drm_sched_job *sched_job)
 	struct panthor_scheduler *sched = ptdev->scheduler;
 	struct panthor_queue *queue = group->queues[job->queue_idx];
 
-	drm_warn(&ptdev->base, "job timeout\n");
+	drm_warn(&ptdev->base, "job timeout: pid=%d, comm=%s, seqno=%llu\n",
+		 group->task_info.pid, group->task_info.comm, job->done_fence->seqno);
 
 	drm_WARN_ON(&ptdev->base, atomic_read(&sched->reset.in_progress));
 
-- 
2.50.0.727.gbf7dc18ff4-goog


