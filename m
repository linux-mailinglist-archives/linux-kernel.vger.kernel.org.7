Return-Path: <linux-kernel+bounces-817514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6FDB58320
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318A54C5926
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B1828C864;
	Mon, 15 Sep 2025 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QEHipibq"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FBC28B7DA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956387; cv=none; b=dc5TvFG/j6ZauxWSSbUWpZD8RaZLAcFmmRMwC1fwR+NyHlgoW8TCwGNBkYOsczRfwnkCsDnSiONwfU4rf47sbPqu+GAW2v6oRl9ORu/KpRVw5RzThzIU6Ivzum7+mQTINqYn7Kg+gEeAlRD2XlPtW0UP3462/DFu4bzlTqxaqZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956387; c=relaxed/simple;
	bh=00uU5cHIc0RSBhg8yoRGPpKNYVU8JIBEr31vWeBgSuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+qabVo7+kZvtcZV1Aa7HGhj7WqIaSOKUdvvsc9MpOA87aG3yltyqgDFCLvWVGw2EVZJTZq1UupHSQN5jafAFPW41o6An4qNU5qQ8oMFqb1lZ2H87fm4rHtQDmAcZvIE/0xSMv3y3ci6fLcMVTxUFdAUnrlGL2cwvm7rIDWuTWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QEHipibq; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b0787fc3008so657572266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757956383; x=1758561183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+giZVYQQyDq7S6qiTsMees2qm3TEERs/CLhWSYHCPyI=;
        b=QEHipibqWRbAE4hqNOoiIdMgu4RNYngci54pe2CQxUV9yCGm4Rm83MlY8G8iN92++j
         wSPHngrGKwj1ZbPLoM/STNeKqbvsHcW2bUx86jWymQVKuc4k4DzajK99W7tqpzLz4dsa
         jFoO/+hoUL+kc2GsF1WANR6A6kXyV1BMiU2axf8zVHoYtB4zy3ZWXXuHynZBovsJW1Pd
         1haW/g2OcJy810Sv6PutF48t1+P6xBpWCjJ1F4EqpbUwTnPI6fmZF4KrCCvnb5Shxtox
         6UD5DzLyJMvxOeseim1OqIyWh1iredf9EI52FHbHn/YPFe9xxWGWgTAeJKErqvuMI+EG
         ovlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757956383; x=1758561183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+giZVYQQyDq7S6qiTsMees2qm3TEERs/CLhWSYHCPyI=;
        b=oSbWdho1s7cu8QIoobaPWTGolA1WkNY/OT4eFVQUWoQpeue071Fd293OV4DXIDaDfp
         LyilUeGIUla9Marju0Rmo4aUgdJYzS41Fp8G4iEmFukxOXn7Yo6Hk/41gT1WbZQUqhkG
         4riBr0QsTLqizMhmnYQBcquC6qIr4NaCTD4Gf0QqbjHEbjkg4s0wrElCeSqhiiB0FFGd
         aZihERv0RCRE/e7RQYy+FrMBCPAoOfr8rcA+iTM2W7OOhElAWim6jxkOaieSLj7RnHC2
         1bRmj9pP8ZHlkg5bluxG+gYZQQpbX0f6db+SjRir9f3ZI9QqREQnU4Itql78joE03tfx
         Gvxg==
X-Forwarded-Encrypted: i=1; AJvYcCUDVaRI7P/I10eA6wPSlPs8msMIeXRKyOH2LJy5eoi6jDYiY4BUEkCiUA5OwqLqFSJNG/DXWpHkZxhbEuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz17TpuepCWZkWKErVWfIhlJYcmdlZLzSAEkc7q12y+bIMSeQsn
	bc6pg9h1pjSqqEurW1jbZUTAWHP8RE6fIN/NpFh3mx+ylYHxhk6gigC8B5BMEWNRWA0=
