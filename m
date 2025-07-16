Return-Path: <linux-kernel+bounces-732984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCBCB06E70
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1723A1F70
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1582B289E03;
	Wed, 16 Jul 2025 07:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4SHTMEn"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F5C286D46;
	Wed, 16 Jul 2025 07:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649350; cv=none; b=mqgFXMdkhyieZJuJ9J93hJ36mtc3m4yab2xLWcKgq4NKqutO5m0UafOiLQMKTzIlNnjQ2kIfmJt1i0RuNuXzi5EDovWezs7YKd1xYfr4l+t0mLT+gQOk2hve1k1HjeYs+zfCtwZEVaXqLEXVkWbk+zBl+BpWJKUfq3cDLCb40cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649350; c=relaxed/simple;
	bh=R5O5qmAFz0qtF49w2X+xp+Ya0BKfWjBW4tGP1boIEXQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzjFyG/OQiWlLx/lMamgWIVa0mV3U/xv2NJQgFmV9aQtrVRi8SWDK3PnBRKeasDNvB8DaCbgB21Go9FmtrQH5fwc0UidQpQ6qBuNqePBpQD5SaybqN0/1BKxmo8+AgTxBlP3JY5tfnQ4IQfDoI92iux7uVXOMhYUZfbf11cpiUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4SHTMEn; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54b10594812so6104223e87.1;
        Wed, 16 Jul 2025 00:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752649346; x=1753254146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IpbTFITF67s5ytx3WF8TIyUbw/oI1yuXLAr1FOz7XUE=;
        b=U4SHTMEnfrZbKQWJQCegTqvMVL1zRxZnKyRLAvKWdtit2+ci2Hr4CWND38PCYX3ggt
         RG1O2JOdD9z+sHqTvmAvZHRnL5R4ayqLmqTos3CIObKEJACk6KHSI+XF8Iw4omGpeKT/
         lo3vdQCoCGdK8iPxZcqO+jklGWaLnC4oNsHmD9x0FzRR6MzQk4Ql+8krX61EpVzeksY6
         3WIrNTiy48GC5yQLeXkh5pJvYhbbzQ7SlNRA+ty6Fn3xAJzQKJGPkFC4xCnaLvxJv2X1
         KD5aaeETLc02tRgPBVLV/kiMSLGXTSCt5Dzq/p6DRFoYYzzlMsmPxUArRRi/FilI3Den
         e9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752649346; x=1753254146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpbTFITF67s5ytx3WF8TIyUbw/oI1yuXLAr1FOz7XUE=;
        b=eAiLlDbST+YWmp4Q/C75nNQIBEtoGOkpLtScbuNePfhpL8veYQSKGwF3VDTsWTTnLI
         Y73cq2mkxtQ51I4ZPVOsOGikc0Lf9Pu4CjehphElJglpXD+Zfc9ipu6v2DjwsQbbtywP
         +Amof3ucCvznYOgKOfUMpjZ22hKWrwWvIBoCgZfEPuXfyBCv/hMooE7jon7wHEMP0vD5
         OCfaJbH0+sAwGG4M/PBIev/p9DhXAAEwjeFafjUlQl/q1PX+hZBhA5j53RuROy9FLFwB
         d0oziKxK0p736cPnYda2SE2rL+sAk1DOUj3UhqlEx04mbQBL0vVMF5JGSyxDhXzPVJaO
         IsXg==
X-Forwarded-Encrypted: i=1; AJvYcCVAhz3ihUtK6arPnuWWILQmqapivjGuGgXapT6SWxuqMeX/+AF2r6BesxL/HZrOEb3Xhss90LL36i2KGMY=@vger.kernel.org, AJvYcCVxbMOxopWouT02vEn/EaZg7ZRlpQarVD5ILi9VGFkbvdXpMi1c1EG4MHPNP3KoQARAz50ZIHBRhlRyLKItNdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq+2Bk9xIXGr3W4GKax3YeueGsxhGWztQ2BqIx4pAIEc7/WmES
	zfIMOoZUBSmxIoMgd5wp6GuS5wSxbbtHcUHMut9U+5ijBckj6d219fB1
