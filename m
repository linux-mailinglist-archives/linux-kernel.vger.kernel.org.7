Return-Path: <linux-kernel+bounces-756192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD20EB1B110
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F02F1889CE0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423F8230BF8;
	Tue,  5 Aug 2025 09:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gjYVpEn9"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B4923816E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386265; cv=none; b=eRqOrR1dyJjqoE8msOm7aD6sGz46V8HHmgUuTQWpTcmTzVtqDfCgyAjIxL4duQTLyKUGt2gXZ674I4UjbNE/wqjTW1nQWwAJgVxP+MHp9el1boDq2eAB/po2EJTDrMEIauOkFLpZ9sYwNdvQZ/eEHqxrYbUneX1gijbxhtdDb5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386265; c=relaxed/simple;
	bh=1i3p+NGpdrhunCHvwCp1ssYK4/irjxQ8qoHh/lJVJEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2EhZNpDX2LVE3Q9lyvKoIRSkyBiSpqhZ9hdpicuN7WiJ0FYCaouxRmpT2w1CcF8ejn/Cd2ZA1zRzk597aNYv09W+2gAw+oeflxxTDf2kt1FIl/5uMdupGlAIAicE4YDEvVe1WnlZoUT5MO69mM+f2krwWIN3iNd8965BDUnBqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gjYVpEn9; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b3220c39cffso3973157a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 02:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1754386262; x=1754991062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcSz6w8T+qiYKIZHXA0L96GhzkBgLZFE74LcxOMy1nU=;
        b=gjYVpEn9IL9heODm5HVF4lbMDG+KdMwibB/nFYlB8ckTQEbOTV6fjkIUe2wdCgKS43
         aRVc3DyU46AUV3FqC0Vwgx4FobFZPa4g26K/PUu7UN+v+Gb5PoH/qt0emGmf4KLHcKKi
         4a2Wx2rgxDaAOBzxzrOVR6tMmDNNbJ96p4M5HDspgBEn/pKWSdz4Xlbm4inSfVb+3Mid
         jL+yTycK0y2DofXkH9iKAiJjpdG9XCnQL22LgrEfZ3obdAU46QQcd2fiF97GJ5UgxuMz
         xdg63LqmXPNVd5bJnrit5u5Tp/M2c1LoirSBaCkPpgfMvefWtpjAGMnAsvn/EDKN/j67
         IBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754386262; x=1754991062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hcSz6w8T+qiYKIZHXA0L96GhzkBgLZFE74LcxOMy1nU=;
        b=dqETsGLeKMZpHDdjuKSvXsRYXR16pWujGJuA0CV1QTqqkwrw+aaws4MH8indLMOLNa
         Lqnx6/5wLoKUbGIqX8jWVeLPzJVUmv1krp/lJLDaGLQXUjCMezZSWnnugdB1AupZ/Lo2
         BVv8vZ0W7eX9bbPipPcvHnT0Mk21s9K3InLMz5L2Z52mq7ak8pNZif/ja2VFZMMoQc+Q
         eA6g4zehwZ+V2fu3SzvqTS48eimhkMVh4eOcacCiFzfM2BNhXxrlMFpo8eAOierUL6yI
         SA7sKq7J2fDSpUHbVzJBTp+U9YfphHm1HOhc5xS8XCSk9xJZJ0+JfANWmk6zRHn4FvWj
         VF6w==
X-Gm-Message-State: AOJu0Yzh2sCdiPPCHH+2AVuct5H+eO0sAySBuIaU/o8HDFwkv1cpnAcj
	bEaTiaYbRs+OMWx68bkeLbC1KTXAAJyAEjMVR2Sw4CZOisGaR6t4X4gkonrpWPYdFJk=
X-Gm-Gg: ASbGnctKQXLu2VX2SZWDUgk824Ybw+Be8WIRD0M/bnB9XlVvHm1sludWyaaBC84DXfh
	jhUAIMLUr1FLA23wUSPyRsYFDsK+J1OBoum53HUuFp3AhIoaHREqjWLr0W4GG60m8LjxLmCNpe8
	Cv3Y+dJyn5N34wH8sM9dAE2BCt6wiwFe4kASRd0h5VGmSrR71gqWmXwA9ByqqVYsalJPu+7W280
	GV9EsbqNgRZOkH7TBcsr3zAYl13oO5/o6x0HhlcUDt8ecv/2gfbyGM7ko5NB42jFJRvcE5ynhAr
	I6+MzaCdWSdl4SXrDypEvooeFsGx7gZt/N6VsRwr0kkgvmvjD0f3b5yWGpLLY2goGUrSYAW+MGx
	sJazIc1Xm9hZ9AGRI9QRwEpS+zjzGaKUBtjRfGZPpe86T
X-Google-Smtp-Source: AGHT+IG1HKRs9XWU020nzVLECpDXa3lJhwfMUaTwx5lJK40D506Do8TSCO+UECOj2zkcTVSvxEqc+Q==
X-Received: by 2002:a17:902:f10c:b0:240:678c:d2b7 with SMTP id d9443c01a7336-24246f599ccmr122175505ad.15.1754386261808;
        Tue, 05 Aug 2025 02:31:01 -0700 (PDT)
