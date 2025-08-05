Return-Path: <linux-kernel+bounces-756110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB4EB1B01D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5DA18975A2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B618023A562;
	Tue,  5 Aug 2025 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HEUZWGoK"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D09378F2F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754381833; cv=none; b=hfCJ7zpc2ErtHFiwMctHmvw35FgQVQwn3uePCVXxS8GO/uR2SrOuW7bNZwwrOanfPB5uWuzouY3/bF1j5ujhbyczH3hcQiPGcuhIWIQJNC4kIYqu3YLXbAtzAYevQFswxAnnEBxOXZJ4k4nQjBxombL0uBhRM4duJS4bJcNPyoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754381833; c=relaxed/simple;
	bh=3dFsx4eSSMGoD1vphLnPizmmQ2jSZohyIoMAAP2cwwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iobpa01Vt07xUsvniW/vOjHxirrHZtDKDLAgvSEALs1BQTazcL1ugoG/cE5bwUWB5/x8jiCpyxCiVbzYEzGsOa6AJxo6ggmy7r3IKsUIoGU5h6H8bN6+XoA1vjPhgoT7c6mih8lVfhFnxDYYj5c5wcpyy2ILSEk9CEODQHoke84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HEUZWGoK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76c18568e5eso1065459b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 01:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1754381830; x=1754986630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hdi0osdCtNEGUqWnHGcG2RCagqkAaiO8Ttk2Pz8O1BE=;
        b=HEUZWGoKwe1iFsA9wEc1VOrq+MdbFwWfByUKB9IMvxd683y9rg4pDI2lwgUfAWbDlS
         +PjsCKjXKoTCXdf25WM8VE7sGz+tXfhmrpvraztcmiBssSjv2181UlOFD4x0wU7HBXCi
         bBiehyIabvM+RH/qcoQDjEUWQFn9ZCTiVT4LDekEURTtjtPQjbgrNYhc3H8knD3SmvZ9
         cMlpmKL6RHBYNzIX0dANK2k7Fg//RXSByT+LVQ2DvzsRZ2mToJO9Yo3K7jlnqVoGqMTC
         gYYuN95bzl05iBHyM8eqI/QgusAMCpdQICqKRB58hEC7y5sf/dSQlJCF5mC1QTsGfkG5
         jhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754381830; x=1754986630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hdi0osdCtNEGUqWnHGcG2RCagqkAaiO8Ttk2Pz8O1BE=;
        b=npBdjIsROnA7cbWEElax+RiczZznBowlakXxX1PwC734s2MmXLhkDo8NfB8IrYQygL
         FgxEJgb07gIKvZ1t09jrEkFuqF6n9To2DdAcmKhlEWnsdO2yO8oQiFWAFEWoidx4G0vv
         sM476u/B5Qld7VVBDjWaSDTWXmLGsjpPC5aDrCiy25KO5qEdiU38bsmXPspy7v3A0kb0
         Xqz2CDt26dfJgBWL8XAYlJ+rHspv11vBe66G9rR74CaETDXmeKJGSfA8nYs8flMeRU8K
         vCk6qXGm6lZwonzssgDWk8a98JOeF00sB5GI3/uWL3m71wR1OmtJE+DVfmRjIcO4EYev
         8XRA==
X-Gm-Message-State: AOJu0Yyf7DS4fmWio7v7WVfCeaJlWAHMoGW2juM4v2wWgwtldvwEtSxH
	yEU2kg7lBPDqxUrLXQQI3UWSpEir5SP3JE15Cf8bgvYEKkxEJxKgwMOq7oe1XVR6o3s=
X-Gm-Gg: ASbGnctD0l6FkqUtvgL3xEDa3F0rAMNQDed16F56VvTy1q2t2XB4uN1R+K4dKi2PK9I
	uuVMuPuAqqDG206wrU2JMMNWnXY4Qs8UU7XOYCpFD3tj+yqQ9ZWFA0tM6SbnJGZwDT1toa1w6Uh
	tst2ss/df4fFwaL8q1vbhGkjK1OzqiWkoLOwi4nmvQ2rgyyHs6pI1ONW3rptQEpymEVj3nDx/61
	efpQOJTR0GitkPlfKMVWhcPk1gNSTvkYUQ//JmcPPJe+gzeVhGeCMo8V6YSH+hFD/uQVzORiqXM
	90uuyxsmZC+wHu152i7bhzGwXgQbfZ18hlL9+ue9ooni8R8J+5f32zOrWnO3mh0cT/9m1jyqsty
	fK/MKEu0ehHdAdYVbnMrShyA3Aw7RAUkEqyKKhCUSog/Z
