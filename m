Return-Path: <linux-kernel+bounces-729646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B57F8B039AB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4E11895E07
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AF323B61A;
	Mon, 14 Jul 2025 08:38:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6084E1E7C23
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752482324; cv=none; b=HFY9p15+8M3kJsV3+5/RGJsSovHUTvmNHC8P1046QTOkdkNlC2wI88vXkm9UD8LI6rXpPPnwz3gz4sUQOf5VJHChp8k3+xzXmjIAEuqOGI2uc/aHOxc1ok8afJ0teXpNQaznJe8Cr0JSFJ9QEjPRIPsNTDPx5S+aOJyRNNm4cH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752482324; c=relaxed/simple;
	bh=nczQh7AOZW1mDxUUZIXpCnaJLTNmDAdZaaW1Hcdlo+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKpWKADM/3H1ioV/u45lIatYy6oKx3tWE7s+QumYm2R+uVp2XyKU8Rd6DgiVjvvMZT5J6EC2Ymplmgni1G/Q1aGowO/L/EgalSLgRuDknxg1ryTXnKT7LExEADStRQoRBAfKmY57CnUFOe87F54o3zhocReiPOl56qjip01w+nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7261B1764;
	Mon, 14 Jul 2025 01:38:33 -0700 (PDT)
Received: from [10.57.83.2] (unknown [10.57.83.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4593E3F66E;
	Mon, 14 Jul 2025 01:38:41 -0700 (PDT)
Message-ID: <22879688-eac8-4d76-b406-14a4458e09b0@arm.com>
Date: Mon, 14 Jul 2025 09:38:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] arm64: mm: Introduce a C wrapper for by-level TLB
 invalidation helpers
Content-Language: en-GB
To: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
References: <20250711161732.384-1-will@kernel.org>
 <20250711161732.384-2-will@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250711161732.384-2-will@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/07/2025 17:17, Will Deacon wrote:
> In preparation for reducing our reliance on complex preprocessor macros
> for TLB invalidation routines, introduce a new C wrapper for by-level
> TLB invalidation helpers which can be used instead of the __tlbi() macro
> and can additionally be called from C code.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/tlbflush.h | 33 ++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index aa9efee17277..1c7548ec6cb7 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -88,6 +88,16 @@ static inline unsigned long get_trans_granule(void)
>  	}
>  }
>  
> +enum tlbi_op {
> +	vae1is,
> +	vae2is,
> +	vale1is,
> +	vale2is,
> +	vaale1is,
> +	ipas2e1,
> +	ipas2e1is,
> +};
> +
>  /*
>   * Level-based TLBI operations.
>   *
> @@ -105,6 +115,27 @@ static inline unsigned long get_trans_granule(void)
>  
>  #define TLBI_TTL_UNKNOWN	INT_MAX
>  
> +#define __GEN_TLBI_OP_CASE(op)						\

nit: my personal preference would be to explicitly pass arg into the macro
instead of implicitly picking it from the parent context.


> +	case op:							\
> +		__tlbi(op, arg);					\
> +		break
> +
> +static __always_inline void __tlbi_level_op(const enum tlbi_op op, u64 arg)
> +{
> +	switch (op) {
> +	__GEN_TLBI_OP_CASE(vae1is);
> +	__GEN_TLBI_OP_CASE(vae2is);
> +	__GEN_TLBI_OP_CASE(vale1is);
> +	__GEN_TLBI_OP_CASE(vale2is);
> +	__GEN_TLBI_OP_CASE(vaale1is);
> +	__GEN_TLBI_OP_CASE(ipas2e1);
> +	__GEN_TLBI_OP_CASE(ipas2e1is);
> +	default:
> +		BUILD_BUG();
> +	}
> +}
> +#undef __GEN_TLBI_OP_CASE
> +
>  #define __tlbi_level(op, addr, level) do {				\
>  	u64 arg = addr;							\
>  									\
> @@ -116,7 +147,7 @@ static inline unsigned long get_trans_granule(void)
>  		arg |= FIELD_PREP(TLBI_TTL_MASK, ttl);			\
>  	}								\
>  									\
> -	__tlbi(op, arg);						\
> +	__tlbi_level_op(op, arg);					\
>  } while(0)
>  
>  #define __tlbi_user_level(op, arg, level) do {				\


