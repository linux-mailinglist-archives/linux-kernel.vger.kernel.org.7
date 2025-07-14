Return-Path: <linux-kernel+bounces-730705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8DFB04861
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BAE5188D5F6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4582367C3;
	Mon, 14 Jul 2025 20:27:49 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD661F418B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752524869; cv=none; b=nzLnZR0h0Y9c2pReS+OyRsbwTRZnbE9iQMGDs2cIUi8QjfQYT4GB+9+oL9BwsbLg9df4CcB2RO4I6qaYPSR4HQSUtn0dSxAg6+Ea3pf3p6XDnJVnSRQkjTZfVKFxRzrqJud40R7UCYZYoLRiJREySxeqAplaLFmrOMVhZKUP4Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752524869; c=relaxed/simple;
	bh=TnQs/Oot/qjUXCPgwmfF9IA7aE1EZdZLCDd9zgiAl2I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IkESbsZgszFhyfisJ31MvYcnpdzXvoH+Yd8vZLX5OCAZ8ighfOnAXn6g/a+6sgH8LaIiQjWSS/Ju+JodkzJhKLgkZM57QV40wcQl042hxhOzq9+gsDfKav0anaH6HezujvvpKzxeb3BUTKg70r67qMz40v8eM+g3MLxpQZ+eN5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 5F0D112C6D1;
	Mon, 14 Jul 2025 20:27:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 311BB2D;
	Mon, 14 Jul 2025 20:27:35 +0000 (UTC)
Date: Mon, 14 Jul 2025 16:27:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt
 <rostedt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@infradead.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] LTTng upstreaming next steps
Message-ID: <20250714162750.45b12314@gandalf.local.home>
In-Reply-To: <CAHk-=wiT9Cz+EbbuKozqiu7DnZQ7ftAWSmGf-xy_CdhJPCsNSg@mail.gmail.com>
References: <b554bfa3-d710-4671-945b-5d6ec49e52cd@efficios.com>
	<CAHk-=wiT9Cz+EbbuKozqiu7DnZQ7ftAWSmGf-xy_CdhJPCsNSg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: x4fudhqyaf667z9d9f4dw1ufwdqtonb3
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 311BB2D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19YtcZPqQ1PV4vwI8ablZMhFMJIKw9c8LM=
X-HE-Tag: 1752524855-122563
X-HE-Meta: U2FsdGVkX1+dxjWdkBu+bwZKvi5G8J1HcB7lQ6YMMoObmXke9sXAb1VwseE5xCAtxxHgQvltNfyYzyzn5ej1bhjU5/8ILOObK4kB3IRhGYQ3Cv4Zb8shJV1FwhWPnK2oKkjs4LVgHXHs+EHlF1H3NHVZ7UXsYh0wHOAVBzbxSaA30fpawyKBS1tQHzeJmDq2OvA5prLsnJRLGBxP5aW85Yxxd5IFXwfDIA6dQaAPz6DO2dca+UC9waFMwxiHhx0C1wftB8oErtnsFq9GIYhe+nEOsLgAOY2xS2+yAGIVpd/lJHU0iAKkqFN5pMpgsfNcU+4x3dMh7Yj1/7PqCpxhLMa/DHCWR4e84I1L2etDXRGlqvFGfMiaZYTp/yhxL3KS4CO7Fm/voTJ7fm5VoYRQ2lcuLBk97CDha0d486K4adEPYrRO+1aqOCl7bVyyMZsx

On Mon, 14 Jul 2025 13:00:27 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 14 Jul 2025 at 12:41, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote>
> > A) Bulk upstreaming  
> 
> Honestly, I don't see the point.
> 
> The reason the current tracting infrastructure got merged was that
> people were willing to do it incrementally.
> 
> I was hoping that there would be some kind of eventual merging of the
> different ring buffers etc. That was discussed as a hopeful end goal
> originally, but here were are, decades later, and it never happened.

I'll note that one of the reasons that we couldn't use the LTTng ring
buffer is because the format of the tracing ring buffer and the perf ring
buffer were already exposed to user space and would break tooling if they
were changed. LTTng actually has more features than either the existing in
kernel buffers so it couldn't use the existing buffers without breaking its
own tooling.

> 
> And honestly, I am NOT interested in just having two different tracing models.
> 
> If people need two tracing models, then the other one will be out of
> tree. It's that simple.

It's not that anyone needs two models. It's that there's one model that one
set of people use, and there's another model that another set of people use.
The in-tree tracing (aka ftrace) is designed to be used for kernel
developers. It's quick and easy to use to find issues and is mostly focused
around kernel development. The tracefs directory interface has been a
godsend for embedded developers since it only needs busybox to be useful.

LTTng is more focused toward user admins and is around monitoring how the
system is behaving. It has a different set of tooling and interfaces.

> 
> Because if people haven't been able to agree on common models in the
> decades past, I really don't see the point in maintaining two models
> indefinitely side-by-side in the upstream kernel.
> 
> So as far as I'm concerned, this discussion is not a discussion.
> Either there's a way to merge things incrementally with SHARED
> infrastructure, or there isn't.
> 
> No "two different and disjoint trace buffers".
> 
> No "two different and disjoint trace interfaces".

Although they do have a separate set of buffers and interfaces, the actual
infrastructure (tracepoints, function hooks, etc) is shared.

> 
> And very clearly - based on history - that unification will never happen.

Unfortunately, I think you're right. :-(

-- Steve


