Return-Path: <linux-kernel+bounces-792549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8827BB3C572
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 01:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43721CC1758
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBFC35A2BD;
	Fri, 29 Aug 2025 23:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZyy4P8o"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F5325EFBC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 23:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756508578; cv=none; b=gVa0EkazLT/bfbGFoKDVwdQV2vEaG0bvzvtXZfCl6Ji7bpnFi70RCzmubvIhWDZ+LEGubzQp0OIpFEMItEZSoD0KVP4Ab1nr6ejMzzzdIdp+QmBZRSGqoTT3pWmm420MjHP3bgc0g6sRTp6HLm8uOJX1HqkvewZpUjw5KM0KRGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756508578; c=relaxed/simple;
	bh=sO3XGfDKtDMdPhAcnJ+M5WONS23di5ZJV1j4mMOiYpU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HI7DieHHZfSvSROK0EQc3UaEX+N5ZvVi0OOBgTHYkghwQ3kjJDjDFuil3tsqjxY3AKc+aPnfUrBDORYHaldC9zgManaLAeaxr9eCCR12D6f0b7lp4UKKAiSqjbLkjTmifmIKwqfSSBrxGz1Yxu6NQYAxT9XnJ00DTESdzR0A128=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZyy4P8o; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-248de53d12dso15295705ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756508576; x=1757113376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eiZs08gbE9JnURBm0lL4iNGpq9sFgFW6HUiD8BlVrlw=;
        b=JZyy4P8ogYu8zu/MXFlaTAw1elqTlNYv9u0UpQ4NZnjl7bUTtZoFZ/OwCFTAJxJNki
         ubxK4mba+CyCq3y+lN+P2fr3v4XznBGEpHWfIrN9jMBpOenaCVzuRl/P/7/s4hEPxsFR
         NTWD1JFs4JhS+TozyYevA/ad+kGS8oyD/Hlgyfkk7xyeQaXoLbcciDaM6Mv3BZazBpZk
         xzfhluvR0WXvqh6sTlHYDb1OLnkoyU0/ec1zbjM6b235eizqcpot4PQ7p7cxPBpTatq9
         8Ytzh5Fu1x+FVwJOb4SADBdq3Nu+i/Ue0+XpdO/gBut/ncq2xxMpgTB5pfWThhvvFCmT
         lLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756508576; x=1757113376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eiZs08gbE9JnURBm0lL4iNGpq9sFgFW6HUiD8BlVrlw=;
        b=h4vgwUXBpnbI93G90EeUJi7LPuKnV8VvXAF4jaEZlGXurcsvb9Qkv8+7XHerhbvDLW
         WmvJDq2s0P9PqH/1+hKdIgjI8tuprvCmZIOX69FJNBb67hIKWZGNlWxVcq5nQEpiFECc
         O5ZnYmjsq2a522DguJOgPC+y0LOikyqWSg4sCKJCpqOgj7RsqzFpVsCfT8ii/EUlKKNi
         WGckt00JZNh5BSWrTU5+1cPdkeNDR3bfAvn+/xj24WWVxGM9rcrpiUBtoBw6Z0Kv/M9M
         t6dm9ps4tuxtClF3R9PwqJKqEI17fFjmITq8xfOUllzgqqtZ8hzF8xH2PuJ6QQTiM7SI
         b/6w==
X-Forwarded-Encrypted: i=1; AJvYcCUDzMjeiZ91TTwKfw7YhK4ufTVncM0s4YKAfIBoZ4RnMWKya3oiA1I04ly9UR+RLK8UUlE2WFLq1zD97Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxozMg2ae/kwmZq2zx87fhzrjQDgLgTDewfWkIpHjZwJgNwwJ+/
	DzwK4yEY6eLItRXTFeHpKSKEvw/kpABOPv8NBj+2xlgZgJ0WL5bNMVXS
