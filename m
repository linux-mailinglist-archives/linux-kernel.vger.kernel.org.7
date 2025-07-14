Return-Path: <linux-kernel+bounces-729682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5434B03A4D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D7357ABBE3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6325C23BCFF;
	Mon, 14 Jul 2025 09:06:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970792376EF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752483986; cv=none; b=uFiN/NcaXXgDtYoMhTFBhQt2dIaEtgr9rHvcV0sU92kQruynjYY4edX3D8DjH8ocDfyXkDW5QSnrWqsFG4Bhels/RNEuP5x5/S0t7f4uh8kNZtXCNh6BHMvm67hQaSgOiVSaZSnvOivzZsoEJgw6O7l9y88y492vfBRt0LSxzCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752483986; c=relaxed/simple;
	bh=7zXYlQRlvlyu154f6Nlqm6HDoJVrBc2LVY5VgHylj7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qi79Y4fMo1WWIgtVvycuM+ISnyP62DIKgJCQLohgLPtpvnP/4HwtqVIvpg9JzSO3MQhUMXRUSI7uAWtC9faDuaXjbKGji9639D1uUKSHxsKZ8vzBZgiu4mg4m0/BNwzjkG1nFBjJEu8AHIywa3S3dhGbLUzz3rIASz35ih9NvY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC5E31764;
	Mon, 14 Jul 2025 02:06:14 -0700 (PDT)
Received: from [10.57.83.2] (unknown [10.57.83.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84CD53F694;
	Mon, 14 Jul 2025 02:06:22 -0700 (PDT)
Message-ID: <663e10b2-5f66-4db1-9e7d-6d7538f5f58a@arm.com>
Date: Mon, 14 Jul 2025 10:06:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] arm64: mm: Simplify __TLBI_RANGE_NUM() macro
Content-Language: en-GB
To: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
References: <20250711161732.384-1-will@kernel.org>
 <20250711161732.384-7-will@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250711161732.384-7-will@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/07/2025 17:17, Will Deacon wrote:
> Since commit e2768b798a19 ("arm64/mm: Modify range-based tlbi to
> decrement scale"), we don't need to clamp the 'pages' argument to fit
> the range for the specified 'scale' as we know that the upper bits will
> have been processed in a prior iteration.
> 
> Drop the clamping and simplify the __TLBI_RANGE_NUM() macro.
> 
> Signed-off-by: Will Deacon <will@kernel.org>

Seems reasonable:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  arch/arm64/include/asm/tlbflush.h | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index ddd77e92b268..a8d21e52ef3a 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -205,11 +205,7 @@ static __always_inline void __tlbi_level(const enum tlbi_op op, u64 addr, u32 le
>   * range.
>   */
>  #define __TLBI_RANGE_NUM(pages, scale)					\
> -	({								\
> -		int __pages = min((pages),				\
> -				  __TLBI_RANGE_PAGES(31, (scale)));	\
> -		(__pages >> (5 * (scale) + 1)) - 1;			\
> -	})
> +	(((pages) >> (5 * (scale) + 1)) - 1)
>  
>  /*
>   *	TLB Invalidation


