Return-Path: <linux-kernel+bounces-799441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E660B42BCF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C96547ED9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7A52EC090;
	Wed,  3 Sep 2025 21:23:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FCB2EBBA8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934614; cv=none; b=eXEH+NJEDgeEkISyJ22eMJDe1NansNvCMH6Arf7ni7K/XVX7wUBPNLdynKveiywku3Sb+nj2UZeTqAkrI9bSYmszFZ5ZQzsbR0zstCR6OLmqEEVsbIB2uYTPES1bpLJKpjOz5Zwcms+b1rK7y5XKbS7z0C/8oVp8QoYBJGAhVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934614; c=relaxed/simple;
	bh=B5JeQxB0xaaKDctXaK8S+6y0REKZuDCZibWyVPtHdCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UxYI9YNlK+PVELrqdmSgyFdyu8CCOFfAo7pUw//E/djX/U8CeZunK1neYYXZbZUylNQkGqi0gxJ09sz433DNnfoX81vlJruSyNnCCG67IowSJyUyDrEpigd52l17YQ9nbQeguD4FzhVHIatbhVakEZ6Fy2ZzJzNWlyxwTJu6mXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 315E51688;
	Wed,  3 Sep 2025 14:23:24 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.93.203])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B1A973F694;
	Wed,  3 Sep 2025 14:23:30 -0700 (PDT)
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
Subject: [PATCH v7 1/3] sched_ext: Introduce scx_bpf_locked_rq()
Date: Wed,  3 Sep 2025 22:23:09 +0100
Message-Id: <20250903212311.369697-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903212311.369697-1-christian.loehle@arm.com>
References: <20250903212311.369697-1-christian.loehle@arm.com>
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

Also mark the new scx_bpf_locked_rq() as returning NULL as
scx_bpf_cpu_rq() should've been too.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Acked-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c                       | 23 +++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 4ae32ef179dd..e15f1b0501a1 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7430,6 +7430,28 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
 	return cpu_rq(cpu);
 }
 
+/**
+ * scx_bpf_locked_rq - Return the rq currently locked by SCX
+ *
+ * Returns the rq if a rq lock is currently held by SCX.
+ * Otherwise emits an error and returns NULL.
+ */
+__bpf_kfunc struct rq *scx_bpf_locked_rq(void)
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
+BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_RET_NULL)
 #ifdef CONFIG_CGROUP_SCHED
 BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
 #endif
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index d4e21558e982..e9b006226cf6 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -91,6 +91,7 @@ s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
+struct rq *scx_bpf_locked_rq(void) __ksym;
 struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;
 u64 scx_bpf_now(void) __ksym __weak;
 void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
-- 
2.34.1


