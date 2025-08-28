Return-Path: <linux-kernel+bounces-789170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D12B391E5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82041C21265
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EA926A0A6;
	Thu, 28 Aug 2025 02:53:46 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7AA1A9FB8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756349626; cv=none; b=l7T2TUKTv7iRjR7jp5Q59EbVr1vqr6hUyyRe+xFv/KiWWBjyeU04z/S9WkbcZYpxRa9o2PepJuWrURmcCn10DSJbnAAQwomhdSF0QiIV/pav7qOp+YRqqbewea8CUEuPOOdfkTyYxBqtR6C7+D01L5qETwgB2hea1ctVBNZkizo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756349626; c=relaxed/simple;
	bh=XejjMWQvqMA6S6v/A5hcw+aTDg74LgrkSGYh851/Z50=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Dknfaazj0bf5XLgIN9tjF/cAhE7lQBfIl0L+HehUZ7OfnL+4kAULobogihzwD2gh2J3rxmCAcqChiMvrAWnPVvDKX3Ce9pVlT4kPrYPlfbv0GA5zt1cpRk2ahmwdIrU6RgvB5OmU2uddkDGAmQ0OP6UvMoxHwSqRuhrk5acum4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cC5T52Wwpz2CgHR;
	Thu, 28 Aug 2025 10:49:13 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 91C2114025A;
	Thu, 28 Aug 2025 10:53:39 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 Aug 2025 10:53:39 +0800
Received: from [10.173.125.236] (10.173.125.236) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 Aug 2025 10:53:38 +0800
Subject: Re: [PATCH v3] mm/memory-failure: fix
 VM_BUG_ON_PAGE(PagePoisoned(page)) when unpoison memory
To: David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>
CC: <nao.horiguchi@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20250826075710.278412-1-linmiaohe@huawei.com>
 <5eb5dbc1-274a-4932-8c77-8000509deadb@redhat.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0f0a190a-9a69-dbfe-6964-a0574cb5fc8d@huawei.com>