X-Gm-Gg: ASbGncuNR4x9wpEb1pZ82MgnxBmLu6DwBv1W4LpWxC72u8XPWVCZvmX2G+JIX8oJdZ2
	wHs2X6fzAciZ3wBB3Rv0KH3XnprJUShelq7wTCj9dX7ILCGMHGjFTB8VpDY4oh5Hi8G8D+7ii5+
	3Il4jKs92BtpXPHPH6s0FGFQ9Mi4kCquB2BpDWqnQ/XbppzUYlF5TuD95CywJ1erTor8Rcha/ml
	ux2tkXqxZegsGJGcwwktpBUHo8EOAwdfNBl+CEukwK3iGliZyf0zJ4Ed0yZ0uFHM6juxBQ4jWLv
	s6bpQDhyCIFpI0eSgPEI4ZLodp0MOz6VGDDHQAFi9IWZvUXyV5OOxGMsoOmwUYvIw3nq92Dx+Vc
	SvXuv03poQ73dBDU6DyXLCbOHFqRD130mqpNJWHkY3eFw8pU=
X-Google-Smtp-Source: AGHT+IEaQjkkeF2ySgsL9PJxlSd912c1e0hN8v81h0Xze53G9AuaujDLm7o/XYcnrMZzTnbqw1FiGw==
X-Received: by 2002:a05:6512:118f:b0:553:37e7:867b with SMTP id 2adb3069b0e04-55a23f5660bmr595211e87.31.1752649345904;
        Wed, 16 Jul 2025 00:02:25 -0700 (PDT)
