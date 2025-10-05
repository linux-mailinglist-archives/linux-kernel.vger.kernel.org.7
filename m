Return-Path: <linux-kernel+bounces-842209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5BDBB9387
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 04:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 820323468E0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 02:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA611188A3A;
	Sun,  5 Oct 2025 02:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kraA/Zlq"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C21F1CD1F
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 02:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759632288; cv=none; b=BPxGqmgPO9Zf9l2tMKs7I4RLcLKtIv0suibXSxRXCWXgmCjbD1Ew+cFkFw1xFhwAPuKZ8zewwmr2F4Piafv3u/Bcks9ChcedQkBpaYG19kua3oP3xq1727FSQw8eUz8TlVayvto8RptkmXDVd/6oCEok8k74nvMHTZ6CjQe1Ofs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759632288; c=relaxed/simple;
	bh=ugq64ZjSOaEyero6sS5cA0Go57ep20fL4a3IxPoy6tU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqXiSgS0AaYjcJThZeyw41rqmycI7L0wR8aXjgar4vULv58PXC0Q8QL03+YjNDXkdfdlXjq2xbse54M/0HE4ccaouVj/1YW4l0nbXviBAv4H2juo9QcAtjIKMCJai4meiyB5Gc1gSdTlARynv175/z25BBrQAdZ+JOsKjLAMNKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kraA/Zlq; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8c7c241a-f9fc-47ca-b02f-7adada140d79@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759632283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yzti7L513fCnAHWE2nv71dafGe6w59qWQQTJz5a8Ckk=;
	b=kraA/Zlq3ghO49fHdyoaMGEiqZYiXVL9lbL9P424H/NWyQACv4WUthYco0r6fyLkQJlj3J
	RiSdoc36z9tQKRst27isvRQmhJB3ixDzjIIvqjftDzbOeIHNqnxQ+Y0kNeEXhVkLVY2BxL
	FDTzcTJhB6juFGVr7/kpHJy+2lnz5v0=
Date: Sun, 5 Oct 2025 10:44:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new 2/2] mm/khugepaged: merge PTE scanning logic into a
 new helper
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, Dev Jain <dev.jain@arm.com>,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, ioworker0@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251002073255.14867-1-lance.yang@linux.dev>
 <20251002073255.14867-3-lance.yang@linux.dev>
 <0d55d763-81ff-4b99-bb13-3dbb9af53cdc@arm.com>
 <20251004094217.bah5q2zxczrqontm@master>
 <f235a557-d031-4fcd-8c68-81d9ab7b54e0@arm.com>
 <054ca3f1-b219-49dc-9c4a-6f648b9df7f1@linux.dev>
 <8FF0358E-1ECE-42DA-AE4B-8D5A578450EC@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <8FF0358E-1ECE-42DA-AE4B-8D5A578450EC@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/5 10:38, Zi Yan wrote:
> On 4 Oct 2025, at 22:35, Lance Yang wrote:
> 
>> On 2025/10/4 21:11, Dev Jain wrote:
>>>
>>> On 04/10/25 3:12 pm, Wei Yang wrote:
>>>> On Fri, Oct 03, 2025 at 10:35:12PM +0530, Dev Jain wrote:
>>>>> On 02/10/25 1:02 pm, Lance Yang wrote:
>>>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>>>
>>>>>> As David suggested, the PTE scanning logic in hpage_collapse_scan_pmd()
>>>>>> and __collapse_huge_page_isolate() was almost duplicated.
>>>>>>
>>>>>> This patch cleans things up by moving all the common PTE checking logic
>>>>>> into a new shared helper, thp_collapse_check_pte().
>>>>>>
>>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>>>>> ---
>>>>> In hpage_collapse_scan_pmd(), we enter with mmap lock held, so for
>>>> This is true for the first loop, but we will unlock/lock mmap and revalidate
>>>> vma before isolation.
>>>>
>>>>> an anonymous vma, is it even possible to hit if (! folio_test_anon(folio))?
>>>>> In which case we can replace this with VM_BUG_ON_FOLIO and abstract away
>>>>> till the folio_maybe_mapped_shared() block?
>>>> But it looks still valid, since hugepage_vma_revalidate() will check the vma
>>>> is still anonymous vma after grab the mmap lock again.
>>>>
>>>> My concern is would VM_BUG_ON_FOLIO() be too heavy? How about warn on and
>>>> return?
>>>
>>> Frankly I do not have much opinion on the BUG_ON/WARN_ON debate since I haven't
>>> properly understood that, but this BUG_ON is under CONFIG_DEBUG_VM anways. But
>>
>> Yeah, VM_BUG_ON_FOLIO() is under CONFIG_DEBUG_VM, so it won't affect
>> production kernels.
> 
> Many distros enable it by default. For mm, we are moving away from
> using BUG_ON or VM_BUG_ON. No need to crash the system if it is possible
> to handle it gracefully.

Ah, good to know that, thanks!

> 
>>
>>> if you want to change this to WARN then you can do it at both places.
>>
>> It should flag such an impossible condition there during development.
>> So, I'd prefer to stick with VM_BUG_ON_FOLIO().
>>
>> @Wei please let me know if you feel strongly otherwise :)
> 
> 
> --
> Best Regards,
> Yan, Zi


