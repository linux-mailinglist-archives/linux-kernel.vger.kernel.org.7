Return-Path: <linux-kernel+bounces-754936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D314B19ED5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59B21622B6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681DB24502D;
	Mon,  4 Aug 2025 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VDOiJ6zH"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDBE1ADC97
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300142; cv=none; b=kBXDXN1EiUOzvfh/FQtw7jV967DBhHmX3kmtJrvYND/z8CLl4dm6swb2IlVhq+POkDkvkZQ94T0K8iuJGYeh33sLrM5yoxJ56uc8As6BSqmVzYY2VC/XAetft2m6OpuJTXF/gz+Pd33PsNRhaRiHyUCeWiSqmhvgfapiJokptSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300142; c=relaxed/simple;
	bh=ov/ophMRmt5M8ULMNpEhVm38jkmkoGruqJCIqJoxnAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6GAb99FNEdV2Z7W3WYiMv9B1PjD2xoj3FTD9/9xdsPKHQFPxI/2fJuJSkDP3BnXa2YmMgz6uPQskR4P1JW/9kj3yeZgNyQXm3o7vnEbRCOEurNDHjxX68ONBCvt5Idu2RQ8RwPUAIVG27CF7cVQhXi52CkmUV4s4SLyRK4K3NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VDOiJ6zH; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-707453b0306so31422156d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 02:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1754300139; x=1754904939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcjWij1zfH9zgejgmouHVbcKEsPohZbovhnBUfRRKYA=;
        b=VDOiJ6zHbhfP1taKGLVQGGa3QbdASiNnRUnUEyXAlHZbC64V8Ecfv//mTGV3MAKU0+
         NI13OzRCY/w2ixZOKyzodWGCrjT8la7Ve87cwjvO30Blj+WwUIrjS6Hb1q6iVu/kJW9C
         0Et0XYwsZV0PQyQwHkae3s+qk4QU1JQLaDdRuTLwPYoboD06KwW/gihONV77ZdHmnkYN
         rkwLzcy0bPgVl/BHMTZuMDxrQ2hFCkb1d6zYN8Nr2k5icSGa8m79X87p5D6N1pphYk1Q
         qqP9C1skQnuX/wB4V/thOIexGJeoQPElYmLBJqc8ca2htIwvesLkQ8iOEYKiUluSwlHr
         9gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754300139; x=1754904939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RcjWij1zfH9zgejgmouHVbcKEsPohZbovhnBUfRRKYA=;
        b=VcxUBjRjMC9dziJDxr12eCk/IFRnuivNxDMOIBepghemg0hoJwbyWi/Vb+8oefCqSk
         eph9PrHzwD7/KArK+LWzkmTxw4tBui7j3EOiaHdb/C3eRISXPl9vPeK7umPE6Kvf/HYE
         Pa89EMEhWpOIQqqwAWbrkrVkAm1DmsB7o2Ia2x4WOjWpEGTtSJ/sVpShyudzZIixEkoI
         UuL1UfoJLt57uRi2Bbg72qN0YR8eyIjdkMz+jGcyUVDDDXU8Rv74yj2Gcq93ypuKkOI7
         JvqTe3s0ST5dZU65KzyEYbPc21ecA8fSSjAkJ0p9xHPY8Et8UvSjLK7PBkhy61H3yGwO
         TVhA==
X-Forwarded-Encrypted: i=1; AJvYcCVS2/KE0j47Z7Lv5dvTLCAfGft3QH5UzdBlhtbR8UnDgtLhOYHp852G1crzSQ+nrWh9CCxv2uoXdLT+H08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6b2m+RqrVA35ektH7ae6ahCfxPzfBAZ7z2f1KcY+Y/5atoXWo
	K/YPa82J/rm4QKD0tfdxcpkA+gRMPsu9AdPUqeZZXJduzVWof4UIqOI8vQDztMp2MPU=
X-Gm-Gg: ASbGncur/P0bWATa7Ftpbo5AHqoMgrSyaMeErKGwN42KwuQMYjjwe2HFWrR6plN/GEe
	t8PcKnLzkQjJyv5yATDs+l50E+r18kDOJKE1TBFYZQXLE1ms+nJK+5+iNn8j5lIMDYZ/hqvuNu7
	1xXfPG8faigpdJgaAjrfL7i04UU4O8Le4xFWLrk6f4zhvsEGdxG6jQPNk662VKRMsLa270Q6nNv
	3gR0LM42MKSXeQB5a33N6PDPdUMJhr5VtK5nAAXZWVh25G84H/C4J9eOAyroQlGU4FQdvN7wd1/
	WSyT1CbuuVJJ35hmsrfoiq+U24IbUe5m3wcxSSRvEi1QX4FjMDb+seGkYEy4WKKedfdCh0fNnQ+
	5pkIE8o+9ChUMxEFrOJ4keana6Q0bnY+2fLJ6V1rXwtR6o4hytLMryaey
