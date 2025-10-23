Return-Path: <linux-kernel+bounces-866153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 302D3BFF056
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14A814F4933
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7268A2E092B;
	Thu, 23 Oct 2025 03:32:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8378C2DEA7A
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761190364; cv=none; b=FXnluqdHRpk5VaOY8DW8Dccr1LTvTAimJRaSDNjgeq2+raROEvP0S+wX6JH6dNMyCJjKr/o+akHMjoPnWjx4DfzvhpZEXxKxUc/ES51W7A0vjf3RzT1wP+QERvgrS0bCgUiJ+qLvHfbJuAK5znqG/Nq1+WeBtW1qAnXNih5T86A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761190364; c=relaxed/simple;
	bh=xWhL3+Dq6MSXsHvH7+WWuMbywvoryjin7C3sX75Ef8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pb138fXaaihL3ijurgkRWye5xa/X/yvwb2gyXRY/bUtcTUtnG+UtrLpQtCmAvZvGrldmorb4z3jCwoF6WHvnbPIftPXNdvbo+NPtHN1bTMfH9LvYYOZhSKxaJzHRN+21t48amdQaIzyH6kyqUc39ZpyZVrcVJUcpiDFK6kqGi2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAAD31516;
	Wed, 22 Oct 2025 20:32:32 -0700 (PDT)
Received: from [10.163.71.44] (unknown [10.163.71.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 930813F63F;
	Wed, 22 Oct 2025 20:32:38 -0700 (PDT)
Message-ID: <f9104ef2-8ff2-4111-9a44-33f4d361a416@arm.com>
Date: Thu, 23 Oct 2025 09:02:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/debug_vm_pgtable: Add [pte|pmd]_mkwrite_novma()
 tests
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>
References: <20251022032951.3498553-1-anshuman.khandual@arm.com>
 <87ms5i2z8t.fsf@DESKTOP-5N7EMDA>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <87ms5i2z8t.fsf@DESKTOP-5N7EMDA>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23/10/25 6:47 AM, Huang, Ying wrote:
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
>> Changes in V2:
>>
>> - Added a new test combination per Huang
>>
>> Changes in V1:
>>
>> https://lore.kernel.org/all/20251021024424.2390325-1-anshuman.khandual@arm.com/
>>
>>  mm/debug_vm_pgtable.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>> index 830107b6dd08..def344bb4a32 100644
>> --- a/mm/debug_vm_pgtable.c
>> +++ b/mm/debug_vm_pgtable.c
>> @@ -102,6 +102,12 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
>>  	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte, args->vma))));
>>  	WARN_ON(pte_dirty(pte_wrprotect(pte_mkclean(pte))));
>>  	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
>> +
>> +	WARN_ON(!pte_dirty(pte_mkwrite_novma(pte_mkdirty(pte))));
>> +	WARN_ON(pte_dirty(pte_mkwrite_novma(pte_mkclean(pte))));
>> +	WARN_ON(!pte_write(pte_mkdirty(pte_mkwrite_novma(pte))));
>> +	WARN_ON(!pte_write(pte_mkwrite_novma(pte_wrprotect(pte))));
>> +	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite_novma(pte))));
>>  }
>>  
>>  static void __init pte_advanced_tests(struct pgtable_debug_args *args)
>> @@ -195,6 +201,12 @@ static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
>>  	WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite(pmd, args->vma))));
>>  	WARN_ON(pmd_dirty(pmd_wrprotect(pmd_mkclean(pmd))));
>>  	WARN_ON(!pmd_dirty(pmd_wrprotect(pmd_mkdirty(pmd))));
>> +
>> +	WARN_ON(pmd_dirty(pmd_mkwrite_novma(pmd_mkclean(pmd))));
>> +	WARN_ON(!pmd_write(pmd_mkdirty(pmd_mkwrite_novma(pmd))));
>> +	WARN_ON(!pmd_write(pmd_mkwrite_novma(pmd_wrprotect(pmd))));
>> +	WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite_novma(pmd))));
> 
> Why not add
> 
>         WARN_ON(!pmd_dirty(pmd_mkwrite_novma(pmd_mkdirty(pte))));
> 
> too?

Sure will add the above test which will also be symmetrical with a
similar PTE test being proposed here.

