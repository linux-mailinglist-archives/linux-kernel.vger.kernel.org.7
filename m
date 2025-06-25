Return-Path: <linux-kernel+bounces-701237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9269AE7278
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 00:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E073B1C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 22:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B863B25A625;
	Tue, 24 Jun 2025 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BrVkqt/S"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187851F12E9
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 22:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750805368; cv=none; b=Q58cwACYgAIIOZpFmomQjxjuLMN/WWNLCVkzzRW9rbGDyuj11wyjuKZfeGNDhDijQIkvuzMjumiozw4iahddLRnpCqan9nu6Ft88Y4f63vedrOiHg6oZye443EFpRnhz7zhTDMNhx5rzd8mR2bVsHNXtGWEioFXlgF6yRxV9dIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750805368; c=relaxed/simple;
	bh=swAQJ7D6uR3+UHJ6FyNnFhWOPUR7IHCfJUMioFtwZKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eZMDLhw0I/zaGquRiwmkQR54QwWdbm4MJKgTg+x56J53UmB1Mlb87wyNhyWnUiM/ukyEVSmOTdrqFWmCmQUf23mGvY9Wo3WzX1zs8N+6SNQjxo7hLRIWHnqMMAQSrQKrZKArrXQDq27ZACVColaXtpOFB82o+CQq2JGw6bzGZPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BrVkqt/S; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750805353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=waCMU8XToJ4/O0TuOlz1/Eb71vMnpeZ9I1kTPcvNFP4=;
	b=BrVkqt/SNYzQXu4buoXkoHww1LOaEqIB5unHnPQSE5xvz3tkkCLr0Gt9P567oEeSyeRePq
	bBJ0YrvOT+rfTRZVC1Z5hTJYK3+bLAP8l3qJ8IYkdOspcXTgZQmsr1D5FdojOpD0EmMkLh
	WS072j3hOOSkDOIdBM2YrnryccI12Mc=
From: David Dai <david.dai@linux.dev>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	paulmck@kernel.org
Cc: david.dai@linux.dev,
	davidai@meta.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH] sched_ext, rcu: Eject BPF scheduler on RCU CPU stall panic
Date: Tue, 24 Jun 2025 15:49:06 -0700
Message-ID: <20250624224906.3662221-1-david.dai@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

For systems using a sched_ext scheduler and has panic_on_rcu_stall
enabled, try kicking out the current scheduler before issuing a panic.

While there are numerous reasons for RCU CPU stalls that are not
directly attributed to the scheduler, deferring the panic gives
sched_ext an opportunity to provide additional debug info when ejecting
the current scheduler. Also, handling the event more gracefully allows
us to potentially recover the system instead of incurring additional
down time.

Suggested-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: David Dai <david.dai@linux.dev>
---
 include/linux/sched/ext.h |  2 ++
 kernel/rcu/tree_stall.h   |  7 +++++++
 kernel/sched/ext.c        | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 8b92842776cb..0cf0915572c9 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -206,12 +206,14 @@ struct sched_ext_entity {
 void sched_ext_free(struct task_struct *p);
 void print_scx_info(const char *log_lvl, struct task_struct *p);
 void scx_softlockup(u32 dur_s);
+bool scx_rcu_cpu_stall(void);
 
 #else	/* !CONFIG_SCHED_CLASS_EXT */
 
 static inline void sched_ext_free(struct task_struct *p) {}
 static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
 static inline void scx_softlockup(u32 dur_s) {}
+static inline bool scx_rcu_cpu_stall(void) { return false; }
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */
 
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 486c00536207..af61b2d0d311 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -134,6 +134,13 @@ static void panic_on_rcu_stall(void)
 {
 	static int cpu_stall;
 
+	/*
+	 * Attempt to kick out the BPF scheduler if it's installed and defer
+	 * the panic to give the system a chance to recover.
+	 */
+	if (scx_rcu_cpu_stall())
+		return;
+
 	if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
 		return;
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index bee98fdcdd01..df5b2c952cf7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4672,6 +4672,41 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
 		p->sched_class != &ext_sched_class;
 }
 
+/**
+ * scx_rcu_cpu_stall - sched_ext RCU CPU stall handler
+ *
+ * While there are various reasons why RCU CPU stalls can occur on a system
+ * that may not be caused by the current BPF scheduler, try kicking out the
+ * current scheduler in an attempt to recover the system to a good state before
+ * issuing panics.
+ */
+bool scx_rcu_cpu_stall(void)
+{
+	struct scx_sched *sch;
+
+	rcu_read_lock();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch)) {
+		rcu_read_unlock();
+		return false;
+	}
+
+	switch (scx_enable_state()) {
+	case SCX_ENABLING:
+	case SCX_ENABLED:
+		break;
+	default:
+		rcu_read_unlock();
+		return false;
+	}
+
+	scx_error(sch, "RCU CPU stall detected!");
+	rcu_read_unlock();
+
+	return true;
+}
+
 /**
  * scx_softlockup - sched_ext softlockup handler
  * @dur_s: number of seconds of CPU stuck due to soft lockup
-- 
2.47.1


