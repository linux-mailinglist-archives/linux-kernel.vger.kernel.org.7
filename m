Return-Path: <linux-kernel+bounces-899271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DF8C5741A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2432A3ACEB9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08F533892C;
	Thu, 13 Nov 2025 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EyydNcHn"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECA53112BB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034273; cv=none; b=U3LpuA6xWFNhEXPf3R1rG2NmCQYxf4xnrJJPTK0o/1VeyNW7wh848sV3giFIOxDS/0i400RZR5grRjNiea5W6JhFjbRNOMlHqBFHEwloJHVokglwD4M2q5gQW7BsRJVuKsKo+CyVRVT2mrnkpg07+1m1mNoBeoS3qjBwsSiBk3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034273; c=relaxed/simple;
	bh=cayhevHlhqpCkcyseaRFmNDhVj8QyOhC36i7FYExAfA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=nbR001WMiQTUyr5brOgqg1VR2MB9rQ2Ij4tYPsErbi6USKAor5OkhfgEOClhyXbPYrrQYfWo1gSFSKD3P+MD9WpMiuO3Uhnbh1N2K8q3p6z+mmOaOSrTOIKO3ll9tXGmitA+V2ydtGFbjYi8eii7ySwGWuSXAD6dH7HL7bsD4J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EyydNcHn; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763034259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=OpSEyujv6xez7n2B9Rt5/pmDqH1hHhrLwBlVTGozI5Y=;
	b=EyydNcHnigncRiI/sA5/DuUq+ar8c4s8T3lyQwXyMMeWZFAExFhkcfQfE1Mc+JK7iN34sX
	/IGYD6DTru5dFOVvxy5Rr5vx53xDF4FdLmKOiXh4XpbuXWZFbOh6+Y0h6+hXMoHHzNvfID
	C5mnFt+WRGSzLbThX7DgQ6cSctG+cHQ=
From: Zqiang <qiang.zhang@linux.dev>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev
Subject: [PATCH] sched_ext: Fix possible deadlock in the deferred_irq_workfn()
Date: Thu, 13 Nov 2025 19:43:55 +0800
Message-Id: <20251113114355.24572-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

For PREEMPT_RT=y kernels, the deferred_irq_workfn() is executed in
the per-cpu irq_work/* task context and not disable-irq, if the rq
returned by container_of() is current CPU's rq, the following scenarios
may occur:

lock(&rq->__lock);
<Interrupt>
  lock(&rq->__lock);

This commit use IRQ_WORK_INIT_HARD() to replace init_irq_work() to
initialize rq->scx.deferred_irq_work, make the deferred_irq_workfn()
is always invoked in hard-irq context.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2b0e88206d07..747b0d8528ab 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5225,7 +5225,7 @@ void __init init_sched_ext_class(void)
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_kick_if_idle, GFP_KERNEL, n));
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_preempt, GFP_KERNEL, n));
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_wait, GFP_KERNEL, n));
-		init_irq_work(&rq->scx.deferred_irq_work, deferred_irq_workfn);
+		rq->scx.deferred_irq_work = IRQ_WORK_INIT_HARD(deferred_irq_workfn);
 		init_irq_work(&rq->scx.kick_cpus_irq_work, kick_cpus_irq_workfn);
 
 		if (cpu_online(cpu))
-- 
2.17.1


