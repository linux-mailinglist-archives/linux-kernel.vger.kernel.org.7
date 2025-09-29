Return-Path: <linux-kernel+bounces-835794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 986B7BA812D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 034DC7A8169
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F1D23BF9F;
	Mon, 29 Sep 2025 06:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpNIRtYo"
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CA33FE7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759126355; cv=none; b=pdRORhFn8hQdWAlir5YJVNciIXstjgxuEsU0GU8VONhbJBOXPMW5LNt0QszqUrDSMuUcTAgCrzoVE/mavJXdNIAJhNyJewDKJ/x3pm8axnUYXwKU8EOTKaAMgke5PPUKLh7AyhNd9vwVC9BdXGj+6kpR1siSqLEeRUlwGfnl/RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759126355; c=relaxed/simple;
	bh=C65O5CKyqvMbc239dU6CnGSMFA/gTN3Kzr4RU4y4dpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q8YjSMrNPFKa4aq7pnH99ih33Bp7pT66O6EsqjVAkrUopQ7ZCtS3i9io3v/K7gpQPvcJS8eawzonytfmNtaMYXv9JuCi/LlHwKGKZGSfO2lFZ6kfp3ao5ZFprmEuplt4fqYnezZn16NoVTiaOjWZ/IOo5G5s5pvOhuhLCQd+rgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpNIRtYo; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so4471757a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759126353; x=1759731153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wjo4Rxme5wQr+5CX418SmrHnGf8DI4TpuU3DENsCgnA=;
        b=RpNIRtYowqnTBPGVHlFcQdGfdn3f6nUWbisjyU7KDpixWiTEeV3l7kkCcKDLawps83
         DmV232sevGDi74MPj4HmZfAoI/U/0v1IpN9FHt39ZPIsiHbft+DFdSA6fWYa38o4fV6y
         YWrG00t7Br2FHwXSvVX+F1NIvBKyVaKVrsx3jIKAeX4q/FuvAQOkl8oymovgflj6TGKi
         K5jHp6wu4lfmX/9XqTM5BQFYCLrmnoeU4MU+J71ohkEa4SeLG73cX+rBoSeiHchwIYJd
         EJKNVUCLBXY0AS5+ZzU1mLTEatEumK6NBzkxI3zZ3q9dPU5fTCXmYYEutMbe7PYPM6z6
         w9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759126353; x=1759731153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wjo4Rxme5wQr+5CX418SmrHnGf8DI4TpuU3DENsCgnA=;
        b=UwGWs1DAUgJbloYX83dl5QgbdHpFnfaz03SdVaS3hMMVWeXH73rSZgYkluhAMJsnbQ
         vnJ+yuSFaSlF+l2CnuOwjT+D5EeF33Rh65B59I67hWXV6mofWlUX0xljlUXyu4rtygYy
         Qcc4PyZIfTOmwAvKMbQes7OWh4+KbB8gUXI3lrkwb0fiq5rcvpvSiO19IDgndJk2evow
         bKvg9rtrbjltSt31GfVjBfSqN/+KFqc6yV40XO5s2lyooX/lTmHy6R3FA2ITYGcLe70P
         JhgqJeK70j0s6igtUdcdH3hYelVNtBL+MQHAIOMVvUE51GtFDamDRhvowdmgZNPRtw4W
         /M+A==
X-Gm-Message-State: AOJu0YwLJbuIAxmvmoItFc9QFnQyIOYmZ+zn3b+LAiR5mIjMBcFgWdyV
	vWg9G/xKfGiUHpBcfy7GaC3CxetJUewSwVbR3zV7xnic9J4ALTezoRywEC228/QJy30=
X-Gm-Gg: ASbGncvVamZfn//GylmXi4QQ6wQdAj+T3y9PF5Ovg4HMi/UwW5LoWvYFsuTivuXWRGW
	I9oU8sCOKDQJy1JFztXtMT4IHFCI3tNn0pLiiN5JZ+/G453S3WypjFWNvf4pokzVPUoPMb2JkN9
	O+IuwP0a7JCFYrYmexSteftxIiyrnaKoFcmDgDswXkHTZTtX/5rSj8dVXm16Pnf2wSVBQCTYmZq
	7QZWpN+ZLoL8f7Twcka//E9uHt+VwmK5iHA+wR6UAomxHoRvvEy/K9hCWN9Z/ulIhQ+Vob2Np77
	awy8f1VrjhLTp33Y47nX2h7bGHLYJV5U+k79BZR3CE1R1+Xg1/R/FHSiikPMHy4wmuIU/cuoy+o
	g77Z7RzQ1liFCI9wSpy2mZ65yNT+/Nn2FPKqjgVsq+9R3Pq/lAe0=
X-Google-Smtp-Source: AGHT+IEM8/Klhgocbms2g+/sAOacF5SpskAseKJGUsNbPnEi1cucBMH2g9Mo0jVNmbKLnGUXK3hBcw==
X-Received: by 2002:a17:90b:1b4a:b0:32b:6ac0:8633 with SMTP id 98e67ed59e1d1-3342a25784fmr17828623a91.16.1759126353095;
        Sun, 28 Sep 2025 23:12:33 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.23])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53cb975sm10499236a12.18.2025.09.28.23.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 23:12:32 -0700 (PDT)
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
Subject: [PATCH v2] sched: Fix some spelling mistakes in the scheduler module
Date: Mon, 29 Sep 2025 14:12:12 +0800
Message-Id: <20250929061213.1659258-1-jianyungao89@gmail.com>
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
  excempt -> except
  incorectly -> incorrectly
  litle -> little
  faireness -> fairness
  condtion -> condition

Signed-off-by: jianyun.gao <jianyungao89@gmail.com>
---
V2:
Delete the incorrect modifications for "borken" in V1.
The previous version is here:

https://lore.kernel.org/lkml/20250926092832.1457477-1-jianyungao89@gmail.com/

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


