Return-Path: <linux-kernel+bounces-729679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46567B03A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863B718998A8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCC02367AC;
	Mon, 14 Jul 2025 09:02:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C3E10A1E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752483759; cv=none; b=ZGkTJS/AQZPtEY7x8NL4anWWZQPZQ5z+jVHVQ2i754ZVh9vwDnoMG14pnSjBQGOI51rTDnyqQfnxfR7QgjYx1hViVEEiChzUwwF7t9Pj4elhJfttZQ+NRgVoWqYzMO1rHfUM/+gIg2VlzS53JikOtA5QGE5bkA6scVAJqzQcwrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752483759; c=relaxed/simple;
	bh=+uCl6EJ+WEpr2Uw3EgZffP8rLSFjvwx/yzirO83ZLLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1KqiVMsussyezNUQGqFsUVC+TX0TA/Aqsqx43Y0r7VBdgu15796yRZkIXmySe4Er8Lre4pewluhOAfNJl2p6GCIura1UzK5MSnkSSf0VMbPoUVKJ8e3DWeqkxi0ozwbZFnz1N6xfOBhQUtoAmgvASnv4f+UJKC3ftDDRyHVav8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F10011764;
	Mon, 14 Jul 2025 02:02:27 -0700 (PDT)
Received: from [10.57.83.2] (unknown [10.57.83.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C51E93F694;
	Mon, 14 Jul 2025 02:02:35 -0700 (PDT)
Message-ID: <404625f2-808a-4578-98bd-4d12d7a72c7c@arm.com>
Date: Mon, 14 Jul 2025 10:02:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] arm64: mm: Re-implement the __tlbi_level macro in C
Content-Language: en-GB
To: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
References: <20250711161732.384-1-will@kernel.org>
 <20250711161732.384-6-will@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250711161732.384-6-will@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/07/2025 17:17, Will Deacon wrote:
> __tlbi_level() is just a simple macro around __tlbi_level_op(), so merge
> the two into a single C function. Drop the redundant comparison of
> 'u32 level' against 0 and tidy up the code a little while we're at it.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/tlbflush.h | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 728b00f3e1f4..ddd77e92b268 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -128,8 +128,17 @@ enum tlbi_op {
>  	___GEN_TLBI_OP_CASE(op);					\
>  		break
>  
> -static __always_inline void __tlbi_level_op(const enum tlbi_op op, u64 arg)
> +static __always_inline void __tlbi_level(const enum tlbi_op op, u64 addr, u32 level)

level is passed into all the higher level functions as int. That's why the
"level >= 0" comparison was previously there. Of course no users should be
calling this with a negative value so I'll guess that I was trying to guard
against seeing a valid level -1 in future with 6 level/4K D128 pgtables.

Given everything else uses signed int for level, perhaps we should be consistent
here too?

>  {
> +	u64 arg = addr;
> +
> +	if (alternative_has_cap_unlikely(ARM64_HAS_ARMv8_4_TTL) && level <= 3) {
> +		u64 ttl = level | (get_trans_granule() << 2);
> +
> +		arg &= ~TLBI_TTL_MASK;
> +		arg |= FIELD_PREP(TLBI_TTL_MASK, ttl);
> +	}
> +
>  	switch (op) {
>  	__GEN_TLBI_OP_ASID_CASE(vae1is);
>  	__GEN_TLBI_OP_CASE(vae2is);
> @@ -145,20 +154,6 @@ static __always_inline void __tlbi_level_op(const enum tlbi_op op, u64 arg)
>  #undef __GEN_TLBI_OP_ASID_CASE
>  #undef ___GEN_TLBI_OP_CASE
>  
> -#define __tlbi_level(op, addr, level) do {				\
> -	u64 arg = addr;							\
> -									\
> -	if (alternative_has_cap_unlikely(ARM64_HAS_ARMv8_4_TTL) &&	\
> -	    level >= 0 && level <= 3) {					\
> -		u64 ttl = level & 3;					\
> -		ttl |= get_trans_granule() << 2;			\
> -		arg &= ~TLBI_TTL_MASK;					\
> -		arg |= FIELD_PREP(TLBI_TTL_MASK, ttl);			\
> -	}								\
> -									\
> -	__tlbi_level_op(op, arg);					\
> -} while(0)
> -
>  /*
>   * This macro creates a properly formatted VA operand for the TLB RANGE. The
>   * value bit assignments are:


