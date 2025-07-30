Return-Path: <linux-kernel+bounces-751139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B476B165A5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4233B60D9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BDF2E0406;
	Wed, 30 Jul 2025 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="erHTgaTf"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291EF2DF3C6;
	Wed, 30 Jul 2025 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753897180; cv=none; b=E0iGdSOn+hyFjZSodfQTz9AUQxc1w78baqQq6KzDhvIihEFCGIWn1YJm71Wb40+ryPfOWyF/tVuD0DUD0uoqmJO7PPnFnR/lH88kfYlCxYub2A1fl2xtbXQUna7CIFLHo3L3kRROIKGqBwnEEKMuXTbx9hWWLJh1VtqZC6rkLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753897180; c=relaxed/simple;
	bh=1DIQWYdgNrTKrWCiH4lQQKCDIsa1btvh6AoXKu9PfDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDkt2qKRhxHm28py7JBhnBUqCPAQjVpum03GuJEBvZfK/UnBmv/quvwcl4I5g5Wpc6jS45zXl0xw707UFmH8QkzhSxHRqcsSpI+k7UnbC3GaqdX3X3Q4Za6MkRnsTxeXBjp1y87Eor9iFujAc9qtGUYwZm+esBWcTpnOZ2fPaBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=erHTgaTf; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=IegNGTuT6gUeSc6tpOd0FfCulkFToq3dnkN8l1qdSWg=; b=erHTgaTfWn7fHUp/
	j0U3fWl/RjUBmpJojrRHu2BzhI0TcQs1TpxVoP7XW5HDdgtJU+ls7iRNsJ/ImiwutlE7kgz0NISaa
	XCPGqQgyIkuojUJvvd0ssv/qXPEpxSBgvdZ5Tsy5N/zEMiSKtIABl3x4ss20IrRPigHmRXRxcjy6n
	TM0MjVHYPBR09yKLLIPHMdyUstulwdICCdgWDysdmkT97gtdWjz9Q8rruKRWCRUCodQslwA1nS3zR
	4/+41qyYRoGGFBfkY4lSHmBoGc9PjCxWnO9OocRG8LX5zOV5c03XiWbVYmPewJ7SUNF+FaEr8AKJq
	j3VBo37C7y3z3F6SRQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1uhAlz-001OOp-02;
	Wed, 30 Jul 2025 17:39:27 +0000
Date: Wed, 30 Jul 2025 17:39:26 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Greg KH <greg@kroah.com>,
	Sasha Levin <sashal@kernel.org>, corbet@lwn.net,
	linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <aIpYzg4cI6ELyvYV@gallifrey>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
 <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
 <20250730121829.0c89228d@gandalf.local.home>
 <aIpLB5oMc1tSq1SP@gallifrey>
 <20250730131253.48f5b08d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250730131253.48f5b08d@gandalf.local.home>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 17:23:23 up 94 days,  1:36,  1 user,  load average: 0.02, 0.03, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Steven Rostedt (rostedt@goodmis.org) wrote:
> On Wed, 30 Jul 2025 16:40:39 +0000
> "Dr. David Alan Gilbert" <linux@treblig.org> wrote:
> 
> > * Steven Rostedt (rostedt@goodmis.org) wrote:
> > > On Wed, 30 Jul 2025 16:34:28 +0100
> > > Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > >   
> > > > > Which looked like someone else (now Cc'd on this thread) took it public,  
> > 
> > (I didn't know of the tab discussion)
> 
> Well, you were not there ;-)
> 
> > > I guess a statement in submitting-patches.rst would suffice, or should it
> > > be a separate standalone document?  
> > 
> > If it's separate I think it needs to have a link from submitting-patches.rst
> > to get people to read it.
> > 
> > To summarise some other things that came up between the threads:
> >   a) I think there should be a standard syntax for stating it is
> >      AI written; I'd suggested using a new tag, but others were
> >      arguing on the side of reusing existing tags, which seems OK
> >      if it is done in a standard way and doesn't confuse existing tools.
> 
> Right. So I believe those that did not want the tag, wanted the statement
> to be under the "---" so that it will not get into the git log. I prefer
> the tag, but I'll be OK with the comment below the "---" as long as it is
> clearly stated that the code was generated by AI.

I think the 'clearly stated' is bound to get messy, especially with
multiple (natural) languages.  A tag doesn't have that ambiguity.
My preference for having it above the --- is to allow later analysis
(does the Foo AI tend to mess up checks for .... ?)
It might also be useful for those other GPL licensed projects that
don't accept AI generated code.

> > 
> >   b) There's a whole spectrum of:
> >       i) AI wrote the whole patch based on a vague requirement
> >      ii) AI is in the editor and tab completes stuff
> >     iii) AI suggests fixes/changes
> >     which do you care about?
> 
> Yes, this is one of the controversial issues with having a policy. How much
> does AI have to help you before you must disclose it. I would say basic
> completions shouldn't be an issue. I've had editors where I type "for" it
> then fills in "for (int i = 0; ; i++)". Is that AI? I don't think so.

What happens when it looks at the type you're using and turns it into a
use of a macro like list_for_each()?   I suspect the line is fuzzy.

Personally that doesn't worry me much, but I don't think I can tell others
not to worry about it.

> I'm more concern where you use AI to come up with an algorith. "Hey AI,
> sort this array with a quick-sort routine". And it does so. That should be
> denoted in the change log. Either above or below the '---'.
> 
> > 
> >   c) But then once you get stuff suggesting fixes/changes people were
> >     wondering if you should specify other non-AI tools as well.
> >     That might help reviewers who get bombed by a million patches
> >     from some conventional tool.
> 
> Fixes and changes I don't think require disclosure as long as the human
> looks at that code and figures out that the code needs to change. Now if
> the AI does the fix for you, as in makes the patch, then yeah, you should
> disclose it. But if you manual make the patch after looking at what AI
> pointed you to, then it should be fine.
> 
> > 
> >   d) Either way there needs to be emphasis that the 'Signed-off-by'
> >     is a human declaring it's all legal and checked.
> 
> That should go without saying.

My point is that it needs saying loudly in the docs!

Dave

> -- Steve
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

