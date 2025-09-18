Return-Path: <linux-kernel+bounces-822819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888E1B84BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 141DA7B1D47
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1615308F08;
	Thu, 18 Sep 2025 13:06:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3D4308F0F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200790; cv=none; b=KRd0S/2gTbBwYHBIyqVokL8Lafq5VuBfMh4jr1Qpgx41a6BQit2pjHn/58f0kEzaD68SoNzPSUdONitbz6SQHQmfXgg3YVoDpaqDtVrU/67o1bQeYGCKEmSU4OvIV8QCmBn5yLoFdFoCpGmKneSvbE7h82tVVsTOuF7BAH56Mhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200790; c=relaxed/simple;
	bh=huBGB/mtoq5w27IOL1IUyamubFpIcE1AxvBiM7Mx9KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqO4Sw6KuIMTBuQtXFbjpdfAmUmKpsZQepZIkNqUilC5VfAmExh79mZRwxwqXlB7E44rFJ/AIbhRtuzZQsnXI5PmQQ2wSc8h7RTzn8Bq6domrlZXGt8PtoJe+L5lpKahJ0/GKh5ES5N2Ljo/B7YlKAsszsnyc456IGSN4TfmzEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8DE41A25;
	Thu, 18 Sep 2025 06:06:19 -0700 (PDT)
Received: from [10.1.33.171] (XHFQ2J9959.cambridge.arm.com [10.1.33.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33A873F66E;
	Thu, 18 Sep 2025 06:06:27 -0700 (PDT)
Message-ID: <d4019be7-e24c-4715-a42a-4f1fc39a9bd4@arm.com>
Date: Thu, 18 Sep 2025 14:06:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Remove PMD alignment constraint in execmem_vmalloc()
Content-Language: en-GB
To: Mike Rapoport <rppt@kernel.org>, Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250918093453.75676-1-dev.jain@arm.com>
 <aMvf_R4ttLibbnQ1@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aMvf_R4ttLibbnQ1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/09/2025 11:33, Mike Rapoport wrote:
> On Thu, Sep 18, 2025 at 03:04:53PM +0530, Dev Jain wrote:
>> When using vmalloc with VM_ALLOW_HUGE_VMAP flag, it will set the alignment
>> to PMD_SIZE internally, if it deems huge mappings to be eligible.
>> Therefore, setting the alignment in execmem_vmalloc is redundant. Apart
>> from this, it also reduces the probability of allocation in case vmalloc
>> fails to allocate hugepages - in the fallback case, vmalloc tries to use
>> the original alignment and allocate basepages, which unfortunately will
>> again be PMD_SIZE passed over from execmem_vmalloc, thus constraining
>> the search for a free space in vmalloc region.
>>
>> Therefore, remove this constraint.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
> 
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Hijacking this thread to ask Mike a related question, which I noticed during
code review...

execmem_alloc() determines the pgprot from the descriptor set by the
architecture, and for !CONFIG_ARCH_HAS_EXECMEM_ROX (a la arm64), passes the
value into __vmalloc_node_range() (via execmem_vmalloc()). vmalloc then uses the
pgprot to set the permissions of the vmap. But the linear map is left as is
(i.e. RW).

arm64 requests PAGE_KERNEL_ROX for the EXECMEM_KPROBES type. So by my reckoning,
the memory ends up ROX in vmap and RW in linear map. Naively that sounds like
something we should be avoiding? Is this intentional?

For arches using the ROX cache, execmem_cache_populate() calls set_memory_rox()
which sets both vmap and linear map to ROX.

Thanks,
Ryan

> 
>> ---
>> mm-selftests pass, but I am not sure if they touch execmem code, and I
>> have no experience with this code.
>>
>>  mm/execmem.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/mm/execmem.c b/mm/execmem.c
>> index 0822305413ec..810a4ba9c924 100644
>> --- a/mm/execmem.c
>> +++ b/mm/execmem.c
>> @@ -38,9 +38,6 @@ static void *execmem_vmalloc(struct execmem_range *range, size_t size,
>>  	if (kasan)
>>  		vm_flags |= VM_DEFER_KMEMLEAK;
>>  
>> -	if (vm_flags & VM_ALLOW_HUGE_VMAP)
>> -		align = PMD_SIZE;
>> -
>>  	p = __vmalloc_node_range(size, align, start, end, gfp_flags,
>>  				 pgprot, vm_flags, NUMA_NO_NODE,
>>  				 __builtin_return_address(0));
>> -- 
>> 2.30.2
>>
> 


