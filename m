Return-Path: <linux-kernel+bounces-746500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EA1B12778
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 01:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096063AF3A7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 23:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953E725FA3B;
	Fri, 25 Jul 2025 23:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="avQz/70D"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D35F257AF9;
	Fri, 25 Jul 2025 23:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753486169; cv=none; b=sdFn/5PuK9IYgrfDkW1JJaGARVeyvDoWnoSHKK/f5IeY6prk04Jk1tyeVoUi6X8lUngTlrEHscUBtBHhF6WEh6q43YrRCJW5tY8gQcY+90GwMwrOOu60ffQEAKnUox/KgjXm0RW054DdNVRQSFqyLr6HjorOaR2vYVuyT7k+NKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753486169; c=relaxed/simple;
	bh=R5l3oFGTLukSK9sw1k0scbzU39GzzcxcQt3mDJLyyV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASBlYF40ry6Dz4dYhM7ZKwZqEFOkjzTBHDXhtUddv8PIBzatCXcDfwsXF7tAsmtRtW3cJR891Y0drMwE0P+x1ANezniHKdyXwoYJ+ku7qp0JP0+s8MTUAURHbkVZ+IzZ3Fq1xYj88lEhdm6xz9/zYOiT665Tv0V6dQsTige8yOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=avQz/70D; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=7/6Mvp/HmKwTR0veXV11IQkg7Afl723Mtblk3lghe6k=; b=avQz/70DpiVW9trH
	uABTdYfxwBkb/GrXfruN1zoWHOwIydZIZ+34tP8SsUCYarCTAxaTKfcuWkebZQoHyhGhpy04SB229
	VNUw/LI3bWVEFOYNl0rap4fytrbwEqY6pipIStcPnbYQ+orJPFUqpx5iPx9hqCNRXLXiR8GF9dpqX
	es0zizv6jd9vCMyoSW6ay/fB1xRrevIpvZXiDBvqx9z8fVWOM98egkSwEc38B5J3Sa/j9utJTK3rz
	3J8NDKxMc0OGQ0JkVl9ShCqaEA1t4Qm8sPus7dqkDp8HuDbmyeoBvN/Sj6o/MKIUEgik1DHZQUjRW
	YDeebWfsbvAZ5atcdQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1ufRqp-000iOj-2y;
	Fri, 25 Jul 2025 23:29:19 +0000
Date: Fri, 25 Jul 2025 23:29:19 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	corbet@lwn.net, workflows@vger.kernel.org, josh@joshtriplett.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs: submitting-patches: (AI?) Tool disclosure tag
Message-ID: <aIQTT6Gaf1WhxRX7@gallifrey>
References: <202507241337.F9595E1D@keescook>
 <aIKhvubVqgeXIlrj@gallifrey>
 <202507241418.34AFD28C@keescook>
 <20250724194556.105803db@gandalf.local.home>
 <202507241651.5E9C803C70@keescook>
 <aILYj62tF_1mDjDO@lappy>
 <aILb-zDiDr4b9u9S@gallifrey>
 <aILjTKk_v8NPxlVJ@lappy>
 <aINqjTAwbQ_xnAw6@gallifrey>
 <aIQHzWOkWYCGX4Xg@lappy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aIQHzWOkWYCGX4Xg@lappy>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 23:20:11 up 89 days,  7:33,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Sasha Levin (sashal@kernel.org) wrote:
