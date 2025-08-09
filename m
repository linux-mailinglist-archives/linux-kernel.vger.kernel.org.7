Return-Path: <linux-kernel+bounces-761214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 611E2B1F5D7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 20:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215ED3BE1B9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 18:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2072BEC53;
	Sat,  9 Aug 2025 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TeTDeRCV"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8930E146A72
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754765104; cv=none; b=mLL75uy/doEBffdUXzLupN6DqjlAsu8/iGU8bic43XOZtgCDrX37Dg77dh8FkWYY+fN37A/bIUXvvWqLdmh4zPnWDcwtwaDCd9Sllib0ZuN1YH0d61FpU0s1/5jSQe7Oj5A19exaRZAA6utHZnRRG7ZZoq4GJkYgs8i+47baiBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754765104; c=relaxed/simple;
	bh=xlYPx3rUiRif1vt0rmZ01ozsf1aifnE8niKIXf+1624=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EgJAive5QDWPonPQcwpd9D9b7bPaRfopmunFqaEeDraYm6sEvdkUDuYNNlKUUbFOt2rO2WOYZT9od+ojHOH/0ICFv4I7MY52gnTUgPY9pO1Sgq3f5KllSUGcX8QeDguQFb0TVPpnix3WZI6QRObV0s4ejhR5cm4XeWnBFOpL3YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TeTDeRCV; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qp
	8SVa1IxFlmm0KJl6asj4gWs4d8qTmrc7gFSCo0b/Y=; b=TeTDeRCVDlyeEnv6/C
	hYM/Z3a7q6JHUghPqhebM4pgEgGkqXtOTvgIDzv1dXWAl2jsJ57jA3L0l5NMO/sl
	uRujxUZhvZECR/MpvtSDt2FA146Omraeht9TH5dwR2Q+ouqaVHh3WHJhCraAlS+v
	UxDLg691rL7Wy7GJa4TT61wfI=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDn48YDl5doaAV+AQ--.44420S2;
	Sun, 10 Aug 2025 02:44:20 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
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
	Xin Zhao <jackzxcui1989@163.com>
Subject: [PATCH] sched/rt: Use prev_sum_exec_runtime to record the timeslice start time
Date: Sun, 10 Aug 2025 02:44:18 +0800
Message-Id: <20250809184418.2012584-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn48YDl5doaAV+AQ--.44420S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw17ZryfWrWrJr18ArWDurg_yoW5Jry7pF
	WDW347tw4DJ3WrtrW7Zws3uryYg393Kw17KFn0yw1UAr15G3W8KrsIgr42qF4j9rnYkF12
	vF40qwsru3WqvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRxWrJUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbioxekCmiXk2c7zwAAsl

For tasks in the fair scheduling class, we can register a sched_stat_runtime
tracepoint. When a periodic tick interrupt occurs, we can calculate the
difference between prev_sum_exec_runtime and sum_exec_runtime to determine
how long the current time slice has been running. However, for RT scheduling
class tasks, this is not possible because the value of prev_sum_exec_runtime
is not set when scheduling RT tasks, making it impossible to perform such a
difference calculation.
This detection is very meaningful because if a real-time task runs for too
long in a single time slice, it can significantly impact the overall system
state. For instance, it may prevent the rcu's gp_seq from updating in a
timely manner, and it may cause kworker and other system-level tasks to be
unable to get scheduled on time, which can further affect the entire system's
operation. Early identification of this issue can help the system make
functional safety decisions sooner, especially in the context of automotive
intelligent driving systems.
This change can be combined with tracepoints to extend the sensitive
detection of long-running time slices from fair scheduling class tasks to
RT tasks using the existing tick mechanism of the system. Without this
modification, we would only be able to check at a relatively later time,
such as during sched_switch, and RT tasks can sometimes run for a long time
when issues arise. Discovering system problems only during task switching is
not always a wise choice. Of course, we could use other means, such as adding
a high-resolution timer in a hard interrupt context to perform this detection,
but high-frequency hrtimers can impose a certain burden on the system. If we
can leverage the existing tick mechanism for such checks, it would be a
better approach.

Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
---
 kernel/sched/rt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7936d4333..8e4093a17 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1641,6 +1641,7 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 	struct sched_rt_entity *rt_se = &p->rt;
 	struct rt_rq *rt_rq = &rq->rt;
 
+	p->se.prev_sum_exec_runtime = p->se.sum_exec_runtime;
 	p->se.exec_start = rq_clock_task(rq);
 	if (on_rt_rq(&p->rt))
 		update_stats_wait_end_rt(rt_rq, rt_se);
-- 
2.34.1


