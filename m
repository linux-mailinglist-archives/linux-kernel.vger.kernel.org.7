Return-Path: <linux-kernel+bounces-837903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE57BAE03A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6EF5194439C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111163090F7;
	Tue, 30 Sep 2025 16:08:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA94B303C9D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248528; cv=none; b=RiTypnFo1QLqLaHvYzTee5WDreJWN1I3W34RpBNBnYi1t6GLzMviF0Z+oUwUZ8vafL6/FB1uoGU8BOk2sUkwNPzpxwWslMh9Q3AzBIxm9keeDfm4p852THc3jSXx+6pl6JMNwN6ZSly4XTP9rFvcyX/vMAJFtHLA06+CulozfYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248528; c=relaxed/simple;
	bh=EXPCLyqrl8gYbOyaCu+eFHadB01pjmsUq9P7hhiQYcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/FLSE/0WMl66pKW/KyW7PlCIkTE827TFityfgTPChEU1/uHGl/TTN5N/uR8rDJt9JfvKexjyjVDtbksb1IYB4cgCT1oFDLKWWu9a9PJ/0ku+xFBY3O9hrqNwy9IRwipDv1QjvIvcnoUnTat7aaIDzQ/EXGRa3xW2A7clhJRztE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 367021424;
	Tue, 30 Sep 2025 09:08:38 -0700 (PDT)
Received: from [10.163.65.117] (unknown [10.163.65.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 880333F66E;
	Tue, 30 Sep 2025 09:08:44 -0700 (PDT)
Message-ID: <3399336c-f08e-479f-aa9d-de6bac9bda61@arm.com>
Date: Tue, 30 Sep 2025 21:38:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/ptdump: Replace READ_ONCE() with standard page table
 accessors
To: David Hildenbrand <david@redhat.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20250930025246.1143340-1-anshuman.khandual@arm.com>
 <9736fd6a-8987-4b10-9b05-e03106463c34@arm.com>
 <f0f0479a-fdab-4f42-9600-5d7b44a73f4e@redhat.com>
 <1f3c8fe8-cff0-4e3e-bea8-285b00fc7a5d@arm.com>
 <25653f37-6ba3-442f-9348-d879a8ad4704@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <25653f37-6ba3-442f-9348-d879a8ad4704@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 30/09/25 8:13 pm, David Hildenbrand wrote:
> On 30.09.25 09:00, Anshuman Khandual wrote:
>>
>>
>> On 30/09/25 12:11 PM, David Hildenbrand wrote:
>>> On 30.09.25 06:37, Dev Jain wrote:
>>>>
>>>> On 30/09/25 8:22 am, Anshuman Khandual wrote:
>>>>> Replace READ_ONCE() with standard page table accessors i.e 
>>>>> pxdp_get() which
>>>>> anyways default into READ_ONCE() in cases where platform does not 
>>>>> override.
>>>>>
>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>> Cc: linux-mm@kvack.org
>>>>> Cc: linux-kernel@vger.kernel.org
>>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>> ---
>>>>>     mm/ptdump.c | 8 ++++----
>>>>>     1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/mm/ptdump.c b/mm/ptdump.c
>>>>> index b600c7f864b8..18861501b533 100644
>>>>> --- a/mm/ptdump.c
>>>>> +++ b/mm/ptdump.c
>>>>> @@ -31,7 +31,7 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned 
>>>>> long addr,
>>>>>                     unsigned long next, struct mm_walk *walk)
>>>>>     {
>>>>>         struct ptdump_state *st = walk->private;
>>>>> -    pgd_t val = READ_ONCE(*pgd);
>>>>> +    pgd_t val = pgdp_get(pgd);
>>>>>        #if CONFIG_PGTABLE_LEVELS > 4 && \
>>>>>             (defined(CONFIG_KASAN_GENERIC) || 
>>>>> defined(CONFIG_KASAN_SW_TAGS))
>>>>> @@ -54,7 +54,7 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned 
>>>>> long addr,
>>>>>                     unsigned long next, struct mm_walk *walk)
>>>>>     {
>>>>>         struct ptdump_state *st = walk->private;
>>>>> -    p4d_t val = READ_ONCE(*p4d);
>>>>> +    p4d_t val = p4dp_get(p4d);
>>>>>        #if CONFIG_PGTABLE_LEVELS > 3 && \
>>>>>             (defined(CONFIG_KASAN_GENERIC) || 
>>>>> defined(CONFIG_KASAN_SW_TAGS))
>>>>> @@ -77,7 +77,7 @@ static int ptdump_pud_entry(pud_t *pud, unsigned 
>>>>> long addr,
>>>>>                     unsigned long next, struct mm_walk *walk)
>>>>>     {
>>>>>         struct ptdump_state *st = walk->private;
>>>>> -    pud_t val = READ_ONCE(*pud);
>>>>> +    pud_t val = pudp_get(pud);
>>>>>        #if CONFIG_PGTABLE_LEVELS > 2 && \
>>>>>             (defined(CONFIG_KASAN_GENERIC) || 
>>>>> defined(CONFIG_KASAN_SW_TAGS))
>>>>> @@ -100,7 +100,7 @@ static int ptdump_pmd_entry(pmd_t *pmd, 
>>>>> unsigned long addr,
>>>>>                     unsigned long next, struct mm_walk *walk)
>>>>>     {
>>>>>         struct ptdump_state *st = walk->private;
>>>>> -    pmd_t val = READ_ONCE(*pmd);
>>>>> +    pmd_t val = pmdp_get(pmd);
>>>>
>>>> I believe this should go through pmdp_get_lockless(). I can see in 
>>>> pgtable.h that
>>>> some magic is required on some arches to decode the pmd correctly 
>>>> in case walking
>>>> without locks.
>>>
>>> pmdp_get_lockless() is a nasty thingy to handle selected 32bit 
>>> architectures.
>>>
>>> But given that we're using ptep_get_lockless() in ptdump_pmd_entry() 
>>> it probably wouldn't hurt to use pmdp_get_lockless() here.
>>>
>>> Staring at ARCH_HAS_PTDUMP, I don't think any 32bit arch would 
>>> actually end up compiling ptdump.c.
>>>
>>> E.g., on x86 only X86_64 ends up selecting ARCH_HAS_PTDUMP.
>>>
>>
>> pxdp_get_lockless() not really required here, let's stick with 
>> pxdp_get() instead.
>
> I'd suggest that we keep it consistent. That is, also removing the 
> ptep_get_lockless() if not really required.

So in theory, the _lockless variant is not required, but surely 
consistency would mean that since we are

dereferencing the pte without the PTL, we should use the _lockless variant?



