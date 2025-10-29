Return-Path: <linux-kernel+bounces-876120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A27DC1AA61
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A24188F1DF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED95233F384;
	Wed, 29 Oct 2025 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h4rUWeB7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S7ZRluh6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3246E34845C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743360; cv=none; b=qdOQ5a6N/fEsGmgTIa8IIZLYawc9s9fNGni/QY3YoihVkHPB2214b2qrhUK1704LASalcI+L7eq93cCXbMnex2ryaoa/h2ZGhhq3Dau4QTvGHx1DSA6C1y5L/oirZuAANxVgz6Tjyt/6k62oNTHss3GZk9gZkyVTzG+A4iOaTTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743360; c=relaxed/simple;
	bh=vs2qE4aSRCJ4MOSQwu+0ikKD1GazpoXb7+IgmCQ2HLI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=siEOqVLWyJ//MSNru+o3JpsSluG5aTum3QoNhU1tmNIFz+cQKQJR71FwLtG/iL8A6fwJOBqPCO40MceIr1e2JVA6a82KG2V7/4xhXV4A1CJfqw7T6GnMls+8CS7kdjASwCOjGIts2hsx5rZ0cneCvlXdugQcDH/53X1tZUQ6i2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h4rUWeB7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S7ZRluh6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029124515.972197207@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761743355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ezhVeQoFFg5cKP4kQ5iOgV9eN2TIDhn3UPvppBHphsg=;
	b=h4rUWeB7debb06vJ1Ir+fDqF8lJT+hfjwLwHF629ZSVm3oxamE/tSxVOaf1lKPWNmHIQnf
	DqPlILyxAc2w6SHIrQrI0aNahdliTiMkgFV3rwLVAa+xcDeOanuISmrtNbTvMXk+jgWdxr
	T+yq1BOYer7/xfTgPwnTb3ryZqC1h2KK89PO7ZblUmPJTfBQf9kgbYGQF7Neo956v+WoiL
	n14j9XZ55iZt5g5OXspSS+SRC+tnesS81IivxnM/xY0J/+MpRhGDWQpSuqGTVR4FaOeLBC
	HbL64dik8nOnfeeB3Hq5miAiM1AIcmwtkLysPMTNLSHxYEMbtCuRtvOhjgumUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761743355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ezhVeQoFFg5cKP4kQ5iOgV9eN2TIDhn3UPvppBHphsg=;
	b=S7ZRluh68qB/pOW/t8wd4fvUuQun8DQ70MYpHgmRLmi0h7sfvnrfeo5GVSCOFVIYhG3dUh
	zgyDauy1sG0qBNDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>,
 Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [patch V3 11/20] signal: Move MMCID exit out of sighand lock
References: <20251029123717.886619142@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 14:09:14 +0100 (CET)

There is no need anymore to keep this under sighand lock as the current
code and the upcoming replacement are not depending on the exit state of a
task anymore.

That allows to use a mutex in the exit path.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched.h |    4 ++--
 kernel/exit.c         |    1 +
 kernel/sched/core.c   |    4 ++--
 kernel/signal.c       |    2 --
 4 files changed, 5 insertions(+), 6 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2298,7 +2298,7 @@ static __always_inline void alloc_tag_re
 void sched_mm_cid_before_execve(struct task_struct *t);
 void sched_mm_cid_after_execve(struct task_struct *t);
 void sched_mm_cid_fork(struct task_struct *t);
-void sched_mm_cid_exit_signals(struct task_struct *t);
+void sched_mm_cid_exit(struct task_struct *t);
 static inline int task_mm_cid(struct task_struct *t)
 {
 	return t->mm_cid.cid;
@@ -2307,7 +2307,7 @@ static inline int task_mm_cid(struct tas
 static inline void sched_mm_cid_before_execve(struct task_struct *t) { }
 static inline void sched_mm_cid_after_execve(struct task_struct *t) { }
 static inline void sched_mm_cid_fork(struct task_struct *t) { }
-static inline void sched_mm_cid_exit_signals(struct task_struct *t) { }
+static inline void sched_mm_cid_exit(struct task_struct *t) { }
 static inline int task_mm_cid(struct task_struct *t)
 {
 	/*
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -910,6 +910,7 @@ void __noreturn do_exit(long code)
 	user_events_exit(tsk);
 
 	io_uring_files_cancel();
+	sched_mm_cid_exit(tsk);
 	exit_signals(tsk);  /* sets PF_EXITING */
 
 	seccomp_filter_release(tsk);
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10392,7 +10392,7 @@ static inline void mm_update_cpus_allowe
 	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, weight);
 }
 
-void sched_mm_cid_exit_signals(struct task_struct *t)
+void sched_mm_cid_exit(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
 
@@ -10410,7 +10410,7 @@ void sched_mm_cid_exit_signals(struct ta
 /* Deactivate MM CID allocation across execve() */
 void sched_mm_cid_before_execve(struct task_struct *t)
 {
-	sched_mm_cid_exit_signals(t);
+	sched_mm_cid_exit(t);
 }
 
 /* Reactivate MM CID after successful execve() */
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3125,7 +3125,6 @@ void exit_signals(struct task_struct *ts
 	cgroup_threadgroup_change_begin(tsk);
 
 	if (thread_group_empty(tsk) || (tsk->signal->flags & SIGNAL_GROUP_EXIT)) {
-		sched_mm_cid_exit_signals(tsk);
 		tsk->flags |= PF_EXITING;
 		cgroup_threadgroup_change_end(tsk);
 		return;
@@ -3136,7 +3135,6 @@ void exit_signals(struct task_struct *ts
 	 * From now this task is not visible for group-wide signals,
 	 * see wants_signal(), do_signal_stop().
 	 */
-	sched_mm_cid_exit_signals(tsk);
 	tsk->flags |= PF_EXITING;
 
 	cgroup_threadgroup_change_end(tsk);


