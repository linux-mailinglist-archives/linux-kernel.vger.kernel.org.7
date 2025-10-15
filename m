Return-Path: <linux-kernel+bounces-854976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA03BDFDFC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02BBF19A27DF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F4A341AC7;
	Wed, 15 Oct 2025 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zNrdfZRd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oUbNZge3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACBD341AAE
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549386; cv=none; b=VsBhBJwsSN6zMJYeegnb1/yXS/xkOBVvJpAidSbqHXYdLrlafP5oPuqXon/BrvVwwWY14lkyyUlL7tI9mmnUe3evINJ0MsQMyobRFOV5JI/qzx9XcbBezuE8GGKweAAm3jXJ6202vp1gdQ2bO9FT5XHhxFwd5rIGjmLPM0gcVM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549386; c=relaxed/simple;
	bh=LGC5d2CwjKxGi8CiLe0Iy8t7nBfUegW3c4jMF3VjwWw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ORQLwHxvhvzeX83Hh/IaaeZEbssBtJ7/JY7pL2zCtbuhMTIttFgH79eR/2CYxPN1j4g2Kr4ZpEH5e+s+5+bKM7cNE3v4WstU4Su9wOcUUcuKHJCIePeZv/BPP7lLl1PlSYJLTuICTxLzx1XWPkLamPS75mwclBglPIFUbUsyceg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zNrdfZRd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oUbNZge3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251015172834.947237114@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760549383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MlMcgpBHCcOIkGa/6GuJAY6BtPSrUqB+AgtqLnUK3s0=;
	b=zNrdfZRdKvjQReDv1ILALmNN0nK+Bf9BmhnWcVZ8Mo8QXTZlSsHbng5bUFRk8W9lHxerA3
	lcJ9Jc+VnElsdxSz1sH/hz0E31sU/ad58SZdRFHNwv2EwiuU70DhAnxl+s9kI04JsZk5q7
	u5QOirV+2BWvNR8HDZjGzod3P0fwxw67MuJ1FBKWaLqOeQsYmT+GlwjpR8y1gMscYWQHcL
	8yGnytGkqPnvWQwdRSXOXFqBxzycuEZXCx1bwirQe/vEvYRsXOzBAwzyFFfE3JQy4wZvIQ
	k/FtNnZBsRWwTn8s6CCZhs6no5vSIVl86djD90f9f+bfUvGr45iJ38be1aG4Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760549383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MlMcgpBHCcOIkGa/6GuJAY6BtPSrUqB+AgtqLnUK3s0=;
	b=oUbNZge3nzVM2C81f9lLJcuerlZh9f44RG01tEv6G5DSg+px9CdGtrhpQ39ffiG7dTttE5
	sotf+t2OzI9swQBg==
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
 TCMalloc Team <tcmalloc-eng@google.com>
Subject: [patch 10/19] signal: Move MMCID exit out of sighand lock
References: <20251015164952.694882104@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 19:29:42 +0200 (CEST)

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
@@ -2290,7 +2290,7 @@ static __always_inline void alloc_tag_re
 void sched_mm_cid_before_execve(struct task_struct *t);
 void sched_mm_cid_after_execve(struct task_struct *t);
 void sched_mm_cid_fork(struct task_struct *t);
-void sched_mm_cid_exit_signals(struct task_struct *t);
+void sched_mm_cid_exit(struct task_struct *t);
 static inline int task_mm_cid(struct task_struct *t)
 {
 	return t->mm_cid.cid;
@@ -2299,7 +2299,7 @@ static inline int task_mm_cid(struct tas
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
@@ -905,6 +905,7 @@ void __noreturn do_exit(long code)
 	user_events_exit(tsk);
 
 	io_uring_files_cancel();
+	sched_mm_cid_exit(tsk);
 	exit_signals(tsk);  /* sets PF_EXITING */
 
 	seccomp_filter_release(tsk);
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10427,7 +10427,7 @@ static inline void mm_update_cpus_allowe
 	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, weight);
 }
 
-void sched_mm_cid_exit_signals(struct task_struct *t)
+void sched_mm_cid_exit(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
 
@@ -10445,7 +10445,7 @@ void sched_mm_cid_exit_signals(struct ta
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