X-Google-Smtp-Source: AGHT+IGJYeDoMlkbxXOekoon1joz4ipz4FPO6Mj7+15rgXMlIFwmDrM6pyUnxD9IxFCApfdn/Qj1VA==
X-Received: by 2002:a05:6214:2626:b0:707:159e:d1c9 with SMTP id 6a1803df08f44-7093637cd44mr112044766d6.51.1754300138944;
        Mon, 04 Aug 2025 02:35:38 -0700 (PDT)
Received: from [10.68.122.90] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde8d56sm56261826d6.73.2025.08.04.02.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 02:35:38 -0700 (PDT)
Message-ID: <7d92ec18-ff8e-4929-8b9a-f0bf5c6d249f@bytedance.com>
Date: Mon, 4 Aug 2025 17:35:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: use per_vma lock for MADV_DONTNEED
To: Barry Song <21cnbao@gmail.com>, "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Suren Baghdasaryan <surenb@google.com>, Lokesh Gidra
 <lokeshgidra@google.com>, Tangquan Zheng <zhengtangquan@oppo.com>,
 yi1.lai@intel.com
References: <20250607220150.2980-1-21cnbao@gmail.com>
 <aJAFrYfyzGpbm+0m@ly-workstation>
 <1d1d97f9-2a67-4920-850e-accf4c82440e@redhat.com>
 <4fa8f492-c7ef-451c-8dc7-38b031c8a092@bytedance.com>
 <d9d0890e-2837-49dc-9ca8-1d6c28e95a21@redhat.com>
 <aJB0Kdc6cx1lGkdb@ly-workstation>
 <CAGsJ_4yw4Qn7OWmUJeJZYuOHLjJ7L8kov3Th3vFPa3h4y0ur_A@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAGsJ_4yw4Qn7OWmUJeJZYuOHLjJ7L8kov3Th3vFPa3h4y0ur_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/4/25 5:15 PM, Barry Song wrote:
> On Mon, Aug 4, 2025 at 8:49 PM Lai, Yi <yi1.lai@linux.intel.com> wrote:
>>
>> On Mon, Aug 04, 2025 at 10:30:45AM +0200, David Hildenbrand wrote:
>>> On 04.08.25 10:26, Qi Zheng wrote:
>>>>
>>>>
>>>> On 8/4/25 3:57 PM, David Hildenbrand wrote:
>>>>> On 04.08.25 02:58, Lai, Yi wrote:
>>>>>> Hi Barry Song,
>>>>>>
>>>>>> Greetings!
>>>>>>
>>>>>> I used Syzkaller and found that there is general protection fault in
>>>>>> __pte_offset_map_lock in linux-next next-20250801.
>>>>>>
>>>>>> After bisection and the first bad commit is:
>>>>>> "
>>>>>> a6fde7add78d mm: use per_vma lock for MADV_DONTNEED
>>>>>> "
>>>>>>
>>>>>> All detailed into can be found at:
>>>>>> https://github.com/laifryiee/syzkaller_logs/tree/
>>>>>> main/250803_193026___pte_offset_map_lock
>>>>>> Syzkaller repro code:
>>>>>> https://github.com/laifryiee/syzkaller_logs/tree/
>>>>>> main/250803_193026___pte_offset_map_lock/repro.c
>>>>>> Syzkaller repro syscall steps:
>>>>>> https://github.com/laifryiee/syzkaller_logs/tree/
>>>>>> main/250803_193026___pte_offset_map_lock/repro.prog
>>>>>> Syzkaller report:
>>>>>> https://github.com/laifryiee/syzkaller_logs/tree/
>>>>>> main/250803_193026___pte_offset_map_lock/repro.report
>>>>>> Kconfig(make olddefconfig):
>>>>>> https://github.com/laifryiee/syzkaller_logs/tree/
>>>>>> main/250803_193026___pte_offset_map_lock/kconfig_origin
>>>>>> Bisect info:
>>>>>> https://github.com/laifryiee/syzkaller_logs/tree/
>>>>>> main/250803_193026___pte_offset_map_lock/bisect_info.log
>>>>>> bzImage:
>>>>>> https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/
>>>>>> main/250803_193026___pte_offset_map_lock/bzImage_next-20250801
>>>>>> Issue dmesg:
>>>>>> https://github.com/laifryiee/syzkaller_logs/blob/
>>>>>> main/250803_193026___pte_offset_map_lock/next-20250801_dmesg.log
>>>>>
>>>>> Skimming over the reproducer, we seem to have racing MADV_DONTNEED and
>>>>> MADV_COLLAPSE on the same anon area, but the problem only shows up once
>>>>> we tear down that MM.
>>>>>
>>>>> If I would have to guess, I'd assume it's related to PT_RECLAIM
>>>>> reclaiming empty page tables during MADV_DONTNEED -- but the kconfig
>>>>> does not indicate that CONFIG_PT_RECLAIM was set.
>>>>
>>>> On the x86_64, if PT_RECLAIM is not manually disabled, PT_RECLAIM should
>>>> be enabled
>>>
>>> That's what I thought: but I was not able to spot it in the provided config
>>> [1].
>>>
>>> Or is that config *before* "make olfconfig"? confusing. I would want to see
>>> the actually used config.
>>>
>>>
>>>
>> My kernel compiling steps:
>> 1. copy kconfig_origin to kernel_source_folder/.config
>> 2. make olddefconfig
>> 3. make bzImage -jx
>>
>> I have also uploaded the actual .config during compiling.
>> [2] https://github.com/laifryiee/syzkaller_logs/blob/main/250803_193026___pte_offset_map_lock/.config
>> CONFIG_ARCH_SUPPORTS_PT_RECLAIM=y
>> CONFIG_PT_RECLAIM=y
> 
> Thanks! I can reproduce the issue within one second.

