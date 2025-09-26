Return-Path: <linux-kernel+bounces-833819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E6DBA3251
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797A81BC8236
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D420283CB5;
	Fri, 26 Sep 2025 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/Ms8UOs"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D837272814
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758878975; cv=none; b=lfb/8tBGCWpcFZzFcqgNYxDRSERzS6XcNN/l93dZOwC53dtCHvmMIMw7cI927ZIBOhC7CeRASAy8y+qTElSWSxkR2OcTg0IjaxGy6MeU15x1P83ydOgWitVtrxjze2IDkHieKeMdauPLexfHzkHo2QYyXPDfaaVwX0trKsyTZl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758878975; c=relaxed/simple;
	bh=AeXjPd7N/Jir0CATAPHycUi/fJY/JqYJ8PMLu+BMkNE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dMQLVZ67/j18faH1CvvHFssq2WBwAFDhgsCth+Wd49irja8yd007PDnfCjFoshCbA3tIpX4MDzLJIKFDbLamMr6D8z+dJkGnI+xwOstGtgDgHXRSkZqZcIbQksjkyDgUR2zcrc+bG4gSgrHldO9egmvOPwabr1TrbeUfAXFyios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/Ms8UOs; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-77f41086c11so1836932b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758878973; x=1759483773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jTmGRiV0i9AG+4gnDdm7bgxielPDDLusYKiIwNh2bo0=;
        b=J/Ms8UOsdD80BoFEKRNj+fE5VpIZiR3cazVGdSxxxqd8iLRXpNslLuCVzcyREwMvOE
         gbLM2kdhwez1waCMjGmg25Q5Je4NsCJ+Xe2hFfghX0quxS6GQtyNntNuW2/wH5qvE/2b
         oVt3yVx0xMuNSUv3OGlMgTeuyHJc+Nnr52RF+Y9XO0x14HAUK3vKW2i9ehO0nT/oTohV
         tZ4qiOJu2Ek/pYJNt9ghayBDe/3C7uiMUUW6EeYDZOW8IA/VDFPhnIw2aMBxIn2E3eXl
         QCe76Sk7TjUuiLB4E5r7x3Why8pBkpfKEO+syKxVHmOH3FnTDTOUgY1gW90la8yphFJZ
         jg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758878973; x=1759483773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTmGRiV0i9AG+4gnDdm7bgxielPDDLusYKiIwNh2bo0=;
        b=s7bBHFZou6lIUZKGep9GgmnYFkZEPnn1NlZ886X+ekDAf51U86BDYbyIEhUu6vVE28
         3v1jTzRDZgJ9r+JISC2xILjO33x6gr/PwF7i9S8X2TsZy/I1tg4XRgUR7NH/kzEPT82n
         scqHXW6ZNkHH1SZ0BuxwzVhJTddZlTY5PGhpXInbUdrsh8p4PQDJy46iVTfLpVwve7WI
         SkoVWEneuk9VOleWHTNLH8eit14dggwkzsjKILZEwKX2aAw78bnXdmX1VaiyIMuZoxGd
         EqIoHqqQN5O63p8EryjRq9Qc9TvJS5BWqlgU9RL7Niu7mugDszP0j294VYtfDGpY49nf
         j5wA==
X-Gm-Message-State: AOJu0YzYForS8m67wX7tw/XaSVoINssoa2Guzol5oXAOOOihRGoTHGKQ
	Wag/gKpy2upK+ljQ9rToBwAJVCKRS0bSCdyakR/mu7SPQmLGsaQoEEvE482kh6610VZn4A==
X-Gm-Gg: ASbGncu88MRvDWPFe+ZzWzTgz3aMzPhg3xVhpr0BGMnIPAveScgRqS4NYyEg1DKoOsA
	KHL0zXuqgjOxkeTo6k5KNTlbYJN4GPtGdO5LaqC22tnieFjIuue9pG60rlLKJoCsYn68Mqmn6Fh
	wljjBHz2bR/vmrzNLbyKFQoHWywtONtxaWOarRVPu8edX6xqMHlmbO33SwKf10fz8EVCsj12pXm
	JlBSHYdWVOc0w2GK+tf3rDUCe+Km8LUcEL3q03DOjx0xe5k/17Ub84UXU+hh3xfHZp/bitwyVt5
	ZG9opaW2uMx6PIl4ewYwYifv/EgUlJ16dcujEaxY5LHf4DMEtTXLouvgKrVL9O76b+tjamTI3xD
	PTT78+WdYnzYFZbFO4plCPlVJfJdbUQBi444QjoFJ
X-Google-Smtp-Source: AGHT+IFToI51D2x755P8HNQvtFTzd07IA4MKIRubyaHrcj13jSDKfzgKrvbnBzfV5rqPnhlPAXB08w==
X-Received: by 2002:a05:6a20:72a5:b0:2c6:2c4c:fb08 with SMTP id adf61e73a8af0-2e7be9f1e80mr8740491637.2.1758878973068;
        Fri, 26 Sep 2025 02:29:33 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3355592d5d6sm389122a91.23.2025.09.26.02.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 02:29:32 -0700 (PDT)
