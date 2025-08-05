Return-Path: <linux-kernel+bounces-756147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DA6B1B08A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4741899D61
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61262258CF6;
	Tue,  5 Aug 2025 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AdHKDmDH"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A062580F7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754384196; cv=none; b=M3sXvv+lSuE/V4HBnbH4tviBWIm/CkC07yzs3UhkhnPoFqigrpaFrVomVLVUgxmbN67SPhGSNP6gPa6drOUz9DbrEXDaj4E85u0uWloapUJr4QkRTgAmBbdXKkOzsk8/BE6iRh5CQ5O6CELQoFS4XtT7+KFvmgP0DJhJAKJiTbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754384196; c=relaxed/simple;
	bh=xYhwcpFuCni1hwXBMdKjFy/NpkBjfpLrv9c3IVpT86Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aU+MO0hoMSFemV5jSA5F5UCT7xtIkX9CtbiCtHsRDVSRwYaLf4SswVad9+HBkxW1OH3+bPTWr/QHsYY+hN2g7QxvokGFWhBl0Cx26p29EwDKJrSn45yQhs3YeGnevZDpALMeUst3Ht7wQKUux6yXzG25fhg3k4VY0+dIsTtkhtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AdHKDmDH; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754384185; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2NBVVAA2DuTVhMuc2zncIDms1+52a6Ct/b9XmMxwvBQ=;
	b=AdHKDmDH9gYhSk9PV47/+9PYkuvl2CEtk+PKCp4rNqhQJQG8gE6Mj3mY7kiICsvE5HJflYP8MyZ49BMVclmn7PiVu7p0JnAXgFEE1bs0DBCJuc0U66gCfphOQXYF1ymMTEoACmysS0ifpH/AuV27ODr/kOTO9pvagyi+594zPDg=
Received: from 30.74.144.114(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wl4cIP7_1754384182 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Aug 2025 16:56:23 +0800
Message-ID: <c6f9dacf-d520-4cc3-88ac-c5937916aa2c@linux.alibaba.com>
Date: Tue, 5 Aug 2025 16:56:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix the race between collapse and PT_RECLAIM under
 per-vma lock
To: Qi Zheng <zhengqi.arch@bytedance.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 "Lai, Yi" <yi1.lai@linux.intel.com>, David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Suren Baghdasaryan <surenb@google.com>, Lokesh Gidra
 <lokeshgidra@google.com>, Tangquan Zheng <zhengtangquan@oppo.com>,
 Lance Yang <ioworker0@gmail.com>, Zi Yan <ziy@nvidia.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>
References: <20250805035447.7958-1-21cnbao@gmail.com>
 <35417160-86bf-4580-8ae9-5cadd4f6401d@bytedance.com>
 <d73213ba-5ca0-451c-b82b-f590d10da6d7@linux.alibaba.com>
 <b594a315-8458-439c-b535-fc7f052a3fae@bytedance.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <b594a315-8458-439c-b535-fc7f052a3fae@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/8/5 16:17, Qi Zheng wrote:
> Hi Baolin,
> 
> On 8/5/25 3:53 PM, Baolin Wang wrote:
>>
>>
>> On 2025/8/5 14:42, Qi Zheng wrote:
>>> Hi Barry,
>>>
>>> On 8/5/25 11:54 AM, Barry Song wrote:
>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>
>>>> The check_pmd_still_valid() call during collapse is currently only
>>>> protected by the mmap_lock in write mode, which was sufficient when
>>>> pt_reclaim always ran under mmap_lock in read mode. However, since
>>>> madvise_dontneed can now execute under a per-VMA lock, this assumption
>>>> is no longer valid. As a result, a race condition can occur between
>>>> collapse and PT_RECLAIM, potentially leading to a kernel panic.
>>>
>>> There is indeed a race condition here. And after applying this patch, I
>>> can no longer reproduce the problem locally (I was able to reproduce it
>>> stably locally last night).
>>>
>>> But I still can't figure out how this race condtion causes the
>>> following panic:
>>>
>>> exit_mmap
>>> --> mmap_read_lock()
>>>      unmap_vmas()
>>>      --> pte_offset_map_lock
>>>          --> rcu_read_lock()
>>>              check if the pmd entry is a PTE page
>>>              ptl = pte_lockptr(mm, &pmdval)  <-- ptl is NULL
>>>              spin_lock(ptl)                  <-- PANIC!!
>>>
>>> If this PTE page is freed by pt_reclaim (via RCU), then the ptl can 
>>> not be NULL.
>>>
>>> The collapse holds mmap write lock, so it is impossible to be concurrent
>>> with exit_mmap().
>>>
>>> Confusing. :(
>>
>> IIUC, the issue is not caused by the concurrency between exit_mmap and 
>> collapse, but rather by the concurrency between pt_reclaim and collapse.
>>
>> Before this patch, khugepaged might incorrectly restore a PTE 
>> pagetable that had already been freed.
>>
>> pt_reclaim has cleared the pmd entry and freed the PTE page table. 
>> However, due to the race condition, check_pmd_still_valid() still 
>> passes and continues to attempt the collapse:
>>
>> _pmd = pmdp_collapse_flush(vma, address, pmd); ---> returns a none pmd 
>> entry (the original pmd entry has been cleared)
>>
>> pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl); ---> returns 
>> pte == NULL
>>
>> Then khugepaged will restore the old PTE pagetable with an invalid pmd 
>> entry:
>>
>> pmd_populate(mm, pmd, pmd_pgtable(_pmd));
>>
>> So when the process exits and trys to free the mapping of the process, 
>> traversing the invalid pmd table will lead to a crash.
> 
> CPU0                         CPU1
> ====                         ====
> 
> collapse
> --> pmd_populate(mm, pmd, pmd_pgtable(_pmd));
>      mmap_write_unlock
>                               exit_mmap
>                               --> hold mmap lock
>                                   __pte_offset_map_lock
>                                   --> pte = __pte_offset_map(pmd, addr, 
> &pmdval);
>                                       if (unlikely(!pte))
>                                           return pte;   <-- will return

__pte_offset_map() might not return NULL? Because the 'pmd_populate(mm, 
pmd, pmd_pgtable(_pmd))' could populate a valid page (although the 
'_pmd' entry is NONE), but it is not the original pagetable page.

> IIUC, in this case, if we get an invalid pmd entry, we will retrun
> directly instead of causing a crash?
> 
>>
>> Barry, please correct me if I have misunderstood something.
>>
> 


