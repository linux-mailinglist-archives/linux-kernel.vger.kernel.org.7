Return-Path: <linux-kernel+bounces-826662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DCBB8F110
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6ED9189D6B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1586D242D91;
	Mon, 22 Sep 2025 06:03:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C3978F2B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758520984; cv=none; b=LTwKKh3NO68jvt6v6SOH6eycUjZd/wglxzcms3ESwQysUzPwbrj8fgHdpe04OoCn3yqeB+C6sLRWs7YifwMQ0woeZaolQ+u4XK5qiOzRUSSWNIXMpcBDaPTsrJtqW1CXwQI6M3NNO69pU4XQMXYTBOemaxYquwDEYWITNDh++x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758520984; c=relaxed/simple;
	bh=qDc/uS2GiXYeSChKf5ldsb5jujOin43T3IFnBxW7UH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bq/cq3gb3U9HKHPx6D8Vf/GmIDI7fHQxQH7SDrwgnN03iVvvTqZpqDLAHBTdoEV42Ptty3pRus63tFX+f1UqNZDeiUFUYqsPf6g6KnbkpNGSL0mD6xnLzp0c9S9b8eS9fvUg6jeaNZknSPA+eWCnRuND12A0odnZCsoPVuW7ylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 797B51515;
	Sun, 21 Sep 2025 23:02:53 -0700 (PDT)
Received: from [10.164.18.47] (unknown [10.164.18.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E81803F66E;
	Sun, 21 Sep 2025 23:02:59 -0700 (PDT)
Message-ID: <2a7e000c-f075-487e-a750-1fa8d29adfe8@arm.com>
Date: Mon, 22 Sep 2025 11:32:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Remove PMD alignment constraint in execmem_vmalloc()
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org
Cc: rppt@kernel.org, ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250918093453.75676-1-dev.jain@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250918093453.75676-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/09/25 3:04 PM, Dev Jain wrote:
> When using vmalloc with VM_ALLOW_HUGE_VMAP flag, it will set the alignment
> to PMD_SIZE internally, if it deems huge mappings to be eligible.
> Therefore, setting the alignment in execmem_vmalloc is redundant. Apart
> from this, it also reduces the probability of allocation in case vmalloc
> fails to allocate hugepages - in the fallback case, vmalloc tries to use
> the original alignment and allocate basepages, which unfortunately will
> again be PMD_SIZE passed over from execmem_vmalloc, thus constraining
> the search for a free space in vmalloc region.
> 
> Therefore, remove this constraint.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
> mm-selftests pass, but I am not sure if they touch execmem code, and I
> have no experience with this code.
> 
>  mm/execmem.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/mm/execmem.c b/mm/execmem.c
> index 0822305413ec..810a4ba9c924 100644
> --- a/mm/execmem.c
> +++ b/mm/execmem.c
> @@ -38,9 +38,6 @@ static void *execmem_vmalloc(struct execmem_range *range, size_t size,
>  	if (kasan)
>  		vm_flags |= VM_DEFER_KMEMLEAK;
>  
> -	if (vm_flags & VM_ALLOW_HUGE_VMAP)
> -		align = PMD_SIZE;
> -

So if the above assignment is getting dropped here, probably the local
variable 'align' could be dropped as well and range->alignment be used
directly instead ?
>  	p = __vmalloc_node_range(size, align, start, end, gfp_flags,
>  				 pgprot, vm_flags, NUMA_NO_NODE,
>  				 __builtin_return_address(0));


