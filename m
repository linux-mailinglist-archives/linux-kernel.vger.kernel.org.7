Return-Path: <linux-kernel+bounces-745151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47270B115B5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 03:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86676582998
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6807D1C9DE5;
	Fri, 25 Jul 2025 01:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Neh1Lw+Q"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD1327472;
	Fri, 25 Jul 2025 01:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753406467; cv=none; b=bx/wkKlMzqDPXv9alSXFUnD/mq7Vf+8fJPnmIxN8MNcXisM4idJ4aa0nkFKdetn3Yg5pWvLIrLDroPC6CdhdJuoPooMvZY94adwiXeZThQO3PG8G8kYyU72hE/kgm7+r1+J78J2Ve2ZOeCQWqTykdan0LqSVKikL91ggbvdmg2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753406467; c=relaxed/simple;
	bh=PNQnT0E50xou3ylyJ/Sy59bI117wqWxuviW0jil5ED0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiyCew4bauZp+/yhWZibQOaxnSKzFzjHkkWUGvsO5cJIKPHBUzpKAj9PusJIoGoolDfo/62i9gDppwkY/sLBIbRaFfDOvnAlJif6cwGKbXw6gxNimv2xc3TIhrWKoIEAmjb8vHEH0kNYEBtUG5SQg+kqCfADKcIXHfUvlgwL/nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Neh1Lw+Q; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=UNpaFk2/ktvgyD2Yygkf+981tz3aEAu/xR3Kivia+98=; b=Neh1Lw+QcHk9JTtQ
	7TwiA6V8z5o2Kpl3kAPbUoQv/fePDknI5d1E3TM3nSA0fofuHLCNSOOw252s4kFCN1oiX+XjrCxAe
	bFctWdljt6+70Pg4OGuxP1N1nf1NEhViJhT1ZC/IL6X/XNxPtm3BckANzAAeh7Rt120n5WnkgJxHe
	L8spk4J4JWop01oA1X6AGAV+6XJYb7GDv6hsafiL+YH6X+svJ6l5GChf8SrDmSeqcQEvPS1LuGjvx
	HIS0Jj3ztFkXqwjbMwqbIi7aKJooANLBamOdi43xle3AINOe9rMvfzybrkCxD6P7SnsUvXiX2rYgD
	e4LcV6lNKZgqXLRsLA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1uf77L-000Whh-0n;
	Fri, 25 Jul 2025 01:20:59 +0000
Date: Fri, 25 Jul 2025 01:20:59 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	corbet@lwn.net, workflows@vger.kernel.org, josh@joshtriplett.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs: submitting-patches: (AI?) Tool disclosure tag
Message-ID: <aILb-zDiDr4b9u9S@gallifrey>
References: <20250724175439.76962-1-linux@treblig.org>
 <20250724-alluring-fuzzy-tanuki-6e8282@lemur>
 <202507241337.F9595E1D@keescook>
 <aIKhvubVqgeXIlrj@gallifrey>
 <202507241418.34AFD28C@keescook>
 <20250724194556.105803db@gandalf.local.home>
 <202507241651.5E9C803C70@keescook>
 <aILYj62tF_1mDjDO@lappy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aILYj62tF_1mDjDO@lappy>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 01:15:23 up 88 days,  9:28,  1 user,  load average: 0.03, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Sasha Levin (sashal@kernel.org) wrote:
> On Thu, Jul 24, 2025 at 04:54:11PM -0700, Kees Cook wrote:
> > On Thu, Jul 24, 2025 at 07:45:56PM -0400, Steven Rostedt wrote:
> > > My thought is to treat AI as another developer. If a developer helps you
> > > like the AI is helping you, would you give that developer credit for that
> > > work? If so, then you should also give credit to the tooling that's helping
> > > you.
> > > 
> > > I suggested adding a new tag to note any tool that has done non-trivial
> > > work to produce the patch where you give it credit if it has helped you as
> > > much as another developer that you would give credit to.
> > 
> > We've got tags to choose from already in that case:
> > 
> > Suggested-by: LLM
> > 
> > or
> > 
> > Co-developed-by: LLM <not@human.with.legal.standing>
> > Signed-off-by: LLM <not@human.with.legal.standing>
> > 
> > The latter seems ... not good, as it implies DCO SoB from a thing that
> > can't and hasn't acknowledged the DCO.
> 
> In my mind, "any tool" would also be something like gcc giving you a
> "non-trivial" error (think something like a buffer overflow warning that
> could have been a security issue).
> 
> In that case, should we encode the entire toolchain used for developing
> a patch?
> 
> Maybe...
> 
> Some sort of semi-standardized shorthand notation of the tooling used to
> develop a patch could be interesting not just for plain disclosure, but
> also to be able to trace back issues with patches ("oh! the author
> didn't see a warning because they use gcc 13 while the warning was added
> in gcc 14!").
> 
> Signed-off-by: John Doe <jd@example.com> # gcc:14.1;ccache:1.2;sparse:4.7;claude-code:0.5
> 
> This way some of it could be automated via git hooks and we can recommend
> a relevant string to add with checkpatch.

For me there are two separate things:
  a) A tool that found a problem
  b) A tool that wrote a piece of code.

I think the cases you're referring to are all (a), where as I'm mostly
thinking here about (b).
In the case of (a) it's normally _one_ of those tools that found it,
e.g. I see some:
   Found by gcc -fanalyzer

but we don't have a defined way to refer to them.
I also see a variety from coverity, e.g.
  Addresses-Coverity:  xxxxx
or the use of Link: to refer to a coverity failure
or
  Addresses-Coverity-ID: xxxx ("Description of it")

or a few others.
It would be great to standardise some of that as well.

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

