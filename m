Return-Path: <linux-kernel+bounces-729638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B691BB0398F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F2E1884D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335C620AF67;
	Mon, 14 Jul 2025 08:26:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2795A2367AA
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481600; cv=none; b=OHILNiu0Hm6hS68HiSQOY2RWufVGbNBY+1hiORS5cVG51KPr5o8uDUWHVW+LEP/HalmdzXvnrKuOz5rO/pUYyz/6OjPWAYT6fVsyb3uJ920A6J9cofDawcemX/1yTHZPct75uckn1JetzYhu8tut3K7bp9Ay0qtCMoWArwAuuyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481600; c=relaxed/simple;
	bh=byPqHPJ3ildrFyKNbhHhvCUcOnpKUQJ71X9ClGdQQ3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JeMyS8ZaW2e/Utn9mT8eHb+NJ9m8r4in2G9RVd4pjXAIOk2MRdoKth6FsesyuTl+TN4Jcn/55BFcaycuf3ddPE2c01oyKUIcpBkIpHsKNimXNBrARlmA82PIXDh7obsmItcJcKUYOMTgX+AvL9kpuVBrKUA2g+DyU8WETbjdAek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 071CC1764;
	Mon, 14 Jul 2025 01:26:26 -0700 (PDT)
Received: from [10.57.83.2] (unknown [10.57.83.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C45723F66E;
	Mon, 14 Jul 2025 01:26:33 -0700 (PDT)
Message-ID: <65b4f0b6-3b0f-4d9b-a034-5031dc889abd@arm.com>
Date: Mon, 14 Jul 2025 09:26:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] arm64: mm: Introduce a C wrapper for by-range TLB
 invalidation helpers
Content-Language: en-GB
To: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
References: <20250711161732.384-1-will@kernel.org>
 <20250711161732.384-3-will@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250711161732.384-3-will@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/07/2025 17:17, Will Deacon wrote:
> In preparation for reducing our reliance on complex preprocessor macros
> for TLB invalidation routines, introduce a new C wrapper for by-range
> TLB invalidation helpers which can be used instead of the __tlbi() macro
> and can additionally be called from C code.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/tlbflush.h | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 1c7548ec6cb7..4408aeebf4d5 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -418,6 +418,24 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>   *    operations can only span an even number of pages. We save this for last to
>   *    ensure 64KB start alignment is maintained for the LPA2 case.
>   */
> +#define __GEN_TLBI_OP_CASE(op)						\
> +	case op:							\
> +		__tlbi(r ## op, arg);					\
> +		break
> +
> +static __always_inline void __tlbi_range(const enum tlbi_op op, u64 arg)

nit: you called the level version __tlbi_level_op(). Why not call this
__tlbi_range_op() for consistency?

> +{
> +	switch (op) {
> +	__GEN_TLBI_OP_CASE(vae1is);
> +	__GEN_TLBI_OP_CASE(vale1is);
> +	__GEN_TLBI_OP_CASE(vaale1is);
> +	__GEN_TLBI_OP_CASE(ipas2e1is);
> +	default:
> +		BUILD_BUG();
> +	}
> +}
> +#undef __GEN_TLBI_OP_CASE
> +
>  #define __flush_tlb_range_op(op, start, pages, stride,			\
>  				asid, tlb_level, tlbi_user, lpa2)	\
>  do {									\
> @@ -445,7 +463,7 @@ do {									\
>  		if (num >= 0) {						\
>  			addr = __TLBI_VADDR_RANGE(__flush_start >> shift, asid, \
>  						scale, num, tlb_level);	\
> -			__tlbi(r##op, addr);				\
> +			__tlbi_range(op, addr);				\
>  			if (tlbi_user)					\
>  				__tlbi_user(r##op, addr);		\
>  			__flush_start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT; \


