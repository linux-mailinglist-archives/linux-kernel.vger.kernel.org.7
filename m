Return-Path: <linux-kernel+bounces-729759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E63BDB03B31
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 809AF7A2B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D86A188CC9;
	Mon, 14 Jul 2025 09:44:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E452222AF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486256; cv=none; b=rRYwq7j3U7gU1AZatz0gD7BpVM62ngE3vwQoWRj/GgzBXpBZ5+0H6TZagqGJN+ozPMUgH2ZAm71YgyJTFH5ApG/h+/mFbey7kYsEeZD9Ns9fIfBQ0YK6IW84vdpUvvoZ9YKU13bAHXOxH72OHf4mj2P/XaLpAUh+jKU2eq9WGKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486256; c=relaxed/simple;
	bh=JVxvZ6WCBf5+8wupCA32vPSBKfPPL5OS5mRQ+e9I8vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ssGzb0v8tjDV33Su8lG4Zmi64RtRBOpvqoxsXxNEfjdoaw5TxR+dlsCoDYcAV+t9W4JQvG8DE2mjhbDYPBqJ757wgNLCsBMhq6cLLMzwr6izn7dySDGYDgR5ZzjCjXXmc9SwlwnU8FkYK37vXC1kA8tw4IVJxZacHurA4cQLSV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04D151BC0;
	Mon, 14 Jul 2025 02:44:04 -0700 (PDT)
Received: from [10.57.83.2] (unknown [10.57.83.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B1FE3F694;
	Mon, 14 Jul 2025 02:44:11 -0700 (PDT)
Message-ID: <1e650a1d-5c45-4d15-8b90-88c39785ff7b@arm.com>
Date: Mon, 14 Jul 2025 10:44:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] arm64: mm: Re-implement the __flush_tlb_range_op
 macro in C
Content-Language: en-GB
To: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
References: <20250711161732.384-1-will@kernel.org>
 <20250711161732.384-11-will@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250711161732.384-11-will@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/07/2025 17:17, Will Deacon wrote:
> The __flush_tlb_range_op() macro is horrible and has been a previous

Amen to that!

> source of bugs thanks to multiple expansions of its arguments (see
> commit f7edb07ad7c6 ("Fix mmu notifiers for range-based invalidates")).
> 
> Rewrite the thing in C.

This looks much better! Do we know it's definitely valuable to have all these
functions inline though? They have grown a lot over the years. I wonder how much
code size cost they have, vs the performance they actually save?

Perhaps it's worth considering if at least these should move to a c file?

__flush_tlb_range_nosync
flush_tlb_kernel_range


FYI, I've got a patch that uses local tlbi when we can prove only the local cpu
has seen the old pgtable entries that we are trying to flush. These changes to
use enum tlbi_op make that patch quite a bit neater. I'll post that as an RFC at
some point, as I expect it will need quite a bit of discussion.

Thanks,
Ryan


> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  arch/arm64/include/asm/tlbflush.h | 63 +++++++++++++++++--------------
>  1 file changed, 34 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 2541863721af..ee69efdc12ab 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -376,12 +376,12 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>  /*
>   * __flush_tlb_range_op - Perform TLBI operation upon a range
>   *
> - * @op:	TLBI instruction that operates on a range (has 'r' prefix)
> + * @op:		TLBI instruction that operates on a range
>   * @start:	The start address of the range
>   * @pages:	Range as the number of pages from 'start'
>   * @stride:	Flush granularity
>   * @asid:	The ASID of the task (0 for IPA instructions)
> - * @tlb_level:	Translation Table level hint, if known
> + * @level:	Translation Table level hint, if known
>   * @lpa2:	If 'true', the lpa2 scheme is used as set out below
>   *
>   * When the CPU does not support TLB range operations, flush the TLB
> @@ -439,33 +439,38 @@ static __always_inline void __tlbi_range(const enum tlbi_op op, u64 addr,
>  #undef ___GEN_TLBI_OP_CASE
>  #undef __GEN_TLBI_OP_CASE
>  
> -#define __flush_tlb_range_op(op, start, pages, stride,			\
> -				asid, tlb_level, lpa2)			\
> -do {									\
> -	typeof(start) __flush_start = start;				\
> -	typeof(pages) __flush_pages = pages;				\
> -	int num = 0;							\
> -	int scale = 3;							\
> -									\
> -	while (__flush_pages > 0) {					\
> -		if (!system_supports_tlb_range() ||			\
> -		    __flush_pages == 1 ||				\
> -		    (lpa2 && __flush_start != ALIGN(__flush_start, SZ_64K))) {	\
> -			__tlbi_level_asid(op, __flush_start, tlb_level, asid);	\
> -			__flush_start += stride;			\
> -			__flush_pages -= stride >> PAGE_SHIFT;		\
> -			continue;					\
> -		}							\
> -									\
> -		num = __TLBI_RANGE_NUM(__flush_pages, scale);		\
> -		if (num >= 0) {						\
> -			__tlbi_range(op, __flush_start, asid, scale, num, tlb_level, lpa2); \
> -			__flush_start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT; \
> -			__flush_pages -= __TLBI_RANGE_PAGES(num, scale);\
> -		}							\
> -		scale--;						\
> -	}								\
> -} while (0)
> +static __always_inline void __flush_tlb_range_op(const enum tlbi_op op,
> +						 u64 start, size_t pages,
> +						 u64 stride, u16 asid,
> +						 u32 level, bool lpa2)
> +{
> +	u64 addr = start, end = start + pages * PAGE_SIZE;
> +	int scale = 3;
> +
> +	while (addr != end) {
> +		int num;
> +
> +		pages = (end - addr) >> PAGE_SHIFT;
> +
> +		if (!system_supports_tlb_range() || pages == 1)
> +			goto invalidate_one;
> +
> +		if (lpa2 && !IS_ALIGNED(addr, SZ_64K))
> +			goto invalidate_one;
> +
> +		num = __TLBI_RANGE_NUM(pages, scale);
> +		if (num >= 0) {
> +			__tlbi_range(op, addr, asid, scale, num, level, lpa2);
> +			addr += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT;
> +		}
> +
> +		scale--;
> +		continue;
> +invalidate_one:
> +		__tlbi_level_asid(op, addr, level, asid);
> +		addr += stride;
> +	}
> +}
>  
>  #define __flush_s2_tlb_range_op(op, start, pages, stride, tlb_level) \
>  	__flush_tlb_range_op(op, start, pages, stride, 0, tlb_level, kvm_lpa2_is_enabled());


