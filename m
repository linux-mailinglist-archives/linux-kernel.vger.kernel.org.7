Return-Path: <linux-kernel+bounces-812474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A6DB5389C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9D1E1884C57
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954E835082D;
	Thu, 11 Sep 2025 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XbPiLc8/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m/4SGdnt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807A2340D8C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606570; cv=none; b=ADZ8liWK9MgjtAx5AUs/4bq24x3q9TaXTmBgm/HdwHzSr6Drmb7c7V3rMNMWSEtNxB5vL82JLs1IGzAvtU1tb5mGp1hEBEg4TViAmluR5M6/5pIw6D9p4/MhFw/+L2fpNVlWK1DqeDL0kFZirxeC8rJm81o57CGkDB5xf1ACg5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606570; c=relaxed/simple;
	bh=ll/kINXh/9MGd3DoUtItQ1VjkZRl7CcV6iQPk5TOTEg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OLnPf/vGNZhQahMyLE8pe1dyXBHV36PZFp1XnEnMNI0v++bJkfGjmyqgl69YZ7OF3MfjRd0BGrgD6NgeIq7fG58ubDerZJcvg8asKoTtvwYz/MFbPuYI6UP4BJNp9bKA23McAnnPGLHsP1X3pR+391RUMtPR9HRYqk7thQpgjbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XbPiLc8/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m/4SGdnt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757606565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1qXM1SJmzae6adVmu4WR3emS+Bh51b1+iIzFh3M5hoo=;
	b=XbPiLc8/44yH56n/MT03du/bqn0tHHJf06AYUSkGQqEmaWY83BDP4jfDAcvhDLNZDPsjPw
	lhUD767c04VZxOnWP7QreylbfEbAkiHM1tD0vNfbv6NN/A3QDrpPTBpLz3IXyDfk6EJuwA
	YB0eA98oxBCau+L444MKZzpSWNrBsYg6+UBhjH1NybiDOTUctZ1CKfj5sHwbdQgVe7VYag
	L9MMr7tOzJDENnInfSIgPrWwGu8Lcu0nyxQ94kOaQIr4LHfRdOamodSAimaBalevoesbtB
	EvINMkNjiUpk/kKKBWpeNdbUCenb1I+nQ6Fxi37j/WYPJzM8ZXYRquBbE7750g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757606565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1qXM1SJmzae6adVmu4WR3emS+Bh51b1+iIzFh3M5hoo=;
	b=m/4SGdntNkEP91FUrsKVt4Q5FIhyehiA+ba7MQRk+vrKzMZ9DuU7B5h39vN2U6HzpARL8+
	EYP+9F7vJBv9YdAw==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patch V4 23/36] rseq: Provide and use rseq_set_ids()
In-Reply-To: <a5b70b86-ce87-435e-9ba5-407ea98e8c8b@efficios.com>
References: <20250908212737.353775467@linutronix.de>
 <20250908212926.738408636@linutronix.de>
 <a5b70b86-ce87-435e-9ba5-407ea98e8c8b@efficios.com>
Date: Thu, 11 Sep 2025 18:02:44 +0200
Message-ID: <874it9rn8b.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 11 2025 at 09:40, Mathieu Desnoyers wrote:
> On 2025-09-08 17:32, Thomas Gleixner wrote:
>> +/*
>> + * On debug kernels validate that user space did not mess with it if
>> + * DEBUG_RSEQ is enabled, but don't on the first exit to user space. In
>> + * that case cpu_cid is ~0. See fork/execve.
>> + */
>> +bool rseq_debug_validate_ids(struct task_struct *t)
>> +{
>> +	struct rseq __user *rseq = t->rseq.usrptr;
>
> Why not check on NULL rseq user pointer rather than skip using
> the ~0ULL cpu_cid ?

It's not about the NULL rseq pointer.

At the point of a freshly installed RSEQ the cached values are invalid
when the task goes out to user space for the first time because the
write out obviously never happened before that.

We could write out some defined value when RSEQ is installed and cache
that, but I did not think about that and this is debug code so I did not
care about the performance that much.

>> +	u32 cpu_id, uval, node_id;
>> +
>> +	if (t->rseq.ids.cpu_cid == ~0)
>
> Here we are using ~0 and where cpu_cid is set in rseq_set() ~0ULL is
> used. Now I understand that because of sign-extend and type promotion
> this happens to provide all bits set on a 64-bit, but can we please just
> pick one, e.g. ~0ULL ?

Sure. Trivial enough

> Also why does rseq_fork() set it to ~0ULL rather than keep the value
> from the parent when forking a new process ?
>
> Whatever was present in the parent process in the rseq area should
> still be in the child, including the rseq registration.
>
> Or am missing something ?

Not really. I just made all those cases (install, fork, exec...) behave
the same way. It's harmless enough, no?

Thanks,

        tglx