From: "jianyun.gao" <jianyungao89@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	"jianyun.gao" <jianyungao89@gmail.com>
Subject: [PATCH] sched: Fix some spelling mistakes in the scheduler module
Date: Fri, 26 Sep 2025 17:28:32 +0800
Message-Id: <20250926092832.1457477-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following are some spelling mistakes existing in the scheduler
module. Just fix it!

  slection -> selection
  achitectures -> architectures
  excempt -> except
  incorectly -> incorrectly
  litle -> little
  faireness -> fairness
  borken -> broken
  condtion -> condition

Signed-off-by: jianyun.gao <jianyungao89@gmail.com>
---
 kernel/sched/core.c     | 2 +-
 kernel/sched/cputime.c  | 2 +-
 kernel/sched/fair.c     | 8 ++++----
 kernel/sched/topology.c | 2 +-
 kernel/sched/wait_bit.c | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7f1e5cb94c53..af5076e40567 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6858,7 +6858,7 @@ static void __sched notrace __schedule(int sched_mode)
 		/*
 		 * We pass task_is_blocked() as the should_block arg
 		 * in order to keep mutex-blocked tasks on the runqueue
-		 * for slection with proxy-exec (without proxy-exec
+		 * for selection with proxy-exec (without proxy-exec
 		 * task_is_blocked() will always be false).
 		 */
 		try_to_block_task(rq, prev, &prev_state,
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 7097de2c8cda..2429be5a5e40 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -585,7 +585,7 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
 	/*
 	 * Because mul_u64_u64_div_u64() can approximate on some
-	 * achitectures; enforce the constraint that: a*b/(b+c) <= a.
+	 * architectures; enforce the constraint that: a*b/(b+c) <= a.
 	 */
 	if (unlikely(stime > rtime))
 		stime = rtime;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 18a30ae35441..20fe5899b247 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5381,7 +5381,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		bool delay = sleep;
 		/*
 		 * DELAY_DEQUEUE relies on spurious wakeups, special task
-		 * states must not suffer spurious wakeups, excempt them.
+		 * states must not suffer spurious wakeups, except them.
 		 */
 		if (flags & (DEQUEUE_SPECIAL | DEQUEUE_THROTTLE))
 			delay = false;
@@ -5842,7 +5842,7 @@ static bool enqueue_throttled_task(struct task_struct *p)
 	 * target cfs_rq's limbo list.
 	 *
 	 * Do not do that when @p is current because the following race can
-	 * cause @p's group_node to be incorectly re-insterted in its rq's
+	 * cause @p's group_node to be incorrectly re-insterted in its rq's
 	 * cfs_tasks list, despite being throttled:
 	 *
 	 *     cpuX                       cpuY
@@ -12161,7 +12161,7 @@ static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
 		 * sched_balance_newidle() bumps the cost whenever newidle
 		 * balance fails, and we don't want things to grow out of
 		 * control.  Use the sysctl_sched_migration_cost as the upper
-		 * limit, plus a litle extra to avoid off by ones.
+		 * limit, plus a little extra to avoid off by ones.
 		 */
 		sd->max_newidle_lb_cost =
 			min(cost, sysctl_sched_migration_cost + 200);
@@ -13176,7 +13176,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 	 * If a task gets attached to this cfs_rq and before being queued,
 	 * it gets migrated to another CPU due to reasons like affinity
 	 * change, make sure this cfs_rq stays on leaf cfs_rq list to have
-	 * that removed load decayed or it can cause faireness problem.
+	 * that removed load decayed or it can cause fairness problem.
 	 */
 	if (!cfs_rq_pelt_clock_throttled(cfs_rq))
 		list_add_leaf_cfs_rq(cfs_rq);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 1104d931c015..796ece7989e6 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2399,7 +2399,7 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 
 		if (!cpumask_subset(sched_domain_span(child),
 				    sched_domain_span(sd))) {
-			pr_err("BUG: arch topology borken\n");
+			pr_err("BUG: arch topology broken\n");
 			pr_err("     the %s domain not a subset of the %s domain\n",
 					child->name, sd->name);
 			/* Fixup, ensure @sd has at least @child CPUs. */
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 1088d3b7012c..47ab3bcd2ebc 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -207,7 +207,7 @@ EXPORT_SYMBOL(init_wait_var_entry);
  * given variable to change.  wait_var_event() can be waiting for an
  * arbitrary condition to be true and associates that condition with an
  * address.  Calling wake_up_var() suggests that the condition has been
- * made true, but does not strictly require the condtion to use the
+ * made true, but does not strictly require the condition to use the
  * address given.
  *
  * The wake-up is sent to tasks in a waitqueue selected by hash from a
-- 
2.34.1


