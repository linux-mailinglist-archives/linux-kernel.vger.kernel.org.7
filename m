Return-Path: <linux-kernel+bounces-843683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C26BBBFFD4
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE3F3C1FDA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FF51FAC4B;
	Tue,  7 Oct 2025 01:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVLcxT/r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17CE1F4C90;
	Tue,  7 Oct 2025 01:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759801910; cv=none; b=cY8UOEsj+4Hu6uwOa4TFOsO/sTLSMnWQiFRpnqhMM1cY77IfFR/h6/URL1oBxAl1bvawK2PlUut20DFYk1hKs1aUXxyhZjFojl8j6BS7i0YsXKnlY02mACle0QwNfQ0wOeQeGWS74lhB8JvxKFOBINrrGPFk/3bLPZ9Nmk8akck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759801910; c=relaxed/simple;
	bh=BO5AG96qA6EqANjF+42/EFcSL7IaL/WGEPS/8QWyZhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKLqqcSMeZ2VJEFf1CUAR3A5Vl0/fkviboKqOwateIOTlB+vE5IyxOdGgHtiifca79Ue8jpnVcrulGpTlB3P/FLjreRqNIKjfDFlsg1KFGx5+TG0rIZRX218rKIAHnneMGlYV8dLt6obhQa0UqN4RZml0VNJcxi5kp7fLnC3b9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVLcxT/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8235BC116C6;
	Tue,  7 Oct 2025 01:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759801910;
	bh=BO5AG96qA6EqANjF+42/EFcSL7IaL/WGEPS/8QWyZhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kVLcxT/rDh26C8w2+bbHzjbnTILUAqTFexDjm7hPDUVVVMX870+OuihHdHnrWabnD
	 LKj+B8ujk+elJQxRZfZzzzHAcQp1n7umkSkYkC3neC7+LUI2sAfRiGv2y2i0OMMj4C
	 vQtXsXnokJHg3enryoEokOaHhOBhDIuzVSiFu3FY7rUyQqA0hpIOsLq4YJNB+iDxz2
	 xbBUxIEyAFZDlZChHvYjOOE88AcEyD7J61wfoqw26PBBsTAun2aNhccfaA0CfC9nBs
	 Q5bZ8ze+2kOMRSZgjrO8LalR/WEBifAvUbP2g8Oy3HLYyQhvgsmDLOPdv8xTW2pcpK
	 FyxjdfIFxIdeQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/4] sched_ext: Add scx_bpf_task_set_slice() and scx_bpf_task_set_dsq_vtime()
Date: Mon,  6 Oct 2025 15:51:45 -1000
Message-ID: <20251007015147.2496026-3-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007015147.2496026-1-tj@kernel.org>
References: <20251007015147.2496026-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the planned hierarchical scheduler support, sub-schedulers will need to
be verified for authority before being allowed to modify task->scx.slice and
task->scx.dsq_vtime. Add scx_bpf_task_set_slice() and
scx_bpf_task_set_dsq_vtime() which will perform the necessary permission
checks.

Root schedulers can still directly write to these fields, so this doesn't
affect existing schedulers.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c                       | 30 ++++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index fc353b8d69f7..6d76efaaa9b2 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5833,6 +5833,34 @@ static const struct btf_kfunc_id_set scx_kfunc_set_unlocked = {
 
 __bpf_kfunc_start_defs();
 
+/**
+ * scx_bpf_task_set_slice - Set task's time slice
+ * @p: task of interest
+ * @slice: time slice to set in nsecs
+ *
+ * Set @p's time slice to @slice. Returns %true on success, %false if the
+ * calling scheduler doesn't have authority over @p.
+ */
+__bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice)
+{
+	p->scx.slice = slice;
+	return true;
+}
+
+/**
+ * scx_bpf_task_set_dsq_vtime - Set task's virtual time for DSQ ordering
+ * @p: task of interest
+ * @vtime: virtual time to set
+ *
+ * Set @p's virtual time to @vtime. Returns %true on success, %false if the
+ * calling scheduler doesn't have authority over @p.
+ */
+__bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime)
+{
+	p->scx.dsq_vtime = vtime;
+	return true;
+}
+
 static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 {
 	struct rq *this_rq;
@@ -6638,6 +6666,8 @@ __bpf_kfunc void scx_bpf_events(struct scx_event_stats *events,
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_any)
+BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_RCU);
+BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 06e2551033cb..505231b7b7ae 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -102,6 +102,8 @@ s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_allowed, int node, u64 flags
 s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
+bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice) __ksym __weak;
+bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime) __ksym __weak;
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
 struct rq *scx_bpf_locked_rq(void) __ksym;
 struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym __weak;
-- 
2.51.0


