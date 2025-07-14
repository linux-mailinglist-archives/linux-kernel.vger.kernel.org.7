Return-Path: <linux-kernel+bounces-729730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 654E0B03AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C09189FAFE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A622417EE;
	Mon, 14 Jul 2025 09:30:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DFF1C3C18
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752485434; cv=none; b=gSwby92wQl+Zy/ImA7zGcuhcmaWYVBMpIexKOLJJqOJKXjOV/ATNJAb157X2mNjjUm91yoYbFWHlYq8F9nCHgaVz56SL/Pa96fFqWidYDMU+07ILgyVkicfraqqFL1HGR9tgZNRVgipfJV7CNe78lZ89wudvDVtceDqB/jC9mYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752485434; c=relaxed/simple;
	bh=IY+Z9DmxqV6gJIAopizZa/oluID0QKWcerIUQ4FApnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9nOwOgRIJ0hZOALzt1Tu7Hfb3qRDU9x4pdpHcKrAloOPwblZm0Suki27StZZC/kal4tXms1XGKFv9eQbsys6DXF7JWnF9ug1b7Q1/95YAcDWYdqqRzQNWl+GKYsqwfc1W3WcSca5amleVPk+hSjOXWlrXthSihA2f3dV+WvfWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3C561BC0;
	Mon, 14 Jul 2025 02:30:22 -0700 (PDT)
Received: from [10.57.83.2] (unknown [10.57.83.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74C513F694;
	Mon, 14 Jul 2025 02:30:30 -0700 (PDT)
Message-ID: <b10fd873-6de9-445a-a43a-cd588b433f42@arm.com>
Date: Mon, 14 Jul 2025 10:30:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] arm64: mm: Simplify
 __flush_tlb_range_limit_excess()
Content-Language: en-GB
To: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
References: <20250711161732.384-1-will@kernel.org>
 <20250711161732.384-10-will@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250711161732.384-10-will@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/07/2025 17:17, Will Deacon wrote:
> __flush_tlb_range_limit_excess() is unnecessarily complicated:
> 
>   - It takes a 'start', 'end' and 'pages' argument, whereas it only
>     needs 'pages' (which the caller has computed from the other two
>     arguments!).
> 
>   - It erroneously compares 'pages' with MAX_TLBI_RANGE_PAGES when
>     the system doesn't support range-based invalidation but the range to
>     be invalidated would result in fewer than MAX_DVM_OPS invalidations.
> 
> Simplify the function so that it no longer takes the 'start' and 'end'
> arguments and only considers the MAX_TLBI_RANGE_PAGES threshold on
> systems that implement range-based invalidation.
> 
> Signed-off-by: Will Deacon <will@kernel.org>

Does this warrant a Fixes: tag?

> ---
>  arch/arm64/include/asm/tlbflush.h | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 8618a85d5cd3..2541863721af 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -470,21 +470,13 @@ do {									\
>  #define __flush_s2_tlb_range_op(op, start, pages, stride, tlb_level) \
>  	__flush_tlb_range_op(op, start, pages, stride, 0, tlb_level, kvm_lpa2_is_enabled());
>  
> -static inline bool __flush_tlb_range_limit_excess(unsigned long start,
> -		unsigned long end, unsigned long pages, unsigned long stride)
> +static inline bool __flush_tlb_range_limit_excess(unsigned long pages,
> +						  unsigned long stride)
>  {
> -	/*
> -	 * When the system does not support TLB range based flush
> -	 * operation, (MAX_DVM_OPS - 1) pages can be handled. But
> -	 * with TLB range based operation, MAX_TLBI_RANGE_PAGES
> -	 * pages can be handled.
> -	 */
> -	if ((!system_supports_tlb_range() &&
> -	     (end - start) >= (MAX_DVM_OPS * stride)) ||
> -	    pages > MAX_TLBI_RANGE_PAGES)
> +	if (system_supports_tlb_range() && pages > MAX_TLBI_RANGE_PAGES)
>  		return true;
>  
> -	return false;
> +	return pages >= (MAX_DVM_OPS * stride) >> PAGE_SHIFT;
>  }

I'm still not sure I totally get this... Aren't these really 2 separate
concepts? MAX_TLBI_RANGE_PAGES is the max amount of VA that can be handled by a
single tlbi-by-range (and due to implementation, the largest range that can be
handled by the loop in __flush_tlb_range_op()). Whereas MAX_DVM_OPS is the max
number of tlbi instrcutions you want to issue with the PTL held? Perhaps it is
better to split these out; For the range case, calculate the number of ops you
actually need and compare with MAX_DVM_OPS?


>  
>  static inline void __flush_tlb_range_nosync(struct mm_struct *mm,
> @@ -498,7 +490,7 @@ static inline void __flush_tlb_range_nosync(struct mm_struct *mm,
>  	end = round_up(end, stride);
>  	pages = (end - start) >> PAGE_SHIFT;
>  
> -	if (__flush_tlb_range_limit_excess(start, end, pages, stride)) {
> +	if (__flush_tlb_range_limit_excess(pages, stride)) {
>  		flush_tlb_mm(mm);
>  		return;
>  	}
> @@ -547,7 +539,7 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
>  	end = round_up(end, stride);
>  	pages = (end - start) >> PAGE_SHIFT;
>  
> -	if (__flush_tlb_range_limit_excess(start, end, pages, stride)) {
> +	if (__flush_tlb_range_limit_excess(pages, stride)) {
>  		flush_tlb_all();
>  		return;
>  	}


