Return-Path: <linux-kernel+bounces-894565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6652EC4B4F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF62188F641
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33B634A79B;
	Tue, 11 Nov 2025 03:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kRjP4hwt"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344A4314A8F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762831560; cv=none; b=VdUk45REwdn2AfOOHbn2/sV5veIk2YDgQm3Ncr0Ya0rHSg2fj4lKbvp1JSesZY0XbqipfGinRQNRBy4AgK16IsELxRjJ5gyEMUY5UyNz8ToTON4TCO913j2hutTPe2Xnd20GRWfAevIlsahCYpJIUOg1mThaOLiLd7oCMA+euoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762831560; c=relaxed/simple;
	bh=+3A/dqDBUaiD/fqCHMYkpoRB9/fB6Lb8nuvP9o5hNkM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Fpc9847ppcf4PJT9KdGpf+jqCKrIyzhQzx+KIXl22bVEuVuVZdk+LTMoFt+2Jl09corvxTBSn9ZNAOfabaiBa1OWZVqH7HrJhwoqP7keFkSZvsiX01Ao7PpuYkDpOaqojz8Uocus+LnH+CaYEZOX4ITFUJ91UXbI8tmh3kUQkdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kRjP4hwt; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0432bee6-b384-4cd7-ac1c-e9123c7b393f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762831556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWmeOmbaA7+VgqiMTnj4K9aVuIljbTl3qUWGKZSf2ZI=;
	b=kRjP4hwtLD/JKJhFT4zQmm9kFq1RTjPBFxj/uY9nDzwWWJ+0CxeWDkGfDw0cgwdDzBgWh9
	1qhVlRRJTFNiNdEaMuKaXVneQlZa9ZpQI6kBrhlWqcqUYjjj73FvsAPztH8Gaa1CNjy7sf
	7fqgBNkxyZYUM4R44GqIieGGbWGVi0U=
Date: Tue, 11 Nov 2025 11:25:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] mm/hugetlb: fix possible deadlocks in hugetlb VMA
 unmap paths
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
To: mike.kravetz@oracle.com
Cc: Harry Yoo <harry.yoo@oracle.com>, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Hillf Danton <hdanton@sina.com>, muchun.song@linux.dev, osalvador@suse.de,
 david@kernel.org
References: <20251110230745.9105-1-hdanton@sina.com>
 <aef27438-7636-4c38-a5c7-beda95efa02b@linux.dev>
In-Reply-To: <aef27438-7636-4c38-a5c7-beda95efa02b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Cc: HugeTLB folks

On 2025/11/11 11:20, Lance Yang wrote:
> +Mike
> 
> On 2025/11/11 07:07, Hillf Danton wrote:
>> On Tue, 11 Nov 2025 00:39:29 +0800 Lance Yang wrote:
>>> On 2025/11/10 20:17, Harry Yoo wrote:
>>>> On Mon, Nov 10, 2025 at 07:15:53PM +0800, Lance Yang wrote:
>>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>>
>>>>> The hugetlb VMA unmap path contains several potential deadlocks, as
>>>>> reported by syzbot. These deadlocks occur in __hugetlb_zap_begin(),
>>>>> move_hugetlb_page_tables(), and the retry path of
>>>>> hugetlb_unmap_file_folio() (affecting remove_inode_hugepages() and
>>>>> unmap_vmas()), where vma_lock is acquired before i_mmap_lock. This 
>>>>> lock
>>>>> ordering conflicts with other paths like hugetlb_fault(), which 
>>>>> establish
>>>>> the correct dependency as i_mmap_lock -> vma_lock.
>>>>>
>>>>> Possible unsafe locking scenario:
>>>>>
>>>>> CPU0                                 CPU1
>>>>> ----                                 ----
>>>>> lock(&vma_lock->rw_sema);
>>>>>                                        lock(&i_mmap_lock);
>>>>>                                        lock(&vma_lock->rw_sema);
>>>>> lock(&i_mmap_lock);
>>>>>
>>>>> Resolve the circular dependencies reported by syzbot across 
>>>>> multiple call
>>>>> chains by reordering the locks in all conflicting paths to 
>>>>> consistently
>>>>> follow the established i_mmap_lock -> vma_lock order.
>>>>
>>>> But mm/rmap.c says:
>>>>> * hugetlbfs PageHuge() take locks in this order:
>>>>> *   hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
>>>>> *     vma_lock (hugetlb specific lock for pmd_sharing)
>>>>> *       mapping->i_mmap_rwsem (also used for hugetlb pmd sharing)
>>>>> *         folio_lock
>>>>> */
>>>
>>> Thanks! You are right, I was mistaken ...
>>>
>>>>
>>>> I think the commit message should explain why the locking order 
>>>> described
>>>> above is incorrect (or when it became incorrect) and fix the comment?
>>>
>>> I think the locking order documented in mm/rmap.c (vma_lock -> 
>>> i_mmap_lock)
>>> is indeed the correct one to follow.
> 
> Looking at the commit[1] that introduced the vma_lock, it seems possible 
> that
> the deadlock reported by syzbot[2] is a false positive ...
> 
>  From the commit message:
> 
> ```
> The vma_lock is used as follows:
> - During fault processing. The lock is acquired in read mode before
>    doing a page table lock and allocation (huge_pte_alloc).  The lock is
>    held until code is finished with the page table entry (ptep).
> - The lock must be held in write mode whenever huge_pmd_unshare is
>    called.
> 
> Lock ordering issues come into play when unmapping a page from all
> vmas mapping the page.  The i_mmap_rwsem must be held to search for the
> vmas, and the vma lock must be held before calling unmap which will
> call huge_pmd_unshare.  This is done today in:
> - try_to_migrate_one and try_to_unmap_ for page migration and memory
>    error handling.  In these routines we 'try' to obtain the vma lock and
>    fail to unmap if unsuccessful.  Calling routines already deal with the
>    failure of unmapping.
> - hugetlb_vmdelete_list for truncation and hole punch.  This routine
>    also tries to acquire the vma lock.  If it fails, it skips the
>    unmapping.  However, we can not have file truncation or hole punch
>    fail because of contention.  After hugetlb_vmdelete_list, truncation
>    and hole punch call remove_inode_hugepages.  remove_inode_hugepages
>    checks for mapped pages and call hugetlb_unmap_file_page to unmap them.
>    hugetlb_unmap_file_page is designed to drop locks and reacquire in the
>    correct order to guarantee unmap success.```
> 
> The locking logic is a bit tricky; some paths can't follow a strict lock 
> order
> and must use trylock or a drop/retry pattern to avoid deadlocking :)
> 
> Hoping Mike can take a look and confirm!
> 
> [1] https://lore.kernel.org/all/20220914221810.95771-9- 
> mike.kravetz@oracle.com/
> [2] https://lore.kernel.org/linux- 
> mm/69113a97.a70a0220.22f260.00ca.GAE@google.com/
> 
> Thanks,
> Lance
> 
>>>
>>> This fix has it backwards then. I'll rework it to fix the actual 
>>> violations.
>>>
>> Break a leg, better after taking a look at ffa1e7ada456 ("block: Make
>> request_queue lockdep splats show up earlier")
> 


