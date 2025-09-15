Return-Path: <linux-kernel+bounces-816035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85876B56E79
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 05:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9453BBF85
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D00212548;
	Mon, 15 Sep 2025 03:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G+Uo7hGn"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7895A57C9F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757905347; cv=none; b=TqqmuTt9HIvvLLVm/NGrYfpxoFN+nab1NldSK4V0VWQi0TbTCocwmQzVNnZgy6WgVng0/x7/DW9uW5tJeVqfEmpowdKBP8bQf9XRUXhGKkRYAeLlhXByi+fePYr64qb6Ih1rBiEtkDM3VrHyTA0mV0VRt2MHVPx/IifpxI3tS9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757905347; c=relaxed/simple;
	bh=fhnCjnA2uecuJbYizAIbJadlQYVFUl/FnXdkKah6TYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AmdrCv/lHzJi8CynlJi9u/1Iv1O5Oup6mzuClm3UkL7lbEf+yMKVyZ6GYdIa5D35BLCO8HZgJrTFkhGxyBxH0bnqtFv9Qv95z9IGtPlPBb/B122gcCQuwAUGJqiFba087ErveGTy9gbfvlOaWQTVjKpRvfz2puVdag12bedRaEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G+Uo7hGn; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <016e4d4c-c16b-45d5-a903-681afc6b4203@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757905341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AEcarrc2+8ifIeyobydV/xFWrr9hTTutZzw8IUFdV5g=;
	b=G+Uo7hGnDZ1c7SlCcAmx4kxesEfclvRm6kNBIYrJE2rjg3psEjvldYdQdL9oVfBxFTYnNl
	WYaVn1GJPmFzlifBpSeZ4jQIFuR0DifF7W2B6vUMRS+GttAoEuRTTlvsp9ZRnkG9uKkt0V
	V8wD95ttVwwTScYDc30lsKlVEFeL++w=
Date: Mon, 15 Sep 2025 11:02:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new 1/3] mm/khugepaged: skip unsuitable VMAs earlier in
 khugepaged_scan_mm_slot()
Content-Language: en-US
To: Dev Jain <dev.jain@arm.com>
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, david@redhat.com
References: <20250914143547.27687-1-lance.yang@linux.dev>
 <20250914143547.27687-2-lance.yang@linux.dev>
 <a62b7461-3faf-494c-bd00-0206de184a5a@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <a62b7461-3faf-494c-bd00-0206de184a5a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hey Dev,

Thanks for taking time to review!

On 2025/9/15 00:16, Dev Jain wrote:
> 
> On 14/09/25 8:05 pm, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> Let's skip unsuitable VMAs early in the khugepaged scan; specifically,
>> mlocked VMAs should not be touched.
>>
>> Note that the only other user of the VM_NO_KHUGEPAGED mask is
>>   __thp_vma_allowable_orders(), which is also used by the MADV_COLLAPSE
>> path. Since MADV_COLLAPSE has different rules (e.g., for mlocked 
>> VMAs), we
>> cannot simply make the shared mask stricter as that would break it.
>>
>> So, we also introduce a new VM_NO_THP_COLLAPSE mask for that helper,
>> leaving the stricter checks to be applied only within the khugepaged path
>> itself.
>>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   include/linux/mm.h |  6 +++++-
>>   mm/huge_memory.c   |  2 +-
>>   mm/khugepaged.c    | 14 +++++++++++++-
>>   3 files changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index be3e6fb4d0db..cb54d94b2343 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -505,7 +505,11 @@ extern unsigned int kobjsize(const void *objp);
>>   #define VM_REMAP_FLAGS (VM_IO | VM_PFNMAP | VM_DONTEXPAND | 
>> VM_DONTDUMP)
>>   /* This mask prevents VMA from being scanned with khugepaged */
>> -#define VM_NO_KHUGEPAGED (VM_SPECIAL | VM_HUGETLB)
>> +#define VM_NO_KHUGEPAGED \
>> +    (VM_SPECIAL | VM_HUGETLB | VM_LOCKED_MASK | VM_NOHUGEPAGE)
>> +
>> +/* This mask prevents VMA from being collapsed by any THP path */
>> +#define VM_NO_THP_COLLAPSE    (VM_SPECIAL | VM_HUGETLB)
> 
> VM_NO_KHUGEPAGED should then be defined as VM_NO_THP_COLLAPSE | 
> VM_LOCKED_MASK | VM_NOHUGEPAGE.

Yep, it's a good cleanup ;)

> But...
> 
> I believe that the eligibility checking for khugepaged collapse is the 
> business of
> thp_vma_allowable_order(). This functionality should be put there, we 
> literally
> have a TVA_KHUGEPAGED flag :)

Good spot. That's a much better apporach!

My initial thinking was to keep thp_vma_allowable_order() as generic as
possible, avoiding specific checks for individual callers ;)

BUT you are right, the TVA_KHUGEPAGED flag is only passed from the
khugepaged path, so the compiler will optimize out the branch for other
callers, leaving no runtime overhead.

Will rework this patch for v2 as your suggestion!

Thanks,
Lance

> 
>>   /* This mask defines which mm->def_flags a process can inherit its 
>> parent */
>>   #define VM_INIT_DEF_MASK    VM_NOHUGEPAGE
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index d6fc669e11c1..2e91526a037f 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -134,7 +134,7 @@ unsigned long __thp_vma_allowable_orders(struct 
>> vm_area_struct *vma,
>>        * Must be checked after dax since some dax mappings may have
>>        * VM_MIXEDMAP set.
>>        */
>> -    if (!in_pf && !smaps && (vm_flags & VM_NO_KHUGEPAGED))
>> +    if (!in_pf && !smaps && (vm_flags & VM_NO_THP_COLLAPSE))
>>           return 0;
>>       /*
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 7c5ff1b23e93..e54f99bb0b57 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -345,6 +345,17 @@ struct attribute_group khugepaged_attr_group = {
>>   };
>>   #endif /* CONFIG_SYSFS */
>> +/**
>> + * khugepaged_should_scan_vma - check if a VMA is a candidate for 
>> collapse
>> + * @vm_flags: The flags of the VMA to check.
>> + *
>> + * Returns: true if the VMA should be scanned by khugepaged, false 
>> otherwise.
>> + */
>> +static inline bool khugepaged_should_scan_vma(vm_flags_t vm_flags)
>> +{
>> +    return !(vm_flags & VM_NO_KHUGEPAGED);
>> +}
>> +
>>   int hugepage_madvise(struct vm_area_struct *vma,
>>                vm_flags_t *vm_flags, int advice)
>>   {
>> @@ -2443,7 +2454,8 @@ static unsigned int 
>> khugepaged_scan_mm_slot(unsigned int pages, int *result,
>>               progress++;
>>               break;
>>           }
>> -        if (!thp_vma_allowable_order(vma, vma->vm_flags, 
>> TVA_KHUGEPAGED, PMD_ORDER)) {
>> +        if (!khugepaged_should_scan_vma(vma->vm_flags) ||
>> +            !thp_vma_allowable_order(vma, vma->vm_flags, 
>> TVA_KHUGEPAGED, PMD_ORDER)) {
>>   skip:
>>               progress++;
>>               continue;


