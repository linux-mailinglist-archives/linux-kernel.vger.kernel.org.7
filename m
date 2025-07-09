Return-Path: <linux-kernel+bounces-723640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671E5AFE96C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B551726C1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F822D9ED8;
	Wed,  9 Jul 2025 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V00fCMQO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB841A285
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752065508; cv=none; b=bRUQ14SsM7fez4M/oKfp3QX0L2lqVb1ZHlf089jf/yH3ZZ9M4Gk4i0welH/hu2y/W1NJ6f0E4o1O3TVBFglaHhq/0ep4TSYfqUGHpXqkDSABGBFSyPOOwenKY0Rc5b3HYzoWg21hDXMCyjKrgh//6YipK+j/Z1ibiPQiJ9rG+mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752065508; c=relaxed/simple;
	bh=VuRgj/sdLtwK0RlLYkInBW5ApilIJUoOBpoC2BmQ8ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OmyoDzhe+w3bM/ftHyUybQzzyvAVgaZQpC5UU98dm8T21AIUCDx4MdUXtdbgePQLKfGVay/XNCC/Bz8zApxle/uwUBlzPVblB+wQuE4BH9Nk1ohYGNDXUT0aW67C2pUQ/hX3HfNLslet0cHjsKugsc0vrNDmBqLxtZSLO+rYJu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V00fCMQO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752065501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dlIRSqW1gbQFHbxE6/CtUYp/pu4eO17k3y+jGCC2p/c=;
	b=V00fCMQO8X7hTz2UIKugAYvL1UcKP2hEijMAeuWVpXqd/l50COQPqfM1q9kqNEs1egFRXU
	yxe0VyzqFV+Jf8iugaFrwvdEgmq32lArVQmmzO1rVnpIoCMqhJhv7TIlp4zWz7MhylD1XM
	GptN544vF0+Hqq/ZrPilbJK0CByyJ7k=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-ymDrYfbjPCuDVX47Xj4xWQ-1; Wed, 09 Jul 2025 08:51:40 -0400
X-MC-Unique: ymDrYfbjPCuDVX47Xj4xWQ-1
X-Mimecast-MFC-AGG-ID: ymDrYfbjPCuDVX47Xj4xWQ_1752065499
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b31df10dfadso3512369a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 05:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752065498; x=1752670298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dlIRSqW1gbQFHbxE6/CtUYp/pu4eO17k3y+jGCC2p/c=;
        b=CMCVq/U1A/ANl2sY4nnHeU0P8OkuA3XLePzt9OUw3ngWeTTLGgvHJPprNdtclFsH3S
         Jr9MLBwX9DU+vF+Sxtfxaq5Tr2mOmbrMPfBWuBQaq/0tJlCKr4hD08c6ek0Mh15giaC3
         x8qLUifky+UTT3QAvohqJgwMXgdIpeRDICW4BsXf97plWZgdSC5ltFE4yR/k64m7f9uj
         Whvj7xgGps6msEN2+yjtQ0SduLaz74wO5YtoGDbtCTyPCCkSF2ImvWebyvbgPLsjiBs5
         g2u3iL0zfHOSBxm46mdWvdqmdrE2UuBIyQuV/v22cZDHzKeIk9ZJMNbfcgeQhFe08l8d
         ns1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoa3Aa8DFvmVJHzL+8hpneqCSK+nD9/edYHV4NC+Wz0bqrJQQAS9552mqeuxxhd0hQ7h0By+3ycm5iLak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMUb/a0eI/t75IT4HfRElTcTFiGK1S6FZVxiX3PEVn1K2gyQgQ
	EBCP+WwkEiBBf1rBsEl5SrDofyaRk/1HK0QzkxJtZe+oR2EZUfo8Mv/LM0VT9M1xEPkyiY/LthU
	P2046cADaXCZeME7Ej/rjkxOpsDplg+Uim6D9gyB/q0mdGQ5rCua3iYOorFi9V8Tw3Q==
X-Gm-Gg: ASbGncsfAmtKgy/AfW0W2AGFLXuCEiKNVe1jgbW99bpzzFaaAEdXl0zxWoGAYFBgFR7
	eARU5BJtxil9jpRnFEk/41igptOjr24A5wuSC2qpG2UP5Uh68iN4fHu7lQhLqT8f9O8pDNRb0Iz
	RI/t7EVFZGJwTbe1pNjtj6MhaA1kBsahYq6Oou/A+X+YJy/Z7wAw0C7eBKdZJxEDhPCvElXroVy
	GtsXulyzBnJojqRkeJmk/vP34z3MaGnVneGfphfeXXx88MOTKXmGoqngI/+UqOANMegL5eKGD8c
	i5919dyX3Z7WLfS4SBZxEj6lRs2ZbZRjIIPOk1tp6RBU7SpeubS0fpxxYH6fmilQgEgDVUsq/PK
	DeFEqkJIAZQ==
