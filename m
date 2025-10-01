Return-Path: <linux-kernel+bounces-838398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 505A5BAF165
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 06:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE48D16796E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 04:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEF42D73B2;
	Wed,  1 Oct 2025 04:23:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC2D1519AC
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 04:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759292617; cv=none; b=sCzhyeXTXL158EkL1SiBeGwi9IWUaOCeL60hhszXjPYp191efq9Nq6HD4Nhl9zq8v4+QoYIr08BQ9AQ8X6AgsY1sqpsD0G6d8SD0VWyNCcNtBm5MPlZv1FQlQhRbBX50VrQ7aV54N3+TGk7wfuLGJrXo9MOfeof5POsI7p1wicI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759292617; c=relaxed/simple;
	bh=v+lbESnAe2ivpXOa54AKZRDPwIkwui+2ZYmZ+zkEMtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHZ4qgQbomsjwoIzKUNqGK3QkSwobtUWuX093FicqwvWcVGqGIcQfdvKY+CBQ520lMw0UwldcTu/mZwPn7Mt4+U0xhZxCgsn9aLZeB6kRoW6eCEVrNy8OJ5i0sEsQwLRkhoJbVXq/jyr+C9hGnNiZRN2bfkWcyobJ1CE8F6yF9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6D8F16F2;
	Tue, 30 Sep 2025 21:23:25 -0700 (PDT)
Received: from [10.164.18.53] (MacBook-Pro.blr.arm.com [10.164.18.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B29623F66E;
	Tue, 30 Sep 2025 21:23:29 -0700 (PDT)
Message-ID: <746c4dd3-2285-4353-9e15-a0a2fbd4e6b5@arm.com>
Date: Wed, 1 Oct 2025 09:53:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] mm: hugetlb: avoid soft lockup when mprotect to large
 memory area
To: Yang Shi <yang@os.amperecomputing.com>, muchun.song@linux.dev,
 osalvador@suse.de, david@redhat.com, akpm@linux-foundation.org,
 catalin.marinas@arm.com, will@kernel.org, anshuman.khandual@arm.com,
 carl@os.amperecomputing.com, cl@gentwo.org
Cc: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250929202402.1663290-1-yang@os.amperecomputing.com>
 <cc40d827-3b98-4e15-ad45-5c2033e4ce20@arm.com>
 <6cde8290-3aa2-411c-bf29-eb91a99e33a5@os.amperecomputing.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <6cde8290-3aa2-411c-bf29-eb91a99e33a5@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 30/09/25 11:38 pm, Yang Shi wrote:
>
>
> On 9/29/25 10:26 PM, Dev Jain wrote:
>>
>> On 30/09/25 1:54 am, Yang Shi wrote:
>>> When calling mprotect() to a large hugetlb memory area in our 
>>> customer's
>>> workload (~300GB hugetlb memory), soft lockup was observed:
>>>
>>> watchdog: BUG: soft lockup - CPU#98 stuck for 23s! [t2_new_sysv:126916]
>>>
>>> CPU: 98 PID: 126916 Comm: t2_new_sysv Kdump: loaded Not tainted 
>>> 6.17-rc7
>>> Hardware name: GIGACOMPUTING R2A3-T40-AAV1/Jefferson CIO, BIOS 
>>> 5.4.4.1 07/15/2025
>>> pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> pc : mte_clear_page_tags+0x14/0x24
>>> lr : mte_sync_tags+0x1c0/0x240
>>> sp : ffff80003150bb80
>>> x29: ffff80003150bb80 x28: ffff00739e9705a8 x27: 0000ffd2d6a00000
>>> x26: 0000ff8e4bc00000 x25: 00e80046cde00f45 x24: 0000000000022458
>>> x23: 0000000000000000 x22: 0000000000000004 x21: 000000011b380000
>>> x20: ffff000000000000 x19: 000000011b379f40 x18: 0000000000000000
>>> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>>> x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>>> x11: 0000000000000000 x10: 0000000000000000 x9 : ffffc875e0aa5e2c
>>> x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
>>> x5 : fffffc01ce7a5c00 x4 : 00000000046cde00 x3 : fffffc0000000000
>>> x2 : 0000000000000004 x1 : 0000000000000040 x0 : ffff0046cde7c000
>>>
>>> Call trace:
>>>    mte_clear_page_tags+0x14/0x24
>>>    set_huge_pte_at+0x25c/0x280
>>>    hugetlb_change_protection+0x220/0x430
>>>    change_protection+0x5c/0x8c
>>>    mprotect_fixup+0x10c/0x294
>>>    do_mprotect_pkey.constprop.0+0x2e0/0x3d4
>>>    __arm64_sys_mprotect+0x24/0x44
>>>    invoke_syscall+0x50/0x160
>>>    el0_svc_common+0x48/0x144
>>>    do_el0_svc+0x30/0xe0
>>>    el0_svc+0x30/0xf0
>>>    el0t_64_sync_handler+0xc4/0x148
>>>    el0t_64_sync+0x1a4/0x1a8
>>>
>>> Soft lockup is not triggered with THP or base page because there is
>>> cond_resched() called for each PMD size.
>>>
>>> Although the soft lockup was triggered by MTE, it should be not MTE
>>> specific. The other processing which takes long time in the loop may
>>> trigger soft lockup too.
>>>
>>> So add cond_resched() for hugetlb to avoid soft lockup.
>>>
>>> Fixes: 8f860591ffb2 ("[PATCH] Enable mprotect on huge pages")
>>> Tested-by: Carl Worth <carl@os.amperecomputing.com>
>>> Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>
>>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>>> Acked-by: David Hildenbrand <david@redhat.com>
>>> Acked-by: Oscar Salvador <osalvador@suse.de>
>>> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>> ---
>>> v2: - Made the subject and commit message less MTE specific and fixed
>>>        the fixes tag.
>>>      - Collected all R-bs and A-bs.
>>>
>>>   mm/hugetlb.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index cb5c4e79e0b8..fe6606d91b31 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -7242,6 +7242,8 @@ long hugetlb_change_protection(struct 
>>> vm_area_struct *vma,
>>>                           psize);
>>>           }
>>>           spin_unlock(ptl);
>>> +
>>> +        cond_resched();
>>>       }
>>>       /*
>>>        * Must flush TLB before releasing i_mmap_rwsem: x86's 
>>> huge_pmd_unshare
>>
>> Reviewed-by: Dev Jain <dev.jain@arm.com>
>
> Thank you.
>
>>
>> Does it make sense to also do cond_resched() in the 
>> huge_pmd_unshare() branch?
>> That also amounts to clearing a page. And I can see for example, 
>> zap_huge_pmd()
>> and change_huge_pmd() consume a cond_resched().
>
> Thanks for raising this. I did think about it. But I didn't convince 
> myself because shared pmd should be not that common IMHO (If I'm 
> wrong, please feel free to correct me). At least PMD can't be shared 
> if the memory is tagged IIRC. So I'd like to keep the patch minimal 
> for now and defer adding cond_resched() until it is hit by some real 
> life workload.

If we have large swathes of hugetlb memory like in your workload, and it 
is MAP_SHARED, then there should be high chances of sharing the PMD. 
Although, I incorrectly

observed that we are clearing a page there - we are only clearing the 
pud entry which is 8 bytes. So yes a soft lockup should be highly 
unlikely. But since cond_resched()

is cheap (I assume this is the case since it is liberally sprinkled all 
over the codebase) I think we should be consistent. Probably not an 
immediate concern and not a matter

of this patch.


>
> Yang
>
>

