Return-Path: <linux-kernel+bounces-853073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5558BDA957
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A026352E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007643019CA;
	Tue, 14 Oct 2025 16:13:26 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D526B2C17B3
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458405; cv=none; b=hpxq7e8fMM01FYBiLtN6CvNd7nMv6s2g2gHxgBw2yMiEPZ0MatqpWXtN2nM5dKTAcOC9Pjk6xtDLEDKnw+NQRWzNTvGzt5/jJTUBqa2IIlMaBhSh5Nr8B0Cfr3KAQTMt63UYGfChGtPOW0Ugy8zFWx9VDvkuvRk0MTcmWuoBLUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458405; c=relaxed/simple;
	bh=IpYLzozxxWXdKbnKBRbJDIidyOlsjMCeODX5hcLA5wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcYZPKOqZqJgJCO1Fn4vy17ZUDgMlKl8NMfmZ5MRPAwc+x/Y7wozwhN4p1t6tn366dnJy1YLeFjGR8N0izxY/FiFIZo5tqE0yQm2z+R/4t5zZbbIj8XaibWA8Mmy/R+tkR82pPpiH4F83CURLqMz8cZc4p6+Uyi1uo0xrYI8AIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63be5c739cdso656648a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760458401; x=1761063201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//02jhzybzRTsAQwMmWpsv3xhS89bxRH7c2a1Fq5ApA=;
        b=R4biXl3A+6x4x3RQ2jy0It64RAXT1GKi4AW5KN9hZ9omUuSPbOVfKhrh2UKrxa/sF3
         y5imJGKBWogyO1iRbzmxisVW9e7mycgbuPYona6Qwqkf+P3XE5pE2VirxYvo3q/v3f0B
         Iw95Xkb7MqnDH7OdvVEKdNiCanVSX618qv15aphcDyNe57jv6CQ9VezNRrRQsoomxQSK
         1W+vbpj71sO7OngFEJsJ43Y5OP9oaG1/yP6PWLRgaKK/5qvuoPkbUvCWAFLSmQErIGN3
         AidvYk6eBRyUQeLK2LApDNd8oANHiM275NvmOdsnTVszBimXQo5Yxfa5XsSQEr1bBQ7f
         07cA==
X-Forwarded-Encrypted: i=1; AJvYcCVgvr9b1qOjJ0gDL1TQx37PR/LUU9mEn77ZsiRhnXs0r4eBMEJzVPZvXxl9/HG64yT1zNRscB2aXoJXzCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp4UpwUFuFeyZwEM/ujRVr7ytNpf0kjZkAb0PTz3as78Kl3WXV
	55MEdR8/KPt7VDkkycJZStIQcTy5BfpF6cggUZmZ3F80debfKmetv5RH
X-Gm-Gg: ASbGncs5q9RjxhVusjcO9gBDJlXvntTz7MkZnWRHuBncNKHaFKVdS8FbQDXIvi/Xhhx
	8bdhSr5no92qH5nh2tzuvpqxA+VP0pfGA+nI4HIkURZFg0gTI/ljt68pLfpk81pdwvOezUiuvfb
	SLR0np6toe6DHBSKRCJOxMnTgyhPuJibMPS1WlZQtzdzZibbNrASyqeWwydrhbPD7fBdTi7LLlL
	bI7CHz2JXK0gjnhuDmJklGXC3/sYXwJ2WhDidGw0cAKnpF4M4+qRecRX4Y2leVhFM14xaXorMNS
	tVhKaqf5KbgszF/Tc0re2QXLhx1RB0WRaB57EpGvjWPx0fDQumwUOQIAFlmlogA500mi5v11JTE
	udd4E0DeHmBJ6iRv10ZLFLDoISsHBUuL1QWc=
X-Google-Smtp-Source: AGHT+IGhu0gykfSr0z1wu2B7v62jrwI1vVub/7qRRjCr3AoBJQe1ZVnEw6PtLOxEN5FHwzaoj867DQ==
X-Received: by 2002:a05:6402:278b:b0:63b:dc7d:72f2 with SMTP id 4fb4d7f45d1cf-63bdc7d7e38mr1695096a12.19.1760458401023;
        Tue, 14 Oct 2025 09:13:21 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f39esm11314435a12.11.2025.10.14.09.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 09:13:20 -0700 (PDT)
Date: Tue, 14 Oct 2025 09:13:18 -0700
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	usamaarif642@gmail.com, riel@surriel.com, kernel-team@meta.com
Subject: Re: [PATCH net v2] netpoll: Fix deadlock in memory allocation under
 spinlock
