Return-Path: <linux-kernel+bounces-729764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9458CB03B43
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03C41883F07
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6F923AB9F;
	Mon, 14 Jul 2025 09:46:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9B823505E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486408; cv=none; b=eXM6AYcUm20/tsx1pp0VgWGHdAiqwGlZm7/PPssUBCTO4WQoa9Q8cJhujiNDmMdwZSzuV+MYYgllhRJ8KNvnGA/7+weI/jlWKB+O38kESbVKUL67oplfzcI+4QmcKY895Ws2p+cD6Pjwk0J98HPGIoUClwadHvkGPauYlwALAz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486408; c=relaxed/simple;
	bh=WjD2+6GSYczgjE9l3ETMrddKylV0LGR1r30FIyjZ4HQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KPTPwofJVreJSVFtQzROWqQG1itfmfrwUiJFMQDWpr23TfBqfvR+4lCYVRodcldeAmGdjO9t/G4NplxrejG7lyIK30eHnG/UT2oWIzxEyLHQlxK++pEhntAijXA8iUSXRQe+Ru+BhIYazTVStm4iy/3SvvQeAnC4/rTG8+h2bkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CC831BC0;
	Mon, 14 Jul 2025 02:46:36 -0700 (PDT)
Received: from [10.57.83.2] (unknown [10.57.83.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF4C23F694;
	Mon, 14 Jul 2025 02:46:43 -0700 (PDT)
Message-ID: <c3174c99-dcec-45fa-9e8c-14f378b2b97d@arm.com>
Date: Mon, 14 Jul 2025 10:46:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] arm64: mm: Implicitly invalidate user ASID based on
 TLBI operation
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
To: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
References: <20250711161732.384-1-will@kernel.org>
 <20250711161732.384-4-will@kernel.org>
 <9dccf004-1ac4-45ae-9098-69fcad7107a8@arm.com>
In-Reply-To: <9dccf004-1ac4-45ae-9098-69fcad7107a8@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/07/2025 09:44, Ryan Roberts wrote:
> On 11/07/2025 17:17, Will Deacon wrote:
>> When kpti is enabled, separate ASIDs are used for userspace and
>> kernelspace, requiring ASID-qualified TLB invalidation by virtual
>> address to invalidate both of them.
>>
>> Push the logic for invalidating the two ASIDs down into the low-level
>> __tlbi_level_op() function based on the TLBI operation and remove the
>> burden from the caller to handle the kpti-specific behaviour.
>>
>> Signed-off-by: Will Deacon <will@kernel.org>
>> ---
>>  arch/arm64/include/asm/tlbflush.h | 45 ++++++++++++++++++-------------
>>  1 file changed, 26 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>> index 4408aeebf4d5..08e509f37b28 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -115,17 +115,25 @@ enum tlbi_op {
>>  
>>  #define TLBI_TTL_UNKNOWN	INT_MAX
>>  
>> -#define __GEN_TLBI_OP_CASE(op)						\
>> +#define ___GEN_TLBI_OP_CASE(op)						\
>>  	case op:							\
>> -		__tlbi(op, arg);					\
>> +		__tlbi(op, arg)
>> +
>> +#define __GEN_TLBI_OP_ASID_CASE(op)					\
>> +	___GEN_TLBI_OP_CASE(op);					\
>> +		__tlbi_user(op, arg);					\
>> +		break
>> +
>> +#define __GEN_TLBI_OP_CASE(op)						\
>> +	___GEN_TLBI_OP_CASE(op);					\
>>  		break
>>  
>>  static __always_inline void __tlbi_level_op(const enum tlbi_op op, u64 arg)
>>  {
>>  	switch (op) {
>> -	__GEN_TLBI_OP_CASE(vae1is);
>> +	__GEN_TLBI_OP_ASID_CASE(vae1is);
>>  	__GEN_TLBI_OP_CASE(vae2is);
>> -	__GEN_TLBI_OP_CASE(vale1is);
>> +	__GEN_TLBI_OP_ASID_CASE(vale1is);
>>  	__GEN_TLBI_OP_CASE(vale2is);
>>  	__GEN_TLBI_OP_CASE(vaale1is);
>>  	__GEN_TLBI_OP_CASE(ipas2e1);
>> @@ -134,7 +142,8 @@ static __always_inline void __tlbi_level_op(const enum tlbi_op op, u64 arg)
>>  		BUILD_BUG();
>>  	}
>>  }
>> -#undef __GEN_TLBI_OP_CASE
>> +#undef __GEN_TLBI_OP_ASID_CASE
>> +#undef ___GEN_TLBI_OP_CASE
>>  
>>  #define __tlbi_level(op, addr, level) do {				\
>>  	u64 arg = addr;							\
>> @@ -150,11 +159,6 @@ static __always_inline void __tlbi_level_op(const enum tlbi_op op, u64 arg)
>>  	__tlbi_level_op(op, arg);					\
>>  } while(0)
>>  
>> -#define __tlbi_user_level(op, arg, level) do {				\
>> -	if (arm64_kernel_unmapped_at_el0())				\
>> -		__tlbi_level(op, (arg | USER_ASID_FLAG), level);	\
>> -} while (0)
>> -
>>  /*
>>   * This macro creates a properly formatted VA operand for the TLB RANGE. The
>>   * value bit assignments are:
>> @@ -418,22 +422,28 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>>   *    operations can only span an even number of pages. We save this for last to
>>   *    ensure 64KB start alignment is maintained for the LPA2 case.
>>   */
>> -#define __GEN_TLBI_OP_CASE(op)						\
>> +#define ___GEN_TLBI_OP_CASE(op)						\
>>  	case op:							\
>> -		__tlbi(r ## op, arg);					\
>> +		__tlbi(r ## op, arg)
>> +
>> +#define __GEN_TLBI_OP_ASID_CASE(op)					\
>> +	___GEN_TLBI_OP_CASE(op);					\
>> +		__tlbi_user(r ## op, arg);				\
>>  		break
>>  
>>  static __always_inline void __tlbi_range(const enum tlbi_op op, u64 arg)
>>  {
>>  	switch (op) {
>> -	__GEN_TLBI_OP_CASE(vae1is);
>> -	__GEN_TLBI_OP_CASE(vale1is);
>> +	__GEN_TLBI_OP_ASID_CASE(vae1is);
>> +	__GEN_TLBI_OP_ASID_CASE(vale1is);
>>  	__GEN_TLBI_OP_CASE(vaale1is);
>>  	__GEN_TLBI_OP_CASE(ipas2e1is);
> 
> Bug? This 2 underscore version is still defined from the level case above. So
> this is no longer issuing a range-based tlbi? (i.e. you're no longer prepending
> the "r" here.

Do thse __GEN_TLBI_*() macros really help that much? I think I'd prefer to see
the case statement just written out long hand. It will make things much clearer
for not that many more lines, and if I'm right about that bug, would have
prevented it.

Thanks,
Ryan


> 
>>  	default:
>>  		BUILD_BUG();
>>  	}
>>  }
>> +#undef __GEN_TLBI_OP_ASID_CASE
>> +#undef ___GEN_TLBI_OP_CASE
>>  #undef __GEN_TLBI_OP_CASE
>>  
>>  #define __flush_tlb_range_op(op, start, pages, stride,			\
>> @@ -452,8 +462,6 @@ do {									\
>>  		    (lpa2 && __flush_start != ALIGN(__flush_start, SZ_64K))) {	\
>>  			addr = __TLBI_VADDR(__flush_start, asid);	\
>>  			__tlbi_level(op, addr, tlb_level);		\
>> -			if (tlbi_user)					\
>> -				__tlbi_user_level(op, addr, tlb_level);	\
>>  			__flush_start += stride;			\
>>  			__flush_pages -= stride >> PAGE_SHIFT;		\
>>  			continue;					\
>> @@ -464,8 +472,6 @@ do {									\
>>  			addr = __TLBI_VADDR_RANGE(__flush_start >> shift, asid, \
>>  						scale, num, tlb_level);	\
>>  			__tlbi_range(op, addr);				\
>> -			if (tlbi_user)					\
>> -				__tlbi_user(r##op, addr);		\
>>  			__flush_start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT; \
>>  			__flush_pages -= __TLBI_RANGE_PAGES(num, scale);\
>>  		}							\
>> @@ -584,6 +590,7 @@ static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *b
>>  {
>>  	__flush_tlb_range_nosync(mm, start, end, PAGE_SIZE, true, 3);
>>  }
>> -#endif
>>  
>> +#undef __tlbi_user
>> +#endif
>>  #endif
> 


