Return-Path: <linux-kernel+bounces-756241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C016B1B1BB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FEF03B10F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCBA26A0A6;
	Tue,  5 Aug 2025 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dwdW68Gg"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0FB38FA6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754388437; cv=none; b=rphy7IbkANLuMrlprfV/g1DBVr6bHjgW+JZ/Z5v2A0wPxiPrpJQ9XODNTKf/37IKfQxw9zYCAN919nKqYYZzwOCQIEh6k5y/tYwnED/54wzNfUoyNoGNPavzQ28/Gir8NzmM5yf5GJ5GXiqW1NKRZ6ZBHTKUwLSt55opoEGD2yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754388437; c=relaxed/simple;
	bh=S3Wyu9Ih7/dZCvLX+FVAREkiCGNVTQL/rQiBKfhPHsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pk2P9wBHWOGbuUnEu50LHdnOcsYuhJu07WZ6B85TrKmDcsXkth7HgGqXDCz+3vfjyAZ3KSC8Kjvrj3lWtCtPS8IInXRnUcPrJQSnf/374ag6P/V3FHX8YR+HjYcfOPMgI98gvMZ2O0V6QpweVeRILzeHIIk7APRMe0fPusgNUZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dwdW68Gg; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754388426; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7Ze3GOW3FYLRkT2szR3JOGlwVtUNL/sUjzyH2NQ1q7M=;
	b=dwdW68GgRPtHSR86kxELjwzUyD+B9yvlHNwX/UDDUTGsBJC8HZjn0k7KG2HqYnrYZC2DYmZ1Juu//7WgVL1OcDOQrV8LEavW7HQRkTkqbl4LfGC/e8D+UWsdU05PSwzkpHpUgs86bzM6EmAkLi3nxr8qO60cc+LzJIdyUyzeBPE=
