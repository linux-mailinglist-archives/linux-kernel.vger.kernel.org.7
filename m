Return-Path: <linux-kernel+bounces-602354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F14EA879C0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 10:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A75E37A797B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 08:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160FE259C80;
	Mon, 14 Apr 2025 08:06:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C1442077
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744617967; cv=none; b=Tl9fZRygpBafEukroszkfW0zyLPoJXt1D3Xh2Tc3nchblGieRLYXrmCUTzzoVdq2bj+DMdNlulezCxtnwHL5cATZ9tkV8Q/ht1gDy8iJ1HyrVTipKJKyN/ZiWB0KdV9NT2hWiuHh6Ki/HnYfVwWlFKNSTKh6WDQxE6AT/fjxPb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744617967; c=relaxed/simple;
	bh=+9AjLfUFiR9WlmRw2lss0Jg55nJjHCM05aecGDBkQIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2WdEaeySwaBAFiZCmmYzVTMGXEFK4NVta4V6wmluNheRqCVCkxWwszZVMiDgdXSWcl0IjBeCb4Fb881EGqlaJP0Fbvo63A7Y+Ajnv0h0Ednn+BCS7EeojCFHS6zu6SbQeZaiwRzeSG2MpKdU/xsGhT5ALvm+i6H/APHrpdEiuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C21FE1007;
	Mon, 14 Apr 2025 01:06:02 -0700 (PDT)
Received: from [10.57.88.7] (unknown [10.57.88.7])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21D1E3F694;
	Mon, 14 Apr 2025 01:06:01 -0700 (PDT)
Message-ID: <1613c84e-1e65-44cd-9f23-1c9870df4655@arm.com>
Date: Mon, 14 Apr 2025 09:06:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/contpte: Optimize loop to reduce redundant
 operations
Content-Language: en-GB
To: Lance Yang <ioworker0@gmail.com>, Dev Jain <dev.jain@arm.com>,
 Xavier <xavier_qy@163.com>
Cc: Barry Song <21cnbao@gmail.com>, catalin.marinas@arm.com, will@kernel.org,
 akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>
References: <20250407092243.2207837-1-xavier_qy@163.com>
 <CAGsJ_4wsW+urp6gbp+yDG40fZw9Bszny2iJVsV_AzzGqgQy+4g@mail.gmail.com>
 <7dccb3a2-f5e2-4f9e-8f5c-465a1d3ffdb6@arm.com>
 <CAK1f24=5-VVJoE75wrskXxrGi=KmrbxSYH9P69PRPiOxQuArpA@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAK1f24=5-VVJoE75wrskXxrGi=KmrbxSYH9P69PRPiOxQuArpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/04/2025 06:05, Lance Yang wrote:
