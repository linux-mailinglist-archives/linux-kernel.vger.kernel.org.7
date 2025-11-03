Return-Path: <linux-kernel+bounces-882263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 548E5C2A030
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 05:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 036C2347C25
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 04:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08119271443;
	Mon,  3 Nov 2025 04:05:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB86486334
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 04:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762142730; cv=none; b=Z1kwvqwJIJfgiJMzjweEFyiASg+FYjGcevF1LVOFMk4RqbI7M8IuAphN/UEJGM2J5oEjxyCVs82JIVUD34ZftAEyM4HkW42CpXkYZBbFGD9eqWe7FhmJ1cbj91ml8Bgym9ZKSLGMvmXoCnr3lz6rdww8dtBysNEPIbA92pMgQrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762142730; c=relaxed/simple;
	bh=cOvft/VEXH5Y1gTQEZipy0M11NPbXJqh0x2s2ydJ4LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUTze1vg5EcQ1sa6zLuS4+TMl9l33ejdrIuaE8KRTKXwNX8Ag4kJEVPU/TsdN34Bg8gcfjQWdwjLfLJxDvzKdrINFikqUL7RaAYkCjM/usNHqtrmoFim9mt5cyshlpYdpTmMijOi28j3V6iUIhzqOqPyjzQkYIGubLqJwX54zJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D20A51A9A;
	Sun,  2 Nov 2025 20:05:18 -0800 (PST)
Received: from [10.164.136.41] (unknown [10.164.136.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5FCD3F694;
	Sun,  2 Nov 2025 20:05:23 -0800 (PST)
Message-ID: <e564295b-d5b6-4544-ab8e-dad48a2aee1e@arm.com>
Date: Mon, 3 Nov 2025 09:35:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] [PATCH v2] arm64/mm: Elide TLB flush in certain pte
 protection transitions
To: catalin.marinas@arm.com, will@kernel.org
Cc: anshuman.khandual@arm.com, wangkefeng.wang@huawei.com,
 ryan.roberts@arm.com, baohua@kernel.org, pjaroszynski@nvidia.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251017160251.96717-1-dev.jain@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251017160251.96717-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Gentle ping

On 17/10/25 9:32 pm, Dev Jain wrote:
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
> 2.85 microseconds, giving a 12.3% improvement.
>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
> mm-selftests pass. Based on 6.18-rc1.
>
> v1->v2:
>   - Drop PTE_PRESENT_INVALID and PTE_AF checks, use ptdesc_t instead of
>     pteval_t, return !!diff (Ryan)
>
>   arch/arm64/include/asm/tlbflush.h | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 18a5dc0c9a54..40df783ba09a 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -524,6 +524,33 @@ static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *b
>   {
>   	__flush_tlb_range_nosync(mm, start, end, PAGE_SIZE, true, 3);
>   }
> +
> +static inline bool __pte_flags_need_flush(ptdesc_t oldval, ptdesc_t newval)
> +{
> +	ptdesc_t diff = oldval ^ newval;
> +
> +	/* invalid to valid transition requires no flush */
> +	if (!(oldval & PTE_VALID))
> +		return false;
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
>   #endif
>   
>   #endif

