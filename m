Return-Path: <linux-kernel+bounces-751979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D9BB16FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F74545801
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA01A2D3217;
	Thu, 31 Jul 2025 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbW0gtV5"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BEE2D0C89
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959364; cv=none; b=VaXLaGoxmtLiqY/vYFlmYxY6JxaeS5/wbmD+wkNX9fI3DIt2tY47vlFmBFx2qKd3INZAQLqrHOMrXr0UKUXCnsLIJ6DU9emOKHjR6jMBzlQkC2qFTDik9aUTtGd7r4upy+V6WaP8MsmsumV6gaDC3i0S+2IJVgEIaAUqsbcDbxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959364; c=relaxed/simple;
	bh=rX4+5bu2PZZ9SUBwzZ8uhPmAteJnql3vA02pjPtir7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pil1eP+28zguls5icskySvx3fe5Y9KbWdDXsNRtRlDlTqGTVel5a6dVeqnqFPUDvGk668tKpNUjo2urfqiXCDibj1v0b+fdap0aQTRMlTeZN68RtqwhWLwHg2Bj0N9BH2l7qJsYOaq9BLwDqWi4hrEZmkzATmsG2HBIIKa2OwOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbW0gtV5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so5031095e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959361; x=1754564161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9Xf/zncsK0C6ZDulQirQipsNhzEPIaovYvVkcMe4d0=;
        b=ZbW0gtV5IuSnv3auHfFvZ0DjiH4yATevigbC5d606R6Zzk6tsJjnduy6jzbwMl1+eu
         Ru0Y9//c3jz28uWRUDK6X1wPPNaRucJHfzxQjsqroMXqvkE7wcl24R4j9kkKk1vmSytM
         n98FqTailYQRQh3FvfG5bOfzj1C6LziDBaq+MDSr38NaYWlxNo/xv9uMEISAxSjUn/6F
         IqzAFeDUCT6zE0Lq8/eyC+Mn2TlzjA+VZOoZnR9I8f84Ru+wOULwmjwhetbcQcEiI63A
         SVY5IuMkw4/9g4cUDKF4Pj+8c6NkWkoMU+QzF/DRWDVIPltVfgDKDYvRHU9/R+KH5qGS
         dY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959361; x=1754564161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9Xf/zncsK0C6ZDulQirQipsNhzEPIaovYvVkcMe4d0=;
        b=tDnZhQKuekJr80xCc1WGghe1LMKmvK94/DllXfBMiNO6Xv6cssPpKZo2mt78dCFOiR
         6rzeBaUkwANYmVXv+Uj/kj3ZwBCZyeBhKN5BnMtM5DKP67YNWBGXbjPWdE5pUhMoPIRD
         l+euM6v8ohblX4TsBt2pR6LSX7w9Keg44qRPwxYO1WkPum+p6M4gdLSJE0GEmX3BwkSD
         t0QK54/d6FQcjngPo3JWmAGHfie/F9A5cI/D+ncWhstpjNnf9aXeAGn1jO9BNNt1/TAB
         RQ4deuT59T1f5UgRjediLJ5qfnlwAM7gyHKwvzTj+V3C8tNeyLkbAs3I3kVq3Ps59d5r
         PXvQ==
X-Gm-Message-State: AOJu0Yyq3jSMQpT4Ki8fvl+HJaAdaYhxYWUOLH3Rj5+4GjhjJSQ5W7cA
	Awfq7F5CUyxBhT5m5yl5N27R0WIhMc+hfyFFoWUSRXBS7b6Ae5hr670G
X-Gm-Gg: ASbGncv2qtefY602Rl79MOAaiQtQtkre2eXZXfvoZLzg/CgMRguJUGN6lxFh77yPx/W
	AkOqJSaYOC4E0adsIbQC/TDRrmfOfKXaAFBfROfDrKI9GXXj5FzwAVquLeJJgjYkqrch3OCuDZT
	XbaBHKdY7ebuGX9f3iFHzN6qM1hS0IJCTOf679INxroJA5USnKhkFwKaK5HF2iMcNVthrMAkyb4
	Slu/CqTO8/HUAof7WozovVNSIamjF+qByEmbW5MwNWpYu3zTFseg+AES94pt56CIN9LwWxODCgR
	YSkf8Q8qAgojiWHBo9bwSDUWlEYDUmgDXiK3BH3/CyU81MgE22bN+oeos8WaQ6a+268/pxb+ndC
	LG+Zg424LFGX7aMW16sg=
