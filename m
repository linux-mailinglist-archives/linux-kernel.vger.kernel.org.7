Return-Path: <linux-kernel+bounces-799961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB9FB431AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2663F179189
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0A9241691;
	Thu,  4 Sep 2025 05:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MrSAEhHD"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E49523B627
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 05:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756964538; cv=none; b=iK89vZOSdxtUK2TdtfsAUvEPylj3RDRUcnwPfAMiYB2R6h5lkfx10eJ4NJcoBaQKFmXIBZYNNjUsiafJxoOqhD/hBJ9f2LIHM5qCy+pRohtduJtOmK49SUvkRiwfEyiyf2WCnUsrA8Oi/vUwGaxmt2NgTNxx4gLhCLSAgLEjiYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756964538; c=relaxed/simple;
	bh=mxaAxLdqym0aU0OLskWjVxIuJX2pO4OCsbFtsTFLA6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXldXUZAphQk6ZH2yKefUNsZDkMiXqKBMfBOIBOwGLkEULx1HPh9ntXX/jyJ/adA40o2wognrPch/pwnKkQDFiLd+tUoDNJcktT0kqkh56pImVRv3AvPmwKpguC/ZGltxyynW/zc1DqUtp6glWMldTtoRAmOg2rrxoMbV4ZVZ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MrSAEhHD; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756964520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZ9WpLyDZWHxfeHjyP6sYS5cY+4GZWxfFInGCGxfKuI=;
	b=MrSAEhHDT52qqerPvVxLJ/LJEw7YOijKP7CIbohpwGwsXykg1vsKT0rafTt9TMIvnIOL1S
	hzn9k+rHL+lowucqj0NmLwswqS3Dh6WSqi4h6HoPvj2IorbiqyFgI/5BWarSuMhhW40EY6
	IPfmuOPAu2Zxgrk5ZS4Vwi/ep8qm4To=
From: menglong.dong@linux.dev
To: Herbert Xu <herbert@gondor.apana.org.au>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 oliver.sang@intel.com
Subject: Re: [PATCH] tracing: fprobe: fix suspicious rcu usage in fprobe_entry
Date: Thu, 04 Sep 2025 13:41:56 +0800
Message-ID: <10717536.nUPlyArG6x@7940hx>
In-Reply-To: <20250902105757.16a78aea@batman.local.home>
References:
 <20250829021436.19982-1-dongml2@chinatelecom.cn>
 <aLa2D4It1Zxc7bs0@gondor.apana.org.au>
 <20250902105757.16a78aea@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/9/2 22:57 Steven Rostedt <rostedt@goodmis.org> write:
> On Tue, 2 Sep 2025 17:17:03 +0800
> Herbert Xu <herbert@gondor.apana.org.au> wrote:
> 
> > Menglong Dong <dongml2@chinatelecom.cn> wrote:
> > >
> > > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > > index fb127fa95f21..fece0f849c1c 100644
> > > --- a/kernel/trace/fprobe.c
> > > +++ b/kernel/trace/fprobe.c
> > > @@ -269,7 +269,9 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> > >        if (WARN_ON_ONCE(!fregs))
> > >                return 0;
> > > 
> > > +       rcu_read_lock();
> > >        head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
> > > +       rcu_read_unlock();
> > >        reserved_words = 0;
> > >        rhl_for_each_entry_rcu(node, pos, head, hlist) {
> > >                if (node->addr != func)  
> > 
> > Actually this isn't quite right.  I know that it is a false-positive
> > so that it's actually safe, but if you're going to mark it with
> > rcu_read_lock, it should cover both the lookup as well as the
> > dereference which happens in the loop rhl_for_each_entry_rcu.
> > 
> 
> I disagree. It's a false positive as RCU is actually enabled here
> because preemption is disabled. Now we are spreading the internals of
> rhltable into the fprobe code.
> 
> We should just wrap it as is with a comment saying that currently RCU
> checking doesn't have a good way to know preemption is disabled in all
> config settings.
> 
> That is, I don't want rcu disabled here where people will think it's
> actually needed when it isn't. Wrapping the call with rcu_read_lock()
> with a comment that says it's to quiet a false positive is enough, as
> then we are not misrepresenting the code.
> 
> Maybe instead have:
> 
> /*
>  * fprobes calls rhltable_lookup() from a preempt_disabled location.
>  * This is equivalent to rcu_read_lock(). But rcu_deferefernce_check()
>  * will trigger a false positive when PREEMPT_COUNT is not defined.
>  * Quiet the check.
>  */
> #ifndef CONFIG_PREEMPT_COUNT
> # define quiet_rcu_lock_check() rcu_read_lock()
> # define quiet_rcu_unlock_check() rcu_read_unlock()
> #else
> # define quiet_rcu_lock_check()
> # define_quiet_rcu_unlock_check()
> #endif
> 
> And then have:
> 
>        quiet_rcu_read_lock_check();
>        head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
>        quiet_rcu_read_unlock_check();

That's a good idea. But I think it doesn't work for PREEMPT_COUNT
case, unless we do some modification to
rcu_read_lock_held()/rcu_read_lock_held_common().

I'm not sure if is it possible to define them as:

# define quiet_rcu_lock_check() rcu_lock_acquire(&rcu_lock_map)
# define quiet_rcu_unlock_check() rcu_lock_release(&rcu_lock_map)

Thanks!
Menglong
> 
> -- Steve
> 
> 