Received: from [10.4.54.91] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6c62sm130288695ad.4.2025.08.05.02.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 02:31:01 -0700 (PDT)
Message-ID: <064cca31-442d-4847-b353-26dc5fd0603c@bytedance.com>
Date: Tue, 5 Aug 2025 17:30:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix the race between collapse and PT_RECLAIM under
 per-vma lock
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org
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
 <c6f9dacf-d520-4cc3-88ac-c5937916aa2c@linux.alibaba.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <c6f9dacf-d520-4cc3-88ac-c5937916aa2c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/5/25 4:56 PM, Baolin Wang wrote:
> 
> 
> On 2025/8/5 16:17, Qi Zheng wrote:
>> Hi Baolin,
>>
>> On 8/5/25 3:53 PM, Baolin Wang wrote:
>>>
>>>
>>> On 2025/8/5 14:42, Qi Zheng wrote:
>>>> Hi Barry,
>>>>
>>>> On 8/5/25 11:54 AM, Barry Song wrote:
>>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>>
>>>>> The check_pmd_still_valid() call during collapse is currently only
>>>>> protected by the mmap_lock in write mode, which was sufficient when
>>>>> pt_reclaim always ran under mmap_lock in read mode. However, since
>>>>> madvise_dontneed can now execute under a per-VMA lock, this assumption
>>>>> is no longer valid. As a result, a race condition can occur between
>>>>> collapse and PT_RECLAIM, potentially leading to a kernel panic.
>>>>
>>>> There is indeed a race condition here. And after applying this patch, I
>>>> can no longer reproduce the problem locally (I was able to reproduce it
>>>> stably locally last night).
>>>>
>>>> But I still can't figure out how this race condtion causes the
>>>> following panic:
>>>>
>>>> exit_mmap
>>>> --> mmap_read_lock()
>>>>      unmap_vmas()
>>>>      --> pte_offset_map_lock
>>>>          --> rcu_read_lock()
>>>>              check if the pmd entry is a PTE page
>>>>              ptl = pte_lockptr(mm, &pmdval)  <-- ptl is NULL
>>>>              spin_lock(ptl)                  <-- PANIC!!
>>>>
>>>> If this PTE page is freed by pt_reclaim (via RCU), then the ptl can 
>>>> not be NULL.
>>>>
>>>> The collapse holds mmap write lock, so it is impossible to be 
>>>> concurrent
>>>> with exit_mmap().
>>>>
>>>> Confusing. :(
>>>
>>> IIUC, the issue is not caused by the concurrency between exit_mmap 
>>> and collapse, but rather by the concurrency between pt_reclaim and 
>>> collapse.
>>>
>>> Before this patch, khugepaged might incorrectly restore a PTE 
>>> pagetable that had already been freed.
>>>
>>> pt_reclaim has cleared the pmd entry and freed the PTE page table. 
>>> However, due to the race condition, check_pmd_still_valid() still 
>>> passes and continues to attempt the collapse:
>>>
>>> _pmd = pmdp_collapse_flush(vma, address, pmd); ---> returns a none 
>>> pmd entry (the original pmd entry has been cleared)
>>>
>>> pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl); ---> returns 
>>> pte == NULL
>>>
>>> Then khugepaged will restore the old PTE pagetable with an invalid 
>>> pmd entry:
>>>
>>> pmd_populate(mm, pmd, pmd_pgtable(_pmd));
>>>
>>> So when the process exits and trys to free the mapping of the 
>>> process, traversing the invalid pmd table will lead to a crash.
>>
>> CPU0                         CPU1
>> ====                         ====
>>
>> collapse
>> --> pmd_populate(mm, pmd, pmd_pgtable(_pmd));
>>      mmap_write_unlock
>>                               exit_mmap
>>                               --> hold mmap lock
>>                                   __pte_offset_map_lock
>>                                   --> pte = __pte_offset_map(pmd, 
>> addr, &pmdval);
>>                                       if (unlikely(!pte))
>>                                           return pte;   <-- will return
> 
> __pte_offset_map() might not return NULL? Because the 'pmd_populate(mm, 
> pmd, pmd_pgtable(_pmd))' could populate a valid page (although the 
> '_pmd' entry is NONE), but it is not the original pagetable page.

CPU0                          CPU1
====                          ====

collapse
--> check_pmd_still_valid
                               vma read lock
                               pt_reclaim clear the pmd entry and will 
free the PTE page (via RCU)
                               vma read unlock

     vma write lock
     _pmd = pmdp_collapse_flush(vma, address, pmd) <-- pmd_none(_pmd)
     pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl); <-- pte is 
NULL
     pmd_populate(mm, pmd, pmd_pgtable(_pmd)); <-- populate a valid page?
     vma write unlock

The above is the concurrent scenario you mentioned, right?

What types of this 'valid page' could be? If __pte_offset_map() returns
non-NULL, then it is a PTE page. Even if it is not the original one, it
should not cause panic. Did I miss some key information? :(

> 
>> IIUC, in this case, if we get an invalid pmd entry, we will retrun
>> directly instead of causing a crash?
>>
>>>
>>> Barry, please correct me if I have misunderstood something.
>>>
>>
> 


