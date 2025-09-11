Return-Path: <linux-kernel+bounces-812244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863A5B534F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA041C83794
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67114337683;
	Thu, 11 Sep 2025 14:12:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6B8322A3B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599973; cv=none; b=RIFw//AK23zqlPJr64Qt8ciaDbAnhBKz4CylXX97x8FqqYxXuYqamxbb7jyc5aoCMBKlPmv5eD8Wv4c7SoYixHQ/PieolxJuR/MOqS7pFyCME+AuGv1BtOoRgC5QNIoEw1uMgaZHcQYkXNVJcaXhpk5V/evZ5w+Pev1JRhe/Jl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599973; c=relaxed/simple;
	bh=INs0GJC7GbrwXVSSHaoSwI9JA2Oyr1lKNTN+LW9xdmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LhDolqTG6N8ofTlPt48Bz55Z50Kq+4ZZMO14iwtSJhn7MP0wED9QGBKeuWQTnANeNZLjXKq4HlOE5K7XgfF9LFQOkjLlTq9pNDKHt9kh7hzbLwb3ptA2CtgzW7fi6H+ps9PgQvgMR6agbihy7GM1CbG41YWJoTHDakU3bHipUFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A251153B;
	Thu, 11 Sep 2025 07:12:42 -0700 (PDT)
Received: from [10.1.32.180] (unknown [10.1.32.180])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B4473F694;
	Thu, 11 Sep 2025 07:12:49 -0700 (PDT)
Message-ID: <3e3f15a1-77d4-4391-91bb-7a5eb0e93a63@arm.com>
Date: Thu, 11 Sep 2025 15:12:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/2] arm64: tlbflush: Move invocation of
 __flush_tlb_range_op() to a macro
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250829153510.2401161-1-ryan.roberts@arm.com>
 <20250829153510.2401161-2-ryan.roberts@arm.com>
 <4ac449f1-d5cc-42d6-bded-2db6984d55f0@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <4ac449f1-d5cc-42d6-bded-2db6984d55f0@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/09/2025 06:50, Anshuman Khandual wrote:
> 
> 
> On 29/08/25 9:05 PM, Ryan Roberts wrote:
>> __flush_tlb_range_op() is a pre-processor macro that takes the TLBI
>> operation as a string, and builds the instruction from it. This prevents
>> passing the TLBI operation around as a variable. __flush_tlb_range_op()
>> also takes 7 other arguments.
>>
>> Adding extra invocations for different TLB operations means duplicating
>> the whole thing, but those 7 extra arguments are the same each time.
>>
>> Add an enum for the TLBI operations that __flush_tlb_range() uses, and a
>> macro to pass the operation name as a string to __flush_tlb_range_op(),
>> and the rest of the arguments using __VA_ARGS_.
>>
>> The result is easier to add new TLBI operations to, and to modify any of
>> the other arguments as they only appear once.
>>
>> Suggested-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  arch/arm64/include/asm/tlbflush.h | 30 ++++++++++++++++++++++++------
>>  1 file changed, 24 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>> index 18a5dc0c9a54..f66b8c4696d0 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -11,6 +11,7 @@
>>  #ifndef __ASSEMBLY__
>>  
>>  #include <linux/bitfield.h>
>> +#include <linux/build_bug.h>
>>  #include <linux/mm_types.h>
>>  #include <linux/sched.h>
>>  #include <linux/mmu_notifier.h>
>> @@ -433,12 +434,32 @@ static inline bool __flush_tlb_range_limit_excess(unsigned long start,
>>  	return false;
>>  }
>>  
>> +enum tlbi_op {
>> +	TLBI_VALE1IS,
>> +	TLBI_VAE1IS,
>> +};
>> +
>> +#define flush_tlb_range_op(op, ...)					\
>> +do {									\
>> +	switch (op) {							\
>> +	case TLBI_VALE1IS:						\
>> +		__flush_tlb_range_op(vale1is, __VA_ARGS__);		\
>> +		break;							\
>> +	case TLBI_VAE1IS:						\
>> +		__flush_tlb_range_op(vae1is, __VA_ARGS__);		\
>> +		break;							\
>> +	default:							\
>> +		BUILD_BUG_ON_MSG(1, "Unknown TLBI op");			\
>> +	}								\
>> +} while (0)
>> +
>>  static inline void __flush_tlb_range_nosync(struct mm_struct *mm,
>>  				     unsigned long start, unsigned long end,
>>  				     unsigned long stride, bool last_level,
>>  				     int tlb_level)
>>  {
>>  	unsigned long asid, pages;
>> +	enum tlbi_op tlbi_op;
>>  
>>  	start = round_down(start, stride);
>>  	end = round_up(end, stride);
>> @@ -452,12 +473,9 @@ static inline void __flush_tlb_range_nosync(struct mm_struct *mm,
>>  	dsb(ishst);
>>  	asid = ASID(mm);
>>  
>> -	if (last_level)
>> -		__flush_tlb_range_op(vale1is, start, pages, stride, asid,
>> -				     tlb_level, true, lpa2_is_enabled());
>> -	else
>> -		__flush_tlb_range_op(vae1is, start, pages, stride, asid,
>> -				     tlb_level, true, lpa2_is_enabled());
>> +	tlbi_op = last_level ? TLBI_VALE1IS : TLBI_VAE1IS;
>> +	flush_tlb_range_op(tlbi_op, start, pages, stride, asid, tlb_level,
>> +			   true, lpa2_is_enabled());
>>  
>>  	mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, end);
>>  }
> 
> Should the remaining __flush_tlb_range_op() in flush_tlb_kernel_range()
> converted into flush_tlb_range_op() adding another similar enum variable
> i.e TLBI_VAALE1IS ? Because this will ensure that there is one variant
> helper i.e flush_tlb_range_op() that gets called.

Yeah maybe. I don't really have a strong opinion.

Will posted an RFC for converting all this to functions a while ago. That's the
better baseline to build this all on I think.

> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index f66b8c4696d0..a23169751deb 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -437,6 +437,7 @@ static inline bool __flush_tlb_range_limit_excess(unsigned long start,
>  enum tlbi_op {
>         TLBI_VALE1IS,
>         TLBI_VAE1IS,
> +       TLBI_VAALE1IS,
>  };
> 
>  #define flush_tlb_range_op(op, ...)                                    \
> @@ -448,6 +449,9 @@ do {                                                                        \
>         case TLBI_VAE1IS:                                               \
>                 __flush_tlb_range_op(vae1is, __VA_ARGS__);              \
>                 break;                                                  \
> +       case TLBI_VAALE1IS:                                             \
> +               __flush_tlb_range_op(vaale1is, __VA_ARGS__);            \
> +               break;                                                  \
>         default:                                                        \
>                 BUILD_BUG_ON_MSG(1, "Unknown TLBI op");                 \
>         }                                                               \
> @@ -517,7 +521,7 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
>         }
> 
>         dsb(ishst);
> -       __flush_tlb_range_op(vaale1is, start, pages, stride, 0,
> +       flush_tlb_range_op(TLBI_VAALE1IS, start, pages, stride, 0,
>                              TLBI_TTL_UNKNOWN, false, lpa2_is_enabled());
>         dsb(ish);
>         isb();


