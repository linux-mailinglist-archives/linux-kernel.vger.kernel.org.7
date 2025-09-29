Return-Path: <linux-kernel+bounces-836032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B42BA8987
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BE31888294
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0F32D3220;
	Mon, 29 Sep 2025 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjReApQJ"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBEA28750B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137761; cv=none; b=Qs3saml5vSmIPb+FBlqbQlBfcTVp2b5UYrdx0YKId+We8fL5Xy3lejEW1iaTZAa8wD35o+k5x7WhFFGj3pVSHfpt1LHUdgQV/FQMNUDCITsAfjMLOw+BuvoZH30h2zGzvh6OfJOOIdsdFUkooN0/nH1JY9GWvHJyNP9/B+l3OWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137761; c=relaxed/simple;
	bh=SX06KYe3UfsMlxi07fSgKyO3jk3XpncC2n0/cGMfWZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzvhzPJ0h3uA0VQa9AfQbtMuZUlZsh6HFSaUCskJfG3dTDVjFdS1hJsxMTwCp+gZhxxR0LdVSJdiYntP6Q25Ioc3RabCiFCAAF6GkNWqemUnt7uumjGPcegfKnhil+RFZvaVldl3D/2lmi6GMcfA8qi4c8X3vhM2KapnFCBJeL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjReApQJ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so290499366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137757; x=1759742557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCB7d9ViC9MONweDSs0QerFusX73MoEMEy3T8nwoQ+g=;
        b=EjReApQJettja88f2/BNpa/4+T6MKX5c3VGgzNC9frhfmImCuGukZzDGoEyg7vrz5U
         WQXiWmdZowfMAKhOx1f/ncPQmSvE3moahDs57+1zqcTRRP1GQZJtO56mDTk472yk8Dir
         CyVyJmG2WCskA1bdEZz7Px8b9dxYMyhI8Hu7rPnJS8Q6YCgjBSjbpSKIQZYh09JQTlpk
         baRvoRh6o3FWeUGtoALdUcUctrlfr5iLCQpurBux7w0Im8/IOrjJxouCCiCCyCJBplfF
         0Qs8LjwohPu/aKjoCQ0f36eXsjLHxtz3ZAx2PGaiqC6+8tVmvQqKU1NoWO1oOfX0qEDI
         W3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137757; x=1759742557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCB7d9ViC9MONweDSs0QerFusX73MoEMEy3T8nwoQ+g=;
        b=RK6MKmCfbv3Q3TVOIeXIA5zIgW7dvn15QhDtx67ek/IDl0kt/1CiH/udsDz/gYIwXV
         MP+BnlFzzS2uZDOZAUPD9m7ikOvW5rWA0uKV7ab76B1FYeBL5284dgPdQXe/b2Gf0rAL
         W7N8cJte4c1X6OZuEGAd1HbyVysePfWYbwrzB/v4LwueMqkUu0MgLhyRUoyM/Ojc+5Z+
         Rqx9TikZh7cFyGx0MhLavKzLVOg5DblRXMPq+SHNWc3Xz6asOgL9m2Fuqx7iqgeIa4lb
         yHhHv7TvhnVRkrvjgKgrZtKuak4evxjbMackdxkqRzH6S/fRGWJH2/WQeY+oSHkEkHjj
         r/Ow==
X-Gm-Message-State: AOJu0YycoMN1qV1RpLKjHwpvyIRcRDp7DXKH2X8tPiBhp3nmqrGRmVPK
	AJGIQ85MkcqBaqwrUQ/RXuI1dFPF9fuYe6XGmzYE/7EfLSVf7Rblv8tX
X-Gm-Gg: ASbGncts9WY4SQ+L0mbgiN6LxQhsbA22BrSnh5SyfQVmRP/cBvBxHJB+aPtKYS+bXqN
	oeaLzqJyY1jfu64z3hfEeggXMYaXuDj+BAEAy2Ustq7R3PEIFpF7u5UwFGPYq4aCrtIXXCqBy7w
	nxaVH/ZrEAugT+YtFWAWLkXcW8CJhRSvDEAfhX4vrjUbEdqJIr9+kDUi85vNhHb9ZVPoAX9Vg7J
	e2oDBC/iUsMe7JOrDo+Me3Gksz8HO+uIyfDO4g1pcSWTZNu6NHiUm/vxZcBGaP7kg7DDwfklEBM
	02K1kaBurkQ2hoQhP8jpCAMPCJVqwLuxSiNa38xOIlKfAi0z9rYsSN7Hs3nvgxcM71YGr+gKpBX
	+qAy6FfBjoElEuJ+Zgb8=
