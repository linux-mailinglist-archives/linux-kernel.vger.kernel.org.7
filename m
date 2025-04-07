Return-Path: <linux-kernel+bounces-591730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A11A7E47D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 17:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD433BE84B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 15:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B261FA177;
	Mon,  7 Apr 2025 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDMA0KP3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692B61FDE27
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744039388; cv=none; b=uslxOwRymUj4WDPsDXog4tmW33y+RaNnZJAd2JKHNNUOZWiJJTMbjgeZhHxUYs36yUSAPTbTwVrJoVSER+7ZuGS0j0FlNBjtPDOhxLar222b5gFpSaiqBT9kR2HCu7tY0fFAreED+pl658D7+Csl5qmgamTRw6N0ca9fNk7QZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744039388; c=relaxed/simple;
	bh=P28JeNDdfIsHs0Yhi2or+iZJOlxhsSMOqlD2e6764qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gimzxl1T7lu2cyY0QBVZjIJUfj2YoaH0eu4jkHyePbrcnBTZKeDeGelQfra7/S5at2dQdyEBCb9FRwEmb62Pcx3NS6T5z7wBmE4p6rQ9SGbd3k4496V8740moniK+2XNu9QfNehsXd/jElDQ5w0Hsyfbfa3UM/Ejzuysd04unB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDMA0KP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53266C4CEE7;
	Mon,  7 Apr 2025 15:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744039388;
	bh=P28JeNDdfIsHs0Yhi2or+iZJOlxhsSMOqlD2e6764qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cDMA0KP3tGjI6x6ba19ugGRDkswnjsmdqrOgCrhRrWMAR4djnsROl/4l2MrX3WT3i
	 oC6BQ3/80kRlSuwBRd+OX6+O9QI7UtW5esQgRMSAED25dDB885cTxu876BlpXy1W97
	 FgFh9ZxvUZOhimxW1+cx3+NhgWD9KUIy/+6XGK49wlrZ3HBE7CheCbjIJIAUbbcvgq
	 04MVCCvDJ8YtoWIECJzwHL0HEKPr1AH2l6GtFRfY6GgjJd8RdOF5qEXPVGxy81H9ON
	 HcFCGzG2skPCY46C3Ehal7dgPCeYDGJRvc6kCBBmIDwakwMxujq/l3J7DOmsUjZ2na
	 F+Ne3qLdPI9Gg==
From: Philipp Stanner <phasta@kernel.org>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] drm/nouveau: Remove waitque for sched teardown
Date: Mon,  7 Apr 2025 17:22:40 +0200
Message-ID: <20250407152239.34429-7-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407152239.34429-2-phasta@kernel.org>
References: <20250407152239.34429-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct nouveau_sched contains a waitque needed to prevent
drm_sched_fini() from being called while there are still jobs pending.
Doing so so far would have caused memory leaks.

With the new memleak-free mode of operation switched on in
drm_sched_fini() by providing the callback
nouveau_sched_fence_context_kill() the waitque is not necessary anymore.

Remove the waitque.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_sched.c | 20 +++++++-------------
 drivers/gpu/drm/nouveau/nouveau_sched.h |  9 +++------
 drivers/gpu/drm/nouveau/nouveau_uvmm.c  |  8 ++++----
 3 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.c b/drivers/gpu/drm/nouveau/nouveau_sched.c
index 3659ac78bb3e..d9ac76198616 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.c
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.c
@@ -121,11 +121,9 @@ nouveau_job_done(struct nouveau_job *job)
 {
 	struct nouveau_sched *sched = job->sched;
 
-	spin_lock(&sched->job.list.lock);
+	spin_lock(&sched->job_list.lock);
 	list_del(&job->entry);
-	spin_unlock(&sched->job.list.lock);
-
-	wake_up(&sched->job.wq);
+	spin_unlock(&sched->job_list.lock);
 }
 
 void
@@ -306,9 +304,9 @@ nouveau_job_submit(struct nouveau_job *job)
 	}
 
 	/* Submit was successful; add the job to the schedulers job list. */
-	spin_lock(&sched->job.list.lock);
-	list_add(&job->entry, &sched->job.list.head);
-	spin_unlock(&sched->job.list.lock);
+	spin_lock(&sched->job_list.lock);
+	list_add(&job->entry, &sched->job_list.head);
+	spin_unlock(&sched->job_list.lock);
 
 	drm_sched_job_arm(&job->base);
 	job->done_fence = dma_fence_get(&job->base.s_fence->finished);
@@ -458,9 +456,8 @@ nouveau_sched_init(struct nouveau_sched *sched, struct nouveau_drm *drm,
 		goto fail_sched;
 
 	mutex_init(&sched->mutex);
-	spin_lock_init(&sched->job.list.lock);
-	INIT_LIST_HEAD(&sched->job.list.head);
-	init_waitqueue_head(&sched->job.wq);
+	spin_lock_init(&sched->job_list.lock);
+	INIT_LIST_HEAD(&sched->job_list.head);
 
 	return 0;
 
@@ -503,9 +500,6 @@ nouveau_sched_fini(struct nouveau_sched *sched)
 	struct drm_gpu_scheduler *drm_sched = &sched->base;
 	struct drm_sched_entity *entity = &sched->entity;
 
-	rmb(); /* for list_empty to work without lock */
-	wait_event(sched->job.wq, list_empty(&sched->job.list.head));
-
 	drm_sched_entity_fini(entity);
 	drm_sched_fini(drm_sched);
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.h b/drivers/gpu/drm/nouveau/nouveau_sched.h
index e6e2016a3569..339a14563fbb 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.h
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.h
@@ -105,12 +105,9 @@ struct nouveau_sched {
 	struct nouveau_channel *chan;
 
 	struct {
-		struct {
-			struct list_head head;
-			spinlock_t lock;
-		} list;
-		struct wait_queue_head wq;
-	} job;
+		struct list_head head;
+		spinlock_t lock;
+	} job_list;
 };
 
 int nouveau_sched_create(struct nouveau_sched **psched, struct nouveau_drm *drm,
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 48f105239f42..ddfc46bc1b3e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1019,8 +1019,8 @@ bind_validate_map_sparse(struct nouveau_job *job, u64 addr, u64 range)
 	u64 end = addr + range;
 
 again:
-	spin_lock(&sched->job.list.lock);
-	list_for_each_entry(__job, &sched->job.list.head, entry) {
+	spin_lock(&sched->job_list.lock);
+	list_for_each_entry(__job, &sched->job_list.head, entry) {
 		struct nouveau_uvmm_bind_job *bind_job = to_uvmm_bind_job(__job);
 
 		list_for_each_op(op, &bind_job->ops) {
@@ -1030,7 +1030,7 @@ bind_validate_map_sparse(struct nouveau_job *job, u64 addr, u64 range)
 
 				if (!(end <= op_addr || addr >= op_end)) {
 					nouveau_uvmm_bind_job_get(bind_job);
-					spin_unlock(&sched->job.list.lock);
+					spin_unlock(&sched->job_list.lock);
 					wait_for_completion(&bind_job->complete);
 					nouveau_uvmm_bind_job_put(bind_job);
 					goto again;
@@ -1038,7 +1038,7 @@ bind_validate_map_sparse(struct nouveau_job *job, u64 addr, u64 range)
 			}
 		}
 	}
-	spin_unlock(&sched->job.list.lock);
+	spin_unlock(&sched->job_list.lock);
 }
 
 static int
-- 
2.48.1


