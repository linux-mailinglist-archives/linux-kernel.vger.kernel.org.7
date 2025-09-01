Return-Path: <linux-kernel+bounces-794659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D032B3E4DD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2C71894B1B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D3C334397;
	Mon,  1 Sep 2025 13:26:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DA233438B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733178; cv=none; b=bPrDIHNwKLKCL2mtIi/oBwd0xS1fQUiWnt7nAd611w8LDXIdQwDuyX72ENFAexpZIr0GlU4IMcoHFUHrAzu5OOLQUu/WYk0NzYl75iRvAZBYyi+pBFg8SSOCEldVYTf21fxrdDUy51qIM3O0AjL75FKCGcyZ0yhgNhrSdl5bfKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733178; c=relaxed/simple;
	bh=ZgLcD+Uip94yvizlqHhEv7KW/s+A49+1dOGZmLQf2g8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c2GHMJFQE0CAGr9tCea1xtSTLCSqh+2bfJxrAqf1D0oPC9/CNT5h2iIOeMQus/QF2zsAxpHSh32DsbZDtKNro6iY9qFaeSzcMVCzDSpt0KDzYMs7CyaxnuF3r1BG/MdQX/acL5RMav6JpZno+aMKxc8/kGlPjc9X56qP3InCcA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7527B2680;
	Mon,  1 Sep 2025 06:26:07 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.36.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B4D23F694;
	Mon,  1 Sep 2025 06:26:14 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: tj@kernel.org,
	arighi@nvidia.com,
	void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	changwoo@igalia.com,
	hodgesd@meta.com,
	mingo@redhat.com,
	peterz@infradead.org,
	jake@hillion.co.uk,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v5 1/3] sched_ext: Introduce scx_bpf_cpu_rq_locked()
Date: Mon,  1 Sep 2025 14:26:02 +0100
Message-Id: <20250901132605.2282650-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901132605.2282650-1-christian.loehle@arm.com>
References: <20250901132605.2282650-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most fields in scx_bpf_cpu_rq() assume that its rq_lock is held.
Furthermore they become meaningless without rq lock, too.
Make a safer version of scx_bpf_cpu_rq() that only returns a rq
if we hold rq lock of that rq.

Also mark the new scx_bpf_cpu_rq_locked() as returning NULL.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/ext.c                       | 23 +++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 4ae32ef179dd..9fcc310d85d5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7430,6 +7430,28 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
 	return cpu_rq(cpu);
 }
 
+/**
+ * scx_bpf_cpu_rq_locked - Return the rq currently locked by SCX
+ *
+ * Returns the rq if a rq lock is currently held by SCX.
+ * Otherwise emits an error and returns NULL.
+ */
+__bpf_kfunc struct rq *scx_bpf_cpu_rq_locked(void)
+{
+	struct rq *rq;
+
+	preempt_disable();
+	rq = scx_locked_rq();
+	if (!rq) {
+		preempt_enable();
+		scx_kf_error("accessing rq without holding rq lock");
+		return NULL;
+	}
+	preempt_enable();
+
+	return rq;
+}
+
 /**
  * scx_bpf_task_cgroup - Return the sched cgroup of a task
  * @p: task of interest
@@ -7594,6 +7616,7 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
+BTF_ID_FLAGS(func, scx_bpf_cpu_rq_locked, KF_RET_NULL)
 #ifdef CONFIG_CGROUP_SCHED
 BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
 #endif
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index d4e21558e982..f5be06c93359 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -91,6 +91,7 @@ s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
+struct rq *scx_bpf_cpu_rq_locked(void) __ksym;
 struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;
 u64 scx_bpf_now(void) __ksym __weak;
 void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
-- 
2.34.1


