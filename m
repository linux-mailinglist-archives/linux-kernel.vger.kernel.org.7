Return-Path: <linux-kernel+bounces-822777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FE6B84A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744AF522446
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE9421B199;
	Thu, 18 Sep 2025 12:47:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C86A303CBE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199621; cv=none; b=Noc3/ru+BZkd3xKFBtR+JKIVRc4N4xr916LlqkGmjsS6cDAJ3DgZWeW+pDNYLSDMeYknqXnlenMscEVwTOiVYIW4rig/wIazydao1gQ0OgpzT4K1sLoaAn3T+zJUFP/wc3wyF3b7f4wcNjMFgsaeZ6m8D/ktZBVGeq0+6GE9r3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199621; c=relaxed/simple;
	bh=YqjonaFy98Souif8jMRYUc4Bgn2SynbvZ18mfDfh53A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d83TGAK2Oeu7sX9Rv5Wp4fFLRZ3FP+yAhUJowGUJnuBG3gboQ986JCdnJUyJTTH7Crh21/8KutVlSaoroj6y/pcOuRg/BHE3zIKFbGdU3I5sV2sf33D36BR2QYYeWTIvuarYIeJCilqCSYJm2usGK5HEXYjrR9R3MnjDeVNphAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F3FB1A25;
	Thu, 18 Sep 2025 05:46:50 -0700 (PDT)
Received: from [10.163.74.75] (unknown [10.163.74.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B5693F673;
	Thu, 18 Sep 2025 05:46:52 -0700 (PDT)
Message-ID: <41443985-341b-4139-ab20-be2ac96e31d4@arm.com>
Date: Thu, 18 Sep 2025 18:16:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Elide TLB flush in certain pte protection
 transitions
To: Kefeng Wang <wangkefeng.wang@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: anshuman.khandual@arm.com, ryan.roberts@arm.com, baohua@kernel.org,
 pjaroszynski@nvidia.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250918103638.77282-1-dev.jain@arm.com>
 <2bd52a76-c92a-431d-a26a-ad98ede14431@huawei.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <2bd52a76-c92a-431d-a26a-ad98ede14431@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 18/09/25 5:52 pm, Kefeng Wang wrote:
>
>
> On 2025/9/18 18:36, Dev Jain wrote:
>> Currently arm64 does an unconditional TLB flush in mprotect(). This 
>> is not
>> required for some cases, for example, when changing from PROT_NONE to
>> PROT_READ | PROT_WRITE (a real usecase - glibc malloc does this to 
>> emulate
>> growing into the non-main heaps), and unsetting uffd-wp in a range.
>>
>> Therefore, implement pte_needs_flush() for arm64, which is already
>> implemented by some other arches as well.
>>
>> Running a userspace program changing permissions back and forth between
>> PROT_NONE and PROT_READ | PROT_WRITE, and measuring the average time 
>> taken
>> for the none->rw transition, I get a reduction from 3.2 microseconds to
>> 2.95 microseconds, giving an 8.5% improvement.
>>
>
> Hi Dev，
>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>> mm-selftests pass. Based on 6.17-rc6.
>>
>>   arch/arm64/include/asm/tlbflush.h | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/tlbflush.h 
>> b/arch/arm64/include/asm/tlbflush.h
>> index 18a5dc0c9a54..4a566d589100 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -524,6 +524,35 @@ static inline void 
>> arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *b
>>   {
>>       __flush_tlb_range_nosync(mm, start, end, PAGE_SIZE, true, 3);
>>   }
>> +
>> +static inline bool __pte_flags_need_flush(pteval_t oldval, pteval_t 
>> newval)
>> +{
>> +    pteval_t diff = oldval ^ newval;
>> +
>> +    /* invalid to valid transition requires no flush */
>> +    if (!(oldval & PTE_VALID) || (oldval & PTE_PRESENT_INVALID))
>> +        return false;
>> +
>> +    /* Transition in the SW bits and access flag requires no flush */
>> +    diff &= ~(PTE_SWBITS_MASK | PTE_AF);
>> +
>> +    if (!diff)
>> +        return false;
>> +    return true;
>> +}
>> +
>
> LibMicro mprotect testcase show 3~5% improvement with different size in
> old kernel(we did this before, but only check PTE_VALID and 
> PTE_PROT_NONE in our kernel), it seems that no one change other sw bit 
> by mprotect?

Not mprotect, but when unsetting uffd-wp, we do mwriteprotect_range -> 
uffd_wp_range -> change_protection() with MM_CP_UFFD_WP_RESOLVE set.


>
> Anyway, Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Thanks!


>
>> +static inline bool pte_needs_flush(pte_t oldpte, pte_t newpte)
>> +{
>> +    return __pte_flags_need_flush(pte_val(oldpte), pte_val(newpte));
>> +}
>> +#define pte_needs_flush pte_needs_flush
>> +
>> +static inline bool huge_pmd_needs_flush(pmd_t oldpmd, pmd_t newpmd)
>> +{
>> +    return __pte_flags_need_flush(pmd_val(oldpmd), pmd_val(newpmd));
>> +}
>> +#define huge_pmd_needs_flush huge_pmd_needs_flush
>> +
>>   #endif
>>     #endif
>

