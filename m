Return-Path: <linux-kernel+bounces-855552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E318BE19CE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D4FE235174B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1511246770;
	Thu, 16 Oct 2025 05:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y5rndtHo"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A32123E35F
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760594364; cv=none; b=ZBK6+g3RVK4GUr2FlFRLHSMFTfLqbmpaW8yrYIRi/RHnfDpiZSQg4i5GQDO4k5KXmAmW3t/EwrHcvTIN8rHr6TTdbuqDLs97Kpigy+8Lix9J9sxrI/PXum5konXC60xgdB24rqPD36i/FzQGtEJFgWMUEchO5KM6jOCXt60mnRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760594364; c=relaxed/simple;
	bh=vawqNMoFZ5VKFuN0Vja2YQC5OXrm6Pc/9crYHoD1Sek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPGFJ9ejzmFTbLVbHCN1YwwdtY1gqPVVCGIKF+t0z7dUBxyj0OK3ALp5e2JRsS+5RVkD6yRhukh0mKzNX8yhaw1ykJje/0Iw+57TpfOVsCrid9DKEDcT/Q0W+JKzKUKgTtAj5AR0O57dgSKXg1RxpoBux4zYeVBa5PVpxTzP9jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y5rndtHo; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d5d2fe20-9d63-4304-8b36-9708309791ea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760594360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vdb4s1EUc15piP4fsMIcyGvi1KhE492ZqzLXb8qr2Tc=;
	b=Y5rndtHob9Zji+lY2MljLArqMcNI1xw4ZC5ZajqNzJ9wnEaq0A7owV05dBx4uVeWKfCStV
	sJ/l1S3P678HOCQBjCfnev8fEfeIMD9C/NW1ReEsu4/Z4huTRwzsKIa5tfDpaIeVGeyjgw
	JyzMWMjf8AHV7IkDbitYqkZZR8v8xGU=
Date: Thu, 16 Oct 2025 13:59:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new 1/1] mm/khugepaged: guard is_zero_pfn() calls with
 pte_present()
Content-Language: en-US
To: Dev Jain <dev.jain@arm.com>
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, akpm@linux-foundation.org, david@redhat.com
References: <20251016033643.10848-1-lance.yang@linux.dev>
 <ab4e7044-c285-426e-bf9c-fa06a0f47ae9@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <ab4e7044-c285-426e-bf9c-fa06a0f47ae9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/16 13:34, Dev Jain wrote:
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
> 
> Thanks, I missed this.

Me too ...

> 
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
> 
> There should be no chance that we end up with a pteval which is not none 
> *and*
> not present, if you look at the callers of release_pte_pages. So perhaps we
> should keep this either the same, or, after "if(pte_none(pteval))", do a
> WARN_ON_ONCE(!pte_present(pteval))?

Good catch! Yeah, but I'd rather not rely on the callers ...

Wouldn't it just be simpler and safer to always have is_zero_pfn() guarded
by pte_present()?

I don't have a strong opinon here, though ;p

Dev, Thanks!

