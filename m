Return-Path: <linux-kernel+bounces-745750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF789B11DE7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB4617B806A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397F12E6D17;
	Fri, 25 Jul 2025 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="C1fRJ6sf"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40684238C3A;
	Fri, 25 Jul 2025 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753444154; cv=none; b=V0G5Ag+vFHmD3wGgOoHl4tGNJpST/Y6BRR73NODas91ZrqucKiCUsYH5yCno6QGkuZATSuk6nJ6T2J18HkSHRje1og+jhRfutQzcKZ+Ejgz4tj4B3/n5vERYfyAyLkS9nZxpRelXLH2b05wUhP+xc+n9dPAU/w5lwIaYvVu/SO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753444154; c=relaxed/simple;
	bh=D2ivzNJuaDVX9C5eOi3hZ8Kr8x1lFAqdeFEb9V6jXtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWGojjQ7Q/esCltwXVW3XZbhaxYKJLG6FW5jF3tvi+flXHwxIvyz7OHUApP93XI+w8rANL2pNvt0qeoOYNul+JGcJ2Pb1bgqPzKhOmD25xOaCp8Cg2+7xnU/uk5Kmme/m3quP75QqM71A9BmRBOHNZ6Oj1D9ac1bO7y9RSOFSes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=C1fRJ6sf; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=k0dqcf75EGGfL16WYYDaJ5XQjo4w6DRgcCALzNEwqmA=; b=C1fRJ6sfMTLwadKH
	G2f1zfqX776s+ng43cehav+bn/Ahf7/TDy+X/6yUI9qDyo+tlfficejHX+Zry9RX4/jgTHuasBdya
	A1ALDi7d77B9cq6NZs8PcAzHOnNg8CLxcxBZCIwqw6QmK6tFkYZv+mbvHaC0D5mK16+KKcvrkR+Q8
	MQoHqNRuiuvVfN9WBP6GrN8QhAT8Wlh1qUjsO6wv1F+ItgzisoL6wicSclpKLYfo2JdJlnzx523L8
	FY7fzfNf+0yNk3dAGrrX827Epb7p7urWEERkQ5s2m+9aEXI1nsmi+uVNDNJxuUx1CXde68xI1VVIc
	JgpVThDzOStKvArTlA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1ufGv8-000baf-2h;
	Fri, 25 Jul 2025 11:49:02 +0000
Date: Fri, 25 Jul 2025 11:49:02 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sasha Levin <sashal@kernel.org>, Kees Cook <kees@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	corbet@lwn.net, workflows@vger.kernel.org, josh@joshtriplett.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs: submitting-patches: (AI?) Tool disclosure tag
Message-ID: <aINvLgwaKZsKOibE@gallifrey>
References: <202507241337.F9595E1D@keescook>
 <aIKhvubVqgeXIlrj@gallifrey>
 <202507241418.34AFD28C@keescook>
 <20250724194556.105803db@gandalf.local.home>
 <202507241651.5E9C803C70@keescook>
 <aILYj62tF_1mDjDO@lappy>
 <aILb-zDiDr4b9u9S@gallifrey>
 <aILjTKk_v8NPxlVJ@lappy>
 <aINqjTAwbQ_xnAw6@gallifrey>
 <20250725113702.GD11202@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250725113702.GD11202@pendragon.ideasonboard.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 11:42:35 up 88 days, 19:56,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Laurent Pinchart (laurent.pinchart@ideasonboard.com) wrote:
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
> >   1) Reported-by:
> >     That's a lot of tools, that generate an error or warning.
> >   2) Suggested-by:
> >     That covers your example above (hmm including --fix ????)
> >   3) Co-authored-by:
> >     Where a tool wrote code based on your more abstract instructions
> > 
> > (1) & (2) are taking some existing code and finding errors or light
> > improvements;  I don't think it matters whether the tool is a good
> > old chunk of C or an LLM that's doing it, but how much it's originating.
> 
> Except from a copyright point of view. The situation is quite clear for
> deterministic code generation, it's less so for LLMs.

As long as you'd acknowledged the use of the LLM in all cases, it seems to
me right to say to what degree you use it (i.e. the 1..3) above.
I think even most people worried about copright issues would worry
less if an LLM had just told you about a problem (1) and you fixed it.
(Although obviously IANAL)

Dave

> > (Now I'm leaning more towards Kees's style of using existing tags
> > if we could define a way to do it cleanly).
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

