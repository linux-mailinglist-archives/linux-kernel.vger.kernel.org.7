Return-Path: <linux-kernel+bounces-826155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E676B8DABF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 14:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2813A3B4FC6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 12:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14492749E2;
	Sun, 21 Sep 2025 12:23:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F112E40B
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 12:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457420; cv=none; b=ICzkM8Y0wUigiicufh025caom/1BUoaEdlJ4vdO8tImKRZEiqgfg1o/kpchF+mmnQa3H0AHXcdGOcrWc4Q3vBr2+G/RL02KnG4fZPc4Ut5cpDk/bdvJsKtMb9WENZkE0K1GkkEl2LUMU+JLn+96YelhnH1HDC+cmHfPia2wmn4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457420; c=relaxed/simple;
	bh=xsCweM0SLWTm6tOF7yEPI/xV7qi/PGFoGuEQp07uM1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G56z/gkjGc6JzPqK58BF8CcMpTd840FvUwx3WYubwGJpy38QvcsX7vmc/R7li33HSEsyO+7pKLePPrb6VgcDAZwpKCOzEMrKELoS95OdvaQtgLR4/VZb9qEy+aVqafdIFW0ObwVFvzI+YMsXMKOQ8ENpjwQbXMauwbBwLj0PeRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0AFE1516;
	Sun, 21 Sep 2025 05:23:28 -0700 (PDT)
Received: from [10.163.39.139] (unknown [10.163.39.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 729483F66E;
	Sun, 21 Sep 2025 05:23:34 -0700 (PDT)
Message-ID: <d84eef92-115e-4b71-9146-86fc91244c15@arm.com>
Date: Sun, 21 Sep 2025 17:53:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64/mm: Elide TLB flush in certain pte protection
 transitions
To: Dev Jain <dev.jain@arm.com>, catalin.marinas@arm.com, will@kernel.org
Cc: wangkefeng.wang@huawei.com, ryan.roberts@arm.com, baohua@kernel.org,
 pjaroszynski@nvidia.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250920051043.16421-1-dev.jain@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250920051043.16421-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/09/25 10:40 AM, Dev Jain wrote:
> Currently arm64 does an unconditional TLB flush in mprotect(). This is not
> required for some cases, for example, when changing from PROT_NONE to
> PROT_READ | PROT_WRITE (a real usecase - glibc malloc does this to emulate

The following transition does not require a TLB flush on all
architectures ? In which case, should not this check be part
of generic mprotect() itself.

PROT_NONE ---> PROT_READ | PROT_WRITE
> growing into the non-main heaps), and unsetting uffd-wp in a range.
> 
> Therefore, implement pte_needs_flush() for arm64, which is already
> implemented by some other arches as well.

Agreed, defining pte_needs_flush() on the platform does make
sense, if it brings some perf improvement without additional
cost.
> 
> Running a userspace program changing permissions back and forth between
> PROT_NONE and PROT_READ | PROT_WRITE, and measuring the average time taken
> for the none->rw transition, I get a reduction from 3.2 microseconds to
> 2.85 microseconds, giving a 12.3% improvement.

But that's a very specific workload intended to demonstrate
the use case for this change. Hence the improvement claimed
here is not representative of real world work loads.
> 
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
> mm-selftests pass.
> 
> v1->v2:
>  - Drop PTE_PRESENT_INVALID and PTE_AF checks, use ptdesc_t instead of
>    pteval_t, return !!diff (Ryan)
> 
>  arch/arm64/include/asm/tlbflush.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 18a5dc0c9a54..40df783ba09a 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -524,6 +524,33 @@ static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *b
>  {
>  	__flush_tlb_range_nosync(mm, start, end, PAGE_SIZE, true, 3);
>  }
> +
> +static inline bool __pte_flags_need_flush(ptdesc_t oldval, ptdesc_t newval)
> +{
> +	ptdesc_t diff = oldval ^ newval;
> +
> +	/* invalid to valid transition requires no flush */
> +	if (!(oldval & PTE_VALID))
> +		return false;

Is not this true for all platforms which could be checked via
pte_present() helper ? Hence should not this be moved inside
the caller itself in generic MM ? I guess probably the above
mentioned transition should be moved as well.

PROT_NONE ---> PROT_READ | PROT_WRITE
> +
> +	/* Transition in the SW bits requires no flush */
> +	diff &= ~PTE_SWBITS_MASK;
> +
> +	return !!diff;
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


