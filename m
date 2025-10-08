Return-Path: <linux-kernel+bounces-845542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A06C5BC552D
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53F384E9F5B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4417A287512;
	Wed,  8 Oct 2025 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cN84VAN3"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14A928136B
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931695; cv=none; b=bW5t05jAqmWi4T+FEergAFCKiRZeNXX9yVz4WrcNj/XbKqHFSAKHmAYiDJdpixZZSHm+mymit7C4DU9g78VST6Nj9lldkIADZMUW8x0L2AsSQcJywjD0q4QX6snm+N3JFBEOoMeoJ2CCDRm0WL3iq4+FuhkGopIFoDQRm6qhFJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931695; c=relaxed/simple;
	bh=KaOEP7hl9cgTB2S2NJ2qf63TWLaM0s5Mzu574b5hLFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbGMHs+qbl1oFdG5hW5dvyZbCRfbyOfkv93N5SYWeHLq86/3rFnGB80S4061TcTu3HUzcQnez3mk/T+g/GHRVA1wf7IS7FqDmOsXa+g1/O5FqgAfiM9LAUn/+IfKsVpuhgDKccQ8COvZblvDECTq4tsmtXnKgwWIEF7sTd5A7Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cN84VAN3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YM/SaVga4KAyWAanRvJdElPb2xcC5s+RfnhpKJaVGgU=; b=cN84VAN3aQDBIVSNiJ0U4QKWJB
	fEbroQ31W7DyPKgLhMr06QiDMSZbGhAskwVbNaSV+xXY1tD+bHBIyQIXVp9ZnL7VINJgII2pCuO2K
	D44b/GdlBOYDlWub6ZAimdpwzG6tSpFmBmOuPMIizbea/O5haATpv0v9sIeIUM71xDuBBEXtRlss2
	cevn1CyTAwhFRZwwVXtNry1xLSHoQXPqe1P8MWqxMIR6t4IynUv0dBBGIud/9BzpsKzaVpVL+y+ME
	ckn4bj+gPAlq6ND9pqfoGHlOhg5KUr2Adn2eDT6yiqFuXJ9K6pCKJkJCyiw2rlcP21c/7TDekV+VG
	IfASX9rQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6Ucu-00000000jgy-45Fu;
	Wed, 08 Oct 2025 13:54:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0A2DF300400; Wed, 08 Oct 2025 15:54:44 +0200 (CEST)
Date: Wed, 8 Oct 2025 15:54:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] seqlock: introduce scoped_seqlock_read() and
 scoped_seqlock_read_irqsave()
Message-ID: <20251008135443.GU4067720@noisy.programming.kicks-ass.net>
References: <20251008123014.GA20413@redhat.com>
 <20251008123045.GA20440@redhat.com>
 <20251008125508.GJ3289052@noisy.programming.kicks-ass.net>
 <20251008125902.GA23813@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008125902.GA23813@redhat.com>

On Wed, Oct 08, 2025 at 02:59:03PM +0200, Oleg Nesterov wrote:
> On 10/08, Peter Zijlstra wrote:
> >
> > On Wed, Oct 08, 2025 at 02:30:45PM +0200, Oleg Nesterov wrote:
> > >
> > > 	scoped_seqlock_read_irqsave (&seqlock) {
> > > 		// read-side critical section
> > > 	}
> > >
> >
> > Hmm, on first reading I was expecting that to be:
> >
> > 	do {
> > 		seq = read_seqbegin(&seqlock);
> >
> > 		// read-side section
> >
> > 	} while (read_seqretry(&seqlock, seq));
> >
> > for lack of that _or_lock() wording, but I suppose we can make that
> > something like:
> >
> >  	scoped_seqbegin_read (&seqlock) {
> 
> I was thinking about scoped_seqcount_read() but I agree with any naming

Ah, but that would take a seqcount_*t not a seqlock_t no?

Or we can do:

	scoped_seqcount_read (&seqlock.seqcount)

But yeah, for later I suppose.

