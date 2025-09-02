Return-Path: <linux-kernel+bounces-796043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E9FB3FB4B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09AB4E328F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620772F0666;
	Tue,  2 Sep 2025 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NthiP3ZI"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5232EE26F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806652; cv=none; b=VmxIYIhRCo954s1RQp5dKM8g2592WoCQPCPA4MXhMLlVpuvyS/03vUg0GGYedT2UVGy4TStLOnuo/R3JTrfEcKDGk3H0ycGvfzFcOmJIbYEGQn+xK0ZrixE1+KhzWHRN6LzPw/c2B5DE3Qb8X4SiHsquTJb5zW2zLQVsg+VbkFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806652; c=relaxed/simple;
	bh=163G7NBdzqRIPtQG4d3ilwcmwlPRh8/kiwuM9ySu38A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iv9AiayDe5La+b1lKeuXv6awjErcgrdjteauyFCyYBFuxbetyzSdllPJ06KWxRgS4rlp9pxZw9T2SQSHxl27GwCylZSnceRkNXyxvxrBUuEojQQgAwfTNXBJfYT/Xo1/1uGdK3PHEJkn5WMD7E0+wDSGA0zQJWVbjk1sdUWx8Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NthiP3ZI; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756806638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SdPs7YnNzYXwBnxMTAdg8ahsnKcBqqdQyzBDOBssAU=;
	b=NthiP3ZIVAXlk9mD7ngIFOyN2w4/wQyfgmMBCW5ewtH4ouXHfxEEgnYyjQBO+cJ2ox8FH4
	QHftcUgY7cE71r0IrgFzhDePBVz0vizJH4nZAv/PgTDcqPzIqBBiMHL7ZysltTvki9MRhZ
	rRzmQCBZvAXvWJ8IlMSKDrb9HbTOy20=
From: menglong.dong@linux.dev
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: mhiramat@kernel.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 oliver.sang@intel.com
Subject: Re: [PATCH] tracing: fprobe: fix suspicious rcu usage in fprobe_entry
Date: Tue, 02 Sep 2025 17:50:32 +0800
Message-ID: <3005966.e9J7NaK4W3@7940hx>
In-Reply-To: <aLa2D4It1Zxc7bs0@gondor.apana.org.au>
References: <aLa2D4It1Zxc7bs0@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/9/2 17:17 Herbert Xu <herbert@gondor.apana.org.au> write:
> Menglong Dong <dongml2@chinatelecom.cn> wrote:
> >
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index fb127fa95f21..fece0f849c1c 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -269,7 +269,9 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> >        if (WARN_ON_ONCE(!fregs))
> >                return 0;
> > 
> > +       rcu_read_lock();
> >        head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
> > +       rcu_read_unlock();
> >        reserved_words = 0;
> >        rhl_for_each_entry_rcu(node, pos, head, hlist) {
> >                if (node->addr != func)
> 
> Actually this isn't quite right.  I know that it is a false-positive
> so that it's actually safe, but if you're going to mark it with
> rcu_read_lock, it should cover both the lookup as well as the
> dereference which happens in the loop rhl_for_each_entry_rcu.

Yeah, I understand. The rcu_read_lock() here is totally used to
suppress the suspicious rcu usage warning, not for the protection.
So I used it just for the rhltable_lookup() to reduce the impact.
Maybe I should add some comment for it.

This is the easiest way to suppress the warning, but not the  best,
as it can introduce addition overhead when PREEMPT is enabled.

As Masami said, maybe we can use guard(rcu)() here to obtain
better code readability.

It seems that it's hard to think of a way to suppress the warning
without holding the rcu_read_lock :/

Thanks!
Menglong Dong

> 
> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> 
> 





