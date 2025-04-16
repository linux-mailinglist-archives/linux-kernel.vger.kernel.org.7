Return-Path: <linux-kernel+bounces-605766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADFBA8A5E9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 19:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309B33AB6C7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 17:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F762206B3;
	Tue, 15 Apr 2025 17:43:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EC8158520
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744739000; cv=none; b=jJpMhZtp7VL8XDT9nodJef6lPXh8RW7lGcLOP6aPu0Mh4sINRUOlAvPmB7/1VMyGsY/y6AELJSAS5lFcPqKRSEVTWQfNq7YvtFM3jEH2C2u0YB1moOV54QwP5oN0UE4VCFz4fK/9uj8Hv8ZbAb9/M3Y+cwUb63rNEWmrlGqzy2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744739000; c=relaxed/simple;
	bh=VFgb6NGSP68dybKGhsZgdUSTzJRaslSSXQZ7JlMAMpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VKCuUURLYCBtpNN5BAdPH4r+GIYzB7eJ0Dq6SuzFGTr7BPJS9QyFKedNqaz6EhSnceas6KV05Tlf7gwDiRwJhNdMq9SKT4peAYq+Y5riVlZkvPRwjSxJdk5D9/mCqJuyd7VwDrRqB3AxrSfFNpZ3LHeRCBuCqubSqxhuHq+nhU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C053515A1;
	Tue, 15 Apr 2025 10:43:13 -0700 (PDT)
Received: from [10.57.86.225] (unknown [10.57.86.225])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 736E03F59E;
	Tue, 15 Apr 2025 10:43:14 -0700 (PDT)
Message-ID: <30b6c851-993a-42a2-be71-9748faa2eb4d@arm.com>
Date: Tue, 15 Apr 2025 18:43:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Re-organise setting up FEAT_S1PIE registers
 PIRE0_EL1 and PIR_EL1
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
References: <20250410074024.1545768-1-anshuman.khandual@arm.com>
 <6e6305fd-3b93-43ec-8114-e81b2926adfc@arm.com>
 <CAMj1kXG5R1jVWLQ-XEcqF9U365T18pTW8u3DgC7OY4N53hchOA@mail.gmail.com>
 <16602b97-2f49-4612-9e9a-d6d0ed964fd3@arm.com>
 <CAMj1kXEnmpu3Dc5zZz1aQJGVwEFwx=JdYisSFkDNjUJ44FjX9Q@mail.gmail.com>
 <5d975762-7678-419f-8e2f-40547c079276@arm.com>
 <0eabad93-26ef-4452-bd89-17c153f483f3@arm.com>
 <7b26c6e4-5483-4ac3-a084-bb0769768006@arm.com>
 <fb411be7-b8e8-493f-ae79-90adb8bb79fd@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <fb411be7-b8e8-493f-ae79-90adb8bb79fd@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/04/2025 10:46, Anshuman Khandual wrote:
