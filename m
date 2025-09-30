Return-Path: <linux-kernel+bounces-837217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49180BABB65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E7627A4A55
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7A4222586;
	Tue, 30 Sep 2025 07:00:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA8D42A99
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759215613; cv=none; b=RAdsnfX1vcyzs3p268kkGPM5FCWWfOC4U774GmQkNP8EN3ytKUz4R+JUm9R2ep2+17ZwWLDaozBqG+71/4cFTy7dmddb1GGFx9uP01MwL0+TWEm+jCqXWZ7MX/CfnjPIHURK44hSW+uDnJCv+0dYEmdauo8XElMJB57Iycj+LQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759215613; c=relaxed/simple;
	bh=3dimaceeiFIr2/i3WBe8t8sggF7zQn4+zC90g8QDT4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1rx6jGLl9aENYax/CX5aQZwGdJEWWgnYwKHY7sigCHRBQdcskCKNZqlf/6F6eUbMrfp0m9RAsMVAKaknSA3OItv9uI2+EXG0aTYc0PHgBbns/HmK8d4uRUtCzV8TRlzz8hZxwluNo+R4JPQY+p30hvDAqEyHNfgAuem5mIXZn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B2F21424;
	Tue, 30 Sep 2025 00:00:02 -0700 (PDT)
Received: from [10.164.18.71] (unknown [10.164.18.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 277A53F5A1;
	Tue, 30 Sep 2025 00:00:08 -0700 (PDT)
Message-ID: <1f3c8fe8-cff0-4e3e-bea8-285b00fc7a5d@arm.com>
Date: Tue, 30 Sep 2025 12:30:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/ptdump: Replace READ_ONCE() with standard page table
 accessors
To: David Hildenbrand <david@redhat.com>, Dev Jain <dev.jain@arm.com>,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20250930025246.1143340-1-anshuman.khandual@arm.com>
 <9736fd6a-8987-4b10-9b05-e03106463c34@arm.com>
 <f0f0479a-fdab-4f42-9600-5d7b44a73f4e@redhat.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <f0f0479a-fdab-4f42-9600-5d7b44a73f4e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 30/09/25 12:11 PM, David Hildenbrand wrote:
> On 30.09.25 06:37, Dev Jain wrote:
>>
>> On 30/09/25 8:22 am, Anshuman Khandual wrote:
>>> Replace READ_ONCE() with standard page table accessors i.e pxdp_get() which
>>> anyways default into READ_ONCE() in cases where platform does not override.
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: linux-mm@kvack.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>    mm/ptdump.c | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/ptdump.c b/mm/ptdump.c
>>> index b600c7f864b8..18861501b533 100644
>>> --- a/mm/ptdump.c
>>> +++ b/mm/ptdump.c
>>> @@ -31,7 +31,7 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
>>>                    unsigned long next, struct mm_walk *walk)
>>>    {
>>>        struct ptdump_state *st = walk->private;
>>> -    pgd_t val = READ_ONCE(*pgd);
>>> +    pgd_t val = pgdp_get(pgd);
>>>       #if CONFIG_PGTABLE_LEVELS > 4 && \
>>>            (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
>>> @@ -54,7 +54,7 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
>>>                    unsigned long next, struct mm_walk *walk)
>>>    {
>>>        struct ptdump_state *st = walk->private;
>>> -    p4d_t val = READ_ONCE(*p4d);
>>> +    p4d_t val = p4dp_get(p4d);
>>>       #if CONFIG_PGTABLE_LEVELS > 3 && \
>>>            (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
>>> @@ -77,7 +77,7 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long addr,
>>>                    unsigned long next, struct mm_walk *walk)
>>>    {
>>>        struct ptdump_state *st = walk->private;
>>> -    pud_t val = READ_ONCE(*pud);
>>> +    pud_t val = pudp_get(pud);
>>>       #if CONFIG_PGTABLE_LEVELS > 2 && \
>>>            (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
>>> @@ -100,7 +100,7 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned long addr,
>>>                    unsigned long next, struct mm_walk *walk)
>>>    {
>>>        struct ptdump_state *st = walk->private;
>>> -    pmd_t val = READ_ONCE(*pmd);
>>> +    pmd_t val = pmdp_get(pmd);
>>
>> I believe this should go through pmdp_get_lockless(). I can see in pgtable.h that
>> some magic is required on some arches to decode the pmd correctly in case walking
>> without locks.
> 
> pmdp_get_lockless() is a nasty thingy to handle selected 32bit architectures.
> 
> But given that we're using ptep_get_lockless() in ptdump_pmd_entry() it probably wouldn't hurt to use pmdp_get_lockless() here.
> 
> Staring at ARCH_HAS_PTDUMP, I don't think any 32bit arch would actually end up compiling ptdump.c.
> 
> E.g., on x86 only X86_64 ends up selecting ARCH_HAS_PTDUMP.
> 

pxdp_get_lockless() not really required here, let's stick with pxdp_get() instead.

