Return-Path: <linux-kernel+bounces-846187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA7BBC73BF
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCFD19E581C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D614A1662E7;
	Thu,  9 Oct 2025 02:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxglofC/"
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E044C6C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 02:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759978027; cv=none; b=VstxyhGP1laFmCHNlPo44UhgzGxduIIcSlp/RSczu1vIsjIvYVZGnyR4x4yaV3VCif+w8DYLJLndnkztf+jXbad3zYAOrLjU697s43LcujY6ojR93s1qxr4TD1w6HlbZiMqeU182UUR6Kc6VZuKgAb+btInZUtMF+6sRy2yrxis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759978027; c=relaxed/simple;
	bh=j1H8rr3ZCKuau3eSV0aCOIemmLP/Ndrxe09nU4fQzcI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V5D8CrP53dvEdFju3vxGki2dADnv5h7xRCiMPw8QPxxtnQG8z0pcqUQKpUNcOTVgGEhqSgCvby5ffCOvBQARms69EThC2kZJR4cvwNry/QI6Fovr5NI55CiHI9mEhyjrGvVCwWKGshgKfb9q4IH6vPZ+bxAcu/mlCr6i1SUhScw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxglofC/; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso288356a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 19:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759978025; x=1760582825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+GiA4iuz6lIjQr1cqP5VsrnXl9FUk3KwAqlmR8Sc5as=;
        b=AxglofC/vxv7OmV86lH/1wyYUWD9QhadO3/nVfCAhZMqZHP7DGCx0bpuGyJ4P8+BgK
         Dy5qY2fEhgObg4Iucc06mlNjl0ddgNZ4pF3EvQ2BWKvh7LkVyPxvoIsBHj9okAPF1iic
         kDzx66BJDJ0A+zjOSswg50yWo+X7OvUm7Z91vdxzEWxR97sAz9GVPUmcfvWQpGZw2kX3
         K+7XSKc9n4SkZTLznFOGhPwubOpjBS65D9SLcx5fMfU/O5BSZHdH3NtTvAxFkFQg82OG
         jYe9YbLm2Me8u6TnEzK768YcjosgsmYpK/f/GSqssQYoYEplvJkRf1LpjbN+rCGfEw3z
         6weg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759978025; x=1760582825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+GiA4iuz6lIjQr1cqP5VsrnXl9FUk3KwAqlmR8Sc5as=;
        b=cE16RszHQoc1MnHu8slerRG66hmmrUQs5qjNOsR2t4ZsSH5EtSb6DfG0Owvu1A0daZ
         NuLVM8/aQiEFK8gwMadhLxj4mVEEc4aTNAMWIcSDTptCEydt+/Ukq9DvLq4rqQ2AKApo
         6CbvUafLb9+e0IlgZEjj7Ca5eX/L6i+A/gYljFPoiIG2sfaskeHJRbElWhfiOgBw+nGk
         vlDhEph++DrW//yF9fk6ekuUd0B7j8jTnknhV7y72t6P0W95ZzWKy4bwWKalMZdUmf3S
         8j8xk3Lo3k6IgcpL5WD1WtojYk7cyufKLv5FA5LxxB7hzBeHj+ITX36MjC3MNUJSJJ1j
         DGpA==
X-Gm-Message-State: AOJu0YwoC14mw4s4jVHLVeumIb1LBSQO4T8e4cVMj/AIO0/5wPI5ATO2
	748h3yK4OGxF9O9mO0z6LasS+9+wcSqZE/uDgy+jzJ7WuDn4zQtIPAXIvM8SO/aN
X-Gm-Gg: ASbGncuoa6AokucPt/P0/VQw4ojgozswkyt5LJTbKxRhkKBzCD7iOvqem7riT76IuyM
	mKWzhyfNO2zt0xqKwx+WcXE0FxvQ3HjtMB78W1XaLDjzAywXjzD0D+u51gS3498FtEVgiVaM5iB
	QYFL3wO4MMR2/rGcQCbWUl6fXreyqaKSYI/Y5rk00S8N0NSAxILGK3zjcnodLABk8rhHrDL2444
	XqzYdBG7WHnmbXzIxE4S3Y52uZMxPvSdBbD8ce5qFUAMncH16lkouJ4qNOfJT0b0b0RJCFiAgRu
	gcxfwteqcpuzGzYpkz+VlwXpL2viRyDDjMibsajLs8MZzME0/mZUwOg2+2oTNRbbmnSTPuFeLrz
	emEYmoGGOfWJKJcIyyQXSJs78F3YBvgv2oAHuK7ZvBhtt0mEqO+BgOVLZHTvonPxx
X-Google-Smtp-Source: AGHT+IHFOkfD55JzBdmrtB7rRkB8x8PQKvLZVhVzaNqrmyfFwltFeiwS/jvh4biiqwQmWhRIAW4UlA==
X-Received: by 2002:a17:903:1b4b:b0:26d:353c:75cd with SMTP id d9443c01a7336-290272409c7mr77633275ad.21.1759978024481;
        Wed, 08 Oct 2025 19:47:04 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de6fd3sm11900395ad.25.2025.10.08.19.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 19:47:04 -0700 (PDT)
From: Jianyun Gao <jianyungao89@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: "jianyun.gao" <jianyungao89@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH v3] sched: Fix some spelling mistakes in the scheduler module
Date: Thu,  9 Oct 2025 10:46:56 +0800
Message-Id: <20251009024657.151767-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "jianyun.gao" <jianyungao89@gmail.com>

The following are some spelling mistakes existing in the scheduler
module. Just fix it!

  slection -> selection
  achitectures -> architectures
  excempt -> exempt
  incorectly -> incorrectly
  litle -> little
  faireness -> fairness
  condtion -> condition

Signed-off-by: jianyun.gao <jianyungao89@gmail.com>
---
v3:
Change "except" to "exempt" in v2.
The previous version is here:

https://lore.kernel.org/lkml/20250929061213.1659258-1-jianyungao89@gmail.com/

 kernel/sched/core.c     | 2 +-
 kernel/sched/cputime.c  | 2 +-
 kernel/sched/fair.c     | 8 ++++----
 kernel/sched/wait_bit.c | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

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
index 18a30ae35441..b1c335719f49 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5381,7 +5381,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		bool delay = sleep;
 		/*
 		 * DELAY_DEQUEUE relies on spurious wakeups, special task
-		 * states must not suffer spurious wakeups, excempt them.
+		 * states must not suffer spurious wakeups, exempt them.
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


