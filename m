Return-Path: <linux-kernel+bounces-618199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976CBA9AB47
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 13:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E295A429C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 11:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDD222579B;
	Thu, 24 Apr 2025 11:01:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7D12253A5
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745492459; cv=none; b=gAYt/MJmnPrJ5wmfqSxQGlWtfpVlkeH5PB5TuU7MTMKcqssQ6kvR53dsv2h2RmSY/V2nozPd9MoQGvj/BmpCpEeD7mNVszIGqLQhChyZhsYEgtCesjRiprDYHylSPcJKw+aSyJQWVmznxY1nDXcVM/4fSmgMS/IIQnlXPmILClI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745492459; c=relaxed/simple;
	bh=NiHd+pdDh1BzEml5Vs3D5Ib3JpNc7/L+tRzLuaYjMbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bl8k5cBTQCruyTEeRsW+HWEAP1C8KS+IMpaoasH/u1BNq/ueW8YJdQTuK2h+amr6X9W4x9TOmgdx3NbA1SHCj4AG5zro8ywwqdBCt5yk0vQchWwHOMnaglwXZo1mmUZ1ZVO7HKCvsUCs0jXNIpuSSK1WHzNd11rNH/FQp1F6hSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC7FC1063;
	Thu, 24 Apr 2025 04:00:51 -0700 (PDT)
Received: from [10.163.49.106] (unknown [10.163.49.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 586AF3F59E;
	Thu, 24 Apr 2025 04:00:54 -0700 (PDT)
Message-ID: <c0c95b67-2dec-43f1-8f3a-0e1e624292bf@arm.com>
Date: Thu, 24 Apr 2025 16:30:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] arm64/mm: Re-organise setting up FEAT_S1PIE registers
 PIRE0_EL1 and PIR_EL1
To: Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250416035604.2717188-1-anshuman.khandual@arm.com>
 <fbba5d43-d740-401a-b5c5-9dfc222db5c4@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <fbba5d43-d740-401a-b5c5-9dfc222db5c4@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/24/25 15:37, Ryan Roberts wrote:
> On 16/04/2025 04:56, Anshuman Khandual wrote:
>> mov_q cannot really move PIE_E[0|1] macros into a general purpose register
>> as expected if those macro constants contain some 128 bit layout elements,
>> that are required for D128 page tables. The primary issue is that for D128,
>> PIE_E[0|1] are defined in terms of 128-bit types with shifting and masking,
>> which the assembler can't accommodate.
>>
>> Instead pre-calculate these PIRE0_EL1/PIR_EL1 constants into asm-offsets.h
>> based PIE_E0_ASM/PIE_E1_ASM which can then be used in arch/arm64/mm/proc.S.
>>
>> While here also move PTE_MAYBE_NG/PTE_MAYBE_SHARED assembly overrides into
>> arch/arm64/kernel/asm-offsets.c to ensure PIRE0_EL1/PIR_EL1 are calculated
>> in assembly without arm64_use_ng_mappings and lpa2_is_enabled() symbols
>> being accessible. Also move the corresponding comment as well.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This patch applies on v6.15-rc2
>>
>> Changes in V2:
>>
>> - Added asm-offsets.c based PIE_E0_ASM and PIE_E1_ASM symbols as per Ard
>> - Moved PTE_MAYBE_NG and PTE_MAYBE_SHARED overrides inside asm-offsets.c
>>   along with the corresponding comment as per Ard
>>
>> Changes in V1:
>>
>> https://lore.kernel.org/linux-arm-kernel/20250410074024.1545768-1-anshuman.khandual@arm.com/
>>
>>  arch/arm64/kernel/asm-offsets.c | 16 ++++++++++++++++
>>  arch/arm64/mm/proc.S            | 19 ++-----------------
>>  2 files changed, 18 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
>> index eb1a840e4110..5b99a78f6882 100644
>> --- a/arch/arm64/kernel/asm-offsets.c
>> +++ b/arch/arm64/kernel/asm-offsets.c
>> @@ -182,5 +182,21 @@ int main(void)
>>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>>    DEFINE(FTRACE_OPS_DIRECT_CALL,	offsetof(struct ftrace_ops, direct_call));
>>  #endif
>> +	/*
>> +	 * The PROT_* macros describing the various memory types may resolve to
>> +	 * C expressions if they include the PTE_MAYBE_* macros, and so they
>> +	 * can only be used from C code. The PIE_E* constants below are also
>> +	 * defined in terms of those macros, but will mask out those
>> +	 * PTE_MAYBE_* constants, whether they are set or not. So #define them
>> +	 * as 0x0 here so we can evaluate the PIE_E* constants in asm context.
>> +	 */
>> +#undef PTE_MAYBE_NG
>> +#define PTE_MAYBE_NG		0
>> +
>> +#undef PTE_MAYBE_SHARED
>> +#define PTE_MAYBE_SHARED	0
> 
> My toolchain at least is smart enough to figure out that the bits of interest in
> PIE_E1 are all contstant so it works without this hack.
> 
> I'd prefer to drop this hack on that basis. Or if there are issues with other
> toolchains that mean we need to keep it, I think the wording of the comment

So could we keep these for some more time and later drop them off just to be
on the safer side ?

> should be changed since we are now in C code so the "can only be used from C
> code" bit doesn't really make sense.

Dropped that. Does this look better ?

	/*
	 * The PROT_* macros describing the various memory types may resolve
	 * to C expressions if they include the PTE_MAYBE_* macros. The PIE_E*
	 * constants below are also defined in terms of those macros, but will
	 * mask out those PTE_MAYBE_* constants, whether they are set or not.
	 * So #define them as 0x0 here so we can evaluate the PIE_E* constants
	 * in asm context.
 	 */

> 
> Thanks,
> Ryan
> 
>> +
>> +  DEFINE(PIE_E0_ASM, PIE_E0);
>> +  DEFINE(PIE_E1_ASM, PIE_E1);
>>    return 0;
>>  }
>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>> index fb30c8804f87..80d470aa469d 100644
>> --- a/arch/arm64/mm/proc.S
>> +++ b/arch/arm64/mm/proc.S
>> @@ -512,26 +512,11 @@ alternative_else_nop_endif
>>  	ubfx	x1, x1, #ID_AA64MMFR3_EL1_S1PIE_SHIFT, #4
>>  	cbz	x1, .Lskip_indirection
>>  
>> -	/*
>> -	 * The PROT_* macros describing the various memory types may resolve to
>> -	 * C expressions if they include the PTE_MAYBE_* macros, and so they
>> -	 * can only be used from C code. The PIE_E* constants below are also
>> -	 * defined in terms of those macros, but will mask out those
>> -	 * PTE_MAYBE_* constants, whether they are set or not. So #define them
>> -	 * as 0x0 here so we can evaluate the PIE_E* constants in asm context.
>> -	 */
>> -
>> -#define PTE_MAYBE_NG		0
>> -#define PTE_MAYBE_SHARED	0
>> -
>> -	mov_q	x0, PIE_E0
>> +	mov_q	x0, PIE_E0_ASM
>>  	msr	REG_PIRE0_EL1, x0
>> -	mov_q	x0, PIE_E1
>> +	mov_q	x0, PIE_E1_ASM
>>  	msr	REG_PIR_EL1, x0
>>  
>> -#undef PTE_MAYBE_NG
>> -#undef PTE_MAYBE_SHARED
>> -
>>  	orr	tcr2, tcr2, TCR2_EL1_PIE
>>  	msr	REG_TCR2_EL1, x0
>>  
> 

