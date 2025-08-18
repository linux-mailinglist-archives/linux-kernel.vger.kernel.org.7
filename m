Return-Path: <linux-kernel+bounces-773599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D208B2A204
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3351E3A898A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167ED26F29D;
	Mon, 18 Aug 2025 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mob6ZTVN"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C158F3218DA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521245; cv=none; b=VXfMaax/0KP4p8ekr25J9STbUBZ1BK+Bv5ZoSyuhxMFwKsk03iLZwdceNY9cZ9lDEmE1i3X5X4AkkqJGi1UP0OHJ4VwC7uG8Qp2XSG8cIQ2u711pt8ACe6yxFt00s8FeKvpH892n7jNwFKD2loZoWPIMSoeOFjODs2XLjOxoEyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521245; c=relaxed/simple;
	bh=ziNuDJPFgkV499fIzFHozEfsCpCyKEu3TAleA8yHsNc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n9H7Qy9gjoEyVJ2hE7yogpvSjZRxSUtRuR6VUGlRMfE9yodgBxOi/5iG0SaV2SvQY9PeQ2pMLWzWa+uwpoALjodYF6DmoHvMlKQkWnKDGQ74PDbeCkp/TmJGqcHrATB+mT6BfKct6fv9S82p2UDLJ2NTDxDy7m9QHCrm68FPtm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mob6ZTVN; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755521238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4k9g/c5HGOWuI7zMBJbr5oPSHWVBPCB9+ekSdZV/mZk=;
	b=mob6ZTVNjI/LkWqABiZCl+y9Q6hMoYRrVDGCmGLCY6xFjCZgSlhkxT4L15gwJbgNbLOIea
	+c6KbOGUa72StEoHcUd6rhQ4625it/Z5/6P2+iGdlPIMMvaCyOim2nfDptMpiVKR5t9Tba
	JiNKUKSEJRWWI60aSI3AC1I4zcFucBg=
From: Chengming Zhou <chengming.zhou@linux.dev>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	chengming.zhou@linux.dev
Subject: [RFC PATCH] sched/fair: Remove sched_idle_cpu() usages in select_task_rq_fair()
Date: Mon, 18 Aug 2025 20:47:02 +0800
Message-Id: <20250818124702.163271-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

These sched_idle_cpu() considerations in select_task_rq_fair() is based
on an assumption that the wakee task can pick a cpu running sched_idle
task and preempt it to run, faster than picking an idle cpu to preempt
the idle task.

This assumption is correct, but it also brings some problems:

1. work conservation: Often sched_idle tasks are also picking the cpu
which is already running sched_idle task, instead of utilizing a real
idle cpu, so work conservation is somewhat broken.

2. sched_idle group: This sched_idle_cpu() is just not correct with
sched_idle group running. Look a simple example below.

		root
	/		\
	kubepods	system
	/	\
burstable	besteffort
		(cpu.idle == 1)

When a sched_idle cpu is just running tasks from besteffort group,
sched_idle_cpu() will return true in this case, but this cpu pick
is bad for wakee task from system group. Because the system group
has lower weight than kubepods, work conservation is somewhat
broken too.

In a nutshell, sched_idle_cpu() should consider the wakee task group's
relationship with sched_idle tasks running on the cpu.

Obviously, it's hard to do so. This patch chooses the simple approach
to remove all sched_idle_cpu() considerations in select_task_rq_fair()
to bring back work conservation in these cases.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 kernel/sched/fair.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..d9de63cdc314 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7355,9 +7355,6 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
 		if (!sched_core_cookie_match(rq, p))
 			continue;
 
-		if (sched_idle_cpu(i))
-			return i;
-
 		if (available_idle_cpu(i)) {
 			struct cpuidle_state *idle = idle_get_state(rq);
 			if (idle && idle->exit_latency < min_exit_latency) {
@@ -7446,7 +7443,7 @@ static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct tas
 
 static inline int __select_idle_cpu(int cpu, struct task_struct *p)
 {
-	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
+	if (available_idle_cpu(cpu) &&
 	    sched_cpu_cookie_match(cpu_rq(cpu), p))
 		return cpu;
 
@@ -7519,13 +7516,9 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
 		if (!available_idle_cpu(cpu)) {
 			idle = false;
-			if (*idle_cpu == -1) {
-				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, cpus)) {
-					*idle_cpu = cpu;
-					break;
-				}
+			if (*idle_cpu == -1)
 				continue;
-			}
+
 			break;
 		}
 		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, cpus))
@@ -7555,7 +7548,7 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 		 */
 		if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
 			continue;
-		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
+		if (available_idle_cpu(cpu))
 			return cpu;
 	}
 
@@ -7677,7 +7670,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	for_each_cpu_wrap(cpu, cpus, target) {
 		unsigned long cpu_cap = capacity_of(cpu);
 
-		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
+		if (!available_idle_cpu(cpu))
 			continue;
 
 		fits = util_fits_cpu(task_util, util_min, util_max, cpu);
@@ -7748,7 +7741,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 */
 	lockdep_assert_irqs_disabled();
 
-	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
+	if (available_idle_cpu(target) &&
 	    asym_fits_cpu(task_util, util_min, util_max, target))
 		return target;
 
@@ -7756,7 +7749,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
 	if (prev != target && cpus_share_cache(prev, target) &&
-	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
+	    available_idle_cpu(prev) &&
 	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
 
 		if (!static_branch_unlikely(&sched_cluster_active) ||
@@ -7788,7 +7781,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
 	    cpus_share_cache(recent_used_cpu, target) &&
-	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
+	    available_idle_cpu(recent_used_cpu) &&
 	    cpumask_test_cpu(recent_used_cpu, p->cpus_ptr) &&
 	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
 
-- 
2.20.1


