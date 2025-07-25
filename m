Return-Path: <linux-kernel+bounces-746327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA573B12594
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1410E3B9272
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86AB25A348;
	Fri, 25 Jul 2025 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="rzwomizJ"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA51239E60;
	Fri, 25 Jul 2025 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475568; cv=none; b=u+GGyt7OuhYxksqEFASE1/8OjBzH8XHGq+rDu1A6VoSTyFXFjn5LESNY/sDkbzah5JINyyyD/BjLahaIipZ89hW5hAW8+3yoBliPxSo7Wn2FTjD8S/uSYdQzo0DRjsN0rx01wCDLh+CZ2twOaozISlNk3p9DBhaoqDlFfYg3qlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475568; c=relaxed/simple;
	bh=7aJC6uaWLGEw1lnbfhHpk8IA2Tli6jwxMfjrL4em60Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpBqeEol/bGIOul4cg1RqY4ykdnkiAouvaJMp15tyKz3vVoAd/R/IIupdcWapN5e7Rhuuk6YZHDimCql/2lTn5SLrrRP3Wu2zVMnV9fvORwOO0LVrtmxwbCAFxGmqpnOI5LLQSvKSscJTl3qhifLExvAlE/tdEXA+AEaMhhJ8s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=rzwomizJ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=hRwiYsJBZAA+T2dCXWEfTMbwkhCHo5/rLbx54F03w7Y=; b=rzwomizJNlEXyOVd
	+qFw49Ij7AcMZlaIVveJmSUbR18deas0t9dyFhr9wX+Qzgpd3j6fsP2WEgkArHioC2QRBHUpyNBlr
	4033Vy1O0qpwVVsXHw1mgD7vSmpuXcWU8Ul0YKV2ZPyoRfX6327dwhNvXRye984aESBJGQxnrMoPJ
	Xq4ZtRpXwcYmthnjFPw/iYyvcl0PPbm5UORvmk560RPnsj7s6Yj4NHQJmvt62fd/EAirRV5Uo1bkn
	ODTKHkt0kw4QOV31n4UX4SEKUCIrP1qhzCDLoLrj+x3CdOPofAwF3ddq+1DB96JCSOxyp/Zl+gUan
	C4O6lWbRantKRL5dJw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1ufP5l-000gsa-2h;
	Fri, 25 Jul 2025 20:32:33 +0000
Date: Fri, 25 Jul 2025 20:32:33 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sasha Levin <sashal@kernel.org>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kees@kernel.org,
	konstantin@linuxfoundation.org, corbet@lwn.net,
	josh@joshtriplett.org
Subject: Re: [RFC 0/2] Add AI coding assistant configuration to Linux kernel
Message-ID: <aIPp4R7Xd_10J2uH@gallifrey>
References: <20250725175358.1989323-1-sashal@kernel.org>
 <20250725114114.3b13e7b1@kernel.org>
 <20250725150046.3adb556c@gandalf.local.home>
 <20250725125906.1db40a7f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250725125906.1db40a7f@kernel.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 20:26:01 up 89 days,  4:39,  1 user,  load average: 0.02, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Jakub Kicinski (kuba@kernel.org) wrote:
> On Fri, 25 Jul 2025 15:00:46 -0400 Steven Rostedt wrote:
> > On Fri, 25 Jul 2025 11:41:14 -0700
> > Jakub Kicinski <kuba@kernel.org> wrote:
> > > On Fri, 25 Jul 2025 13:53:56 -0400 Sasha Levin wrote:  
> > > > 	Co-developed-by: Claude claude-opus-4-20250514
> > > > 	---
> > > > 	 Documentation/power/opp.rst | 2 +-
> > > > 	 1 file changed, 1 insertion(+), 1 deletion(-)    
> > > 
> > > I think we should suggest that the tag is under --- ?
> > > It's only relevant during the review. Once the patch is committed 
> > > whether the code was organic or generated by Corp XYZ's Banana AI
> > > is just free advertising..  
> > 
> > What's the difference between that and others using their corporate email?
> > I even add (Google) to my SoB to denote who is paying me to do the work.
> 
> To be clear, it's not my main point, my main point is that 
> the information is of no proven use right now. As long as
> committer follows the BKP of adding Link: https://patch.msgid.link/...
> we can find the metadata later.
> 
> We never found the need to attach the exact version of smatch / sparse
> / cocci that found the bug or "wrote" a patch. Let us not overreact to
> the AI tools.

People have done it (using inconsistent tags and comments) for things
like Coverity for years;  some people worry a lot about AI, some not at all;
adding a tag:
  a) Lets the people who worry keep of track what our mechanical overlords are
doing.
  b) Reviewers who are wary of slop get to cast a careful eye.
  c) Gives the tools (and their developers) suitable credit.  After all machines
need love too.

> > Also, I would argue that it would be useful in the change log as if there's
> > a bug in the generated code, you know who or *what* to blame. Especially if
> > there is a pattern to be found.
> 
> This touches on explainability of AI. Perhaps the metadata would be
> interesting for XAI research... not sure that's enough to be lugging
> those tags in git history.

We carry lots more random stuff in commit messages!

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

