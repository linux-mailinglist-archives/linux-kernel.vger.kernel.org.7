Return-Path: <linux-kernel+bounces-751094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1082CB16535
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3903A5640C3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E792DEA8A;
	Wed, 30 Jul 2025 17:12:49 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64CC2E3711;
	Wed, 30 Jul 2025 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753895569; cv=none; b=ejVO4kItbdw2yihyDHhZnLnkJIRDvadITu9wK9sAGtXpyrVSc+3sbMhoHDVaqwcOlq+rTszObfYXj/n9Myrle9APZXFefcYdNMJdt9vDIKSCY0P/1QGZyHY7dQsFScr8fNwMk5bQVL/s+xKX934gEI4v6Qj5adakJGY7E575PZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753895569; c=relaxed/simple;
	bh=1VBTrX6/qa56810Gejryg2OeqV4vxKzvefNgP7/6u74=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owg898Ap292sH4mD3hsLGaNACVgJfmMHcSXN/usxPxog2m55wu3L6FfxNbx4ECWWUrDqYupL1JPARMUYT9q/VrDSxczLAy8jZ699eGpd/cvEXPolxag2HUChJPqrn9XIAZL5rOBDWMVubMYITWRDISo+bWEft8pJj9Wr+KouKB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 74F3F13466A;
	Wed, 30 Jul 2025 17:12:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id E1ED32000D;
	Wed, 30 Jul 2025 17:12:36 +0000 (UTC)
Date: Wed, 30 Jul 2025 13:12:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Greg KH <greg@kroah.com>,
 Sasha Levin <sashal@kernel.org>, corbet@lwn.net, linux-doc@vger.kernel.org,
 workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org,
 konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <20250730131253.48f5b08d@gandalf.local.home>
In-Reply-To: <aIpLB5oMc1tSq1SP@gallifrey>
References: <20250727195802.2222764-1-sashal@kernel.org>
	<7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
	<2025072854-earthen-velcro-8b32@gregkh>
	<df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
	<20250730112753.17f5af13@gandalf.local.home>
	<158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
	<20250730121829.0c89228d@gandalf.local.home>
	<aIpLB5oMc1tSq1SP@gallifrey>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E1ED32000D
X-Stat-Signature: k3it3xzk47uyfp6gsxygo6dsafwne4gp
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+hLCS5q6sZLDkdhSP//d+QrKsGGeDj0aE=
X-HE-Tag: 1753895556-13449
X-HE-Meta: U2FsdGVkX1+7Wu/8kP/9CblTEu/fiaaeZolS0RIdj03eOTdx/I3CFy0zND5KxzGiXY6lqA/0/6GF3iJHd3TwqmP+j0MUruLgaHuJ3E9FqzY6sQs5j4NZA8jCxONQAU9k2AmaMBw+1bm36gyDAXKpJAieOHcO+HrovGktpG4+Y8JrGbbeiIdw3lxQojIv5jxGNHvSWfa+f9WXwjeioiJ+NtWwV9lizlN89JWNk7G2ayKfcJPMBoShYs/ML1yWNVIHgn6V2b8ErsyhbPAHQV3FgcINADssyEuaMum2EjHEVzojb8jirV90D/rkLqjoCkH/yFmypvajTFlg+mHHQrltEmKPLJV0h7a4rPBGjU29QRj971aazPkEFUCbtGHkorLv3jOfBO5R6nDuHx6xk47/4LFPQDCCorN1RM16BqNGhuCGVh2q7h12lhDIqIn3uDkwABWnBldP/vnJw4fJFZkpfw==

On Wed, 30 Jul 2025 16:40:39 +0000
"Dr. David Alan Gilbert" <linux@treblig.org> wrote:

> * Steven Rostedt (rostedt@goodmis.org) wrote:
> > On Wed, 30 Jul 2025 16:34:28 +0100
> > Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> >   
> > > > Which looked like someone else (now Cc'd on this thread) took it public,  
> 
> (I didn't know of the tab discussion)

Well, you were not there ;-)

> > I guess a statement in submitting-patches.rst would suffice, or should it
> > be a separate standalone document?  
> 
> If it's separate I think it needs to have a link from submitting-patches.rst
> to get people to read it.
> 
> To summarise some other things that came up between the threads:
>   a) I think there should be a standard syntax for stating it is
>      AI written; I'd suggested using a new tag, but others were
>      arguing on the side of reusing existing tags, which seems OK
>      if it is done in a standard way and doesn't confuse existing tools.

Right. So I believe those that did not want the tag, wanted the statement
to be under the "---" so that it will not get into the git log. I prefer
the tag, but I'll be OK with the comment below the "---" as long as it is
clearly stated that the code was generated by AI.

> 
>   b) There's a whole spectrum of:
>       i) AI wrote the whole patch based on a vague requirement
>      ii) AI is in the editor and tab completes stuff
>     iii) AI suggests fixes/changes
>     which do you care about?

Yes, this is one of the controversial issues with having a policy. How much
does AI have to help you before you must disclose it. I would say basic
completions shouldn't be an issue. I've had editors where I type "for" it
then fills in "for (int i = 0; ; i++)". Is that AI? I don't think so.

I'm more concern where you use AI to come up with an algorith. "Hey AI,
sort this array with a quick-sort routine". And it does so. That should be
denoted in the change log. Either above or below the '---'.

> 
>   c) But then once you get stuff suggesting fixes/changes people were
>     wondering if you should specify other non-AI tools as well.
>     That might help reviewers who get bombed by a million patches
>     from some conventional tool.

Fixes and changes I don't think require disclosure as long as the human
looks at that code and figures out that the code needs to change. Now if
the AI does the fix for you, as in makes the patch, then yeah, you should
disclose it. But if you manual make the patch after looking at what AI
pointed you to, then it should be fine.

> 
>   d) Either way there needs to be emphasis that the 'Signed-off-by'
>     is a human declaring it's all legal and checked.

That should go without saying.

-- Steve

