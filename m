Return-Path: <linux-kernel+bounces-797281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63903B40E5A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBC7486046
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA8B350D5F;
	Tue,  2 Sep 2025 20:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fcc1muko"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610A2BE048
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756843591; cv=none; b=SMzVPgN/ooLOhv69Dadhyimf+k6xOH3hkjce8QBxiF8G2BM4HpxPu3L0G5xMqY7ix33xWm/s2yM646vCabq0LB3PxSBV8LWzFYs3VrDCNB06J4IF3P1NKhMkbaFckm+znXIsc1dQsCu67OrzFBlBWb3HXaxcTCuvd0g7uw/JQlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756843591; c=relaxed/simple;
	bh=DWoK7tqX5PgF3wSC6tD2e7xHth8F2jQmBic1LgtgAuo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=U/EGPElAAaJ+uRXgIAxga1n5VCAnlDThqlhIxsASelZ+GugGa9PTez/XDuWAru0bdpe8LNvJ3hjLLXXbRlUpAsNEx2T2I+f5+2aMAUnFPqhWloMoy4buTTCBv8XFxXeda68uc/mjx8Igf4lH25Pv+kj6/T3Kw1kjGtaEz7vRyhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fcc1muko; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77251d7cca6so2288787b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 13:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756843588; x=1757448388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ayy33aEbiCOrojQ+KoYlyNeKLNvxYtR93pxbZ3I6xUs=;
        b=Fcc1mukobCCiWk/3ndKWtAMVQcT5MeXy8z/RjI6pgxAPzpDhyUnRFGmYvqPy3Lk1oX
         g2cvsq62y0/cYJwCEU5Q/R1lRAOcyB0/i/SP3w8IPdpRRQCxzbYF5wbcCBMfWOxdryS8
         7A+ea0/qrok3stut5Q2t1EWObeSgdys+NejR+B9q6ET/4ZW5ieCYXZNidLE9SEXjIPhu
         rFFcJx+qghvyFgL8vtPjfG7WzL1L6UFwx4lxyhINMHO03iiVWxd3JbOIMghXJz8AIjUl
         58woaXvytbd37GtJzs+4pIYK5xrM38NPh3BqpWzeYQ/+Wzs8MGDiKu9DvZTgZiTq5oF2
         M7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756843588; x=1757448388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ayy33aEbiCOrojQ+KoYlyNeKLNvxYtR93pxbZ3I6xUs=;
        b=TAiei3FAalPQGWxvhNnjHjjH959aRJjj8zPHoaWuQsmeQu49IeEtw70pA0b9oZH3OA
         KzBcP4WzLZN6CeA7ae27cS5ihk20IoEUMJRMHBSwoVFHoeq+0NHwILiDBrQlhIUmxBXd
         4+KjbSUKPySEh3Le29skeMeJgeAwX3Gw9nyJr35O2ojjJCwVw32LvBP0QDWGVbXsiD1Z
         i/GLmqoQ4zyl4oSix9yci5A6lov/Aula9kYIfM2csGgFDNdte6knU4S1GY5gFcEA2hkf
         lUIh50Slno/OMa98/wlErKiTQ9XciILNY6MIfTa0FyljLY2zGnpa74hxycDKOpxR0yQW
         XKGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWAGXWZx2uuRCgYEiq+naGYV5N/zwjKw0WkdX8MRcTu20kkKBmgysR2Ep28ex8AEGVipcQSwS+kN2OZ1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsG/zzvME4ACRls4BAc5xfTs/gb3BLH9RWR5hdsus8k7TWeHfl
	kz6p4wNsi1qOZzxbnsosH/N1gniOh35rcIyzDXF5aNaW5orRUBUYRPca
X-Gm-Gg: ASbGncvlRzFsh13KsV8XHtcPyxprYyyMnyej10N8aUrUY/p6EnAUHFdeSvcaB9Sfsnz
	Nc8oceY/+2gwOYeh1gyt0hjN+PnSFczWdvVpkSGowllpHyGHlkPYiXNkvek1yo7jur4AzIVcpUj
	fg4poPO2qJBT3F9Bp15ht1b8E9AiKctvwPaQXyUqkSy0ilgETzssTuHIQYex7WMf8sm5MVKKQEG
	pCeuOtQQPoF3qpmwucIfrl+HU8eiPVkPp/RkeoKVX3nbrxIc/s2uvRgC7V53vr/jbAhyUArAopT
	Z15EdyjDZv6FR8LdIzBSvSxj37BsCCM3x1f4eQ0zRFxAw8LOmFfVdk7f6LEJtpzX63Ngfrtn1GH
	Pj3uHZV4biUOkSjtmG0qNX6rD9DqxibGEQ3AfCzvOT4fvfZXHFe2qP+1RbP11YdSfJ3GczxdARJ
	EID4hi8GDcQ6SjHppA5iHxfKUoUTRJOho=
