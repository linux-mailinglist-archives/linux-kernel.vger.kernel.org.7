Return-Path: <linux-kernel+bounces-884722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D9FC30E65
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 443214E3D51
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134D72EDD60;
	Tue,  4 Nov 2025 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0SvR9VoW"
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF652EC54B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258213; cv=none; b=amoTETFiz6fv/2AEY5pfvlAL8b5VuFkjG/cJqX5N43qaH0of8OMBPqn6aR9Ve73xz1NDMDi4WI8NA0yErWLzx1qLT0aZwnVkZGu+96iw7hqXPWENAdhg9GtRLnfIOd+Tyja+Rh3yU9cJpijaZOxIf+ZaH6c8aUhWqlzkqdUAwE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258213; c=relaxed/simple;
	bh=81NqNFq430kZI2prWoUsrG2YpuuCb8Xd55KakpMw4fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cXpHGbGvhY9y5I/WXXZWDI/uWwT/VhfssmQRw7CeouYqVrG3ybK8HYVyNgop7ramdT0FTofzpk/OEi+xQ4Dn5jM+OPlEfmTjk2dsMGHe41varkdSbeC5n0exaHRg6xy8J1r0BPbGYCwMxH5A/g+j0de50ZjPQZk/2PEUxYMU898=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0SvR9VoW; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=muowinBjB5u+VBZIerFKK9Iv670g+lCFTaqTXK7kMfE=;
	b=0SvR9VoWnt+T2u4dNohjI1F1XGclCpF4gVQDX59MF6RB1AetoxXCPPt0x5HpT6tj7G0EXNQXq
	D+L0xxUHXFYSuOFWuuFq3w9/akt8+DBjAXz1gFhoBNzSQQSXW4ILAJxcR4aqxRLtmR/z7BglSMZ
	1suk62WNhnA8ACmx1hOq6iE=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4d16fy4f48zmV6l;
	Tue,  4 Nov 2025 20:08:26 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B8CE140143;
	Tue,  4 Nov 2025 20:10:01 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 20:10:00 +0800
Message-ID: <c9925b2e-207b-447e-afce-07873406a853@huawei.com>
Date: Tue, 4 Nov 2025 20:09:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: use per_vma lock for MADV_DONTNEED
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: Barry Song <21cnbao@gmail.com>, <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, Suren Baghdasaryan <surenb@google.com>,
	<linux-kernel@vger.kernel.org>, Barry Song <v-songbaohua@oppo.com>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Lokesh Gidra
	<lokeshgidra@google.com>, Tangquan Zheng <zhengtangquan@oppo.com>, Qi Zheng
	<zhengqi.arch@bytedance.com>
References: <20250607220150.2980-1-21cnbao@gmail.com>
 <efeb3350-fbdf-408c-92ef-c6eada4a5755@huawei.com>
 <564941f2-b538-462a-ac55-f38d3e8a6f2e@lucifer.local>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <564941f2-b538-462a-ac55-f38d3e8a6f2e@lucifer.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2025/11/4 17:01, Lorenzo Stoakes wrote:
> On Tue, Nov 04, 2025 at 04:34:35PM +0800, Kefeng Wang wrote:
>>> +static enum madvise_lock_mode get_lock_mode(struct madvise_behavior *madv_behavior)
>>>    {
>>> +	int behavior = madv_behavior->behavior;
>>> +
>>>    	if (is_memory_failure(behavior))
>>> -		return 0;
>>> +		return MADVISE_NO_LOCK;
>>> -	if (madvise_need_mmap_write(behavior)) {
>>> +	switch (behavior) {
>>> +	case MADV_REMOVE:
>>> +	case MADV_WILLNEED:
>>> +	case MADV_COLD:
>>> +	case MADV_PAGEOUT:
>>> +	case MADV_FREE:
>>> +	case MADV_POPULATE_READ:
>>> +	case MADV_POPULATE_WRITE:
>>> +	case MADV_COLLAPSE:
>>> +	case MADV_GUARD_INSTALL:
>>> +	case MADV_GUARD_REMOVE:
>>> +		return MADVISE_MMAP_READ_LOCK;
>>> +	case MADV_DONTNEED:
>>> +	case MADV_DONTNEED_LOCKED:
>>> +		return MADVISE_VMA_READ_LOCK;
>>
>> I have a question, we will try per-vma lock for dontneed,
>> but there is a mmap_assert_locked() during madvise_dontneed_free(),
> 
> Hmm, this is only in the THP PUD huge case, and MADV_FREE is only valid for
> anonymous memory, and I think only DAX can have some weird THP PUD case.
> 
> So I don't think we can hit this.

Yes, we don't support pud THP for anonymous pages.

> 
> In any event, I think this mmap_assert_locked() is mistaken, as we should
> only need a VMA lock here.
> 
> So we could replace with a:
> 
> 	if (!rwsem_is_locked(&tlb->mm->mmap_lock))
> 		vma_assert_locked(vma);
> 
> ?
> 

The pmd dax/anon split don't have assert, for PUD dax, we maybe remove 
this assert?




>>
>> madvise_dontneed_free
>>    madvise_dontneed_single_vma
>>      zap_page_range_single_batched
>>        unmap_single_vma
>>           unmap_page_range
>>             zap_pud_range
>>               mmap_assert_locked
>>
>> We could fix it by passing the lock_mode into zap_detial and then check
>> the right lock here, but I'm not sure whether it is safe to zap page
>> only with vma lock?
> 
> It's fine to zap with the VMA lock. You need only hold the VMA stable which
> a VMA lock achieves.
> 
> See https://docs.kernel.org/mm/process_addrs.html

Thanks, I will learn it.

> 
>>
>> And another about 4f8ba33bbdfc （"mm: madvise: use per_vma lock
>> for MADV_FREE"）, it called walk_page_range_vma() in
>> madvise_free_single_vma(),  but from link[1] and 5631da56c9a8
>> ("fs/proc/task_mmu: read proc/pid/maps under per-vma lock"), it saids
>>
>>    "Note that similar approach would not work for /proc/pid/smaps
>>    reading as it also walks the page table and that's not RCU-safe"
>>
>> We could use walk_page_range_vma() instead of walk_page_range() in
>> smap_gather_stats(), and same question, why 4f8ba33bbdfc(for MADV_FREEE)
>> is safe but not for show_numa_map()/show_smap()?
> 
> We only use walk_page_range() there in case 4 listed in show_smaps_rollup()
> where the mmap lock is dropped on contention.

Sorry, I mean the walk_page_range() in smap_gather_stats() called by
show_smap()  from /proc/pid/smaps, not the walk_page_range() in
show_smaps_rollup() from /proc/pid/smaps_rollup.


> 
>>
>> Thanks.
>>
>> [1] https://lkml.kernel.org/r/20250719182854.3166724-1-surenb@google.com
> 
> AFAICT That's referring to a previous approach that tried to walk
> /proc/$pid/swaps under RCU _alone_ without VMA locks. This is not safe as
> page tables can be yanked from under you not under RCU.

But for now it tries per-vma lock or fallback to mmap lock, not 
lockless, so do you mean we could try per-vma lock for 
/proc/pid/numa_maps or /proc/pid/smaps ?

> 
> Cheers, Lorenzo
> 


