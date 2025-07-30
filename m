Return-Path: <linux-kernel+bounces-751109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 242ABB16558
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B375A6ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D746E2DC34F;
	Wed, 30 Jul 2025 17:20:44 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378D52DE70B;
	Wed, 30 Jul 2025 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896044; cv=none; b=i1eeT5BnpcEEwg+aMEpWpCpJe5rXdPYZDHFskXPdIoN6tVPm8ZlBF38LUNEk7qORSLdEmxTQxmDYGhDujvgGVVwH343K3lV/Q2XHH9ndFqLNx8t//eJTYvyXVNOZN1MLSx31wmV6n/qyluMZsOiqPF78ZnrPTu2dhUgNO50fHi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896044; c=relaxed/simple;
	bh=eGgYF3faEDvlbfXoAL+/uQaiHWaQLSaNvRovm9vIZE0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2E/sz4hPlc/Sd0l1xx/n44SL6PXqWoAWdue3BGRqWmXKmmyidw/xpAye6g9o5A64EkTA5kc+X/XIlaFScy/s7znViyV97lZ/Y8t6ITR8sykN+TK2nYAL72JDKcwBGoYQe9a3zISDk2GcYPraLRs+450L2FE6qM1p0a86TJIEX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 5D7A916049D;
	Wed, 30 Jul 2025 17:20:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id EC1F919;
	Wed, 30 Jul 2025 17:20:37 +0000 (UTC)
Date: Wed, 30 Jul 2025 13:20:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>, Greg KH <greg@kroah.com>,
 Sasha Levin <sashal@kernel.org>, corbet@lwn.net, linux-doc@vger.kernel.org,
 workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org,
 konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <20250730132054.1e710372@gandalf.local.home>
In-Reply-To: <46973236-a53d-4d1c-912c-1e3dc08e4160@lucifer.local>
References: <20250727195802.2222764-1-sashal@kernel.org>
	<7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
	<2025072854-earthen-velcro-8b32@gregkh>
	<df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
	<20250730112753.17f5af13@gandalf.local.home>
	<158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
	<20250730121829.0c89228d@gandalf.local.home>
	<aIpLB5oMc1tSq1SP@gallifrey>
	<46973236-a53d-4d1c-912c-1e3dc08e4160@lucifer.local>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: oie35eibcbkyro4hyb3ctondp8kzxqpq
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: EC1F919
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18wKPxFa3CpT4uCPLKfmEDBhk4OCY6wBDk=
X-HE-Tag: 1753896037-199669
X-HE-Meta: U2FsdGVkX190h4xoJRWLdQP+eNpIHZDUHIQEr7gSwBSEv+hFY2EUu0Jh4SaQPSRSojsWgSGkLM7gU5/RvO0RoCACIihUzv80x3mshby1uXRcLYV0DVycNbp/ObCXkHsS+HKAyB07v7hWYUaIFJOMdfHQtR4WAPNDqgouhOy+8s2sEgjXDgogYLSmqFzKkP36xz7m6+2jBp4B2OTb7JqEDy9MjVBl++PsCmoIh6EQ+xjTkLIg8AjcCnd4SG3reoqwh140yRgc/Gm71uT2ifu2BOAK7+mf089HZxu4SQkao7cn9X22s+X+bIlv5gQO0ZzXH6H/dcIexFcQDoYbxXHH2uh0HfQ6FqAH

On Wed, 30 Jul 2025 18:10:51 +0100
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:


> > > I guess a statement in submitting-patches.rst would suffice, or should it
> > > be a separate standalone document?  
> >
> > If it's separate I think it needs to have a link from submitting-patches.rst
> > to get people to read it.  
> 
> Absolutely agree.

Sorry for cropping your response about submitting patches, but honestly, I
think it may get more visibility there than in a separate doc. That's
because submitting-patches is one of the most popular documents kernel devs
reference to people submitting patches!

Of course, adding a link as suggested above may fix that too.

> 
> >
> > To summarise some other things that came up between the threads:
> >   a) I think there should be a standard syntax for stating it is
> >      AI written; I'd suggested using a new tag, but others were
> >      arguing on the side of reusing existing tags, which seems OK
> >      if it is done in a standard way and doesn't confuse existing tools.  
> 
> Yes.
> 
> >
> >   b) There's a whole spectrum of:
> >       i) AI wrote the whole patch based on a vague requirement
> >      ii) AI is in the editor and tab completes stuff
> >     iii) AI suggests fixes/changes
> >     which do you care about?  
> 
> I think any AI involvment that results in _changes to the code_ should
> require the tag.

I disagree with this. As I reply, I don't think if you have AI finishing
your for loops and such requires disclosure. As I believe that may soon be
the norm of most folks and then we may get AI storms.

And then, if you have people saying "I don't want any AI patches", does
that mean those that use AI for templates and such will now be forbidden
from submitting to those subsystems?

I would say if AI creates any algorithm for you then it must be disclosed.

> 
> >
> >   c) But then once you get stuff suggesting fixes/changes people were
> >     wondering if you should specify other non-AI tools as well.
> >     That might help reviewers who get bombed by a million patches
> >     from some conventional tool.  

I should add that non-AI tools should always come with a disclaimer that
they were used. For the most part, most submissions that use non-AI tooling
has done this. I just don't think we ever made any formal policy about it.

-- Steve

