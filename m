Return-Path: <linux-kernel+bounces-745740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA079B11DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2615D3B67E9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44D72E5B18;
	Fri, 25 Jul 2025 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="T8QE7V7P"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE9F230BD9;
	Fri, 25 Jul 2025 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753443430; cv=none; b=lpMBhBfi9Wlh8UOZbnElLt56a/PXqwebQocCk1riUDAUVORSa6bn1+zjNzm1paszc8XqUl3ve55G0e5VQ8FW7B+i1dExKb92YjsUiEuE3ZQm6v903VIINIj4jJYWq2Ghmz9seUSEL1r+Ps+BRErzHJ9mZlNOIlDgCCrH9zmFqeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753443430; c=relaxed/simple;
	bh=pPxpMCrAPG85F8fQoO31oOdpGDPi60o9D/2MxwrcJ0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzdjKxsDzsyF3KrwKBaG3baBs0mPAnVNOfAEwN20iYNW8tCJYpXcFlMacvI+4RKUq5ZVGBeCOlOp+kQpnQ3MiM/yZHB+fEhShw2+1QtXHrp416ypmof0gs5dVHxY76vLCrPHnNXyTBNPuq4FY2PbuAzyqRj7Z+ETvqfa3jN31X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=T8QE7V7P; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id DF59BC66;
	Fri, 25 Jul 2025 13:36:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1753443387;
	bh=pPxpMCrAPG85F8fQoO31oOdpGDPi60o9D/2MxwrcJ0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T8QE7V7PQFQOFIat3LpsskLjpc2sNcoy3cpEQ+EIxheNSBZHpw5dft0QyGuLd4Zd9
	 7eb/XZWu3Au5YT2mRQnrwOUIzUGUpiJ80WTJexR1koZ5cWQKJBsT+EOpLcOTqirIPU
	 x+40MEXx4eB3HNbeuICc6SRVy175LcpJVqbS6O9s=
Date: Fri, 25 Jul 2025 14:37:02 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Sasha Levin <sashal@kernel.org>, Kees Cook <kees@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	corbet@lwn.net, workflows@vger.kernel.org, josh@joshtriplett.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs: submitting-patches: (AI?) Tool disclosure tag
Message-ID: <20250725113702.GD11202@pendragon.ideasonboard.com>
References: <20250724-alluring-fuzzy-tanuki-6e8282@lemur>
 <202507241337.F9595E1D@keescook>
 <aIKhvubVqgeXIlrj@gallifrey>
 <202507241418.34AFD28C@keescook>
 <20250724194556.105803db@gandalf.local.home>
 <202507241651.5E9C803C70@keescook>
 <aILYj62tF_1mDjDO@lappy>
 <aILb-zDiDr4b9u9S@gallifrey>
 <aILjTKk_v8NPxlVJ@lappy>
 <aINqjTAwbQ_xnAw6@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aINqjTAwbQ_xnAw6@gallifrey>