I also reproduced it locally.

BUG: Bad page map in process repro  pte:f000e987f000fea5 pmd:00000067
[22099.667758][T22301] addr:0000000020004000 vm_flags:00100077 
anon_vma:ffff8882c5b5fc98 mapping:0000000000000000 index:20004
[22099.671248][T22301] file:(null) fault:0x0 mmap:0x0 mmap_prepare: 0x0 
read_folio:0x0
[22099.673833][T22301] CPU: 15 UID: 0 PID: 22301 Comm: repro Tainted: G 
   B   W           6.16.0-rc4-next-20250704+ #200 PREEMPT(voluntary)
[22099.673838][T22301] Tainted: [B]=BAD_PAGE, [W]=WARN
[22099.673838][T22301] Hardware name: QEMU Standard PC (i440FX + PIIX, 
1996), BIOS 1.12.0-1 04/01/2014
[22099.673840][T22301] Call Trace:
[22099.673841][T22301]  <TASK>
[22099.673842][T22301]  dump_stack_lvl+0x53/0x70
[22099.673845][T22301]  print_bad_pte+0x178/0x220
[22099.673849][T22301]  vm_normal_page+0x8a/0xa0
[22099.673852][T22301]  unmap_page_range+0x5cb/0x1d40
[22099.673855][T22301]  ? flush_tlb_mm_range+0x21a/0x780
[22099.673859][T22301]  ? tlb_flush_mmu+0x30/0x1c0
[22099.673861][T22301]  unmap_vmas+0xab/0x160
[22099.673863][T22301]  exit_mmap+0xda/0x3c0
[22099.673868][T22301]  mmput+0x6e/0x130
[22099.673869][T22301]  do_exit+0x242/0xb40
[22099.673871][T22301]  do_group_exit+0x30/0x80
[22099.673873][T22301]  get_signal+0x951/0x980
[22099.673876][T22301]  ? futex_wake+0x84/0x170
[22099.673880][T22301]  arch_do_signal_or_restart+0x2d/0x1f0
[22099.673883][T22301]  ? do_futex+0x11a/0x1d0
[22099.673885][T22301]  ? __x64_sys_futex+0x67/0x1c0
[22099.673888][T22301]  exit_to_user_mode_loop+0x86/0x110
[22099.673890][T22301]  do_syscall_64+0x184/0x2b0
[22099.673892][T22301]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[22099.673895][T22301] RIP: 0033:0x7fafb0048af9
[22099.673896][T22301] Code: Unable to access opcode bytes at 
0x7fafb0048acf.
[22099.673898][T22301] RSP: 002b:00007fafaff50ea8 EFLAGS: 00000246 
ORIG_RAX: 00000000000000ca
[22099.673900][T22301] RAX: fffffffffffffe00 RBX: 0000000000000000 RCX: 
00007fafb0048af9
[22099.673901][T22301] RDX: 0000000000000000 RSI: 0000000000000080 RDI: 
0000559d33cab1a8
[22099.673903][T22301] RBP: 00007fafaff50ec0 R08: 0000000000000000 R09: 
0000000000000000
[22099.673904][T22301] R10: 0000000000000000 R11: 0000000000000246 R12: 
00007ffe78dbcd2e
[22099.673905][T22301] R13: 00007ffe78dbcd2f R14: 00007fafaff51700 R15: 
0000000000000000
[22099.673907][T22301]  </TASK>
[22099.673913][T22301] BUG: unable to handle page fault for address: 
ffffea7be1ffe548
[22099.674789][T22301] #PF: supervisor read access in kernel mode
[22099.674789][T22301] #PF: error_code(0x0000) - not-present page
[22099.674789][T22301] PGD 2bfff7067 P4D 2bfff7067 PUD 0
[22099.674789][T22301] Oops: Oops: 0000 [#1] SMP PTI
[22099.674789][T22301] CPU: 15 UID: 0 PID: 22301 Comm: repro Tainted: G 
   B   W           6.16.0-rc4-next-20250704+ #200 PREEMPT(voluntary)
[22099.674789][T22301] Tainted: [B]=BAD_PAGE, [W]=WARN
[22099.674789][T22301] Hardware name: QEMU Standard PC (i440FX + PIIX, 
1996), BIOS 1.12.0-1 04/01/2014
[22099.674789][T22301] RIP: 0010:unmap_page_range+0x1101/0x1d40
[22099.674789][T22301] Code: eb 03 cc cc cc f3 0f 1e fa f3 0f 1e fa e9 
ea 01 00 00 48 b8 ff ff ff ff ff 00 00 00 49 21 c2 49 c1 e2 06 4c 03 15 
ef a6 fd 00 <49> 8b 52 08 4c 89 d0 f6 c2 01 0f 8
[22099.674789][T22301] RSP: 0018:ffffc9000557baa0 EFLAGS: 00010282
[22099.674789][T22301] RAX: 00000003ffffffff RBX: 0000000020005000 RCX: 
f000000000000420
[22099.674789][T22301] RDX: 000000000000001e RSI: 0000000000000000 RDI: 
7803ff95ef87ff95
[22099.674789][T22301] RBP: f000d420f000d420 R08: ffff888000000028 R09: 
c000000100000864
[22099.674789][T22301] R10: ffffea7be1ffe540 R11: ffffc9000557b6b0 R12: 
0000000000000000
[22099.674789][T22301] R13: 00000000000001fb R14: ffffc9000557bcc0 R15: 
ffff888000000028
[22099.674789][T22301] FS:  00007fafaff51700(0000) 
GS:ffff8885b2b29000(0000) knlGS:0000000000000000
[22099.674789][T22301] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[22099.674789][T22301] CR2: ffffea7be1ffe548 CR3: 0000000103d8c000 CR4: 
00000000000006f0
[22099.674789][T22301] Call Trace:
[22099.674789][T22301]  <TASK>
[22099.674789][T22301]  ? flush_tlb_mm_range+0x21a/0x780
[22099.674789][T22301]  ? tlb_flush_mmu+0x30/0x1c0
[22099.674789][T22301]  unmap_vmas+0xab/0x160
[22099.674789][T22301]  exit_mmap+0xda/0x3c0
[22099.674789][T22301]  mmput+0x6e/0x130
[22099.674789][T22301]  do_exit+0x242/0xb40
[22099.674789][T22301]  do_group_exit+0x30/0x80
[22099.674789][T22301]  get_signal+0x951/0x980
[22099.674789][T22301]  ? futex_wake+0x84/0x170
[22099.674789][T22301]  arch_do_signal_or_restart+0x2d/0x1f0
[22099.674789][T22301]  ? do_futex+0x11a/0x1d0
[22099.674789][T22301]  ? __x64_sys_futex+0x67/0x1c0
[22099.674789][T22301]  exit_to_user_mode_loop+0x86/0x110
[22099.674789][T22301]  do_syscall_64+0x184/0x2b0
[22099.674789][T22301]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[22099.674789][T22301] RIP: 0033:0x7fafb0048af9
[22099.674789][T22301] Code: Unable to access opcode bytes at 
0x7fafb0048acf.
[22099.674789][T22301] RSP: 002b:00007fafaff50ea8 EFLAGS: 00000246 
ORIG_RAX: 00000000000000ca
[22099.674789][T22301] RAX: fffffffffffffe00 RBX: 0000000000000000 RCX: 
00007fafb0048af9
[22099.674789][T22301] RDX: 0000000000000000 RSI: 0000000000000080 RDI: 
0000559d33cab1a8
[22099.674789][T22301] RBP: 00007fafaff50ec0 R08: 0000000000000000 R09: 
0000000000000000
[22099.674789][T22301] R10: 0000000000000000 R11: 0000000000000246 R12: 
00007ffe78dbcd2e
[22099.674789][T22301] R13: 00007ffe78dbcd2f R14: 00007fafaff51700 R15: 
0000000000000000
[22099.674789][T22301]  </TASK>

> After disabling PT_RECLAIM in .config, the issue disappears.

Thanks for the test, I'll take a closer look.

> The reason it doesn't occur on arm64 is that x86 is the only platform
> that supports ARCH_SUPPORTS_PT_RECLAIM.
> 
>>
>>> [1] https://github.com/laifryiee/syzkaller_logs/tree/main/250803_193026___pte_offset_map_lock/kconfig_origin
>>>
>>> --
>>> Cheers,
>>>
>>> David / dhildenb
>>>
> 
> Thanks
> Barry