X-Google-Smtp-Source: AGHT+IHsJlClq5gm1xJnhjE3i6PmqXx7/BoTu7ITvgZDbc0/yB37WbKPsQyMszk+sBc66H6FkzV6mA==
X-Received: by 2002:a05:6a00:2e98:b0:76c:1c69:111c with SMTP id d2e1a72fcca58-76c1c691425mr2054194b3a.9.1754381830515;
        Tue, 05 Aug 2025 01:17:10 -0700 (PDT)
Received: from [10.4.54.91] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce93da5sm12202646b3a.50.2025.08.05.01.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 01:17:09 -0700 (PDT)
Message-ID: <b594a315-8458-439c-b535-fc7f052a3fae@bytedance.com>
Date: Tue, 5 Aug 2025 16:17:01 +0800
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
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <d73213ba-5ca0-451c-b82b-f590d10da6d7@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Baolin,

On 8/5/25 3:53 PM, Baolin Wang wrote:
> 
> 
> On 2025/8/5 14:42, Qi Zheng wrote:
>> Hi Barry,
>>
>> On 8/5/25 11:54 AM, Barry Song wrote:
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> The check_pmd_still_valid() call during collapse is currently only
>>> protected by the mmap_lock in write mode, which was sufficient when
>>> pt_reclaim always ran under mmap_lock in read mode. However, since
>>> madvise_dontneed can now execute under a per-VMA lock, this assumption
>>> is no longer valid. As a result, a race condition can occur between
>>> collapse and PT_RECLAIM, potentially leading to a kernel panic.
>>
>> There is indeed a race condition here. And after applying this patch, I
>> can no longer reproduce the problem locally (I was able to reproduce it
>> stably locally last night).
>>
>> But I still can't figure out how this race condtion causes the
>> following panic:
>>
>> exit_mmap
>> --> mmap_read_lock()
>>      unmap_vmas()
>>      --> pte_offset_map_lock
>>          --> rcu_read_lock()
>>              check if the pmd entry is a PTE page
>>              ptl = pte_lockptr(mm, &pmdval)  <-- ptl is NULL
>>              spin_lock(ptl)                  <-- PANIC!!
>>
>> If this PTE page is freed by pt_reclaim (via RCU), then the ptl can 
>> not be NULL.
>>
>> The collapse holds mmap write lock, so it is impossible to be concurrent
>> with exit_mmap().
>>
>> Confusing. :(
> 
> IIUC, the issue is not caused by the concurrency between exit_mmap and 
> collapse, but rather by the concurrency between pt_reclaim and collapse.
> 
> Before this patch, khugepaged might incorrectly restore a PTE pagetable 
> that had already been freed.
> 
> pt_reclaim has cleared the pmd entry and freed the PTE page table. 
> However, due to the race condition, check_pmd_still_valid() still passes 
> and continues to attempt the collapse:
> 
> _pmd = pmdp_collapse_flush(vma, address, pmd); ---> returns a none pmd 
> entry (the original pmd entry has been cleared)
> 
> pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl); ---> returns 
> pte == NULL
> 
> Then khugepaged will restore the old PTE pagetable with an invalid pmd 
> entry:
> 
> pmd_populate(mm, pmd, pmd_pgtable(_pmd));
> 
> So when the process exits and trys to free the mapping of the process, 
> traversing the invalid pmd table will lead to a crash.

CPU0                         CPU1
====                         ====

collapse
--> pmd_populate(mm, pmd, pmd_pgtable(_pmd));
     mmap_write_unlock
                              exit_mmap
                              --> hold mmap lock
                                  __pte_offset_map_lock
                                  --> pte = __pte_offset_map(pmd, addr, 
&pmdval);
                                      if (unlikely(!pte))
                                          return pte;   <-- will return

IIUC, in this case, if we get an invalid pmd entry, we will retrun
directly instead of causing a crash?

> 
> Barry, please correct me if I have misunderstood something.
> 



