Return-Path: <linux-kernel+bounces-850189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4B2BD2318
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A51914EDD32
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C022F9DB2;
	Mon, 13 Oct 2025 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H1oT1epM"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDC223F429
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346202; cv=none; b=umfSlAMNwUN+QMePKJTjYWUBV0K0ZN3Qb8i4+Mdnx4dV0NJyFjblQOCRt1gqegln2IAI3DrSU6zU1199xwpb+j9Xyw7HqK4LbJ04D6HTwbikRklY4P0lN6DvrtqNxJKO7d0IpNlDnazdRoaQxdBgMtF5zuwHX2yESrWnSJNoCeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346202; c=relaxed/simple;
	bh=kr75SPLKu6ZEBAmXKmXbQq/exoBT8A8lBuyW5JGaozM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFCLXKLqWf01tNI/HeuohcY/fCZmoYxCj9si8v8KkPTyZ2bbvWI5Kkvq3/mshZkV6lBRI0zP/bQVnD6siavzAM4IQ6rYe8sYWyKc+TDfWoJs952vlPWVsVms3mpBekdp7bkaKV59TaLm2QaS7m9YJZ/mN/5klFxczQ9gJwQ/J8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H1oT1epM; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pmhpaQQgOS9ATeEGamVwWMEItrO2vHDmUypkgEAcNqo=; b=H1oT1epMnqv7KzkqxOzgslO0Oj
	5XYp0y/VC1Uqoanj99/aLaG5w/jAknwsE+bTO9AG2eJK/DtQ6YLCtl3iwmadkCfJs7yoN7r+md5JX
	dCHLSUscXHI17pKCUmGOmtDiCTWNA4aYxmH8eZxLahHQrz2Ld7t9RNWItDnj9cDbxiqAmFtX5lEP0
	qR+rb3lDYIJxFBZqcF35Zrpr7ebKltL0zekL625pcNAOZvVAZIKevuRgP/tfSmkAGJzR0T7v8OsQg
	b0a+GDpmHPRvAN2QrM0swdzlfXKvPbcFxFtKGq4yrLcNyveorpDTypqL/JXWP+HNCq6BptJkLWUHC
	GU6Tx49g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8ESY-00000004DTr-0PAw;
	Mon, 13 Oct 2025 09:03:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3266F300212; Mon, 13 Oct 2025 11:03:13 +0200 (CEST)
Date: Mon, 13 Oct 2025 11:03:13 +0200
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
Message-ID: <20251013090313.GI4067720@noisy.programming.kicks-ass.net>
References: <CAHk-=wiHbN+_LCmSj2sHswDRJ0yG3kkjptMvCXcMwk7jWK1F=Q@mail.gmail.com>
 <20251009143748.GA2704@redhat.com>
 <20251009195024.GL3289052@noisy.programming.kicks-ass.net>
 <20251009201154.GL1386988@noisy.programming.kicks-ass.net>
 <CAHk-=wh3h5cV=UiTg+gvqB-T6+pStDNH0+6w4i34qMC1BQwmpg@mail.gmail.com>
 <20251009221242.GX3419281@noisy.programming.kicks-ass.net>
 <CAHk-=whmjm0BbirO8HhT_TZQ2JJMs_FpTcT9SXXaA3NifW2a4w@mail.gmail.com>
 <20251010080327.GF4067720@noisy.programming.kicks-ass.net>
 <20251010122347.GA8798@redhat.com>
 <20251010131439.GB8798@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010131439.GB8798@redhat.com>

On Fri, Oct 10, 2025 at 03:14:39PM +0200, Oleg Nesterov wrote:
> On 10/10, Oleg Nesterov wrote:
> >
> > On 10/10, Peter Zijlstra wrote:
> > >
> > > I reordered the code, it is happier now.
> > >
> > > Anyway, the below seems to generate decent code for
> > > {-O2,-Os}x{gcc-14,clang-22}. Yay for optimizing compilers I suppose :-)
> >
> > Another approach which looks better than mine ;)
> >
> > Linus's version is simpler, but yours can handle break/return and
> > the "only lockless" case, good.
> >
> > I leave this patch to you and Linus, he seems to like your code too.
> >
> > Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> >
> >
> > But... perhaps we should not "export" the _target names and instead
> > add the additional defines, something like
> >
> > 	scoped_seqlock_read()
> > 	scoped_seqlock_read_or_lock()
> > 	scoped_seqlock_read_or_lock_irqsave()
> >
> > ?
> 
> And... perhaps we can simplify this code a little bit? I mean
> 
> 	enum ss_state {
> 		ss_lockless	= 0,
> 		ss_lock		= 1,
> 		ss_lock_irqsave	= 2,
> 		ss_done		= 4,
> 	};
> 
> 	struct ss_tmp {
> 		enum ss_state	state;
> 		unsigned long	data;
> 		seqlock_t	*lock;
> 	};
> 
> 	static inline void __scoped_seqlock_cleanup(struct ss_tmp *sst)
> 	{
> 		if (sst->state & ss_lock)
> 			spin_unlock(&sst->lock.lock);
> 		if (sst->state & ss_lock_irqsave)
> 			spin_unlock_irqrestore(&sst->lock.lock, sst->data);
> 	}
> 
> 	static inline void
> 	__scoped_seqlock_next(struct ss_tmp *sst, enum ss_state target)
> 	{
> 		switch (sst->state) {
> 		case ss_lock:
> 		case ss_lock_irqsave:
> 			sst->state |= ss_done;
> 			return;
> 
> 		case ss_lockless:
> 			if (!read_seqretry(sst->lock, sst->data)) {
> 				sst->state = ss_done;
> 				return;
> 			}
> 			break;
> 		}
> 
> 		switch (target) {
> 		case ss_lock:
> 			spin_lock(&sst->lock.lock);
> 			sst->state = ss_lock;
> 			return;
> 
> 		case ss_lock_irqsave:
> 			spin_lock_irqsave(&sst->lock.lock, sst->data);
> 			sst->state = ss_lock_irqsave;
> 			return;
> 
> 		case ss_lockless:
> 			sst->data = read_seqbegin(sst->lock);
> 			return;
> 		}
> 	}
> 
> 	#define __scoped_seqlock_read(_seqlock, _target, _s)			\
> 		for (struct ss_tmp _s __cleanup(__scoped_seqlock_cleanup) =				\
> 		     { .state = ss_lockless, .data = read_seqbegin(_seqlock), .lock = __seqlock };	\
> 		     !(_s.state & ss_done);								\
> 		     __scoped_seqlock_next(&_s, _target))
> 
> 
> (I removed __scoped_seqlock_invalid_target/__scoped_seqlock_bug to lessen the code).
> 
> Not sure this makes sense. Plus I didn't even try to compile this code and I have
> no idea how this change can affect the code generation. But let me ask anyway...

So GCC is clever enough to see through this scheme, but Clang gets
confused and generates worse code. Specifically it emits the whole
__scoped_seqlock_cleanup() sequence, testing both bits and both unlock
options.

Where previously it would only have to discover which field was written
to and could delete all code for the unwritten field, it now has to
track the state and discover ss_lock|ss_done is not possible while
ss_lock_irqsave|ss_done is.

So while that additional pointer might seem wasteful, it actually makes
the state tracking easier and allows the compiler to more easily throw
away stuff.