Date: Thu, 28 Aug 2025 10:53:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5eb5dbc1-274a-4932-8c77-8000509deadb@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2025/8/26 18:58, David Hildenbrand wrote:
> On 26.08.25 09:57, Miaohe Lin wrote:
>> When I did memory failure tests, below panic occurs:
>>
>> page dumped because: VM_BUG_ON_PAGE(PagePoisoned(page))
>> kernel BUG at include/linux/page-flags.h:616!
>> Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>> CPU: 3 PID: 720 Comm: bash Not tainted 6.10.0-rc1-00195-g148743902568 #40
>> RIP: 0010:unpoison_memory+0x2f3/0x590
>> RSP: 0018:ffffa57fc8787d60 EFLAGS: 00000246
>> RAX: 0000000000000037 RBX: 0000000000000009 RCX: ffff9be25fcdc9c8
>> RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff9be25fcdc9c0
>> RBP: 0000000000300000 R08: ffffffffb4956f88 R09: 0000000000009ffb
>> R10: 0000000000000284 R11: ffffffffb4926fa0 R12: ffffe6b00c000000
>> R13: ffff9bdb453dfd00 R14: 0000000000000000 R15: fffffffffffffffe
>> FS:  00007f08f04e4740(0000) GS:ffff9be25fcc0000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000564787a30410 CR3: 000000010d4e2000 CR4: 00000000000006f0
>> Call Trace:
>>   <TASK>
>>   unpoison_memory+0x2f3/0x590
>>   simple_attr_write_xsigned.constprop.0.isra.0+0xb3/0x110
>>   debugfs_attr_write+0x42/0x60
>>   full_proxy_write+0x5b/0x80
>>   vfs_write+0xd5/0x540
>>   ksys_write+0x64/0xe0
>>   do_syscall_64+0xb9/0x1d0
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7f08f0314887
>> RSP: 002b:00007ffece710078 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>> RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00007f08f0314887
>> RDX: 0000000000000009 RSI: 0000564787a30410 RDI: 0000000000000001
>> RBP: 0000564787a30410 R08: 000000000000fefe R09: 000000007fffffff
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000009
>> R13: 00007f08f041b780 R14: 00007f08f0417600 R15: 00007f08f0416a00
>>   </TASK>
>> Modules linked in: hwpoison_inject
>> ---[ end trace 0000000000000000 ]---
>> RIP: 0010:unpoison_memory+0x2f3/0x590
>> RSP: 0018:ffffa57fc8787d60 EFLAGS: 00000246
>> RAX: 0000000000000037 RBX: 0000000000000009 RCX: ffff9be25fcdc9c8
>> RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff9be25fcdc9c0
>> RBP: 0000000000300000 R08: ffffffffb4956f88 R09: 0000000000009ffb
>> R10: 0000000000000284 R11: ffffffffb4926fa0 R12: ffffe6b00c000000
>> R13: ffff9bdb453dfd00 R14: 0000000000000000 R15: fffffffffffffffe
>> FS:  00007f08f04e4740(0000) GS:ffff9be25fcc0000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000564787a30410 CR3: 000000010d4e2000 CR4: 00000000000006f0
>> Kernel panic - not syncing: Fatal exception
>> Kernel Offset: 0x31c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>> ---[ end Kernel panic - not syncing: Fatal exception ]---
>>
>> The root cause is that unpoison_memory() tries to check the PG_HWPoison
>> flags of an uninitialized page. So VM_BUG_ON_PAGE(PagePoisoned(page)) is
>> triggered. This can be reproduced by below steps:
>> 1.Offline memory block:
>>   echo offline > /sys/devices/system/memory/memory12/state
>> 2.Get offlined memory pfn:
>>   page-types -b n -rlN
>> 3.Write pfn to unpoison-pfn
>>   echo <pfn> > /sys/kernel/debug/hwpoison/unpoison-pfn
>>
>> This scene can be identified by pfn_to_online_page() returning NULL.
>> And ZONE_DEVICE pages are never expected, so we can simply fail if
>> pfn_to_online_page() == NULL to fix the bug.
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Similar to
> 
> commit 96c804a6ae8c59a9092b3d5dd581198472063184
> Author: David Hildenbrand <david@redhat.com>
> Date:   Fri Oct 18 20:19:23 2019 -0700
> 
>     mm/memory-failure.c: don't access uninitialized memmaps in memory_failure()
>         We should check for pfn_to_online_page() to not access uninitialized
>     memmaps.  Reshuffle the code so we don't have to duplicate the error
>     message.
>         Link: http://lkml.kernel.org/r/20191009142435.3975-3-david@redhat.com
>     Signed-off-by: David Hildenbrand <david@redhat.com>
>     Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory to zones until online")      [visible after d0dc12e86b319]
>     Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>     Cc: Michal Hocko <mhocko@kernel.org>
>     Cc: <stable@vger.kernel.org>    [4.13+]
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> We should likely just use the exact same Fixes:
> 
> Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory to zones until online")      [visible after d0dc12e86b319]
> 

Thanks for your information. Will add it in next version.

> 
> Not sure about CCing stable. This is a pure debugging feature (depends on DEBUG_KERNEL),
> and someone really has to trigger it manually to provoke this. So I would not CC stable.
> 
>> ---
>> v2:
>>    Use pfn_to_online_page per David. Thanks.
>> v3:
>>    Simply fail if pfn_to_online_page() == NULL per David. Thanks.
>> ---
>>   mm/memory-failure.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index c15ffee7d32b..212620308028 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2572,7 +2572,9 @@ int unpoison_memory(unsigned long pfn)
>>       if (!pfn_valid(pfn))
>>           return -ENXIO;
>>   -    p = pfn_to_page(pfn);
>> +    p = pfn_to_online_page(pfn);
>> +    if (!p)
>> +        return -EIO;
> 
> I think we can just drop the pfn_valid() check now. pfn_to_online_page() implies a pfn_valid() check.
> 

Will do.

Thanks.
.

