Return-Path: <linux-kernel+bounces-847506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA27BCB0A9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FBC61A65003
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CE3283CB8;
	Thu,  9 Oct 2025 22:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mu5RtL33"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749491A9FAE
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760047974; cv=none; b=DFo+EADcU01syadpG40I0PWup2zXr4l/65DWknhfy6fxlBv2PDwSQluINHvQ2sJDOvXfNgtq3RpUPvlqJcvmRNr+ECxQJI5jjjs43u+QZDmvMOF+MTchur9cFT+nSz2sovOCaQHKVLXyQo79xyekB4Ix+0roZLpQf750HIRifc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760047974; c=relaxed/simple;
	bh=ud1DXl7Bt+NO6UgcsWZkHo604+Lwy3amwayg/fTtK+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jztDIHKMlFSF1vzsVoyMIgoJneoknuBT7he5+wwOCzBZA58fLxcFzTy57WFVz7JBMewBsn8kpmgcnwl1xPnbBn0uSm2c1n7wvRJLOg+SFiyQ+8Su3iQHU0jsPTvwrUQ4YZvIKvLY8YXCJNT+8c+PV7Y42m4TCQsls7P7025iHcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mu5RtL33; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OzMLjZVameR549UBnMxLMwt007CUyi/pnfIYCmRtGYY=; b=mu5RtL33uambI1V8VkzcKK7hCr
	n22+C8qmO2OSwg3F3AHX7XqupuFB8Dn3uBa+QvAjQ6MVV6oL+f36mv08pPDNOjaM19OvjBffqRFMm
	V6lQ1OE6lpAIycPSedzFbxOx5BZEEFaP3BmpZhd3VXnxXrPItW1Ot/8Aw9WIPuUTuc+FlvO7LBiWK
	xD9p5omdnye7VkjUQ3bUhYOV8uiSr1R1RvOchGHNg99ywEHJ51R0dmWIIATFDNX8vmUHiCEZfINAD
	1MM+S/UfzhPbRP9yUeLSG7cs3DqSBFWzLKJGD5rbQVxr6MZS99UM+l2WpdGdckD1PMQU6OtpVqycC
	mBLmU6UQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6ysM-0000000G1p3-0Rw6;
	Thu, 09 Oct 2025 22:12:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 12D0030023C; Fri, 10 Oct 2025 00:12:42 +0200 (CEST)
Date: Fri, 10 Oct 2025 00:12:42 +0200
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
Message-ID: <20251009221242.GX3419281@noisy.programming.kicks-ass.net>
References: <20251008123014.GA20413@redhat.com>
 <20251008123045.GA20440@redhat.com>
 <CAHk-=wjozC9_JCdEW9K_uruJqzTLzhtcVpgDk1OuqErNRUS7Mg@mail.gmail.com>
 <CAHk-=wjuoFm9yZur_T4VOnX2iyDYD6T_gDRXE5ms9538W6Q35g@mail.gmail.com>
 <CAHk-=wiHbN+_LCmSj2sHswDRJ0yG3kkjptMvCXcMwk7jWK1F=Q@mail.gmail.com>
 <20251009143748.GA2704@redhat.com>
 <20251009195024.GL3289052@noisy.programming.kicks-ass.net>
 <20251009201154.GL1386988@noisy.programming.kicks-ass.net>
 <CAHk-=wh3h5cV=UiTg+gvqB-T6+pStDNH0+6w4i34qMC1BQwmpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh3h5cV=UiTg+gvqB-T6+pStDNH0+6w4i34qMC1BQwmpg@mail.gmail.com>

On Thu, Oct 09, 2025 at 01:24:51PM -0700, Linus Torvalds wrote:
> On Thu, 9 Oct 2025 at 13:12, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Slightly nicer version that's actually compiled :-)
> 
> I assume that "target of ss_lockless" is an intentional extension to
> just make the loop never take a lock at all?

Yep. Almost came for free, so might as well do it.

> I do like it, but I think you'll find that having a separate 'seq' and
> 'flags' like this:
> 
> > +struct ss_tmp {
> > +       enum ss_state   state;
> > +       int             seq;
> > +       unsigned long   flags;
> > +       spinlock_t      *lock;
> > +};
> 
> makes it unnecessarily waste a register.
> 
> You never need both seq and flags at the same time, since if you take
> the spinlock the sequence number is pointless.
> 
> So please make that a union, and I think it will help avoid wasting a
> register in the loop.

Sure; otoh compiler should be able to tell the same using liveness
analysis I suppose, but perhaps they're not *that* clever.

> Other than that I like it. Except that "BUG()" really bugs me. It will
> generate horrendous code for no reason and we *really* shouldn't add
> BUG statements anyway.
> 
> Either that inline function is fine, or it isn't. Don't make it
> generate stupid code for "I'm not fine" that will also be a huge pain
> to debug because if that code is buggy it will presumably trigger in
> context where the machine will be dead, dead, dead.

So I thought they were fine; we handle all the enum cases with 'return'
so its impossible to not exit the switch() but the silly compiler was
complaining about possible fall-through, so clearly it was getting
confused.

The ss_done case should never trip either -- perhaps I should make that
one of those __scoped_seqlock_fail like things as well.

Anyway, I'll play around with it some (and look at actual code-gen)
tomorrow.

