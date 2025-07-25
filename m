Return-Path: <linux-kernel+bounces-745734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B52BEB11D9F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333135A56AF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE692E6112;
	Fri, 25 Jul 2025 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="kz6QuSW9"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F562E62A4;
	Fri, 25 Jul 2025 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442970; cv=none; b=oyOdVINspXPuPy8MsFa5NM/4wp6KUNXGL/WUP/QhtE5sEudK2rQGoJyiEPe4sWiGnJXYWVDrFAAk2G+dWCVL7QrP0nz/s66deZH/aSXbRjt4iOaN9ARPWurhpfniZFzKNa6t5HxyXauv1NCnZO9ibKBPuiDt1SFEOT4gpsV6TzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442970; c=relaxed/simple;
	bh=XsvFg+p1govI8EGlJSNomJM5E16g0UqO9BOn7JiuKXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htJJG0YhJYbycWlu1ErG2fXZcHzffXKT/xyvhosi2iCQNk+5idhD5bnU67MUDsKkigzG9T+WkUq1DyZ41NbRUCmt3xSBIZTKbY+f+d/3ixC6urB2PPiTqjbh0sVkiTrSfUkPD40GLX41p0U0sMsHqr/Ycs+OMfhT9WNQxTGRJzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=kz6QuSW9; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=xT5SwSHBPnUnzFBFRHBE405vwzAuExHfJuonebrRTcw=; b=kz6QuSW9/iL3m+Hk
	Refcbz21mhlmpQQxYoILIzd6VWem6Mpn4eU5j9C9X4wRDXlMdwQ3TIrfayCIqXzojMqbc1ioovBY0
	o6Gl4Ms4liz/zQh6GAM5PQ4p6J3SOwULPEkJt7UMdRMmezRfrouMMXv5taUrkUcxRVHjirY3ej+9F
	RV5tbMuCtZZb3e5d1hXKWzvi9nT0TnJy7Ax9gmuvTsXuqYzYX/xhPaZBLBFnV3T63BJ9aZsPVb3GR
	MRlC2mDQtUqeSHPZOlzDOjv4AqL/jeHI04ytWD1Rph2aSqj5Xc0n1f83cLGdAYJbO1T3Fpn00RWe+
	W0y+Xhb6Yt7Mpb4E0Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1ufGc1-000bNz-2x;
	Fri, 25 Jul 2025 11:29:17 +0000
Date: Fri, 25 Jul 2025 11:29:17 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	corbet@lwn.net, workflows@vger.kernel.org, josh@joshtriplett.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs: submitting-patches: (AI?) Tool disclosure tag
Message-ID: <aINqjTAwbQ_xnAw6@gallifrey>
References: <20250724175439.76962-1-linux@treblig.org>
 <20250724-alluring-fuzzy-tanuki-6e8282@lemur>
 <202507241337.F9595E1D@keescook>
 <aIKhvubVqgeXIlrj@gallifrey>
 <202507241418.34AFD28C@keescook>
 <20250724194556.105803db@gandalf.local.home>
 <202507241651.5E9C803C70@keescook>
 <aILYj62tF_1mDjDO@lappy>
 <aILb-zDiDr4b9u9S@gallifrey>
 <aILjTKk_v8NPxlVJ@lappy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aILjTKk_v8NPxlVJ@lappy>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 11:22:25 up 88 days, 19:35,  1 user,  load average: 0.00, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Sasha Levin (sashal@kernel.org) wrote:
> On Fri, Jul 25, 2025 at 01:20:59AM +0000, Dr. David Alan Gilbert wrote:
> > * Sasha Levin (sashal@kernel.org) wrote:
> > > On Thu, Jul 24, 2025 at 04:54:11PM -0700, Kees Cook wrote:
> > > > On Thu, Jul 24, 2025 at 07:45:56PM -0400, Steven Rostedt wrote:
> > > > > My thought is to treat AI as another developer. If a developer helps you
> > > > > like the AI is helping you, would you give that developer credit for that
> > > > > work? If so, then you should also give credit to the tooling that's helping
> > > > > you.
> > > > >
> > > > > I suggested adding a new tag to note any tool that has done non-trivial
> > > > > work to produce the patch where you give it credit if it has helped you as
> > > > > much as another developer that you would give credit to.
> > > >
> > > > We've got tags to choose from already in that case:
> > > >
> > > > Suggested-by: LLM
> > > >
> > > > or
> > > >
> > > > Co-developed-by: LLM <not@human.with.legal.standing>
> > > > Signed-off-by: LLM <not@human.with.legal.standing>
> > > >
> > > > The latter seems ... not good, as it implies DCO SoB from a thing that
> > > > can't and hasn't acknowledged the DCO.
> > > 
> > > In my mind, "any tool" would also be something like gcc giving you a
> > > "non-trivial" error (think something like a buffer overflow warning that
> > > could have been a security issue).
> > > 
> > > In that case, should we encode the entire toolchain used for developing
> > > a patch?
> > > 
> > > Maybe...
> > > 
> > > Some sort of semi-standardized shorthand notation of the tooling used to
> > > develop a patch could be interesting not just for plain disclosure, but
> > > also to be able to trace back issues with patches ("oh! the author
> > > didn't see a warning because they use gcc 13 while the warning was added
> > > in gcc 14!").
> > > 
> > > Signed-off-by: John Doe <jd@example.com> # gcc:14.1;ccache:1.2;sparse:4.7;claude-code:0.5
> > > 
> > > This way some of it could be automated via git hooks and we can recommend
> > > a relevant string to add with checkpatch.
> > 
> > For me there are two separate things:
> >  a) A tool that found a problem
> >  b) A tool that wrote a piece of code.
> > 
> > I think the cases you're referring to are all (a), where as I'm mostly
> > thinking here about (b).
> > In the case of (a) it's normally _one_ of those tools that found it,
> > e.g. I see some:
> >   Found by gcc -fanalyzer
> 
> I think that the line between (a) and (b) gets very blurry very fast, so
> I'd rather stay out of trying to define it.
> 
> Running "cargo clippy" on some code might generate a warning as follows:
> 
> warning: variables can be used directly in the `format!` string
>   --> dyad/src/kernel/sha_processing.rs:20:13
>    |
> 20 |             debug!("git sha {} could not be validated, attempting a second way...", git_sha);
>    |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    |
>    = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#uninlined_format_args
>    = note: `#[warn(clippy::uninlined_format_args)]` on by default
> help: change this to
>    |
> 20 -             debug!("git sha {} could not be validated, attempting a second way...", git_sha);
> 20 +             debug!("git sha {git_sha} could not be validated, attempting a second way...");
> 
> As you see, it proposes a fix at the bottom. Should I attribute "cargo
> clippy" in my commit message as it wrote some code?
> 
> Would your answer change if I run "cargo clippy --fix" which would
> automatically apply the fix on it's own?
> 
> We'll be hitting these issues all over the place if we try and draw a
> line... For example, with more advances autocompletion: where would you
> draw the line between completing variable names and writing an entire
> function based on a comment I've made?

Fuzzy isn't it!

There's at least 3 levels as I see it:
  1) Reported-by:
    That's a lot of tools, that generate an error or warning.
  2) Suggested-by:
    That covers your example above (hmm including --fix ????)
  3) Co-authored-by:
    Where a tool wrote code based on your more abstract instructions

(1) & (2) are taking some existing code and finding errors or light
improvements;  I don't think it matters whether the tool is a good
old chunk of C or an LLM that's doing it, but how much it's originating.

(Now I'm leaning more towards Kees's style of using existing tags
if we could define a way to do it cleanly).

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

