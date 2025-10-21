Return-Path: <linux-kernel+bounces-862349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F65CBF5107
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A939B18A50EC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D899288C24;
	Tue, 21 Oct 2025 07:48:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D836628640F
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032908; cv=none; b=JqrozQOQl+68coKnqst0jGUZ7SqsNAi/wpj1B9Glsd0COLY837QuojWxb2zOo/bPup42WTLEDsDhLRFVGS99pCLWp31BIvEOhdi9ryCPaTAMLcyoQhzDeXAq2FZRzJllNFGsLITDQUm+5juXrbU0Qc5vyvqy/p+HKDAPGQ7QQcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032908; c=relaxed/simple;
	bh=TXZuB4qcgVxVy89zone8v7OwKUm/L4pcaUVG4qarnRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flF9BceEe8UVT4fFo66T6tVz6/074y/9ReCQGTmb3r2rK9h9p1u/COvGkSnqA55gw+3Nfo6gSpU8MxlPvO9CcFYrfy4Oj0TwPLUvT1j2kvVWv+pyk/1Uv1GeAdUNS0Y84Q7j+lpEJ1WVssKZTYxjAviGlL5NXcaThH64Ccx3x34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16DD71063;
	Tue, 21 Oct 2025 00:48:17 -0700 (PDT)
Received: from [10.164.18.45] (unknown [10.164.18.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B5C13F66E;
	Tue, 21 Oct 2025 00:48:22 -0700 (PDT)
Message-ID: <5face11f-2e04-4f28-b474-7c22a10d05e0@arm.com>
Date: Tue, 21 Oct 2025 13:18:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/debug_vm_pgtable: Add [pte|pmd]_mkwrite_novma() tests
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>
References: <20251021024424.2390325-1-anshuman.khandual@arm.com>
 <875xc8ap0k.fsf@DESKTOP-5N7EMDA>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <875xc8ap0k.fsf@DESKTOP-5N7EMDA>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/10/25 9:24 AM, Huang, Ying wrote:
> Anshuman Khandual <anshuman.khandual@arm.com> writes:
> 
>> Add some [pte|pmd]_mkwrite_novma() relevant tests.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Huang Ying <ying.huang@linux.alibaba.com>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> These tests clear on arm64 platform after the following recent patch.
>>
>> https://lore.kernel.org/all/20251015023712.46598-1-ying.huang@linux.alibaba.com/
>>
>>  mm/debug_vm_pgtable.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>> index 830107b6dd08..b9cae1580782 100644
>> --- a/mm/debug_vm_pgtable.c
>> +++ b/mm/debug_vm_pgtable.c
>> @@ -102,6 +102,11 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
>>  	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte, args->vma))));
>>  	WARN_ON(pte_dirty(pte_wrprotect(pte_mkclean(pte))));
>>  	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
>> +
>> +	WARN_ON(pte_dirty(pte_mkwrite_novma(pte_mkclean(pte))));
> 
> Why not use: pte_mkwrite(pte, args->vma)?
> 
> Maybe add
> 
>         WARN_ON(!pte_dirty(pte_mkwrite_novma(pte_mkdirty(pte))));

Sure, will add the above test as well.
> 
>> +	WARN_ON(!pte_write(pte_mkdirty(pte_mkwrite_novma(pte))));
>> +	WARN_ON(!pte_write(pte_mkwrite_novma(pte_wrprotect(pte))));
>> +	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite_novma(pte))));
>>  }
>>  
>>  static void __init pte_advanced_tests(struct pgtable_debug_args *args)
>> @@ -195,6 +200,11 @@ static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
>>  	WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite(pmd, args->vma))));
>>  	WARN_ON(pmd_dirty(pmd_wrprotect(pmd_mkclean(pmd))));
>>  	WARN_ON(!pmd_dirty(pmd_wrprotect(pmd_mkdirty(pmd))));
>> +
>> +	WARN_ON(pmd_dirty(pmd_mkwrite_novma(pmd_mkclean(pmd))));
>> +	WARN_ON(!pmd_write(pmd_mkdirty(pmd_mkwrite_novma(pmd))));
>> +	WARN_ON(!pmd_write(pmd_mkwrite_novma(pmd_wrprotect(pmd))));
>> +	WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite_novma(pmd))));
>>  	/*
>>  	 * A huge page does not point to next level page table
>>  	 * entry. Hence this must qualify as pmd_bad().
> 
> ---
> Best Regards,
> Huang, Ying


