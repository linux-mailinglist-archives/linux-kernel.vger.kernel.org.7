Return-Path: <linux-kernel+bounces-896518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF2AC50908
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC5B3B0CB2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 04:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C707F2D73BE;
	Wed, 12 Nov 2025 04:52:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B802D77FF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762923129; cv=none; b=YhI6Pz5jSMySRO8AHp9gvsJWAT8Q3cIogad4pSNpK0DLA9b8tlrxVNxoU/PBlV3F9dua7w8xTA109Zma+OsMxqntkHEMV7MY+qH1g/Tk+M8AhNctnUyv6G37SaERWUDCAR6/w01I3jwQ73cFHnNBru2ipuZ1mlJlXyf32CISIO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762923129; c=relaxed/simple;
	bh=A6Fo8v4HCC+TE1csMVlUzc3yxlfVPzFTHkIm5B1KNEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQByEb8N2g0YKfwDa+muzr2n1Vg2JkZq0IcDgIyUVAsyJrU7U++ZO4myBI7NhSXENi3czrd/IzSyBfj5LtDruwINp5U+8YnhX46SnOWL9rsEoVvYkOHtkO/ldKuuCYCX6/cgk47TIuPhK2Hh2yQxvZiRAipP1renZ0ZIWxWalUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD9971515;
	Tue, 11 Nov 2025 20:51:56 -0800 (PST)
Received: from [10.164.18.56] (unknown [10.164.18.56])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7B2A3F66E;
	Tue, 11 Nov 2025 20:52:01 -0800 (PST)
Message-ID: <24887a95-8959-4ae7-a8f3-6d5ce6ad6e41@arm.com>
Date: Wed, 12 Nov 2025 10:21:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] [PATCH v2] arm64/mm: Elide TLB flush in certain pte
 protection transitions
To: Anshuman Khandual <anshuman.khandual@arm.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: wangkefeng.wang@huawei.com, ryan.roberts@arm.com, baohua@kernel.org,
 pjaroszynski@nvidia.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251017160251.96717-1-dev.jain@arm.com>
 <fcb92f87-063e-4042-8313-0154941404fa@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <fcb92f87-063e-4042-8313-0154941404fa@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 04/11/25 5:45 am, Anshuman Khandual wrote:
>
> On 17/10/25 9:32 PM, Dev Jain wrote:
>> Currently arm64 does an unconditional TLB flush in mprotect(). This is not
>> required for some cases, for example, when changing from PROT_NONE to
>> PROT_READ | PROT_WRITE (a real usecase - glibc malloc does this to emulate
>> growing into the non-main heaps), and unsetting uffd-wp in a range.
>>
>> Therefore, implement pte_needs_flush() for arm64, which is already
>> implemented by some other arches as well.
>>
>> Running a userspace program changing permissions back and forth between
>> PROT_NONE and PROT_READ | PROT_WRITE, and measuring the average time taken
>> for the none->rw transition, I get a reduction from 3.2 microseconds to
>> 2.85 microseconds, giving a 12.3% improvement.
>>
>> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>> mm-selftests pass. Based on 6.18-rc1.
>>
>> v1->v2:
>>   - Drop PTE_PRESENT_INVALID and PTE_AF checks, use ptdesc_t instead of
>>     pteval_t, return !!diff (Ryan)
>>
>>   arch/arm64/include/asm/tlbflush.h | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>> index 18a5dc0c9a54..40df783ba09a 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -524,6 +524,33 @@ static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *b
>>   {
>>   	__flush_tlb_range_nosync(mm, start, end, PAGE_SIZE, true, 3);
>>   }
>> +
>> +static inline bool __pte_flags_need_flush(ptdesc_t oldval, ptdesc_t newval)
>> +{
>> +	ptdesc_t diff = oldval ^ newval;
>> +
>> +	/* invalid to valid transition requires no flush */
>> +	if (!(oldval & PTE_VALID))
> Using pte_valid() helper would be better.
>
> 	if (!pte_valid(oldval))
> 		return false;

Unfortunately, that would need asm/pgtable.h, which already includes asm/tlbflush.h,
leading to circular include.

If I put all this code into asm/pgtable.h, then pte_valid() needs a pte_t or a pmd_t
to work on, which forces us to break away from the nice abstraction of directing
both pte_needs_flush and huge_pmd_needs_flush to __pte_flags_need_flush.


>> +		return false;
>> +
>> +	/* Transition in the SW bits requires no flush */
>> +	diff &= ~PTE_SWBITS_MASK;
>> +
>> +	return !!diff;
>> +}
>> +
>> +static inline bool pte_needs_flush(pte_t oldpte, pte_t newpte)
>> +{
>> +	return __pte_flags_need_flush(pte_val(oldpte), pte_val(newpte));
>> +}
>> +#define pte_needs_flush pte_needs_flush
>> +
>> +static inline bool huge_pmd_needs_flush(pmd_t oldpmd, pmd_t newpmd)
>> +{
>> +	return __pte_flags_need_flush(pmd_val(oldpmd), pmd_val(newpmd));
>> +}
>> +#define huge_pmd_needs_flush huge_pmd_needs_flush
>> +
>>   #endif
>>   
>>   #endif

