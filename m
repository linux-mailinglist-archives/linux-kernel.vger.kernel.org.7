Return-Path: <linux-kernel+bounces-728023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BC9B022A3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D233B5C2CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB51219A91;
	Fri, 11 Jul 2025 17:32:52 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AB12AE66
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255172; cv=none; b=NOmBr/J7X0y7W/pxbby2B5pvWj0UAUWZXuV8Mueha/Ko5CiT/5CkMBjcuBuc1Jxo5Y4Iy21ymWnHIRJgP4l3h8jDsWByCyEUmy+GsjMATVVVRO2zDTAxdKE10qbd6GQqoLfDCk/G7YHu5Bq/DGjUqAzsHLaNTPoJ3UKwh3W3Ny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255172; c=relaxed/simple;
	bh=Wm+P0tKWxx0Pps707CafIvsZ2e7oH73pHA0GGHCL0dc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BN04mDr0+6lP7xCvdorw3j5gIyUxgbiAOt0l12jA/5GvI1geQ0zEHUwstPZj6r8gpj4zLGiJkI3ESAkY2vXbvQt8J7zh50b5KezxZRizrdaSq+hQ/caZXMo63fP37ETI0az6+QMMP8iUs5VNjCUjMWTq0D91ryQCV+WLLKXyvbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 2560D81269;
	Fri, 11 Jul 2025 17:32:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id E714B20010;
	Fri, 11 Jul 2025 17:32:41 +0000 (UTC)
Date: Fri, 11 Jul 2025 13:32:40 -0400
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
Message-ID: <20250711133240.0d5b6de8@batman.local.home>
In-Reply-To: <2025071127-reunion-residence-c0f2@gregkh>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
	<20250709212556.32777-3-mathieu.desnoyers@efficios.com>
	<aHC-_HWR2L5kTYU5@infradead.org>
	<20250711065742.00d6668b@gandalf.local.home>
	<2025071124-cola-slouching-9dd2@gregkh>
	<20250711091734.5632dcf7@gandalf.local.home>
	<2025071127-reunion-residence-c0f2@gregkh>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 18adtu5u8ur8tnbm9raqssehis49hibx
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: E714B20010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19s6TWKO0QxzcI2vgZ4MDUlJVv/wA2P5cc=
X-HE-Tag: 1752255161-399294
X-HE-Meta: U2FsdGVkX1/O+ZEOZRiNmL7u0sMWsv636j9dUP/r1UllCQYwe05OB0tZE3WUTF/+wv+0cETMgXaJwoYKM2SANiYzNy9GBV71QeTIQBPGVMys60k8Xx+N+WzT3IUZExXSt2f1sSE7aekCb1hmXDAnfL6qQFcmU5RVBGGb9/o+RnBy0Z1WdB7hmYhwzPag+hyV/fMXnR9k2FM59DiA1mYgg5smK2l0hQhGLFku8HtO270L/gorDEbsT+yX9+ScZyd8hvhjDY20xtlBe0erQhxWuD/C8HyTFD1CK3w1bR62YEc4Cc/9ZkcmNGQiOWEd0+eXdYxS921yVi8RN9Pk7NjmE6XLrMR1E1GX/GYMd1elgupGyVPPVAa5vAo6+slFueuu

On Fri, 11 Jul 2025 18:39:40 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> > Yes, but you mostly see drivers and side functions that really do nothing
> > for the kernel. LTTng has contributed tracepoints, several RCU
> > enhancements, restartable sequences and more.  
> 
> Somehow those little drivers are "doing something" for the kernel by
> virtue of you being able to use your keyboard and network card :)

I meant contributions to other parts of the kernel than just tracing.
This is more like PREEMPT_RT, where improvements to the core kernel was
made to help both LTTng and the kernel proper.

If you want to talk about precedent, we have it. raw_spin_lock() was
used *only* for PREEMPT_RT years before it was ever added to the kernel.

> 
> Seriously, don't conflate tracing core code as some how being more
> "important" than any existing driver in the tree, when both, in the end,
> are necessary for a user to get their job done.  One could even say that
> the tracing stuff is NOT needed, as if code works properly, no one
> should be needing to use it...

I'll even argue that this is fine for EXPORT_SYMBOL_GPL() because it
*isn't important*! I'm not saying it's more important. I'll agree with
you and say its less important. The point that the function I want to
export gives you information only and doesn't give you any operational
hooks into the kernel, means it's just a outside observer of the
system. It's not changing how the system works in any way.

I always tell people that tracing is a second class citizen when it
comes to the kernel. It should try it's damn best to not effect the
system it is trying to observe. If there's a decision to be made that
can improve tracing with the cost of hurting the system performance
when tracing is off, I'll make the decision not to do it. This is why
we have jump_label. To have nops when tracing is disabled and jmps when
it is, so that tracing doesn't affect normal operations. Not to mention
all the hacks done for function tracing to keep its overhead down to a
bare minimum.

> 
> Anyway, I see stuff all over the place, not just drivers, for "real"
> things on a weekly basis.  Go poke in the Android kernel tree if you
> want to see loads of examples of where vendors feel they can export/hook
> into core parts of Linux just to get their work done.  I would argue
> that most of them are NOT needed and are doing crazy things, but as
> users have real hardware that sometimes requires it, it's a hard thing
> to argue against.

I know you see real things. I think you misunderstood my comment. I
didn't mean to say what you see is anyway less than what happens in
core kernel. I find drivers are a key part of the kernel. The core
kernel is just a tool to have applications interact with the hardware,
and without drivers, the kernel is useless. My point was merely stating
that you and I have different view points of the kernel. I in no way
was saying mine was more important. In fact, I would say it's less
important.

> 
> I'll show one real-world example, the USB offload path code, that you
> are using today on your Android phones that saves loads of battery life.
> In older kernels, the hooks/exports needed for that were all over the
> place, it took an engineer years to get this all working for lots of
> different hardware types and merged upstream properly.  They knew that
> they could not just get the upstream developers to export the needed
> functions, they had to get their working code merged in order to be able
> to have it happen.  And they did!

I'm not sure how that is comparable? It sounds like they needed to
clean up a bunch of other code for other hardware so they could use
this feature.

The feature I'm talking about is fully available. It's just a way to
get a user space stack trace from the kernel. Nothing more. The work
being done is to make it generic so all the tracers could use it. All
that's upstream. The two functions I would like to export is "give me a
user space stack trace now" and "defer the user space stack trace
from NMI to when the task goes back to user space".

> 
> That was a non-trivial task, and while you might not feel it "does
> nothing", the power savings you rely on daily would beg to differ.
> 
> So get the lttng code merged into the tree please, it seems that you are
> the one objecting to the merge, not me :)

It was actually others, and it was years ago. Perhaps we could just
accept the LTTng kernel module as is, as a module, and leave it at that?

Then these functions would still have to be EXPORT_SYMBOL_GPL() but at
least it would be for an in-tree module.

-- Steve

