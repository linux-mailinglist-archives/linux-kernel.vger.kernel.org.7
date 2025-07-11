Return-Path: <linux-kernel+bounces-727623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 605E0B01D38
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42612188D84C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BE72D3A80;
	Fri, 11 Jul 2025 13:17:36 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837B52D23B7
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752239855; cv=none; b=eIqgFWGRZlFFawmNUhLTTEDp23SQRF5p26+PE1iCTBIsCaMCXk6cw3P5t+R5pEPDPp2DEOqKjG9jCySP56mEUmk9G3j/Td+khFH9U1FJiyIAuNDLQtg9vNE6j8GpYGZOwf7Ry5lKKqf/eXmsKLf6SdRmPEDs64jJiS6dSaMyWjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752239855; c=relaxed/simple;
	bh=UqQT/KnHMQS63TZRxnmw33hMoSA3ImVA0UiF2O+xEkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WtPETq5eVuIjg7u+edM0KWwT4NVnHRrdQJmM/kNireZaAVx3XGYhuIcJYLWcw0VLk99N/sbTcgGbV8vSloYLy8jL26FbdjylGh3pGrvbyjuY4BntH6jiXIntap1cYlWPsQlYbTxkYIgD9SkaytD7SBpGz+9RJRYjrzh5wPeb4aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 931F612F9A1;
	Fri, 11 Jul 2025 13:17:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id ABB1F2000E;
	Fri, 11 Jul 2025 13:17:26 +0000 (UTC)
Date: Fri, 11 Jul 2025 09:17:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, Josh
 Poimboeuf <jpoimboe@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, tech-board-discuss@lists.linuxfoundation.org
Subject: Re: [RFC PATCH 2/5] unwind: Export unwind_user symbol to GPL
 modules
Message-ID: <20250711091734.5632dcf7@gandalf.local.home>
In-Reply-To: <2025071124-cola-slouching-9dd2@gregkh>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
	<20250709212556.32777-3-mathieu.desnoyers@efficios.com>
	<aHC-_HWR2L5kTYU5@infradead.org>
	<20250711065742.00d6668b@gandalf.local.home>
	<2025071124-cola-slouching-9dd2@gregkh>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: ABB1F2000E
X-Rspamd-Server: rspamout02
X-Stat-Signature: pwrdqdn93e9tjqmeej4oyi433p6t7dmt
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19ehXyLQKNcHcoRq7CHvcfh4WIIqSe9/9U=
X-HE-Tag: 1752239846-934070
X-HE-Meta: U2FsdGVkX1/Dd+dVmKSsmIeJ4hZRiasMudKwpkiY/R0uegcMkfQbSJbNVNIQJk+TkzzcRloaGhkdBi+0QcWjTQMnZ99CiXhWd/ByGHYhQXRErb117zbI/ZXhZ1sq4MsImDge+Uwtn/FHP5HAaBQpuy0d9QLZTvfhjkRCCOg1mFcsqw3SIm/DZtwonSjGOhp2YMefXIi0GXaDWaH/RHeg3pfie2dYYG1Ae/lhH2cRAdAERfD7CduLWG1d8iY2yFQj6cO0W4rWxTUf5IciaAqCmZFxvXxpM12lqXVzOOe0Jt4TEReVOvPGslK5g+yrASGYoNDHZFrpumNtRF4WhmBpLouWCxuR3KO1QP0lquyaXrSXuHOKbx3iupijvt+7B7QM3EOZlGBPGhoO+1s7RoGt3GU4V5KNIiuKci+TzoAgNvCMUxoGFzMaNCUvOkBmri84

On Fri, 11 Jul 2025 13:38:07 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Jul 11, 2025 at 06:57:42AM -0400, Steven Rostedt wrote:
> > 
> > [ Adding the TAB to this as well ]
> > 
> > On Fri, 11 Jul 2025 00:36:28 -0700
> > Christoph Hellwig <hch@infradead.org> wrote:
> >   
> > > On Wed, Jul 09, 2025 at 05:25:49PM -0400, Mathieu Desnoyers wrote:  
> > > > Allow the unwind_user symbol to be used by GPL modules, for instance
> > > > LTTng.    
> > > 
> > > I don't see a LTTng submission or any other user in this series.
> > > So the usual prohibition against adding unused exports applies here
> > > as usual.  
> > 
> > I want to bring up this discussion. I understand there's a policy not to
> > add EXPORT_SYMBOL_GPL() unless there's a current user of it in the kernel
> > proper. My question is, does this policy have to be draconian?  
> 
> It's not "draconian", it is "we do not add exports for stuff that is
> not in our kernel tree."  Simple, direct, and obvious.  We have no idea
> how, or if, external modules do anything with apis that we export and do
> not use internally, so we can't change them without breaking anything,
> so it's simpler and more obvious to not even attempt to care about them.

Let me clear up a misunderstanding on my part. That is, this *will* be used
internally when an EXPORT_SYMBOL_GPL() is added to it. Ftrace, perf and
probably BPF will be using the function. But all of these are not modules,
but the only one that is a module would be LTTng, and it is adaptable to
change. Just like a BPF program would be.

I mean, if I made a part of ftrace into a loadable module that used this
feature, then we could make this EXPORT_SYMBOL_GPL()?

> 
> If external users want to use a symbol, they should get merged into the
> tree.
> 
> Yes, lttng is a "good citizen" of the kernel community, and yes, it's
> not merged into the tree, but that's not our issue, and living outside
> of the tree has it's penalities, both economic and technical.  This is
> one of those penalities, sorry.

But it is our issue. We are the ones keeping it out. We can try to get it
in again, but it will be a long and tedious process. Mathieu is at a
disadvantage here because he has no leverage as most of his customers are
non-kernel developers. So the decisions he makes is for them, not us. And
this has caused tension when it came to the way he did things compared to
what we wanted. His keeping it out of tree has worked so far. And now he's
been an active contributor on a new feature that will benefit perf, ftrace
and BPF but because we've been keeping him out of tree, he doesn't get to
use the work he's contributed to?

> 
> So no, we shouldn't change this at all.  And I think we need to start
> doing more of the "only export this symbol for this subsystem/module"
> trimming as well.  I see the horrors that out-of-tree kernel code does
> and by removing the ability of them to even get access to the things
> they do have access to today, would be good for everyone involved (i.e.
> our community, AND the users of Linux to allow them to have a more
> stable and trustworthy base to rely on.)

Yes, but you mostly see drivers and side functions that really do nothing
for the kernel. LTTng has contributed tracepoints, several RCU
enhancements, restartable sequences and more.

The user stack unwinding that we are adding is a new feature to do stack
unwinding without frame pointers that Fedora is working on adding. There's
two functions that LTTng would need to get this, and both will be used by
ftrace and perf. It only gives the module a user stack unwind. It's
information only and not something that tweaks the kernel in any way.

-- Steve