> On Sat, Apr 12, 2025 at 1:30 AM Dev Jain <dev.jain@arm.com> wrote:
>>
>> +others
>>
>> On 11/04/25 2:55 am, Barry Song wrote:
>>> On Mon, Apr 7, 2025 at 9:23 PM Xavier <xavier_qy@163.com> wrote:
>>>>
>>>> This commit optimizes the contpte_ptep_get function by adding early
>>>>   termination logic. It checks if the dirty and young bits of orig_pte
>>>>   are already set and skips redundant bit-setting operations during
>>>>   the loop. This reduces unnecessary iterations and improves performance.
>>>>
>>>> Signed-off-by: Xavier <xavier_qy@163.com>
>>>> ---
>>>>   arch/arm64/mm/contpte.c | 13 +++++++++++--
>>>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
>>>> index bcac4f55f9c1..ca15d8f52d14 100644
>>>> --- a/arch/arm64/mm/contpte.c
>>>> +++ b/arch/arm64/mm/contpte.c
>>>> @@ -163,17 +163,26 @@ pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte)
>>>>
>>>>          pte_t pte;
>>>>          int i;
>>>> +       bool dirty = false;
>>>> +       bool young = false;
>>>>
>>>>          ptep = contpte_align_down(ptep);
>>>>
>>>>          for (i = 0; i < CONT_PTES; i++, ptep++) {
>>>>                  pte = __ptep_get(ptep);
>>>>
>>>> -               if (pte_dirty(pte))
>>>> +               if (!dirty && pte_dirty(pte)) {
>>>> +                       dirty = true;
>>>>                          orig_pte = pte_mkdirty(orig_pte);
>>>> +               }
>>>>
>>>> -               if (pte_young(pte))
>>>> +               if (!young && pte_young(pte)) {
>>>> +                       young = true;
>>>>                          orig_pte = pte_mkyoung(orig_pte);
>>>> +               }
>>>> +
>>>> +               if (dirty && young)
>>>> +                       break;
>>>
>>> This kind of optimization is always tricky. Dev previously tried a similar
>>> approach to reduce the loop count, but it ended up causing performance
>>> degradation:
>>> https://lore.kernel.org/linux-mm/20240913091902.1160520-1-dev.jain@arm.com/
>>>
>>> So we may need actual data to validate this idea.
>>
>> The original v2 patch does not work, I changed it to the following:
>>
>> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
>> index bcac4f55f9c1..db0ad38601db 100644
>> --- a/arch/arm64/mm/contpte.c
>> +++ b/arch/arm64/mm/contpte.c
>> @@ -152,6 +152,16 @@ void __contpte_try_unfold(struct mm_struct *mm,
>> unsigned long addr,
>>   }
>>   EXPORT_SYMBOL_GPL(__contpte_try_unfold);
>>
>> +#define CHECK_CONTPTE_FLAG(start, ptep, orig_pte, flag) \
>> +       int _start; \
>> +       pte_t *_ptep = ptep; \
>> +       for (_start = start; _start < CONT_PTES; _start++, ptep++) { \
>> +               if (pte_##flag(__ptep_get(_ptep))) { \
>> +                       orig_pte = pte_mk##flag(orig_pte); \
>> +                       break; \
>> +               } \
>> +       }
>> +
>>   pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte)
>>   {
>>          /*
>> @@ -169,11 +179,17 @@ pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte)
>>          for (i = 0; i < CONT_PTES; i++, ptep++) {
>>                  pte = __ptep_get(ptep);
>>
>> -               if (pte_dirty(pte))
>> +               if (pte_dirty(pte)) {
>>                          orig_pte = pte_mkdirty(orig_pte);
>> +                       CHECK_CONTPTE_FLAG(i, ptep, orig_pte, young);
>> +                       break;
>> +               }
>>
>> -               if (pte_young(pte))
>> +               if (pte_young(pte)) {
>>                          orig_pte = pte_mkyoung(orig_pte);
>> +                       CHECK_CONTPTE_FLAG(i, ptep, orig_pte, dirty);
>> +                       break;
>> +               }
>>          }
>>
>>          return orig_pte;
>>
>> Some rudimentary testing with micromm reveals that this may be
>> *slightly* faster. I cannot say for sure yet.
> 
> Yep, this change works as expected, IIUC.
> 
> However, I'm still wondering if the added complexity is worth it for
> such a slight/negligible performance gain. That said, if we have
> solid numbers/data to back it up, all doubts would disappear ;)

I agree with Barry; we need clear performance improvement numbers to consider
this type of optimization. I doubt there will be measurable improvement for 4K
and 64K base pages (because the the number of PTEs in a contpte block are 16 and
32 respectively). But 16K base pages may benefit given there are 128 PTEs in a
contpte block for that case.

Also FWIW, I'm struggling to understand CHECK_CONTPTE_FLAG(); Perhaps something
like this would suffice?

----8<----
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 55107d27d3f8..7787b116b339 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -169,11 +169,17 @@ pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte)
        for (i = 0; i < CONT_PTES; i++, ptep++) {
                pte = __ptep_get(ptep);

-               if (pte_dirty(pte))
+               if (pte_dirty(pte)) {
                        orig_pte = pte_mkdirty(orig_pte);
+                       if (pte_young(orig_pte))
+                               break;
+               }

-               if (pte_young(pte))
+               if (pte_young(pte)) {
                        orig_pte = pte_mkyoung(orig_pte);
+                       if (pte_dirty(orig_pte))
+                               break;
+               }
        }

        return orig_pte;
----8<----

Thanks,
Ryan


> 
> Thanks,
> Lance
> 
>>
>>>
>>>>          }
>>>>
>>>>          return orig_pte;
>>>> --
>>>> 2.34.1
>>>>
>>>
>>> Thanks
>>> Barry
>>>
>>


