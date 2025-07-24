Return-Path: <linux-kernel+bounces-744949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBB1B112E1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E185A2971
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387881494C3;
	Thu, 24 Jul 2025 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="iuaYitFV"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5411F4CAC;
	Thu, 24 Jul 2025 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753391558; cv=none; b=VosO5f2RblnunxE1E8au0i+6plWh0U8NpZ01cHcW68ZFwLkoYgX2XEYNj0QrWCmvceK1jwy7IYB17arDsSFqeoNCXnc4X3eFitM8CpwxAhb1VcRtb/1t0++7N8ewLfeVEsyq496Yqr204RnXOH/xetKFfuO4ausVq/JJK5pMxYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753391558; c=relaxed/simple;
	bh=RAsT+EipAPFwnVzfEL+LJX93TjioLFvlmfyGC6AfhEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElRQ1M2a6UmB54vyQPWxg+7GvjknQqjIOlsekjom0yBIyCrmwzjPk2973Aop/OYyQzK5nLb008HPFFMOE9epyXKzijRu8rYFIMkDUkzgdg2GnJYtku6KLado0s8fCzvuzj1wavOg8ihEOlDU5hO6N6rkTtUzMlm2Tc0YAaQIFMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=iuaYitFV; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=q4MIXRYdHVTBldEpo8YFmzXRjyv4svAN8Y2p5eLBULU=; b=iuaYitFVdECidE7n
	1QIZ0WCtVB9ofN+Bc1JdFqzd1vaHK2egE65ck8zFs7wkAN7oeXRH2VU3ymrZnpqNFs0r+vdF5bW4r
	egGtzrkQEHbQ9Q8JlalFO4Cs6xQbVJksxAVEIQmA96GH5No2XQqjYb7kLQhYdrmj9Y3lf3RvNQHJC
	AThGx5odWsgpc/p4PUdb8fEqoG7ff4tUbS+hB2M/ioVa0oB6km1gJyBJHTxg4PhrLDp4uXuajpPWT
	R4rhcii4uWk0SbzvrchhXrjqClQDWQsOojQszBAxLD+tQmvTVCLc+q8zpVaM5vgQo+Lk3hkS5XvUk
	c2iIKgEBsgF7JNOd9A==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1uf3Es-000Ujl-2p;
	Thu, 24 Jul 2025 21:12:30 +0000
Date: Thu, 24 Jul 2025 21:12:30 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Kees Cook <kees@kernel.org>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, corbet@lwn.net,
	workflows@vger.kernel.org, josh@joshtriplett.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs: submitting-patches: (AI?) Tool disclosure tag
Message-ID: <aIKhvubVqgeXIlrj@gallifrey>
References: <20250724175439.76962-1-linux@treblig.org>
 <20250724-alluring-fuzzy-tanuki-6e8282@lemur>
 <202507241337.F9595E1D@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <202507241337.F9595E1D@keescook>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 20:58:09 up 88 days,  5:11,  1 user,  load average: 0.01, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Kees Cook (kees@kernel.org) wrote:
> On Thu, Jul 24, 2025 at 03:07:17PM -0400, Konstantin Ryabitsev wrote:
> > On Thu, Jul 24, 2025 at 06:54:39PM +0100, linux@treblig.org wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > It seems right to require that code which is automatically
> > > generated is disclosed in the commit message.
> > 
> > I'm not sure that's the case. There is a lot of automatically generated
> > content being added to the kernel all the time -- such as auto-formatted code,
> > documentation, and unit tests generated by non-AI tooling. We've not required
> > indicating this usage before, so I'm not sure it makes sense to start doing it
> > now.
> > 
> > Furthermore, merely indicating the tool doesn't really say anything about how
> > it was used (e.g. what version, what prompt, what context, etc.) If anything,
> > this information needs to live in the cover letter of the submission. I would
> > suggest we investigate encouraging contributors to disclose this there, e.g.:
> > 
> > | ---
> > | This patch series was partially generated with "InsensitiveClod o4 Hokus"
> > | and then heavily modified to remove the parts where it went completely off
> > | the deep end.
> > 
> > I am also not opposed to having a more standard cover letter footer that would
> > allow an easier way to query this information via public-inbox services, e.g.:
> > 
> > | generated-by: insensitive clod o4 hokus
> > 
> > However, I don't really think this belongs in the commit trailers.
> 
> I agree; I'm not sure I see a benefit in creating a regularized trailer
> for this. What automation/tracking is going to key off of it? It's
> a detail of patch creation methodology,

My logic here is something like:
   a) Some people worry about various issues on AI such as copyright;
so it feels like it should be trackable.
   b) The teams that develop tools that work well deserve credit, so
formalising it seems to make that easier to see; be they AI etc.
   c) There's a general worry about people sending patches without
acknowledging their use of AI, and then not (carefully) checking
the output.  Calling out the need to record it might help get
people to at least acknowledge it.
   d) (a) and (c) are really only about AI, but our previous chat
was wondering if all tools needed it, but calling out anything where
it's code generation seemed to be a reasonable line to me.
   e) If one tool tended to be particularly bad at missing one type
of check, with a tag you could track down what we have from it.
   f) Related to (a), some large open source projects are explicitly
disallowing AI generated contributions; life will get messy for them
if people import kernel code with a compatible license that was
generated by AI.

(I didn't really want to get into the question of whether the use of
AI was good or bad; but people worrying about it isn't unreasonable)

> so the commentary about how
> something was created is best put in the prose areas, like we already
> do for Coccinelle or other scripts. It's a bit buried in the Researcher
> Guidelines[1], but we have explicitly asked for details about tooling:
> 
>   When sending patches produced from research, the commit logs should
>   contain at least the following details, so that developers have
>   appropriate context for understanding the contribution.
>   ...
>   Specifically include details about any testing, static or dynamic
>   analysis programs, and any other tools or methods used to perform the
>   work.
> 
> Maybe that needs to be repeated in SubmittingPatches?

'produced from research' is narrowing things down a bit too much I think
when it's people using the tools as their normal way of working.

Dave

> -Kees
> 
> [1] https://docs.kernel.org/process/researcher-guidelines.html
> 
> -- 
> Kees Cook
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

