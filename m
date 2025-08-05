Return-Path: <linux-kernel+bounces-756092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C274AB1AFE1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA8A18A00CE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 07:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A6D21FF3F;
	Tue,  5 Aug 2025 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sQ8ZZx7V"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A05F2904
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754380443; cv=none; b=aslwGh69fQ02LQ7Q9QC0PUNt8rXxdOI8MqHOnfGaqGfOVy2+qUwBz0dd/knI1OzJJv9pQr6COI/7dNRJH/AzS+1mKDRY+/370xSS9GI6paDoOQH0soxBy/JyvOioK6OaXSc3ztEqm/0e3OS628KCN4RdIMAbI7qcJjlrp4IVABQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754380443; c=relaxed/simple;
	bh=tWGYh/6V8yFHh7sK2cuMQidlURY8Xa7NmtuDc043muo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iAYzryUFZrWgwG4AylI/LAR5Df/S41v4NUU9kyjD5pURnNArXwYNQeLjGgqbINB2vf27XmzeRzOKpaGzOp4RrxrGkr1l1xt5zEz8N6bPqxVcuWVSSrkhML4wOj0Uxefo4NHGuOqrGX4LsefsHhmWiunILtRC0EhASvpZl1Te51U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sQ8ZZx7V; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754380431; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/nQryawfyDuIJRKhkainkKo5d5VP9AzO/w40vwouXNI=;
	b=sQ8ZZx7VrjPHL48uTaJKhE93A2TxIblg/SigI96q2OeXmOLTTH/ukX/F82LeUEcZTXVG7AwRVME2BWzpir3CCHR5w4IKEuIGjO3n4l9ir0ipaKrUJyepCdd1oHcoe3kYXxcpnzsT6wFOXirzpmFINiYaFSJ6ysvN8wVNguwmWBs=
