Return-Path: <linux-kernel+bounces-756226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4DDB1B171
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F2C3A75A6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BBE267386;
	Tue,  5 Aug 2025 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DU2zCSNn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1535264A97
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754387444; cv=none; b=XP8tUVirA6nZI2x16DExYf1Rj9FaD8JyBh2TiF7bVJ21Fv2wF03xhzm7SypNVi5EBrCPB/FefMk37eiPLzaf1IpjHdCYBp8wfkF6vuVkQJSgguNuxgSLOCRdIuMS8MsMU7wnrfL3yI02pcM7tIAc7kcdeL3rEsbR8onDOkX2G0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754387444; c=relaxed/simple;
	bh=627yRA4+bM9j7VlenuS8roeb24PCo1NNLjkpI2SnZ0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3OdksDOzM66goKbYT8k33iEbw3zQDeoIzXBLgEbHv92WPl82eynqJnzj3xmBagDQKvb+2IQCfhADHHRRzawA0QmGoVk2a7HrfgXfH1eGsg0cwWeU/OSv7d0sAM37pT44Ot3Xl5s/zn9PLRb/yoE2U4dnXzXrI97SzKL4uFECH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DU2zCSNn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754387441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8EvQmYRofvOplbO2mSmEYQlZEwalBTIU+7aTAq0GsPY=;
	b=DU2zCSNnKfe/u+tOHFP2KzVbE/x8lQbQGfP12LECidzQGblE27KVRbnXsyZp3Cwp2V2bMt
	SIXTHBQWNjsjIN75mA8qSawvsjAUdJHGDTRFfX2dUFxt30tXt8DBL349KvNr14yNSOUOHe
	M0psHFfhJECo3abSQLwzWmgpXk8pwPM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-JTGjC3kHMPa3xUZzLyYdLA-1; Tue, 05 Aug 2025 05:50:40 -0400
X-MC-Unique: JTGjC3kHMPa3xUZzLyYdLA-1
X-Mimecast-MFC-AGG-ID: JTGjC3kHMPa3xUZzLyYdLA_1754387439
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-458b9ded499so22372875e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 02:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754387439; x=1754992239;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8EvQmYRofvOplbO2mSmEYQlZEwalBTIU+7aTAq0GsPY=;
        b=XQ7OGmKjDXDO0a3WCnBIx4DYBi6krRRfbRk0VTCsK0KxZ7IxV5kOFdrWiCPq1v6Z+6
         dDfViVa40KuYT/hplLERFHLTE55LeLRRioxNpkQAKAKtA0pCXYjq4eQaTpsdY3iFqbRe
         iL9WIUMNO7XMrzYoqAQWa+csaL4l0DqU9tCtjJ1m16RIsHzJGy+kTzNygPKYWGAF/Y8k
         Iz4jP3H4ogf/5rS9JuDHIJh5ukp2YUe9dvu0HecoQlqU9rm+xjMPjE7MOvnb/9tSHy8K
         8T959qnu+cTZNu2THu0zqPBncueeD45QpyvuF/ZX+W2sZLfhCrGZOWgOtSQzIWHH67i5
         UaDQ==
X-Gm-Message-State: AOJu0YznuYy7C/xxR4C5UQXlz7yun7KkFuqkQdEcQZGiuij2m3mIhaM3
	+a6Uk5N2BxXF8YbQuxQpuKc6TAskzCrn3BcWooGwyqNMfe7ker2IXd72TrX8CGY5o4hgWLumVkQ
	V0+QFmG/oBwRDVlcfujslPbJqDsfIjwc1jQkuW9JiTzWAOiW51sbMmVZs2WitTWWsQhABDxP/zA
	==
X-Gm-Gg: ASbGncvxK0PFMviadjY0fkxG6BYAHxUBdIXF0jXItp6vfxotT4DGgTZenGw+KpUph9u
	j6FW/ez5b/1yc2Jt01VwHETMfHkL+mCQ8dbGg7H8jVlj6vxcthuZppZ2jRM7NOlBAAaZ3ezj4ft
	JtDvcNTxj20alBDs7S0o5yGsQEi/yXMO8MhlmDmipUgwtN0L6H+Nq++NhJULD/mFvs+FoSrUYGr
	UfIJqUZ6X61UsbcLTFdgeEwRgwMts5j7I8JyWxdlbYH50rjqFcaWbv65Y119yIxJNTe1J58Rkxj
	iaz6qJZPi4k65mWH2IuAvSyRPHzRjaB/ju1VvLkYd83Wg4BC/MDCjAgBhBiaAsi1RsdDqXRuWWS
	uAnhCN+0OeFxJlQ9X+WkS8ubHLkCX2ttvJQ2zCeirfob3fTyzUYas29vCldc/OTCMbCo=
X-Received: by 2002:a05:600c:4f8e:b0:453:8bc7:5cbb with SMTP id 5b1f17b1804b1-458b6b3d9f1mr71626905e9.25.1754387438961;
        Tue, 05 Aug 2025 02:50:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLeifPtR1jHyiiqnkqcPBfkmNNIKxJIA7SboZGUI3MCfaovha7/rwiu27Nn8VFzBIljWpyig==
