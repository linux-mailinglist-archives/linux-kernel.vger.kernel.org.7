Return-Path: <linux-kernel+bounces-582555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9E4A76FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 23:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C09817A30C1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 21:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C9221CA02;
	Mon, 31 Mar 2025 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YV9b36cO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EE31D5CFB;
	Mon, 31 Mar 2025 21:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454996; cv=none; b=DlRwSCbItt/O1ioeJX4YeCuie5DoNxbq6tZvW+kYeXkOaBISo6RzZRMoXOtcjJ2nE3VPndwVExSiqZWBVROYjsttDBgUWqDmBfDJq/ZXwy9FQyzZBAV4sznURQ7L5S6gEBnyhRABhzhzxBy+IAPjsI6VNGGIAy3q05WM2bOovvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454996; c=relaxed/simple;
	bh=4Ai2javJFGPUL16QmZ1bVGq4ISa/G87CeO9P6yL8XAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lCxrtaSMmN5Afro81rPAdR7AteArENbm7nUHdbT7137Z0eOWzpuNYd5Wa/gsttVp9z+NUOX+17BvL7cttcdrgDeitEtXnhkWReY8swpnjga6PSCB+QXAqZk0FrKZh/sVBuB/HObD8cPyGc0Pc4rW3bi1XcF7jiUstObeYAW+aUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YV9b36cO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897F4C4CEEA;
	Mon, 31 Mar 2025 21:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743454995;
	bh=4Ai2javJFGPUL16QmZ1bVGq4ISa/G87CeO9P6yL8XAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YV9b36cO49mM/0VAHMqlxhpmGJWcD3STXodtYDzid8TLRghtTeTMP6dgec/7z5djZ
	 zzu0spFEnQVaP1ltwVcMSDdTlJjlDEFEMFhvExBEI5/unD3FTrpenvzFUUdUw+3mhN
	 1cRHSt8Dpa5gun5GcXx1LxTcDAfFwql2VnZpQQ4t50ZDhDHPoKKynu9VwQEElRPDjy
	 uM5KPRHyZQm7cJiNQjuTWteWDTvbzCYZ/nsnLc51dBGoux7fj3ijiOBudF05uduXRV
	 OqgrAGk0zkAgxHpQ2cxpuFKXIJGd1hIqzNMTPcKvwzRNe2QmMEwPW909xdVjEVbWlh
	 YHrEQS2POqxbQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 292EACE0C96; Mon, 31 Mar 2025 14:03:15 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 03/12] rcutorture: Split out beginning and end from rcu_torture_one_read()
Date: Mon, 31 Mar 2025 14:03:05 -0700
Message-Id: <20250331210314.590622-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
References: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcu_torture_one_read() function is designed for RCU readers that are
confined to a task, such that a single thread of control extends from the
beginning of a given RCU read-side critical section to its end.  This does
not suffice for things like srcu_down_read() and srcu_up_read(), where
the critical section might start at task level and end in a timer handler.

This commit therefore creates separate init_rcu_torture_one_read_state(),
rcu_torture_one_read_start(), and rcu_torture_one_read_end() functions,
along with a rcu_torture_one_read_state structure to coordinate their
actions.  These will be used to create tests for srcu_down_read()
and friends.

One caution:  The caller to rcu_torture_one_read_start() must enter the
initial read-side critical section prior to the call.  This enables use
of non-standard primitives such as srcu_down_read() while still using
the same validation code.
---
 kernel/rcu/rcutorture.c | 124 ++++++++++++++++++++++++++--------------
 1 file changed, 81 insertions(+), 43 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 65095664f5c5b..b0e96df636226 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2164,53 +2164,70 @@ rcutorture_loop_extend(int *readstate, bool insoftirq, struct torture_random_sta
 	return &rtrsp[j];
 }
 
