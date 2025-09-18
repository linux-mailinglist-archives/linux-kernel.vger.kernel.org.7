Return-Path: <linux-kernel+bounces-822497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE59EB8404D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825F454340D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628282FDC52;
	Thu, 18 Sep 2025 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mzal4I4x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874FD2FB623;
	Thu, 18 Sep 2025 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190472; cv=none; b=rKAEoEds0M3O4W0zQ8lfmwK+BorZlf0uujYyG+zsbOwVQX2pA9c+afvkFcKXD0tn7q59bBbX2+evHjUPXnYIMlU57r5G1RB2mbA732MGWbh9dbbhE37bp/5Xnez1OxzktOqUicFh6QTe2uCJr3L79YDJz2OUyrR1WBa+TNpLbao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190472; c=relaxed/simple;
	bh=opZKwW/P7K6hNgmlx4MRoMA9dxl1u6JquJKp2gbCyPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VqEglch2wnCOnMz6/o8PPHhaPoDXZuFMGIeCSJldD6U0E3lfEsLRwFxHpP1cDtrRqSpkrEtpjy45exavnotTYpOo2MHOK++bbM6neekVzm7Z2JgcFk/aUTM9XHpLASa6eUHqNyyHb/i2qJDw6V9gpRPE5VVlzdYNoKXJM8KLrkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mzal4I4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A46C4CEE7;
	Thu, 18 Sep 2025 10:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190472;
	bh=opZKwW/P7K6hNgmlx4MRoMA9dxl1u6JquJKp2gbCyPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mzal4I4xm8LB7n9XWEXczOH36Bg9QYRvIb+ShJuw1um/psvtvFPtK/7qoDha4KdWX
	 BEXliw4mnEUcAM70MJ0V/87bOPtlbK0WRlDBjZUeNXzS43/Qc8zOkNOJvOYrVFZwpi
	 yc8DelpYsk4jwCOPKk9LbEYYeNBYpztRiYfvFwt55jV5Dx5JxqtYnUZe9Xww13/xZX
	 aBN3NrBTBpGxDmzvbk6+C98XBbvqmupNCztwJE1CKvmAPem9k2eAJ0MmNrsKVkm8sY
	 LcHNS9IqeQJ5RMCrK5CxZY5K1gGqQCTsOwmciZQlDbmd+EZjclHbBtgzvq0V5BWAmt
	 nbb8uvAN+LoUQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BA8C4CE0B32; Thu, 18 Sep 2025 03:14:31 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 1/8] doc: Update whatisRCU.rst for recent RCU API additions
Date: Thu, 18 Sep 2025 03:14:23 -0700
Message-Id: <20250918101430.2592294-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <921eb978-5f39-4480-bcf6-c735f859c694@paulmck-laptop>
References: <921eb978-5f39-4480-bcf6-c735f859c694@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bring this file kicking and screaming into the year 2025!

