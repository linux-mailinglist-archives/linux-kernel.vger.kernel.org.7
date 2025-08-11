Return-Path: <linux-kernel+bounces-763475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C100B21518
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962911892CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701842E2DEC;
	Mon, 11 Aug 2025 19:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWbRHNXK"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7EE26CE2A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754939189; cv=none; b=JT5dGwyFo87MccORXiWesA5reJGYv7IUlQ1uRVfe7NY4kZtKhF6Se4SuqB1vooW5TgxJofVxvXCXZfLC2kJ6ezk2NNjeiuU6G5PSWOoAIHmSN43HCNdNLxMMzbeeIWLRMEtIuyI+oaP7t/vQJtX0GWv06Ys6QG2Ewic2bK1DMWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754939189; c=relaxed/simple;
	bh=W7/ItujornmJw6aD76KkRbr0U1s2KWMkwaMQeXOvmok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SRE2R4SCbb8S6joVc7leusqPEzKhleR3QZxWJlOZIzTTJ6o9aSrb9aId7JTgCkhj2dDj1vqU7evTLC8SK6dWqM7H8o1PaTCHpZtF+drZ+LbmM+pLHxlmm1PPdjQHvUMGZpHB0FYWtaIMDzWrd4Yr5/VxK/kw3jB0hegnQLfl+fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWbRHNXK; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e6974a290eso443185485a.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754939187; x=1755543987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nib1am6QF0+yLy7Kix8WvtIMTy4GMtDedFeVAg3u6JY=;
        b=QWbRHNXKq+AoUfjF5+6QVrDtLcJdBWzihtLENAtMMx4YJS1gjF6D9LkyTAXJafoNEI
         QGS2MiooTXPTugA+2qnS+WU9HVZgwz7VX4UcHWnbOQ4HkhpvXiizoUK+abd0/wdYIZ4v
         pWpagumSuxe16jgsdYePx+lLwlm7RDEZCJMZz4dPG8S5LHJ28zXsWtcXJfP4476YNEga
         cywdWMkHKcmWuYkOzPeSLB0/adVO/FAISyqIv5KAMPn6tbgEuZd9E0DyufvfbKQGGGPa
         YEJG/Tu5rDtJ83Cwh9PDHZKMwSlALB1+EEpBGzQS7vZk6HUMFUSpAqnmxaCkf5AJReTg
         AGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754939187; x=1755543987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nib1am6QF0+yLy7Kix8WvtIMTy4GMtDedFeVAg3u6JY=;
        b=oY3+JfBbdFLR8YOp39ScX879S4tmho7hjZymeG5E+QW9UAzc9nEQzxvCiHu51bAlSq
         v6R/ndQA1uqhaEGiy9mcSkyXE2YrT/sQIWTHt5XO1xpfuG1eiwcMbCSMkteamFKCJ4ET
         xphyXD/rHyGIepv20xoSD9TLf9K3MuiIpFy3si+16TFwEATiwJ9RChoEEDtd6CFcaEl6
         1ZoLlAtI4d3ClSPVjNXI+QuLq34ZUqKYuJO6/w4RNCSuXmTKhH8NuRdCHSNF/r59Mvlc
         5/sDjl2OddC9tkHDTkw3dIRGWM9SwdSXAzGtupyAvNOYMoUNp2sF5ZwUfq5M6t+vyFDJ
         Y+xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkbfoYtC2ZNUEFJlgi27uo5cTaXbeWs4gU52Uz9841gmOebTU/LCex77uLebysFVRjrExVvVmhWMzmafs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgGgkRG4SAat4Dut0PPKVQ+rud9vCu3yJUEo+2V4qNNIrImxtL
	N/XK954S3c9yDR4Hr24j9uZgJ/WKDz+HOln2GE7TcilDa3/aBL7ZtTgt
X-Gm-Gg: ASbGncvWjE4ndkGsOM3MzG7gCX7tWDe+DPTl1A5RH+y9L9xj8U0Hd3PCe5PaAjLc6w8
	5DWq78SExow/Lfcb51Gyd4DWVJeSO4lGrSG909qm3CXaaNa4lqa5ej0L7g6dTKCxzgUse9NwInL
	XNJI2AC3YzXkX+lpemX0HNVW5GnExVZO149M7ZNqCc2yK1J3AW0Cafln112sKj5nr51ha/6HasT
	jwbaZ9s+5xRRxBGuZ4rwgYzBO/+7lPncXXm72RHFQs673c7NwqtmTqvddn8DvjsaDDtBpmSmYo0
	d90SpXZFlz/MT3rjwXu4fNqJv1mQ0nic918VOiSzJGBkeNlyep1rOc4aRfcaUuKOVs99Ju6PA6m
	HtnyEzdPuif7252dZIWDu96BOC2QWpg/dmPleOQ3+Gd9Nt42+MfW6dm2DcgaBV5jU5anWNX2tT8
	b6
