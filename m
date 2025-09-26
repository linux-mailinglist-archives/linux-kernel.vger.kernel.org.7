Return-Path: <linux-kernel+bounces-834397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34433BA49C0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB323A81D9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5552D05D;
	Fri, 26 Sep 2025 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSNovDnf"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156F923BD1F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903920; cv=none; b=kpV5qsSWQyj8+wBnAx02PEoR3TAFYG3L7v2k1dliiiaOY5g01rptDzvl/0gIeE7mmXAYwfyYhUJ8Zvcd6lutFy+37n4I6puDvy72VsnasTJevSWK+VA4t7wMa2knoUOWSSK4TvH46nRnxFBLrP3FOafW7oq4jfVcWPpjnwB0Bfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903920; c=relaxed/simple;
	bh=/sa+ycTcIOhnk8NqXfvlI35EiLD2pDmUQy/eYIPs/fw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lKmsk1vUbe8L0eG6/hCIpBE0tAxXecyQhfHdKnKUr0YAlgpWQv/+7y3+2Tb/Plb29jaCQRXMnhzaPbvPazBrk1aFxDA4gtEueNcDu0Dl5p0hhuTHkkctT6Ix6WdTZYTTTRWevJJU26oVYWsCuIHgVgPfEhrG5NQP41/Osum5UH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSNovDnf; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-78104c8cbb4so2268974b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758903918; x=1759508718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AvzAdX1cHgIDD7PYzsoD5DdjbGHuHz6IfmQrjY/6K0=;
        b=BSNovDnfKiSUGMltwR2g3iyHXw1Fzx/2i7Hdf5M3S+aO+liDFZCbUPw6K5rOd1LDOJ
         BkwvkbkccpGpZSIxP3GPAiN4o5zM82whvsgHHOrb4HOuoJcBgD34yVSSvtfWKWpvGRQs
         CssTuSuA2z5kICpFYAbfSAHkyXxEVzIqCriTrB8lW7dDFFJ/j2wSsuixSD8lp1ZR6G6M
         rjz1RoiCRngeu3Np7MZG0n2OBqPzyko7ns3eQU18H1c+eFMmPSbrjHXBlnKW6vatzroA
         zryXekNsyTCtzuVq/fiiwRbLbjr4f8sJDbeBdeMM/Ql/IXW8rwgMoUXo5vJN3ZKKww9a
         fpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758903918; x=1759508718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AvzAdX1cHgIDD7PYzsoD5DdjbGHuHz6IfmQrjY/6K0=;
        b=TQ/5J5/fjsdDv/oRYkPjWp6g/siBrO1q4CJa36YbmLOff67t5cGfij3nQL5UlGC9Qh
         kR7ua2nBCLg6JkKpKTUtsCvLZqShsVs8Yun9Q77OOXtdPCuEtbC6caj5qwZBtWOisEYr
         wi15qZI3ij7HwrMB7hOAjF8AMQRvpxogFRdPgK78qImceeRN/5nyxiJtF/PCmlJKvzEe
         3+QFcyIcMbT1Jf3W0XfjlGxxj5c16p1SBfoz1mxZb+K8xZGYcWcir0a2u4e5NJuUwguh
         X8mrC7TwbN67K3/HhGc39x+8sRST5sd6nE8KS7wZ+pgfPZGNbJZVsnVNwROEUzho+GpL
         gohQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIDDXl3hCq6r8BLoza1vE/c937AN+ZFsV3WhbFxf1CbqQY3NDaJGNf4UIuA++gIyz3RpAvzqJc+EEj2SA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdN7YIOMaUsANrMWza5TpPvyqzrhSkmo5QlTZOaK11tdNchj2h
	e95887+P7nUKFvfZCQTJ4deeG7wwH6Kmb7kscFp14h78Keb52bB4HJWZ
X-Gm-Gg: ASbGncuKBkdC4yWozHhqiUlliIT1bGfY/voC9hb/7lQAcGv7P9ZPgx7uA+9zj36Yk8Z
	LzqucKJNPjBWVVDamgm59ZgEynVNvEhZTP1oHvYz7KSv37dsCnQ2jMI8mpy/e2r/4Nm1jcfP892
	uD2GoGoGu++6oR0cF6Q7shvPUvxQt8RTUo1uStjknF5lux082TemruH97edCwTCQPjFNcVM3gMn
	WiTWRig7hqDjEOb8IXjeDE0HAjhlDeFxvk8lVGtQu04y5Cw9jm4NaW0/kbpmWzO1s51JWIH9Xh7
	jvwy/SlhsLhmKyXDdnu2srZR0f3dIWN1fjZZaF5AnUc/dHLrFXIiyHb4ZUCrinTeUti/q4VHL4/
	3Gjk+68Bfha8Uizmnd1F3vmL986x3nVtXsmHz9EM5FZpuon2Kq7Q=
X-Google-Smtp-Source: AGHT+IEVajTUTyu4PORQmWBDubQOna3LjFTjnjthCPDVvepbSARLGZAbwp2aCYhaXHBSUG6FtTKJzg==
X-Received: by 2002:a05:6a00:148f:b0:77f:3149:3735 with SMTP id d2e1a72fcca58-780fcdff12amr8982677b3a.2.1758903918217;
        Fri, 26 Sep 2025 09:25:18 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c27733sm4912058b3a.95.2025.09.26.09.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:25:17 -0700 (PDT)
From: "jianyun.gao" <jianyungao89@gmail.com>
To: peterz@infradead.org
Cc: bsegall@google.com,
	dietmar.eggemann@arm.com,
	jianyungao89@gmail.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: [PATCH v2] sched: Fix some spelling mistakes in the scheduler module
Date: Sat, 27 Sep 2025 00:25:08 +0800
Message-Id: <20250926162508.1463229-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926110047.GB3245006@noisy.programming.kicks-ass.net>
References: <20250926110047.GB3245006@noisy.programming.kicks-ass.net>
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
  condtion -> condition

Signed-off-by: jianyun.gao <jianyungao89@gmail.com>
---
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