X-Gm-Gg: ASbGncvxckrohKoDIvDEceK0IuHRZlqtNnO2d9+AWoR2qvbcNxN29s29CeZm8Alvb7x
	s0SdC3KckCzhYtZEjJD+dXfZ/LfbcqM+JSjuhlZO8DG+/QDVh6+OD84cMs5cWJBgzLCjZwbpCxw
	BRCiHgGCgXxJIgD074a/lJ80xMrbgvkSkLv34tCAFfnF/bal+crhIUxwiR+eZbU0aBy3aoMu5RM
	0ymocZ27wGPMoo6vlZDaLmAKrrTNuo3TsLLvj3BopSeAsUBYEC1TRDVrx8TCNDBjbsOEkAhQ2Bm
	neOWl0nKCD13Ta6XdDbX8vyCAExZVGfKJNuzgFDx1guFFORCP3PJ9p4zo5zRNEMSt7yrov2bAd5
	ajuLWvx0JmP0sYRS71QZgHswT9L3XE3YrrDPUI0NDXEN1IR4LURpBW+ym6dr3rA93
X-Google-Smtp-Source: AGHT+IH9Z0nhUvfFISk3Go+jkDUVMeGGU/M48/XQwo59p9hMYpOasjzBuT2f02Ym5btzFrtOClfPgA==
X-Received: by 2002:a17:902:e888:b0:248:79d4:93ae with SMTP id d9443c01a7336-24944a98674mr3531185ad.33.1756508576211;
        Fri, 29 Aug 2025 16:02:56 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-249067de9f1sm34714485ad.151.2025.08.29.16.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:02:55 -0700 (PDT)
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
Subject: [PATCH v2] drm/panthor: assign unique names to queues
Date: Fri, 29 Aug 2025 16:02:50 -0700
Message-ID: <20250829230251.3095911-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Userspace relies on the ring field of gpu_scheduler tracepoints to
identify a drm_gpu_scheduler.  The value of the ring field is taken from
sched->name.

Because we typically have multiple schedulers running in parallel in
each process, assign unique names to schedulers such that userspace can
distinguish them.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>

---

v2:
 - include drm_client_id in the name to be truly unique
 - remove unnecessary NULL in drm_sched_init_args initialization
 - reformat to column width 100
---
 drivers/gpu/drm/panthor/panthor_drv.c   |  2 +-
 drivers/gpu/drm/panthor/panthor_sched.c | 32 +++++++++++++++++--------
 drivers/gpu/drm/panthor/panthor_sched.h |  3 ++-
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 9256806eb6623..be962b1387f03 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1105,7 +1105,7 @@ static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
 	if (ret)
 		goto out;
 
