Return-Path: <linux-kernel+bounces-751978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA677B16FF8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA5A54581C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775E92D2389;
	Thu, 31 Jul 2025 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXR5acCe"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523C92C3745
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959363; cv=none; b=GWIIt/N6gLttPznfhDobIBTK75mNBeh81QAt1OrhctX4Q7S/BAng1EOJdxr6BkZNkzXmxeewoZyqHvXQKNUnLI4gNIHFO75/pS2TdtD9YjDc/21qCT2MjbMT5PolKbAlPqeZhfNLwmNLid6hbuIznsn0zvVpGUYM4SqUf/thsl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959363; c=relaxed/simple;
	bh=6zRKlwo23+6u56UEk2LaVGEisTYGXjm0mm3VKe7EI3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pV41ii1/JGOWvAgPmDU34gFoqKLQzuXAFWVF6UQFQYfIWVuFSuKZ4DZ12vH8WJ/2Wil+hWdF6vW7aUe/mNrC0BeBgBRjhV7rquil1KDYuCv3KNe2448/lAfmHVHnt7du6ZI4jexOJLjWRdj9CE1CH4c9yO8C5y4Yla9QQUO0F5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXR5acCe; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b783ea502eso514353f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959360; x=1754564160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/Dh5Zhhr5dqENgdMbOY1ekMDiju3H1epGU1a1pN8No=;
        b=cXR5acCejyqI5A1/A3YsttxGzcUXaZ5T7qO2fBOemye0EcOdcfQm2GPWfNnzh10a9R
         q88GDUecqnIWlfTwuL2mwRhhwTBUYVQXS2JaWqmi4YWszoHurxqMqtfWlb2kYFkN1t/7
         fFgQC5udX7s6zeAR1eKrel2oeJZFpx7y2gY9j/dPuc+q0j38ni+tAsFyQX077fxL3AsC
         9NR0OER0a9l/qLSCL6aJctcSMytgYvG6vKqOfjnwUcTP+Sj9Uegs3XU8DAFFox36TVUy
         +momvr72uscu8IKxacfVO5fehnD6La0qRPz9HU+e6QS58W0BEGY5CCy/1UUaM2FBoqf3
         Z2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959360; x=1754564160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/Dh5Zhhr5dqENgdMbOY1ekMDiju3H1epGU1a1pN8No=;
        b=M0AnqZ+MoH0DweFsb2yELRF5Uw6c8C2lg/7JOQ5+5DS7MK/8Z2HeC+jHt68ejnjWm9
         kAc/5tnS75XuPYRu2PEK6p6S30HTcxiK1P6PnpTXRdXSkgxna+HnAegkuSywg56IQcYI
         FQdeCTyDA7V6UVJNTnJm81Dftchj5M51Wq2MnQhpyoa86gKSLu/RFrIkXrs5pzVXoGYn
         m6sE85JvlXeAeEe2YEMQS94PUO+jaA+BF4J91Sx2W2lO3gaK7j9PFpOzecVNw6Wp5UdQ
         dlUcIuBiKkM37IdOTf/AT3gCD4sR3sJONCGBw2UWCk1U8ZxvyGeCTH1bNAnKDG3rIe+y
         mDxg==
X-Gm-Message-State: AOJu0YyG8G42JSEgKSSmLKp1ZQAewpMielAuiwWLkuESgQRbcZMb0Avi
	QY7AejfIcOdgn5XuNe/rH+5gYy8WqsjT0PpLv4I+MkybRU1u/AHZuw8p7svZ2w56uNc=
X-Gm-Gg: ASbGncsrFn4KyVqEDg1O0G47Nsy0WQg2JsAfIiJfZIddbhuii1eiqn8gVYqF+POQjm2
	rl6944YgoKaj/MeUpOrbfsOqxXqq+DJkFNc5ze7B1Y4ZyKgwDtvUL3PaNz751wFC/qMCtWWH+EO
	LaDfKO6nq2tFZwg9Vwwr8vJU0vQvwqufW20JgmcQqXTUX79pjDl1iLdTOnt6CUM03J7hQbMZbbt
	+LZy7oHWjfFtYgwmhv26+GhP2sHjFkDbtag6oNTuVIkqwFpQ6GmFdpqFKUK3GdOjYxbQYl+9e1C
	yqJ9o2+L8RGIZQajNJOVNCQocee6G1fePyXMD01+yquT39Rd5J5VVLFzHJb5R5WCZo1Ajeq03tC
	T6hsxrzezXt+CCoFlR88=