[ paulmck: Apply feedback from Bagas Sanjaya. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/whatisRCU.rst | 150 +++++++++++++++++++++++++-------
 1 file changed, 118 insertions(+), 32 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index be2eb6be16ece8..cf0b0ac9f4636a 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -1021,32 +1021,41 @@ RCU list traversal::
 	list_entry_rcu
 	list_entry_lockless
 	list_first_entry_rcu
+	list_first_or_null_rcu
+	list_tail_rcu
 	list_next_rcu
+	list_next_or_null_rcu
 	list_for_each_entry_rcu
 	list_for_each_entry_continue_rcu
 	list_for_each_entry_from_rcu
-	list_first_or_null_rcu
-	list_next_or_null_rcu
+	list_for_each_entry_lockless
 	hlist_first_rcu
 	hlist_next_rcu
 	hlist_pprev_rcu
 	hlist_for_each_entry_rcu
+	hlist_for_each_entry_rcu_notrace
 	hlist_for_each_entry_rcu_bh
 	hlist_for_each_entry_from_rcu
 	hlist_for_each_entry_continue_rcu
 	hlist_for_each_entry_continue_rcu_bh
 	hlist_nulls_first_rcu
+	hlist_nulls_next_rcu
 	hlist_nulls_for_each_entry_rcu
+	hlist_nulls_for_each_entry_safe
 	hlist_bl_first_rcu
 	hlist_bl_for_each_entry_rcu
 
 RCU pointer/list update::
 
 	rcu_assign_pointer
+	rcu_replace_pointer
+	INIT_LIST_HEAD_RCU
 	list_add_rcu
 	list_add_tail_rcu
 	list_del_rcu
 	list_replace_rcu
+	list_splice_init_rcu
+	list_splice_tail_init_rcu
 	hlist_add_behind_rcu
 	hlist_add_before_rcu
 	hlist_add_head_rcu
@@ -1054,34 +1063,53 @@ RCU pointer/list update::
 	hlist_del_rcu
 	hlist_del_init_rcu
 	hlist_replace_rcu
-	list_splice_init_rcu
-	list_splice_tail_init_rcu
 	hlist_nulls_del_init_rcu
 	hlist_nulls_del_rcu
 	hlist_nulls_add_head_rcu
+	hlist_nulls_add_tail_rcu
+	hlist_nulls_add_fake
+	hlists_swap_heads_rcu
 	hlist_bl_add_head_rcu
-	hlist_bl_del_init_rcu
 	hlist_bl_del_rcu
 	hlist_bl_set_first_rcu
 
 RCU::
 
-	Critical sections	Grace period		Barrier
-
-	rcu_read_lock		synchronize_net		rcu_barrier
-	rcu_read_unlock		synchronize_rcu
-	rcu_dereference		synchronize_rcu_expedited
-	rcu_read_lock_held	call_rcu
-	rcu_dereference_check	kfree_rcu
-	rcu_dereference_protected
+	Critical sections		Grace period		Barrier
+
+	rcu_read_lock			synchronize_net		rcu_barrier
+	rcu_read_unlock			synchronize_rcu
+	guard(rcu)()			synchronize_rcu_expedited
+	scoped_guard(rcu)		synchronize_rcu_mult
+	rcu_dereference			call_rcu
+	rcu_dereference_check		call_rcu_hurry
+	rcu_dereference_protected	kfree_rcu
+	rcu_read_lock_held		kvfree_rcu
+	rcu_read_lock_any_held		kfree_rcu_mightsleep
+	rcu_pointer_handoff		cond_synchronize_rcu
+	unrcu_pointer			cond_synchronize_rcu_full
+					cond_synchronize_rcu_expedited
+					cond_synchronize_rcu_expedited_full
+					get_completed_synchronize_rcu
+					get_completed_synchronize_rcu_full
+					get_state_synchronize_rcu
+					get_state_synchronize_rcu_full
+					poll_state_synchronize_rcu
+					poll_state_synchronize_rcu_full
+					same_state_synchronize_rcu
+					same_state_synchronize_rcu_full
+					start_poll_synchronize_rcu
+					start_poll_synchronize_rcu_full
+					start_poll_synchronize_rcu_expedited
+					start_poll_synchronize_rcu_expedited_full
 
 bh::
 
 	Critical sections	Grace period		Barrier
 
-	rcu_read_lock_bh	call_rcu		rcu_barrier
-	rcu_read_unlock_bh	synchronize_rcu
-	[local_bh_disable]	synchronize_rcu_expedited
+	rcu_read_lock_bh	[Same as RCU]		[Same as RCU]
+	rcu_read_unlock_bh
+	[local_bh_disable]
 	[and friends]
 	rcu_dereference_bh
 	rcu_dereference_bh_check
@@ -1092,9 +1120,9 @@ sched::
 
 	Critical sections	Grace period		Barrier
 
-	rcu_read_lock_sched	call_rcu		rcu_barrier
-	rcu_read_unlock_sched	synchronize_rcu
-	[preempt_disable]	synchronize_rcu_expedited
+	rcu_read_lock_sched	[Same as RCU]		[Same as RCU]
+	rcu_read_unlock_sched
+	[preempt_disable]
 	[and friends]
 	rcu_read_lock_sched_notrace
 	rcu_read_unlock_sched_notrace
@@ -1104,46 +1132,104 @@ sched::
 	rcu_read_lock_sched_held
 
 
+RCU: Initialization/cleanup/ordering::
+
+	RCU_INIT_POINTER
+	RCU_INITIALIZER
+	RCU_POINTER_INITIALIZER
+	init_rcu_head
+	destroy_rcu_head
+	init_rcu_head_on_stack
+	destroy_rcu_head_on_stack
+	SLAB_TYPESAFE_BY_RCU
+
+
+RCU: Quiescents states and control::
+
+	cond_resched_tasks_rcu_qs
+	rcu_all_qs
+	rcu_softirq_qs_periodic
+	rcu_end_inkernel_boot
+	rcu_expedite_gp
+	rcu_gp_is_expedited
+	rcu_unexpedite_gp
+	rcu_cpu_stall_reset
+	rcu_head_after_call_rcu
+	rcu_is_watching
+
+
+RCU-sync primitive::
+
+	rcu_sync_is_idle
+	rcu_sync_init
+	rcu_sync_enter
+	rcu_sync_exit
+	rcu_sync_dtor
+
+
 RCU-Tasks::
 
-	Critical sections	Grace period		Barrier
+	Critical sections	Grace period			Barrier
 
-	N/A			call_rcu_tasks		rcu_barrier_tasks
+	N/A			call_rcu_tasks			rcu_barrier_tasks
 				synchronize_rcu_tasks
 
 
 RCU-Tasks-Rude::
 
-	Critical sections	Grace period		Barrier
+	Critical sections	Grace period			Barrier
 
-	N/A						N/A
-				synchronize_rcu_tasks_rude
+	N/A			synchronize_rcu_tasks_rude	rcu_barrier_tasks_rude
+				call_rcu_tasks_rude
 
 
 RCU-Tasks-Trace::
 
-	Critical sections	Grace period		Barrier
+	Critical sections	Grace period			Barrier
 
-	rcu_read_lock_trace	call_rcu_tasks_trace	rcu_barrier_tasks_trace
+	rcu_read_lock_trace	call_rcu_tasks_trace		rcu_barrier_tasks_trace
 	rcu_read_unlock_trace	synchronize_rcu_tasks_trace
+	guard(rcu_tasks_trace)()
+	scoped_guard(rcu_tasks_trace)
 
 
-SRCU::
+SRCU list traversal::
+	list_for_each_entry_srcu
+	hlist_for_each_entry_srcu
 
-	Critical sections	Grace period		Barrier
 
-	srcu_read_lock		call_srcu		srcu_barrier
-	srcu_read_unlock	synchronize_srcu
-	srcu_dereference	synchronize_srcu_expedited
+SRCU::
+
+	Critical sections		Grace period		Barrier
+
+	srcu_read_lock			call_srcu		srcu_barrier
+	srcu_read_unlock		synchronize_srcu
+	srcu_read_lock_fast		synchronize_srcu_expedited
+	srcu_read_unlock_fast		get_state_synchronize_srcu
+	srcu_read_lock_nmisafe		start_poll_synchronize_srcu
+	srcu_read_unlock_nmisafe	start_poll_synchronize_srcu_expedited
+	srcu_read_lock_notrace		poll_state_synchronize_srcu
+	srcu_read_unlock_notrace
+	srcu_down_read
+	srcu_up_read
+	srcu_down_read_fast
+	srcu_up_read_fast
+	guard(srcu)()
+	scoped_guard(srcu)
+	srcu_read_lock_held
+	srcu_dereference
 	srcu_dereference_check
+	srcu_dereference_notrace
 	srcu_read_lock_held
 
-SRCU: Initialization/cleanup::
+
+SRCU: Initialization/cleanup/ordering::
 
 	DEFINE_SRCU
 	DEFINE_STATIC_SRCU
 	init_srcu_struct
 	cleanup_srcu_struct
+	smp_mb__after_srcu_read_unlock
 
 All: lockdep-checked RCU utility APIs::
 
-- 
2.40.1


