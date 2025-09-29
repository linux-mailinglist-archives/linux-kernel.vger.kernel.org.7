Return-Path: <linux-kernel+bounces-835833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5661BA82E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215E5189BF93
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615F02BF01E;
	Mon, 29 Sep 2025 06:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2D3bKvX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22ED2BEC41
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128556; cv=none; b=lsWr1lMU11SOz2V3ekXISlgmLV+kWPpT8lEE4n41lTYAcT1qOVg3v6A0l+nS+ZfSNaa2yld4SdQ4BaS22P313BR5IPtiD8IrPOgUiiDO3CjxmxAutv8nTGUfFIIshd3SO71LQA1GMaoiI0gWDraEG0JrGDEvIL5n+/bVCu+tl8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128556; c=relaxed/simple;
	bh=4spyL6Na5g5JJ0fDen/XknT358VQN3W+ZE8ikSf1St0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIDAtW2ONwIExNkZWCUkBxrY64CWt3pVOGclvHdRFTjMxvMuldtAiJis8v+TdJmbc/fChJN0d/CE7AStyFkD84KAI33ZebRFA0nXRWFb2KNJyPSSRCLGbRU9dPcZzlzsKQxYNV/VO/baw3hXcfVPY51+jyuyJy5LRU4/0q4CXUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T2D3bKvX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759128553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zJBrYQzKPmsXe4A2D7OxeNp2JMJW8Wi974UMLzhTcs0=;
	b=T2D3bKvX8cpbW7VafHmGXedkK87NIPFHo/Tu7fCjIVoubNiFuZhIgzK9LcsZpVNQkzrx5A
	frhpRucu3fio+urA6HGfYmGTKVVFY7Yh7rwr3lPwKE3zS+FrTn6Rx4N5azsynFIQbxeuE4
	arXIWCuBGrMvDvWkbgjH4QR9cNY52xE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-hue81e8pOHWNQKMV5lQilQ-1; Mon,
 29 Sep 2025 02:49:09 -0400
X-MC-Unique: hue81e8pOHWNQKMV5lQilQ-1
X-Mimecast-MFC-AGG-ID: hue81e8pOHWNQKMV5lQilQ_1759128548
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1847E1800451;
	Mon, 29 Sep 2025 06:49:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8E4F01800446;
	Mon, 29 Sep 2025 06:49:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 29 Sep 2025 08:47:45 +0200 (CEST)
Date: Mon, 29 Sep 2025 08:47:41 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, David Howells <dhowells@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [????] [RFC 2/1] seqlock: make the read_seqbegin_or_lock() API
 more simple and less error-prone ?
Message-ID: <20250929064740.GA10839@redhat.com>
References: <20250928161953.GA3112@redhat.com>
 <20250928162054.GB3121@redhat.com>
 <8edee550f50647218787cac1016de97a@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8edee550f50647218787cac1016de97a@baidu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 09/29, Li,Rongqing wrote:
>
> > Another problem is that this API is error prone. Two years ago half of the
> > read_seqbegin_or_lock() users were buggy (they followed the wrong example
> > from Documentation/locking/seqlock.rst). And even if the code is mostly
> > correct it is very easy to add a hard-to-detect mistake, see for example
> >
> > 	[PATCH][v3] afs: Remove erroneous seq |= 1 in volume lookup loop
> > 	https://lore.kernel.org/all/20250910084235.2630-1-lirongqing@baidu.co
> > m/
> >
> > Can we improve this API?
> >
> > -------------------------------------------------------------------------------
> > To simplify, suppose we add the new helper
> >
> > 	static inline int need_seqretry_xxx(seqlock_t *lock, int *seq)
> > 	{
> > 		int ret = !(*seq & 1) && read_seqretry(lock, *seq);
> >
> > 		if (ret)
> > 			++*seq;	/* make this counter odd */
> >
> > 		return ret;
> > 	}
> >
> > which can be used instead of need_seqretry(). This way the users do not need
> > to modify "seq" in the main loop. For example, we can simplify
> > thread_group_cputime() as follows:
> >
> > 	--- a/kernel/sched/cputime.c
> > 	+++ b/kernel/sched/cputime.c
> > 	@@ -314,7 +314,7 @@ void thread_group_cputime(struct task_struct
> > *tsk, struct task_cputime *times)
> > 		struct signal_struct *sig = tsk->signal;
> > 		u64 utime, stime;
> > 		struct task_struct *t;
> > 	-	unsigned int seq, nextseq;
> > 	+	unsigned int seq;
> > 		unsigned long flags;
> >
> > 		/*
> > 	@@ -330,9 +330,8 @@ void thread_group_cputime(struct task_struct
> > *tsk, struct task_cputime *times)
> >
> > 		rcu_read_lock();
> > 		/* Attempt a lockless read on the first round. */
> > 	-	nextseq = 0;
> > 	+	seq = 0;
> > 		do {
> > 	-		seq = nextseq;
> > 			flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
> > 			times->utime = sig->utime;
> > 			times->stime = sig->stime;
> > 	@@ -344,9 +343,7 @@ void thread_group_cputime(struct task_struct
> > *tsk, struct task_cputime *times)
> > 				times->stime += stime;
> > 				times->sum_exec_runtime += read_sum_exec_runtime(t);
> > 			}
> > 	-		/* If lockless access failed, take the lock. */
> > 	-		nextseq = 1;
> > 	-	} while (need_seqretry(&sig->stats_lock, seq));
> > 	+	} while (need_seqretry_xxx(&sig->stats_lock, &seq));
> > 		done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
> > 		rcu_read_unlock();
> > 	 }
> >
>
> If this API can be simplified, it should prevent future errors;
>
> I submitted a patch, inspired by inspired by your previous patch, and hope that all places use a fixed syntax, to prevent future errors;
>
> https://lkml.org/lkml/2025/7/31/616

Well, I am not sure it makes a lot of sense to change thread_group_cputime()
this way, "nextseq" or the "seq++" trick is a matter of taste. I tried to
suggest a simplified API to avoid the manipulation of "seq" altogether.

Oleg.

> > most (if not all) of other users can be changed the same way.
> >
> > -------------------------------------------------------------------------------
> > Or perhaps we can even add a helper that hides all the details, something like
> >
> > 	int xxx(seqlock_t *lock, int *seq, int lockless)
> > 	{
> > 		if (lockless) {
> > 			*seq = read_seqbegin(lock);
> > 			return 1;
> > 		}
> >
> > 		if (*seq & 1) {
> > 			read_sequnlock_excl(lock);
> > 			return 0;
> > 		}
> >
> > 		if (read_seqretry(lock, *seq)) {
> > 			read_seqlock_excl(lock);
> > 			*seq = 1;
> > 			return 1;
> > 		}
> >
> > 		return 0;
> >
> > 	}
> >
> > 	#define __XXX(lock, seq, lockless)	\
> > 		for (int lockless = 1, seq; xxx(lock, &seq, lockless); lockless = 0)
> >
> > 	#define XXX(lock)	\
> > 		__XXX(lock, __UNIQUE_ID(seq), __UNIQUE_ID(lockless))
> >
> >
> > ?
> >
> > This way the users can simply do:
> >
> > 	seqlock_t sl;
> >
> > 	void func(void)
> > 	{
> > 		XXX(&sl) {
> > 			... read-side critical section ...
> > 		}
> > 	}
> >
> > using only the new XXX() helper. No need to declare/initialize seq, no need for
> > need_seqretry/done_seqretry.
> >
> > What do you think?
> >
> > Oleg.
>


