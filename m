Return-Path: <linux-kernel+bounces-822739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 352D4B848F6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2B24A37E4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2682F90D8;
	Thu, 18 Sep 2025 12:23:05 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE282EA49F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198184; cv=none; b=XTStgXQP6B73GkpmCEm6jHWyP3Urr0pY5qn6tigI6aV2ouJHb9ml0mBB3fjpnB4Terj4BD185KYgE9lIJl4lg3AgZ639Hlm+TT4xAT7Tc4HfuuqnX5xeTaEF9G04zmB3YR8+EeDhzvz4JE4YpE9ZrywdlrNiwRLvMpy9Gy9AIk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198184; c=relaxed/simple;
	bh=s1uFxojmfNRdQGizgKq8BqYlo2GXxYF3LvxgiPtxz4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kIKIuq6LvCZx1z0VLKI7WvreStCIh+sjhObUXX5Eykx36rlU1q2CvhG/TXch0TCsyVnk2SDFb6pi8QqBpBWlq+fR7Y6aN607GMrRWEcFhPDJvdmf4ZfipE3+uGJrEeCYfFGZG2hPia/bQBcY4HeLKKAjDSBpEvCBtXsHWboiimg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cSF7j4llqz1R9RG;
	Thu, 18 Sep 2025 20:19:45 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id DCFD11A0188;
	Thu, 18 Sep 2025 20:22:51 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Sep 2025 20:22:50 +0800
Message-ID: <2bd52a76-c92a-431d-a26a-ad98ede14431@huawei.com>
Date: Thu, 18 Sep 2025 20:22:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Elide TLB flush in certain pte protection
 transitions
To: Dev Jain <dev.jain@arm.com>, <catalin.marinas@arm.com>, <will@kernel.org>
CC: <anshuman.khandual@arm.com>, <ryan.roberts@arm.com>, <baohua@kernel.org>,
	<pjaroszynski@nvidia.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250918103638.77282-1-dev.jain@arm.com>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20250918103638.77282-1-dev.jain@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2025/9/18 18:36, Dev Jain wrote:
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

Hi Dev，

> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
> mm-selftests pass. Based on 6.17-rc6.
> 
>   arch/arm64/include/asm/tlbflush.h | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 18a5dc0c9a54..4a566d589100 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -524,6 +524,35 @@ static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *b
>   {
>   	__flush_tlb_range_nosync(mm, start, end, PAGE_SIZE, true, 3);
>   }
> +
> +static inline bool __pte_flags_need_flush(pteval_t oldval, pteval_t newval)
> +{
> +	pteval_t diff = oldval ^ newval;
> +
> +	/* invalid to valid transition requires no flush */
> +	if (!(oldval & PTE_VALID) || (oldval & PTE_PRESENT_INVALID))
> +		return false;
> +
> +	/* Transition in the SW bits and access flag requires no flush */
> +	diff &= ~(PTE_SWBITS_MASK | PTE_AF);
> +
> +	if (!diff)
> +		return false;
> +	return true;
> +}
> +

LibMicro mprotect testcase show 3~5% improvement with different size in
old kernel(we did this before, but only check PTE_VALID and 
PTE_PROT_NONE in our kernel), it seems that no one change other sw bit 
by mprotect?

Anyway, Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

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


