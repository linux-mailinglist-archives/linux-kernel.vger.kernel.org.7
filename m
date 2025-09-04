Return-Path: <linux-kernel+bounces-799962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2885FB431B0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F3A17F592
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A3A242D60;
	Thu,  4 Sep 2025 05:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qHeaYKDi"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DDF23B627
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 05:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756964551; cv=none; b=FdqUMY235qk84aD4m1oUFZrn39r7eKEPj5VRllMtlvZFoeocNOI4P2eKJ1eP7QaQanhfktwRG2lX4LI+7rp1dhyNg4DWp6W7P2FkRaNhR5CecUm/O5HughFOHXLGgQJ2qXswPA3UCT4uZ7zID6q0itCCpjH+0gU8dh5DgqyXmqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756964551; c=relaxed/simple;
	bh=KnBlSL+u/GgJbd1KwN3zOuSY9m9+rSkn4C6EEldbc5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwjiWx8g3CrpYdONwRb7KoEivevC90TIq4/FVr+ifeZLC3SYNs6tTKkls+KDYulYxglfrRH2Gj5vpby4PmiRcmdRkv4R0Z3vel4ZQUQY9vOs6lysagp0xP63akJ/NSV1oEKztf36j/tVLQJj88revayODaVo4d4tu6h11w2Pxsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qHeaYKDi; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756964544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vv579mHoPmGiiQ8blU72cyOv0YwItlr8McIzFMHuZdU=;
	b=qHeaYKDiK4+4eUWY1/HgFJfLsCOw+YoSOxZkjOcjF2979O1ROske5xtxfb5uR79Ins3sB3
	+d95fvAsjwkevOeXiGIAr/1C0KIvogIA7ElolVd7gKHyGwcOZFJrhMhDjcNICG7U0vZ1Ud
	GfxYoGiOebn3vjymEa7XexfrvtfjB9E=
From: Menglong Dong <menglong.dong@linux.dev>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, mhiramat@kernel.org,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 oliver.sang@intel.com
Subject: Re: [PATCH] tracing: fprobe: fix suspicious rcu usage in fprobe_entry
Date: Thu, 04 Sep 2025 13:42:18 +0800
Message-ID: <2322233.iZASKD2KPV@7940hx>
In-Reply-To: <20250904132931.8c46a011b2fa1743fc87def4@kernel.org>
References:
 <aLa2D4It1Zxc7bs0@gondor.apana.org.au> <5038598.31r3eYUQgx@7940hx>
 <20250904132931.8c46a011b2fa1743fc87def4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/9/4 12:29 Masami Hiramatsu <mhiramat@kernel.org> write:
> On Thu, 04 Sep 2025 11:37:35 +0800
> Menglong Dong <menglong.dong@linux.dev> wrote:
> 
> > On 2025/9/3 12:22 Herbert Xu <herbert@gondor.apana.org.au> write:
> > > On Tue, Sep 02, 2025 at 05:50:32PM +0800, menglong.dong@linux.dev wrote:
> > > > On 2025/9/2 17:17 Herbert Xu <herbert@gondor.apana.org.au> write:
> > > > > Menglong Dong <dongml2@chinatelecom.cn> wrote:
> > > > > >
> > > > > > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > > > > > index fb127fa95f21..fece0f849c1c 100644
> > > > > > --- a/kernel/trace/fprobe.c
> > > > > > +++ b/kernel/trace/fprobe.c
> > > > > > @@ -269,7 +269,9 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> > > > > >        if (WARN_ON_ONCE(!fregs))
> > > > > >                return 0;
> > > > > > 
> > > > > > +       rcu_read_lock();
> > > > > >        head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
> > > > > > +       rcu_read_unlock();
> > > > > >        reserved_words = 0;
> > > > > >        rhl_for_each_entry_rcu(node, pos, head, hlist) {
> > > > > >                if (node->addr != func)
> > > > > 
> > > > > Actually this isn't quite right.  I know that it is a false-positive
> > > > > so that it's actually safe, but if you're going to mark it with
> > > > > rcu_read_lock, it should cover both the lookup as well as the
> > > > > dereference which happens in the loop rhl_for_each_entry_rcu.
> > > > 
> > > > Yeah, I understand. The rcu_read_lock() here is totally used to
> > > > suppress the suspicious rcu usage warning, not for the protection.
> > > > So I used it just for the rhltable_lookup() to reduce the impact.
> > > > Maybe I should add some comment for it.
> > > 
> > > My point is that after a lookup you will be doing some sort of a
> > > dereference on the RCU pointer.  That would cause exactly the same
> > > splat that rhltable_lookup itself generated.
> > > 
> > > For example, rhl_for_each_entry_rcu should have created the same
> > > warning, but it doesn't because for some reason it is using
> > > rcu_dereference_raw.  I'll need to dig up the history of this
> > > to see if there is a good reason for it to not warn.
> > 
> > Yeah, I understand what you mean. I noticed this, and that's why
> > I added the rcu_read_lock() for rhashtable_lookup() only.
> > 
> > Maybe it is to obtain better performance? Just guess ;)
> > And hlist_for_each_entry_rcu() also uses rcu_dereference_raw().
> 
> Hi Menglong, if you update the patch to use guard(rcu)() because
> head is used repeatedly in fprobe_entry(), I can replace it.

Of course, with pleasure. I can send a new version of this
patch with guard(rcu)() instead.

> 
> Thank you,
> 
> > 
> > Thanks!
> > Menglong Dong
> > > 
> > > Cheers,
> > > -- 
> > > Email: Herbert Xu <herbert@gondor.apana.org.au>
> > > Home Page: http://gondor.apana.org.au/~herbert/
> > > PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> > > 
> > 
> > 
> > 
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 