Received: from pc636 (host-95-203-27-91.mobileonline.telia.com. [95.203.27.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d32c1sm2531820e87.125.2025.07.16.00.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 00:02:25 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 16 Jul 2025 09:02:22 +0200
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Geliang Tang <geliang@kernel.org>, Hui Zhu <zhuhui@kylinos.cn>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] vmalloc: Add vrealloc_align to support allocation of
 aligned vmap pages
Message-ID: <aHdOfv1QyisOiAXL@pc636>
References: <cover.1752573305.git.zhuhui@kylinos.cn>
 <81647cce3b8e7139af47f20dbeba184b7a89b0cc.1752573305.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81647cce3b8e7139af47f20dbeba184b7a89b0cc.1752573305.git.zhuhui@kylinos.cn>

On Tue, Jul 15, 2025 at 05:59:46PM +0800, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> This commit add new function vrealloc_align.
> vrealloc_align support allocation of aligned vmap pages with
> __vmalloc_node_noprof.
> And vrealloc_align will check the old address. If this address does
> not meet the current alignment requirements, it will also release
> the old vmap pages and reallocate new vmap pages that satisfy the
> alignment requirements.
> 
> Co-developed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
>  include/linux/vmalloc.h |  5 +++
>  mm/vmalloc.c            | 80 ++++++++++++++++++++++++++---------------
>  2 files changed, 57 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index fdc9aeb74a44..0ce0c1ea2427 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -201,6 +201,11 @@ void * __must_check vrealloc_noprof(const void *p, size_t size, gfp_t flags)
>  		__realloc_size(2);
>  #define vrealloc(...)		alloc_hooks(vrealloc_noprof(__VA_ARGS__))
>  
> +void * __must_check vrealloc_align_noprof(const void *p, size_t size,
> +					  size_t align, gfp_t flags)
> +		__realloc_size(2);
> +#define vrealloc_align(...)	alloc_hooks(vrealloc_align_noprof(__VA_ARGS__))
> +
>  extern void vfree(const void *addr);
>  extern void vfree_atomic(const void *addr);
>  
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ab986dd09b6a..41cb3603b3cc 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4081,9 +4081,11 @@ void *vzalloc_node_noprof(unsigned long size, int node)
>  EXPORT_SYMBOL(vzalloc_node_noprof);
>  
>  /**
> - * vrealloc - reallocate virtually contiguous memory; contents remain unchanged
> + * vrealloc_align - reallocate virtually contiguous memory;
> + *                  contents remain unchanged
>   * @p: object to reallocate memory for
>   * @size: the size to reallocate
> + * @align: requested alignment
>   * @flags: the flags for the page level allocator
>   *
>   * If @p is %NULL, vrealloc() behaves exactly like vmalloc(). If @size is 0 and
> @@ -4103,7 +4105,8 @@ EXPORT_SYMBOL(vzalloc_node_noprof);
>   * Return: pointer to the allocated memory; %NULL if @size is zero or in case of
>   *         failure
>   */
> -void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
> +void *vrealloc_align_noprof(const void *p, size_t size, size_t align,
> +			    gfp_t flags)
>  {
>  	struct vm_struct *vm = NULL;
>  	size_t alloced_size = 0;
> @@ -4116,49 +4119,65 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
>  	}
>  
>  	if (p) {
> +		if (!is_power_of_2(align)) {
> +			WARN(1, "Trying to vrealloc_align() align is not power of 2 (%ld)\n",
> +			     align);
> +			return NULL;
> +		}
> +
>  		vm = find_vm_area(p);
>  		if (unlikely(!vm)) {
> -			WARN(1, "Trying to vrealloc() nonexistent vm area (%p)\n", p);
> +			WARN(1, "Trying to vrealloc_align() nonexistent vm area (%p)\n", p);
>  			return NULL;
>  		}
>  
>  		alloced_size = get_vm_area_size(vm);
>  		old_size = vm->requested_size;
>  		if (WARN(alloced_size < old_size,
> -			 "vrealloc() has mismatched area vs requested sizes (%p)\n", p))
> +			 "vrealloc_align() has mismatched area vs requested sizes (%p)\n", p))
>  			return NULL;
>  	}
>  
> -	/*
> -	 * TODO: Shrink the vm_area, i.e. unmap and free unused pages. What
> -	 * would be a good heuristic for when to shrink the vm_area?
> -	 */
> -	if (size <= old_size) {
> -		/* Zero out "freed" memory, potentially for future realloc. */
> -		if (want_init_on_free() || want_init_on_alloc(flags))
> -			memset((void *)p + size, 0, old_size - size);
> -		vm->requested_size = size;
> -		kasan_poison_vmalloc(p + size, old_size - size);
> -		return (void *)p;
> -	}
> +	if (IS_ALIGNED((unsigned long)p, align)) {
> +		/*
> +		 * TODO: Shrink the vm_area, i.e. unmap and free unused pages. What
> +		 * would be a good heuristic for when to shrink the vm_area?
> +		 */
> +		if (size <= old_size) {
> +			/* Zero out "freed" memory, potentially for future realloc. */
> +			if (want_init_on_free() || want_init_on_alloc(flags))
> +				memset((void *)p + size, 0, old_size - size);
> +			vm->requested_size = size;
> +			kasan_poison_vmalloc(p + size, old_size - size);
> +			return (void *)p;
> +		}
>  
> -	/*
> -	 * We already have the bytes available in the allocation; use them.
> -	 */
> -	if (size <= alloced_size) {
> -		kasan_unpoison_vmalloc(p + old_size, size - old_size,
> -				       KASAN_VMALLOC_PROT_NORMAL);
>  		/*
> -		 * No need to zero memory here, as unused memory will have
> -		 * already been zeroed at initial allocation time or during
> -		 * realloc shrink time.
> +		 * We already have the bytes available in the allocation; use them.
> +		 */
> +		if (size <= alloced_size) {
> +			kasan_unpoison_vmalloc(p + old_size, size - old_size,
> +					KASAN_VMALLOC_PROT_NORMAL);
> +			/*
> +			 * No need to zero memory here, as unused memory will have
> +			 * already been zeroed at initial allocation time or during
> +			 * realloc shrink time.
> +			 */
> +			vm->requested_size = size;
> +			return (void *)p;
> +		}
> +	} else {
> +		/*
> +		 * p is not aligned with align.
> +		 * Allocate a new address to handle it.
>  		 */
> -		vm->requested_size = size;
> -		return (void *)p;
> +		if (size < old_size)
> +			old_size = size;
>  	}
>  
>  	/* TODO: Grow the vm_area, i.e. allocate and map additional pages. */
> -	n = __vmalloc_noprof(size, flags);
> +	n = __vmalloc_node_noprof(size, align, flags, NUMA_NO_NODE,
> +				  __builtin_return_address(0));
>  	if (!n)
>  		return NULL;
>  
> @@ -4170,6 +4189,11 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
>  	return n;
>  }
>  
> +void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
> +{
> +	return vrealloc_align_noprof(p, size, 1, flags);
> +}
> +
>  #if defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA32)
>  #define GFP_VMALLOC32 (GFP_DMA32 | GFP_KERNEL)
>  #elif defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA)
> -- 
> 2.43.0
> 
This is similar what Vitaly is doing. There is already v14
but as example see it here: https://lkml.org/lkml/2025/7/9/1583

--
Uladzislau Rezki

