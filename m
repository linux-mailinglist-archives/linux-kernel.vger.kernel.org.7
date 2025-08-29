Return-Path: <linux-kernel+bounces-791336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939E7B3B597
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA0287BAE30
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1692848AF;
	Fri, 29 Aug 2025 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N+8UhMNy"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5E6262FC7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756455131; cv=none; b=f0uFADTibLgwl5vv3NMTaM4hGqHVNixj+grb1Ef+AW35Omf41oqgcuc5hqCHYuZTQd61EkG5CicpXB3fWVf9bTcDd9PkvdA4O10CZYCf41zJVirVxmT9H8wzVVhN6TwJJcVFj/1f09a+QAb0vuazIvta6ZBSfQaztym9IU9fOlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756455131; c=relaxed/simple;
	bh=bI0ojabawS9r2Sa8dCy9+WJV9AxPHlvYS1/yKCbf+oc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QHSlglw3pGqHgIBsw2N5TfMHlhQ2CPjZ+NImWOhEYXLRq9wOYn5FObNJjCY4+W4qzJCiyLLP8sY4H5QrnAczcoOAKw4IHO46isR5y1XQGDz3HrEQN8ybz5rBuMS4JfPAtJJ/emBCR4Gzg3SrUdkDcOCz51EfC2avSxV81Qo6PZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N+8UhMNy; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-771f90a45easo1590013b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756455126; x=1757059926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqBqN7RGE2xf0B17OAlbbwx5XDTDX0izvi88Auw+30o=;
        b=N+8UhMNyfvgEINWF7ndU+u8yCJHBSgW2Dm7hY/eJz+UbB4JrBTsx91xX1V7d/h4IIF
         ZJ4OvRCz0qQcfxBvDgs2VVMMFsV7UNyeF9N7j4WA1XHcgyRNY6L8o+nHkHVzdjoQRQAz
         KHo1dCF2VO5Z3l+zhSX2Furdus48m8Z7Vem8iFKyj0miV/95ON33ukRJJhSVKYZOjlqW
         pUHg669Qsa24nzcc8jP6iQjJ/jvixFt8uznX86B/uZuUWvkGgzBs9NXtcSEpBtSDwm2v
         be4+lMmo+h9FRgCw5YWoiO4zxnXaM0SzTwHaJFqhNJQcC0c6NGlKgkPSzIPVoSayvAXZ
         K8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756455126; x=1757059926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqBqN7RGE2xf0B17OAlbbwx5XDTDX0izvi88Auw+30o=;
        b=lvf1ZizECaDlblM+MH8efSVHF3CSHd47eOi4/pq/Jleieao44pWeiLpLHp+siri5fR
         67Nk3vyfsw1g6IpW86g06yIRv6tIvtvrePE/5ge5D4G3ktx5C78a5WFDbXUABFO4lp7z
         FQvvD7YNq+9VX5QmGWh/kJHYO8Qb0ITLl6oNa4Zvtyktwu1U60hmHDO2c/mic0GKvh4K
         TtSHufa5xK70JUe1u17ObyEVocTZEAc/fzKsMRxtpewU58x7I/qcE+MOiS0hRtPS6p0I
         Ao3NAPM95WomstEYC8sidDxU0ckuA/xBWfAjbuwDVKREM9sdk6fMgrKLemakIabIK0G9
         AdVA==
X-Gm-Message-State: AOJu0YxNj5Ph204t6WH8v2TVq3z1c6G0UBPgsDiTa8sFgY7X3FpomZOj
	Qzyt6TddYE+NIqh43hivytJt+fmr6bnyj1ZY6JfFx2ikJ7IMRoc7w/C+kscn7tq3pg==
X-Gm-Gg: ASbGncskxtGARuav01/BZNSQaU4Szpq+35Yiu2y1ibKgozFAULDi3xnUggqDoiQdOE+
	yaXeJzSsATMzSYoF0TDWq6TPelo7Fr1GgDjzytYR3dOD4brapfZ4rGXe61w/ShWBnL+MEpHHi13
	1H3EW9EVWMI41TwXyeskE57zjIEKbQzn/qXAMw0ALyManSpUuWE/mccSYi1BnyU+6rsQQ8jJVB8
	DSV0s/YwOPSzOWJ3Qi69Q8PKquc9Da8kEcC9iqab0daDYQfCpGmtUyALVMFhD6AVHoKKSxtuzdV
	W+ywmfK4OOY2Yg3H+oBfgmmNzOgOuHu15hL/jhRytjRrMDSFN1qsq0SuhWqgnu9nx50/S1uQhCJ
	o1sDrh9qrQjB8zdyIjtxw1TV3EJBcoFSl1c8nwNu9kdOAUvDpyTGAoNH1knFWSvpZNlFcxMD9+R
	SUtjA=
