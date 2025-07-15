Return-Path: <linux-kernel+bounces-731340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60808B052C7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC974A6CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AD5272804;
	Tue, 15 Jul 2025 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XBY3Z/Fe"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC15226F471
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563961; cv=none; b=f4Ob1z4WQDxXLajfEC5mV4qom+2grMlD24lghPkIQ0i9PBp+LZ+6KpA/WCVGlyjw6hXyliNSSyLOQvTYgRtAU3vG3jxXPx8LDVsHBX5COEeC9cqWOg3yyb3QurVug6IUZVK9ZwY6ajEb0kCbrsIaOU0FT2uFvHBEsMo2bEVgy3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563961; c=relaxed/simple;
	bh=Aj5SxkP3pbJtiSAJWgrM03m/j1mRYKafX3o4uGhsOrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/a7gyrjgby16LKUknVzRDaizCHmyDDuvuMyHO0w9ovh21wOk0Cu9OvfyXbT1ka0kE/otC7wmDrQ1haDdjO1dLUdsE078ibsMgtxEGZwTI8QOtT4ljC1VqjPy0IPCCUH7LNdDZ8D1o1v9Ly3BHhM+eXWFeFkSmjtR60hK3gBOMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XBY3Z/Fe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OFtDJohQGlOhGcPgxY5jVmvQrgNWThXXIGfuiBYm42Y=; b=XBY3Z/Fe4tZp8l2NH9Mae0Qs2Z
	XMEYhlDmlFXmTmMmEDGFIAlKUmDndlnNKhdiuEPn4g/V799fEqvLtltqtS3c3bmRYWFhGZzEtxkFn
	L8OVWSLYviiANNlCfV09iVJQv/i8j86Qnrm1HpLko1e9VFhtcfCcXlv4qSKw34zy1a8ZaggAb8Z5k
	t28em/bbscgVKNjY+H0i9OKZG9SAI5KLcXfICUVB27vawQ3l/0Jc1ToKK4hVOwr6cqPVfE1dT40k/
	kFBPGLF5f2psKn86Ns0QW8zVYkTsaNgRN3UHFMbNDBkrOzImBdHUd+qkBQQgpMUHzpY5O4hI5cqq2
	B8LA5IJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubZwa-00000004JJB-3Ozc;
	Tue, 15 Jul 2025 07:19:16 +0000
Date: Tue, 15 Jul 2025 00:19:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	tech-board-discuss@lists.linuxfoundation.org
Subject: Re: [RFC PATCH 2/5] unwind: Export unwind_user symbol to GPL modules
Message-ID: <aHYA9IPs5QiX-QLs@infradead.org>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
 <20250709212556.32777-3-mathieu.desnoyers@efficios.com>
 <aHC-_HWR2L5kTYU5@infradead.org>
 <20250711065742.00d6668b@gandalf.local.home>
 <aHSmIa3uffj5vW-m@infradead.org>
 <20250714062724.6febd9fb@gandalf.local.home>
 <aHTsOcIUs0ObXCo1@infradead.org>
 <20250714075426.36bdda0b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714075426.36bdda0b@gandalf.local.home>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 14, 2025 at 07:54:26AM -0400, Steven Rostedt wrote:
> On Mon, 14 Jul 2025 04:38:33 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Mon, Jul 14, 2025 at 06:27:24AM -0400, Steven Rostedt wrote:
> > > This has nothing to do with Mathieu being a friend. He's a long time Linux
> > > kernel contributor and has played a key role in developing a new feature
> > > that will help both perf and ftrace, but without the EXPORT_SYMBOL_GPL(),
> > > LTTng can't use it. It's basically saying "thank you Mathieu for helping us
> > > with this new feature, now go F*** off!"  
> > 
> > You don't have to be as explicit, but otherwise that's exactly how
> > it works.  No one gets a free ride just because they are nice and/or
> > contributed something.
> 
> Why is that?

Why would it be any different?  We have a clear reason both for technical
reasons, and to get code upstream.  Making exceptions for vaguely defined
friends and family defeats the entire purpose.

If you want to help Mathieu or others do that by putting your effort
behind the cause instead of making up exceptions.

> How would you recommend getting LTTng into the kernel? It's a relatively
> large project that has 75K of lines of code with development that lasted
> around 20 years.

I honestly don't care.  Not my business.  And you're probably also
asking the wrong question, as those giant old out of tree projects
tend to be a mess because of that.  The right question is really what
functionality does LTTng have that we want in the kernel and work on
that.

