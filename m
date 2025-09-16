Return-Path: <linux-kernel+bounces-817996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84510B58B47
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA067AC2F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED091F03D8;
	Tue, 16 Sep 2025 01:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="C7VvoLJd"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47409CA5E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986581; cv=none; b=IFZ+8qLKd8vnJ045RWxZeTwjFwtI4xZj6kT0i9ccXzqbmYxfmvEfsXHNr/R0oqoMl9QViJOq2kFltffdZ0Sv4uwdHdTbW9b66E+TNyQjqLwNNU9z7ZaaiJvhgZy4Y4nXEoYfrz2NhyAgEbwqbG8CBR+Ci+d/ZFiFhf9Zu3kNi4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986581; c=relaxed/simple;
	bh=MXFcQ4ZGkmTx7rvXGFSKIdrds2mfeOFixKJ78OClczc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JwipE3QIpDtni2lda2YVbdMUhgZWgm/1rKwXv+P6bc2B60uPP+DT0nKMsklGwIlOVUo53Lcb32f15g73Rg2GIc1yZJsqI6Ur9WSN8q1sQzLKNqYtO/+LFv0gos/xLve4tMzqNFR9gQ8Rx5H2z5WkCpDtZMZcfBWZeZ0qM67uRYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=C7VvoLJd; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757986568; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=iO9IyLuu+6VJGjLqKGfdYZOIt/8+8VRDHAroqFcBXb8=;
	b=C7VvoLJdP/9/F6aCbRQPn0x7onZzwChbaqsAlMUyvIusaqrosTaZ/3K/nu3vZ5tWlbtDUsD85WSYbwSU+pEDt4p6FW0lyFdskf5whrVB6cx3w6BEdsqU2b+ja21v5nd+NOGQaXBGxIRGlVklIwrd74ld7Le2HJGDXCK5ZKIwTx8=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wo6JU5v_1757986565 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 16 Sep 2025 09:36:06 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: David Hildenbrand <david@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,  Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>,  Vlastimil Babka <vbabka@suse.cz>,
  Zi Yan <ziy@nvidia.com>,  Baolin Wang <baolin.wang@linux.alibaba.com>,
  Ryan Roberts <ryan.roberts@arm.com>,  Yang Shi
 <yang@os.amperecomputing.com>,  "Christoph Lameter (Ampere)"
 <cl@gentwo.org>,  Dev Jain <dev.jain@arm.com>,  Barry Song
 <baohua@kernel.org>,  Anshuman Khandual <anshuman.khandual@arm.com>,
  Yicong Yang <yangyicong@hisilicon.com>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  Kevin Brodsky <kevin.brodsky@arm.com>,  Yin
 Fengwei <fengwei_yin@linux.alibaba.com>,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/2] mm: add spurious fault fixing support for huge pmd
In-Reply-To: <8c51da7a-7370-4678-96a3-7cd6eaf0db62@redhat.com> (David
	Hildenbrand's message of "Mon, 15 Sep 2025 13:08:09 +0200")
References: <20250915032946.33203-1-ying.huang@linux.alibaba.com>
	<20250915032946.33203-2-ying.huang@linux.alibaba.com>
	<8c51da7a-7370-4678-96a3-7cd6eaf0db62@redhat.com>
Date: Tue, 16 Sep 2025 09:36:03 +0800
Message-ID: <87frcn6uws.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, David,

Thanks for review!

David Hildenbrand <david@redhat.com> writes:

> On 15.09.25 05:29, Huang Ying wrote:
>> In the current kernel, there is spurious fault fixing support for pte,
>> but not for huge pmd because no architectures need it. But in the
>> next patch in the series, we will change the write protection fault
>> handling logic on arm64, so that some stale huge pmd entries may
>> remain in the TLB. These entries need to be flushed via the huge pmd
>> spurious fault fixing mechanism.
>> Signed-off-by: Huang Ying <ying.huang@linux.alibaba.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Yang Shi <yang@os.amperecomputing.com>
>> Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>
>> Cc: Dev Jain <dev.jain@arm.com>
>> Cc: Barry Song <baohua@kernel.org>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Yicong Yang <yangyicong@hisilicon.com>
>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
>> Cc: Yin Fengwei <fengwei_yin@linux.alibaba.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> ---
>
> [...]
>
>>     int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct
>> *src_mm,
>> @@ -1857,7 +1861,20 @@ void huge_pmd_set_accessed(struct vm_fault *vmf)
>>   	if (unlikely(!pmd_same(*vmf->pmd, vmf->orig_pmd)))
>>   		goto unlock;
>>   -	touch_pmd(vmf->vma, vmf->address, vmf->pmd, write);
>> +	if (!touch_pmd(vmf->vma, vmf->address, vmf->pmd, write)) {
>> +		/* Skip spurious TLB flush for retried page fault */
>> +		if (vmf->flags & FAULT_FLAG_TRIED)
>> +			goto unlock;
>> +		/*
>> +		 * This is needed only for protection faults but the arch code
>> +		 * is not yet telling us if this is a protection fault or not.
>> +		 * This still avoids useless tlb flushes for .text page faults
>> +		 * with threads.
>> +		 */
>
> Can we instead just remove these comments and simplly say "see
> handle_pte_fault()"

Sure.

>> +		if (vmf->flags & FAULT_FLAG_WRITE)
>> +			flush_tlb_fix_spurious_fault_pmd(vmf->vma, vmf->address,
>> +							 vmf->pmd);
>> +	}
>
> Okay, In the PTE case, we call flush_tlb_fix_spurious_fault() during
> write faults if ptep_set_access_flags() returned "0".
>
> You are calling flush_tlb_fix_spurious_fault_pmd() during a write
> fault when pmdp_set_access_flags() returned "0" as well.
>
> In general, LGTM, but I would just let touch_pmd() return the value of
> pmdp_set_access_flags() instead and add a quick comment for
> touch_pmd() what the return value means.

Sure.

---
Best Regards,
Huang, Ying