X-Google-Smtp-Source: AGHT+IHf6AKSb9RscPmZGD57JpqKv90J23PCflYXkYWObEj1yT0k2mVVPC0on5btjQdD5EuCvdcOsw==
X-Received: by 2002:a05:600c:4ab0:b0:456:22f8:3aa1 with SMTP id 5b1f17b1804b1-458a1e0c00fmr11349765e9.2.1753959361111;
        Thu, 31 Jul 2025 03:56:01 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:56:00 -0700 (PDT)
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
Subject: [RFC PATCH v2 21/25] sched/rt: add HCBS migration related checks and function calls
Date: Thu, 31 Jul 2025 12:55:39 +0200
Message-ID: <20250731105543.40832-22-yurand2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731105543.40832-1-yurand2000@gmail.com>
References: <20250731105543.40832-1-yurand2000@gmail.com>
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
 kernel/sched/rt.c | 63 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2fdb2657554..677ab9e8aa4 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -865,6 +865,11 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
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
@@ -964,7 +969,10 @@ static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
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
 
@@ -1050,7 +1058,10 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 	if (rq->donor->sched_class != &rt_sched_class)
 		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
-	rt_queue_push_tasks(rq);
+	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && is_dl_group(rt_rq))
+		rt_queue_push_from_group(rq, rt_rq);
+	else
+		rt_queue_push_tasks(rq);
 }
 
 static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
@@ -1113,6 +1124,13 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct task_s
 	 */
 	if (on_rt_rq(&p->rt) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_task(rt_rq, p);
+
+	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && is_dl_group(rt_rq)) {
+		struct sched_dl_entity *dl_se = dl_group_of(rt_rq);
+
+		if (dl_se->dl_throttled)
+			rt_queue_push_from_group(rq, rt_rq);
+	}
 }
 
 /* Only try algorithms three times */
@@ -2174,8 +2192,13 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
 			    (rq->curr->nr_cpus_allowed < 2 ||
 			     rq->donor->prio <= p->prio);
 
-	if (need_to_push)
+	if (!need_to_push)
+		return;
+
+	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && is_dl_group(rt_rq))
 		group_push_rt_tasks(rt_rq);
+	else
+		push_rt_tasks(rq);
 }
 
 /* Assumes rq->lock is held */
@@ -2216,7 +2239,9 @@ static void switched_from_rt(struct rq *rq, struct task_struct *p)
 	if (!task_on_rq_queued(p) || rt_rq->rt_nr_running)
 		return;
 
-	if (!IS_ENABLED(CONFIG_RT_GROUP_SCHED))
+	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && is_dl_group(rt_rq))
+		rt_queue_pull_to_group(rq, rt_rq);
+	else
 		rt_queue_pull_task(rq);
 }
 
@@ -2243,6 +2268,13 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
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
 
@@ -2252,17 +2284,14 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 	 * then see if we can move to another run queue.
 	 */
 	if (task_on_rq_queued(p)) {
-
-#ifndef CONFIG_RT_GROUP_SCHED
-		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
+		if (!is_dl_group(rt_rq_of_se(&p->rt)) && p->nr_cpus_allowed > 1 && rq->rt.overloaded) {
 			rt_queue_push_tasks(rq);
-#else
-		if (rt_rq_of_se(&p->rt)->overloaded) {
-		} else {
-			if (p->prio < rq->curr->prio)
-				resched_curr(rq);
+			return;
+		} else if (is_dl_group(rt_rq_of_se(&p->rt)) && rt_rq_of_se(&p->rt)->overloaded) {
+			rt_queue_push_from_group(rq, rt_rq_of_se(&p->rt));
+			return;
 		}
-#endif
+
 		if (p->prio < rq->donor->prio && cpu_online(cpu_of(rq)))
 			resched_curr(rq);
 	}
@@ -2285,8 +2314,12 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * If our priority decreases while running, we
 		 * may need to pull tasks to this runqueue.
 		 */
-		if (!IS_ENABLED(CONFIG_RT_GROUP_SCHED) && oldprio < p->prio)
-			rt_queue_pull_task(rq);
+		if (oldprio < p->prio) {
+			if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && is_dl_group(rt_rq))
+				rt_queue_pull_to_group(rq, rt_rq);
+			else
+				rt_queue_pull_task(rq);
+		}
 
 		/*
 		 * If there's a higher priority task waiting to run
-- 
2.50.1


