Return-Path: <linux-kernel+bounces-836027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B5EBA8978
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29CCA189E04F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571802C032E;
	Mon, 29 Sep 2025 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djD0vZoa"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36102C21E4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137757; cv=none; b=hDVWPUxNkK8l0q01R6ovzG+PKuJnNO8FNff5KheDzwJ9vqal+qKK3KkPHLZ9Vn8R8XlyrCiOGjJh48hF1F6Vtl6tgDkHYZMHyxgaDPwLh9WejrZqQqDsCviQnkuu4SEDSgqeiNIinSoZbYaIWKjqv2euDd/ll6Mpxe6tJ3tM1LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137757; c=relaxed/simple;
	bh=fCqvrO2cKxcNa4ZL1uaDwbPb7ivBVURv4PDyaiKipFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBBk61sCs+h1n9VwRgBr5P6jpm4WUPypD+dOWCsxkQhG5rKuhBQj8hGMM2WDlM8uswzoqIv9TfQd3itebh6SSJ4oYc92uiBNbZFQADmC8jU1erW3zqjrf3gyAdqLJx0C5uGN37MUGnzwLD0BzhykrOMpa9AkVmIecblsgsqksOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djD0vZoa; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3ee18913c0so133097366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137753; x=1759742553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3bcCdHXskWPXk6GtHk1u/zclf51+7VczfN2xDqdC/U=;
        b=djD0vZoayGfg31Fkivq+cwlaAiEvirFgk86ZrXkjrLzl0BG40zuPcq9CNcXmMvjcyy
         5JGyK3whJxMp5xtMqetoRlEBYf0UG+1lQpvCwH4c93wkbuSiB44zPWCE3Lml8g0bhwLS
         /rHxFuhgTl8Tk54LCQl2iTMqw+WrqEGOlc0kDSyEn0x3wmmtMwKax+xlVLRWsjQfEJ/0
         H/aTw7vjMAiNCWXwWM5LDqLhJkfee8KAME2hnNCzRkgWU9KdWJJMGSFG81VzN9hgQ8jp
         Kg94CYQ+PsCkS8sWtguiIhu+3MKT1Z3mVBQT41NhlnA+ZH3OENM7QKST+fyspuwWgGQQ
         5R2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137753; x=1759742553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3bcCdHXskWPXk6GtHk1u/zclf51+7VczfN2xDqdC/U=;
        b=UUACrP+blu5+MBKZkH6c98jkb85gZzmU/23bRdrydUj8gNSBOjmj2Rc/XD2bYrUa30
         GzRliPj5G2G7WJ133IqwZ/0ZYjMollg/RaFH+0mJjBnsofNSa8E26metKD0ce9hCYfxf
         8ZOOZ426nlMGWJQlwJhLnvCdTqoP8gDsg8jWmvouRKDJOAW8h1qCuChCGxhlMy8d0FfM
         d9LzfiE2N7dFY0LWJPAaRZooxCBMNRjgJ5OMemJbmdMoNQeZYJ+Docav4hhDaxI/8P5b
         dMtjkUShA6faFukD32S0SChQU6EmE6kJekECi42997ywRs7fwd7sd4LrSVULXMDHzO1U
         m/BA==
X-Gm-Message-State: AOJu0YyYxtWQMd+tT2mu9UggSjJNFdLgVG5gk2SGuJDmH334Sg6XBeOG
	uu7whbdZcTOCqEseXr3o7aoCU64acfacTYTOle9yWFC3QGsoa6KM+llG
X-Gm-Gg: ASbGncv9fAWmCHiYrNwKRqcQQfhg69E685G8E6TnkF4Wr+k7pOpswaK+HWDVmeOB+qk
	viVzP0tzd3zZBpeLjfqNOp6O9qDS88krRAu4PBLX6Viambu5cNauCiYK2p/vu1lXDTWPCvcqjnb
	XuA+ub/SIvXKz6K9lJ9vZOI0hOwd5ipMOUIC8Tr9/buB0vaLX9qiqOy4DKidNH97mSBhJMLIaTY
	cx5r48pm611vRCsUGYzbJL4M6DBSvGAjslotpI34DD0hHNCzim1jSip4b6SvwVzF6X+aRkAYEht
	pmyWRYBFtb4j18kDd+WYoeiJrv3x7tLP30JlOvmxveXWWaMePwtewMVeHlogPy5/Nb5T5E0YdEF
	FEdIQdq/6wRHT9S7hGUydvGBauDm7QQ==
X-Google-Smtp-Source: AGHT+IEn9FStZky34j+Urt4Ym2Wku9Rm+dkOnekNRZ2Xd7o7lJC2WWohqOTd5aQpvF0vQfr4muGSgw==
X-Received: by 2002:a17:907:1c95:b0:b2b:c145:ab8f with SMTP id a640c23a62f3a-b34bdd13351mr1338977966b.65.1759137753142;
        Mon, 29 Sep 2025 02:22:33 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:32 -0700 (PDT)
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
Subject: [RFC PATCH v3 13/24] sched/rt: Update rt-cgroup schedulability checks
Date: Mon, 29 Sep 2025 11:22:10 +0200
Message-ID: <20250929092221.10947-14-yurand2000@gmail.com>
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
 kernel/sched/deadline.c | 46 +++++++++++++++++++++++----
 kernel/sched/rt.c       | 70 +++++++++++++++++++++++------------------
 kernel/sched/sched.h    |  1 +
 4 files changed, 87 insertions(+), 36 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2cfbe3b7b17..1217f714dd2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9281,6 +9281,12 @@ cpu_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
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
index 1293b9a252b..5d93b3ca030 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -347,7 +347,47 @@ void cancel_inactive_timer(struct sched_dl_entity *dl_se)
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
@@ -3153,12 +3193,6 @@ DEFINE_SCHED_CLASS(dl) = {
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
index ce114823fe7..7c7622303e8 100644
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
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b2c87541257..97e1e779df9 100644
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
2.51.0


