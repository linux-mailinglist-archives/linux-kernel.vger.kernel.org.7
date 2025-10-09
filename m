Return-Path: <linux-kernel+bounces-847556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313FEBCB2F8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E84E1A64919
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 23:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71FE274B5F;
	Thu,  9 Oct 2025 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UT4sa0Af"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028F784039
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 23:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760052024; cv=none; b=oQ9GI3nXVhz716LAB36xWjIUElr5XYptteeD91qIFAiZZ7U7sjTJvhfeJ/OIUe2YMM8L3oAMM2JR3Ya2HVKzyShaHqsZ8HvQ+VXsGKkc6kZOnhxYmnt9aIL3R5zEm5f3cD+uDmrvZxMtMGnbWT9ZAmp0VWGijNUTmXDOi9KAHVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760052024; c=relaxed/simple;
	bh=IHphrzCFeAd4dtQlI2rM+rbkpFG26XaL6sWLWETzNYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uX9c1ZtEFJnmteBGuTkz653K51UU6e8ZijnjDwL7wejSpJnIMS7kt4qUXL8SNeepap2mTu461qlaL8S97yx6+O8KCG6EbElel/h/MyslswooopREZrSp+ssPdJJISXDPd3Y+NxvKOYaid1gHOmJ86I6Cjv9n+OjWm2p58WayQHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UT4sa0Af; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LpEwn5HiXMYVFSEnEQjsnVvh9bsvdq1SJ5Q/4/EUG44=; b=UT4sa0AfJhpHr0nRBc9cUEwMgq
	hS68XNkxFTvh1g6HPfh9JGkNQXseQfxPnE0nNWoFOihKq5iMy27+77xSLROapSGRo4Ot0CHc4UlTp
	3l9fXxOhpCBZ4POG9cA60UqCGYDDTm/PDu4rhkA1QEfwZtHEHLoXdiBn8N0Hgo6A8prXGgF7fDxET
	LxC6EixtMyXm6Ya50YYfLgDDtreFgXZMo0BBuyGvIP1j4DX519tjiTp2aV8Jki5w+BLlLhumaHCIJ
	PTCqODdpAk1vIEovDYuG1B2cSlx6ex+epF7oO8jAUAQ8WWJYvzmdpX78HoKX8zo60PYGFGt+4dLba
	501D5Ykw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6zvd-00000001lVq-2gZc;
	Thu, 09 Oct 2025 23:20:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 64E3830023C; Fri, 10 Oct 2025 01:20:08 +0200 (CEST)
Date: Fri, 10 Oct 2025 01:20:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] seqlock: introduce scoped_seqlock_read() and
 scoped_seqlock_read_irqsave()
Message-ID: <20251009232008.GM1386988@noisy.programming.kicks-ass.net>
References: <20251008123014.GA20413@redhat.com>
 <20251008123045.GA20440@redhat.com>
 <CAHk-=wjozC9_JCdEW9K_uruJqzTLzhtcVpgDk1OuqErNRUS7Mg@mail.gmail.com>
 <CAHk-=wjuoFm9yZur_T4VOnX2iyDYD6T_gDRXE5ms9538W6Q35g@mail.gmail.com>
 <CAHk-=wiHbN+_LCmSj2sHswDRJ0yG3kkjptMvCXcMwk7jWK1F=Q@mail.gmail.com>
 <20251009143748.GA2704@redhat.com>
 <20251009195024.GL3289052@noisy.programming.kicks-ass.net>
 <20251009201154.GL1386988@noisy.programming.kicks-ass.net>
 <CAHk-=wh3h5cV=UiTg+gvqB-T6+pStDNH0+6w4i34qMC1BQwmpg@mail.gmail.com>
 <20251009221242.GX3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009221242.GX3419281@noisy.programming.kicks-ass.net>

On Fri, Oct 10, 2025 at 12:12:42AM +0200, Peter Zijlstra wrote:
> On Thu, Oct 09, 2025 at 01:24:51PM -0700, Linus Torvalds wrote:
> > On Thu, 9 Oct 2025 at 13:12, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > Slightly nicer version that's actually compiled :-)
> > 
> > I assume that "target of ss_lockless" is an intentional extension to
> > just make the loop never take a lock at all?
> 
> Yep. Almost came for free, so might as well do it.
> 
> > I do like it, but I think you'll find that having a separate 'seq' and
> > 'flags' like this:
> > 
> > > +struct ss_tmp {
> > > +       enum ss_state   state;
> > > +       int             seq;
> > > +       unsigned long   flags;
> > > +       spinlock_t      *lock;
> > > +};
> > 
> > makes it unnecessarily waste a register.
> > 
> > You never need both seq and flags at the same time, since if you take
> > the spinlock the sequence number is pointless.
> > 
> > So please make that a union, and I think it will help avoid wasting a
> > register in the loop.
> 
> Sure; otoh compiler should be able to tell the same using liveness
> analysis I suppose, but perhaps they're not *that* clever.

The moment I use a union gcc-14 creates the whole structure on the
stack, while without the union it mostly manages to keep the things
in registers without too much spilling.

Also, there's a rather silly bug in the code, the __cleanup function
looks at ->state to determine which spin_unlock variant to pick, but
->state will be ss_done. Additionally, when someone does 'break' or
'goto' out of the scope the state isn't reliably anyway.

The sanest code gen happens when I do:

struct ss_tmp {
	enum ss_state	state;
	int		seq;
	unsigned long	flags;
	spinlock_t	*lock;
	spinlock_t	*lock_irqsave;
}

static inline void __scoped_seqlock_cleanup(struct ss_tmp *sst)
{
	if (sst->lock)
		spin_unlock(sst->lock);
	if (sst->lock_irqsave)
		spin_unlock_irqrestore(sst->lock, sst->flags);
}

liveness analysis seems to work well, and it is able to determine which
fields are active and only track those in registers and utterly discard
the rest. Specifically in the thread_group_cputime code, there are only
_raw_spin_lock_irqsave and _raw_spin_unlock_irqrestore calls left, all
the other stuff is just optimized out.

I'll look what clang does ... but that's really tomorrow, or rather,
somewhat later this morning :/

