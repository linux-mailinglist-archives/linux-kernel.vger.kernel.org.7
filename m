Return-Path: <linux-kernel+bounces-841023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3502ABB5FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 08:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6DFB19E59D2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 06:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506711FECAB;
	Fri,  3 Oct 2025 06:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HwRd5rGG"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF1B1E7C19
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759473011; cv=none; b=c+kbBET6Mby1J/4UEcRh5xhUBU+ow2N/6dDcx0STYxXMZ/zaL/vnD6yuNEgLJQowNz7SItcvC750sARp2uo4OZNJB+TGqDBWLEwYuytRk1wSjJ2wHbIPWLpyNadlPM8XT1iA91b18vx9PFB/IPyDF0GUbKwDp78fxTvg7pLHaNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759473011; c=relaxed/simple;
	bh=J5hyQtasdpeeYSX5uUTCjqcrxsgBRfn6Zur7d/+DBiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFdGYQOqa+vpT0DYQFnhBp8nD7J9VBgxJKrzX84KE55+aKReJ5lcPUcOW3YggTYs/0oi0Y4RogTltEs5Y+egCUyXTPnPN0Fs4W2KGrlAq+NE28AiK7egy+uq6FnleYFyzr2NDMpZkCaeiDwL1jhhb41R5dvZKPPmn9BOiubn6Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HwRd5rGG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62ecd3c21d3so3350861a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 23:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759473007; x=1760077807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XkLFiACyw+pxXQ9Sqz5bYmdEFhy/428iFAOlJwo0q5k=;
        b=HwRd5rGGJ2tAhRGDqCHKI/U+jtu++m8Ylwbe9r5GuA+tVPFfPBsaD67N9JgTcfe5af
         ED9z0ZCCpvVOIP/j1Oq73a8OiC81230kpBBdzbzzYhbuQYlft40UPdpzjRc8zAaNyvfd
         A1g6Xv0RV0I+o2xjmRsebOjh6HFwr+l9VxPdAKp8FI+ZF0f4ePMr4oHdCeW4eqlMR6y+
         3l3oait4JHEnzajuktlPH/QSr0qaBtjIWcWV2BRTs9HyvOCox/9DmGximo+NDUpjv39n
         tX+MBMAWiTkwAJ1Ot9XQbqraeDlCkjf/fyCXsEBZ0d5cgVgru5JPtrgvxfGPOEKTaUCN
         MHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759473007; x=1760077807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkLFiACyw+pxXQ9Sqz5bYmdEFhy/428iFAOlJwo0q5k=;
        b=L3zg7ZlDHcZvzB4AtrO/DfImES0uLKQuD/aJDDd9ojAikktpaLyo4Kwc6J7h+NtihD
         FqD8satsHXLqAMmUyve6thA/hw10HvDxWiBdqcQ3JWPM7LqKQ3muyIrzBG6MMuRAo0OC
         DZREJRIhN2rLrte7vRyOYdavZ7CGqmVpV5BpCUUR3A/TcB1NB74lQDvghCE8zxeG+3pI
         twQJ2kDEUxUdRXv9yT0UcA7rZ9adnHTnP9tfXR2lb64RJYbPFMhI7Ll2WX/ozl4p7/vt
         uXMrZHDLbXKgHE7UEZOCFzlu8DtfKZ8d6p3E7Fk8PfBEfPgxi2dbQRCa2zVsydeNjFxq
         5FMA==
X-Forwarded-Encrypted: i=1; AJvYcCVEQAfS1DNWe0EvRff0itURk915/cOPYGkiO4crXSecK5I3/EsuochfUdEYmwyoht/dqzdLFxs14zpCpxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNRWinsK+3wKxjZtBzQSD7IzB3BX6fN0RRo2KC/NPYWpCkxQrA
	dkciyxBtcKvzcolzx0LVfxsiT2sF4LIba+7W52Duc8KN2uusOG7TeVT764ay14kf2ik=
X-Gm-Gg: ASbGncvMIOvDtQYzMR0mpopZ9MSVEw+/o0hCiUFEHUwUdjYBGjoVBDPAfswRhnpKnaB
	ZQanlZVt3dU4qIfAbK5Rwt93ynG5Ir+xY1lOYfj2x+uD/ZJxjb0IQcQM6eBucqPeF/Uc2lStEiv
	qOUNsYu86Sda9G71+LdesQP7N7bF6mcnjNx8m9XCTHqCcYf8ZwSvVySlNn1UDZyz1Ao4dqeV6U0
	cZv+2pOaTrEfV3z114lM3HlWva7QXOqlVgqPeTHG6KmNVeOMNWunkEM+jB82RVDLuCpT6aFNyTt
	1tloqqCsQ9qFhItvrZyq0eGyGdUC24oBO9mgd6aJ6Z+q3TGtHpO6emt4iSW6pltF3+Pf9CMUBaj
	FdHfLKvIJaCWVQl73PJwocG70lvmOCJjKG2Pj8iJm+GKAG8csGhG/sNPf5y/2
