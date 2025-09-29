Return-Path: <linux-kernel+bounces-836034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3169CBA8A47
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A0B3B89DC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22522D3A96;
	Mon, 29 Sep 2025 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xh7/MrDl"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FD52882CE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137762; cv=none; b=MYEGeK9pTVUEa9t05znwNsWjgOWKxZeQyTkORcgsyTkcXgZ5w6yuGM8AHxc+yLkbdPWzX6sUUVc3v7vvc0e6kb6e/QW45/XmXP6ypFXnx6I+KbAXNm1pjtFbab4A3Ir61/0DLd8ODzXHuKy8fyjpFBhk4+SurCPrs+kzHR84b9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137762; c=relaxed/simple;
	bh=Iz7a/+csj2v8C4sn2k5anh+MgzwpbdhqAF5JZBkm4Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2uK/nJAvODNH+KSM/PAZLDnTVFZv7zoOfjhYvxYxBTONTdzCsMU8zjhsPNUfHvSfMQc2jLMwQ5hxBhLVbPSmXYCvTYT3DXQYLIsnLm2WIprvtTUDW7U6ksG3OyywBkShQQvuc+w9u4fc9mPYXgjBj29os6Q+lKOELMWurYw/9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xh7/MrDl; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3727611c1bso786327966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137759; x=1759742559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lRFZDcuR+/tnVgGSLQo/bREaLE1pnyBOicDh/5tuqQ=;
        b=Xh7/MrDlSXAjGNirnSU1XJ+JZFjkQQRTXUP6Wt2jZcUa4iW98BLQFg0auW2BRAufI3
         gw67DeoIA5CukOP9mAtwNZLSX0pt9Hil2OvGbTWt7fmZWzKvFNwS0Armz7/tORQ8E0Hl
         6lxQIn3VyRxEsgfTMEqhQ1BCawNuPUaX3nW1x5jauTJei145TJel6L5eRCnowXOF23Zu
         B46qidhezUDN9rMkl/Cee10v5rU+FU3kRgHfGYctXDAdHUpvYSdKMq9s8GkiRvWshCqB
         OvC3ETxCzaCAoYE2RKd+s8X00FwARV2x+N4lj0XWnpxGgq9wKqT+LghrNVs/JcL0by9C
         CodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137759; x=1759742559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lRFZDcuR+/tnVgGSLQo/bREaLE1pnyBOicDh/5tuqQ=;
        b=u+m3dPv6eTBfF8T7fNzYdp9JwsRGIAfMkLY495BH9sfetjJPVALY6vW5XmfxoxBcwP
         LkNyYLJr9N720qazKB4CBqS1Nwqs2juJgICpqDySyoAA/yFpbcjEiSM2p07xOzH3i6J/
         VKGK1KZxqlyvtXr7Qzmlw9mRWxwwJO8uH+Gqy8xD2HPh0cvbUc3ROn9arSk+/in2P5mr
         ze24pSC5r9FktQlTmK34CIDRwMu4rgYpJjG4X0l8C8jyxMBuQAY4yzUgtBFIv9qQ8A/V
         zdeuVdS/q0DHul8aHFLfi801q836jd2875IUXHiY8LOpResJ7Vv6Eh4+y3m51Q5iW8mw
         o5+g==
X-Gm-Message-State: AOJu0Yzv08i9lQCzEiNu00PyUEZUU+qVOI6eMYOdPJk0QifrL6OBWbQk
	HOXOydsftHfUBbc8dVGG6KhZOWn5E/HZPoVycL2+p28wxRr6dqpf2r59s0HliQ==
X-Gm-Gg: ASbGncv34j4Qen1/Vch2q+hqSwXPPXllYMu4SujI4/xq6z9v+CZjAPH5f+vuvk6vtH3
	YdvwVGtN1r1kiRKipr9Cnmgt5CQmz2o9BtQZEjzmvK7Yk7/Qb86Ew9zS3k528nZAFTU17DoVGxJ
	K8mw+eJnk+PSHUWfFWSOOpmXeKOmvx9Uz5OfpYvwbVTFAjts14xPotYqrqEya5dEJJu1+kVrDu5
	cZ6ujV1HsXiJyT2bBMXZhcpK05obmQEXJjHQTbCkcUF1VA+phpX1lohNImsFOJL8yD6OA0VYb23
	hwl1wNsf/cdpXGrDUsnZ/uIZk2TTSepJ9vwr+Mvmh9GXWvtbIvL8k48SdHG82VYD6DVOFWxAGkn
	M7++Up668jmryiLB0+igMup8hxNf3x5kSqw2KkHUK
X-Google-Smtp-Source: AGHT+IEVILOg+z91fG4SWjeQohPG/tNRPAWTFl9FF7AuDiiUdQbPb54oZ90e624eSQJ3nmcJdqFcUg==
X-Received: by 2002:a17:907:f815:b0:b31:ec30:c678 with SMTP id a640c23a62f3a-b34bbebc92amr1982113766b.57.1759137758418;
        Mon, 29 Sep 2025 02:22:38 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:38 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [RFC PATCH v3 20/24] sched/rt: Add HCBS migration related checks and function calls
Date: Mon, 29 Sep 2025 11:22:17 +0200
Message-ID: <20250929092221.10947-21-yurand2000@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929092221.10947-1-yurand2000@gmail.com>
References: <20250929092221.10947-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: luca abeni <luca.abeni@santannapisa.it>