X-Google-Smtp-Source: AGHT+IG0VewZhZ9wi59ZJSVEZ4ujuQDfpIkOFxwtMeBsFoAqRomMI7/6sYWU1XjAH/eUKDnfmkLtqQ==
X-Received: by 2002:a05:6a00:4f85:b0:772:1a0:f772 with SMTP id d2e1a72fcca58-77201a0fdf6mr14375397b3a.28.1756455125931;
        Fri, 29 Aug 2025 01:12:05 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2da9c6sm1601419b3a.42.2025.08.29.01.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:12:05 -0700 (PDT)
From: Aaron Lu <ziqianlu@bytedance.com>
To: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>
Cc: linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 2/5] sched/fair: Implement throttle task work and related helpers
Date: Fri, 29 Aug 2025 16:11:17 +0800
Message-Id: <20250829081120.806-3-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829081120.806-1-ziqianlu@bytedance.com>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Valentin Schneider <vschneid@redhat.com>

Implement throttle_cfs_rq_work() task work which gets executed on task's
ret2user path where the task is dequeued and marked as throttled.

Tested-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/sched/fair.c | 65 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8fff40fcbc425..dab4ed86d0c82 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5748,8 +5748,51 @@ static inline int throttled_lb_pair(struct task_group *tg,
 	       throttled_hierarchy(dest_cfs_rq);
 }
 
+static inline bool task_is_throttled(struct task_struct *p)
+{
+	return cfs_bandwidth_used() && p->throttled;
+}
+
+static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags);
 static void throttle_cfs_rq_work(struct callback_head *work)
 {
+	struct task_struct *p = container_of(work, struct task_struct, sched_throttle_work);
+	struct sched_entity *se;
+	struct cfs_rq *cfs_rq;
+	struct rq *rq;
+
+	WARN_ON_ONCE(p != current);
+	p->sched_throttle_work.next = &p->sched_throttle_work;
+
+	/*
+	 * If task is exiting, then there won't be a return to userspace, so we
+	 * don't have to bother with any of this.
+	 */
+	if ((p->flags & PF_EXITING))
+		return;
+
+	scoped_guard(task_rq_lock, p) {
+		se = &p->se;
+		cfs_rq = cfs_rq_of(se);
+
+		/* Raced, forget */
+		if (p->sched_class != &fair_sched_class)
+			return;
+
+		/*
+		 * If not in limbo, then either replenish has happened or this
+		 * task got migrated out of the throttled cfs_rq, move along.
+		 */
+		if (!cfs_rq->throttle_count)
+			return;
+		rq = scope.rq;
+		update_rq_clock(rq);
+		WARN_ON_ONCE(p->throttled || !list_empty(&p->throttle_node));
+		dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_SPECIAL);
+		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
+		p->throttled = true;
+		resched_curr(rq);
+	}
 }
 
 void init_cfs_throttle_work(struct task_struct *p)
@@ -5789,6 +5832,26 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 	return 0;
 }
 
+static inline bool task_has_throttle_work(struct task_struct *p)
+{
+	return p->sched_throttle_work.next != &p->sched_throttle_work;
+}
+
+static inline void task_throttle_setup_work(struct task_struct *p)
+{
+	if (task_has_throttle_work(p))
+		return;
+
+	/*
+	 * Kthreads and exiting tasks don't return to userspace, so adding the
+	 * work is pointless
+	 */
+	if ((p->flags & (PF_EXITING | PF_KTHREAD)))
+		return;
+
+	task_work_add(p, &p->sched_throttle_work, TWA_RESUME);
+}
+
 static int tg_throttle_down(struct task_group *tg, void *data)
 {
 	struct rq *rq = data;
@@ -6652,6 +6715,8 @@ static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq) { return false; }
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq) {}
 static inline void sync_throttle(struct task_group *tg, int cpu) {}
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
+static void task_throttle_setup_work(struct task_struct *p) {}
+static bool task_is_throttled(struct task_struct *p) { return false; }
 
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
 {
-- 
2.39.5


