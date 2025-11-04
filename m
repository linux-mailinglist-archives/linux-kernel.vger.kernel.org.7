Return-Path: <linux-kernel+bounces-885037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FF6C31D24
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 121394F0C41
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886BC2580F2;
	Tue,  4 Nov 2025 15:17:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEB225FA3B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762269463; cv=none; b=FICt05aCw1XGFD/ejsKiUpz5As34RIRwslgYogf+gUbHSufkgEwK8RsdIq+YDxf/Nwq+2iQYE6RxEytFkcc+nUz8nXr6hWbXqty87eJFaisn/l96BLhzS5vtnMWhRGkvGf2iW3OUpUGXMk/sbR7aABK6sF8469/0oaFHwqD+4Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762269463; c=relaxed/simple;
	bh=gs3rkVXcSCeQGGzdOynBKnqYR4GUxN/eBf75M3M166U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OK9nqIPqm6MKkqGeHUKAvsvSSNRTe0u4LZsskz3o1HvLPOb6LHgNiOAA9xJiCvj5/vkIAAARza2ATFMGySdaK6LuBV4JeM+T3YnRFEVH5w/azq/tS7VQRzZozCMVjdjrw0WZymeXrt2zBRvncbWRRvLJL21JbR46eQG6a28LF1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 625C61CE0;
	Tue,  4 Nov 2025 07:17:32 -0800 (PST)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6FB63F66E;
	Tue,  4 Nov 2025 07:17:38 -0800 (PST)
Date: Tue, 4 Nov 2025 15:17:33 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] arm64/mm: Ensure correct 48 bit PA gets into
 TTBRx_EL1
Message-ID: <aQoZDbuBJ_2YcsyP@J2N7QTR9R3.cambridge.arm.com>
References: <20251103052618.586763-1-anshuman.khandual@arm.com>
 <20251103052618.586763-5-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103052618.586763-5-anshuman.khandual@arm.com>

On Mon, Nov 03, 2025 at 05:26:16AM +0000, Anshuman Khandual wrote:
> Even though 48 bit PA representation in TTBRx_EL1 does not involve shifting
> partial bits like 52 bit variant does, they sill need to be masked properly
> for correctness. Hence mask 48 bit PA with TTBRx_EL1_BADDR_MASK.

There is no need for the address "to be masked properly for
correctness".

We added masking for 52-bit PAs due to the need to shuffle the bits
around. There is no need for that when using 48-bit PAs, since the
address must be below 2^48, and the address must be suitably aligned.

If any bits are set outside of this mask, that is a bug in the caller.

Mark.

> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/include/asm/assembler.h | 1 +
>  arch/arm64/include/asm/pgtable.h   | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 23be85d93348..d5eb09fc5f8a 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -609,6 +609,7 @@ alternative_endif
>  	and	\ttbr, \ttbr, #TTBR_BADDR_MASK_52
>  #else
>  	mov	\ttbr, \phys
> +	and	\ttbr, \ttbr, #TTBRx_EL1_BADDR_MASK
>  #endif
>  	.endm
>  
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 0944e296dd4a..c3110040c137 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1604,7 +1604,7 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
>  #ifdef CONFIG_ARM64_PA_BITS_52
>  #define phys_to_ttbr(addr)	(((addr) | ((addr) >> 46)) & TTBR_BADDR_MASK_52)
>  #else
> -#define phys_to_ttbr(addr)	(addr)
> +#define phys_to_ttbr(addr)	(addr & TTBRx_EL1_BADDR_MASK)
>  #endif
>  
>  /*
> -- 
> 2.30.2
> 

