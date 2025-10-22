Return-Path: <linux-kernel+bounces-865011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F58BFC05C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC8AE560E80
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6951934B1A6;
	Wed, 22 Oct 2025 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sWIm/PMz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MQ7ba5+2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161AC34A3CE
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137736; cv=none; b=R2bMxyMp8kbh8BBHC+ROYqyebYkH/l1thiXU0i8Xpm95tLa1Ig11Oj+FpuCELusGaTyC2cryMlhPSwNP//J+BfSbJhoo44IjHR3SEsK/Yj8PIadKDPL//Zbts37ot6Tc5v6tu2NHqnR0ANmemk6Srlcpwuu+LZ1ciWECGSK4sjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137736; c=relaxed/simple;
	bh=sVVOLJ04FLiXzMFuKLHgl6shJ7ESejpdQtdjqeTZW1k=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=I5aXQ8vQBVNUQUWP+GcEo8gHMEHEw0IbNPB79Rk7ACLy6JJ2k19r1iQe9Gmfm8oONlt7dxuTC3i2To2r0mATgl0SQ+iPmWKLhwN3B537lvgO0RgKfz8z6OLS4wKbrXL5/Z9pzEvnesBmcLvy1Zdu6iueHaVagxjQfLzOC+mfGFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sWIm/PMz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MQ7ba5+2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022110556.090376957@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=nhXvK7LQ+EPsk8jngP+4j+16QKubg1O3sO55JG7Yy+E=;
	b=sWIm/PMzyXm3rsG8g3jSl5AnjvTtxLVdqwJ2EaL9caJSM3lWMfLzyscfZ8FYb1+NJaOkCt
	YOed4Omvqb3w0b6LENOS5MMn48ZeGAkGG/jAIAaiCTm/44z7QB4+4PEJOYN0o+DCOhsg/a
	INOj1piSMJGGArXWI3qjvMA1NoVeD1qPol1Wa1/kUHtGwYUTt/ZiwljSNjAerEozwugzZS
	Dgl+8Sq2hAKJjv69FvVYfiVhsCvzKyIUvDyE5mC/m5gbmwDcEtWLgzKsWHCJhZo1Df6Jcx
	M/HfEb/7XLfo29D3WcfdQBum+N7b3RmOF9d9znA3XEa0tNu3WwvfnHJNq1a84w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=nhXvK7LQ+EPsk8jngP+4j+16QKubg1O3sO55JG7Yy+E=;
	b=MQ7ba5+2FXjxV/Jy6IGmNGT0DWY2OHYm2CQZyYndy7U4+TGT3OKbAgcTzU3Po8SM66hFX4
	v8a02SlVBbi1spAA==
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
 Yury Norov <yury.norov@gmail.com>
Subject: [patch V2 11/20] signal: Move MMCID exit out of sighand lock
References: <20251022104005.907410538@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:55:33 +0200 (CEST)

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
@@ -10390,7 +10390,7 @@ static inline void mm_update_cpus_allowe
 	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, weight);
 }
 
-void sched_mm_cid_exit_signals(struct task_struct *t)
+void sched_mm_cid_exit(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
 
@@ -10408,7 +10408,7 @@ void sched_mm_cid_exit_signals(struct ta
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


