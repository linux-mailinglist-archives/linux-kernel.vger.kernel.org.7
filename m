Return-Path: <linux-kernel+bounces-729712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F897B03AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB7B189EE62
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07695240604;
	Mon, 14 Jul 2025 09:17:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33CB23F41F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484656; cv=none; b=oZqVAgBrEd5NjyJKtI5IKTgeQSuXYn41AjedXIdSqu8S3XaDhHx46iP28Fff3AajN+toY6Z2Kss65eKEXh94LlbWBIYqScMkml25Pxq6VkqKD4e4679VeaE9g/5A47P+q5zkeG2nt55z7kDxN7pinGS2kWz0XYr+TsoAgYDKQ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484656; c=relaxed/simple;
	bh=0gZ5AhGTPZtnIMk2VsgCVuia39W6okU3+0ESn+WMaSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCOXhC1LVaREae3hzXxdutFHaPKnq1pnby5ukf77cxhoTbk8pwBcbpzkIM0U1GJCtHG1YAZa/AxJvljqcjhfBpiYrjZDpCzUuhGFAqweUSl38+hWvNTfqduw81pCB9gbeHKobl09+H0ZQuXiYIzW/t0iH4ctAjO1MI6KRYS2uEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DF721764;
	Mon, 14 Jul 2025 02:17:24 -0700 (PDT)
Received: from [10.57.83.2] (unknown [10.57.83.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EE553F694;
	Mon, 14 Jul 2025 02:17:32 -0700 (PDT)
Message-ID: <e3c6b8a5-083e-4993-8a87-9fe96af0763d@arm.com>
Date: Mon, 14 Jul 2025 10:17:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] arm64: mm: Inline __TLBI_VADDR_RANGE() into
 __tlbi_range()
Content-Language: en-GB
To: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
References: <20250711161732.384-1-will@kernel.org>
 <20250711161732.384-9-will@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250711161732.384-9-will@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/07/2025 17:17, Will Deacon wrote:
> The __TLBI_VADDR_RANGE() macro is only used in one place and isn't
> something that's generally useful outside of the low-level range
> invalidation gubbins.
> 
> Inline __TLBI_VADDR_RANGE() into the __tlbi_range() function so that the
> macro can be removed entirely.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/tlbflush.h | 32 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 434b9fdb340a..8618a85d5cd3 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -185,19 +185,6 @@ static inline void __tlbi_level(const enum tlbi_op op, u64 addr, u32 level)
>  #define TLBIR_TTL_MASK		GENMASK_ULL(38, 37)
>  #define TLBIR_BADDR_MASK	GENMASK_ULL(36,  0)
>  
> -#define __TLBI_VADDR_RANGE(baddr, asid, scale, num, ttl)		\
> -	({								\
> -		unsigned long __ta = 0;					\
> -		unsigned long __ttl = (ttl >= 1 && ttl <= 3) ? ttl : 0;	\
> -		__ta |= FIELD_PREP(TLBIR_BADDR_MASK, baddr);		\
> -		__ta |= FIELD_PREP(TLBIR_TTL_MASK, __ttl);		\
> -		__ta |= FIELD_PREP(TLBIR_NUM_MASK, num);		\
> -		__ta |= FIELD_PREP(TLBIR_SCALE_MASK, scale);		\
> -		__ta |= FIELD_PREP(TLBIR_TG_MASK, get_trans_granule());	\
> -		__ta |= FIELD_PREP(TLBIR_ASID_MASK, asid);		\
> -		__ta;							\
> -	})
> -
>  /* These macros are used by the TLBI RANGE feature. */
>  #define __TLBI_RANGE_PAGES(num, scale)	\
>  	((unsigned long)((num) + 1) << (5 * (scale) + 1))
> @@ -426,8 +413,19 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>  		__tlbi_user(r ## op, arg);				\
>  		break
>  
> -static __always_inline void __tlbi_range(const enum tlbi_op op, u64 arg)
> +static __always_inline void __tlbi_range(const enum tlbi_op op, u64 addr,
> +					 u16 asid, int scale, int num,
> +					 u32 level, bool lpa2)

Same comment about signedness of level; I think it would be marginally less
confusing to consistently consider level as signed, and it will help us when we
get to D128 pgtables.

>  {
> +	u64 arg = 0;
> +
> +	arg |= FIELD_PREP(TLBIR_BADDR_MASK, addr >> (lpa2 ? 16 : PAGE_SHIFT));
> +	arg |= FIELD_PREP(TLBIR_TTL_MASK, level > 3 ? 0 : level);
> +	arg |= FIELD_PREP(TLBIR_NUM_MASK, num);
> +	arg |= FIELD_PREP(TLBIR_SCALE_MASK, scale);
> +	arg |= FIELD_PREP(TLBIR_TG_MASK, get_trans_granule());
> +	arg |= FIELD_PREP(TLBIR_ASID_MASK, asid);
> +
>  	switch (op) {
>  	__GEN_TLBI_OP_ASID_CASE(vae1is);
>  	__GEN_TLBI_OP_ASID_CASE(vale1is);
> @@ -448,8 +446,6 @@ do {									\
>  	typeof(pages) __flush_pages = pages;				\
>  	int num = 0;							\
>  	int scale = 3;							\
> -	int shift = lpa2 ? 16 : PAGE_SHIFT;				\
> -	unsigned long addr;						\
>  									\
>  	while (__flush_pages > 0) {					\
>  		if (!system_supports_tlb_range() ||			\
> @@ -463,9 +459,7 @@ do {									\
>  									\
>  		num = __TLBI_RANGE_NUM(__flush_pages, scale);		\
>  		if (num >= 0) {						\
> -			addr = __TLBI_VADDR_RANGE(__flush_start >> shift, asid, \
> -						scale, num, tlb_level);	\
> -			__tlbi_range(op, addr);				\
> +			__tlbi_range(op, __flush_start, asid, scale, num, tlb_level, lpa2); \
>  			__flush_start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT; \
>  			__flush_pages -= __TLBI_RANGE_PAGES(num, scale);\
>  		}							\


