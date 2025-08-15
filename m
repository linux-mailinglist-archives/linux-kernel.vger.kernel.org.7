Return-Path: <linux-kernel+bounces-769873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A7BB274AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB17D1CC6089
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FD681ACA;
	Fri, 15 Aug 2025 01:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYAnLUtX"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D400F8821
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220977; cv=none; b=JrQhyJ0I7hiKWjkBLHJByodYncUoRUA3PLTNtfk51JEsjX6Za5AsqCEgh0XkY2PBfuPV4uKpYaVlv9HhXefuMy9kty8ZR1nvWCyBsVaZzl9wJhHpIOzcvBZgy9zCfJh+oViLrNwEN01m74V67hE2NVtm3HrCWyqOfxebaG+b8Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220977; c=relaxed/simple;
	bh=gQJj3YTb0Mz1xhzW0voD9jTrfc1FgrKPq5/cDmms9js=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i2yq102BQWaprYX15Z5HlEwht7v1gTmZ2N1mf67ezL5gY91UDzEm1OKY2u0kWTV+qS61vorW0VoL+2BHKSwLFnjYJGoDnnml8T5cew9oCwCmPXkWs4m8uHjB6P8jxVOH09rzNld85IBigggH84w9s55oPAMG+910ApO+t6Y9so0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYAnLUtX; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b0faa6601cso27102371cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755220974; x=1755825774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iBuRxfe/z5wW3xGNVl5YcXioAUhr3ZX9GpN13ARzbTU=;
        b=BYAnLUtXjDIQLKjuTghAShtRqjmqfkYHYINKx5MdUk8Patir9fB5KgXjxHBSIw9voR
         SrJJm4M7U/VHMornY0hIiCV433jSuEljm05EcO19GhsTmOXqgPJ0ny2tKH3eezmZZH7X
         laSwutuAmT2oxaYDpmcVpoZ0sd7E38aA3GNNR1QTi1Ccgam5mt0q33Hfr4EOLFAQVbR4
         AbVWBrKbYOfDZqCd+UDvyaKrXWkjy5mGzkUP4UHVVPLLf4+6APHZRN3Y00/YI8JBZYoA
         ghSZgondaAUDEsTtAVVb3nMuUJYGxZsz40982k1T5W3vjMo0yYy797yyld4P28bRaFO5
         FYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220974; x=1755825774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iBuRxfe/z5wW3xGNVl5YcXioAUhr3ZX9GpN13ARzbTU=;
        b=b7R/kuCKKkBpdKGAIg/+yGLkD9qsEnKyQ18Zjre0HFp0FNZ0gcbaIFVpfBbNVMYF7J
         14eUbooCzrkxDgb+vCeVAakfK/UxPSrZmlo8gw81VfbsnbI0dEFUywjdhpknwgqFeCUg
         R5pQFHh1FHYkxoUubUbxRb4A3SH1RdRKxpDPXWe+ozP+Hry+iYq/lpWHudkEFaZJJ1Jd
         ttUSc/nX8cDz4TWmkQC7lTcIQTzullU/47rb4gHmtn+D+80voGgDQpzkk2OJS/Yx/scW
         B3JFNy4SAA2sv415JMX4YyUlxraF30E8Coik7YLouAC8066WQxmGnFrq7rUwg51s7qVg
         mVLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6adJorq5AkB+cEwMPQlk/b/NmLfr7bsBzJWfxoYBMgvphjzJ9mMRNErNmdlENnKMULl+RQmhtaI9WZ30=@vger.kernel.org
X-Gm-Message-State: AOJu0YweOIYEzyHADSwNTkPbKk3pw2Ni70KovgEcOi7o7Bh3FRQ13GvY
	d5vrf6E4Pxbmh4Gbe68RoMdfli4rAGsZ5/a8taSLseIDdZFdyB48/YvU
X-Gm-Gg: ASbGncuDw7w8Rlx/aE8VtaSEBTniUA28YyBqAu+vUZEquIqM9XoREYc5jm8W7I98h9e
	pcPJ73qQvfKvhmP21XzdvWnl+fDG/8Wy1LXr3NwAhAoCYQVqbt9ZC0aihopUVvpmAGBLlwJ/mMT
	zrtzR4Iw/8Unm4E7C+efJ+9w9+FV3AbikZ1xzkOsN8Io6ej8rAWXtMgo5Dj/Uaz7A+UtVZvVzWU
	PMYDGSnrDClkuzgFl9Y9WGp2s0cA3QVHbr5H08W3FbP4Oi8DbGa+19DfSoyfuSA9pmNQUkkObT+
	eda1HkHPv9dmVzeXa1LbSfhB4h1l79HpHV9agLbJ7r5PFH8Gll6FewBRhyFuVtNo9Csx5l62eDL
	tRT1XVHpp1DV6hIGfQIOifjUQE8ykZXJcLunKtNHKTTKVH/iSvpzLZ0EWoHq2kDtoOQ==
X-Google-Smtp-Source: AGHT+IGLeZybdCaAun60ZOr3On1COSQP39aFqI9vXjQRgYZ1okapnQNQfTpYa/aOsJJexULA09VDYg==
X-Received: by 2002:a05:622a:1346:b0:4b0:ed76:3720 with SMTP id d75a77b69052e-4b11d1b1992mr5621731cf.9.1755220974366;
        Thu, 14 Aug 2025 18:22:54 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc5b57fsm1445771cf.18.2025.08.14.18.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:22:53 -0700 (PDT)
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
Subject: [PATCH v2] sched/deadline: only set free_cpus for online runqueues
Date: Thu, 14 Aug 2025 18:22:36 -0700
Message-Id: <20250815012236.4053467-1-opendmb@gmail.com>
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
Change in v2:
  Inverted the logic of the online check in cpudl_clear.

 kernel/sched/cpudeadline.c | 34 +++++++++-------------------------
 kernel/sched/cpudeadline.h |  4 +---
 kernel/sched/deadline.c    |  8 ++++----
 3 files changed, 14 insertions(+), 32 deletions(-)

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index cdd740b3f774..37b572cc8aca 100644
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
+	if (likely(online))
+		__cpumask_set_cpu(cpu, cp->free_cpus);
+	else
+		__cpumask_clear_cpu(cpu, cp->free_cpus);
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


