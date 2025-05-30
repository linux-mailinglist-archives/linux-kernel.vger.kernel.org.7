Return-Path: <linux-kernel+bounces-667883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E220AC8AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 11:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C6B1898981
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 09:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9A22288F7;
	Fri, 30 May 2025 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="R9FVY4LF"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2757522170B
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597586; cv=none; b=TKOZOJn26rLUJ1Xyt9nhdi8SzGvoG4C3WRUlP6B3gKNdyWCKGv5SOkaaQGkjf4RZv78/msIxV4j+WGLmZGOgB9YauK1fBcCWQsdhgO4/O/hPci9uNVqLb4iXnBPbVeeIYJlTOgj4VQbGArF/XaOSqYDJTmzpXXajD3UwW+GJ4pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597586; c=relaxed/simple;
	bh=eF1gU64raWj5Emit2P3crNbm/xRze6gEOQkFioffxcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FnJdftun2OGJQ7BddFXxFkimTgoV6RIUt7xmgaej5KtCwPwkP9vuwJi4KUppmt1OhxVk8CbWb76uZapYdZlpIynd0XFf1/xUVHZNDaFcypLLCpIxPQUfJPPmHsQSvGnwtNr5Fyd+gBcLX94lnlJH0qxQJ56m+svdToyhYkWY/oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=R9FVY4LF; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3081f72c271so1408383a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 02:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597583; x=1749202383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlxrRjV8tJmbvpYFl1bSrUikb+IFpVRg2V1s2EQ5voc=;
        b=R9FVY4LF1Zrf/Gp3vENFInTrH6itORQS+OA1/+RoJ+ucGi05UAckNOWotomOVQctzl
         zG7AWofEo4WqwFTlXq50CKPfhYItqxmTicTdRO5SWw7ohYdp02PlQddlnla1xotDbo+W
         CeGfj86h1fo4ZKax11DGGNo6+4KLAOifBpSNtrGAhViBoHwkYhwKN+P6DijMC57AyoWK
         GghgOqvu8A54AzXTqf1gxGTET8iBpxpIArrUZVZSqr51J1pjrGa950Ba6pib26pYu7LB
         KugC80k8QvQRYrihDIhMSHDZFF4VnXJUR+siVu2gcstIfhNNC6smd4Ra1/VHIMj1J1r+
         HGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597583; x=1749202383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlxrRjV8tJmbvpYFl1bSrUikb+IFpVRg2V1s2EQ5voc=;
        b=ZL/V7nulTRP1vti1ugRPkqwT8dod9EpA+XP6JxF5X7G9t0YYHDYBUwoK2qClpNeSLw
         5kw8QN9ASWOOWh8uQpz12+ZH1H+QJ1rScCeinI5w+0zzsxAeqGYoCEZdk7wU+VgaeBmC
         a9nmj4UbssZPhbHXbKgKdPP0k8213Fg23VH1mZRnN2a+t8LJ7CkPc9F46ijiRkaK6qGs
         9DUe3IKiJ6fh++XE6+UP119xK24F+P7TYW4eUOtaOmTKApwtYVOI+yAf29IH5esenKZu
         vZVci5RUjFKDWbIpLsCjPKx/DjFORi/Gv4Nouw5a+whC3KwESPyRK/lR2EYrQNHFFtiZ
         n3Pw==
X-Forwarded-Encrypted: i=1; AJvYcCURPVZTBUH2Z5UhKFHSmmYFzve3C9K1shtJstbs4qkP6oyXCfYmLIzAFM+kGegtG1mAjwJEtIwA/cYbEjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxOyL6wyY/U0ARwDwsOrzc9JlVeH/1ILMcm7ce5sDaEZcGBYAE
	zEPr7HrH0nab4glT1S1bFNxVAK4qFRFh9mcYROOB1Rtz6StxVVSzvqG8I6Ne0DeLZyQ=
X-Gm-Gg: ASbGnctD1qWR3D5K0zp1WUcJ3stw1rAS+EFHdRedEdgbTeE9GMIO9pSdNNXtASvyG2q
	mgPIggxNHATwJujHTCOdb0Yz3YU0WthjdYV0AQvOTR4iJe+P5+obcpyTkmqJY4iGoDeHi4egaMc
	UCpqAaI7vMyP6ygmk5MEfOjDx9/4S/cgOkLL2V/TronuZ/x2xYJ36NinxI2cpiM9DThrKNZBagn
	6L5gSSNtHA5iAnf70hFCwgvNEiSw6sKDIlX4oPYmcy6IZOU8xZN5pdpYd/yfR+3Xqpegei0LGLl
	ac4PybmXSilUaYosDxwjIT4ESbYydBXuTq+itlMhfIlEPsDYVctkFliEW8sge9jVqKbdllzN2iF
	yaI0+UDjJQeQEmDQYU/G7