X-Google-Smtp-Source: AGHT+IGMktd+ej9fkjLPpg2JFh9TI+04sASGgTJogJZqKRxWN3xpQPwYtvzScBqBiPPBXwaFY/1F2A==
X-Received: by 2002:a17:907:86ab:b0:b04:9854:981f with SMTP id a640c23a62f3a-b34bc96d5femr1786364866b.43.1759137756875;
        Mon, 29 Sep 2025 02:22:36 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:36 -0700 (PDT)
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
Subject: [RFC PATCH v3 18/24] sched/deadline: Allow deeper hierarchies of RT cgroups
Date: Mon, 29 Sep 2025 11:22:15 +0200
Message-ID: <20250929092221.10947-19-yurand2000@gmail.com>
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

Allow creation of cgroup hierachies with depth greater than two.
Add check to prevent attaching tasks to a child cgroup of an active cgroup (i.e.
with a running FIFO/RR task).
Add check to prevent attaching tasks to cgroups which have children with
non-zero runtime.
Update rt-cgroups allocated bandwidth accounting for nested cgroup hierachies.

Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 kernel/sched/core.c     |  6 -----
 kernel/sched/deadline.c | 51 +++++++++++++++++++++++++++++++++++++----
 kernel/sched/rt.c       | 16 ++++++++++---
 kernel/sched/sched.h    |  3 ++-
 4 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6f516cdc7bb..d1d7215c4a2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9281,12 +9281,6 @@ cpu_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		return &root_task_group.css;
 	}
 
-	/* Do not allow cpu_cgroup hierachies with depth greater than 2. */
-#ifdef CONFIG_RT_GROUP_SCHED
-	if (parent != &root_task_group)
-		return ERR_PTR(-EINVAL);
-#endif
-
 	tg = sched_create_group(parent);
 	if (IS_ERR(tg))
 		return ERR_PTR(-ENOMEM);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5d93b3ca030..abe11985c41 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -388,11 +388,42 @@ int dl_check_tg(unsigned long total)
 	return 1;
 }
 
