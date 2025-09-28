Return-Path: <linux-kernel+bounces-835494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E37BA7493
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 18:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D3F1895631
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 16:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74228237163;
	Sun, 28 Sep 2025 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="astyeooO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBB11F130A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759076548; cv=none; b=mS4poYtjdm8kiMjy3CKZYpOaza0kLRJxjdbgMtpTMr1/P45LcTvqImQ44x8z6JH6AujXBeUfT7Yg01aHZpIT41nUDusI+RZJdZKf9cYkZbPE3vthEDfj+FJsOvUVYFEAtznKQtQj8PORC6sD+O1S+USXwKD/v/lIESpT5G/7gmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759076548; c=relaxed/simple;
	bh=VCaG8EC3wI18Xn4jYIXGblrM3j4nV7m83t6sfwwYBmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0b+d+jhLCD2zSNsIi+Ow5tWkqFMesbu9AaeEhqDgsCdvLtiZ+IQOrXUiFkP+z9nP9ljLflfX0V9Cxb1QkuKyfCs9MjIcuGu4edL8kIBeS/MvWheLohF7nk5/61+wwB+i8N0x40Kb/ASLpgB3eb8KZq61l/Ij5U94SqUR6RnOxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=astyeooO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759076546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dJec5gQDM9jGAM6PC3GEKxNTGVzgNlqTk1q25WJJ/TI=;
	b=astyeooOqtR5S4HPqxfALT9FvTyKVD/8jj8hOBEfFiUWxdSFpQwYmKDBbjSFvF8tcK1aF5
	LsT26gnomoRCVUTlgkYT6sqWp4iKAunRMHt5pO5LjvZ8KkSovbWmTn5t+78IDQ+om0y7b6
	yuw6yOCRNzXu6iYStPSFcmGglxrBLAo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-Su_QsFm2MRyYnsFbcv61lg-1; Sun,
 28 Sep 2025 12:22:22 -0400
X-MC-Unique: Su_QsFm2MRyYnsFbcv61lg-1
X-Mimecast-MFC-AGG-ID: Su_QsFm2MRyYnsFbcv61lg_1759076541
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58DAA180057B;
	Sun, 28 Sep 2025 16:22:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 991341800576;
	Sun, 28 Sep 2025 16:22:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 28 Sep 2025 18:20:58 +0200 (CEST)
Date: Sun, 28 Sep 2025 18:20:54 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Boqun Feng <boqun.feng@gmail.com>, David Howells <dhowells@redhat.com>,
	Ingo Molnar <mingo@redhat.com>, Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC 2/1] seqlock: make the read_seqbegin_or_lock() API more simple
 and less error-prone ?
Message-ID: <20250928162054.GB3121@redhat.com>
References: <20250928161953.GA3112@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928161953.GA3112@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Another problem is that this API is error prone. Two years ago half of the
read_seqbegin_or_lock() users were buggy (they followed the wrong example
from Documentation/locking/seqlock.rst). And even if the code is mostly
correct it is very easy to add a hard-to-detect mistake, see for example

	[PATCH][v3] afs: Remove erroneous seq |= 1 in volume lookup loop
	https://lore.kernel.org/all/20250910084235.2630-1-lirongqing@baidu.com/

Can we improve this API?

-------------------------------------------------------------------------------
To simplify, suppose we add the new helper

	static inline int need_seqretry_xxx(seqlock_t *lock, int *seq)
	{
		int ret = !(*seq & 1) && read_seqretry(lock, *seq);

		if (ret)
			++*seq;	/* make this counter odd */

		return ret;
	}

which can be used instead of need_seqretry(). This way the users do not
need to modify "seq" in the main loop. For example, we can simplify
thread_group_cputime() as follows:

	--- a/kernel/sched/cputime.c
	+++ b/kernel/sched/cputime.c
	@@ -314,7 +314,7 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
		struct signal_struct *sig = tsk->signal;
		u64 utime, stime;
		struct task_struct *t;
	-	unsigned int seq, nextseq;
	+	unsigned int seq;
		unsigned long flags;
	 
		/*
	@@ -330,9 +330,8 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
	 
		rcu_read_lock();
		/* Attempt a lockless read on the first round. */
	-	nextseq = 0;
	+	seq = 0;
		do {
	-		seq = nextseq;
			flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
			times->utime = sig->utime;
			times->stime = sig->stime;
	@@ -344,9 +343,7 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
				times->stime += stime;
				times->sum_exec_runtime += read_sum_exec_runtime(t);
			}
	-		/* If lockless access failed, take the lock. */
	-		nextseq = 1;
	-	} while (need_seqretry(&sig->stats_lock, seq));
	+	} while (need_seqretry_xxx(&sig->stats_lock, &seq));
		done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
		rcu_read_unlock();
	 }

most (if not all) of other users can be changed the same way.

-------------------------------------------------------------------------------
Or perhaps we can even add a helper that hides all the details, something like

	int xxx(seqlock_t *lock, int *seq, int lockless)
	{
		if (lockless) {
			*seq = read_seqbegin(lock);
			return 1;
		}

		if (*seq & 1) {
			read_sequnlock_excl(lock);
			return 0;
		}

		if (read_seqretry(lock, *seq)) {
			read_seqlock_excl(lock);
			*seq = 1;
			return 1;
		}

		return 0;

	}

	#define __XXX(lock, seq, lockless)	\
		for (int lockless = 1, seq; xxx(lock, &seq, lockless); lockless = 0)

	#define XXX(lock)	\
		__XXX(lock, __UNIQUE_ID(seq), __UNIQUE_ID(lockless))


?

This way the users can simply do:

	seqlock_t sl;

	void func(void)
	{
		XXX(&sl) {
			... read-side critical section ...
		}
	}

using only the new XXX() helper. No need to declare/initialize seq, no need
for need_seqretry/done_seqretry.

What do you think?

Oleg.