X-Google-Smtp-Source: AGHT+IEYSZ2S0C29Lk1HyWJPSBYF7rAZv73+WciDtcAyLcmFQZytQOHAcXqbTgBRFlgZtLq3VV3NaQ==
X-Received: by 2002:a05:620a:1034:b0:7e8:1f79:67a2 with SMTP id af79cd13be357-7e8588afcacmr90890785a.34.1754939186658;
        Mon, 11 Aug 2025 12:06:26 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b081827cd7sm89418081cf.7.2025.08.11.12.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 12:06:25 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>
Subject: [PATCH] sched/deadline: only set free_cpus for online runqueues
Date: Mon, 11 Aug 2025 12:05:36 -0700
Message-Id: <20250811190536.661884-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 16b269436b72 ("sched/deadline: Modify cpudl::free_cpus
to reflect rd->online") introduced the cpudl_set/clear_freecpu
functions to allow the cpu_dl::free_cpus mask to be manipulated
by the deadline scheduler class rq_on/offline callbacks so the
mask would also reflect this state.

Commit 9659e1eeee28 ("sched/deadline: Remove cpu_active_mask
from cpudl_find()") removed the check of the cpu_active_mask to
save some processing on the premise that the cpudl::free_cpus
mask already reflected the runqueue online state.

Unfortunately, there are cases where it is possible for the
cpudl_clear function to set the free_cpus bit for a CPU when the
deadline runqueue is offline. When this occurs while a CPU is
connected to the default root domain the flag may retain the bad
state after the CPU has been unplugged. Later, a different CPU
that is transitioning through the default root domain may push a
deadline task to the powered down CPU when cpudl_find sees its
free_cpus bit is set. If this happens the task will not have the
opportunity to run.

One example is outlined here:
https://lore.kernel.org/lkml/20250110233010.2339521-1-opendmb@gmail.com

Another occurs when the last deadline task is migrated from a
CPU that has an offlined runqueue. The dequeue_task member of
the deadline scheduler class will eventually call cpudl_clear
and set the free_cpus bit for the CPU.

This commit modifies the cpudl_clear function to be aware of the
online state of the deadline runqueue so that the free_cpus mask
can be updated appropriately.

It is no longer necessary to manage the mask outside of the
cpudl_set/clear functions so the cpudl_set/clear_freecpu
functions are removed. In addition, since the free_cpus mask is
now only updated under the cpudl lock the code was changed to
use the non-atomic __cpumask functions.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 kernel/sched/cpudeadline.c | 34 +++++++++-------------------------
 kernel/sched/cpudeadline.h |  4 +---
 kernel/sched/deadline.c    |  8 ++++----
 3 files changed, 14 insertions(+), 32 deletions(-)

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index cdd740b3f774..d612d5c6c61a 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -166,12 +166,13 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
  * cpudl_clear - remove a CPU from the cpudl max-heap
  * @cp: the cpudl max-heap context
  * @cpu: the target CPU
+ * @online: the online state of the deadline runqueue
  *
  * Notes: assumes cpu_rq(cpu)->lock is locked
  *
  * Returns: (void)
  */
-void cpudl_clear(struct cpudl *cp, int cpu)
+void cpudl_clear(struct cpudl *cp, int cpu, bool online)
 {
 	int old_idx, new_cpu;
 	unsigned long flags;
@@ -184,7 +185,7 @@ void cpudl_clear(struct cpudl *cp, int cpu)
 	if (old_idx == IDX_INVALID) {
 		/*
 		 * Nothing to remove if old_idx was invalid.
-		 * This could happen if a rq_offline_dl is
+		 * This could happen if rq_online_dl or rq_offline_dl is
 		 * called for a CPU without -dl tasks running.
 		 */
 	} else {
@@ -195,9 +196,12 @@ void cpudl_clear(struct cpudl *cp, int cpu)
 		cp->elements[new_cpu].idx = old_idx;
 		cp->elements[cpu].idx = IDX_INVALID;
 		cpudl_heapify(cp, old_idx);
-
-		cpumask_set_cpu(cpu, cp->free_cpus);
 	}
+	if (unlikely(!online))
+		__cpumask_clear_cpu(cpu, cp->free_cpus);
+	else
+		__cpumask_set_cpu(cpu, cp->free_cpus);
+
 	raw_spin_unlock_irqrestore(&cp->lock, flags);
 }
 
@@ -228,7 +232,7 @@ void cpudl_set(struct cpudl *cp, int cpu, u64 dl)
 		cp->elements[new_idx].cpu = cpu;
 		cp->elements[cpu].idx = new_idx;
 		cpudl_heapify_up(cp, new_idx);
-		cpumask_clear_cpu(cpu, cp->free_cpus);
+		__cpumask_clear_cpu(cpu, cp->free_cpus);
 	} else {
 		cp->elements[old_idx].dl = dl;
 		cpudl_heapify(cp, old_idx);
@@ -237,26 +241,6 @@ void cpudl_set(struct cpudl *cp, int cpu, u64 dl)
 	raw_spin_unlock_irqrestore(&cp->lock, flags);
 }
 
-/*
- * cpudl_set_freecpu - Set the cpudl.free_cpus
- * @cp: the cpudl max-heap context
- * @cpu: rd attached CPU
- */
-void cpudl_set_freecpu(struct cpudl *cp, int cpu)
-{
-	cpumask_set_cpu(cpu, cp->free_cpus);
-}
-
-/*
- * cpudl_clear_freecpu - Clear the cpudl.free_cpus
- * @cp: the cpudl max-heap context
- * @cpu: rd attached CPU
- */
-void cpudl_clear_freecpu(struct cpudl *cp, int cpu)
-{
-	cpumask_clear_cpu(cpu, cp->free_cpus);
-}
-
 /*
  * cpudl_init - initialize the cpudl structure
  * @cp: the cpudl max-heap context
diff --git a/kernel/sched/cpudeadline.h b/kernel/sched/cpudeadline.h
index 11c0f1faa7e1..d7699468eedd 100644
--- a/kernel/sched/cpudeadline.h
+++ b/kernel/sched/cpudeadline.h
@@ -19,8 +19,6 @@ struct cpudl {
 
 int  cpudl_find(struct cpudl *cp, struct task_struct *p, struct cpumask *later_mask);
 void cpudl_set(struct cpudl *cp, int cpu, u64 dl);
-void cpudl_clear(struct cpudl *cp, int cpu);
+void cpudl_clear(struct cpudl *cp, int cpu, bool online);
 int  cpudl_init(struct cpudl *cp);
-void cpudl_set_freecpu(struct cpudl *cp, int cpu);
-void cpudl_clear_freecpu(struct cpudl *cp, int cpu);
 void cpudl_cleanup(struct cpudl *cp);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e2d51f4306b3..ef91871b14d8 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1832,7 +1832,7 @@ static void dec_dl_deadline(struct dl_rq *dl_rq, u64 deadline)
 	if (!dl_rq->dl_nr_running) {
 		dl_rq->earliest_dl.curr = 0;
 		dl_rq->earliest_dl.next = 0;
-		cpudl_clear(&rq->rd->cpudl, rq->cpu);
+		cpudl_clear(&rq->rd->cpudl, rq->cpu, rq->online);
 		cpupri_set(&rq->rd->cpupri, rq->cpu, rq->rt.highest_prio.curr);
 	} else {
 		struct rb_node *leftmost = rb_first_cached(&dl_rq->root);
@@ -2878,9 +2878,10 @@ static void rq_online_dl(struct rq *rq)
 	if (rq->dl.overloaded)
 		dl_set_overload(rq);
 
-	cpudl_set_freecpu(&rq->rd->cpudl, rq->cpu);
 	if (rq->dl.dl_nr_running > 0)
 		cpudl_set(&rq->rd->cpudl, rq->cpu, rq->dl.earliest_dl.curr);
+	else
+		cpudl_clear(&rq->rd->cpudl, rq->cpu, true);
 }
 
 /* Assumes rq->lock is held */
@@ -2889,8 +2890,7 @@ static void rq_offline_dl(struct rq *rq)
 	if (rq->dl.overloaded)
 		dl_clear_overload(rq);
 
-	cpudl_clear(&rq->rd->cpudl, rq->cpu);
-	cpudl_clear_freecpu(&rq->rd->cpudl, rq->cpu);
+	cpudl_clear(&rq->rd->cpudl, rq->cpu, false);
 }
 
 void __init init_sched_dl_class(void)
-- 
2.34.1


