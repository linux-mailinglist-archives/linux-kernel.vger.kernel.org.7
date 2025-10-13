Return-Path: <linux-kernel+bounces-850410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C68BD2B88
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E1624F0EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A003D26A1CC;
	Mon, 13 Oct 2025 11:05:44 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC43212572
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760353544; cv=none; b=YDRgt6BQN11gW+Ebu+vNYn1bDPSdvlqXJn3lOg0t70bmr9so4bjstC536M6Sk5PQXDoRSVljFquAmL+VChOpnvsDuSriKzYaKpnPavQ6/8nVxBTPkRu4rHULpnk7IY7gnw4+RBK2MuNJVbtEs6wQhUFbY5lOqU0HxGfZDhYFsWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760353544; c=relaxed/simple;
	bh=2VR10E5wmg+4Yys6nHjV3FIVrHeBrYXrjEeeXKow4Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwP7JPN6wzBEyYsrhnUgmRjv240DZqzsiPzf/GUaq5ljdJUWTOFj+WAQD+lnimqswerJ39FN66WR3TKQ8K1alKlYAndsMfWts6zENM11KVcGsTSfusNgWb4hA/WF4qKxhX0HxdBFHxw4fqx1+gjtNUhhWoSnfvgf2ywHlI6HbHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-639df8d869fso7651591a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760353540; x=1760958340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmLqeppxe73hh13JxtM2ixOg3mr3dSJTkeBYNyqFybw=;
        b=bwWSsOaM+wMBgqDvCFnfMz5A2cwuTWxr6H50KGSG9p5fWQPdXAwS8/sVler/thZCjX
         sP8J2GkAMk58IuGLg5x9n7vuk2aWPB7ORgrGQwirWT3Mt3fsOnF6lIdz/J6djixT8fkz
         KpdcyOQm9S6TQpPfjEV75pk07ZioK6Mhq3Oa4PWYLKs/pTqrucOGuoWG0Q/c6VSSSs1E
         YuEAp/YY9R/0qJZIMxSZfBdQk+uuOFAakuaZS44AjMpDknkHDnxvWfEGf9JLhiRfiQxH
         pYusi++Zy2zJSHMjcbNT87FHy/qLK+2M39cyQIEEr1nRU9rXtoaWygHk+O6CZsU6R4Wa
         6iNw==
X-Forwarded-Encrypted: i=1; AJvYcCW+H/oZx7LEXsE6ItKUb4PKwSoc08/3FEKW1WhS+QLRuJKHTXG+b7pq/8/U/i/Avzi4CwrggRCsvabff88=@vger.kernel.org
X-Gm-Message-State: AOJu0YydZBpMZ6rEwrzSDFrOh+RoA3d7DduXXOFx5juZBnsotEG3dV60
	BqMcOYNEuV9i5Za7eusnxbEJ56H82+CrmieAwK51kmO2H0C3yUuXDlId
X-Gm-Gg: ASbGnctIrfFzsnO6s5eKZDo1CWj+Fc5/msk1IyIP8Z1jE712oloRrQpaPU3oo2VAFq9
	otZXqeL2YA8JMd8d8mNSdkga7bQcaoTlwmNZhqqxfAXLFpoHcSjlRVTTajuBv/rk9LPas8ppJJM
	L9lkppjkebMTGgSkwjQJTA41Rre3SBt7IfVogHgZvghH2s4zVRQ5T6uyagdgvY1k0a018EFzZGw
	zxJ9uNaOZlPwYG74PkwLCzTPSwjq2VmLlYckLNVRo32KyAdFB2sJfMKSUkBZhMGugxvqmNNOvsH
	GxMOqaPTXFRI0X6F0cVM8Q5S9jbI7I/aJi1ezi7ExsJlljHuwi6gTL030TVlxHDMY/uUA5Tko48
	FeyTUxKSZbcF43+Y+oiepMsdUI6TMlhxZVCE=
X-Google-Smtp-Source: AGHT+IGfjpsttXQ6mVNBCI+WQJkc+SoRWJBewz2mUjprO6UzkXnxv8IdBN8hGF8N7hiFPxEeQBzZ/g==
X-Received: by 2002:a05:6402:40cd:b0:639:dbe7:37c1 with SMTP id 4fb4d7f45d1cf-639dbe73c81mr18605916a12.15.1760353539497;
        Mon, 13 Oct 2025 04:05:39 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c132b68sm8775862a12.31.2025.10.13.04.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 04:05:39 -0700 (PDT)
Date: Mon, 13 Oct 2025 04:05:36 -0700
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, gustavold@gmail.com
Subject: Re: [PATCH net] netpoll: Fix deadlock caused by memory allocation
 under spinlock
Message-ID: <rozn3jx2kbtlpcfvymykyqp2wapqw3jp4wkv6ehrzfqynokr7z@eij4fqog2ldu>
References: <20251013-fix_netpoll_aa-v1-1-94a1091f92f0@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-fix_netpoll_aa-v1-1-94a1091f92f0@debian.org>

On Mon, Oct 13, 2025 at 02:42:29AM -0700, Breno Leitao wrote:
> Fix a AA deadlock in refill_skbs() where memory allocation while holding
> skb_pool->lock can trigger a recursive lock acquisition attempt.
> 
> The deadlock scenario occurs when the system is under severe memory
> pressure:
> 
> 1. refill_skbs() acquires skb_pool->lock (spinlock)
> 2. alloc_skb() is called while holding the lock
> 3. Memory allocator fails and calls slab_out_of_memory()
> 4. This triggers printk() for the OOM warning
> 5. The console output path calls netpoll_send_udp()
> 6. netpoll_send_udp() attempts to acquire the same skb_pool->lock
> 7. Deadlock: the lock is already held by the same CPU
> 
> Call stack:
>   refill_skbs()
>     spin_lock_irqsave(&skb_pool->lock)    <- lock acquired
>     __alloc_skb()
>       kmem_cache_alloc_node_noprof()
>         slab_out_of_memory()
>           printk()
>             console_flush_all()
>               netpoll_send_udp()
>                 skb_dequeue()
>                   spin_lock_irqsave()     <- deadlock attempt
> 
> Refactor refill_skbs() to never allocate memory while holding
> the spinlock.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
> ---
>  net/core/netpoll.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index 60a05d3b7c249..788cec4d527f8 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -232,14 +232,26 @@ static void refill_skbs(struct netpoll *np)
>  
>  	skb_pool = &np->skb_pool;
>  
> -	spin_lock_irqsave(&skb_pool->lock, flags);
> -	while (skb_pool->qlen < MAX_SKBS) {
> +	while (1) {
> +		spin_lock_irqsave(&skb_pool->lock, flags);
> +		if (skb_pool->qlen >= MAX_SKBS)
> +			goto unlock;
> +		spin_unlock_irqrestore(&skb_pool->lock, flags);
> +
>  		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
>  		if (!skb)
> -			break;
> +			return;
>  
> +		spin_lock_irqsave(&skb_pool->lock, flags);
> +		if (skb_pool->qlen >= MAX_SKBS)
> +			/* Discard if len got increased (TOCTOU) */
> +			goto discard;
>  		__skb_queue_tail(skb_pool, skb);
> +		spin_unlock_irqrestore(&skb_pool->lock, flags);
>  	}

We probably want to return in here, as pointed out by Rik van Riel
offline.

If there are no more concerns, I will wait the 24-hours period and send
a v2.

