Return-Path: <linux-kernel+bounces-731562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15637B05643
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31AF3189B484
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0352D63E0;
	Tue, 15 Jul 2025 09:24:52 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1A42D4B6C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571492; cv=none; b=W6p8TxeIF+BFazNG/UWK1WDLj8PDqJh0RcXxiXQAGcJUeEF0DSArTmssfdGumLUjo36dIS17jaq/GLlqhTD+16sDWb462qoeE06BQ9NdkaiQZL/jLlR2YgUPiWmsgvrZpY7vHHJViOqNUSU7IBJgGmGOi8lUjuW4a895qT0xSwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571492; c=relaxed/simple;
	bh=64bt0iSESH6whWxj7HMeGo4fm1c+U7mOLXtACGkYC58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BztKAmxIROtKzWOJZvGYtKwJwtor5Cfvt3nt5YKgvZf65ete1BluLXFLpv/3qgyayTHtez3VvjQiCJIOblMMpyDlhtdYuky4h/igYn219eXt2PysJn0njNn5kSqWw7qPw2wJIYzSIL69am5MS4+5j3NVagGF6xpnoeTxUxiYVOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 5EB9910EF50;
	Tue, 15 Jul 2025 09:24:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 2619420030;
	Tue, 15 Jul 2025 09:24:46 +0000 (UTC)
Date: Tue, 15 Jul 2025 05:24:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt
 <rostedt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@infradead.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] LTTng upstreaming next steps
Message-ID: <20250715052459.0000e119@gandalf.local.home>
In-Reply-To: <CAHk-=wgZ=Ssx4qoeuaHet1vx+8M36j0a3q2aw5ePapWm=KnSfQ@mail.gmail.com>
References: <b554bfa3-d710-4671-945b-5d6ec49e52cd@efficios.com>
	<CAHk-=wiT9Cz+EbbuKozqiu7DnZQ7ftAWSmGf-xy_CdhJPCsNSg@mail.gmail.com>
	<20250714162750.45b12314@gandalf.local.home>
	<20250714163755.1de132e9@gandalf.local.home>
	<CAHk-=wgZ=Ssx4qoeuaHet1vx+8M36j0a3q2aw5ePapWm=KnSfQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2619420030
X-Stat-Signature: g4ijjbpajeh6paa5ig6e3f5f3ffmwi8c
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/ZwbkjnE51esi0NAQspdyE9ivdkuaezqo=
X-HE-Tag: 1752571486-635244
X-HE-Meta: U2FsdGVkX1+vl75AssqaKIqnIPvxSuUEU+D7PXmwwgx1zbGaatG/Qhuky06wNCtlSjoHfcXMujEYGAjS78h+XjIRqUbtRno4DCe7HhuuRZR1T/M/t1DQUPyVA6uYRhtwhtDNwLSp6rCbdcjwGUCugPb0TaQgFLlGqW+T5yECe/hImCt93POvcGGp+PYv+k3F1VgwnXCc9q+doTVrdjgIbyTqVwxnuVMmZjtV8i9GPs2QnNQw4OFNQ0fZjQBmH3eUniaDWuwjOjovxPPx0Ii2Yot8h5HNmHJ2wQsntD8HoTaQAISnQXi7CE2vQadmTnDV1s+ZeLASBfY5xQnIphpc5uLRjno7JTiQvQKhQ+zv+ntboiZgqnjegaCU6Jgf0fz9hpxgbJnRyABQw9QuY3UFJwEEgg+1HZztubCruDuFYON2Uj+1Pn8yVPyhSCPkkjva

On Mon, 14 Jul 2025 14:04:38 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 14 Jul 2025 at 13:37, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > If LTTng were to be in tree, it would be much easier to work on a strategy
> > to merge the infrastructure as the maintainers of both would have better
> > access to each other's code.  
> 
> That's not a bet I'd take.
> 
> If people haven't unified this in the last two decades, I'm noty going
> to take the argument of "hey, merge it because *then* it will be
> unified".
> 
> Because honestly, that sounds like a total fairy tale to me: "the
> princess came along and kissed the toad, and he turned into a
> beautiful price, and they lived happily ever after".
> 
> So no. I don't believe in fairy tales. Not when we have two decades of
> "that didn't happen".
> 
> If people can unify this and merge it incrementally, that's one thing.
> 
> Until then, you're just making stuff up.
> 
> "Show me the code", in other words.

We'd love to, but how is one to merge code in incremental steps when they
are not allowed to use the current infrastructure?

LTTng being out of tree means it is only allowed to use EXPORT_SYMBOL_GPL()
functions as it must be a module. Perf, ftrace and BPF are all 100% in-tree
and has no modules so they do not require any EXPORT_SYMBOL_GPL() to use
the current infrastructure.

This is the main difference between an external tracer and an external
driver. That's because other in-tree drivers and file systems all have a
module component. If ftrace, perf and BPF were modules, it would require the
infrastructure they use to all be defined as EXPORT_SYMBOL_GPL(). This
makes LTTng have a huge disadvantage as those are not modules and the
interface they use are not exported.

Christoph and Greg keep saying "this is no different than any other out of
tree code", but I'm saying due to this limitation it is. When they talk
about out of tree drivers and file systems that need to do the same, that
code has a huge advantage because it is competing with other code that are
modules and they can use the same infrastructure. Even when they are out of
tree.

Case in point, Mathieu is helping with the sframe work so that it can share
the same code that perf and ftrace will use. But as soon as we want to
allow it to use that code, it is shot down because it requires a
EXPORT_SYMBOL_GPL() to access it. Because perf an ftrace have no "module"
selection, there will be no in-tree module that would use that interface,
thus LTTng is out of luck.

This forces LTTng to come up with a different solution for everything that
perf and ftrace do.

This is a huge catch-22 for LTTng. You want unification before LTTng can
become part of the kernel. But because Christoph and Greg refuse to allow
LTTng to have access to anything that perf and ftrace use, there's no path
for LTTng to share the code.

This discussion is going full circle:

1. Mathieu helps with new infrastructure that it could share with perf and
   ftrace.

2. We ask to add EXPORT_SYMBOL_GPL() so that LTTng can share this code.

3. It is denied because LTTng is out of tree, and we are told that if LTTng
   wants to use this it must first be in tree.

4. We send an RFC on how to get LTTng in tree.

5. We are told that LTTng can only get in tree through incremental steps.

6. The only way to do incremental steps is for LTTng to have access to the
   same functions as perf and ftrace have, but is not allow to because it's
   out of tree!

When I said being out of tree makes it much more difficult to merge code,
this is the reason why.

Breaking up LTTng is a huge task to do it in incremental states. If it can't
use in kernel infrastructure while it is out of tree, it will mean the out
of tree LTTng cannot use the code being submitted. Thus, the code going
upstream will be unused or will be a non-functional LTTng. If it takes several
years to complete, it is forcing Mathieu to have a broken LTTng for several
years before it is allowed to use code upstream.

So which is it?

Either LTTng can use the same infrastructure as perf and ftrace, meaning it
requires EXPORT_SYMBOL_GPL() on those interfaces, or it gets pulled in as
is, so that it can incrementally start to share the code.

-- Steve