X-Gm-Gg: ASbGncsGcP2x09qRRB078j3LQ5Wu/02xl6BodlbFy6lItWvDsPfoOacjiizui1T31Em
	BUPEQOXSM/jaIigngpUCxRuc8ebJuIHI/vhs+Vp0ZXAnfea4K90rh6L8MWWNJrRiQiUDPLyEz8t
	GSkmMEbyLKbmLX8+cM/rBbtpMqJ9WVbR29V11l1zng3WUAVLibI4TlUHNO3qiXyVSYlvpAgywfD
	a/OR9lQV/nxbWUKVma9mKRh6ERuwfD0P/7pjRy/1MZfo1o4fwwzGOCK9l3KUQNGCaHkYcBscG+V
	Y+zNUAeM9GnKGPKn2WrqsisZOj6kE0pB8meMArTk5Tm16fnhrl9KyrABDJufX9QKlLnJ4oxHqam
	IW3Br5NteP8Gdcukt1vJwHWRUDUx7OyiDV2vWBrDTfeNo
X-Google-Smtp-Source: AGHT+IEkYDkSIxnayNFM/ld2w5lh1jPOqBVqFdxEoRu8e2wrG86GBvZnI15upz7LkdeMAopd5zF0XQ==
X-Received: by 2002:a17:907:7fa3:b0:b04:6a58:560b with SMTP id a640c23a62f3a-b07c37fc95fmr1421811466b.39.1757956382708;
        Mon, 15 Sep 2025 10:13:02 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b3347a4fsm960439566b.103.2025.09.15.10.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 10:13:02 -0700 (PDT)
Date: Mon, 15 Sep 2025 19:13:01 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/10] mm/vmalloc: Update __vmalloc_node_range()
 documentation
Message-ID: <aMhJHUfr_PupSZSW@tiehlicka>
References: <20250915134041.151462-1-urezki@gmail.com>
 <20250915134041.151462-11-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915134041.151462-11-urezki@gmail.com>

On Mon 15-09-25 15:40:40, Uladzislau Rezki wrote:
> __vmalloc() function now supports non-blocking flags such as
> GFP_ATOMIC and GFP_NOWAIT. Update the documentation accordingly.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

I would just fold this into the patch which adds the support. We also
need kvmalloc doc update.
Anyway
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/vmalloc.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 2d4e22dd04f7..e56d576b46c8 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3880,19 +3880,20 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>   * @caller:		  caller's return address
>   *
>   * Allocate enough pages to cover @size from the page level
> - * allocator with @gfp_mask flags. Please note that the full set of gfp
> - * flags are not supported. GFP_KERNEL, GFP_NOFS and GFP_NOIO are all
> - * supported.
> - * Zone modifiers are not supported. From the reclaim modifiers
> - * __GFP_DIRECT_RECLAIM is required (aka GFP_NOWAIT is not supported)
> - * and only __GFP_NOFAIL is supported (i.e. __GFP_NORETRY and
> - * __GFP_RETRY_MAYFAIL are not supported).
> + * allocator with @gfp_mask flags and map them into contiguous
> + * virtual range with protection @prot.
>   *
> - * __GFP_NOWARN can be used to suppress failures messages.
> + * Supported GFP classes: %GFP_KERNEL, %GFP_ATOMIC, %GFP_NOWAIT,
> + * %GFP_NOFS and %GFP_NOIO. Zone modifiers are not supported.
> + * Please note %GFP_ATOMIC and %GFP_NOWAIT are supported only
> + * by __vmalloc().
> +
> + * Retry modifiers: only %__GFP_NOFAIL is supported; %__GFP_NORETRY
> + * and %__GFP_RETRY_MAYFAIL are not supported.
>   *
> - * Map them into contiguous kernel virtual space, using a pagetable
> - * protection of @prot.
> + * %__GFP_NOWARN can be used to suppress failure messages.
>   *
> + * Can not be called from interrupt nor NMI contexts.
>   * Return: the address of the area or %NULL on failure
>   */
>  void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
> -- 
> 2.47.3

-- 
Michal Hocko
SUSE Labs