X-Google-Smtp-Source: AGHT+IFRxV/uO1ynrbPQpKYbWo1BdkPpqPJfwKaGM+M1EblRzTIKuZgxM4JDshmIh4OUS5cYyqK/IQ==
X-Received: by 2002:a17:90b:380a:b0:311:c596:5c6f with SMTP id 98e67ed59e1d1-31250422c83mr2343246a91.17.1748597583233;
        Fri, 30 May 2025 02:33:03 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.32.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:33:02 -0700 (PDT)
From: Bo Li <libo.gcs85@bytedance.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	kees@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	riel@surriel.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com,
	yuanzhu@bytedance.com,
	chengguozhu@bytedance.com,
	sunjiadong.lff@bytedance.com,
	Bo Li <libo.gcs85@bytedance.com>
Subject: [RFC v2 18/35] sched: pick a specified task
Date: Fri, 30 May 2025 17:27:46 +0800
Message-Id: <6e785c48ed266694748e0e71e264b94b27d9fa7b.1748594841.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a lazy switch occurs, the kernel already gets the task_struct of the
next task to switch to. However, the CFS does not provide an interface to
explicitly specify the next task. Therefore, RPAL must implement its own
mechanism to pick a specified task.

This patch introduces two interfaces, rpal_pick_next_task_fair() and
rpal_pick_task_fair(), to achieve this functionality. These interfaces
leverage the sched_entity of the target task to modify the CFS data
structures directly. Additionally, the patch adapts to the SCHED_CORE
feature by temporarily setting the highest weight for the specified task,
ensuring that the core will select this task preferentially during
scheduling decisions.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 kernel/sched/core.c  | 212 +++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c  | 109 ++++++++++++++++++++++
 kernel/sched/sched.h |   8 ++
 3 files changed, 329 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a862bf4a0161..2e76376c5172 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11003,3 +11003,215 @@ void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx)
 		set_next_task(rq, ctx->p);
 }
 #endif	/* CONFIG_SCHED_CLASS_EXT */