Message-ID: <53jkbptcchxc2sxho56rrj7bcwizpd536bsox45hw75uk2fydg@k33edbzrjdvr>
References: <20251014-fix_netpoll_aa-v2-1-dafa6a378649@debian.org>
 <aO5aJ9dN5xIIdmNE@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO5aJ9dN5xIIdmNE@horms.kernel.org>

On Tue, Oct 14, 2025 at 03:11:51PM +0100, Simon Horman wrote:
> On Tue, Oct 14, 2025 at 03:10:51AM -0700, Breno Leitao wrote:
> > Fix a AA deadlock in refill_skbs() where memory allocation while holding
> > skb_pool->lock can trigger a recursive lock acquisition attempt.
> > 
> > The deadlock scenario occurs when the system is under severe memory
> > pressure:
> > 
> > 1. refill_skbs() acquires skb_pool->lock (spinlock)
> > 2. alloc_skb() is called while holding the lock
> > 3. Memory allocator fails and calls slab_out_of_memory()
> > 4. This triggers printk() for the OOM warning
> > 5. The console output path calls netpoll_send_udp()
> > 6. netpoll_send_udp() attempts to acquire the same skb_pool->lock
> > 7. Deadlock: the lock is already held by the same CPU
> > 
> > Call stack:
> >   refill_skbs()
> >     spin_lock_irqsave(&skb_pool->lock)    <- lock acquired
> >     __alloc_skb()
> >       kmem_cache_alloc_node_noprof()
> >         slab_out_of_memory()
> >           printk()
> >             console_flush_all()
> >               netpoll_send_udp()
> >                 skb_dequeue()
> >                   spin_lock_irqsave(&skb_pool->lock)     <- deadlock attempt
> > 
> > This bug was exposed by commit 248f6571fd4c51 ("netpoll: Optimize skb
> > refilling on critical path") which removed refill_skbs() from the
> > critical path (where nested printk was being deferred), letting nested
> > printk being calld form inside refill_skbs()
> > 
> > Refactor refill_skbs() to never allocate memory while holding
> > the spinlock.
> > 
> > Another possible solution to fix this problem is protecting the
> > refill_skbs() from nested printks, basically calling
> > printk_deferred_{enter,exit}() in refill_skbs(), then, any nested
> > pr_warn() would be deferred.
> > 
> > I prefer tthis approach, given I _think_ it might be a good idea to move
> > the alloc_skb() from GFP_ATOMIC to GFP_KERNEL in the future, so, having
> > the alloc_skb() outside of the lock will be necessary step.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Fixes: 248f6571fd4c51 ("netpoll: Optimize skb refilling on critical path")
> > ---
> > Changes in v2:
> > - Added a return after the successful path (Rik van Riel)
> > - Changed the Fixes tag to point to the commit that exposed the problem.
> > - Link to v1: https://lore.kernel.org/r/20251013-fix_netpoll_aa-v1-1-94a1091f92f0@debian.org
> > ---
> >  net/core/netpoll.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> > index 60a05d3b7c249..c19dada9283ce 100644
> > --- a/net/core/netpoll.c
> > +++ b/net/core/netpoll.c
> > @@ -232,14 +232,28 @@ static void refill_skbs(struct netpoll *np)
> >  
> >  	skb_pool = &np->skb_pool;
> >  
> > -	spin_lock_irqsave(&skb_pool->lock, flags);
> > -	while (skb_pool->qlen < MAX_SKBS) {
> > +	while (1) {
> > +		spin_lock_irqsave(&skb_pool->lock, flags);
> > +		if (skb_pool->qlen >= MAX_SKBS)
> > +			goto unlock;
> > +		spin_unlock_irqrestore(&skb_pool->lock, flags);
> > +
> >  		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
> >  		if (!skb)
> > -			break;
> > +			return;
> >  
> > +		spin_lock_irqsave(&skb_pool->lock, flags);
> > +		if (skb_pool->qlen >= MAX_SKBS)
> > +			/* Discard if len got increased (TOCTOU) */
> > +			goto discard;
> >  		__skb_queue_tail(skb_pool, skb);
> > +		spin_unlock_irqrestore(&skb_pool->lock, flags);
> >  	}
> > +
> > +	return;
> 
> Maybe it is worth leaving alone for clarity.
> And certainly it does no harm.
> But the line above is never reached.

Thanks for the catch. I will remove it since it is useless and respin.

