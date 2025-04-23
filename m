Return-Path: <linux-kernel+bounces-617207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71543A99C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 01:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E69B3ADF33
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 23:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A6A262FE6;
	Wed, 23 Apr 2025 23:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxHPGqLW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C9F2620C3
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 23:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745451957; cv=none; b=ra2ordl530/2ZOD4tLOzbuRWHHGUfATNB929+NZy5SsSwN1z3MO02t5ao78rhvS/eoIt4W7P2R7FwrdpPRUes/1Zk1LFA8SQcXFBLA8r/sRJZD+M/KxrPbvcjAofKcOCpSN6z1im2OsDqjKmAlPggW79gKBZlgU5rZxzVbTZ5iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745451957; c=relaxed/simple;
	bh=Y6fptssCVzF+ZMR09N+MM95qFggzX5ES4xLOV4h9IQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8RzdS+rSXgurTCIAU5n3ojN4lZpsgxlOsFQrAlWilCkS9K6F4gY3MY3xzcoeaiyy0nftp4Wv7v1ns100juTV3Qwx1YfTNJY8sRUBGHtVG+TGADoScjvr7iX/0qdXg/G3WNjSPw7VY6h2UePqJwSSh8qS1AUfVAZiz99EWN6TJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxHPGqLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFE2C4CEEA;
	Wed, 23 Apr 2025 23:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745451956;
	bh=Y6fptssCVzF+ZMR09N+MM95qFggzX5ES4xLOV4h9IQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JxHPGqLWgQZfOl8zB6KXsAyKwnYl3oF3DM71ElRN7oyb3nqmO5YCq2247sa8c9Yeo
	 2FjsgfE1Yir7QkXOCbz99Wk7gSow5dSv95aU+MIiqyCFSLIbYvTr+9luRAmKo5RqPy
	 WHUrejURAM2EZyy4RDlzx9N3UTrMP4khMzDaT7BltssZ8PzmVIG0TZCoNlHXByovzs
	 kmJjYxzIw4n8mbeABe+WedmRu+J8Bu7hZqPxOK1pxUWCqQhKZNxjItcmf5xm/wpRiC
	 ynIQSL5c9TsGDiFiG7BqjCeQm9i08xEDPP0j4+ybTqIoOgyDup3l0f5zS+DlDM9fcs
	 w7HEMt+Ci+tvg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/12] sched_ext: Relocate scx_event_stats definition
Date: Wed, 23 Apr 2025 13:44:46 -1000
Message-ID: <20250423234542.1890867-9-tj@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423234542.1890867-1-tj@kernel.org>
References: <20250423234542.1890867-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In prepration of moving event_stats_cpu into scx_sched, move scx_event_stats
definitions above scx_sched definition. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 114 ++++++++++++++++++++++-----------------------
 1 file changed, 57 insertions(+), 57 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5beb2dd868ad..244ccf134cee 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -763,6 +763,63 @@ enum scx_opi {
 	SCX_OPI_END			= SCX_OP_IDX(init),
 };
 
+/*
+ * Collection of event counters. Event types are placed in descending order.
+ */
+struct scx_event_stats {
+	/*
+	 * If ops.select_cpu() returns a CPU which can't be used by the task,
+	 * the core scheduler code silently picks a fallback CPU.
+	 */
+	s64		SCX_EV_SELECT_CPU_FALLBACK;
+
+	/*
+	 * When dispatching to a local DSQ, the CPU may have gone offline in
+	 * the meantime. In this case, the task is bounced to the global DSQ.
+	 */
+	s64		SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE;
+
+	/*
+	 * If SCX_OPS_ENQ_LAST is not set, the number of times that a task
+	 * continued to run because there were no other tasks on the CPU.
+	 */
+	s64		SCX_EV_DISPATCH_KEEP_LAST;
+
+	/*
+	 * If SCX_OPS_ENQ_EXITING is not set, the number of times that a task
+	 * is dispatched to a local DSQ when exiting.
+	 */
+	s64		SCX_EV_ENQ_SKIP_EXITING;
+
+	/*
+	 * If SCX_OPS_ENQ_MIGRATION_DISABLED is not set, the number of times a
+	 * migration disabled task skips ops.enqueue() and is dispatched to its
+	 * local DSQ.
+	 */
+	s64		SCX_EV_ENQ_SKIP_MIGRATION_DISABLED;
+
+	/*
+	 * Total number of times a task's time slice was refilled with the
+	 * default value (SCX_SLICE_DFL).
+	 */
+	s64		SCX_EV_REFILL_SLICE_DFL;
+
+	/*
+	 * The total duration of bypass modes in nanoseconds.
+	 */
+	s64		SCX_EV_BYPASS_DURATION;
+
+	/*
+	 * The number of tasks dispatched in the bypassing mode.
+	 */
+	s64		SCX_EV_BYPASS_DISPATCH;
+
+	/*
+	 * The number of times the bypassing mode has been activated.
+	 */
+	s64		SCX_EV_BYPASS_ACTIVATE;
+};
+
 struct scx_sched {
 	struct sched_ext_ops	ops;
 	DECLARE_BITMAP(has_op, SCX_OPI_END);
@@ -1539,63 +1596,6 @@ static struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter)
 	return p;
 }
 
-/*
- * Collection of event counters. Event types are placed in descending order.
- */
-struct scx_event_stats {
-	/*
-	 * If ops.select_cpu() returns a CPU which can't be used by the task,
-	 * the core scheduler code silently picks a fallback CPU.
-	 */
-	s64		SCX_EV_SELECT_CPU_FALLBACK;
-
-	/*
-	 * When dispatching to a local DSQ, the CPU may have gone offline in
-	 * the meantime. In this case, the task is bounced to the global DSQ.
-	 */
-	s64		SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE;
-
-	/*
-	 * If SCX_OPS_ENQ_LAST is not set, the number of times that a task
-	 * continued to run because there were no other tasks on the CPU.
-	 */
-	s64		SCX_EV_DISPATCH_KEEP_LAST;
-
-	/*
-	 * If SCX_OPS_ENQ_EXITING is not set, the number of times that a task
-	 * is dispatched to a local DSQ when exiting.
-	 */
-	s64		SCX_EV_ENQ_SKIP_EXITING;
-
-	/*
-	 * If SCX_OPS_ENQ_MIGRATION_DISABLED is not set, the number of times a
-	 * migration disabled task skips ops.enqueue() and is dispatched to its
-	 * local DSQ.
-	 */
-	s64		SCX_EV_ENQ_SKIP_MIGRATION_DISABLED;
-
-	/*
-	 * Total number of times a task's time slice was refilled with the
-	 * default value (SCX_SLICE_DFL).
-	 */
-	s64		SCX_EV_REFILL_SLICE_DFL;
-
-	/*
-	 * The total duration of bypass modes in nanoseconds.
-	 */
-	s64		SCX_EV_BYPASS_DURATION;
-
-	/*
-	 * The number of tasks dispatched in the bypassing mode.
-	 */
-	s64		SCX_EV_BYPASS_DISPATCH;
-
-	/*
-	 * The number of times the bypassing mode has been activated.
-	 */
-	s64		SCX_EV_BYPASS_ACTIVATE;
-};
-
 /*
  * The event counter is organized by a per-CPU variable to minimize the
  * accounting overhead without synchronization. A system-wide view on the
-- 
2.49.0


