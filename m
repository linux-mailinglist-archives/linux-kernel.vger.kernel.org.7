Return-Path: <linux-kernel+bounces-769868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4FEB274A1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 931977A274B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9852BAF9;
	Fri, 15 Aug 2025 01:16:31 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4022D1FB3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220591; cv=none; b=RENr8ZTZyeH3stfz6M2yFlLUPByx7Bikr+g4cbHMD1vgGxVyQpbYCeTPYEY/inFla6gAFz2OE1vMt6P1VfXb8xEonV119tld2GwpKXH3niVjeEY/sji/Xo6lg7SiPW0ehFPK0xtLwsDOBSty3Jk8bEGNWLuGl+feWmDxE9ojTBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220591; c=relaxed/simple;
	bh=qkyFepM8nQB4AAgXDc1BusyYpbmsHD3p4f1U9Ix8jlQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NDAARFCCOaybRkRtsJ3UKuJRZhtXy0McZCBTOW/GcUtWk2PHM0ItDyJZcysr4QOiyLDuLyl1EFAphjjBazWGAFfPHDHX/aeY3bmrvwY9T7L6JDWnmjN7X4JmOR49I32PKgX9/5hwhY1jsLMx7hEf6TVCh5l+00s7vGjMj08njiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] sched/fair: Optimize CPU iteration using for_each_cpu_and[not]
Date: Fri, 15 Aug 2025 09:15:12 +0800
Message-ID: <20250815011512.6870-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc4.internal.baidu.com (172.31.3.14) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Replace open-coded CPU iteration patterns with more efficient
for_each_cpu_and() and for_each_cpu_andnot() macros in three locations.

This change both simplifies the code and provides minor performance
improvements by using the more specialized iteration macros.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 kernel/sched/fair.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a05..8794581 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1389,10 +1389,7 @@ static inline bool is_core_idle(int cpu)
 #ifdef CONFIG_SCHED_SMT
 	int sibling;
 
-	for_each_cpu(sibling, cpu_smt_mask(cpu)) {
-		if (cpu == sibling)
-			continue;
-
+	for_each_cpu_andnot(sibling, cpu_smt_mask(cpu), cpumask_of(cpu)) {
 		if (!idle_cpu(sibling))
 			return false;
 	}
@@ -2474,11 +2471,7 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 		maymove = !load_too_imbalanced(src_load, dst_load, env);
 	}
 
-	for_each_cpu(cpu, cpumask_of_node(env->dst_nid)) {
-		/* Skip this CPU if the source task cannot migrate */
-		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
-			continue;
-
+	for_each_cpu_and(cpu, cpumask_of_node(env->dst_nid), env->p->cpus_ptr) {
 		env->dst_cpu = cpu;
 		if (task_numa_compare(env, taskimp, groupimp, maymove))
 			break;
@@ -7493,10 +7486,7 @@ void __update_idle_core(struct rq *rq)
 	if (test_idle_cores(core))
 		goto unlock;
 
-	for_each_cpu(cpu, cpu_smt_mask(core)) {
-		if (cpu == core)
-			continue;
-
+	for_each_cpu_andnot(cpu, cpu_smt_mask(core), cpumask_of(core)) {
 		if (!available_idle_cpu(cpu))
 			goto unlock;
 	}
-- 
2.9.4


