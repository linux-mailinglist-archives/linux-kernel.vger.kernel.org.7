Return-Path: <linux-kernel+bounces-864409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3122BFAB9D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B212189FC4D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78DB2F363B;
	Wed, 22 Oct 2025 07:58:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB2D2FE560
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119932; cv=none; b=SiNfQNDJpT2ojGL43gswPymeSp1yNEDoQDzeN1WMwLa2R0g5gUhW425UsZp1k6pPNsJBNf0EKtFzq8rbWKzRPiJisJ8oDCNBmz1ammrCpD7EtJOXVIfs+AYems6qRp7o6mVebZYRCoAaJxwh9R9ORbjIqqnoT95crmjTcERZM00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119932; c=relaxed/simple;
	bh=QZJ5RZU9Yx7CjfDh5xEF9FJ6+lC37R7fmR8QkW4THC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OeGLS8R1WOgsLCFq+2uGn+7D2D0UoQ4hDtcLrchkRLMxGcShYWg2//rOA8fc/rtAakwWSE5fNk72TaK8NQCKyW7+nlx6WKMp0nF7HU7nFTA6TAlFTTg1L/1gT8H/x3k1HseG396oQgvcNqTFYmCbydegEQpcgJlmS6wbKRzAJ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE4201063;
	Wed, 22 Oct 2025 00:58:40 -0700 (PDT)
Received: from [10.164.18.45] (unknown [10.164.18.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9864A3F63F;
	Wed, 22 Oct 2025 00:58:46 -0700 (PDT)
Message-ID: <b5a1b52c-75ef-4915-a254-a502b9f78eeb@arm.com>
Date: Wed, 22 Oct 2025 13:28:43 +0530
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
 <87ecqve6gg.fsf@DESKTOP-5N7EMDA>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <87ecqve6gg.fsf@DESKTOP-5N7EMDA>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/10/25 1:03 PM, Huang, Ying wrote:
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
> 
> Why do you use
> 
> pte_mkwrite_novma(pte)
> 
> instead of
> 
> pte_mkwrite(pte, args->vma)
Just wanted to have more coverage for pte_mkwrite_novma() helper which was missing
till now in this test. But just wondering is there a specific reason for replacing
this with pte_mkwrite() helper instead here ? Also we could probably add tests for
both these helper variations if that is preferred.

