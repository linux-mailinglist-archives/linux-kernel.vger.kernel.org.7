Return-Path: <linux-kernel+bounces-751251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EA3B166E7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 673F87AC3DB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219252E1C78;
	Wed, 30 Jul 2025 19:27:09 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD941624EA;
	Wed, 30 Jul 2025 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903628; cv=none; b=iclQbtAGPSU3Sr1xRRjUs9Sn/5R/0zFxwTuu/NjifcVw3uw5f0WywT0ag5B1LRAh4+3G7q6T+xFbmkA/JjpvwUGKXyJPahrO0mi1wueQz/ai8YO/HkAMD9YNmCqEZPAPiCW4E5ySbdE0n6hf8+4AEENXkEBgZOmkZm/xnRBGvM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903628; c=relaxed/simple;
	bh=BInQqAuFuhv6ShllU1BMRFpqWjLupYaHWHnVG6WDYJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PqZzi3MwH9lHtWLNP5sQS3GBFkMNEj4mGWIDBuv3hnc/w/JR8yBDbxhBnCKwPWGxeOWlhBFcf2vn8z1tLoZPW0Nt0hmPyYzWAA1K2pATf4MCzhy4rKJ96jNarrB9Jjyv91K9p4kPAWV+zSq338WCb+QfKOS1g12vltHJrFjZI3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 52A0F56064;
	Wed, 30 Jul 2025 19:27:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 0008D2F;
	Wed, 30 Jul 2025 19:27:01 +0000 (UTC)
Date: Wed, 30 Jul 2025 15:27:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Greg KH <greg@kroah.com>,
 corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
 josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
 linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, "Dr. David Alan Gilbert"
 <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <20250730152718.2f12b927@gandalf.local.home>
In-Reply-To: <aIpah6DTRd99mMqb@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
	<7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
	<2025072854-earthen-velcro-8b32@gregkh>
	<df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
	<20250730112753.17f5af13@gandalf.local.home>
	<158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
	<20250730121829.0c89228d@gandalf.local.home>
	<aIpKCXrc-k2Dx43x@lappy>
	<20250730130531.4855a38b@gandalf.local.home>
	<aIpah6DTRd99mMqb@lappy>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: k1smr8y1wqmgzhjda147db5kejzepe75
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 0008D2F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18TekhUR2waaUF2I5r3QQ0y1GVRV1RYguU=
X-HE-Tag: 1753903621-547155
X-HE-Meta: U2FsdGVkX18v5lCV3uzaXGX+DgCCN6qk0Bs2jpUbn85hhBs/mdlHulN/ESdIGHvF5JIPQOmzShCkNxrrw4msiexwIH2UySSOxq+6sGGChW4DzwTwLOBH+MzCRmwUO2ikEbPdZA1nX/PQZUtMOvIZk2pacjIDI5DkDbBd86DwZTu7uKkqbYK89zHhdymFe59i2FBKhtL4X+VpJ5Gmwq7d8IyIXfYd/zRE2v7IHRsW5KupK6Z6MGLeMvKlxCLlE6PYbfmn/j6/xKDtED4iZfzTLQt48LyirFVyob8BtfbrtOBq5IFPKAOHfgdAMK5plCCWhB7r3enfVZ2DPxK6RVuxDA3zLCLuQ4lqiP1c+9bzFisSVFNed2cReqxcwoFCEElf

On Wed, 30 Jul 2025 13:46:47 -0400
Sasha Levin <sashal@kernel.org> wrote:

> >My point here is that AI can now add questions that maintainers can't
> >answer. Is it really legal? Can the maintainer trust it? Yes, these too can
> >fall under the "technical reasons" but having a clear policy that states
> >that a maintainer may not want to even bother with AI generated code can
> >perhaps give the maintainer something to point to if push comes to shove.  
> 
> I don't think that those are technical aspects.

I didn't either, but I was just saying one could possibly argue that they
are. But that also states why it should be called out explicitly. As
refusing AI patches may not be a technical issue where all other refusals
should be.


> >I wouldn't think so. This is about submitting patches and a statement there
> >may be easier found by those about to submit an AI patch. Just because they
> >are using AI doesn't mean they'll think it's an academic research.  
> 
> Not in the sense that AI is research, but more that this is code coming
> from someone who is unable to reliably verify the patch that is being
> sent in.

The issue I have is that the person sending in the patch may not know that
they don't understand the patch. We've had those in the past. I could
imagine AI creating more of these kinds of submissions.

> 
> The source can be academic research, AI, or whatever else comes along.
> 
> It'll just be nice to have a unified set of rules around it. Otherwise
> the amount of combinations will explode (in which category do we put in
> academic researchers sending in AI generated code?).

Research folks know they are doing research. Those using AI may likely will
not, even if they are. Hence why I would like this outside of the academic
research document.

> 
> >> Some sort of a "traffic light" system:
> >>
> >>   1. Green: the subsystem is happy to receive patches from any source.
> >>
> >>   2. Yellow: "If you're unfamiliar with the subsystem and using any
> >>   tooling to generate your patches, please have a reviewed-by from a
> >>   trusted developer before sending your patch".
> >>
> >>   3. No tool-generated patches without prior maintainer approval.  
> >
> >Perhaps. Of course there's the Coccinelle scripts that fix a bunch of code
> >around the kernel that will like be ignored in this. But this may still be
> >a good start.  
> 
> It'll be hard to draw a line here, so I suggest we don't try.

Agreed. But perhaps we could have a note that some subsystems expect all
submissions done by a human. Although treewide patches that change
interfaces that are fixed up by coccinelle may not have a choice.

> 
> Are AI generated .cocci semantic patches that are then transformed into
> C patches and sent in by a human ok?
> 

Up to the maintainer.

-- Steve


