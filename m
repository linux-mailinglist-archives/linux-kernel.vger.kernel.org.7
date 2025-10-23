Return-Path: <linux-kernel+bounces-866651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82889C005A1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72F014E4D35
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F6230ACEA;
	Thu, 23 Oct 2025 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tq8+3nu2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1034030AAC6
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761213195; cv=none; b=sGG3xc2GZs7GdtTDsYbS1Iw9ARqcYd6c8Ut4qIIyY8LMCHDlL0sXmXqWXPytG1WraiExtNBUZRfGqK/EYq53a7sd6FJAlR6EFxzVJNhyrf8PBF9gSPqtVUquz/LQQ4ALrd/A8uPDhxdz0MSJ4Qq1fDED3+et9QSVFUl9B4+V0Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761213195; c=relaxed/simple;
	bh=+QNz/sCSPxowQ4A0rSFGwe+MjrYJUcdB/1Em1dn79zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULSk98waHLSI9KVRwjd96mOOC5WKS8tPbR20XbRahuzTabEWbhpbcaHLLCVi+HPKII+Scf03U5pogaK1nB0Y/OeDeim2lhgEMSPQcC77p2FE7izhwBLc+GxgH9y2dsAYcdhe1jY4nPs9mR6fQPmoXU4Cqv1PULhFEbe8OYZMmRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Tq8+3nu2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nl2wRTUWcntq2xNhTw4r9w369kiI8o+A4/HrciECOgk=; b=Tq8+3nu28G8qeZWLExFy875P/U
	uwKULw8l6/nAyCF/eJPcgmLbr2fUWJL9QxMYuOpOvQl9eS3iU21yNlDNqvpQL4o2BvccBZkEVN6bo
	os+m95itO9k/PzFeWhRUr5cG1upQ0e+7QMPdrpB2wRVGvWXS8OufQTynNGnqx49dsnq5PNAykb+n0
	pMLZog1SM4KWKBmnb3nA85QsNGpvMutFWbLZO8SkFs/sWbeYv+le2QUHG/yIjOohgjepQS4o0MdT8
	iqMElsCUtGcSNB1FekLnI+5P4EamdIG++Tl2liUkN6M2hQfkxLZen4fHHKDw56W6SKGRsoP3cKUHo
	852BkWpw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBs0J-0000000HJlK-0MhZ;
	Thu, 23 Oct 2025 09:53:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3F9D6300208; Thu, 23 Oct 2025 11:53:07 +0200 (CEST)
Date: Thu, 23 Oct 2025 11:53:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: jpoimboe@kernel.org, rostedt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] unwind: Simplify unwind_user_next_fp() alignment
 check
Message-ID: <20251023095307.GZ3245006@noisy.programming.kicks-ass.net>
References: <20250924075948.579302904@infradead.org>
 <20250924080119.497867836@infradead.org>
 <20251001115524.24542fd8@gandalf.local.home>
 <20251020102814.GN3419281@noisy.programming.kicks-ass.net>
 <20251022112032.130218cd@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022112032.130218cd@gandalf.local.home>

On Wed, Oct 22, 2025 at 11:20:32AM -0400, Steven Rostedt wrote:
> On Mon, 20 Oct 2025 12:28:14 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Oct 01, 2025 at 11:55:24AM -0400, Steven Rostedt wrote:
> > > On Wed, 24 Sep 2025 09:59:58 +0200
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > > I would add a change log. Something like:
> > > 
> > >   sizeof(long) is 4 or 8. Where 4 = 1 << 2 and 8 = 1 << 3.
> > >   Calculating shift to be 2 or 3 and then passing that variable into
> > >   (1 << shift) is the same as just using sizeof(long).  
> > 
> > I've made it: "2^log_2(n) == n". I find it very hard to spend that many
> > words on something this trivial :-)
> 
> What you don't like Common Core Math[1]?

I'm not sure I'm qualified to comment on that particular topic. Yes,
there are many equivalent ways of doing 'math' and it is fun to explore
them all.

Specifically: 3000-1 and 2999+1 should both be mastered and both involve
the (decimal) carry bit. If your curriculum does not provide, or treats
one as more difficult from the other, something is wrong.

The thing I've noticed with my own kids though, is that teachers often
don't master these basics themselves, and find it very hard to properly
explain these things. This then makes me wonder HTF they ever got to be
a teacher, in face of their obvious incompetence, but that's another
problem.

[ I am now having to explain and derive the abc formula for finding the
  roots of the 2nd grade polynomial to my kid because curriculum mostly
  'forgot' about proofs and provides 'tricks' instead of understanding.

  Also, there is a very nice tie-in with this derivation of the abc
  formula to the starting point of calculus, notably the expression for
  finding the extreme is of course f'(x)=0, but is found here through
  simple algebra. ]

Anyway, I find throwing heaps of natural language at a trivial statement
makes it more opaque, rather than clearer.

