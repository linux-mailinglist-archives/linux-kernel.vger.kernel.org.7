Return-Path: <linux-kernel+bounces-876098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92209C1A9DF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A362580752
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725A823506F;
	Wed, 29 Oct 2025 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="yKRGkRzD"
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D748213C8E8
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743245; cv=none; b=hZENX7dD7xo3dZjRcKcMje9WKgJaS8JE/cxkx1A0GM8b7WHBaI4YioSyT3ocR569Uzrd0+N9n+B6ssSqZ52Xx2qBY7v5R1XIGg47BCzFWrI3H6wdSe8Alcw10Ulpv/w5RSDY7LYhL9VVWaORj+G8fehM10jm2oNxIc/1OnIRQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743245; c=relaxed/simple;
	bh=IrVtMbUkX/LJ2VrECH5K26IrlIfd5WYjMA0jvgSGuy0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A1CV8KvYafB6Dr0I5PD0XBuId7HNAyPZ20tyNXgILqEKnFJWhQlwEpeTKgh38tr2bKi4nYxdC1cWloOp2qV8GI/QNtYXe4e40hh+vtfmqKAqM9B/qV4kiLCcQVWUd8CeogOKXgq1uGbLrm95xi0KO4SltT97fMr5mNpUbLwbLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=yKRGkRzD; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id F06189B0AA;
	Wed, 29 Oct 2025 13:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1761743242;
	bh=k3Ea24BoY1a35jbnCGKzd5DZASZKhlRwvTKw6rRYra8=;
	h=Date:From:To:Cc:Subject;
	b=yKRGkRzDFEhwjJ+KZ30a7/86JkI+1kP07Vc9XuQ2x6yKUkUVHefWueNO4OFyklwSZ
	 xaOpNx53BWmgH5qjku84kbYp9qsqhewjfxpPrq3pB0JAF8x95ldyoJaDw/w87rClox
	 0i2Y+b20QmeU0ZpbYYlXK6Kz7Kzr5K1771V6K6GY=
Date: Wed, 29 Oct 2025 13:07:15 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] sched/stats: Optimize /proc/schedstat printing
Message-ID: <aQIRg9EaBSX2rrGx@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Function seq_printf supports rich format string for decimals printing,
but there is no need for it in /proc/schedstat, since majority of the
data is space separared decimals. Use seq_put_decimal_ull instead as
faster alternative.

Performance counter stats (truncated) for sh -c 'cat /proc/schedstat >
/dev/null' before and after applying the patch from machine with 72 CPUs
are below.

Before:

      2.94 msec task-clock               #    0.820 CPUs utilized
         1      context-switches         #  340.551 /sec
         0      cpu-migrations           #    0.000 /sec
       340      page-faults              #  115.787 K/sec
10,327,200      instructions             #    1.89  insn per cycle
                                         #    0.10  stalled cycles per insn
 5,458,307      cycles                   #    1.859 GHz
 1,052,733      stalled-cycles-frontend  #   19.29% frontend cycles idle
 2,066,321      branches                 #  703.687 M/sec
    25,621      branch-misses            #    1.24% of all branches

0.00357974 +- 0.00000209 seconds time elapsed  ( +-  0.06% )

After:

      2.50 msec task-clock              #    0.785 CPUs utilized
         1      context-switches        #  399.780 /sec
         0      cpu-migrations          #    0.000 /sec
       340      page-faults             #  135.925 K/sec
 7,371,867      instructions            #    1.59  insn per cycle
                                        #    0.13  stalled cycles per insn
 4,647,053      cycles                  #    1.858 GHz
   986,487      stalled-cycles-frontend #   21.23% frontend cycles idle
 1,591,374      branches                #  636.199 M/sec
    28,973      branch-misses           #    1.82% of all branches

0.00318461 +- 0.00000295 seconds time elapsed  ( +-  0.09% )

This is ~11% (relative) improvement in time elapsed.

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 kernel/sched/stats.c | 86 ++++++++++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 34 deletions(-)

diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index d1c9429a4ac5..b304f821e8ff 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -98,6 +98,56 @@ void __update_stats_enqueue_sleeper(struct rq *rq, struct task_struct *p,
 	}
 }
 
