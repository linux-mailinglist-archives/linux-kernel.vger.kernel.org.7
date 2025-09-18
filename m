Return-Path: <linux-kernel+bounces-822784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF232B84A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860BF1C84335
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB11304BCD;
	Thu, 18 Sep 2025 12:49:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E06D2F068E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199748; cv=none; b=SJRVkZ/6E32FFaZWTRJ4Sjv42d8iEcxCpkKoou2SQhckxc4OH2DETvYI+UGx7Dhl6+bmOR1oA/BRbYBYXuHhPl2qNZLc70jtc9hJp5I/fb/4T5cy2+d+F6hLOXdP37tU32CbFlDxmClDLlXVUb7mkIql8jPy5KnP+QKLLMKsNnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199748; c=relaxed/simple;
	bh=hJ0tdaanriQPwBtblPJDgqQ1T6E5EGo67YCgCLh4xa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+SRkO+JM/OU/Em+cT+3dd513r8NBIgKRL2SaPp30UhbOMJc/dCgeT1AWpZXr0m/MLAuTrb0Fl1SfVpscQaLx9nONXrdFa2rb+UK+0XFc14nFsxVx7Mg+yMmrcjMrIfadM9GtW4/tMd9iK0922Bv6YMZSTsCw7j2bQrM/TrIE34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0C1C1A2D;
	Thu, 18 Sep 2025 05:48:57 -0700 (PDT)
Received: from [10.1.33.171] (XHFQ2J9959.cambridge.arm.com [10.1.33.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D2453F673;
	Thu, 18 Sep 2025 05:49:04 -0700 (PDT)
Message-ID: <fb5818ec-dde9-4d53-ab0f-e28e5c2cab33@arm.com>
Date: Thu, 18 Sep 2025 13:49:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Elide TLB flush in certain pte protection
 transitions
Content-Language: en-GB
To: Dev Jain <dev.jain@arm.com>, catalin.marinas@arm.com, will@kernel.org
Cc: anshuman.khandual@arm.com, wangkefeng.wang@huawei.com, baohua@kernel.org,
 pjaroszynski@nvidia.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250918103638.77282-1-dev.jain@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250918103638.77282-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/09/2025 11:36, Dev Jain wrote:
> Currently arm64 does an unconditional TLB flush in mprotect(). This is not
> required for some cases, for example, when changing from PROT_NONE to
> PROT_READ | PROT_WRITE (a real usecase - glibc malloc does this to emulate
> growing into the non-main heaps), and unsetting uffd-wp in a range.
> 
> Therefore, implement pte_needs_flush() for arm64, which is already
> implemented by some other arches as well.
> 
> Running a userspace program changing permissions back and forth between
> PROT_NONE and PROT_READ | PROT_WRITE, and measuring the average time taken
> for the none->rw transition, I get a reduction from 3.2 microseconds to
> 2.95 microseconds, giving an 8.5% improvement.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
> mm-selftests pass. Based on 6.17-rc6.
> 
>  arch/arm64/include/asm/tlbflush.h | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 18a5dc0c9a54..4a566d589100 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -524,6 +524,35 @@ static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *b
>  {
>  	__flush_tlb_range_nosync(mm, start, end, PAGE_SIZE, true, 3);
>  }
> +
> +static inline bool __pte_flags_need_flush(pteval_t oldval, pteval_t newval)

ptdesc_t is the preferred any-level type.

> +{
> +	pteval_t diff = oldval ^ newval;
> +
> +	/* invalid to valid transition requires no flush */
> +	if (!(oldval & PTE_VALID) || (oldval & PTE_PRESENT_INVALID))

Is the PTE_PRESENT_INVALID really required? If the oldval was invalid, there
can't be a TLB entry for it, so no flush is required; that's it, I think?

In fact, PTE_PRESENT_INVALID is overlaid with PTE_NG; it only means
PTE_PRESENT_INVALID when PTE_INVALID=0, so I think this is broken as is. Valid
user-space PTEs always have PTE_NG set, so you will never flush.

> +		return false;
> +
> +	/* Transition in the SW bits and access flag requires no flush */
> +	diff &= ~(PTE_SWBITS_MASK | PTE_AF);

Could you explain your thinking on why PTE_AF changes don't need a flush? I
would have thought if we want to clear the access flag, that would definitely
require a flush? Otherwise how would the MMU know to set the acccess bit on next
access if it already has a TLB entry?

> +
> +	if (!diff)
> +		return false;
> +	return true;

Perhaps just "return !!diff;" here?

Thanks,
Ryan


> +}
> +
> +static inline bool pte_needs_flush(pte_t oldpte, pte_t newpte)
> +{
> +	return __pte_flags_need_flush(pte_val(oldpte), pte_val(newpte));
> +}
> +#define pte_needs_flush pte_needs_flush
> +
> +static inline bool huge_pmd_needs_flush(pmd_t oldpmd, pmd_t newpmd)
> +{
> +	return __pte_flags_need_flush(pmd_val(oldpmd), pmd_val(newpmd));
> +}
> +#define huge_pmd_needs_flush huge_pmd_needs_flush
> +
>  #endif
>  
>  #endif