On Fri, Jul 25, 2025 at 11:29:17AM +0000, Dr. David Alan Gilbert wrote:
> * Sasha Levin (sashal@kernel.org) wrote:
> > On Fri, Jul 25, 2025 at 01:20:59AM +0000, Dr. David Alan Gilbert wrote:
> > > * Sasha Levin (sashal@kernel.org) wrote:
> > > > On Thu, Jul 24, 2025 at 04:54:11PM -0700, Kees Cook wrote:
> > > > > On Thu, Jul 24, 2025 at 07:45:56PM -0400, Steven Rostedt wrote:
> > > > > > My thought is to treat AI as another developer. If a developer helps you
> > > > > > like the AI is helping you, would you give that developer credit for that
> > > > > > work? If so, then you should also give credit to the tooling that's helping
> > > > > > you.
> > > > > >
> > > > > > I suggested adding a new tag to note any tool that has done non-trivial
> > > > > > work to produce the patch where you give it credit if it has helped you as
> > > > > > much as another developer that you would give credit to.
> > > > >
> > > > > We've got tags to choose from already in that case:
> > > > >
> > > > > Suggested-by: LLM
> > > > >
> > > > > or
> > > > >
> > > > > Co-developed-by: LLM <not@human.with.legal.standing>
> > > > > Signed-off-by: LLM <not@human.with.legal.standing>
> > > > >
> > > > > The latter seems ... not good, as it implies DCO SoB from a thing that
> > > > > can't and hasn't acknowledged the DCO.
> > > > 
> > > > In my mind, "any tool" would also be something like gcc giving you a
> > > > "non-trivial" error (think something like a buffer overflow warning that
> > > > could have been a security issue).
> > > > 
> > > > In that case, should we encode the entire toolchain used for developing
> > > > a patch?
> > > > 
> > > > Maybe...
> > > > 
> > > > Some sort of semi-standardized shorthand notation of the tooling used to
> > > > develop a patch could be interesting not just for plain disclosure, but
> > > > also to be able to trace back issues with patches ("oh! the author
> > > > didn't see a warning because they use gcc 13 while the warning was added
> > > > in gcc 14!").
> > > > 
> > > > Signed-off-by: John Doe <jd@example.com> # gcc:14.1;ccache:1.2;sparse:4.7;claude-code:0.5
> > > > 
> > > > This way some of it could be automated via git hooks and we can recommend
> > > > a relevant string to add with checkpatch.
> > > 
> > > For me there are two separate things:
> > >  a) A tool that found a problem
> > >  b) A tool that wrote a piece of code.
> > > 
> > > I think the cases you're referring to are all (a), where as I'm mostly
> > > thinking here about (b).
> > > In the case of (a) it's normally _one_ of those tools that found it,
> > > e.g. I see some:
> > >   Found by gcc -fanalyzer
> > 
> > I think that the line between (a) and (b) gets very blurry very fast, so
> > I'd rather stay out of trying to define it.
> > 
> > Running "cargo clippy" on some code might generate a warning as follows:
> > 
> > warning: variables can be used directly in the `format!` string
> >   --> dyad/src/kernel/sha_processing.rs:20:13
> >    |
> > 20 |             debug!("git sha {} could not be validated, attempting a second way...", git_sha);
> >    |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >    |
> >    = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#uninlined_format_args
> >    = note: `#[warn(clippy::uninlined_format_args)]` on by default
> > help: change this to
> >    |
> > 20 -             debug!("git sha {} could not be validated, attempting a second way...", git_sha);
> > 20 +             debug!("git sha {git_sha} could not be validated, attempting a second way...");
> > 
> > As you see, it proposes a fix at the bottom. Should I attribute "cargo
> > clippy" in my commit message as it wrote some code?
> > 
> > Would your answer change if I run "cargo clippy --fix" which would
> > automatically apply the fix on it's own?
> > 
> > We'll be hitting these issues all over the place if we try and draw a
> > line... For example, with more advances autocompletion: where would you
> > draw the line between completing variable names and writing an entire
> > function based on a comment I've made?
> 
> Fuzzy isn't it!
> 
> There's at least 3 levels as I see it:
>   1) Reported-by:
>     That's a lot of tools, that generate an error or warning.
>   2) Suggested-by:
>     That covers your example above (hmm including --fix ????)
>   3) Co-authored-by:
>     Where a tool wrote code based on your more abstract instructions
> 
> (1) & (2) are taking some existing code and finding errors or light
> improvements;  I don't think it matters whether the tool is a good
> old chunk of C or an LLM that's doing it, but how much it's originating.

Except from a copyright point of view. The situation is quite clear for
deterministic code generation, it's less so for LLMs.

> (Now I'm leaning more towards Kees's style of using existing tags
> if we could define a way to do it cleanly).

-- 
Regards,

Laurent Pinchart