Received: from 30.74.144.114(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wl4MJeu_1754380429 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Aug 2025 15:53:49 +0800
Message-ID: <d73213ba-5ca0-451c-b82b-f590d10da6d7@linux.alibaba.com>
Date: Tue, 5 Aug 2025 15:53:48 +0800
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
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <35417160-86bf-4580-8ae9-5cadd4f6401d@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/8/5 14:42, Qi Zheng wrote:
> Hi Barry,
> 
> On 8/5/25 11:54 AM, Barry Song wrote:
>> From: Barry Song <v-songbaohua@oppo.com>
>>
>> The check_pmd_still_valid() call during collapse is currently only
>> protected by the mmap_lock in write mode, which was sufficient when
>> pt_reclaim always ran under mmap_lock in read mode. However, since
>> madvise_dontneed can now execute under a per-VMA lock, this assumption
>> is no longer valid. As a result, a race condition can occur between
>> collapse and PT_RECLAIM, potentially leading to a kernel panic.
> 
> There is indeed a race condition here. And after applying this patch, I
> can no longer reproduce the problem locally (I was able to reproduce it
> stably locally last night).
> 
> But I still can't figure out how this race condtion causes the
> following panic:
> 
> exit_mmap
> --> mmap_read_lock()
>      unmap_vmas()
>      --> pte_offset_map_lock
>          --> rcu_read_lock()
>              check if the pmd entry is a PTE page
>              ptl = pte_lockptr(mm, &pmdval)  <-- ptl is NULL
>              spin_lock(ptl)                  <-- PANIC!!
> 
> If this PTE page is freed by pt_reclaim (via RCU), then the ptl can not 
> be NULL.
> 
> The collapse holds mmap write lock, so it is impossible to be concurrent
> with exit_mmap().
> 
> Confusing. :(

IIUC, the issue is not caused by the concurrency between exit_mmap and 
collapse, but rather by the concurrency between pt_reclaim and collapse.

Before this patch, khugepaged might incorrectly restore a PTE pagetable 
that had already been freed.

pt_reclaim has cleared the pmd entry and freed the PTE page table. 
However, due to the race condition, check_pmd_still_valid() still passes 
and continues to attempt the collapse:

_pmd = pmdp_collapse_flush(vma, address, pmd); ---> returns a none pmd 
entry (the original pmd entry has been cleared)

pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl); ---> returns 
pte == NULL

Then khugepaged will restore the old PTE pagetable with an invalid pmd 
entry:

pmd_populate(mm, pmd, pmd_pgtable(_pmd));

So when the process exits and trys to free the mapping of the process, 
traversing the invalid pmd table will lead to a crash.

Barry, please correct me if I have misunderstood something.

>>   [   38.151897] Oops: general protection fault, probably for non- 
>> canonical address 0xdffffc0000000003: 0000 [#1] SMP KASI
>>   [   38.153519] KASAN: null-ptr-deref in range 
>> [0x0000000000000018-0x000000000000001f]
>>   [   38.154605] CPU: 0 UID: 0 PID: 721 Comm: repro Not tainted 
>> 6.16.0-next-20250801-next-2025080 #1 PREEMPT(voluntary)
>>   [   38.155929] Hardware name: QEMU Standard PC (i440FX + PIIX, 
>> 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org4
>>   [   38.157418] RIP: 0010:kasan_byte_accessible+0x15/0x30
>>   [   38.158125] Code: 03 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 
>> 90 90 90 90 90 66 0f 1f 00 48 b8 00 00 00 00 00 fc0
>>   [   38.160461] RSP: 0018:ffff88800feef678 EFLAGS: 00010286
>>   [   38.161220] RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 
>> 1ffffffff0dde60c
>>   [   38.162232] RDX: 0000000000000000 RSI: ffffffff85da1e18 RDI: 
>> dffffc0000000003
>>   [   38.163176] RBP: ffff88800feef698 R08: 0000000000000001 R09: 
>> 0000000000000000
>>   [   38.164195] R10: 0000000000000000 R11: ffff888016a8ba58 R12: 
>> 0000000000000018
>>   [   38.165189] R13: 0000000000000018 R14: ffffffff85da1e18 R15: 
>> 0000000000000000
>>   [   38.166100] FS:  0000000000000000(0000) GS:ffff8880e3b40000(0000) 
>> knlGS:0000000000000000
>>   [   38.167137] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   [   38.167891] CR2: 00007f97fadfe504 CR3: 0000000007088005 CR4: 
>> 0000000000770ef0
>>   [   38.168812] PKRU: 55555554
>>   [   38.169275] Call Trace:
>>   [   38.169647]  <TASK>
>>   [   38.169975]  ? __kasan_check_byte+0x19/0x50
>>   [   38.170581]  lock_acquire+0xea/0x310
>>   [   38.171083]  ? rcu_is_watching+0x19/0xc0
>>   [   38.171615]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
>>   [   38.172343]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
>>   [   38.173130]  _raw_spin_lock+0x38/0x50
>>   [   38.173707]  ? __pte_offset_map_lock+0x1a2/0x3c0
>>   [   38.174390]  __pte_offset_map_lock+0x1a2/0x3c0
>>   [   38.174987]  ? __pfx___pte_offset_map_lock+0x10/0x10
>>   [   38.175724]  ? __pfx_pud_val+0x10/0x10
>>   [   38.176308]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
>>   [   38.177183]  unmap_page_range+0xb60/0x43e0
>>   [   38.177824]  ? __pfx_unmap_page_range+0x10/0x10
>>   [   38.178485]  ? mas_next_slot+0x133a/0x1a50
>>   [   38.179079]  unmap_single_vma.constprop.0+0x15b/0x250
>>   [   38.179830]  unmap_vmas+0x1fa/0x460
>>   [   38.180373]  ? __pfx_unmap_vmas+0x10/0x10
>>   [   38.180994]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
>>   [   38.181877]  exit_mmap+0x1a2/0xb40
>>   [   38.182396]  ? lock_release+0x14f/0x2c0
>>   [   38.182929]  ? __pfx_exit_mmap+0x10/0x10
>>   [   38.183474]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
>>   [   38.184188]  ? mutex_unlock+0x16/0x20
>>   [   38.184704]  mmput+0x132/0x370
>>   [   38.185208]  do_exit+0x7e7/0x28c0
>>   [   38.185682]  ? __this_cpu_preempt_check+0x21/0x30
>>   [   38.186328]  ? do_group_exit+0x1d8/0x2c0
>>   [   38.186873]  ? __pfx_do_exit+0x10/0x10
>>   [   38.187401]  ? __this_cpu_preempt_check+0x21/0x30
>>   [   38.188036]  ? _raw_spin_unlock_irq+0x2c/0x60
>>   [   38.188634]  ? lockdep_hardirqs_on+0x89/0x110
>>   [   38.189313]  do_group_exit+0xe4/0x2c0
>>   [   38.189831]  __x64_sys_exit_group+0x4d/0x60
>>   [   38.190413]  x64_sys_call+0x2174/0x2180
>>   [   38.190935]  do_syscall_64+0x6d/0x2e0
>>   [   38.191449]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> This patch moves the vma_start_write() call to precede
>> check_pmd_still_valid(), ensuring that the check is also properly
>> protected by the per-VMA lock.
>>
>> Fixes: a6fde7add78d ("mm: use per_vma lock for MADV_DONTNEED")
>> Tested-by: "Lai, Yi" <yi1.lai@linux.intel.com>
>> Reported-by: "Lai, Yi" <yi1.lai@linux.intel.com>
>> Closes: https://lore.kernel.org/all/aJAFrYfyzGpbm+0m@ly-workstation/
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: Qi Zheng <zhengqi.arch@bytedance.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Jann Horn <jannh@google.com>
>> Cc: Suren Baghdasaryan <surenb@google.com>
>> Cc: Lokesh Gidra <lokeshgidra@google.com>
>> Cc: Tangquan Zheng <zhengtangquan@oppo.com>
>> Cc: Lance Yang <ioworker0@gmail.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
>> Cc: Nico Pache <npache@redhat.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Dev Jain <dev.jain@arm.com>
>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> ---
>>   mm/khugepaged.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 374a6a5193a7..6b40bdfd224c 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1172,11 +1172,11 @@ static int collapse_huge_page(struct mm_struct 
>> *mm, unsigned long address,
>>       if (result != SCAN_SUCCEED)
>>           goto out_up_write;
>>       /* check if the pmd is still valid */
>> +    vma_start_write(vma);
>>       result = check_pmd_still_valid(mm, address, pmd);
>>       if (result != SCAN_SUCCEED)
>>           goto out_up_write;
>> -    vma_start_write(vma);
>>       anon_vma_lock_write(vma->anon_vma);
>>       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,