Add HCBS related checks and operations to allow rt-task migration,
differentiating between cgroup's tasks or tasks that run on the global runqueue.

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 kernel/sched/rt.c | 69 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 1fbcac14fc9..a864f569011 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -884,6 +884,11 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 	struct rq *rq;
 	bool test;
 
+	/* Just return the task_cpu for processes inside task groups */
+	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) &&
+	    is_dl_group(rt_rq_of_se(&p->rt)))
+		goto out;
+
 	/* For anything but wake ups, just return the task_cpu */
 	if (!(flags & (WF_TTWU | WF_FORK)))
 		goto out;
@@ -983,7 +988,10 @@ static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 		 * not yet started the picking loop.
 		 */
 		rq_unpin_lock(rq, rf);
-		pull_rt_task(rq);
+		if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && is_dl_group(rt_rq_of_se(&p->rt)))
+			group_pull_rt_task(rt_rq_of_se(&p->rt));
+		else
+			pull_rt_task(rq);
 		rq_repin_lock(rq, rf);
 	}
 
@@ -1085,7 +1093,10 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 	if (rq->donor->sched_class != &rt_sched_class)
 		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
-	rt_queue_push_tasks(rt_rq);
+	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && is_dl_group(rt_rq))
+		rt_queue_push_from_group(rt_rq);
+	else
+		rt_queue_push_tasks(rt_rq);
 }
 
 static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
@@ -1148,6 +1159,13 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct task_s
 	 */
 	if (on_rt_rq(&p->rt) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_task(rt_rq, p);
+
+	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && is_dl_group(rt_rq)) {
+		struct sched_dl_entity *dl_se = dl_group_of(rt_rq);
+
+		if (dl_se->dl_throttled)
+			rt_queue_push_from_group(rt_rq);
+	}
 }
 
 /* Only try algorithms three times */
@@ -2209,6 +2227,7 @@ static void group_push_rt_tasks(struct rt_rq *rt_rq) { }
  */
 static void task_woken_rt(struct rq *rq, struct task_struct *p)
 {
+	struct rt_rq *rt_rq = rt_rq_of_se(&p->rt);
 	bool need_to_push = !task_on_cpu(rq, p) &&
 			    !test_tsk_need_resched(rq->curr) &&
 			    p->nr_cpus_allowed > 1 &&
@@ -2216,7 +2235,12 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
 			    (rq->curr->nr_cpus_allowed < 2 ||
 			     rq->donor->prio <= p->prio);
 
-	if (need_to_push)
+	if (!need_to_push)
+		return;
+
+	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && is_dl_group(rt_rq))
+		group_push_rt_tasks(rt_rq);
+	else
 		push_rt_tasks(rq);
 }
 
@@ -2256,7 +2280,9 @@ static void switched_from_rt(struct rq *rq, struct task_struct *p)
 	if (!task_on_rq_queued(p) || rt_rq->rt_nr_running)
 		return;
 
-	if (!IS_ENABLED(CONFIG_RT_GROUP_SCHED))
+	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && is_dl_group(rt_rq))
+		rt_queue_pull_to_group(rt_rq);
+	else
 		rt_queue_pull_task(rt_rq);
 }
 
@@ -2277,12 +2303,21 @@ void __init init_sched_rt_class(void)
  */
 static void switched_to_rt(struct rq *rq, struct task_struct *p)
 {
+	struct rt_rq *rt_rq;
+
 	/*
 	 * If we are running, update the avg_rt tracking, as the running time
 	 * will now on be accounted into the latter.
 	 */
 	if (task_current(rq, p)) {
 		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
+
+		if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && is_dl_group(rt_rq_of_se(&p->rt))) {
+			struct sched_dl_entity *dl_se = dl_group_of(rt_rq_of_se(&p->rt));
+
+			p->dl_server = dl_se;
+		}
+
 		return;
 	}
 
@@ -2292,17 +2327,15 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 	 * then see if we can move to another run queue.
 	 */
 	if (task_on_rq_queued(p)) {
-
-#ifndef CONFIG_RT_GROUP_SCHED
-		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
-			rt_queue_push_tasks(rt_rq_of_se(&p->rt));
-#else
-		if (rt_rq_of_se(&p->rt)->overloaded) {
-		} else {
-			if (p->prio < rq->curr->prio)
-				resched_curr(rq);
+		rt_rq = rt_rq_of_se(&p->rt);
+		if (!is_dl_group(rt_rq) && p->nr_cpus_allowed > 1 && rq->rt.overloaded) {
+			rt_queue_push_tasks(rt_rq);
+			return;
+		} else if (is_dl_group(rt_rq) && rt_rq->overloaded) {
+			rt_queue_push_from_group(rt_rq);
+			return;
 		}
-#endif
+
 		if (p->prio < rq->donor->prio && cpu_online(cpu_of(rq)))
 			resched_curr(rq);
 	}
@@ -2325,8 +2358,12 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * If our priority decreases while running, we
 		 * may need to pull tasks to this runqueue.
 		 */
-		if (!IS_ENABLED(CONFIG_RT_GROUP_SCHED) && oldprio < p->prio)
-			rt_queue_pull_task(rt_rq);
+		if (oldprio < p->prio) {
+			if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && is_dl_group(rt_rq))
+				rt_queue_pull_to_group(rt_rq);
+			else
+				rt_queue_pull_task(rt_rq);
+		}
 
 		/*
 		 * If there's a higher priority task waiting to run
-- 
2.51.0