-	ret = panthor_group_create(pfile, args, queue_args);
+	ret = panthor_group_create(pfile, args, queue_args, file->client_id);
 	if (ret < 0)
 		goto out;
 	args->group_handle = ret;
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index ba5dc3e443d9c..62f17476e5852 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -360,6 +360,9 @@ struct panthor_queue {
 	/** @entity: DRM scheduling entity used for this queue. */
 	struct drm_sched_entity entity;
 
+	/** @name: DRM scheduler name for this queue. */
+	char name[32];
+
 	/**
 	 * @remaining_time: Time remaining before the job timeout expires.
 	 *
@@ -3308,9 +3311,10 @@ static u32 calc_profiling_ringbuf_num_slots(struct panthor_device *ptdev,
 
 static struct panthor_queue *
 group_create_queue(struct panthor_group *group,
-		   const struct drm_panthor_queue_create *args)
+		   const struct drm_panthor_queue_create *args,
+		   u64 drm_client_id, u32 gid, u32 qid)
 {
-	const struct drm_sched_init_args sched_args = {
+	struct drm_sched_init_args sched_args = {
 		.ops = &panthor_queue_sched_ops,
 		.submit_wq = group->ptdev->scheduler->wq,
 		.num_rqs = 1,
@@ -3323,7 +3327,6 @@ group_create_queue(struct panthor_group *group,
 		.credit_limit = args->ringbuf_size / sizeof(u64),
 		.timeout = msecs_to_jiffies(JOB_TIMEOUT_MS),
 		.timeout_wq = group->ptdev->reset.wq,
-		.name = "panthor-queue",
 		.dev = group->ptdev->base.dev,
 	};
 	struct drm_gpu_scheduler *drm_sched;
@@ -3398,6 +3401,11 @@ group_create_queue(struct panthor_group *group,
 	if (ret)
 		goto err_free_queue;
 
+	/* assign a unique name */
+	snprintf(queue->name, sizeof(queue->name), "panthor-queue-%llu-%u-%u",
+		 drm_client_id, gid, qid);
+	sched_args.name = queue->name;
+
 	ret = drm_sched_init(&queue->scheduler, &sched_args);
 	if (ret)
 		goto err_free_queue;
@@ -3447,7 +3455,8 @@ static void add_group_kbo_sizes(struct panthor_device *ptdev,
 
 int panthor_group_create(struct panthor_file *pfile,
 			 const struct drm_panthor_group_create *group_args,
-			 const struct drm_panthor_queue_create *queue_args)
+			 const struct drm_panthor_queue_create *queue_args,
+			 u64 drm_client_id)
 {
 	struct panthor_device *ptdev = pfile->ptdev;
 	struct panthor_group_pool *gpool = pfile->groups;
@@ -3540,12 +3549,16 @@ int panthor_group_create(struct panthor_file *pfile,
 	memset(group->syncobjs->kmap, 0,
 	       group_args->queues.count * sizeof(struct panthor_syncobj_64b));
 
+	ret = xa_alloc(&gpool->xa, &gid, group, XA_LIMIT(1, MAX_GROUPS_PER_POOL), GFP_KERNEL);
+	if (ret)
+		goto err_put_group;
+
 	for (i = 0; i < group_args->queues.count; i++) {
-		group->queues[i] = group_create_queue(group, &queue_args[i]);
+		group->queues[i] = group_create_queue(group, &queue_args[i], drm_client_id, gid, i);
 		if (IS_ERR(group->queues[i])) {
 			ret = PTR_ERR(group->queues[i]);
 			group->queues[i] = NULL;
-			goto err_put_group;
+			goto err_erase_gid;
 		}
 
 		group->queue_count++;
@@ -3553,10 +3566,6 @@ int panthor_group_create(struct panthor_file *pfile,
 
 	group->idle_queues = GENMASK(group->queue_count - 1, 0);
 
-	ret = xa_alloc(&gpool->xa, &gid, group, XA_LIMIT(1, MAX_GROUPS_PER_POOL), GFP_KERNEL);
-	if (ret)
-		goto err_put_group;
-
 	mutex_lock(&sched->reset.lock);
 	if (atomic_read(&sched->reset.in_progress)) {
 		panthor_group_stop(group);
@@ -3575,6 +3584,9 @@ int panthor_group_create(struct panthor_file *pfile,
 
 	return gid;
 
+err_erase_gid:
+	xa_erase(&gpool->xa, gid);
+
 err_put_group:
 	group_put(group);
 	return ret;
diff --git a/drivers/gpu/drm/panthor/panthor_sched.h b/drivers/gpu/drm/panthor/panthor_sched.h
index 742b0b4ff3a3c..f4a475aa34c0a 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.h
+++ b/drivers/gpu/drm/panthor/panthor_sched.h
@@ -21,7 +21,8 @@ struct panthor_job;
 
 int panthor_group_create(struct panthor_file *pfile,
 			 const struct drm_panthor_group_create *group_args,
-			 const struct drm_panthor_queue_create *queue_args);
+			 const struct drm_panthor_queue_create *queue_args,
+			 u64 drm_client_id);
 int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle);
 int panthor_group_get_state(struct panthor_file *pfile,
 			    struct drm_panthor_group_get_state *get_state);
-- 
2.51.0.318.gd7df087d1a-goog