-/*
- * Do one read-side critical section, returning false if there was
- * no data to read.  Can be invoked both from process context and
- * from a timer handler.
- */
-static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
-{
-	bool checkpolling = !(torture_random(trsp) & 0xfff);
+struct rcu_torture_one_read_state {
+	bool checkpolling;
 	unsigned long cookie;
 	struct rcu_gp_oldstate cookie_full;
-	int i;
 	unsigned long started;
-	unsigned long completed;
-	int newstate;
 	struct rcu_torture *p;
-	int pipe_count;
-	bool preempted = false;
-	int readstate = 0;
-	struct rt_read_seg rtseg[RCUTORTURE_RDR_MAX_SEGS] = { { 0 } };
-	struct rt_read_seg *rtrsp = &rtseg[0];
-	struct rt_read_seg *rtrsp1;
+	int readstate;
+	struct rt_read_seg rtseg[RCUTORTURE_RDR_MAX_SEGS];
+	struct rt_read_seg *rtrsp;
 	unsigned long long ts;
+};
 
-	WARN_ON_ONCE(!rcu_is_watching());
-	newstate = rcutorture_extend_mask(readstate, trsp);
-	rcutorture_one_extend(&readstate, newstate, myid < 0, trsp, rtrsp++);
-	if (checkpolling) {
+static void init_rcu_torture_one_read_state(struct rcu_torture_one_read_state *rtorsp,
+					    struct torture_random_state *trsp)
+{
+	memset(rtorsp, 0, sizeof(*rtorsp));
+	rtorsp->checkpolling = !(torture_random(trsp) & 0xfff);
+	rtorsp->rtrsp = &rtorsp->rtseg[0];
+}
+
+/*
+ * Set up the first segment of a series of overlapping read-side
+ * critical sections.  The caller must have actually initiated the
+ * outermost read-side critical section.
+ */
+static bool rcu_torture_one_read_start(struct rcu_torture_one_read_state *rtorsp,
+				       struct torture_random_state *trsp, long myid)
+{
+	if (rtorsp->checkpolling) {
 		if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
-			cookie = cur_ops->get_gp_state();
+			rtorsp->cookie = cur_ops->get_gp_state();
 		if (cur_ops->get_gp_state_full && cur_ops->poll_gp_state_full)
-			cur_ops->get_gp_state_full(&cookie_full);
+			cur_ops->get_gp_state_full(&rtorsp->cookie_full);
 	}
-	started = cur_ops->get_gp_seq();
-	ts = rcu_trace_clock_local();
-	p = rcu_dereference_check(rcu_torture_current,
+	rtorsp->started = cur_ops->get_gp_seq();
+	rtorsp->ts = rcu_trace_clock_local();
+	rtorsp->p = rcu_dereference_check(rcu_torture_current,
 				  !cur_ops->readlock_held || cur_ops->readlock_held());
-	if (p == NULL) {
+	if (rtorsp->p == NULL) {
 		/* Wait for rcu_torture_writer to get underway */
-		rcutorture_one_extend(&readstate, 0, myid < 0, trsp, rtrsp);
+		rcutorture_one_extend(&rtorsp->readstate, 0, myid < 0, trsp, rtorsp->rtrsp);
 		return false;
 	}
-	if (p->rtort_mbtest == 0)
+	if (rtorsp->p->rtort_mbtest == 0)
 		atomic_inc(&n_rcu_torture_mberror);
-	rcu_torture_reader_do_mbchk(myid, p, trsp);
-	rtrsp = rcutorture_loop_extend(&readstate, myid < 0, trsp, rtrsp);
+	rcu_torture_reader_do_mbchk(myid, rtorsp->p, trsp);
+	return true;
+}
+
+/*
+ * Complete the last segment of a series of overlapping read-side
+ * critical sections and check for errors.
+ */
+static void rcu_torture_one_read_end(struct rcu_torture_one_read_state *rtorsp,
+				     struct torture_random_state *trsp, long myid)
+{
+	int i;
+	unsigned long completed;
+	int pipe_count;
+	bool preempted = false;
+	struct rt_read_seg *rtrsp1;
+
 	preempt_disable();
-	pipe_count = READ_ONCE(p->rtort_pipe_count);
+	pipe_count = READ_ONCE(rtorsp->p->rtort_pipe_count);
 	if (pipe_count > RCU_TORTURE_PIPE_LEN) {
 		// Should not happen in a correct RCU implementation,
 		// happens quite often for torture_type=busted.
@@ -2218,28 +2235,28 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	}
 	completed = cur_ops->get_gp_seq();
 	if (pipe_count > 1) {
-		do_trace_rcu_torture_read(cur_ops->name, &p->rtort_rcu,
-					  ts, started, completed);
+		do_trace_rcu_torture_read(cur_ops->name, &rtorsp->p->rtort_rcu,
+					  rtorsp->ts, rtorsp->started, completed);
 		rcu_ftrace_dump(DUMP_ALL);
 	}
 	__this_cpu_inc(rcu_torture_count[pipe_count]);
-	completed = rcutorture_seq_diff(completed, started);
+	completed = rcutorture_seq_diff(completed, rtorsp->started);
 	if (completed > RCU_TORTURE_PIPE_LEN) {
 		/* Should not happen, but... */
 		completed = RCU_TORTURE_PIPE_LEN;
 	}
 	__this_cpu_inc(rcu_torture_batch[completed]);
 	preempt_enable();
-	if (checkpolling) {
+	if (rtorsp->checkpolling) {
 		if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
-			WARN_ONCE(cur_ops->poll_gp_state(cookie),
+			WARN_ONCE(cur_ops->poll_gp_state(rtorsp->cookie),
 				  "%s: Cookie check 2 failed %s(%d) %lu->%lu\n",
 				  __func__,
 				  rcu_torture_writer_state_getname(),
 				  rcu_torture_writer_state,
-				  cookie, cur_ops->get_gp_state());
+				  rtorsp->cookie, cur_ops->get_gp_state());
 		if (cur_ops->get_gp_state_full && cur_ops->poll_gp_state_full)
-			WARN_ONCE(cur_ops->poll_gp_state_full(&cookie_full),
+			WARN_ONCE(cur_ops->poll_gp_state_full(&rtorsp->cookie_full),
 				  "%s: Cookie check 6 failed %s(%d) online %*pbl\n",
 				  __func__,
 				  rcu_torture_writer_state_getname(),
@@ -2248,21 +2265,42 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	}
 	if (cur_ops->reader_blocked)
 		preempted = cur_ops->reader_blocked();
-	rcutorture_one_extend(&readstate, 0, myid < 0, trsp, rtrsp);
-	WARN_ON_ONCE(readstate);
+	rcutorture_one_extend(&rtorsp->readstate, 0, myid < 0, trsp, rtorsp->rtrsp);
+	WARN_ON_ONCE(rtorsp->readstate);
 	// This next splat is expected behavior if leakpointer, especially
 	// for CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels.
-	WARN_ON_ONCE(leakpointer && READ_ONCE(p->rtort_pipe_count) > 1);
+	WARN_ON_ONCE(leakpointer && READ_ONCE(rtorsp->p->rtort_pipe_count) > 1);
 
 	/* If error or close call, record the sequence of reader protections. */
 	if ((pipe_count > 1 || completed > 1) && !xchg(&err_segs_recorded, 1)) {
 		i = 0;
-		for (rtrsp1 = &rtseg[0]; rtrsp1 < rtrsp; rtrsp1++)
+		for (rtrsp1 = &rtorsp->rtseg[0]; rtrsp1 < rtorsp->rtrsp; rtrsp1++)
 			err_segs[i++] = *rtrsp1;
 		rt_read_nsegs = i;
 		rt_read_preempted = preempted;
 	}
+}
 
+/*
+ * Do one read-side critical section, returning false if there was
+ * no data to read.  Can be invoked both from process context and
+ * from a timer handler.
+ */
+static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
+{
+	int newstate;
+	struct rcu_torture_one_read_state rtors;
+
+	WARN_ON_ONCE(!rcu_is_watching());
+	init_rcu_torture_one_read_state(&rtors, trsp);
+	newstate = rcutorture_extend_mask(rtors.readstate, trsp);
+	rcutorture_one_extend(&rtors.readstate, newstate, myid < 0, trsp, rtors.rtrsp++);
+	if (!rcu_torture_one_read_start(&rtors, trsp, myid)) {
+		rcutorture_one_extend(&rtors.readstate, 0, myid < 0, trsp, rtors.rtrsp);
+		return false;
+	}
+	rtors.rtrsp = rcutorture_loop_extend(&rtors.readstate, myid < 0, trsp, rtors.rtrsp);
+	rcu_torture_one_read_end(&rtors, trsp, myid);
 	return true;
 }
 
-- 
2.40.1


