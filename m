Return-Path: <linux-kernel+bounces-842601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20469BBD218
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 08:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD633AFE71
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 06:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41DC246760;
	Mon,  6 Oct 2025 06:28:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706201D63F7
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 06:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759732107; cv=none; b=N2dKt0KixWiXuqyVP5LXCKlO01FnxjFFFuv1xmOfPn2+sBUsHFETjXU9OEZ8U+lkaLsLCzGrmeKy1KEwPpGiGu/mxZLShg2qLg3s8eggU5hUkmZX3X6hNXxf1roAvHNvkT9bM4EVuHKBR8+0IDtC9b2eo7pLbh93YLUdxIcENEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759732107; c=relaxed/simple;
	bh=p30WR1fRKfo4Zn9J5kvCerH+ZDGCiLDXfxdoaqlW1zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5jHvm9Sf6AEqLtmPul54T1ItX144WcsEKNKPDcMo7vJ0RvBPQkJMZIGoawlS4Be344UqorVla/mw4mpEjUs8npIXgKcJ5eADNeAtxa45t8DDlH8vrIGg0Iuo8fOI6hsTzP0aqhyQKrzPoHCE/GqAvV9qkNUCpWLkGUnRbF//rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B93451515;
	Sun,  5 Oct 2025 23:28:16 -0700 (PDT)
Received: from [10.164.18.47] (unknown [10.164.18.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F8013F59E;
	Sun,  5 Oct 2025 23:28:22 -0700 (PDT)
Message-ID: <1c948262-e201-4473-b156-8b90fedc9ce7@arm.com>
Date: Mon, 6 Oct 2025 11:58:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/dirty: Replace READ_ONCE() with pudp_get()
To: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
References: <20251006055214.1845342-1-anshuman.khandual@arm.com>
 <4b513d32-7795-4998-98df-d398c3d5462a@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <4b513d32-7795-4998-98df-d398c3d5462a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 06/10/25 11:37 AM, Dev Jain wrote:
> 
> On 06/10/25 11:22 am, Anshuman Khandual wrote:
>> Replace READ_ONCE() with a standard page table accessor i.e pudp_get() that
>> anyways defaults into READ_ONCE() in cases where platform does not override
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   mm/mapping_dirty_helpers.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
>> index c193de6cb23a..737c407f4081 100644
>> --- a/mm/mapping_dirty_helpers.c
>> +++ b/mm/mapping_dirty_helpers.c
>> @@ -149,7 +149,7 @@ static int wp_clean_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
>>                     struct mm_walk *walk)
>>   {
>>   #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>> -    pud_t pudval = READ_ONCE(*pud);
>> +    pud_t pudval = pudp_get(pud);
>>         /* Do not split a huge pud */
>>       if (pud_trans_huge(pudval)) {
> 
> Talking about mm, why not also make changes for these READ_ONCE accesses
> in gup, hmm, memory, mprotect, sparse-vmemmap?
> 

Right, could replace all mm/ READ_ONCE() for pxdp pointers with the pgtable helpers
but that will create too much code churn in a single patch. Thought of doing these
replacements per file will be much more contained which is easy both for review and
testing.