X-Google-Smtp-Source: AGHT+IFMzFQ1FkEPST51kLn+3qPNQ2XfQ/4Cjo0P7wmFjUPdDGLI6HmQWVl8iu/ZdMYPYOvP7uXkWQ==
X-Received: by 2002:a17:902:d4cb:b0:249:2318:7a2d with SMTP id d9443c01a7336-249448f6e79mr152558375ad.19.1756843587778;
        Tue, 02 Sep 2025 13:06:27 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24903702999sm141252535ad.3.2025.09.02.13.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 13:06:27 -0700 (PDT)
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
Subject: [PATCH v3] drm/panthor: assign unique names to queues
Date: Tue,  2 Sep 2025 13:06:24 -0700
Message-ID: <20250902200624.428175-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
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

v3:
 - switch to kasprintf for queue name
   - open to alternatives such as name[48], shorter prefix (e.g.,
     panthor-q), etc.
---
 drivers/gpu/drm/panthor/panthor_drv.c   |  2 +-
 drivers/gpu/drm/panthor/panthor_sched.c | 38 ++++++++++++++++++-------
 drivers/gpu/drm/panthor/panthor_sched.h |  3 +-
 3 files changed, 31 insertions(+), 12 deletions(-)

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
index ba5dc3e443d9c..b328631c00489 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -360,6 +360,9 @@ struct panthor_queue {
 	/** @entity: DRM scheduling entity used for this queue. */
 	struct drm_sched_entity entity;
 
+	/** @name: DRM scheduler name for this queue. */
+	char *name;
+
 	/**
 	 * @remaining_time: Time remaining before the job timeout expires.
 	 *
@@ -901,6 +904,8 @@ static void group_free_queue(struct panthor_group *group, struct panthor_queue *
 	if (queue->scheduler.ops)
 		drm_sched_fini(&queue->scheduler);
 
+	kfree(queue->name);
+
 	panthor_queue_put_syncwait_obj(queue);
 
 	panthor_kernel_bo_destroy(queue->ringbuf);
@@ -3308,9 +3313,10 @@ static u32 calc_profiling_ringbuf_num_slots(struct panthor_device *ptdev,
 
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
@@ -3323,7 +3329,6 @@ group_create_queue(struct panthor_group *group,
 		.credit_limit = args->ringbuf_size / sizeof(u64),
 		.timeout = msecs_to_jiffies(JOB_TIMEOUT_MS),
 		.timeout_wq = group->ptdev->reset.wq,
-		.name = "panthor-queue",
 		.dev = group->ptdev->base.dev,
 	};
 	struct drm_gpu_scheduler *drm_sched;
@@ -3398,6 +3403,15 @@ group_create_queue(struct panthor_group *group,
 	if (ret)
 		goto err_free_queue;
 
+	/* assign a unique name */
+	queue->name = kasprintf(GFP_KERNEL, "panthor-queue-%llu-%u-%u", drm_client_id, gid, qid);
+	if (!queue->name) {
+		ret = -ENOMEM;
+		goto err_free_queue;
+	}
+
+	sched_args.name = queue->name;
+
 	ret = drm_sched_init(&queue->scheduler, &sched_args);
 	if (ret)
 		goto err_free_queue;
@@ -3447,7 +3461,8 @@ static void add_group_kbo_sizes(struct panthor_device *ptdev,
 
 int panthor_group_create(struct panthor_file *pfile,
 			 const struct drm_panthor_group_create *group_args,
-			 const struct drm_panthor_queue_create *queue_args)
+			 const struct drm_panthor_queue_create *queue_args,
+			 u64 drm_client_id)
 {
 	struct panthor_device *ptdev = pfile->ptdev;
 	struct panthor_group_pool *gpool = pfile->groups;
@@ -3540,12 +3555,16 @@ int panthor_group_create(struct panthor_file *pfile,
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
@@ -3553,10 +3572,6 @@ int panthor_group_create(struct panthor_file *pfile,
 
 	group->idle_queues = GENMASK(group->queue_count - 1, 0);
 
-	ret = xa_alloc(&gpool->xa, &gid, group, XA_LIMIT(1, MAX_GROUPS_PER_POOL), GFP_KERNEL);
-	if (ret)
-		goto err_put_group;
-
 	mutex_lock(&sched->reset.lock);
 	if (atomic_read(&sched->reset.in_progress)) {
 		panthor_group_stop(group);
@@ -3575,6 +3590,9 @@ int panthor_group_create(struct panthor_file *pfile,
 
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
2.51.0.338.gd7d06c2dae-goog


