Return-Path: <linux-kernel+bounces-841948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B742FBB89A3
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 06:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EFDA4E79F9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 04:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D81E21ADCB;
	Sat,  4 Oct 2025 04:42:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB66C219E8
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 04:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759552942; cv=none; b=KImPFllf8UvG92XkDUdUFh147z1wq3ClLkJ9j5p8H9VAqgsmLwwvn7qwJkEobnxuJa1hguBo2Jf8hs8Ct7JYJ0oX2jdgN/QuuyUFLsktiXjHBXnWbB8N77QTzm7wrqTwHMA2cW2Fx/uH4O42nermgPzraq5/J8DoRDlS1vE/T4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759552942; c=relaxed/simple;
	bh=b+EdcHlcxVt3C3DlIZ27a9ypkZ1pOFlfmjs1B/pyCqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMM8d07uGyg5EL46WvamS0SBWd2ooIdmnzMPANEmz7JuisB+PfQvx4XOPnkqilbvq3+WdmwsN2el1M1azMPS9nBcHeT+LiIEtkcSYv3uiwZkk2n0pXqiohxUEVKYAtOLLgR6+uy/SpbJ2y57e1N682rUzpOdOzzO+SzQ6ulTL1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D68021515;
	Fri,  3 Oct 2025 21:42:09 -0700 (PDT)
Received: from [10.163.65.95] (unknown [10.163.65.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 113283F5A1;
	Fri,  3 Oct 2025 21:42:12 -0700 (PDT)
Message-ID: <f9f62e40-92a6-4ee8-aba0-6bb9b2929f41@arm.com>
Date: Sat, 4 Oct 2025 10:12:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new 2/2] mm/khugepaged: merge PTE scanning logic into a
 new helper
To: Lance Yang <lance.yang@linux.dev>
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, david@redhat.com, richard.weiyang@gmail.com,
 linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com,
 linux-mm@kvack.org, akpm@linux-foundation.org
References: <20251002073255.14867-1-lance.yang@linux.dev>
 <20251002073255.14867-3-lance.yang@linux.dev>
 <0d55d763-81ff-4b99-bb13-3dbb9af53cdc@arm.com>
 <a36c9776-d158-4add-86d0-c41a09e4a255@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <a36c9776-d158-4add-86d0-c41a09e4a255@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 04/10/25 8:33 am, Lance Yang wrote:
>
>
> On 2025/10/4 01:05, Dev Jain wrote:
>>
>> On 02/10/25 1:02 pm, Lance Yang wrote:
>>> From: Lance Yang <lance.yang@linux.dev>
>>>
>>> As David suggested, the PTE scanning logic in hpage_collapse_scan_pmd()
>>> and __collapse_huge_page_isolate() was almost duplicated.
>>>
>>> This patch cleans things up by moving all the common PTE checking logic
>>> into a new shared helper, thp_collapse_check_pte().
>>>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>> ---
>>
>> In hpage_collapse_scan_pmd(), we enter with mmap lock held, so for
>> an anonymous vma, is it even possible to hit if 
>> (!folio_test_anon(folio))?
>
> Ah, indeed :)
>
>> In which case we can replace this with VM_BUG_ON_FOLIO and abstract away
>> till the folio_maybe_mapped_shared() block?
>
> So you meant something like this:
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2a897cfb1d03..ef87d7fe3d50 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1374,11 +1374,7 @@ static int hpage_collapse_scan_pmd(struct 
> mm_struct *mm,
>                         goto out_unmap;
>                 }
>                 folio = page_folio(page);
> -
> -               if (!folio_test_anon(folio)) {
> -                       result = SCAN_PAGE_ANON;
> -                       goto out_unmap;
> -               }
> +               VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);

Yes, I would suggest a different patch making this change, then in the

last patch you can abstract away till the shared statistics line since that

much code will become common between scan_pmd and _isolate.


>
>                 /*
>                  * We treat a single page as shared if any part of the 
> THP
>
>

