Return-Path: <linux-kernel+bounces-635727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5062DAAC146
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 12:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7870A3B3A29
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 10:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46383275869;
	Tue,  6 May 2025 10:24:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3F826B956
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746527053; cv=none; b=cFVvYdYo3Q2K4yYMnlI7hElqsYi9YogiNGb5o00iZt7OOEpapibNw0H1uUk4mQnxiArJurvWT8Ez5cUabTwBqwa8QNPirRsVyRXM0mTfUQFWFFLYMXUjWLTT554QJsfT9Ksp5jkwp/QnqBxAwc+tu6C3CTQeG4RYThIcWqI7DYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746527053; c=relaxed/simple;
	bh=lIMGlCcAWdK9vLmeZ3zcIQDXpg99SHJUMMuzp5geo8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kBhhvRsW9GS6eYrCMv84tTTl80zA/ZKz6ANRQv94FK7OO0nW4BHQAte57TmHltjFKUXBTGE+SPOTaJH0QgUVWEZS3CQgEJwJkCfBr2c57NCwESu/sQh4ztfZ8Z2TE3Q6PAIwUe0/SOx2Xg9NWaRIWIFERTigDDl+DnYoiQ0fJyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1083D113E;
	Tue,  6 May 2025 03:24:02 -0700 (PDT)
Received: from [10.57.93.118] (unknown [10.57.93.118])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94A743F5A1;
	Tue,  6 May 2025 03:24:10 -0700 (PDT)
Message-ID: <0d227893-38f5-4f77-a3d1-4caed29c7663@arm.com>
Date: Tue, 6 May 2025 11:24:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] arm64/mm: Re-organise setting up FEAT_S1PIE registers
 PIRE0_EL1 and PIR_EL1
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250429050511.1663235-1-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250429050511.1663235-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/04/2025 06:05, Anshuman Khandual wrote:
> mov_q cannot really move PIE_E[0|1] macros into a general purpose register
> as expected if those macro constants contain some 128 bit layout elements,
> that are required for D128 page tables. The primary issue is that for D128,
> PIE_E[0|1] are defined in terms of 128-bit types with shifting and masking,
> which the assembler can't accommodate.
> 
> Instead pre-calculate these PIRE0_EL1/PIR_EL1 constants into asm-offsets.h
> based PIE_E0_ASM/PIE_E1_ASM which can then be used in arch/arm64/mm/proc.S.
> 
> While here also drop PTE_MAYBE_NG/PTE_MAYBE_SHARED assembly overrides which
> are not required any longer, as the compiler toolchains are smart enough to
> compute both the PIE_[E0|E1]_ASM constants in all scenarios.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
> This patch applies on v6.15-rc4
> 
> Changes in V3:
> 
> - Dropped off macros PTE_MAYBE_NG and PTE_MAYBE_SHARED as per Ryan
> 
> Changes in V2:
> 
> https://lore.kernel.org/all/20250416035604.2717188-1-anshuman.khandual@arm.com/
> 
> - Added asm-offsets.c based PIE_E0_ASM and PIE_E1_ASM symbols as per Ard
> - Moved PTE_MAYBE_NG and PTE_MAYBE_SHARED overrides inside asm-offsets.c
>   along with the corresponding comment as per Ard
> 
> Changes in V1:
> 
> https://lore.kernel.org/linux-arm-kernel/20250410074024.1545768-1-anshuman.khandual@arm.com/
> 
>  arch/arm64/kernel/asm-offsets.c |  2 ++
>  arch/arm64/mm/proc.S            | 19 ++-----------------
>  2 files changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index eb1a840e4110..30d4bbe68661 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -182,5 +182,7 @@ int main(void)
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>    DEFINE(FTRACE_OPS_DIRECT_CALL,	offsetof(struct ftrace_ops, direct_call));
>  #endif
> +  DEFINE(PIE_E0_ASM, PIE_E0);
> +  DEFINE(PIE_E1_ASM, PIE_E1);
>    return 0;
>  }
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index fb30c8804f87..80d470aa469d 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -512,26 +512,11 @@ alternative_else_nop_endif
>  	ubfx	x1, x1, #ID_AA64MMFR3_EL1_S1PIE_SHIFT, #4
>  	cbz	x1, .Lskip_indirection
>  
> -	/*
> -	 * The PROT_* macros describing the various memory types may resolve to
> -	 * C expressions if they include the PTE_MAYBE_* macros, and so they
> -	 * can only be used from C code. The PIE_E* constants below are also
> -	 * defined in terms of those macros, but will mask out those
> -	 * PTE_MAYBE_* constants, whether they are set or not. So #define them
> -	 * as 0x0 here so we can evaluate the PIE_E* constants in asm context.
> -	 */
> -
> -#define PTE_MAYBE_NG		0
> -#define PTE_MAYBE_SHARED	0
> -
> -	mov_q	x0, PIE_E0
> +	mov_q	x0, PIE_E0_ASM
>  	msr	REG_PIRE0_EL1, x0
> -	mov_q	x0, PIE_E1
> +	mov_q	x0, PIE_E1_ASM
>  	msr	REG_PIR_EL1, x0
>  
> -#undef PTE_MAYBE_NG
> -#undef PTE_MAYBE_SHARED
> -
>  	orr	tcr2, tcr2, TCR2_EL1_PIE
>  	msr	REG_TCR2_EL1, x0
>  


