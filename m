Return-Path: <linux-kernel+bounces-847405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F37BCAB9E
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 21:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6890E3537B3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 19:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B1F23956A;
	Thu,  9 Oct 2025 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oottToKK"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E9A1FAC4B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760039438; cv=none; b=ldHd6lmYL0xlrOrVoeYVBnwzUdQiZ1JE+szLrLT1/JYzXeWTzGCRE6STTEcV/nR+L5FAqEmaik3Un57FfF8aj6T+Lh0FuhgVDN9kKODj3Pff0dtP53+xCNVj3EDnT2E5j4ZnG42mHpN/3Vb2RlGJZKHvo2lxlfS9P9MS61Imtsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760039438; c=relaxed/simple;
	bh=H4RIwx8TOqozYKnCYHLzNSrgLoM9CIEoYMO+ZjSUeDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etz5nrsITVOb422lDotyqnW2epQASU2SQCD52OhV59iCXiEr6Y+5SHCwDWz1wLVRLIi14MkFrCK/pu3iaPB7Oa2LdkTyLNXrYYTPPKs40bsULuin8LarqzfTQluMGxneqgudUq+r0VjdVVSReFfZbueIiGO/gAWX429c5+zsMDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oottToKK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YxqV+tsr8lSMmLH0FUuBEb1nReCJ+8txfM9gWkUNaD4=; b=oottToKKSdr+b+yII+FrFXMtBi
	tWErwrfzpdI0PSuH0IDKFYeNbL1kY/unmq5SAFjhtNq+AgWSTTm8Ba0MGBCLcqQdlfcltIOF1C9Qr
	1AWSE+vhsIX9GteCOcJBmW3kBzHEgjDAhtnpcklsZSdctbA4glZv/TLXhCzVb0XBjNMRwlnbM4y2U
	iazH28HmJ2wO1yDz/qoHFm4eD1ML0Cf/BEhwHY0wdrEqvw1G12h5Jj3xUiD66B6IW/u4QxpZk7j0Z
	AaeNljB6O2ZzvxxwoKnBQY35C9M+jsa2UuNhr0Lzrbcy6Ao1PIbsCF+vE7coVOodMoT9TSNwF/p6A
	KyKt82lw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6wef-00000001fh2-1SYk;
	Thu, 09 Oct 2025 19:50:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 459D6300399; Thu, 09 Oct 2025 21:50:24 +0200 (CEST)
Date: Thu, 9 Oct 2025 21:50:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] seqlock: introduce scoped_seqlock_read() and
 scoped_seqlock_read_irqsave()
Message-ID: <20251009195024.GL3289052@noisy.programming.kicks-ass.net>
References: <20251008123014.GA20413@redhat.com>
 <20251008123045.GA20440@redhat.com>
 <CAHk-=wjozC9_JCdEW9K_uruJqzTLzhtcVpgDk1OuqErNRUS7Mg@mail.gmail.com>
 <CAHk-=wjuoFm9yZur_T4VOnX2iyDYD6T_gDRXE5ms9538W6Q35g@mail.gmail.com>
 <CAHk-=wiHbN+_LCmSj2sHswDRJ0yG3kkjptMvCXcMwk7jWK1F=Q@mail.gmail.com>
 <20251009143748.GA2704@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009143748.GA2704@redhat.com>

On Thu, Oct 09, 2025 at 04:37:49PM +0200, Oleg Nesterov wrote:

> Let me think a bit more before I send V3...

How do we feel about something a little like so?


diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 5ce48eab7a2a..9786b8d14164 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -1209,4 +1209,85 @@ done_seqretry_irqrestore(seqlock_t *lock, int seq, unsigned long flags)
 	if (seq & 1)
 		read_sequnlock_excl_irqrestore(lock, flags);
 }
+
+enum ss_state {
+	sss_done = 0,
+	sss_locked,
+	sss_lockless,
+};
+
+enum ss_type {
+	ss_lockless,
+	ss_lock,
+	ss_lock_irqsave,
+};
+
+struct ss_tmp {
+	enum ss_type	type;
+	enum ss_state	state;
+	int		seq;
+	unsigned long	flags;
+	spinlock_t	*lock;
+};
+
+static inline void __scoped_seqlock_cleanup(struct ss_tmp *sst)
+{
+	if (!sst->lock)
+		return;
+
+	if (sst->type == ss_lock_irqsave) {
+		spin_unlock_irqrestore(sst->lock, sst->flags);
+		return;
+	}
+
+	spin_unlock(sst->lock);
+}
+
+static inline void
+__scoped_seqlock_next(struct ss_tmp *sst, seqlock_t *lock)
+{
+	switch (sst->state) {
+	case sss_lockless:
+		if (!read_seqretry(lock, sst->seq)) {
+			sst->state = sss_done;
+			return;
+		}
+
+		switch (sst->type) {
+		case ss_lock:
+			sst->lock = &lock->lock;
+			spin_lock(sst->lock);
+			sst->state = sss_locked;
+			return;
+
+		case ss_lock_irqsave:
+			sst->lock = &lock->lock;
+			spin_lock_irqsave(sst->lock, sst->flags);
+			sst->state = sss_locked;
+			return;
+
+		case ss_lockless:
+			sst->seq = read_seqbegin(lock);
+			return;
+		}
+
+	case sss_locked:
+		sst->state = sss_done;
+		return;
+
+	case sss_done:
+		BUG();
+	}
+}
+
+#define __scoped_seqlock_read(_seqlock, _type, _s)			\
+	for (struct ss_tmp _s __cleanup(__scoped_seqlock_cleanup) = {	\
+		.type = _type, .state = sss_lockless,			\
+		.seq = read_seqbegin(_seqlock), .lock = NULL };		\
+	     _s.state != sss_done;					\
+	     __scoped_seqlock_next(&_s, _seqlock))
+
+#define scoped_seqlock_read(_seqlock, _type)				\
+	__scoped_seqlock_read(_seqlock, _type, __UNIQUE_ID(seqlock))
+
 #endif /* __LINUX_SEQLOCK_H */
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 7097de2c8cda..d2b3f987c888 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -313,10 +313,8 @@ static u64 read_sum_exec_runtime(struct task_struct *t)
 void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
 {
 	struct signal_struct *sig = tsk->signal;
-	u64 utime, stime;
 	struct task_struct *t;
-	unsigned int seq, nextseq;
-	unsigned long flags;
+	u64 utime, stime;
 
 	/*
 	 * Update current task runtime to account pending time since last
@@ -329,27 +327,19 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
 	if (same_thread_group(current, tsk))
 		(void) task_sched_runtime(current);
 
-	rcu_read_lock();
-	/* Attempt a lockless read on the first round. */
-	nextseq = 0;
-	do {
-		seq = nextseq;
-		flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
+	guard(rcu)();
+	scoped_seqlock_read(&sig->stats_lock, ss_lock_irqsave) {
 		times->utime = sig->utime;
 		times->stime = sig->stime;
 		times->sum_exec_runtime = sig->sum_sched_runtime;
 
-		for_each_thread(tsk, t) {
+		__for_each_thread(sig, t) {
 			task_cputime(t, &utime, &stime);
 			times->utime += utime;
 			times->stime += stime;
 			times->sum_exec_runtime += read_sum_exec_runtime(t);
 		}
-		/* If lockless access failed, take the lock. */
-		nextseq = 1;
-	} while (need_seqretry(&sig->stats_lock, seq));
-	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
-	rcu_read_unlock();
+	}
 }
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING

