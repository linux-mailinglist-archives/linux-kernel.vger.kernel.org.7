Return-Path: <linux-kernel+bounces-838928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E77BB0716
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3534A56B7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB91C2ECD1D;
	Wed,  1 Oct 2025 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdsHXDKv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644762ECD01
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324512; cv=none; b=od+Z6Mf/rwnQWMWVS2Si93r6bW3N5oshMgf8f+xuKIAim4xgd6w8a39oDgzeQ5ESxCiFpEm2PmZD/ShaN4YZT6Ol4b3ug6Nxa+FlLcTrEfUHUUMLGAUXBUxR8WpDMzrZSVkr9q1uDw/Dc0s62VQi8ocsa8OPBz6Y5Qr2UY/Bq6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324512; c=relaxed/simple;
	bh=uG4s+VHOckvehOTawPZf/vYBPxoNrNy6W//+X9+EXrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEVRi5FrozZL7dCVHTocOgiSATV4R1qYvwo6ai0EFtUQFNIcolIR/TDrBFeKpAymUc2u7LU5eqZlNnM03zD31FFu0FbbAjCIQdSglxit5kIHPYzkiQqSADEB5noKQbi60B0fG5/BAWXTxBC1xcauoX3P7x2S0BGI/H/eaWQY9uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hdsHXDKv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759324509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0bx8l14XwDJ5Pj1IP3Yz3RKQJDDa242dHafLA9wGw0Q=;
	b=hdsHXDKvIwMWx4lqtiDvJ6r5sQJsCmwOvVMUfLElXTCtWxJl07qIeTJREf14Kouv/Lurgz
	sWwqGvYVcyAHDgvMY9zZQTKW0moAA3cK355I0XMnZSA1zz7ZhorYgPNy+gHxPG8I3MEy0r
	SisB4y9XUv9E8y3dfmTIYzRnVBuwZC8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-04H7c5e_P1KSj8ulv9Q36w-1; Wed,
 01 Oct 2025 09:15:08 -0400
X-MC-Unique: 04H7c5e_P1KSj8ulv9Q36w-1
X-Mimecast-MFC-AGG-ID: 04H7c5e_P1KSj8ulv9Q36w_1759324507
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B79E619774EF;
	Wed,  1 Oct 2025 13:15:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B3E8030002C5;
	Wed,  1 Oct 2025 13:15:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  1 Oct 2025 15:13:44 +0200 (CEST)
Date: Wed, 1 Oct 2025 15:13:39 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, David Howells <dhowells@redhat.com>,
	Ingo Molnar <mingo@redhat.com>, Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/1] seqlock: make the read_seqbegin_or_lock() API more
 simple and less error-prone ?
Message-ID: <20251001131337.GC20441@redhat.com>
References: <20250928161953.GA3112@redhat.com>
 <20250928162054.GB3121@redhat.com>
 <20251001130229.GO3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001130229.GO3245006@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/01, Peter Zijlstra wrote:
> On Sun, Sep 28, 2025 at 06:20:54PM +0200, Oleg Nesterov wrote:
>
> > To simplify, suppose we add the new helper
> >
> > 	static inline int need_seqretry_xxx(seqlock_t *lock, int *seq)
> > 	{
> > 		int ret = !(*seq & 1) && read_seqretry(lock, *seq);
> >
> > 		if (ret)
> > 			++*seq;	/* make this counter odd */
                        ^^^^^^
Hmm. just
			*seq = 1;
makes more sense

> How about need_seqretry_or_lock() to stay in theme with
> read_seqbegin_or_lock().

I am fine with any name ;) This one looks good to me.

> > 	#define __XXX(lock, seq, lockless)	\
> > 		for (int lockless = 1, seq; xxx(lock, &seq, lockless); lockless = 0)
> >
> > 	#define XXX(lock)	\
> > 		__XXX(lock, __UNIQUE_ID(seq), __UNIQUE_ID(lockless))
> >
> >
> > ?
>
> Oh gawd, that thing had better not have control flow escape that loop.

Yes, yes. "continue" is fine, but break/return won't work.

> But yes, I suppose something like this is far more useable than the
> current thing.

OK, great. So, modulo naming, how about the patch below?

The new stuff should obviously go to include/linux/seqlock.h, xxx() can be
probably uninlined. thread_group_cputime() is changed as an example.

Oleg.


--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -306,6 +306,35 @@ static u64 read_sum_exec_runtime(struct task_struct *t)
 }
 #endif /* !CONFIG_64BIT */
 
+static inline int xxx(seqlock_t *lock, int lockless, int *seq, unsigned long *flags)
+{
+	if (lockless) {
+		*seq = read_seqbegin(lock);
+		return 1;
+	} else if (*seq & 1) {
+		if (flags)
+			read_sequnlock_excl_irqrestore(lock, *flags);
+		else
+			read_sequnlock_excl(lock);
+		return 0;
+	} else if (read_seqretry(lock, *seq)) {
+		if (flags)
+			read_seqlock_excl_irqsave(lock, *flags);
+		else
+			read_seqlock_excl(lock);
+		*seq = 1;
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+#define __XXX(lock, lockless, seq, flags)	\
+	for (int lockless = 1, seq; xxx(lock, lockless, &seq, flags); lockless = 0)
+
+#define XXX(lock, flags)	\
+	__XXX(lock, __UNIQUE_ID(lockless), __UNIQUE_ID(seq), flags)
+
 /*
  * Accumulate raw cputime values of dead tasks (sig->[us]time) and live
  * tasks (sum on group iteration) belonging to @tsk's group.
@@ -315,7 +344,6 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
 	struct signal_struct *sig = tsk->signal;
 	u64 utime, stime;
 	struct task_struct *t;
-	unsigned int seq, nextseq;
 	unsigned long flags;
 
 	/*
@@ -330,11 +358,7 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
 		(void) task_sched_runtime(current);
 
 	rcu_read_lock();
-	/* Attempt a lockless read on the first round. */
-	nextseq = 0;
-	do {
-		seq = nextseq;
-		flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
+	XXX(&sig->stats_lock, &flags) {
 		times->utime = sig->utime;
 		times->stime = sig->stime;
 		times->sum_exec_runtime = sig->sum_sched_runtime;
@@ -345,10 +369,7 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
 			times->stime += stime;
 			times->sum_exec_runtime += read_sum_exec_runtime(t);
 		}
-		/* If lockless access failed, take the lock. */
-		nextseq = 1;
-	} while (need_seqretry(&sig->stats_lock, seq));
-	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
+	}
 	rcu_read_unlock();
 }
 


