Return-Path: <linux-kernel+bounces-790645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDC9B3AB43
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91213986BB9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E133527F4CE;
	Thu, 28 Aug 2025 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX6o5k+c"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CA127CCE2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411542; cv=none; b=ayfKafTpom0G0TzOxe2H9smE/yIKgDgA+2pKIFrj9sc0wsP4CJDTuQqeQ1S5BmeR8gexIjQnv5yrqInBs580dOgYhkw92HZDbbuGrFvaMk96SUNiiPtutWSSjYAvhUxTMwzmh0FXcMFwuYWwZcfYhk2ty41mP3JrlAOrUmJ5eCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411542; c=relaxed/simple;
	bh=lLtjzd6O8HO7gkv+l7YGZbUvlYOWHUpA8CFt/l/Th7A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=n/ZWwjVoHbLrAQvZRtBKA0gV8ErztDPyLOlpjWxIdm3ih+GxYfnn8ZzWcKKu3/88wCrZEqzGqdcPej47cLP3s+rmIesRp5yu/WAzzJfQ5VBXj1bnG7SvlrKQ/2YygaQ0DN10SYENFVoMzIWdtdHUtCd/AXyWnOsb83Ku5Wd5ZHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DX6o5k+c; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4cf40cd0d1so11417a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756411539; x=1757016339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jmSGeUqi7bgVdyADhjktgbxkyZv4XRIq1wbeRuWB31M=;
        b=DX6o5k+cxeiK5Vs62WYBbTJ9XWy1V6sQspO+eAbYyNOv/BDQCVasxnL/jB9MOeOYD1
         A7DaGVcEYXPKfNXyeQ5i3UISndWeFg+m7xfMcugZQhmuqIY482wbWyXyKOuI0LY1a+Qt
         4L6bL0irSwmNnNQjcIKOkfkPGRbTL7QyryYP+lJuJDMOu8EiEi/i47cnEWYOx9YZnWkD
         dT7zO3XF6qzR/Z1g8TrDOIkyqzSoNbFShSciJTitZPGfjalB8v8lltUdflkQEByBy96K
         UBTMkumDblrs8c8ktzq/GEFoZGk02K32XLOIAmJJdvwjFmwaLzoAxg9oELvkHSohlTmT
         6pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756411539; x=1757016339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jmSGeUqi7bgVdyADhjktgbxkyZv4XRIq1wbeRuWB31M=;
        b=Qh4WGlduamm5nbisDTbNKZnW+KdQ7YHlXduEqA4/loXKX27n2daKE+pPrPz5I4VoWU
         51qyKcL+uiGIMWOmLtcwfLlCJ6Nr2ozsMGhQ+mDNLbX3TFOpgWJ9QIvUrL4Q/vVueY85
         up+izjx6jGTLuoDTbZA6e4Jar7tJWEIRgGSbavNbPyGBl5JIFkFMmv4ymLBNF9ayfX46
         5ZHsKzQCVCro1Sv6LQReBrMuJzbXtUKhMBfVhPyVEqbvXHBdlNNmKWixSe0e/RMMVt8C
         JdhH0Ulv0fr/NTnc/Poq6HM1DeOQqO0o5/zx1csWxOuUOcOkfGW5+DhECqUkztc5xqll
         h/Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWVQixrMap2hG+FygviXbqIlwf2opu+Vd7lqZ62XJKhhlRR61T8ppjbs5P0OFZx12ZtWXe0mT0IFTzw/g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzpUQUE9px+vwqaos1B3Ymfuab4bCrXMDMooXGuzYkDzChKxXo
	mQHYv28EHq/BY/vOc1dqBV6uErrTzh4bQIgqwMtFAa3wS8iChbQ3KDtD
X-Gm-Gg: ASbGncuV+uXehW1nlCnv+HHocrXNGfs7qV1CIuQNoql5IRmGkC+F5gC2lW9lLq8in8P
	dm4/iP0EhukknEB9rz92vjHLk+v6D+HB0dG+rPbcOlC89HtDAtu6wDbCc4s8ePaPPMqRVJlejiV
	z3VgB3ZN6AvLYtodGOne9AXpp9bhOjXvfwHHeU/Z8tF7gs0GxnQMP1pQGRJCox/9Ekl+cMxwdzd
	nxWhPpPNb0EzI2oONlCCN5yqyYwatovR5eP7QVnM3KuJr+oGeXJZFWRnUc+LsPAEzg3frt1uXP/
	JHKhhzqto0z7VxazbndRRpeI7aF5Zl0k7ip0dE/DQlYajaKCZH/j4+0BwBTDc6++xPqj3s7xrmF
	VWLqS+Ml5SPR1B4Miqo9UWVY6yrZAjoRVK3Hl+54mgVIf/KYdh7bGjyXPGfWJW0M8
X-Google-Smtp-Source: AGHT+IEzxoHmzG3n4HuxC6z+DexJNDaIUy1dNEXlCE2cF0/EicLBDhy71dFO/24eaTNw02i5vYZGOw==
X-Received: by 2002:a17:902:c402:b0:246:464d:118a with SMTP id d9443c01a7336-246464d12bbmr286853515ad.46.1756411539067;
        Thu, 28 Aug 2025 13:05:39 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-249065a4a76sm3522085ad.122.2025.08.28.13.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 13:05:38 -0700 (PDT)
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
Subject: [PATCH] drm/panthor: assign unique names to queues
Date: Thu, 28 Aug 2025 13:05:32 -0700
Message-ID: <20250828200532.3534201-1-olvaffe@gmail.com>
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
 drivers/gpu/drm/panthor/panthor_sched.c | 32 ++++++++++++++++++-------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index ba5dc3e443d9c..26616b6cb110d 100644
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
+		   const struct drm_panthor_queue_create *args, u32 gid,
+		   u32 qid)
 {
-	const struct drm_sched_init_args sched_args = {
+	struct drm_sched_init_args sched_args = {
 		.ops = &panthor_queue_sched_ops,
 		.submit_wq = group->ptdev->scheduler->wq,
 		.num_rqs = 1,
@@ -3323,7 +3327,7 @@ group_create_queue(struct panthor_group *group,
 		.credit_limit = args->ringbuf_size / sizeof(u64),
 		.timeout = msecs_to_jiffies(JOB_TIMEOUT_MS),
 		.timeout_wq = group->ptdev->reset.wq,
-		.name = "panthor-queue",
+		.name = NULL, /* will point to queue->name */
 		.dev = group->ptdev->base.dev,
 	};
 	struct drm_gpu_scheduler *drm_sched;
@@ -3398,6 +3402,11 @@ group_create_queue(struct panthor_group *group,
 	if (ret)
 		goto err_free_queue;
 
+	/* assign a unique name */
+	snprintf(queue->name, sizeof(queue->name), "panthor-queue-%d-%d", gid,
+		 qid);
+	sched_args.name = queue->name;
+
 	ret = drm_sched_init(&queue->scheduler, &sched_args);
 	if (ret)
 		goto err_free_queue;
@@ -3540,12 +3549,18 @@ int panthor_group_create(struct panthor_file *pfile,
 	memset(group->syncobjs->kmap, 0,
 	       group_args->queues.count * sizeof(struct panthor_syncobj_64b));
 
+	ret = xa_alloc(&gpool->xa, &gid, group,
+		       XA_LIMIT(1, MAX_GROUPS_PER_POOL), GFP_KERNEL);
+	if (ret)
+		goto err_put_group;
+
 	for (i = 0; i < group_args->queues.count; i++) {
-		group->queues[i] = group_create_queue(group, &queue_args[i]);
+		group->queues[i] =
+			group_create_queue(group, &queue_args[i], gid, i);
 		if (IS_ERR(group->queues[i])) {
 			ret = PTR_ERR(group->queues[i]);
 			group->queues[i] = NULL;
-			goto err_put_group;
+			goto err_erase_gid;
 		}
 
 		group->queue_count++;
@@ -3553,10 +3568,6 @@ int panthor_group_create(struct panthor_file *pfile,
 
 	group->idle_queues = GENMASK(group->queue_count - 1, 0);
 
-	ret = xa_alloc(&gpool->xa, &gid, group, XA_LIMIT(1, MAX_GROUPS_PER_POOL), GFP_KERNEL);
-	if (ret)
-		goto err_put_group;
-
 	mutex_lock(&sched->reset.lock);
 	if (atomic_read(&sched->reset.in_progress)) {
 		panthor_group_stop(group);
@@ -3575,6 +3586,9 @@ int panthor_group_create(struct panthor_file *pfile,
 
 	return gid;
 
+err_erase_gid:
+	xa_erase(&gpool->xa, gid);
+
 err_put_group:
 	group_put(group);
 	return ret;
-- 
2.51.0.318.gd7df087d1a-goog


