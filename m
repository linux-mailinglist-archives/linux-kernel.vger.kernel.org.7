Return-Path: <linux-kernel+bounces-790489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28685B3A896
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56DE16A671
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B292271453;
	Thu, 28 Aug 2025 17:45:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9D322F01
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756403139; cv=none; b=KURYbOffejWyl1+a5C+JAJtGuWEJjkFZ0eqqxrws3ZpbB4vMZtXZUqqbn8KfCSxshsYJCnWc/4fPjCXMetq4q8VVJ+yt60BWte55URaBCnor5qe6vP6eaJL07COXBpa933fxZRk2Nm34TWLU/WQKg9WopHD0kfpnu+tMIwY71LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756403139; c=relaxed/simple;
	bh=iNsl+IAzAYmp8h/QlzABNvwx/GGLwh/vPMwYnWYOMJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=inHb9ywMldAqp7smE4z1K9oE1S9d80qrIkROqwkJK+el9d/6vl36esOEyf/cbnull2v7iAbdLeHXu1q6SN1XFb05qa8oQJwgvn+/Kr7BNXw2dviXJGeY98vhWG+LOYdKctVXUuTUAMZz5oEPe0z5RL5SRsS/JJ5tVEfATlzCbqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8D021688;
	Thu, 28 Aug 2025 10:45:27 -0700 (PDT)
Received: from [10.57.91.118] (unknown [10.57.91.118])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6626B3F738;
	Thu, 28 Aug 2025 10:45:34 -0700 (PDT)
Message-ID: <5795892e-503e-496b-a5dd-be4776f15513@arm.com>
Date: Thu, 28 Aug 2025 18:45:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 3/4] arm64: mm: support large block mapping when
 rodata=full
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org,
 akpm@linux-foundation.org, Miko.Lenczewski@arm.com, dev.jain@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250805081350.3854670-1-ryan.roberts@arm.com>
 <20250805081350.3854670-4-ryan.roberts@arm.com> <aLCNTsM-nn6SpfOO@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aLCNTsM-nn6SpfOO@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/08/2025 18:09, Catalin Marinas wrote:
> On Tue, Aug 05, 2025 at 09:13:48AM +0100, Ryan Roberts wrote:
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index abd9725796e9..f6cd79287024 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
> [...]
>> @@ -640,6 +857,16 @@ static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) {
>>  
>>  #endif /* CONFIG_KFENCE */
>>  
>> +static inline bool force_pte_mapping(void)
>> +{
>> +	bool bbml2 = system_capabilities_finalized() ?
>> +		system_supports_bbml2_noabort() : bbml2_noabort_available();
>> +
>> +	return (!bbml2 && (rodata_full || arm64_kfence_can_set_direct_map() ||
>> +			   is_realm_world())) ||
>> +		debug_pagealloc_enabled();
>> +}
>> +
>>  static void __init map_mem(pgd_t *pgdp)
>>  {
>>  	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
>> @@ -665,7 +892,7 @@ static void __init map_mem(pgd_t *pgdp)
>>  
>>  	early_kfence_pool = arm64_kfence_alloc_pool();
>>  
>> -	if (can_set_direct_map())
>> +	if (force_pte_mapping())
>>  		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>  
>>  	/*
>> @@ -1367,7 +1594,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>  
>>  	VM_BUG_ON(!mhp_range_allowed(start, size, true));
>>  
>> -	if (can_set_direct_map())
>> +	if (force_pte_mapping())
>>  		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>  
>>  	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> 
> Not sure this works in a heterogeneous configuration.
> bbml2_noabort_available() only checks the current/boot CPU which may
> return true but if secondary CPUs don't have the feature, it results in
> system_supports_bbml2_noabort() being false with force_pte_mapping()
> also false in the early map_mem() calls.

The intent is that we eagerly create a block-mapped linear map at boot if the
boot CPU supports BBML2. If, once we have determined that a secondary CPU
doesn't support BBML2 (and therefore the system doesn't support it) then we
repaint the linear map using page mappings.

The repainting mechanism is added in the next patch.

I've tested this with heterogeneous configs and I'm confident it does work.


FYI, I actually have a new version of this ready to go - I was hoping to post
tomorrow, subject to performance results. I thought you were implying in a
previous mail that you weren't interested in reviewing until it was based on top
of an -rc. Perhaps I misunderstood. Let me know if you want me to hold off on
posting that given you are now reviewing this version.

Thanks,
Ryan

> 
> I don't see a nice solution other than making BBML2 no-abort a boot CPU
> feature.
> 


