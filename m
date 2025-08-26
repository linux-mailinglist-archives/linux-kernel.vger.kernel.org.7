Return-Path: <linux-kernel+bounces-786495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C27B35A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97FD31B64D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1072F6164;
	Tue, 26 Aug 2025 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNNDr2/R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DBC2405E1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756205918; cv=none; b=Q2bpwcrSNewuPgfqOpZ1MrK6QBth6lTeQSPVhtIV++d4Q53Pi1Ce97EnPTn0stJkuwT4VVGQxBIZPcZtRUINcOLDZD95ZkIr+lgdJBkJN46kS2PQL93G8eBPYNqGrntNY0Iqir7+cW0kqogjxWufpKWs0Jn8YCiyJL5lCrYeLF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756205918; c=relaxed/simple;
	bh=fDzV+/QDtTW08p5gsnly8MfwT1HF4IEA//YHdL7iFJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSXnLmu4CUpln9jUjZup9og5NrQmq0NR8sfCcGVu95nK1whxfckUY7LSPG0rdDZUNukmbaoS5xlWlhRFXXyTSSk7v+OcScwAC6dhUj5uaXWa2OlZ30dqhTiCiNhcBjYg34tg9rd+8jjzdjqqGuPZhmYyazSHCH7I3eKdYH1OOsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iNNDr2/R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756205915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+EgA37MBCBDy1a1mdvBoYVq3fWogkvWCdD/YDwlv/rs=;
	b=iNNDr2/RvlNA88UOvEx4kOAOSKuhw3xSaJPboi5UN2Bjw2YMBLN7h6rIXAJklt/OEz0HdD
	Oid6LgTHPEBgsBW692gsqLo/F6CW8b0rI3ekJ778qPnSyoFuh0FAxoqsYI2blCVZl7cNHy
	3iurwKaakQsMbeXdTrV9TfBjaHpszkE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-jIpToh2tMhS9G0g2dQCLyg-1; Tue, 26 Aug 2025 06:58:32 -0400
X-MC-Unique: jIpToh2tMhS9G0g2dQCLyg-1
X-Mimecast-MFC-AGG-ID: jIpToh2tMhS9G0g2dQCLyg_1756205911
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-afeb19cf14cso30235666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 03:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756205911; x=1756810711;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+EgA37MBCBDy1a1mdvBoYVq3fWogkvWCdD/YDwlv/rs=;
        b=krbcU8LvPgDFaueI7R7qaOgkEoX0yrHUXb5nNkvmuxEJX06sh7x1m0ExHimA2SvEDz
         KQtl1+892RoQWsgqrgJEvVv57EZ8g5NBcBUQDq2ixiED///QrG3YgF6KJWUYFgCw92Hp
         J81mJpOaCwAzRHHvHdXSi+RPsWL1DgtEFw+zVL7nz1EmKNs4DZGiW9M5smFbvadNBDJ2
         Be6JRGHHkVxJ8tAIjbzEdqIoIxtRwfEGjAD7LVfZ/0d22quJUkpeeE5fudcy4akxTHb8
         N15Oq8wwn9BiYcoLuCIQkhQ33Zh4eKvYQvLlGhnXpL/0lor/CD0sVSQZQELi2TT+6N2A
         38Aw==
X-Forwarded-Encrypted: i=1; AJvYcCW7EY0ENeBxfwA3ymDYBASx7uMHV2hZMNnR8bgrLaEXcLD6ZuII+sV7Fy50IKH9DcA5Zk8gMH1fPyfsOZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjaOv0IdUozD5eoPknA2LwrPL3jBWedweWJOB1Um4lHzQakCcM
	p9I5LylGhQ1n1naeECbODd3ziH7DJVxbwJ8/WbuA0kuMk3VDMQYYNd90+XJMpzCaaOiwSEaFQ8L
	Bww8PcY1G8bLq4FvyLW7WZJfQ1coXu3efjdcZjE6gjgaql6LX6CAKUxsy98R8WabsXLONnTX9bb
	1f
X-Gm-Gg: ASbGnctOtH73BQNfqV0Dh0xgnda4sJnqyUI8MfVLB1Bu01SH2lfFgP8ktCqtDEPdUFq
	XXoNdu0VFTVURIjuQW0VnTN8WzzyTBu+EXGciUdwC/M48xg1fF1ar5aDsbpobNInLeSjATdrOla
	PL3xhyPG2AsYE6RIDbhbA8I5t65tjltLLia8Eza+MFXSFTr13wJ9rlvnBqrG1DDJbgcF106fD2t
	JaarS6cZyzPiyIERV82WOvs1WVrrttdp9Ug3CxISV1ETsI7hlVZZHvSGd53GTXwzqST6sj1wtgM
	+X2210faEwMyxXFIP21xhDtjHzwEnJI53U8XkAuMf45sDdfYbcel+4liz63vIilEJeoJJ7D1qA=
	=
X-Received: by 2002:a17:907:7e90:b0:afe:8a40:49bb with SMTP id a640c23a62f3a-afe8a404c32mr464659366b.22.1756205910813;
        Tue, 26 Aug 2025 03:58:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTLyoMdzRtcueTqbkFT6EPOfAzQtyAZfbsUKrCCUFnpYC2rska742i1k7jJ3Lbarg7QFoSFw==
X-Received: by 2002:a17:907:7e90:b0:afe:8a40:49bb with SMTP id a640c23a62f3a-afe8a404c32mr464657866b.22.1756205910364;
        Tue, 26 Aug 2025 03:58:30 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe6a3d7cd5sm566241666b.6.2025.08.26.03.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 03:58:29 -0700 (PDT)