> 
> 
> On 4/15/25 13:23, Ryan Roberts wrote:
>> On 15/04/2025 07:27, Anshuman Khandual wrote:
>>>
>>>
>>> On 4/14/25 18:01, Ryan Roberts wrote:
>>>> On 14/04/2025 13:28, Ard Biesheuvel wrote:
>>>>> On Mon, 14 Apr 2025 at 14:04, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>
>>>>>> On 14/04/2025 10:41, Ard Biesheuvel wrote:
>>>>>>> On Mon, 14 Apr 2025 at 09:52, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>>>
>>>>>>>> On 10/04/2025 08:40, Anshuman Khandual wrote:
>>>>>>>>> mov_q cannot really move PIE_E[0|1] macros into a general purpose register
>>>>>>>>> as expected if those macro constants contain some 128 bit layout elements,
>>>>>>>>> required for D128 page tables. Fix this problem via first loading up these
>>>>>>>>> macro constants into a given memory location and then subsequently setting
>>>>>>>>> up registers PIRE0_EL1 and PIR_EL1 by retrieving the memory stored values.
>>>>>>>>
>>>>>>>> From memory, the primary issue is that for D128, PIE_E[0|1] are defined in terms
>>>>>>>> of 128-bit types with shifting and masking, which the assembler can't do? It
>>>>>>>> would be good to spell this out.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>>>>>> Cc: Will Deacon <will@kernel.org>
>>>>>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>>>>>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>>>>>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>>>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>>>>>> Cc: linux-kernel@vger.kernel.org
>>>>>>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>>>>>> ---
>>>>>>>>> This patch applies on v6.15-rc1
>>>>>>>>>
>>>>>>>>>  arch/arm64/kernel/head.S         | 3 +++
>>>>>>>>>  arch/arm64/kernel/pi/map_range.c | 6 ++++++
>>>>>>>>>  arch/arm64/kernel/pi/pi.h        | 1 +
>>>>>>>>>  arch/arm64/mm/mmu.c              | 1 +
>>>>>>>>>  arch/arm64/mm/proc.S             | 5 +++--
>>>>>>>>>  5 files changed, 14 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>>>>>>>>> index 2ce73525de2c..4950d9cc638a 100644
>>>>>>>>> --- a/arch/arm64/kernel/head.S
>>>>>>>>> +++ b/arch/arm64/kernel/head.S
>>>>>>>>> @@ -126,6 +126,9 @@ SYM_CODE_START(primary_entry)
>>>>>>>>>        * On return, the CPU will be ready for the MMU to be turned on and
>>>>>>>>>        * the TCR will have been set.
>>>>>>>>>        */
>>>>>>>>> +     adr_l   x0, pir_data
>>>>>>>>> +     bl      __pi_load_pir_data
>>>>>>>>
>>>>>>>> Using C code to pre-calculate the values into global variables that the assembly
>>>>>>>> code then loads and stuffs into the PIR registers feels hacky. I wonder if we
>>>>>>>> can instead pre-calculate into asm-offsets.h? e.g. add the following to
>>>>>>>> asm-offsets.c:
>>>>>>>>
>>>>>>>> DEFINE(PIE_E0_ASM, PIE_E0);
>>>>>>>> DEFINE(PIE_E1_ASM, PIE_E1);
>>>>>>>>
>>>>>>>> Which will generate the asm-offsets.h header with PIE_E[0|1]_ASM with the
>>>>>>>> pre-calculated values that you can then use in proc.S?
>>>>>>>>
>>>>>>>
>>>>>>> There is another issue, which is that mov_q tries to be smart, and
>>>>>>> emit fewer than 4 MOVZ/MOVK instructions if possible. So the .if
>>>>>>> directive evaluates the argument, which does not work with symbolic
>>>>>>> constants.
>>>>>>
>>>>>> I'm not quite understanding the detail here; what do you mean by "symbolic
>>>>>> constants"? asm-offsets.h will provide something like:
>>>>>>
>>>>>> #define PIE_E0_ASM 1234567890
>>>>>>
>>>>>> The current code is using a hash-define and that's working fine:
>>>>>>
>>>>>> mov_q   x0, PIE_E0
>>>>>>
>>>>>>
>>>>>> Won't the C preprocessor just substitute and everything will work out?
>>>>>>
>>>>>
>>>>> Yeah, you're right. I was experimenting with something like
>>>>>
>>>>> .set .Lpie_e0, PIE_E0_ASM
>>>>> mov_q xN, .Lpie_e0
>>>>>
>>>>> where this problem does exist, but we can just use PIE_E0_ASM directly
>>>>> and things should work as expected.
>>>>
>>>> Ahh great, sounds like this should be pretty simple then!
>>>
>>> Following change works both on current and with D128 page tables.
>>>
>>> --- a/arch/arm64/kernel/asm-offsets.c
>>> +++ b/arch/arm64/kernel/asm-offsets.c
>>> @@ -182,5 +182,7 @@ int main(void)
>>>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>>>    DEFINE(FTRACE_OPS_DIRECT_CALL,       offsetof(struct ftrace_ops, direct_call));
>>>  #endif
>>> +  DEFINE(PIE_E0_ASM, PIE_E0);
>>> +  DEFINE(PIE_E1_ASM, PIE_E1);
>>>    return 0;
>>>  }
>>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>>> index 737c99d79833..f45494425d09 100644
>>> --- a/arch/arm64/mm/proc.S
>>> +++ b/arch/arm64/mm/proc.S
>>> @@ -536,9 +536,9 @@ alternative_else_nop_endif
>>>  #define PTE_MAYBE_NG           0
>>>  #define PTE_MAYBE_SHARED       0
>>
>> I think at minimum, you can remove this PTE_MAYBE_* hack from proc.S. But as Ard
>> says, you may need to add it to asm-offsets.c? I'm surprised asm-offsets.c even
> 
> Moving PTE_MAYBE_* inside asm-offsets.c works as well in both cases
> but still wondering why this is even required ? What am I missing ?

Without the overrides:

#define PTE_MAYBE_NG		(arm64_use_ng_mappings ? PTE_NG : 0)
#define PTE_MAYBE_SHARED	(lpa2_is_enabled() ? 0 : PTE_SHARED)

And these are used in the definition of PROT_DEFAULT, which is used in the
definition of _PAGE_KERNEL*, which are used in the definition of PIE_E1.

For the assembly code arm64_use_ng_mappings and lpa2_is_enabled() are not
accessible. But we don't actually care about those bits so its just hacked to
override the fields to 0.

I would have expected the asm-offsets.c case to have a similer problem because
we have not defined arm64_use_ng_mappings and lpa2_is_enabled(). asm-offsets.c
is compiled as a standalone object then the macros are exfiltrated and
asm-offsets.h is created.

Perhaps the compiler is smart enough to see that we don't care about the bits in
those fields (pte_pi_index() is only keeping selected bits) and asm-offsets.c
can be safely compiled without the hack?

> 
>> compiles without this hack since surely it doesn't have arm64_use_ng_mappings or
>> is_realm_world() available?
> Did not face any problem with defconfig for the mainline kernel and
> both these symbols were visible in the built code.
> 
>>
>> Thanks,
>> Ryan
>>
>>>  
>>> -       mov_q   x0, PIE_E0
>>> +       mov_q   x0, PIE_E0_ASM
>>>         msr     REG_PIRE0_EL1, x0
>>> -       mov_q   x0, PIE_E1
>>> +       mov_q   x0, PIE_E1_ASM
>>>         msr     REG_PIR_EL1, x0
>>>  
>>>  #undef PTE_MAYBE_NG
>>>
>>


