Return-Path: <linux-kernel+bounces-751058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC65B164CC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43052189082B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFA42DF3C6;
	Wed, 30 Jul 2025 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGpm6w9Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51D92DECD4;
	Wed, 30 Jul 2025 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753893231; cv=none; b=XuGod01lvRjjUrRq46exREzaC1l4GqIfDCYGeJFD+sNPuqFvGtIeicNIAhkfpKftlAHSDz/4G6s+RjnjMs8wt3tHMz0aupaWdg3FAznBysghPBiuGlfy1MrWod1mv0U7JdDN2bNBisil+J0i+MoldQT0pHLUP54Om07uJyFzFxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753893231; c=relaxed/simple;
	bh=2Z1q2Q3cKj2SU4XUe/21zdB7IBgP9YP5AJAJKrYNAg8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j09a0sMnDIDUuaYsSoUB+qluJ7jwLydSbQatODZsbhldz+AbzUtlJgusOobJpiNJAvIJZYlAIdgQLSz0TjECm9YJ82cWklWoi/SnWUCAGqJaX8ekFxRwnczJkDFapZv4cuW3QzsxP8r++NAoz0k2O+ddQ+xxBjnSYHI5afgvUDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGpm6w9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79102C4CEE7;
	Wed, 30 Jul 2025 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753893231;
	bh=2Z1q2Q3cKj2SU4XUe/21zdB7IBgP9YP5AJAJKrYNAg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WGpm6w9ZE8yPlBMH6mVsa3wfTJtVtiNujYiGpdgGuOX+RlH0UR+v0+GLyfsgYJgFM
	 /P16WDIb2XGcNNt6Vh/MoEwC/oo0JZM1ffl95DA+i8jU9X64O4gTVvY2FWOyQPRXlb
	 NH5k+2gxEyUzs1dELN4msM6b3AdeGiTO5vv7fb/ZVqfJ8lA5DYg+ay3+J/WEXGlGag
	 KbAdVn6Ib2Lbq0bJIp14+fcoT+HaoQd90eVHAmt553/SOEboVFBYIgsxc53IV96iSA
	 bpfD9S+pArck3wfRr1+H/Wh2cwuT9a/LzXPZgMnoBGfSB+o9aXUe64BzWUNudyP2Q4
	 EEDycF4g166aw==
Date: Wed, 30 Jul 2025 18:33:45 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Greg KH <greg@kroah.com>,
 Sasha Levin <sashal@kernel.org>, corbet@lwn.net, linux-doc@vger.kernel.org,
 workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org,
 konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org, Linus
 Torvalds <torvalds@linux-foundation.org>, "Dr. David Alan Gilbert"
 <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <20250730183337.6c60db4f@foz.lan>
In-Reply-To: <20250730121829.0c89228d@gandalf.local.home>
References: <20250727195802.2222764-1-sashal@kernel.org>
	<7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
	<2025072854-earthen-velcro-8b32@gregkh>
	<df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
	<20250730112753.17f5af13@gandalf.local.home>
	<158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
	<20250730121829.0c89228d@gandalf.local.home>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 30 Jul 2025 12:18:29 -0400
Steven Rostedt <rostedt@goodmis.org> escreveu:

> On Wed, 30 Jul 2025 16:34:28 +0100
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> 
> > > Which looked like someone else (now Cc'd on this thread) took it public,
> > > and I wanted to see where that ended. I didn't want to start another
> > > discussion when there's already two in progress.    
> > 
> > OK, but having a document like this is not in my view optional - we must
> > have a clear, stated policy and one which ideally makes plain that it's
> > opt-in and maintainers may choose not to take these patches.  
> 
> That sounds pretty much exactly as what I was stating in our meeting. That
> is, it is OK to submit a patch written with AI but you must disclose it. It
> is also the right of the Maintainer to refuse to take any patch that was
> written in AI. They may feel that they want someone who fully understands
> what that patch does, and AI can cloud the knowledge of that patch from the
> author.
> 
> I guess a statement in submitting-patches.rst would suffice, or should it
> be a separate standalone document?

As you pointed earlier on this thread, I think something like this is good
enough:
	https://lore.kernel.org/lkml/20250724175439.76962-1-linux@treblig.org/

E.g. just a couple of paragraphs at submitting-patches should work.
Now, if we end adding an AI-focused instruction set like what it
was proposed here:

	https://lore.kernel.org/lkml/20250725175358.1989323-1-sashal@kernel.org/

I would add a mention and change the text to ask the ones developing
patches with AI/LLM to ensure that AI accessed the ruleset when
possible(*).

(*) sometimes, AI may not have direct access to the internet and/or
    may be using old caches.

Thanks,
Mauro