+
+#ifdef CONFIG_RPAL
+#ifdef CONFIG_SCHED_CORE
+static inline struct task_struct *
+__rpal_pick_next_task(struct rq *rq, struct task_struct *prev,
+		      struct task_struct *next, struct rq_flags *rf)
+{
+	struct task_struct *p;
+
+	if (likely(prev->sched_class == &fair_sched_class &&
+		   next->sched_class == &fair_sched_class)) {
+		p = rpal_pick_next_task_fair(prev, next, rq, rf);
+		return p;
+	}
+
+	BUG();
+}
+
+static struct task_struct *rpal_pick_next_task(struct rq *rq,
+					       struct task_struct *prev,
+					       struct task_struct *next,
+					       struct rq_flags *rf)
+{
+	struct task_struct *p;
+	const struct cpumask *smt_mask;
+	bool fi_before = false;
+	bool core_clock_updated = (rq == rq->core);
+	unsigned long cookie;
+	int i, cpu, occ = 0;
+	struct rq *rq_i;
+	bool need_sync;
+
+	if (!sched_core_enabled(rq))
+		return __rpal_pick_next_task(rq, prev, next, rf);
+
+	cpu = cpu_of(rq);
+
+	/* Stopper task is switching into idle, no need core-wide selection. */
+	if (cpu_is_offline(cpu)) {
+		rq->core_pick = NULL;
+		return __rpal_pick_next_task(rq, prev, next, rf);
+	}
+
+	if (rq->core->core_pick_seq == rq->core->core_task_seq &&
+	    rq->core->core_pick_seq != rq->core_sched_seq &&
+		rq->core_pick) {
+		WRITE_ONCE(rq->core_sched_seq, rq->core->core_pick_seq);
+
+		/* ignore rq->core_pick, always pick next */
+		if (rq->core_pick == next) {
+			put_prev_task(rq, prev);
+			set_next_task(rq, next);
+
+			rq->core_pick = NULL;
+			goto out;
+		}
+	}
+
+	put_prev_task_balance(rq, prev, rf);
+
+	smt_mask = cpu_smt_mask(cpu);
+	need_sync = !!rq->core->core_cookie;
+
+	/* reset state */
+	rq->core->core_cookie = 0UL;
+	if (rq->core->core_forceidle_count) {
+		if (!core_clock_updated) {
+			update_rq_clock(rq->core);
+			core_clock_updated = true;
+		}
+		sched_core_account_forceidle(rq);
+		/* reset after accounting force idle */
+		rq->core->core_forceidle_start = 0;
+		rq->core->core_forceidle_count = 0;
+		rq->core->core_forceidle_occupation = 0;
+		need_sync = true;
+		fi_before = true;
+	}
+
+	rq->core->core_task_seq++;
+
+	if (!need_sync) {
+		next = rpal_pick_task_fair(rq, next);
+		if (!next->core_cookie) {
+			rq->core_pick = NULL;
+			/*
+			 * For robustness, update the min_vruntime_fi for
+			 * unconstrained picks as well.
+			 */
+			WARN_ON_ONCE(fi_before);
+			task_vruntime_update(rq, next, false);
+			goto out_set_next;
+		}
+	}
+
+	for_each_cpu_wrap(i, smt_mask, cpu) {
+		rq_i = cpu_rq(i);
+
+		if (i != cpu && (rq_i != rq->core || !core_clock_updated))
+			update_rq_clock(rq_i);
+
+		/* ignore prio, always pick next */
+		if (i == cpu)
+			rq_i->core_pick = rpal_pick_task_fair(rq, next);
+		else
+			rq_i->core_pick = pick_task(rq_i);
+	}
+
+	cookie = rq->core->core_cookie = next->core_cookie;
+
+	for_each_cpu(i, smt_mask) {
+		rq_i = cpu_rq(i);
+		p = rq_i->core_pick;
+
+		if (!cookie_equals(p, cookie)) {
+			p = NULL;
+			if (cookie)
+				p = sched_core_find(rq_i, cookie);
+			if (!p)
+				p = idle_sched_class.pick_task(rq_i);
+		}
+
+		rq_i->core_pick = p;
+
+		if (p == rq_i->idle) {
+			if (rq_i->nr_running) {
+				rq->core->core_forceidle_count++;
+				if (!fi_before)
+					rq->core->core_forceidle_seq++;
+			}
+		} else {
+			occ++;
+		}
+	}
+
+	if (schedstat_enabled() && rq->core->core_forceidle_count) {
+		rq->core->core_forceidle_start = rq_clock(rq->core);
+		rq->core->core_forceidle_occupation = occ;
+	}
+
+	rq->core->core_pick_seq = rq->core->core_task_seq;
+	WARN_ON_ONCE(next != rq->core_pick);
+	rq->core_sched_seq = rq->core->core_pick_seq;
+
+	for_each_cpu(i, smt_mask) {
+		rq_i = cpu_rq(i);
+
+		/*
+		 * An online sibling might have gone offline before a task
+		 * could be picked for it, or it might be offline but later
+		 * happen to come online, but its too late and nothing was
+		 * picked for it.  That's Ok - it will pick tasks for itself,
+		 * so ignore it.
+		 */
+		if (!rq_i->core_pick)
+			continue;
+
+		/*
+		 * Update for new !FI->FI transitions, or if continuing to be in !FI:
+		 * fi_before     fi      update?
+		 *  0            0       1
+		 *  0            1       1
+		 *  1            0       1
+		 *  1            1       0
+		 */
+		if (!(fi_before && rq->core->core_forceidle_count))
+			task_vruntime_update(rq_i, rq_i->core_pick,
+					     !!rq->core->core_forceidle_count);
+
+		rq_i->core_pick->core_occupation = occ;
+
+		if (i == cpu) {
+			rq_i->core_pick = NULL;
+			continue;
+		}
+
+		/* Did we break L1TF mitigation requirements? */
+		WARN_ON_ONCE(!cookie_match(next, rq_i->core_pick));
+
+		if (rq_i->curr == rq_i->core_pick) {
+			rq_i->core_pick = NULL;
+			continue;
+		}
+
+		resched_curr(rq_i);
+	}
+
+out_set_next:
+	set_next_task(rq, next);
+out:
+	if (rq->core->core_forceidle_count && next == rq->idle)
+		queue_core_balance(rq);
+
+	return next;
+}
+#else
+static inline struct task_struct *
+rpal_pick_next_task(struct rq *rq, struct task_struct *prev,
+		      struct task_struct *next, struct rq_flags *rf)
+{
+	struct task_struct *p;
+
+	if (likely(prev->sched_class == &fair_sched_class &&
+		   next->sched_class == &fair_sched_class)) {
+		p = rpal_pick_next_task_fair(prev, next, rq, rf);
+		return p;
+	}
+
+	BUG();
+}
+#endif
+#endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 125912c0e9dd..d9c16d974a47 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8983,6 +8983,115 @@ void fair_server_init(struct rq *rq)
 	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick_task);
 }
 