-void dl_init_tg(struct sched_dl_entity *dl_se, u64 rt_runtime, u64 rt_period)
+bool is_active_sched_group(struct task_group *tg)
 {
+	struct task_group *child;
+	bool is_active = 1;
+
+	// if there are no children, this is a leaf group, thus it is active
+	list_for_each_entry_rcu(child, &tg->children, siblings) {
+		if (child->dl_bandwidth.dl_runtime > 0) {
+			is_active = 0;
+		}
+	}
+	return is_active;
+}
+
+static inline bool sched_group_has_active_siblings(struct task_group *tg)
+{
+	struct task_group *child;
+	bool has_active_siblings = 0;
+
+	// if there are no children, this is a leaf group, thus it is active
+	list_for_each_entry_rcu(child, &tg->parent->children, siblings) {
+		if (child != tg && child->dl_bandwidth.dl_runtime > 0) {
+			has_active_siblings = 1;
+		}
+	}
+	return has_active_siblings;
+}
+
+void dl_init_tg(struct task_group *tg, int cpu, u64 rt_runtime, u64 rt_period)
+{
+	struct sched_dl_entity *dl_se = tg->dl_se[cpu];
 	struct rq *rq = container_of(dl_se->dl_rq, struct rq, dl);
-	int is_active;
-	u64 new_bw;
+	int is_active, is_active_group;
+	u64 old_runtime, new_bw;
+
+	is_active_group = is_active_sched_group(tg);
 
 	raw_spin_rq_lock_irq(rq);
 	is_active = dl_se->my_q->rt.rt_nr_running > 0;
@@ -400,8 +431,10 @@ void dl_init_tg(struct sched_dl_entity *dl_se, u64 rt_runtime, u64 rt_period)
 	update_rq_clock(rq);
 	dl_server_stop(dl_se);
 
+	old_runtime = dl_se->dl_runtime;
 	new_bw = to_ratio(dl_se->dl_period, dl_se->dl_runtime);
-	dl_rq_change_utilization(rq, dl_se, new_bw);
+	if (is_active_group)
+		dl_rq_change_utilization(rq, dl_se, new_bw);
 
 	dl_se->dl_runtime  = rt_runtime;
 	dl_se->dl_deadline = rt_period;
@@ -413,6 +446,16 @@ void dl_init_tg(struct sched_dl_entity *dl_se, u64 rt_runtime, u64 rt_period)
 	dl_se->dl_bw = new_bw;
 	dl_se->dl_density = new_bw;
 
+	// add/remove the parent's bw
+	if (tg->parent && tg->parent != &root_task_group)
+	{
+		if (rt_runtime == 0 && old_runtime != 0 && !sched_group_has_active_siblings(tg)) {
+			__add_rq_bw(tg->parent->dl_se[cpu]->dl_bw, dl_se->dl_rq);
+		} else if (rt_runtime != 0 && old_runtime == 0 && !sched_group_has_active_siblings(tg)) {
+			__sub_rq_bw(tg->parent->dl_se[cpu]->dl_bw, dl_se->dl_rq);
+		}
+	}
+
 	if (is_active)
 		dl_server_start(dl_se);
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 1cdc699bbb7..17ad91261cb 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -114,7 +114,8 @@ void free_rt_sched_group(struct task_group *tg)
 		 * Fix this issue by changing the group runtime
 		 * to 0 immediately before freeing it.
 		 */
-		dl_init_tg(tg->dl_se[i], 0, tg->dl_se[i]->dl_period);
+		if (tg->dl_se[i]->dl_runtime)
+			dl_init_tg(tg, i, 0, tg->dl_se[i]->dl_period);
 
 		raw_spin_rq_lock_irqsave(cpu_rq(i), flags);
 		BUG_ON(tg->rt_rq[i]->rt_nr_running);
@@ -2122,6 +2123,14 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
 	static DEFINE_MUTEX(rt_constraints_mutex);
 	int i, err = 0;
 
+	/*
+	 * Do not allow to set a RT runtime > 0 if the parent has RT tasks
+	 * (and is not the root group)
+	 */
+	if (rt_runtime && (tg != &root_task_group) && (tg->parent != &root_task_group) && tg_has_rt_tasks(tg->parent)) {
+		return -EINVAL;
+	}
+
 	/* No period doesn't make any sense. */
 	if (rt_period == 0)
 		return -EINVAL;
@@ -2145,7 +2154,7 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
 		return 0;
 
 	for_each_possible_cpu(i) {
-		dl_init_tg(tg->dl_se[i], rt_runtime, rt_period);
+		dl_init_tg(tg, i, rt_runtime, rt_period);
 	}
 
 	return 0;
@@ -2216,7 +2225,8 @@ int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk)
 	if (rt_group_sched_enabled() && tg->dl_bandwidth.dl_runtime == 0)
 		return 0;
 
-	return 1;
+	/* tasks can be attached only if the taskgroup has no active children. */
+	return (int)is_active_sched_group(tg);
 }
 
 #else /* !CONFIG_RT_GROUP_SCHED: */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fddb171145e..55631d93e02 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -386,7 +386,8 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq,
 		    dl_server_pick_f pick_task);
 extern void sched_init_dl_servers(void);
 extern int dl_check_tg(unsigned long total);
-extern void dl_init_tg(struct sched_dl_entity *dl_se, u64 rt_runtime, u64 rt_period);
+extern void dl_init_tg(struct task_group *tg, int cpu, u64 rt_runtime, u64 rt_period);
+extern bool is_active_sched_group(struct task_group *tg);
 
 extern void dl_server_update_idle_time(struct rq *rq,
 		    struct task_struct *p);
-- 
2.51.0


