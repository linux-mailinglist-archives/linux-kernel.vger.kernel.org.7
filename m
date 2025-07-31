Return-Path: <linux-kernel+bounces-751973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F648B16FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DF177AFF5B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E62F2C3259;
	Thu, 31 Jul 2025 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjPVzWS7"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE532C1581
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959359; cv=none; b=u9qFVwhYN4XWjTpq3ZMd28qjzG5XhzMP8H+eROk/fMI8TTaeuXRy4/X5nirzIk8a4z63jy3QrU84SumKpaISaiN5hGXdML+mp7T0D36T7XunbV+9TcrX2hNHeNH/BDnFhPmfS+2QgJpzFowqWX97osSOok2nfDo/RhjBV/3+xdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959359; c=relaxed/simple;
	bh=xO0PgRp2TDyPC9ly5AjN8AEQNEsBUUHcZB6gNAbif/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdPb2WdygR5rWZF25BiakRZrRgTuxCVwEfZvYF1MaBeUac4Lglfjf7LO2Dz+qml29O/k303G6bfH0GYMQlpBKClDMpMivmIWkdwp2H6d0gvn1kUO9uyZtoi4brS2JvevYvmz/0q9sVs4NKs7+YgyWS72qfQ2Z/rVmRrVUcNUbm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjPVzWS7; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b7848df30cso1103901f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959356; x=1754564156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPD4AKGlLYy7ld0yhNWiLxKSPOb9hAQPD23s+30e4P8=;
        b=TjPVzWS7ie/+QT/O/Vpk2hIIuTfr9TGJHWC4hGvE6YH7Jp5oyrBFZD15VwvmFzlW7Q
         18ydfnhop3itwVNQLod6QT5zaPi8wp7slijUIA2L9m8PLg7V9EMxESqBv7NLHVH+Nuyp
         fOYfhCS0xBEOaq5adnMpls54MI1vl0kZ+8bICB2vMYZV6NiQS77OSbegAum3gw6ckRap
         FNdzxJXqCslMQsHgBt9UzhgIAr/FjH1dxNemnJpZzMfyIuezjvJd6/FtWOcwDT0RaXig
         u08+LV172H/0l3kv3PBiEOZTzyTvD8SyvXC1SkfpC5ssdWbtQnERxKrjzXKw4PnlI4lS
         e5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959356; x=1754564156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPD4AKGlLYy7ld0yhNWiLxKSPOb9hAQPD23s+30e4P8=;
        b=hfUrAxHrr/9zJ/ZzT5LeVJMpyGTS0uqqH7Hndl3pNGVK2/jPK1hM7AoNBhNFf9WhUE
         HrWmK89b1LQ/VfwMGG7Bi1j0tiQ8H7vyJLCfi7TkFKm6NVKu8aTV6BqirMobd6oFxEQc
         T+i1SbS2YhtGpUQed8lmJuVbeNGudMGrq4X8kmNoRqhSxNf05PohpARu8Hab4IsP3MBm
         cRtNdDmnMLUzzFIk7Kk8qNpXOHq/g8a2h5+zGTHnrI84jEfuxrUv/8D4qiMir/2qd42V
         R8YscC3nwfojv3X9prvThozf16QTtJkOWRB9MKCBXfsXembxTjB8GKcUQ/OrKe43NKsc
         ITfQ==
X-Gm-Message-State: AOJu0YxPTtjHWnTvjANElAnkU3Zk2jzZe+tAk6VgXKEcXsWZMIQmcMZP
	w5AOyHknBRLTNK1m//BuBq7BudItYVkyJcCHOkLJQGZykkWj7nvCEjeY