+#ifdef CONFIG_RPAL
+/* if the next is throttled, unthrottle it */
+static void rpal_unthrottle(struct rq *rq, struct task_struct *next)
+{
+	struct sched_entity *se;
+	struct cfs_rq *cfs_rq;
+
+	se = &next->se;
+	for_each_sched_entity(se) {
+		cfs_rq = cfs_rq_of(se);
+		if (cfs_rq_throttled(cfs_rq))
+			unthrottle_cfs_rq(cfs_rq);
+
+		if (cfs_rq == &rq->cfs)
+			break;
+	}
+}
+
+struct task_struct *rpal_pick_task_fair(struct rq *rq, struct task_struct *next)
+{
+	struct sched_entity *se;
+	struct cfs_rq *cfs_rq;
+
+	rpal_unthrottle(rq, next);
+
+	se = &next->se;
+	for_each_sched_entity(se) {
+		cfs_rq = cfs_rq_of(se);
+
+		if (cfs_rq->curr && cfs_rq->curr->on_rq)
+			update_curr(cfs_rq);
+
+		if (unlikely(check_cfs_rq_runtime(cfs_rq)))
+			continue;
+
+		clear_buddies(cfs_rq, se);
+	}
+
+	return next;
+}
+
+struct task_struct *rpal_pick_next_task_fair(struct task_struct *prev,
+					     struct task_struct *next,
+					     struct rq *rq, struct rq_flags *rf)
+{
+	struct cfs_rq *cfs_rq;
+	struct sched_entity *se;
+	struct task_struct *p;
+
+	rpal_unthrottle(rq, next);
+
+	p = rpal_pick_task_fair(rq, next);
+
+	if (!sched_fair_runnable(rq))
+		panic("rpal error: !sched_fair_runnable\n");
+
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	__put_prev_set_next_dl_server(rq, prev, next);
+
+	se = &next->se;
+	p = task_of(se);
+
+	/*
+	 * Since we haven't yet done put_prev_entity and if the selected task
+	 * is a different task than we started out with, try and touch the
+	 * least amount of cfs_rqs.
+	 */
+	if (prev != p) {
+		struct sched_entity *pse = &prev->se;
+
+		while (!(cfs_rq = is_same_group(se, pse))) {
+			int se_depth = se->depth;
+			int pse_depth = pse->depth;
+
+			if (se_depth <= pse_depth) {
+				put_prev_entity(cfs_rq_of(pse), pse);
+				pse = parent_entity(pse);
+			}
+			if (se_depth >= pse_depth) {
+				set_next_entity(cfs_rq_of(se), se);
+				se = parent_entity(se);
+			}
+		}
+
+		put_prev_entity(cfs_rq, pse);
+		set_next_entity(cfs_rq, se);
+	}
+#endif
+#ifdef CONFIG_SMP
+	/*
+	 * Move the next running task to the front of
+	 * the list, so our cfs_tasks list becomes MRU
+	 * one.
+	 */
+	list_move(&p->se.group_node, &rq->cfs_tasks);
+#endif
+
+	WARN_ON_ONCE(se->sched_delayed);
+
+	if (hrtick_enabled_fair(rq))
+		hrtick_start_fair(rq, p);
+
+	update_misfit_status(p, rq);
+	sched_fair_update_stop_tick(rq, p);
+
+	return p;
+}
+#endif
+
 /*
  * Account for a descheduled task:
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c5a6a503eb6d..f8fd26b584c9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2575,6 +2575,14 @@ static inline bool sched_fair_runnable(struct rq *rq)
 
 extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
 extern struct task_struct *pick_task_idle(struct rq *rq);
+#ifdef CONFIG_RPAL
+extern struct task_struct *rpal_pick_task_fair(struct rq *rq,
+					       struct task_struct *next);
+extern struct task_struct *rpal_pick_next_task_fair(struct task_struct *prev,
+						    struct task_struct *next,
+						    struct rq *rq,
+						    struct rq_flags *rf);
+#endif
 
 #define SCA_CHECK		0x01
 #define SCA_MIGRATE_DISABLE	0x02
-- 
2.20.1


