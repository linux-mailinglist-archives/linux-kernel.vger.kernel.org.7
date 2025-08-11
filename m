Return-Path: <linux-kernel+bounces-762557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F03B2086C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41E33B6754
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688B52D3A60;
	Mon, 11 Aug 2025 12:10:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779852D375E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914211; cv=none; b=Xg6XBrDOZ1tjevtp4zqHqiiBnyf/eoPhtYkCgJDsRhNI290q1D3GsX9YIsO2uIKKqVgQPUBXWjsBvtHzC+Tk+XFW7HYz2uK9/AmYwYUnZNBwnLTtZ6XVk5Z3QWtbR7m6z1TddBAAE60cdHxWGbHXaCnwtZ9fig8UPHwTj6MuY3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914211; c=relaxed/simple;
	bh=5CZt0Tr0ldXyz+gr88lFol3XFxRp8cNukBwBIF1WIj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8DM8DW5YaQGrzBunhyLEjkxXdbqWTw2LXGjyXWGOGUmv+ThezEHLZM+BSptbO6iDg/QIvTDMD4tBeqmzbr6A4cQ54jITz6LvhIvRRQyNA5zgwl6Neqmco12w6vkbqV/ulHtVGAN00eyExi+wQ5zFVIC8ow49xSHXbQssZoaOts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 856C01D13;
	Mon, 11 Aug 2025 05:09:59 -0700 (PDT)
Received: from [10.57.5.137] (unknown [10.57.5.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22B1B3F738;
	Mon, 11 Aug 2025 05:09:59 -0700 (PDT)
Message-ID: <8fd39851-4bbc-4a31-84d9-5939b519d308@arm.com>
Date: Mon, 11 Aug 2025 13:09:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 1/2] dma/pool: Use vmap() address for memory
 encryption helpers on ARM64
To: Mike Rapoport <rppt@kernel.org>,
 Shanker Donthineni <sdonthineni@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Steven Price <steven.price@arm.com>, linux-arm-kernel@lists.infradead.org,
 Gavin Shan <gshan@redhat.com>, Vikram Sethi <vsethi@nvidia.com>,
 Jason Sequeira <jsequeira@nvidia.com>, Dev Jain <dev.jain@arm.com>,
 David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20250811005036.714274-1-sdonthineni@nvidia.com>
 <20250811005036.714274-2-sdonthineni@nvidia.com>
 <aJmuXTNUzsq1jKEK@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aJmuXTNUzsq1jKEK@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-11 9:48 am, Mike Rapoport wrote:
> On Sun, Aug 10, 2025 at 07:50:34PM -0500, Shanker Donthineni wrote:
>> In atomic_pool_expand(), set_memory_encrypted()/set_memory_decrypted()
>> are currently called with page_to_virt(page). On ARM64 with
>> CONFIG_DMA_DIRECT_REMAP=y, the atomic pool is mapped via vmap(), so
>> page_to_virt(page) does not reference the actual mapped region.
>>
>> Using this incorrect address can cause encryption attribute updates to
>> be applied to the wrong memory region. On ARM64 systems with memory
>> encryption enabled (e.g. CCA), this can lead to data corruption or
>> crashes.
>>
>> Fix this by using the vmap() address ('addr') on ARM64 when invoking
>> the memory encryption helpers, while retaining the existing
>> page_to_virt(page) usage for other architectures.
>>
>> Fixes: 76a19940bd62 ("dma-direct: atomic allocations must come from atomic coherent pools")
>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
>> ---
>>   kernel/dma/pool.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
>> index 7b04f7575796b..ba08a301590fd 100644
>> --- a/kernel/dma/pool.c
>> +++ b/kernel/dma/pool.c
>> @@ -81,6 +81,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>>   {
>>   	unsigned int order;
>>   	struct page *page = NULL;
>> +	void *vaddr;
>>   	void *addr;
>>   	int ret = -ENOMEM;
>>   
>> @@ -113,8 +114,8 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>>   	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
>>   	 * shrink so no re-encryption occurs in dma_direct_free().
>>   	 */
>> -	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
>> -				   1 << order);
>> +	vaddr = IS_ENABLED(CONFIG_ARM64) ? addr : page_to_virt(page);
> 
> There's address calculation just before this code:
> 
> #ifdef CONFIG_DMA_DIRECT_REMAP
> 	addr = dma_common_contiguous_remap(page, pool_size,
> 					   pgprot_dmacoherent(PAGE_KERNEL),
> 					   __builtin_return_address(0));
> 	if (!addr)
> 		goto free_page;
> #else
> 	addr = page_to_virt(page);
> #endif
> 
> It should be enough to s/page_to_virt(page)/addr in the call to
> set_memory_decrypted().

Indeed, and either way this is clearly a DMA_DIRECT_REMAP concern rather 
than just an ARM64 one.

Thanks,
Robin.

>> +	ret = set_memory_decrypted((unsigned long)vaddr, 1 << order);
>>   	if (ret)
>>   		goto remove_mapping;
>>   	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
>> @@ -126,8 +127,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>>   	return 0;
>>   
>>   encrypt_mapping:
>> -	ret = set_memory_encrypted((unsigned long)page_to_virt(page),
>> -				   1 << order);
>> +	ret = set_memory_encrypted((unsigned long)vaddr, 1 << order);
>>   	if (WARN_ON_ONCE(ret)) {
>>   		/* Decrypt succeeded but encrypt failed, purposely leak */
>>   		goto out;
>> -- 
>> 2.25.1
>>
> 