X-Google-Smtp-Source: AGHT+IGXX832rzQ3SHMm9cxe/AbXuwPv3O0q1qi/7SX7y0yjjhFdzCNvPBXopZojYDFGU05IQJ2DLQ==
X-Received: by 2002:a17:907:3e93:b0:b04:6fc2:ebb9 with SMTP id a640c23a62f3a-b49c393aa02mr220162166b.45.1759473007029;
        Thu, 02 Oct 2025 23:30:07 -0700 (PDT)
Received: from localhost (109-81-95-234.rct.o2.cz. [109.81.95.234])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b4869c4c1f6sm365114166b.78.2025.10.02.23.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 23:30:06 -0700 (PDT)
Date: Fri, 3 Oct 2025 08:30:05 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 10/10] mm: kvmalloc: Add non-blocking support for
 vmalloc
Message-ID: <aN9tbS3RkEqm2tzP@tiehlicka>
References: <20251001192647.195204-1-urezki@gmail.com>
 <20251001192647.195204-11-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001192647.195204-11-urezki@gmail.com>

On Wed 01-10-25 21:26:46, Uladzislau Rezki wrote:
> Extend __kvmalloc_node_noprof() to handle non-blocking GFP flags
> (GFP_NOWAIT and GFP_ATOMIC). Previously such flags were rejected,
> returning NULL. With this change:
> 
> - kvmalloc() can fall back to vmalloc() if non-blocking contexts;
> - for non-blocking allocations the VM_ALLOW_HUGE_VMAP option is
>   disabled, since the huge mapping path still contains might_sleep();
> - documentation update to reflect that GFP_NOWAIT and GFP_ATOMIC
>   are now supported.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/slub.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 584a5ff1828b..3de0719e24e9 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -7018,7 +7018,7 @@ static gfp_t kmalloc_gfp_adjust(gfp_t flags, size_t size)
>   * Uses kmalloc to get the memory but if the allocation fails then falls back
>   * to the vmalloc allocator. Use kvfree for freeing the memory.
>   *
> - * GFP_NOWAIT and GFP_ATOMIC are not supported, neither is the __GFP_NORETRY modifier.
> + * GFP_NOWAIT and GFP_ATOMIC are supported, the __GFP_NORETRY modifier is not.
>   * __GFP_RETRY_MAYFAIL is supported, and it should be used only if kmalloc is
>   * preferable to the vmalloc fallback, due to visible performance drawbacks.
>   *
> @@ -7027,6 +7027,7 @@ static gfp_t kmalloc_gfp_adjust(gfp_t flags, size_t size)
>  void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), unsigned long align,
>  			     gfp_t flags, int node)
>  {
> +	bool allow_block;
>  	void *ret;
>  
>  	/*
> @@ -7039,16 +7040,22 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), unsigned long align,
>  	if (ret || size <= PAGE_SIZE)
>  		return ret;
>  
> -	/* non-sleeping allocations are not supported by vmalloc */
> -	if (!gfpflags_allow_blocking(flags))
> -		return NULL;
> -
>  	/* Don't even allow crazy sizes */
>  	if (unlikely(size > INT_MAX)) {
>  		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
>  		return NULL;
>  	}
>  
> +	/*
> +	 * For non-blocking the VM_ALLOW_HUGE_VMAP is not used
> +	 * because the huge-mapping path in vmalloc contains at
> +	 * least one might_sleep() call.
> +	 *
> +	 * TODO: Revise huge-mapping path to support non-blocking
> +	 * flags.
> +	 */
> +	allow_block = gfpflags_allow_blocking(flags);
> +
>  	/*
>  	 * kvmalloc() can always use VM_ALLOW_HUGE_VMAP,
>  	 * since the callers already cannot assume anything
> @@ -7056,7 +7063,7 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), unsigned long align,
>  	 * protection games.
>  	 */
>  	return __vmalloc_node_range_noprof(size, align, VMALLOC_START, VMALLOC_END,
> -			flags, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
> +			flags, PAGE_KERNEL, allow_block ? VM_ALLOW_HUGE_VMAP:0,
>  			node, __builtin_return_address(0));
>  }
>  EXPORT_SYMBOL(__kvmalloc_node_noprof);
> -- 
> 2.47.3

-- 
Michal Hocko
SUSE Labs