+static void show_runqueue_stats(struct seq_file *seq, int cpu, struct rq *rq)
+{
+	seq_printf(seq, "cpu%d", cpu);
+	seq_put_decimal_ull(seq, " ", rq->yld_count);
+	seq_put_decimal_ull(seq, " ", 0);
+	seq_put_decimal_ull(seq, " ", rq->sched_count);
+	seq_put_decimal_ull(seq, " ", rq->sched_goidle);
+	seq_put_decimal_ull(seq, " ", rq->ttwu_count);
+	seq_put_decimal_ull(seq, " ", rq->ttwu_local);
+	seq_put_decimal_ull(seq, " ", rq->rq_cpu_time);
+	seq_put_decimal_ull(seq, " ", rq->rq_sched_info.run_delay);
+	seq_put_decimal_ull(seq, " ", rq->rq_sched_info.pcount);
+	seq_putc(seq, '\n');
+}
+
+static void show_domain_stats(struct seq_file *seq, int dcount,
+			      struct sched_domain *sd)
+{
+	enum cpu_idle_type itype;
+
+	seq_printf(seq, "domain%d %s %*pb", dcount, sd->name,
+		   cpumask_pr_args(sched_domain_span(sd)));
+	for (itype = 0; itype < CPU_MAX_IDLE_TYPES; itype++) {
+		seq_put_decimal_ull(seq, " ", sd->lb_count[itype]);
+		seq_put_decimal_ull(seq, " ", sd->lb_balanced[itype]);
+		seq_put_decimal_ull(seq, " ", sd->lb_failed[itype]);
+		seq_put_decimal_ull(seq, " ", sd->lb_imbalance_load[itype]);
+		seq_put_decimal_ull(seq, " ", sd->lb_imbalance_util[itype]);
+		seq_put_decimal_ull(seq, " ", sd->lb_imbalance_task[itype]);
+		seq_put_decimal_ull(seq, " ", sd->lb_imbalance_misfit[itype]);
+		seq_put_decimal_ull(seq, " ", sd->lb_gained[itype]);
+		seq_put_decimal_ull(seq, " ", sd->lb_hot_gained[itype]);
+		seq_put_decimal_ull(seq, " ", sd->lb_nobusyq[itype]);
+		seq_put_decimal_ull(seq, " ", sd->lb_nobusyg[itype]);
+	}
+	seq_put_decimal_ull(seq, " ", sd->alb_count);
+	seq_put_decimal_ull(seq, " ", sd->alb_failed);
+	seq_put_decimal_ull(seq, " ", sd->alb_pushed);
+	seq_put_decimal_ull(seq, " ", sd->sbe_count);
+	seq_put_decimal_ull(seq, " ", sd->sbe_balanced);
+	seq_put_decimal_ull(seq, " ", sd->sbe_pushed);
+	seq_put_decimal_ull(seq, " ", sd->sbf_count);
+	seq_put_decimal_ull(seq, " ", sd->sbf_balanced);
+	seq_put_decimal_ull(seq, " ", sd->sbf_pushed);
+	seq_put_decimal_ull(seq, " ", sd->ttwu_wake_remote);
+	seq_put_decimal_ull(seq, " ", sd->ttwu_move_affine);
+	seq_put_decimal_ull(seq, " ", sd->ttwu_move_balance);
+	seq_putc(seq, '\n');
+}
+
 /*
  * Current schedstat API version.
  *
@@ -121,44 +171,12 @@ static int show_schedstat(struct seq_file *seq, void *v)
 		rq = cpu_rq(cpu);
 
 		/* runqueue-specific stats */
-		seq_printf(seq,
-		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu",
-		    cpu, rq->yld_count,
-		    rq->sched_count, rq->sched_goidle,
-		    rq->ttwu_count, rq->ttwu_local,
-		    rq->rq_cpu_time,
-		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount);
-
-		seq_printf(seq, "\n");
+		show_runqueue_stats(seq, cpu, rq);
 
 		/* domain-specific stats */
 		rcu_read_lock();
 		for_each_domain(cpu, sd) {
-			enum cpu_idle_type itype;
-
-			seq_printf(seq, "domain%d %s %*pb", dcount++, sd->name,
-				   cpumask_pr_args(sched_domain_span(sd)));
-			for (itype = 0; itype < CPU_MAX_IDLE_TYPES; itype++) {
-				seq_printf(seq, " %u %u %u %u %u %u %u %u %u %u %u",
-				    sd->lb_count[itype],
-				    sd->lb_balanced[itype],
-				    sd->lb_failed[itype],
-				    sd->lb_imbalance_load[itype],
-				    sd->lb_imbalance_util[itype],
-				    sd->lb_imbalance_task[itype],
-				    sd->lb_imbalance_misfit[itype],
-				    sd->lb_gained[itype],
-				    sd->lb_hot_gained[itype],
-				    sd->lb_nobusyq[itype],
-				    sd->lb_nobusyg[itype]);
-			}
-			seq_printf(seq,
-				   " %u %u %u %u %u %u %u %u %u %u %u %u\n",
-			    sd->alb_count, sd->alb_failed, sd->alb_pushed,
-			    sd->sbe_count, sd->sbe_balanced, sd->sbe_pushed,
-			    sd->sbf_count, sd->sbf_balanced, sd->sbf_pushed,
-			    sd->ttwu_wake_remote, sd->ttwu_move_affine,
-			    sd->ttwu_move_balance);
+			show_domain_stats(seq, dcount++, sd);
 		}
 		rcu_read_unlock();
 	}
-- 
2.47.3


