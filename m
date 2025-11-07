Return-Path: <linux-kernel+bounces-889993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7D5C3F066
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26250188CAED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1371D2C08A8;
	Fri,  7 Nov 2025 08:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rf/i0p2W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7087925C6E2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762505324; cv=none; b=psPXXdpmxO1IeG8o3kqy6QDjJEVZ0jL4IE30FyhtsT4rCIyhAsFY8qq4ZQWvC4HD5xh81E5EX9hykzFV6J7nvCfgpzuzpHWb8KW4MS1VQyDTL1qTqePBAfnkIJ0Wi4tjkIu1gZZWHydirlSpqduPwssVn9JjHkhUEpilXMcsm1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762505324; c=relaxed/simple;
	bh=E3TwJzPNvZUaml5cZpTDTUQufuUCSzPOAK8264B+Oms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgJ6K9u7qfPcFz6v6pvQn/KuqWP6k+srJltP6DSl8k5WnveWHUAr8fcz5AWjV3vu6/Vsm5bPDd8OKMeUl/BK0TDUydm85fGpL9a6cs8V/0l/e6Mym74e8nFCBNA4h9xdkaEFLZ3H70RmRlJqHkX7U8tVa2th3zfdeSOvzXgadZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rf/i0p2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE20C4CEF8;
	Fri,  7 Nov 2025 08:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762505324;
	bh=E3TwJzPNvZUaml5cZpTDTUQufuUCSzPOAK8264B+Oms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rf/i0p2WMdBHgz6Jt2saUAD8COs+9ceeeVFfjJ0Mj7t4/8ZMJc7cXG10Il75xumNO
	 JAmz4UB+O0L1zs1qS8DH0pFitMi20s0t6y+q1DpCfuvjV2wgDnli+QLRgAZdWgSptx
	 fwqaGMdEgPrPBXL4Y0fjavTXbcW3s3eU1UsbS8zcDTdz/TohFk3GVHD1QBYLfedUeh
	 96oVrENtNESgRixnXbHp2hwjA9bRgroHzEFz5TT1KdkGECjdnL/H09WyxZCZLc6jeX
	 3Wokhb6gem3x2YIIaH/O0H1E/vwfSvW7LQuenGG8lycjBlxAzxireur3rTqC6e6+oJ
	 ARmVb98KojHDQ==
Message-ID: <bd11e906-8d01-4e39-b385-f158520b589b@kernel.org>
Date: Fri, 7 Nov 2025 09:48:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/7] mm/highmem: introduce clear_user_highpages()
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20251027202109.678022-1-ankur.a.arora@oracle.com>
 <20251027202109.678022-4-ankur.a.arora@oracle.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251027202109.678022-4-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.10.25 21:21, Ankur Arora wrote:
> Define clear_user_highpages() which clears pages sequentially using
> the single page variant.
> 
> With !CONFIG_HIGHMEM, pages are contiguous so use the range clearing
> primitive clear_user_pages().
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> 
> Note: fixed

That should be dropped.

> ---
>   include/linux/highmem.h | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 105cc4c00cc3..c5f8b1556fd7 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -199,6 +199,11 @@ static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
>   
>   /* when CONFIG_HIGHMEM is not set these will be plain clear/copy_page */
>   #ifndef clear_user_highpage
> +/**
> + * clear_user_highpage() - clear a page to be mapped to user space
> + * @page: start page
> + * @vaddr: start address of the user mapping
> + */
>   static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
>   {
>   	void *addr = kmap_local_page(page);
> @@ -207,6 +212,30 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
>   }
>   #endif
>   
> +/**
> + * clear_user_highpages() - clear a page range to be mapped to user space
> + * @page: start page
> + * @vaddr: start address of the user mapping
> + * @npages: number of pages
> + *
> + * Assumes that all the pages in the region (@page, +@npages) are valid
> + * so this does no exception handling.
> + */
> +static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
> +					unsigned int npages)
> +{
> +	if (!IS_ENABLED(CONFIG_HIGHMEM)) {
> +		clear_user_pages(page_address(page), vaddr, page, npages);
> +		return;
> +	}
> +
> +	do {
> +		clear_user_highpage(page, vaddr);
> +		vaddr += PAGE_SIZE;
> +		page++;
> +	} while (--npages);
> +}
> +
>   #ifndef vma_alloc_zeroed_movable_folio
>   /**
>    * vma_alloc_zeroed_movable_folio - Allocate a zeroed page for a VMA.

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