X-Google-Smtp-Source: AGHT+IHKpVdt0z1whnjQjXu62SKd40EHF2IK97jOX0EYjMV2OcCVC9XEWf8Tq59R2n3+AwYknba3aQ==
X-Received: by 2002:a05:6000:144a:b0:3b7:931d:37a0 with SMTP id ffacd0b85a97d-3b79d43cd5bmr1391052f8f.9.1753959359552;
        Thu, 31 Jul 2025 03:55:59 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:55:59 -0700 (PDT)
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
Subject: [RFC PATCH v2 19/25] sched/deadline: Allow deeper hierarchies of RT cgroups
Date: Thu, 31 Jul 2025 12:55:37 +0200
Message-ID: <20250731105543.40832-20-yurand2000@gmail.com>
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
 kernel/sched/rt.c       | 25 +++++++++++++++++---
 kernel/sched/sched.h    |  2 +-
 4 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3ac65c6af70..eb9de8c7b1f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9277,12 +9277,6 @@ cpu_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
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
index 7b131630743..e263abcdc04 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -406,11 +406,42 @@ int dl_check_tg(unsigned long total)
 	return 1;
 }
 
-void dl_init_tg(struct sched_dl_entity *dl_se, u64 rt_runtime, u64 rt_period)
+static inline bool is_active_sched_group(struct task_group *tg)
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
@@ -418,8 +449,10 @@ void dl_init_tg(struct sched_dl_entity *dl_se, u64 rt_runtime, u64 rt_period)
 	update_rq_clock(rq);
 	dl_server_stop(dl_se);
 
+	old_runtime = dl_se->dl_runtime;
 	new_bw = to_ratio(dl_se->dl_period, dl_se->dl_runtime);
-	dl_rq_change_utilization(rq, dl_se, new_bw);
+	if (is_active_group)
+		dl_rq_change_utilization(rq, dl_se, new_bw);
 
 	dl_se->dl_runtime  = rt_runtime;
 	dl_se->dl_deadline = rt_period;
@@ -431,6 +464,16 @@ void dl_init_tg(struct sched_dl_entity *dl_se, u64 rt_runtime, u64 rt_period)
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
index 75a6860c2e2..29b51251fdc 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -107,7 +107,8 @@ void free_rt_sched_group(struct task_group *tg)
 			 * Fix this issue by changing the group runtime
 			 * to 0 immediately before freeing it.
 			 */
-			dl_init_tg(tg->dl_se[i], 0, tg->dl_se[i]->dl_period);
+			if (tg->dl_se[i]->dl_runtime)
+				dl_init_tg(tg, i, 0, tg->dl_se[i]->dl_period);
 			raw_spin_rq_lock_irqsave(cpu_rq(i), flags);
 			BUG_ON(tg->rt_rq[i]->rt_nr_running);
 			raw_spin_rq_unlock_irqrestore(cpu_rq(i), flags);
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
@@ -2208,6 +2217,9 @@ static int sched_rt_global_constraints(void)
 
 int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk)
 {
+	struct task_group *child;
+	int can_attach = 1;
+
 	/* Allow executing in the root cgroup regardless of allowed bandwidth */
 	if (tg == &root_task_group)
 		return 1;
@@ -2216,7 +2228,14 @@ int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk)
 	if (rt_group_sched_enabled() && tg->dl_bandwidth.dl_runtime == 0)
 		return 0;
 
-	return 1;
+	/* If one of the children has runtime > 0, cannot attach RT tasks! */
+	list_for_each_entry_rcu(child, &tg->children, siblings) {
+		if (child->dl_bandwidth.dl_runtime) {
+			can_attach = 0;
+		}
+	}
+
+	return can_attach;
 }
 
 #else /* !CONFIG_RT_GROUP_SCHED: */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4a1bbda3720..3dd2ede6d35 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -386,7 +386,7 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq,
 		    dl_server_pick_f pick_task);
 extern void sched_init_dl_servers(void);
 extern int dl_check_tg(unsigned long total);
-extern void dl_init_tg(struct sched_dl_entity *dl_se, u64 rt_runtime, u64 rt_period);
+extern void dl_init_tg(struct task_group *tg, int cpu, u64 rt_runtime, u64 rt_period);
 
 extern void dl_server_update_idle_time(struct rq *rq,
 		    struct task_struct *p);
-- 
2.50.1