X-Received: by 2002:a17:90b:3b4d:b0:313:d346:f347 with SMTP id 98e67ed59e1d1-31c2fdf4de1mr3482492a91.35.1752065497915;
        Wed, 09 Jul 2025 05:51:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZZXGDBs7AvKfmI0T5Et5/9QJjwAUbGbWUiPDxFjggJp4ddR4ZohyvFBguxeUEeU7dhHnDJg==
X-Received: by 2002:a17:90b:3b4d:b0:313:d346:f347 with SMTP id 98e67ed59e1d1-31c2fdf4de1mr3482428a91.35.1752065497066;
        Wed, 09 Jul 2025 05:51:37 -0700 (PDT)
Received: from [192.168.2.110] (bras-base-aylmpq0104w-grc-59-70-29-229-84.dsl.bell.ca. [70.29.229.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3008f259sm2054568a91.29.2025.07.09.05.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 05:51:36 -0700 (PDT)
Message-ID: <97d9d605-8216-4e31-b31b-113764781b13@redhat.com>
Date: Wed, 9 Jul 2025 08:51:34 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: KASAN: stack-out-of-bounds in snapshot_page during gup_test
 test case
To: Harry Yoo <harry.yoo@oracle.com>
Cc: david@redhat.com, willy@infradead.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, shivankg@amd.com,
 sj@kernel.org
References: <cover.1751914235.git.luizcap@redhat.com>
 <aG4k3qwb8wbmfq5V@hyeyoo>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <aG4k3qwb8wbmfq5V@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-07-09 04:14, Harry Yoo wrote:
> On Mon, Jul 07, 2025 at 02:50:42PM -0400, Luiz Capitulino wrote:
>> Hi,
>>
>> The series introduction will follow the changelog. This is against v6.16-rc5.
>>
>> Changelog
>> =========
>>
>> v1 -> v2
>>    - Include is_huge_zero_pfn() patch and use it (David)
>>    - Move free page detection to snapshot_page() (David)
>>    - Changelog improvements (Shivank)
>>    - Added Acked-bys
>>
>> RFC -> v1
>>    - Include <linux/page_idle.h> to avoid build error on sh arch
>>
>> Introduction
>> ============
>>
>> This series introduces snapshot_page(), a helper function that can be used
>> to create a snapshot of a struct page and its associated struct folio.
>>
>> This function is intended to help callers with a consistent view of a
>> a folio while reducing the chance of encountering partially updated or
>> inconsistent state, such as during folio splitting which could lead to
>> crashes and BUG_ON()s being triggered.
> 
> Hi, my mm-new test environment started hitting a kernel crash with
> snapshot_page() involved. As it's pretty new function, reporting
> the bug directly here.

Thanks for the detailed report Harry, I'll look into this shortly.

> 
> I have three independent reports, and all of them fails at:
> 	`./gup_test -ct -F 0x1 0 19 0x1000`
> while dumping the page in tools/testing/selftests/mm/gup_test.c
> test case.
> 
> Attaching the configs as attachment.
> 
> If you need further help to reproduce this, please let me know.
> 
> # Report 1
> 
> # -----------------------------------------
> # running ./gup_test -ct -F 0x1 0 19 0x1000
> # -----------------------------------------
> # TAP version 13
> # 1..1
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in snapshot_page+0x282/0x5d0
> Read of size 256 at addr ffff88810c52fc50 by task gup_test/2236
> 
> CPU: 3 UID: 0 PID: 2236 Comm: gup_test Not tainted 6.16.0-rc5 #22 PREEMPT(voluntary)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x66/0xa0
>   print_report+0xd0/0x640
>   ? snapshot_page+0x282/0x5d0
>   ? srso_return_thunk+0x5/0x5f
>   ? __virt_addr_valid+0x208/0x3f0
>   ? snapshot_page+0x282/0x5d0
>   kasan_report+0xe4/0x120
>   ? snapshot_page+0x282/0x5d0
>   kasan_check_range+0x105/0x1b0
>   __asan_memcpy+0x23/0x60
>   snapshot_page+0x282/0x5d0
>   ? desc_read_finalized_seq+0x75/0x130
>   ? __pfx_snapshot_page+0x10/0x10
>   ? srso_return_thunk+0x5/0x5f
>   ? srso_return_thunk+0x5/0x5f
>   ? _raw_spin_unlock_irqrestore+0x22/0x50
>   ? prb_read_valid+0x64/0x90
>   __dump_page+0x9b/0x590
>   ? __pfx___dump_page+0x10/0x10
>   ? __pfx__printk+0x10/0x10
>   ? srso_return_thunk+0x5/0x5f
>   ? mark_held_locks+0x40/0x70
>   ? dump_page+0x34/0x80
>   dump_page+0x34/0x80
>   gup_test_ioctl+0x100d/0x1790
>   ? __pfx_gup_test_ioctl+0x10/0x10
>   ? srso_return_thunk+0x5/0x5f
>   ? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10
>   ? __fget_files+0x1a7/0x2f0
>   ? srso_return_thunk+0x5/0x5f
>   ? lock_release+0xc5/0x290
>   __x64_sys_ioctl+0x134/0x1c0
>   do_syscall_64+0xbb/0x360
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f8704b24ded
> Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> RSP: 002b:00007f86fc9fedd0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f86fc9ffcdc RCX: 00007f8704b24ded
> RDX: 00007f86fc9fee30 RSI: 00000000c0506706 RDI: 0000000000000004
> RBP: 00007f86fc9fee20 R08: 0000000000000000 R09: 00007f86fc9ff6c0
> R10: 00007f8704a18808 R11: 0000000000000246 R12: 00007f86fc9ff6c0
> R13: ffffffff3faf98ff R14: 0000000000000000 R15: 00007fff93bc7f10
>   </TASK>
> 
> The buggy address belongs to stack of task gup_test/2236
>   and is located at offset 288 in frame:
>   __dump_page+0x0/0x590
> 
> This frame has 1 object:
>   [32, 384) 'ps'
> 
> The buggy address belongs to the physical page:
> 
> Memory state around the buggy address:
>   ffff88810c52fb80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   ffff88810c52fc00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> ffff88810c52fc80: 00 00 00 00 00 00 f3 f3 f3 f3 f3 f3 f3 f3 00 00
>                                       ^
>   ffff88810c52fd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   ffff88810c52fd80: 00 00 00 f1 f1 f1 f1 f1 f1 00 f2 f2 f2 00 00 00
> ==================================================================
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043139c1
> Oops: general protection fault, probably for non-canonical address 0xe3fffa2204313c50: 0000 [#1] SMP KASAN NOPTI
> KASAN: maybe wild-memory-access in range [0x1ffff1102189e280-0x1ffff1102189e287]
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043139b7
> CPU: 0 UID: 102 PID: 444 Comm: in:imklog Tainted: G    B               6.16.0-rc5 #22 PREEMPT(voluntary)
> Tainted: [B]=BAD_PAGE
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:get_mem_cgroup_from_mm+0xe0/0x600
> Code: 03 80 3c 28 00 0f 85 4a 04 00 00 4c 8b bb d0 12 00 00 e8 d3 1b dc 02 85 c0 0f 85 c6 00 00 00 49 8d 7f 20 48 89 f8 48 c1 e8 03 <80> 3c 28 00 0f 85 2b 04 00 00 49 8b 5f 20 48 85 db 0f 84 98 00 00
> RSP: 0000:ffff88810b957bc8 EFLAGS: 00010216
> RAX: 03fffe2204313c50 RBX: ffff88810c4f0000 RCX: ffffffff91cb0e6a
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 1ffff1102189e282
> RBP: dffffc0000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffea00042588c7 R11: ffff88810b957e20 R12: ffff88810edc2700
> R13: ffffed1021db85e9 R14: ffffffff91cb0eb0 R15: 1ffff1102189e262
> FS:  00007fe8d345b6c0(0000) GS:ffff888183970000(0000) knlGS:0000000000000000
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043139ac
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fe8d3860000 CR3: 000000010426b000 CR4: 0000000000350ef0
> Call Trace:
>   <TASK>
>   __mem_cgroup_charge+0x1a/0x1e0
>   folio_prealloc+0x109/0x220
>   do_anonymous_page+0x853/0x1f00
>   ? srso_return_thunk+0x5/0x5f
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043139a2
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313997
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431398d
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313982
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313978
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431396d
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313963
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313958
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431394e
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313943
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313939
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431392e
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313924
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313919
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431390f
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313904
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043138fa
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043138ef
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043138e5
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043138da
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043138d0
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043138c5
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043138bb
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043138b0
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043138a6
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431389b
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313891
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313886
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431387c
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313871
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313867
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431385c
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313852
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313847
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431383d
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313832
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313828
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431381d
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313813
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313808
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043137fe
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043137f3
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043137e9
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043137de
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043137d4
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043137c9
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043137bf
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043137b4
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043137aa
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431379f
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313795
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431378a
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313780
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313775
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431376b
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313760
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313756
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431374b
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313741
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313736
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431372c
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313721
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313717
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431370c
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313702
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043136f7
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043136ed
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043136e2
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043136d8
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043136cd
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043136c3
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043136b8
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043136ae
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043136a3
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313699
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431368e
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313684
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313679
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431366f
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313664
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431365a
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431364f
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313645
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431363a
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313630
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313625
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431361b
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313610
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313606
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043135fb
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043135f1
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043135e6
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043135dc
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043135d1
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043135c7
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043135bc
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043135b2
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043135a7
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431359d
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313592
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313588
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431357d
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313573
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313568
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431355e
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313553
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313549
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431353e
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313534
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313529
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431351f
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a04313514
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0431350a
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043134ff
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043134f5
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a043134ea
> traps: PANIC: double fault, error_code: 0x0
>   ? srso_return_thunk+0x5/0x5f
>   ? lock_release+0x1c0/0x290
>   __handle_mm_fault+0xfb7/0x1310
>   ? __pfx___handle_mm_fault+0x10/0x10
>   ? lock_release+0x1c0/0x290
>   handle_mm_fault+0x2a2/0x670
>   ? __x64_sys_gettimeofday+0x118/0x1a0
>   do_user_addr_fault+0x242/0xb10
>   exc_page_fault+0x5c/0xc0
>   asm_exc_page_fault+0x26/0x30
> RIP: 0033:0x564750127362
> Code: ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 f9 ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 8b 97 38 02 00 00 48 8b 87 40 02 00 00 <48> 89 34 d0 48 8b 87 38 02 00 00 48 63 57 24 48 83 c0 01 48 39 d0
> RSP: 002b:00007fe8d343a1f8 EFLAGS: 00010246
> RAX: 00007fe8d385d010 RBX: 0000000000000001 RCX: 0000000000000000
> RDX: 00000000000005fe RSI: 00007fe8c4016f10 RDI: 000056476d61fc70
> RBP: 00007fe8d343a270 R08: 0000000000000056 R09: 0000000000000000
> R10: a3d70a3d70a3d70b R11: 0000000000000000 R12: 000056475018a560
> R13: 00007fe8d343a220 R14: 0000000000000004 R15: 000056476d61fc70
>   </TASK>
> Modules linked in:
> Oops: double fault: 0000 [#2] SMP KASAN NOPTI
> CPU: 3 UID: 0 PID: 2236 Comm: gup_test Tainted: G    B D             6.16.0-rc5 #22 PREEMPT(voluntary)
> Tainted: [B]=BAD_PAGE, [D]=DIE
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:default_pointer+0x2b/0x490
> Code: 57 41 56 49 89 f6 48 89 ce 48 b9 00 00 00 00 00 fc ff df 41 55 41 54 55 53 48 89 fb 48 83 ec 78 4c 8d 64 24 18 48 8d 7c 24 3c <48> c7 44 24 18 b3 8a b5 41 48 c7 44 24 20 32 42 85 95 49 c1 ec 03
> RSP: 0018:ffff88810c4d2fd8 EFLAGS: 00010096
> RAX: 0000000000000020 RBX: ffff88810c4d337e RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: ffffffffffff0a00 RDI: ffff88810c4d3014
> RBP: ffffffff94cff76a R08: ffffffffffff0a00 R09: 00000000fffffffc
> R10: 0000000000000004 R11: 00000000ffffffff R12: ffff88810c4d2ff0
> R13: ffff88810c4d3360 R14: ffff88810c4d3360 R15: 000000000000ffff
> ---[ end trace 0000000000000000 ]---
> FS:  00007f86fc9ff6c0(0000) GS:ffff888183af0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff88810c4d2fc8 CR3: 000000010135a000 CR4: 0000000000350ef0
> Call Trace:
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:get_mem_cgroup_from_mm+0xe0/0x600
> Oops: general protection fault, probably for non-canonical address 0xe3fffa2204313c50: 0000 [#3] SMP KASAN NOPTI
> Code: 03 80 3c 28 00 0f 85 4a 04 00 00 4c 8b bb d0 12 00 00 e8 d3 1b dc 02 85 c0 0f 85 c6 00 00 00 49 8d 7f 20 48 89 f8 48 c1 e8 03 <80> 3c 28 00 0f 85 2b 04 00 00 49 8b 5f 20 48 85 db 0f 84 98 00 00
> RSP: 0000:ffff88810b957bc8 EFLAGS: 00010216
> RAX: 03fffe2204313c50 RBX: ffff88810c4f0000 RCX: ffffffff91cb0e6a
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 1ffff1102189e282
> RBP: dffffc0000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffea00042588c7 R11: ffff88810b957e20 R12: ffff88810edc2700
> R13: ffffed1021db85e9 R14: ffffffff91cb0eb0 R15: 1ffff1102189e262
> FS:  00007f86fc9ff6c0(0000) GS:ffff888183af0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff88810c4d2fc8 CR3: 000000010135a000 CR4: 0000000000350ef0
> Kernel panic - not syncing: Fatal exception in interrupt
> Shutting down cpus with NMI
> Kernel Offset: 0x10200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> 
> # Report 2
> 
> # -----------------------------------------
> # running ./gup_test -ct -F 0x1 0 19 0x1000
> # -----------------------------------------
> # TAP version 13
> # 1..1
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in snapshot_page+0x27e/0x5b0
> Read of size 256 at addr ffff888100f67c50 by task gup_test/2268
> 
> CPU: 0 UID: 0 PID: 2268 Comm: gup_test Not tainted 6.16.0-rc5 #24 PREEMPT(voluntary)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x66/0xa0
>   print_report+0xd0/0x640
>   ? snapshot_page+0x27e/0x5b0
>   ? srso_return_thunk+0x5/0x5f
>   ? __virt_addr_valid+0x208/0x3f0
>   ? snapshot_page+0x27e/0x5b0
>   kasan_report+0xe4/0x120
>   ? snapshot_page+0x27e/0x5b0
>   kasan_check_range+0x105/0x1b0
>   __asan_memcpy+0x23/0x60
>   snapshot_page+0x27e/0x5b0
>   ? desc_read_finalized_seq+0x75/0x130
>   ? __asan_memcpy+0x3c/0x60
>   ? __pfx_snapshot_page+0x10/0x10
>   ? srso_return_thunk+0x5/0x5f
>   ? srso_return_thunk+0x5/0x5f
>   ? _raw_spin_unlock_irqrestore+0x22/0x50
>   ? prb_read_valid+0x64/0x90
>   __dump_page+0x9b/0x590
>   ? __pfx___dump_page+0x10/0x10
>   ? __pfx__printk+0x10/0x10
>   ? srso_return_thunk+0x5/0x5f
>   ? mark_held_locks+0x40/0x70
>   ? dump_page+0x34/0x80
>   dump_page+0x34/0x80
>   gup_test_ioctl+0x100d/0x1780
>   ? __pfx_gup_test_ioctl+0x10/0x10
>   ? srso_return_thunk+0x5/0x5f
>   ? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10
>   ? __fget_files+0x1a7/0x2f0
>   ? srso_return_thunk+0x5/0x5f
>   ? lock_release+0xc5/0x290
>   __x64_sys_ioctl+0x134/0x1c0
>   do_syscall_64+0xbb/0x360
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f8eb9f24ded
> Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> RSP: 002b:00007f8eb1dfedd0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f8eb1dffcdc RCX: 00007f8eb9f24ded
> RDX: 00007f8eb1dfee30 RSI: 00000000c0506706 RDI: 0000000000000004
> RBP: 00007f8eb1dfee20 R08: 0000000000000000 R09: 00007f8eb1dff6c0
> R10: 00007f8eb9e18808 R11: 0000000000000246 R12: 00007f8eb1dff6c0
> R13: ffffffff3faf98ff R14: 0000000000000000 R15: 00007ffc0a5f6560
>   </TASK>
> 
> The buggy address belongs to stack of task gup_test/2268
>   and is located at offset 288 in frame:
>   __dump_page+0x0/0x590
> 
> This frame has 1 object:
>   [32, 384) 'ps'
> 
> The buggy address belongs to the physical page:
> 
> Memory state around the buggy address:
>   ffff888100f67b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   ffff888100f67c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> ffff888100f67c80: 00 00 00 00 00 00 f3 f3 f3 f3 f3 f3 f3 f3 00 00
>                                       ^
>   ffff888100f67d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   ffff888100f67d80: 00 00 00 f1 f1 f1 f1 f1 f1 00 f2 f2 f2 00 00 00
> ==================================================================
> BUG: unable to handle page fault for address: ffffde2055761988
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 10002a067 P4D 10002a067 PUD 0
> page: refcount:0 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0xfffffe7a0403b3e7
> Oops: Oops: 0000 [#1] SMP KASAN NOPTI
> CPU: 3 UID: 102 PID: 449 Comm: in:imklog Tainted: G    B               6.16.0-rc5 #24 PREEMPT(voluntary)
> Tainted: [B]=BAD_PAGE
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:__cgroup_account_cputime_field+0x6a/0x130
> Code: 00 00 00 48 03 9d f0 03 00 00 83 fe 01 74 2a 76 4b 83 ee 02 83 fe 02 77 62 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 97 00 00 00 4c 01 23 eb 42 48 b8 00 00 00 00 00
> RSP: 0018:ffff88811af88d30 EFLAGS: 00010016
> RAX: dffffc0000000000 RBX: ffff1102abb0cc40 RCX: 0000000000010000
> RDX: 1fffe22055761988 RSI: 0000000000000000 RDI: ffff888100ef53f0
> RBP: ffff888100ef5000 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffffae4aa457 R11: ffff88811afa96e8 R12: 00000000000f4240
> R13: 0000000000000002 R14: ffff888107a21578 R15: 00000000fffe958d
> FS:  00007f18074466c0(0000) GS:ffff88816bb13000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffde2055761988 CR3: 000000010b9ec000 CR4: 0000000000350ef0
> Call Trace:
>   <IRQ>
>   account_system_index_time+0x1ac/0x2d0
>   update_process_times+0x71/0x1e0
>   ? __pfx_update_process_times+0x10/0x10
>   ? srso_return_thunk+0x5/0x5f
>   ? srso_return_thunk+0x5/0x5f
>   ? ktime_get+0xa0/0x1e0
>   tick_nohz_handler+0x19e/0x440
>   ? __pfx_tick_nohz_handler+0x10/0x10
>   __hrtimer_run_queues+0x505/0x8c0
>   ? __pfx___hrtimer_run_queues+0x10/0x10
>   ? srso_return_thunk+0x5/0x5f
>   ? ktime_get_update_offsets_now+0xbe/0x360
>   hrtimer_interrupt+0x30a/0x860
>   ? srso_return_thunk+0x5/0x5f
>   ? __flush_smp_call_function_queue+0x35b/0x600
>   __sysvec_apic_timer_interrupt+0xbc/0x330
>   sysvec_apic_timer_interrupt+0x66/0x80
>   </IRQ>
>   <TASK>
>   asm_sysvec_apic_timer_interrupt+0x1a/0x20
> RIP: 0010:kasan_check_range+0x15/0x1b0
> Code: 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 85 f6 0f 84 5b 01 00 00 48 89 f8 41 54 41 89 d0 <48> 01 f0 55 53 0f 82 dc 00 00 00 eb 0f cc cc cc 48 b8 00 00 00 00
> RSP: 0018:ffff888109427760 EFLAGS: 00000202
> RAX: ffff888109427900 RBX: ffffffffadbe0fd8 RCX: ffffffffa96fb3ba
> RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff888109427900
> RBP: ffff888109427900 R08: 0000000000000001 R09: fffffbfff5b7c1fb
> R10: ffffffffadbe0fdf R11: fffffffffffd9500 R12: 00000000ffffe4ad
> R13: 0000000000000000 R14: ffff8881094277d8 R15: 0000000000000002
>   ? desc_read+0x21a/0x2f0
>   desc_read+0x21a/0x2f0
>   desc_read_finalized_seq+0x75/0x130
>   ? __pfx_desc_read_finalized_seq+0x10/0x10
>   ? lock_release+0x1c0/0x290
>   ? srso_return_thunk+0x5/0x5f
>   ? __mutex_trylock_common+0xdd/0x250
>   _prb_read_valid+0x1ac/0x680
>   ? trace_contention_end+0xc4/0x100
>   ? __pfx__prb_read_valid+0x10/0x10
>   ? lock_release+0x1c0/0x290
>   ? syslog_print+0x34c/0x550
>   ? record_print_text+0x2e9/0x3a0
>   ? srso_return_thunk+0x5/0x5f
>   ? lock_acquire+0x286/0x2e0
>   prb_read_valid+0x64/0x90
>   ? __pfx_prb_read_valid+0x10/0x10
>   syslog_print+0x37d/0x550
>   ? lock_acquire+0x286/0x2e0
>   ? __pfx_syslog_print+0x10/0x10
>   ? srso_return_thunk+0x5/0x5f
>   ? lock_release+0x1c0/0x290
>   ? srso_return_thunk+0x5/0x5f
>   ? __pfx_autoremove_wake_function+0x10/0x10
>   ? srso_return_thunk+0x5/0x5f
>   ? srso_return_thunk+0x5/0x5f
>   ? lock_release+0x1c0/0x290
>   ? srso_return_thunk+0x5/0x5f
>   ? lock_acquire+0x286/0x2e0
>   do_syslog+0x12b/0x4b0
>   ? __pfx_do_syslog+0x10/0x10
>   ? __mutex_trylock_common+0xdd/0x250
>   ? __pfx___mutex_trylock_common+0x10/0x10
>   ? srso_return_thunk+0x5/0x5f
>   ? srso_return_thunk+0x5/0x5f
>   ? srso_return_thunk+0x5/0x5f
>   ? selinux_file_permission+0x3a7/0x520
>   kmsg_read+0x63/0x80
>   vfs_read+0x16e/0xa40
>   ? fdget_pos+0x228/0x2e0
>   ? __pfx___mutex_lock+0x10/0x10
>   ? __pfx_vfs_read+0x10/0x10
>   ? srso_return_thunk+0x5/0x5f
>   ? __fget_files+0x1b1/0x2f0
>   ksys_read+0xf4/0x1c0
>   ? __pfx_ksys_read+0x10/0x10
>   do_syscall_64+0xbb/0x360
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f1807d1ba9a
> Code: 55 48 89 e5 48 83 ec 20 48 89 55 e8 48 89 75 f0 89 7d f8 e8 c8 ca f7 ff 48 8b 55 e8 48 8b 75 f0 41 89 c0 8b 7d f8 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 2e 44 89 c7 48 89 45 f8 e8 22 cb f7 ff 48 8b
> RSP: 002b:00007f1807425440 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 000055a4e236a820 RCX: 00007f1807d1ba9a
> RDX: 0000000000001fa0 RSI: 00007f1807425c80 RDI: 0000000000000005
> RBP: 00007f1807425460 R08: 0000000000000000 R09: 000055a4e2373348
> R10: 00000000000001d4 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f1807425c80 R14: 0000000000020001 R15: 00007f1807426368
>   </TASK>
> Modules linked in:
> CR2: ffffde2055761988
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__cgroup_account_cputime_field+0x6a/0x130
> Code: 00 00 00 48 03 9d f0 03 00 00 83 fe 01 74 2a 76 4b 83 ee 02 83 fe 02 77 62 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 97 00 00 00 4c 01 23 eb 42 48 b8 00 00 00 00 00
> RSP: 0018:ffff88811af88d30 EFLAGS: 00010016
> RAX: dffffc0000000000 RBX: ffff1102abb0cc40 RCX: 0000000000010000
> RDX: 1fffe22055761988 RSI: 0000000000000000 RDI: ffff888100ef53f0
> RBP: ffff888100ef5000 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffffae4aa457 R11: ffff88811afa96e8 R12: 00000000000f4240
> R13: 0000000000000002 R14: ffff888107a21578 R15: 00000000fffe958d
> FS:  00007f18074466c0(0000) GS:ffff88816bb13000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffde2055761988 CR3: 000000010b9ec000 CR4: 0000000000350ef0
> Kernel panic - not syncing: Fatal exception in interrupt
> Kernel Offset: 0x28200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> 
> # Report 3
> 
> # -----------------------------------------
> # running ./gup_test -ct -F 0x1 0 19 0x1000
> # -----------------------------------------
> # TAP version 13
> # 1..1
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in snapshot_page+0x27e/0x5b0
> Read of size 256 at addr ffff88810360fc50 by task gup_test/2123
> 
> CPU: 3 UID: 0 PID: 2123 Comm: gup_test Not tainted 6.16.0-rc5 #24 PREEMPT(voluntary)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x66/0xa0
>   print_report+0xd0/0x640
>   ? snapshot_page+0x27e/0x5b0
>   ? srso_return_thunk+0x5/0x5f
>   ? __virt_addr_valid+0x208/0x3f0
>   ? snapshot_page+0x27e/0x5b0
>   kasan_report+0xe4/0x120
>   ? snapshot_page+0x27e/0x5b0
>   kasan_check_range+0x105/0x1b0
>   __asan_memcpy+0x23/0x60
>   snapshot_page+0x27e/0x5b0
>   ? desc_read_finalized_seq+0x75/0x130
>   ? __asan_memcpy+0x3c/0x60
>   ? __pfx_snapshot_page+0x10/0x10
>   ? srso_return_thunk+0x5/0x5f
>   ? srso_return_thunk+0x5/0x5f
>   ? _raw_spin_unlock_irqrestore+0x22/0x50
>   ? prb_read_valid+0x64/0x90
>   __dump_page+0x9b/0x590
>   ? __pfx___dump_page+0x10/0x10
>   ? __pfx__printk+0x10/0x10
>   ? srso_return_thunk+0x5/0x5f
>   ? mark_held_locks+0x40/0x70
>   ? dump_page+0x34/0x80
>   dump_page+0x34/0x80
>   gup_test_ioctl+0xef0/0x1630
>   ? __pfx_gup_test_ioctl+0x10/0x10
>   ? srso_return_thunk+0x5/0x5f
>   ? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10
>   ? __fget_files+0x1a7/0x2f0
>   ? srso_return_thunk+0x5/0x5f
>   ? lock_release+0xc5/0x290
>   __x64_sys_ioctl+0x134/0x1c0
>   do_syscall_64+0xbb/0x360
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f02c0924ded
> Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> RSP: 002b:00007f02b87fedd0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f02b87ffcdc RCX: 00007f02c0924ded
> RDX: 00007f02b87fee30 RSI: 00000000c0506706 RDI: 0000000000000004
> RBP: 00007f02b87fee20 R08: 0000000000000000 R09: 00007f02b87ff6c0
> R10: 00007f02c0818808 R11: 0000000000000246 R12: 00007f02b87ff6c0
> R13: ffffffff3faf98ff R14: 0000000000000000 R15: 00007ffe07145b50
>   </TASK>
> 
> The buggy address belongs to stack of task gup_test/2123
>   and is located at offset 288 in frame:
>   __dump_page+0x0/0x590
> 
> This frame has 1 object:
>   [32, 384) 'ps'
> 
> The buggy address belongs to the physical page:
> 
> Memory state around the buggy address:
>   ffff88810360fb80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   ffff88810360fc00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> ffff88810360fc80: 00 00 00 00 00 00 f3 f3 f3 f3 f3 f3 f3 f3 00 00
>                                       ^
>   ffff88810360fd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   ffff88810360fd80: 00 00 00 f1 f1 f1 f1 f1 f1 00 f2 f2 f2 00 00 00
> ==================================================================
> traps: PANIC: double fault, error_code: 0x0
> Oops: double fault: 0000 [#1] SMP KASAN NOPTI
> CPU: 3 UID: 0 PID: 2123 Comm: gup_test Tainted: G    B               6.16.0-rc5 #24 PREEMPT(voluntary)
> Tainted: [B]=BAD_PAGE
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:number+0x1c/0xa00
> Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 41 57 41 56 41 55 41 54 49 89 f4 55 53 48 89 fb 48 81 ec f8 00 00 00 48 8d 44 24 58 <48> 89 54 24 08 48 ba 00 00 00 00 00 fc ff df 48 8d 7c 24 78 48 c7
> RSP: 0018:ffff8881035bdfe8 EFLAGS: 00010096
> RAX: ffff8881035be040 RBX: ffff8881035be349 RCX: ffffffffffff0a01
> RDX: 0000000000000000 RSI: ffff8881035be340 RDI: ffff8881035be349
> RBP: ffff8881035be1e8 R08: 0000000000000001 R09: 203a656761703401
> R10: 0000000000000004 R11: ffff8881035be338 R12: ffff8881035be340
> R13: ffff8881035be349 R14: ffff8881035be2f8 R15: 0000000000000010
> FS:  00007f02b87ff6c0(0000) GS:ffff88818e7a2000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff8881035bdfd8 CR3: 000000010c1d3000 CR4: 0000000000350ef0
> Call Trace:
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:number+0x1c/0xa00
> Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 41 57 41 56 41 55 41 54 49 89 f4 55 53 48 89 fb 48 81 ec f8 00 00 00 48 8d 44 24 58 <48> 89 54 24 08 48 ba 00 00 00 00 00 fc ff df 48 8d 7c 24 78 48 c7
> RSP: 0018:ffff8881035bdfe8 EFLAGS: 00010096
> RAX: ffff8881035be040 RBX: ffff8881035be349 RCX: ffffffffffff0a01
> RDX: 0000000000000000 RSI: ffff8881035be340 RDI: ffff8881035be349
> RBP: ffff8881035be1e8 R08: 0000000000000001 R09: 203a656761703401
> R10: 0000000000000004 R11: ffff8881035be338 R12: ffff8881035be340
> R13: ffff8881035be349 R14: ffff8881035be2f8 R15: 0000000000000010
> FS:  00007f02b87ff6c0(0000) GS:ffff88818e7a2000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff8881035bdfd8 CR3: 000000010c1d3000 CR4: 0000000000350ef0
> Kernel panic - not syncing: Fatal exception in interrupt
> Kernel Offset: 0x5a00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> Marking unfinished test run as failed
> 
>> David Hildenbrand (1):
>>    mm/memory: introduce is_huge_zero_pfn() and use it in
>>      vm_normal_page_pmd()
>>
>> Luiz Capitulino (3):
>>    mm/util: introduce snapshot_page()
>>    proc: kpagecount: use snapshot_page()
>>    fs: stable_page_flags(): use snapshot_page()
>>
>>   fs/proc/page.c          | 50 +++++++++++++++-----------
>>   include/linux/huge_mm.h | 12 ++++++-
>>   include/linux/mm.h      | 19 ++++++++++
>>   mm/debug.c              | 42 +++-------------------
>>   mm/memory.c             |  2 +-
>>   mm/util.c               | 77 +++++++++++++++++++++++++++++++++++++++++
>>   6 files changed, 142 insertions(+), 60 deletions(-)
>>
>> -- 
>> 2.50.0
>>
>>
> 