Message-ID: <5eb5dbc1-274a-4932-8c77-8000509deadb@redhat.com>
Date: Tue, 26 Aug 2025 12:58:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/memory-failure: fix
 VM_BUG_ON_PAGE(PagePoisoned(page)) when unpoison memory
To: Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc: nao.horiguchi@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250826075710.278412-1-linmiaohe@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250826075710.278412-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.08.25 09:57, Miaohe Lin wrote:
> When I did memory failure tests, below panic occurs:
> 
> page dumped because: VM_BUG_ON_PAGE(PagePoisoned(page))
> kernel BUG at include/linux/page-flags.h:616!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 3 PID: 720 Comm: bash Not tainted 6.10.0-rc1-00195-g148743902568 #40
> RIP: 0010:unpoison_memory+0x2f3/0x590
> RSP: 0018:ffffa57fc8787d60 EFLAGS: 00000246
> RAX: 0000000000000037 RBX: 0000000000000009 RCX: ffff9be25fcdc9c8
> RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff9be25fcdc9c0
> RBP: 0000000000300000 R08: ffffffffb4956f88 R09: 0000000000009ffb
> R10: 0000000000000284 R11: ffffffffb4926fa0 R12: ffffe6b00c000000
> R13: ffff9bdb453dfd00 R14: 0000000000000000 R15: fffffffffffffffe
> FS:  00007f08f04e4740(0000) GS:ffff9be25fcc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000564787a30410 CR3: 000000010d4e2000 CR4: 00000000000006f0
> Call Trace:
>   <TASK>
>   unpoison_memory+0x2f3/0x590
>   simple_attr_write_xsigned.constprop.0.isra.0+0xb3/0x110
>   debugfs_attr_write+0x42/0x60
>   full_proxy_write+0x5b/0x80
>   vfs_write+0xd5/0x540
>   ksys_write+0x64/0xe0
>   do_syscall_64+0xb9/0x1d0
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f08f0314887
> RSP: 002b:00007ffece710078 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00007f08f0314887
> RDX: 0000000000000009 RSI: 0000564787a30410 RDI: 0000000000000001
> RBP: 0000564787a30410 R08: 000000000000fefe R09: 000000007fffffff
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000009
> R13: 00007f08f041b780 R14: 00007f08f0417600 R15: 00007f08f0416a00
>   </TASK>
> Modules linked in: hwpoison_inject
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:unpoison_memory+0x2f3/0x590
> RSP: 0018:ffffa57fc8787d60 EFLAGS: 00000246
> RAX: 0000000000000037 RBX: 0000000000000009 RCX: ffff9be25fcdc9c8
> RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff9be25fcdc9c0
> RBP: 0000000000300000 R08: ffffffffb4956f88 R09: 0000000000009ffb
> R10: 0000000000000284 R11: ffffffffb4926fa0 R12: ffffe6b00c000000
> R13: ffff9bdb453dfd00 R14: 0000000000000000 R15: fffffffffffffffe
> FS:  00007f08f04e4740(0000) GS:ffff9be25fcc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000564787a30410 CR3: 000000010d4e2000 CR4: 00000000000006f0
> Kernel panic - not syncing: Fatal exception
> Kernel Offset: 0x31c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> The root cause is that unpoison_memory() tries to check the PG_HWPoison
> flags of an uninitialized page. So VM_BUG_ON_PAGE(PagePoisoned(page)) is
> triggered. This can be reproduced by below steps:
> 1.Offline memory block:
>   echo offline > /sys/devices/system/memory/memory12/state
> 2.Get offlined memory pfn:
>   page-types -b n -rlN
> 3.Write pfn to unpoison-pfn
>   echo <pfn> > /sys/kernel/debug/hwpoison/unpoison-pfn
> 
> This scene can be identified by pfn_to_online_page() returning NULL.
> And ZONE_DEVICE pages are never expected, so we can simply fail if
> pfn_to_online_page() == NULL to fix the bug.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Similar to

commit 96c804a6ae8c59a9092b3d5dd581198472063184
Author: David Hildenbrand <david@redhat.com>
Date:   Fri Oct 18 20:19:23 2019 -0700

     mm/memory-failure.c: don't access uninitialized memmaps in memory_failure()
     
     We should check for pfn_to_online_page() to not access uninitialized
     memmaps.  Reshuffle the code so we don't have to duplicate the error
     message.
     
     Link: http://lkml.kernel.org/r/20191009142435.3975-3-david@redhat.com
     Signed-off-by: David Hildenbrand <david@redhat.com>
     Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory to zones until online")      [visible after d0dc12e86b319]
     Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
     Cc: Michal Hocko <mhocko@kernel.org>
     Cc: <stable@vger.kernel.org>    [4.13+]
     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

We should likely just use the exact same Fixes:

Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory to zones until online")      [visible after d0dc12e86b319]


Not sure about CCing stable. This is a pure debugging feature (depends on DEBUG_KERNEL),
and someone really has to trigger it manually to provoke this. So I would not CC stable.

> ---
> v2:
>    Use pfn_to_online_page per David. Thanks.
> v3:
>    Simply fail if pfn_to_online_page() == NULL per David. Thanks.
> ---
>   mm/memory-failure.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index c15ffee7d32b..212620308028 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2572,7 +2572,9 @@ int unpoison_memory(unsigned long pfn)
>   	if (!pfn_valid(pfn))
>   		return -ENXIO;
>   
> -	p = pfn_to_page(pfn);
> +	p = pfn_to_online_page(pfn);
> +	if (!p)
> +		return -EIO;

I think we can just drop the pfn_valid() check now. pfn_to_online_page() implies a pfn_valid() check.

-- 
Cheers

David / dhildenb


