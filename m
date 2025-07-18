Return-Path: <linux-kernel+bounces-736326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A70A0B09B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE211895986
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B9C215075;
	Fri, 18 Jul 2025 06:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA5GS697"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C442036ED
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820709; cv=none; b=jzT7u2WOlYUupSPBob5wEDGGKy8yHvfCZLDlgqitlkqSZvaG+IAPjH3gV22PLEv+tH6PUG6QUanEw8YBIr3vLEi5S+kXFCdN1nGDdr/1LmgnuvSYa9h5xjaItg6gwTgems3mvPbfcbzt+HEVzFsgAhIQNfdYx2MPOcwLHTUz6aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820709; c=relaxed/simple;
	bh=Z6bGvuSgue5vg55Who+wVSq92ZE+83sSHwdR9oeaeBQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7vNeRmHwM8r+bPprDXU/LiVU0WjpAu1eMppZvF1FH/mnawR2rQli/T+jvf7T9WhwM5m2J0bb7IRHnOCHgUcc6FEHx9jfbNtEtr6v/bzskKTEiY8+d4/P9AimXSC6E1CKj4F3xAPDEquWKVfsW4+D2QSK2irAeOOMsEmoHKeBKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cA5GS697; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23636167afeso17373075ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752820707; x=1753425507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pyOFBjjILGZ/9yy1QKGeqG5tqzgbh2ChTzOEA3keYr0=;
        b=cA5GS697X7q9QVpN7Trbbexh/wz2JCSWjNGZKNMQMzGe3PgVLz4Kx286FBujwMo+iJ
         BsjBCXuM/JmUmUKp/ykV1C+JH3354nrtt2y06g2eaYvFequFJupwYyccEMz6zjUIsY4R
         ZR7x1MG5PNN4TA6i0Z6rVEEe3XX56tEQ1+9JTihnMWoW1+BIMkfrePHVBRKwIaLuMN1s
         zYdv22Gcv1keOlD8VOxgHZyP5r2d4+7aSfcZKiDg77eQF1YhUBCyraLlCzQCYGapGlzg
         O1HC7Qp4UvBqEJXRzJrpYSBfeB45d56DA5T2AvYiF5YS25zQjxKS/wW8dONdMiSQ8iKI
         Nx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752820707; x=1753425507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyOFBjjILGZ/9yy1QKGeqG5tqzgbh2ChTzOEA3keYr0=;
        b=q0AdYy2mRhKcTmphHz97CdEteeWa5Qo8m7fF6gK1Oga6UbAviyUIAZNkFyznUPupTF
         P/1UT2GBM+7ZS8VOYQBIq5ozWSevAnAZBNrHalXSUUd/ttBlJtqu8IpeqLZkVZT/naOh
         JXIfVYGcf4gwNpX1wjZdBuprHEC6/Led3OQuSSIc1Ygh+xTYkpVnSxg0Tn75eJ8H+V5r
         2i/uJJo7vAQuwr1OgsdEec/BrAkKlkMTZO5Cfr8gW581c5YAmso33RzTEKyOgdAUnsJ9
         xFm7oXHNoST72/LIOtBp87A1iS4rwz9HJ9HRRk9viLavaAy7QKclOqOBNLjYxWNakZI1
         7Dtg==
X-Forwarded-Encrypted: i=1; AJvYcCV0Tdgep6Oz2XupGDsVBxiJu3e+jRIoWTlbXz2VukSnsn0mvbsp7JuvVTh6kF9nnmWZbJFECCDZbRmBIlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7IWUf5HHXNtKdTsDFCqChj0FmNp1ABLWBGZHScX29UzOuo+Z6
	UcBuIXmd2CqWBNWU79j5sbm2Cx4iC911Ik3Y3zzBSlO/6GcwmaDtLPTz
X-Gm-Gg: ASbGnctlUfvf5JSOiO39bxN53cypXP7QKEFJAlfPSJ/TSXRsm425tQ5EWW1+YckqlZo
	8TJlcgNzzosNuGpNFxAJ3ZYfZ3+zSUwMwhaxhXDhsecogYY3UtjLYupQQqZ7BGhlAP9HWsx1xgv
	GUdKbU/ML3T3z4+sNCUPn6eaqAORRB8MQDnosTsVgKLDz38TQLjyV7St4NfxrSZcjcyDb9J8J9f
	fYNCY2iP4FKlNEVaAUBiavctS0Is56F41p+BySm/RTY40UQZUjbjUCxAiKvGvaJB+BTThCcxtgj
	L4NwY6Miiz/Z+gLhSEJufVxVKuCGHVmx054mV9Yu44o9JzBfTzy/nuGAkdN47wLJixv/yTg+sL0
	6mDFHgMhplQVXLtxnFmz3xZcAmBnGZJqN2diPdIDhUg2E3l1/bZaj6sEadv8cYjoMaS8=
X-Google-Smtp-Source: AGHT+IEyBbipxL07jKyKAdXRLruyc99NlUyMTGUqtVPY6nQyPvdJBmDPwU1q3oCR3Iz/i0MUPQJT5g==
X-Received: by 2002:a17:902:db11:b0:237:ed7c:cd0c with SMTP id d9443c01a7336-23e2566b0fdmr128701105ad.11.1752820707379;
        Thu, 17 Jul 2025 23:38:27 -0700 (PDT)
Received: from localhost (212.18.125.34.bc.googleusercontent.com. [34.125.18.212])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23e3b6b4b73sm6649105ad.113.2025.07.17.23.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 23:38:27 -0700 (PDT)
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
Subject: [PATCH v3 3/3] panthor: dump task pid and comm on gpu errors
Date: Thu, 17 Jul 2025 23:38:16 -0700
Message-ID: <20250718063816.1452123-4-olvaffe@gmail.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250718063816.1452123-1-olvaffe@gmail.com>
References: <20250718063816.1452123-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is useful to know which tasks cause gpu errors.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 9987aeb4608bc..3a7472baa09ac 100644
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