Received: from 30.74.144.114(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wl4v-.X_1754388423 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Aug 2025 18:07:04 +0800
Message-ID: <46f0b251-237c-421d-aec0-adff6c2e1bb4@linux.alibaba.com>
Date: Tue, 5 Aug 2025 18:07:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix the race between collapse and PT_RECLAIM under
 per-vma lock
To: David Hildenbrand <david@redhat.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 "Lai, Yi" <yi1.lai@linux.intel.com>,
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
 <c6f9dacf-d520-4cc3-88ac-c5937916aa2c@linux.alibaba.com>
 <064cca31-442d-4847-b353-26dc5fd0603c@bytedance.com>
 <5ac2ec58-3908-4d0e-a29b-8b4d776410e3@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <5ac2ec58-3908-4d0e-a29b-8b4d776410e3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/8/5 17:50, David Hildenbrand wrote:
> On 05.08.25 11:30, Qi Zheng wrote:
>>
>>
>> On 8/5/25 4:56 PM, Baolin Wang wrote:
>>>
>>>
>>> On 2025/8/5 16:17, Qi Zheng wrote:
>>>> Hi Baolin,
>>>>
>>>> On 8/5/25 3:53 PM, Baolin Wang wrote:
>>>>>
>>>>>
>>>>> On 2025/8/5 14:42, Qi Zheng wrote:
>>>>>> Hi Barry,
>>>>>>
>>>>>> On 8/5/25 11:54 AM, Barry Song wrote:
>>>>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>>>>
>>>>>>> The check_pmd_still_valid() call during collapse is currently only
>>>>>>> protected by the mmap_lock in write mode, which was sufficient when
>>>>>>> pt_reclaim always ran under mmap_lock in read mode. However, since
>>>>>>> madvise_dontneed can now execute under a per-VMA lock, this 
>>>>>>> assumption
>>>>>>> is no longer valid. As a result, a race condition can occur between
>>>>>>> collapse and PT_RECLAIM, potentially leading to a kernel panic.
>>>>>>
>>>>>> There is indeed a race condition here. And after applying this 
>>>>>> patch, I
>>>>>> can no longer reproduce the problem locally (I was able to 
>>>>>> reproduce it
>>>>>> stably locally last night).
>>>>>>
>>>>>> But I still can't figure out how this race condtion causes the
>>>>>> following panic:
>>>>>>
>>>>>> exit_mmap
>>>>>> --> mmap_read_lock()
>>>>>>       unmap_vmas()
>>>>>>       --> pte_offset_map_lock
>>>>>>           --> rcu_read_lock()
>>>>>>               check if the pmd entry is a PTE page
>>>>>>               ptl = pte_lockptr(mm, &pmdval)  <-- ptl is NULL
>>>>>>               spin_lock(ptl)                  <-- PANIC!!
>>>>>>
>>>>>> If this PTE page is freed by pt_reclaim (via RCU), then the ptl can
>>>>>> not be NULL.
>>>>>>
>>>>>> The collapse holds mmap write lock, so it is impossible to be
>>>>>> concurrent
>>>>>> with exit_mmap().
>>>>>>
>>>>>> Confusing. :(
>>>>>
>>>>> IIUC, the issue is not caused by the concurrency between exit_mmap
>>>>> and collapse, but rather by the concurrency between pt_reclaim and
>>>>> collapse.
>>>>>
>>>>> Before this patch, khugepaged might incorrectly restore a PTE
>>>>> pagetable that had already been freed.
>>>>>
>>>>> pt_reclaim has cleared the pmd entry and freed the PTE page table.
>>>>> However, due to the race condition, check_pmd_still_valid() still
>>>>> passes and continues to attempt the collapse:
>>>>>
>>>>> _pmd = pmdp_collapse_flush(vma, address, pmd); ---> returns a none
>>>>> pmd entry (the original pmd entry has been cleared)
>>>>>
>>>>> pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl); ---> returns
>>>>> pte == NULL
>>>>>
>>>>> Then khugepaged will restore the old PTE pagetable with an invalid
>>>>> pmd entry:
>>>>>
>>>>> pmd_populate(mm, pmd, pmd_pgtable(_pmd));
>>>>>
>>>>> So when the process exits and trys to free the mapping of the
>>>>> process, traversing the invalid pmd table will lead to a crash.
>>>>
>>>> CPU0                         CPU1
>>>> ====                         ====
>>>>
>>>> collapse
>>>> --> pmd_populate(mm, pmd, pmd_pgtable(_pmd));
>>>>       mmap_write_unlock
>>>>                                exit_mmap
>>>>                                --> hold mmap lock
>>>>                                    __pte_offset_map_lock
>>>>                                    --> pte = __pte_offset_map(pmd,
>>>> addr, &pmdval);
>>>>                                        if (unlikely(!pte))
>>>>                                            return pte;   <-- will 
>>>> return
>>>
>>> __pte_offset_map() might not return NULL? Because the 'pmd_populate(mm,
>>> pmd, pmd_pgtable(_pmd))' could populate a valid page (although the
>>> '_pmd' entry is NONE), but it is not the original pagetable page.
>>
>> CPU0                          CPU1
>> ====                          ====
>>
>> collapse
>> --> check_pmd_still_valid
>>                                 vma read lock
>>                                 pt_reclaim clear the pmd entry and will
>> free the PTE page (via RCU)
>>                                 vma read unlock
>>
>>       vma write lock
>>       _pmd = pmdp_collapse_flush(vma, address, pmd) <-- pmd_none(_pmd)
>>       pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl); <-- pte is
>> NULL
>>       pmd_populate(mm, pmd, pmd_pgtable(_pmd)); <-- populate a valid 
>> page?
>>       vma write unlock
>>
>> The above is the concurrent scenario you mentioned, right?

Yes.

>>
>> What types of this 'valid page' could be? If __pte_offset_map() returns
>> non-NULL, then it is a PTE page. Even if it is not the original one, it
>> should not cause panic. Did I miss some key information? :(

Sorry for not being clear. Let me try again.

In the race condition described above, the '_pmd' value is NONE, meaning 
that when restoring the pmd entry with ‘pmd_populate(mm, pmd, 
pmd_pgtable(_pmd))’, the 'pmd_pgtable(_pmd)' can return a struct page 
corresponding to pfn == 0 (cause the '_pmd' is NONE) to populate the pmd 
entry. Clearly, this pfn == 0 page is not a pagetable page, meaning the 
corresponding ptl lock of this page is not initialized.

Additionally, from the boot dmesg, I can see that the BIOS reports an 
address range with pfn == 0, indicating that there is a struct page 
initialized for pfn == 0 (possibly a reserved page):

[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007ffe0000-0x000000007fffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] 
reserved

Of course, this is my theoretical analysis from the code perspective. If 
there are other race conditions, I would be very surprised:)

> Wasn't the original issue all about a NULL-pointer de-reference while 
> *locking*?

Yes.

> Note that in that kernel config [1] we have CONFIG_DEBUG_SPINLOCK=y, so 
> likely we will have ALLOC_SPLIT_PTLOCKS set.
> 
> [1] https://github.com/laifryiee/syzkaller_logs/blob/ 
> main/250803_193026___pte_offset_map_lock/.config
> 