X-Gm-Gg: ASbGncs5CXjRo0MmF5NAOQ+DKRaXT7GYVh28EiCFY/d9xv6Dl1Ls6+sKk2QvEgBT9cE
	5nhx7Dci4XNnp2eEx1o6nINIwDo3lp9O8W+8yrth9JNy/SHhBkGP4+fFgGubacFC8bbesiS/BxH
	Ms0jO6OnBAVTinM0fMR/hxuTjkPkVuEzcrzLGFd7pft/PCXEPSZz3tnOrm8O2aJCPcXULisAY0b
	RKp/1XOpxt7g3WKaS4IZxQe0kyoknbyjYqXWAkYcefS4TPMqd95uleeM37UTnmCCGpsTRexzivW
	B+TxuOOdADRLYiO5mkAcLkPmWM/og2DL6f/4dHIFuKWpkkwQTEefIYFbA3DWbmnX7rCStXbTxOx
	DVPXQATrGd/RdOhSEwVE=
X-Google-Smtp-Source: AGHT+IGkctD7bV3W9py+qBKbrRx/gABjDK9obtz5h/vD52b8y7fAtV43jnezdQfMHn1arsNgvR+OYA==
X-Received: by 2002:a5d:5f4c:0:b0:3a5:281b:9fac with SMTP id ffacd0b85a97d-3b79d4b4f0dmr827056f8f.17.1753959355678;
        Thu, 31 Jul 2025 03:55:55 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:55:55 -0700 (PDT)
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
Subject: [RFC PATCH v2 14/25] sched/rt: Update rt-cgroup schedulability checks
Date: Thu, 31 Jul 2025 12:55:32 +0200
Message-ID: <20250731105543.40832-15-yurand2000@gmail.com>
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

Update schedulability checks and setup of runtime/period for rt-cgroups.

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 kernel/sched/core.c     |  6 ++++
 kernel/sched/deadline.c | 46 ++++++++++++++++++++++----
 kernel/sched/rt.c       | 72 +++++++++++++++++++++++------------------
 kernel/sched/sched.h    |  1 +
 4 files changed, 88 insertions(+), 37 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6173684a02b..63cb9271052 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9277,6 +9277,12 @@ cpu_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		return &root_task_group.css;
 	}
 
+	/* Do not allow cpu_cgroup hierachies with depth greater than 2. */
+#ifdef CONFIG_RT_GROUP_SCHED
+	if (parent != &root_task_group)
+		return ERR_PTR(-EINVAL);
+#endif
+
 	tg = sched_create_group(parent);
 	if (IS_ERR(tg))
 		return ERR_PTR(-ENOMEM);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b948000f29f..7b131630743 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -365,7 +365,47 @@ void cancel_inactive_timer(struct sched_dl_entity *dl_se)
 	cancel_dl_timer(dl_se, &dl_se->inactive_timer);
 }
 
+/*
+ * Used for dl_bw check and update, used under sched_rt_handler()::mutex and
+ * sched_domains_mutex.
+ */
+u64 dl_cookie;
+
 #ifdef CONFIG_RT_GROUP_SCHED