> On Fri, Jul 25, 2025 at 11:29:17AM +0000, Dr. David Alan Gilbert wrote:
> > * Sasha Levin (sashal@kernel.org) wrote:
> > > On Fri, Jul 25, 2025 at 01:20:59AM +0000, Dr. David Alan Gilbert wrote:
> > > > * Sasha Levin (sashal@kernel.org) wrote:
> > > > > On Thu, Jul 24, 2025 at 04:54:11PM -0700, Kees Cook wrote:
> > > > > > On Thu, Jul 24, 2025 at 07:45:56PM -0400, Steven Rostedt wrote:
> > > > > > > My thought is to treat AI as another developer. If a developer helps you
> > > > > > > like the AI is helping you, would you give that developer credit for that
> > > > > > > work? If so, then you should also give credit to the tooling that's helping
> > > > > > > you.
> > > > > > >
> > > > > > > I suggested adding a new tag to note any tool that has done non-trivial
> > > > > > > work to produce the patch where you give it credit if it has helped you as
> > > > > > > much as another developer that you would give credit to.
> > > > > >
> > > > > > We've got tags to choose from already in that case:
> > > > > >
> > > > > > Suggested-by: LLM
> > > > > >
> > > > > > or
> > > > > >
> > > > > > Co-developed-by: LLM <not@human.with.legal.standing>
> > > > > > Signed-off-by: LLM <not@human.with.legal.standing>
> > > > > >
> > > > > > The latter seems ... not good, as it implies DCO SoB from a thing that
> > > > > > can't and hasn't acknowledged the DCO.
> > > > >
> > > > > In my mind, "any tool" would also be something like gcc giving you a
> > > > > "non-trivial" error (think something like a buffer overflow warning that
> > > > > could have been a security issue).
> > > > >
> > > > > In that case, should we encode the entire toolchain used for developing
> > > > > a patch?
> > > > >
> > > > > Maybe...
> > > > >
> > > > > Some sort of semi-standardized shorthand notation of the tooling used to
> > > > > develop a patch could be interesting not just for plain disclosure, but
> > > > > also to be able to trace back issues with patches ("oh! the author
> > > > > didn't see a warning because they use gcc 13 while the warning was added
> > > > > in gcc 14!").
> > > > >
> > > > > Signed-off-by: John Doe <jd@example.com> # gcc:14.1;ccache:1.2;sparse:4.7;claude-code:0.5
> > > > >
> > > > > This way some of it could be automated via git hooks and we can recommend
> > > > > a relevant string to add with checkpatch.
> > > >
> > > > For me there are two separate things:
> > > >  a) A tool that found a problem
> > > >  b) A tool that wrote a piece of code.
> > > >
> > > > I think the cases you're referring to are all (a), where as I'm mostly
> > > > thinking here about (b).
> > > > In the case of (a) it's normally _one_ of those tools that found it,
> > > > e.g. I see some:
> > > >   Found by gcc -fanalyzer
> > > 
> > > I think that the line between (a) and (b) gets very blurry very fast, so
> > > I'd rather stay out of trying to define it.
> > > 
> > > Running "cargo clippy" on some code might generate a warning as follows:
> > > 
> > > warning: variables can be used directly in the `format!` string
> > >   --> dyad/src/kernel/sha_processing.rs:20:13
> > >    |
> > > 20 |             debug!("git sha {} could not be validated, attempting a second way...", git_sha);
> > >    |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >    |
> > >    = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#uninlined_format_args
> > >    = note: `#[warn(clippy::uninlined_format_args)]` on by default
> > > help: change this to
> > >    |
> > > 20 -             debug!("git sha {} could not be validated, attempting a second way...", git_sha);
> > > 20 +             debug!("git sha {git_sha} could not be validated, attempting a second way...");
> > > 
> > > As you see, it proposes a fix at the bottom. Should I attribute "cargo
> > > clippy" in my commit message as it wrote some code?
> > > 
> > > Would your answer change if I run "cargo clippy --fix" which would
> > > automatically apply the fix on it's own?
> > > 
> > > We'll be hitting these issues all over the place if we try and draw a
> > > line... For example, with more advances autocompletion: where would you
> > > draw the line between completing variable names and writing an entire
> > > function based on a comment I've made?
> > 
> > Fuzzy isn't it!
> > 
> > There's at least 3 levels as I see it:
> >  1) Reported-by:
> >    That's a lot of tools, that generate an error or warning.
> >  2) Suggested-by:
> >    That covers your example above (hmm including --fix ????)
> >  3) Co-authored-by:
> >    Where a tool wrote code based on your more abstract instructions
> > 
> > (1) & (2) are taking some existing code and finding errors or light
> > improvements;  I don't think it matters whether the tool is a good
> > old chunk of C or an LLM that's doing it, but how much it's originating.
> 
> So let's say I'm using github copilot, and I go:
> 
> 	/* Iterate over pointers in KEY_TYPE_extent: */
> 	#define extent_ptr_next(_e, _ptr) <tab> <tab>
> 
> and copilot completes the code with "__bkey_ptr_next(_ptr, extent_entry_last(_e))".
> 
> Was my instruction abstract? Was it within the realm of something we
> consider a trivial change, or should we attribute the agent? :)

Heck, I don't know either!   I mean there are places & projects that ban even
that level of use, but I'd agree that the 'more abstract' doesn't fit there.

> Why tackle any of this to begin with?

It seemed to me appropriate to identify use of AI which some might
object to, or which wouldn't be allowed in their project, or which
might indicate the need to look for different type of errors than
humans normally make.  At the same time it seemed appropriate to
acknowledge things that worked.

Dave

> -- 
> Thanks,
> Sasha
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

