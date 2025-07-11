Return-Path: <linux-kernel+bounces-727977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ED5B021FA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F32E179B37
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009C02EF9DD;
	Fri, 11 Jul 2025 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P6ndBc5z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C4B2EF670
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251983; cv=none; b=kKpodePkPwGl2U0fUiWcGqMcGglvNIwCjqzgILtwnBHQSd/bpyLqHUXbk3bOzP9qLjxACzh76pIkqTFhK15wbGxkNxVpuDpF1B1jsv7TMUCljUo1+Rxo7zDxIfY6KbQsvRZ9nnu+/liqJ3vXWbMv6bnCJHABGeHZ+gq2XTtWPUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251983; c=relaxed/simple;
	bh=viWonLAY9is2nrjmcLw2ChbXeB0gIG9KdqYgrx4nI+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2ikb7G1+9v4F5ScFBkIVKmsPuD97IUC6LiUmOfnOArLUdyZRYOon/lWR/c2jUyA2qsQUBwKIzWsDf33AzV0KDwiqVit6WeFC2KojyNaphC8BXdaGfyBdNLaums3ThHLdup0KlW7F3DQK7LVN146gRTJDZ0PUK6mugC9BCfr2fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P6ndBc5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EE1C4CEF0;
	Fri, 11 Jul 2025 16:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752251982;
	bh=viWonLAY9is2nrjmcLw2ChbXeB0gIG9KdqYgrx4nI+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6ndBc5zwLlURXZBW4okNhekmQnLfB+wEV2Ul7yRBhtPBFX1oUoUCOVRti+hx++qv
	 C7vzT/W5+Das/kWFasF8a4CexBVQkriDtKuevrxZgzQfutUrVNz1G5qo5PBsD1B3x8
	 cz4FyelRWXXXLUYLGYwJNNjJcEDK7COWORYmnGEQ=
Date: Fri, 11 Jul 2025 18:39:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	tech-board-discuss@lists.linuxfoundation.org
Subject: Re: [RFC PATCH 2/5] unwind: Export unwind_user symbol to GPL modules
Message-ID: <2025071127-reunion-residence-c0f2@gregkh>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
 <20250709212556.32777-3-mathieu.desnoyers@efficios.com>
 <aHC-_HWR2L5kTYU5@infradead.org>
 <20250711065742.00d6668b@gandalf.local.home>
 <2025071124-cola-slouching-9dd2@gregkh>
 <20250711091734.5632dcf7@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711091734.5632dcf7@gandalf.local.home>

On Fri, Jul 11, 2025 at 09:17:34AM -0400, Steven Rostedt wrote:
> On Fri, 11 Jul 2025 13:38:07 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Fri, Jul 11, 2025 at 06:57:42AM -0400, Steven Rostedt wrote:
> > > 
> > > [ Adding the TAB to this as well ]
> > > 
> > > On Fri, 11 Jul 2025 00:36:28 -0700
> > > Christoph Hellwig <hch@infradead.org> wrote:
> > >   
> > > > On Wed, Jul 09, 2025 at 05:25:49PM -0400, Mathieu Desnoyers wrote:  
> > > > > Allow the unwind_user symbol to be used by GPL modules, for instance
> > > > > LTTng.    
> > > > 
> > > > I don't see a LTTng submission or any other user in this series.
> > > > So the usual prohibition against adding unused exports applies here
> > > > as usual.  
> > > 
> > > I want to bring up this discussion. I understand there's a policy not to
> > > add EXPORT_SYMBOL_GPL() unless there's a current user of it in the kernel
> > > proper. My question is, does this policy have to be draconian?  
> > 
> > It's not "draconian", it is "we do not add exports for stuff that is
> > not in our kernel tree."  Simple, direct, and obvious.  We have no idea
> > how, or if, external modules do anything with apis that we export and do
> > not use internally, so we can't change them without breaking anything,
> > so it's simpler and more obvious to not even attempt to care about them.
> 
> Let me clear up a misunderstanding on my part. That is, this *will* be used
> internally when an EXPORT_SYMBOL_GPL() is added to it. Ftrace, perf and
> probably BPF will be using the function. But all of these are not modules,
> but the only one that is a module would be LTTng, and it is adaptable to
> change. Just like a BPF program would be.
> 
> I mean, if I made a part of ftrace into a loadable module that used this
> feature, then we could make this EXPORT_SYMBOL_GPL()?

Don't be silly, and don't attempt to "skirt the rules" like this.
Otherwise you will have a huge onflux of people/companies claiming that
they too deserve symbol exports for their long-out-of-tree-monstrosities
that they never worked to merge.

Again, let's keep the rule simple, exports are only for in-kernel users.

> > If external users want to use a symbol, they should get merged into the
> > tree.
> > 
> > Yes, lttng is a "good citizen" of the kernel community, and yes, it's
> > not merged into the tree, but that's not our issue, and living outside
> > of the tree has it's penalities, both economic and technical.  This is
> > one of those penalities, sorry.
> 
> But it is our issue. We are the ones keeping it out. We can try to get it
> in again, but it will be a long and tedious process. Mathieu is at a
> disadvantage here because he has no leverage as most of his customers are
> non-kernel developers. So the decisions he makes is for them, not us. And
> this has caused tension when it came to the way he did things compared to
> what we wanted. His keeping it out of tree has worked so far. And now he's
> been an active contributor on a new feature that will benefit perf, ftrace
> and BPF but because we've been keeping him out of tree, he doesn't get to
> use the work he's contributed to?

Sure he can, by virtue of it being in perf, ftrace, and bpf :)

Again, export stuff for in-tree users only.

> > So no, we shouldn't change this at all.  And I think we need to start
> > doing more of the "only export this symbol for this subsystem/module"
> > trimming as well.  I see the horrors that out-of-tree kernel code does
> > and by removing the ability of them to even get access to the things
> > they do have access to today, would be good for everyone involved (i.e.
> > our community, AND the users of Linux to allow them to have a more
> > stable and trustworthy base to rely on.)
> 
> Yes, but you mostly see drivers and side functions that really do nothing
> for the kernel. LTTng has contributed tracepoints, several RCU
> enhancements, restartable sequences and more.

Somehow those little drivers are "doing something" for the kernel by
virtue of you being able to use your keyboard and network card :)

Seriously, don't conflate tracing core code as some how being more
"important" than any existing driver in the tree, when both, in the end,
are necessary for a user to get their job done.  One could even say that
the tracing stuff is NOT needed, as if code works properly, no one
should be needing to use it...

Anyway, I see stuff all over the place, not just drivers, for "real"
things on a weekly basis.  Go poke in the Android kernel tree if you
want to see loads of examples of where vendors feel they can export/hook
into core parts of Linux just to get their work done.  I would argue
that most of them are NOT needed and are doing crazy things, but as
users have real hardware that sometimes requires it, it's a hard thing
to argue against.

I'll show one real-world example, the USB offload path code, that you
are using today on your Android phones that saves loads of battery life.
In older kernels, the hooks/exports needed for that were all over the
place, it took an engineer years to get this all working for lots of
different hardware types and merged upstream properly.  They knew that
they could not just get the upstream developers to export the needed
functions, they had to get their working code merged in order to be able
to have it happen.  And they did!

That was a non-trivial task, and while you might not feel it "does
nothing", the power savings you rely on daily would beg to differ.

So get the lttng code merged into the tree please, it seems that you are
the one objecting to the merge, not me :)

thanks,

greg k-h