+int dl_check_tg(unsigned long total)
+{
+	unsigned long flags;
+	int which_cpu;
+	int cpus;
+	struct dl_bw *dl_b;
+	u64 gen = ++dl_cookie;
+
+	for_each_possible_cpu(which_cpu) {
+		rcu_read_lock_sched();
+
+		if (!dl_bw_visited(which_cpu, gen)) {
+			cpus = dl_bw_cpus(which_cpu);
+			dl_b = dl_bw_of(which_cpu);
+
+			raw_spin_lock_irqsave(&dl_b->lock, flags);
+
+			if (dl_b->bw != -1 &&
+			    dl_b->bw * cpus < dl_b->total_bw + total * cpus) {
+				raw_spin_unlock_irqrestore(&dl_b->lock, flags);
+				rcu_read_unlock_sched();
+
+				return 0;
+			}
+
+			raw_spin_unlock_irqrestore(&dl_b->lock, flags);
+		}
+
+		rcu_read_unlock_sched();
+	}
+
+	return 1;
+}
+
 void dl_init_tg(struct sched_dl_entity *dl_se, u64 rt_runtime, u64 rt_period)
 {
 	struct rq *rq = container_of(dl_se->dl_rq, struct rq, dl);
@@ -3139,12 +3179,6 @@ DEFINE_SCHED_CLASS(dl) = {
 #endif
 };
 
-/*
- * Used for dl_bw check and update, used under sched_rt_handler()::mutex and
- * sched_domains_mutex.
- */
-u64 dl_cookie;
-
 int sched_dl_global_validate(void)
 {
 	u64 runtime = global_rt_runtime();
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 83695e11db4..bd11f4a03f7 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1996,11 +1996,6 @@ DEFINE_SCHED_CLASS(rt) = {
 };
 
 #ifdef CONFIG_RT_GROUP_SCHED
-/*
- * Ensure that the real time constraints are schedulable.
- */
-static DEFINE_MUTEX(rt_constraints_mutex);
-
 static inline int tg_has_rt_tasks(struct task_group *tg)
 {
 	struct task_struct *task;
@@ -2034,8 +2029,8 @@ static int tg_rt_schedulable(struct task_group *tg, void *data)
 	unsigned long total, sum = 0;
 	u64 period, runtime;
 
-	period = ktime_to_ns(tg->rt_bandwidth.rt_period);
-	runtime = tg->rt_bandwidth.rt_runtime;
+	period  = tg->dl_bandwidth.dl_period;
+	runtime = tg->dl_bandwidth.dl_runtime;
 
 	if (tg == d->tg) {
 		period = d->rt_period;
@@ -2051,8 +2046,7 @@ static int tg_rt_schedulable(struct task_group *tg, void *data)
 	/*
 	 * Ensure we don't starve existing RT tasks if runtime turns zero.
 	 */
-	if (rt_bandwidth_enabled() && !runtime &&
-	    tg->rt_bandwidth.rt_runtime && tg_has_rt_tasks(tg))
+	if (dl_bandwidth_enabled() && !runtime && tg_has_rt_tasks(tg))
 		return -EBUSY;
 
 	if (WARN_ON(!rt_group_sched_enabled() && tg != &root_task_group))
@@ -2066,12 +2060,17 @@ static int tg_rt_schedulable(struct task_group *tg, void *data)
 	if (total > to_ratio(global_rt_period(), global_rt_runtime()))
 		return -EINVAL;
 
+	if (tg == &root_task_group) {
+		if (!dl_check_tg(total))
+			return -EBUSY;
+	}
+
 	/*
 	 * The sum of our children's runtime should not exceed our own.
 	 */
 	list_for_each_entry_rcu(child, &tg->children, siblings) {
-		period = ktime_to_ns(child->rt_bandwidth.rt_period);
-		runtime = child->rt_bandwidth.rt_runtime;
+		period  = child->dl_bandwidth.dl_period;
+		runtime = child->dl_bandwidth.dl_runtime;
 
 		if (child == d->tg) {
 			period = d->rt_period;
@@ -2097,6 +2096,20 @@ static int __rt_schedulable(struct task_group *tg, u64 period, u64 runtime)
 		.rt_runtime = runtime,
 	};
 
+	/*
+	* Since we truncate DL_SCALE bits, make sure we're at least
+	* that big.
+	*/
+	if (runtime != 0 && runtime < (1ULL << DL_SCALE))
+		return -EINVAL;
+
+	/*
+	* Since we use the MSB for wrap-around and sign issues, make
+	* sure it's not set (mind that period can be equal to zero).
+	*/
+	if (period & (1ULL << 63))
+		return -EINVAL;
+
 	rcu_read_lock();
 	ret = walk_tg_tree(tg_rt_schedulable, tg_nop, &data);
 	rcu_read_unlock();
@@ -2107,6 +2120,7 @@ static int __rt_schedulable(struct task_group *tg, u64 period, u64 runtime)
 static int tg_set_rt_bandwidth(struct task_group *tg,
 		u64 rt_period, u64 rt_runtime)
 {
+	static DEFINE_MUTEX(rt_constraints_mutex);
 	int i, err = 0;
 
 	/*
@@ -2126,34 +2140,30 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
 	if (rt_runtime != RUNTIME_INF && rt_runtime > max_rt_runtime)
 		return -EINVAL;
 
-	mutex_lock(&rt_constraints_mutex);
+	guard(mutex)(&rt_constraints_mutex);
 	err = __rt_schedulable(tg, rt_period, rt_runtime);
 	if (err)
-		goto unlock;
+		return err;
 
-	raw_spin_lock_irq(&tg->rt_bandwidth.rt_runtime_lock);
-	tg->rt_bandwidth.rt_period = ns_to_ktime(rt_period);
-	tg->rt_bandwidth.rt_runtime = rt_runtime;
+	guard(raw_spinlock_irq)(&tg->dl_bandwidth.dl_runtime_lock);
+	tg->dl_bandwidth.dl_period  = rt_period;
+	tg->dl_bandwidth.dl_runtime = rt_runtime;
 
-	for_each_possible_cpu(i) {
-		struct rt_rq *rt_rq = tg->rt_rq[i];
+	if (tg == &root_task_group)
+		return 0;
 
-		raw_spin_lock(&rt_rq->rt_runtime_lock);
-		rt_rq->rt_runtime = rt_runtime;
-		raw_spin_unlock(&rt_rq->rt_runtime_lock);
+	for_each_possible_cpu(i) {
+		dl_init_tg(tg->dl_se[i], rt_runtime, rt_period);
 	}
-	raw_spin_unlock_irq(&tg->rt_bandwidth.rt_runtime_lock);
-unlock:
-	mutex_unlock(&rt_constraints_mutex);
 
-	return err;
+	return 0;
 }
 
 int sched_group_set_rt_runtime(struct task_group *tg, long rt_runtime_us)
 {
 	u64 rt_runtime, rt_period;
 
-	rt_period = ktime_to_ns(tg->rt_bandwidth.rt_period);
+	rt_period  = tg->dl_bandwidth.dl_period;
 	rt_runtime = (u64)rt_runtime_us * NSEC_PER_USEC;
 	if (rt_runtime_us < 0)
 		rt_runtime = RUNTIME_INF;
@@ -2167,10 +2177,10 @@ long sched_group_rt_runtime(struct task_group *tg)
 {
 	u64 rt_runtime_us;
 
-	if (tg->rt_bandwidth.rt_runtime == RUNTIME_INF)
+	if (tg->dl_bandwidth.dl_runtime == RUNTIME_INF)
 		return -1;
 
-	rt_runtime_us = tg->rt_bandwidth.rt_runtime;
+	rt_runtime_us = tg->dl_bandwidth.dl_runtime;
 	do_div(rt_runtime_us, NSEC_PER_USEC);
 	return rt_runtime_us;
 }
@@ -2183,7 +2193,7 @@ int sched_group_set_rt_period(struct task_group *tg, u64 rt_period_us)
 		return -EINVAL;
 
 	rt_period = rt_period_us * NSEC_PER_USEC;
-	rt_runtime = tg->rt_bandwidth.rt_runtime;
+	rt_runtime = tg->dl_bandwidth.dl_runtime;
 
 	return tg_set_rt_bandwidth(tg, rt_period, rt_runtime);
 }
@@ -2192,7 +2202,7 @@ long sched_group_rt_period(struct task_group *tg)
 {
 	u64 rt_period_us;
 
-	rt_period_us = ktime_to_ns(tg->rt_bandwidth.rt_period);
+	rt_period_us = tg->dl_bandwidth.dl_period;
 	do_div(rt_period_us, NSEC_PER_USEC);
 	return rt_period_us;
 }
@@ -2207,7 +2217,7 @@ static int sched_rt_global_constraints(void)
 int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk)
 {
 	/* Don't accept real-time tasks when there is no way for them to run */
-	if (rt_group_sched_enabled() && rt_task(tsk) && tg->rt_bandwidth.rt_runtime == 0)
+	if (rt_group_sched_enabled() && rt_task(tsk) && tg->dl_bandwidth.dl_runtime == 0)
 		return 0;
 
 	return 1;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8bf8af7064f..9f235df4bf1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -394,6 +394,7 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq,
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick_task);
 extern void sched_init_dl_servers(void);
+extern int dl_check_tg(unsigned long total);
 extern void dl_init_tg(struct sched_dl_entity *dl_se, u64 rt_runtime, u64 rt_period);
 
 extern void dl_server_update_idle_time(struct rq *rq,
-- 
2.50.1


