Return-Path: <linux-kernel+bounces-855593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62276BE1B86
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E391188B656
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE562D4807;
	Thu, 16 Oct 2025 06:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YqhTURIH"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3D92D3A86
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596025; cv=none; b=mKs6yofuNvd9DbBC+y1h7W66d+MYaaVvSHjFtb24Q4tO+L9vzCB5VLDykIm3vdW27K14dbowksXUXAzIIGHpG05TxVshZc9e0QiF6ux41wu8cLnZ4diaObSYL6+S7glUAOJf1hbvsgiLtylrXBJZrzTnYaA3paMcSAJg1dFAKQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596025; c=relaxed/simple;
	bh=Qqp0kiIWND20xDyYJe74c11eBzT4sy+ggYL2fspdYEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBvl57l5HN3Us3UFdEPPUICwbyUQjhXcWUajgvPzNfIAKqvgk0BkGh2DJHRMWp95qfOqTG3nbOQhjqNqIi612osvqenIEKR4H8ZuqdWamebyT19bjeQLi+am/QiKe9Eo5QVxm5UiUgtlGIqbpNyBYfvl0qKiXt0ATgfqeHSjd7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YqhTURIH; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8d88fb47-5318-433c-bb07-aeea4a025db8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760596019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNG5Ju61aC+No7m/Kz/oSUIjtFO+hsFQlNAY/X9LidA=;
	b=YqhTURIHrRbmBDr00b7O/r+QOfL1IC659ssjuugIVUHtGQNorJNmYWoZgzwPIOMeG0K9QQ
	Ev8Lylb2963TmGHQU9HxEsU8r2RZxDkZFM1xjN+0D81fkx9o+1DIUImQ/m9U3L8aBanIXG
	r40hajjDxdeZgFEQ33VXvxFbWIbWz/c=
Date: Thu, 16 Oct 2025 14:26:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new 1/1] mm/khugepaged: guard is_zero_pfn() calls with
 pte_present()
To: Dev Jain <dev.jain@arm.com>
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, david@redhat.com
References: <20251016033643.10848-1-lance.yang@linux.dev>
 <17c4c5f9-6ac8-4914-838f-f511dfbf948f@arm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <17c4c5f9-6ac8-4914-838f-f511dfbf948f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/16 14:17, Dev Jain wrote:
> 
> On 16/10/25 9:06 am, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> A non-present entry, like a swap PTE, contains completely different data
>> (swap type and offset). pte_pfn() doesn't know this, so if we feed it a
>> non-present entry, it will spit out a junk PFN.
>>
>> What if that junk PFN happens to match the zeropage's PFN by sheer
>> chance? While really unlikely, this would be really bad if it did.
>>
>> So, let's fix this potential bug by ensuring all calls to is_zero_pfn()
>> in khugepaged.c are properly guarded by a pte_present() check.
>>
>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   mm/khugepaged.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index d635d821f611..0341c3d13e9e 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -516,7 +516,7 @@ static void release_pte_pages(pte_t *pte, pte_t 
>> *_pte,
>>           pte_t pteval = ptep_get(_pte);
>>           unsigned long pfn;
>> -        if (pte_none(pteval))
>> +        if (!pte_present(pteval))
>>               continue;
>>           pfn = pte_pfn(pteval);
>>           if (is_zero_pfn(pfn))
>> @@ -690,9 +690,10 @@ static void 
>> __collapse_huge_page_copy_succeeded(pte_t *pte,
>>            address += nr_ptes * PAGE_SIZE) {
>>           nr_ptes = 1;
>>           pteval = ptep_get(_pte);
>> -        if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>> +        if (pte_none(pteval) ||
>> +            (pte_present(pteval) && is_zero_pfn(pte_pfn(pteval)))) {
>>               add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
>> -            if (is_zero_pfn(pte_pfn(pteval))) {
>> +            if (!pte_none(pteval)) {
> 
> Could save a level of indentation by saying
> if (pte_none(pteval))
>      continue;
> 
> That would make it crystal clear that we do nothing when pte is none,
> and we do something when pte is pointing to zero pfn.

Yes! That does look clearer ;)

I'll pick that up in the next spin, if one is needed.

> 
> Reviewed-by: Dev Jain <dev.jain@arm.com>

Cheers!

> 
>>                   /*
>>                    * ptl mostly unnecessary.
>>                    */
>> @@ -794,7 +795,8 @@ static int __collapse_huge_page_copy(pte_t *pte, 
>> struct folio *folio,
>>           unsigned long src_addr = address + i * PAGE_SIZE;
>>           struct page *src_page;
>> -        if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>> +        if (pte_none(pteval) ||
>> +            (pte_present(pteval) && is_zero_pfn(pte_pfn(pteval)))) {
>>               clear_user_highpage(page, src_addr);
>>               continue;
>>           }
>> @@ -1294,7 +1296,8 @@ static int hpage_collapse_scan_pmd(struct 
>> mm_struct *mm,
>>                   goto out_unmap;
>>               }
>>           }
>> -        if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>> +        if (pte_none(pteval) ||
>> +            (pte_present(pteval) && is_zero_pfn(pte_pfn(pteval)))) {
>>               ++none_or_zero;
>>               if (!userfaultfd_armed(vma) &&
>>                   (!cc->is_khugepaged ||


