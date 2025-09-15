Return-Path: <linux-kernel+bounces-817525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FCCB5833A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5A94C10EC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AE5279DBA;
	Mon, 15 Sep 2025 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="deHILfHK"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE34114B953
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956615; cv=none; b=Z4CTJrY7F9xSFZMERzha08aWY0+3SAbv4YJAZrQGyP/uy8tdyq6AY/b5gDAV/LHYqEhtNXL7LCpxFCw9cHVv+8JdWu/jJqsyY6TeI1apBCkHmRZTu4TBByMv0BFCusD2BX3Wpm3ftyKGqY/htmSuuod8TWZ1GHNii06qQkLqS7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956615; c=relaxed/simple;
	bh=amYEjA7j5L6NYjX79sOlpn+GcaYsvJn8lKj7SwqWSLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiLEvNIXA4pC5TQNA5W5Et//jiJcojYIG04Li71ufHzakZ9xLAjjkCd+4csVZYaq70LEQcnq9cjLiaHxCzZQ2J+IYo9nHzDQd0eChJ36a7VBqdnzYIerIucPBHU/sfNpoLZuoC/aCatBsBdOE/4UhK8gxKK2849IGKxUd2D1yf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=deHILfHK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b042cc3954fso817083266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757956612; x=1758561412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RAiJK2ZmQHbf+XsggTwiJACjPN/xnPzz5AX7w8mTZs8=;
        b=deHILfHK9PKnDLy5Q9l79KxLYTxgrbASZCbRF8bXBltG+gckNAK9VnbiDl4tfU0wKS
         CqUck7PxG3T4ZudZ6sDff4QAwyBoJAFZEkVgKiOG2m6TJZVLsMpn0Xn5wjTyB1aA9hre
         rbxp5oBz9MrEPdhHaN+U5sCQlAIzcWYSaHNAuixbJs6tlkD0AlqY49e7dVJyI3dZal8y
         b66nJk//JJcgnfeuBLYQ+is8Ni6XNoVNUx5V+y0fbK7/vsZGMa33rdW5DkU5FDIhUGti
         PhbIXcPl0ZP3udsdd5YixKw8ryHwUjxgO+T2YZvn8TxsvZE+vh9GfIfn5RxFfOchp+XE
         Cgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757956612; x=1758561412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAiJK2ZmQHbf+XsggTwiJACjPN/xnPzz5AX7w8mTZs8=;
        b=Jxl8edxc4QjdTvIgXVzgWfpuj7Avn1pHVX9vhngumv+/HmIFMaSAU7Bzti4NETP3bH
         SV/AQ+/Gs/jP+fsIb9zzFm3JyLuPlyXS+EfdfSPp6XgArcjNNVGeLR0yhPt4HmGuAi0w
         MxK5yn+ADscrjk3egUXta/LnzCZELq0coYxJZTKG4Nmh0XBpUr2BFC8nM/UGgBfHCz7y
         b1X4TjCjlbO6gL/SzCFOLYzBgnfvxJVFaCC739VjFWnEBFnDajfFJiUvqFkT9x1xVlTw
         iZxhSHCqgqaJPFZCJmH97k1AauzClmTDpg5oqlptxrChwA60CRGHgjNcCVF397nGgoXt
         pKuA==
X-Forwarded-Encrypted: i=1; AJvYcCXUFIh58hLcbrj9MlwMH5cOkXQmoaS9sk7frp1oIdsC3nv26fc1+29IuscaNZxjcemyV6+EVZxGJ/UFcqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx985KQ3ujHD3CHhOBbuK287xrAbfZWm6EerwYl+Jt3GN7uPcRs
	uxxMYV5pM5hCe2gm0oO2UeluiHrX5HQwz629obA5xXhm9YphWSAABtdjIxx0bCahro4=
X-Gm-Gg: ASbGnct5MlpThEJRYAdCQKtQF6G341ZJ1MNE0qKl5Wf6KtVs8Ixw3sdnN0MSbefnWbz
	wj9Xz55rsBP8BTRfWwUYRlw2DHxavvdxHWO9TeXqZjzxN+l1d2tTW5zlRqwHaIYULgpoICb1i2Z
	gTx0yrQ5/gWcRm5+dp7fap3ZDkTbzjMeJCeKtnaMp+Eufzcy2/D981rV99r4nSo6VxT07fH7/LV
	7zdIWxzeQR+cTUsVM0xLrogceIiXPIR3GjqLNTKIYRCMGjQDmjoS7zVTfy2YXQbGH4KxY0cRQFm
	nJ+vfXS41Kck+QmM6LRrF+VEEUoVEa7iMQb83N7gC+KMSPaR1Bo41VQ0Ehx74b9izLYdQNKRR4G
	aRS8D+CZ9QIbm+vI+zRYG0oD3OfpFydWgoQ==
X-Google-Smtp-Source: AGHT+IEPlhCgQvXW5ecZ05x3+ZOUWzRhnk1+vdpPKMe6IRBsIEOhPs7lQfUxpzPTmduP+XwEQYObNg==
X-Received: by 2002:a17:907:9301:b0:b0c:6cae:51b9 with SMTP id a640c23a62f3a-b0c6cae670fmr760718166b.45.1757956611928;
        Mon, 15 Sep 2025 10:16:51 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b3347b6fsm990538866b.111.2025.09.15.10.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 10:16:51 -0700 (PDT)
Date: Mon, 15 Sep 2025 19:16:50 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 09/10] mm: Skip might_alloc() warnings when
 PF_MEMALLOC is set
Message-ID: <aMhKAnO1MmkKHTO-@tiehlicka>
References: <20250915134041.151462-1-urezki@gmail.com>
 <20250915134041.151462-10-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915134041.151462-10-urezki@gmail.com>

On Mon 15-09-25 15:40:39, Uladzislau Rezki wrote:
> might_alloc() catches invalid blocking allocations in contexts
> where sleeping is not allowed.
> 
> However when PF_MEMALLOC is set, the page allocator already skips
> reclaim and other blocking paths. In such cases, a blocking gfp_mask
> does not actually lead to blocking, so triggering might_alloc() splats
> is misleading.
> 
> Adjust might_alloc() to skip warnings when the current task has
> PF_MEMALLOC set, matching the allocator's actual blocking behaviour.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

I would probably just bail out early for PF_MEMALLOC to not meddle with
might_sleep_if condition as it seems to read better but I do not insist.
Acked-by: Michal Hocko <mhocko@suse.com>
Thanks

> ---
>  include/linux/sched/mm.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 2201da0afecc..dc2d3cab32ef 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -318,7 +318,8 @@ static inline void might_alloc(gfp_t gfp_mask)
>  	fs_reclaim_acquire(gfp_mask);
>  	fs_reclaim_release(gfp_mask);
>  
> -	might_sleep_if(gfpflags_allow_blocking(gfp_mask));
> +	might_sleep_if(gfpflags_allow_blocking(gfp_mask) &&
> +		!(current->flags & PF_MEMALLOC));
>  }
>  
>  /**
> -- 
> 2.47.3

-- 
Michal Hocko
SUSE Labs