X-Received: by 2002:a05:600c:4f8e:b0:453:8bc7:5cbb with SMTP id 5b1f17b1804b1-458b6b3d9f1mr71626655e9.25.1754387438529;
        Tue, 05 Aug 2025 02:50:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:b200:607d:d3d2:3271:1be0? (p200300d82f2bb200607dd3d232711be0.dip0.t-ipconnect.de. [2003:d8:2f2b:b200:607d:d3d2:3271:1be0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e075805csm34786315e9.4.2025.08.05.02.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 02:50:37 -0700 (PDT)
Message-ID: <5ac2ec58-3908-4d0e-a29b-8b4d776410e3@redhat.com>
Date: Tue, 5 Aug 2025 11:50:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix the race between collapse and PT_RECLAIM under
 per-vma lock
To: Qi Zheng <zhengqi.arch@bytedance.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <21cnbao@gmail.com>,
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <064cca31-442d-4847-b353-26dc5fd0603c@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.08.25 11:30, Qi Zheng wrote:
> 
> 
> On 8/5/25 4:56 PM, Baolin Wang wrote:
>>
>>
>> On 2025/8/5 16:17, Qi Zheng wrote:
>>> Hi Baolin,
>>>
>>> On 8/5/25 3:53 PM, Baolin Wang wrote:
>>>>
>>>>
>>>> On 2025/8/5 14:42, Qi Zheng wrote:
>>>>> Hi Barry,
>>>>>
>>>>> On 8/5/25 11:54 AM, Barry Song wrote:
>>>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>>>
>>>>>> The check_pmd_still_valid() call during collapse is currently only
>>>>>> protected by the mmap_lock in write mode, which was sufficient when
>>>>>> pt_reclaim always ran under mmap_lock in read mode. However, since
>>>>>> madvise_dontneed can now execute under a per-VMA lock, this assumption
>>>>>> is no longer valid. As a result, a race condition can occur between
>>>>>> collapse and PT_RECLAIM, potentially leading to a kernel panic.
>>>>>
>>>>> There is indeed a race condition here. And after applying this patch, I
>>>>> can no longer reproduce the problem locally (I was able to reproduce it
>>>>> stably locally last night).
>>>>>
>>>>> But I still can't figure out how this race condtion causes the
>>>>> following panic:
>>>>>
>>>>> exit_mmap
>>>>> --> mmap_read_lock()
>>>>>       unmap_vmas()
>>>>>       --> pte_offset_map_lock
>>>>>           --> rcu_read_lock()
>>>>>               check if the pmd entry is a PTE page
>>>>>               ptl = pte_lockptr(mm, &pmdval)  <-- ptl is NULL
>>>>>               spin_lock(ptl)                  <-- PANIC!!
>>>>>
>>>>> If this PTE page is freed by pt_reclaim (via RCU), then the ptl can
>>>>> not be NULL.
>>>>>
>>>>> The collapse holds mmap write lock, so it is impossible to be
>>>>> concurrent
>>>>> with exit_mmap().
>>>>>
>>>>> Confusing. :(
>>>>
>>>> IIUC, the issue is not caused by the concurrency between exit_mmap
>>>> and collapse, but rather by the concurrency between pt_reclaim and
>>>> collapse.
>>>>
>>>> Before this patch, khugepaged might incorrectly restore a PTE
>>>> pagetable that had already been freed.
>>>>
>>>> pt_reclaim has cleared the pmd entry and freed the PTE page table.
>>>> However, due to the race condition, check_pmd_still_valid() still
>>>> passes and continues to attempt the collapse:
>>>>
>>>> _pmd = pmdp_collapse_flush(vma, address, pmd); ---> returns a none
>>>> pmd entry (the original pmd entry has been cleared)
>>>>
>>>> pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl); ---> returns
>>>> pte == NULL
>>>>
>>>> Then khugepaged will restore the old PTE pagetable with an invalid
>>>> pmd entry:
>>>>
>>>> pmd_populate(mm, pmd, pmd_pgtable(_pmd));
>>>>
>>>> So when the process exits and trys to free the mapping of the
>>>> process, traversing the invalid pmd table will lead to a crash.
>>>
>>> CPU0                         CPU1
>>> ====                         ====
>>>
>>> collapse
>>> --> pmd_populate(mm, pmd, pmd_pgtable(_pmd));
>>>       mmap_write_unlock
>>>                                exit_mmap
>>>                                --> hold mmap lock
>>>                                    __pte_offset_map_lock
>>>                                    --> pte = __pte_offset_map(pmd,
>>> addr, &pmdval);
>>>                                        if (unlikely(!pte))
>>>                                            return pte;   <-- will return
>>
>> __pte_offset_map() might not return NULL? Because the 'pmd_populate(mm,
>> pmd, pmd_pgtable(_pmd))' could populate a valid page (although the
>> '_pmd' entry is NONE), but it is not the original pagetable page.
> 
> CPU0                          CPU1
> ====                          ====
> 
> collapse
> --> check_pmd_still_valid
>                                 vma read lock
>                                 pt_reclaim clear the pmd entry and will
> free the PTE page (via RCU)
>                                 vma read unlock
> 
>       vma write lock
>       _pmd = pmdp_collapse_flush(vma, address, pmd) <-- pmd_none(_pmd)
>       pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl); <-- pte is
> NULL
>       pmd_populate(mm, pmd, pmd_pgtable(_pmd)); <-- populate a valid page?
>       vma write unlock
> 
> The above is the concurrent scenario you mentioned, right?
> 
> What types of this 'valid page' could be? If __pte_offset_map() returns
> non-NULL, then it is a PTE page. Even if it is not the original one, it
> should not cause panic. Did I miss some key information? :(

Wasn't the original issue all about a NULL-pointer de-reference while 
*locking*?

Note that in that kernel config [1] we have CONFIG_DEBUG_SPINLOCK=y, so 
likely we will have ALLOC_SPLIT_PTLOCKS set.

[1] 
https://github.com/laifryiee/syzkaller_logs/blob/main/250803_193026___pte_offset_map_lock/.config

-- 
Cheers,

David / dhildenb


