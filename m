Return-Path: <linux-kernel+bounces-885761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EC7C33D7F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 04:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5706D4E5DB5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 03:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C460F221FA0;
	Wed,  5 Nov 2025 03:35:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817291DDA1E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 03:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762313738; cv=none; b=e2O2QaLmQiTEXscx18PDS9aWRWyYjvIzahuEFyMoELD3mcmgkw/9o+y60HXj1zJaWqWZjcCCEmoYkOlDHDBoxaWeWMQwaqHmiA0fxfnjI4U03BpKzRmi1IYWMcwlWS5gYOIdM7HDDX76jsfnsizU+8KtDUcA70Z+OmKcNDX/dqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762313738; c=relaxed/simple;
	bh=+eRNRLSXSO9KuDn/dZ765B7NIftgANi0Xgy0mUSddAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGIeU1+vup02qbjM+6wyBaDekPqCTucprlC/Wr9nPory66EyKKyXTBBbGXvIhddec1/NKVh0Za/oeN55OnhxXjHyudl+QbuEuWkRUdFprbTt9sXx2nXIalV1Bl+/pzjnLqdNu6rE/LdUQPKcnnmygrlxyFoWjSGn/t5JC+atgmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDFFA1655;
	Tue,  4 Nov 2025 19:35:27 -0800 (PST)
Received: from [10.164.18.45] (unknown [10.164.18.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 762263F66E;
	Tue,  4 Nov 2025 19:35:33 -0800 (PST)
Message-ID: <b5ff76a5-b068-4c6b-aa21-d932da42e1e9@arm.com>
Date: Wed, 5 Nov 2025 09:05:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] arm64/mm: Ensure correct 48 bit PA gets into
 TTBRx_EL1
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20251103052618.586763-1-anshuman.khandual@arm.com>
 <20251103052618.586763-5-anshuman.khandual@arm.com>
 <aQoZDbuBJ_2YcsyP@J2N7QTR9R3.cambridge.arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <aQoZDbuBJ_2YcsyP@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/11/25 8:47 PM, Mark Rutland wrote:
> On Mon, Nov 03, 2025 at 05:26:16AM +0000, Anshuman Khandual wrote:
>> Even though 48 bit PA representation in TTBRx_EL1 does not involve shifting
>> partial bits like 52 bit variant does, they sill need to be masked properly
>> for correctness. Hence mask 48 bit PA with TTBRx_EL1_BADDR_MASK.
> 
> There is no need for the address "to be masked properly for
> correctness".
> 
> We added masking for 52-bit PAs due to the need to shuffle the bits
> around. There is no need for that when using 48-bit PAs, since the
> address must be below 2^48, and the address must be suitably aligned.
> 
> If any bits are set outside of this mask, that is a bug in the caller.
> 
> Mark.

Agreed - probably should not be masking out an wrong address from the caller
in order to proceed further with TTBRx_EL1 and then cause a problem down the
line.
> 
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/include/asm/assembler.h | 1 +
>>  arch/arm64/include/asm/pgtable.h   | 2 +-
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
>> index 23be85d93348..d5eb09fc5f8a 100644
>> --- a/arch/arm64/include/asm/assembler.h
>> +++ b/arch/arm64/include/asm/assembler.h
>> @@ -609,6 +609,7 @@ alternative_endif
>>  	and	\ttbr, \ttbr, #TTBR_BADDR_MASK_52
>>  #else
>>  	mov	\ttbr, \phys
>> +	and	\ttbr, \ttbr, #TTBRx_EL1_BADDR_MASK
>>  #endif
>>  	.endm
>>  
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 0944e296dd4a..c3110040c137 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -1604,7 +1604,7 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
>>  #ifdef CONFIG_ARM64_PA_BITS_52
>>  #define phys_to_ttbr(addr)	(((addr) | ((addr) >> 46)) & TTBR_BADDR_MASK_52)
>>  #else
>> -#define phys_to_ttbr(addr)	(addr)
>> +#define phys_to_ttbr(addr)	(addr & TTBRx_EL1_BADDR_MASK)
>>  #endif
>>  
>>  /*
>> -- 
>> 2.30.2
>>


