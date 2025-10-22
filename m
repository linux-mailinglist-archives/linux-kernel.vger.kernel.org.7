Return-Path: <linux-kernel+bounces-864023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AE5BF9BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 776C64E2245
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867F9219E8C;
	Wed, 22 Oct 2025 02:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csH0zhXf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24D417BB35
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761100645; cv=none; b=ei3/odHS9/8uVyXj76NQfR0BjNYHH3rf3ORlmW1nMMuT2P8zLuU8Vy/93ShDh5mBtRLBGheQlEk0fC0BFc2ojAZgqWpefwQgCCh8D/5gJo9mrEBes/fLWGjNmJgF6XY0frjo1B905++mjrxvwkq4B5csPTy1DptexLKxq8Vh5z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761100645; c=relaxed/simple;
	bh=ml/xeYDhTNx1bgatCCjgOtANITCdQ3MIYRxTyroOLqc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=auoLxigI0U5u+Vj/agOls9OKqfTaaz749/3fppX5ATck3QUPtMgVEqrHYa54sS1qtrKpT05e2DqNUFjpAIdhG7PsMGx1pafI2QjOSHbPKzzSsBigQs3cE0yMNnLN96/JZJlUAtLwsduUtvYoizLkjwYknGq5E07UWrfDHkeUkbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csH0zhXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EEEC4CEF1;
	Wed, 22 Oct 2025 02:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761100645;
	bh=ml/xeYDhTNx1bgatCCjgOtANITCdQ3MIYRxTyroOLqc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=csH0zhXfncwQIBpJyKsvZzt7kJzwiJoz7P+ryKKluQo147609cPJsoac1xWxHtr0t
	 tsn3g6gLcMnzKcUveuQqrFAmVPRh93yaqAEOhxhwrEdsgR5UydqGABqEAab/JaFF1D
	 z1idp4HfEPIUeahgeG5ZZ5rgjt3JiciTKWgiWX1tZzyLhIdubcr/2GJqpVvsDB20hh
	 nCdLvqKEYdaCzJolHgIS+TTstpgCs9Km3a+ltrcRP9uOOjiFNS4ZrO9fBWJ02t7mw2
	 C2ZcVVi1kEdRGUZjkIg5LTKTS68goNHy79AfrkukNxIQM9bwh9O3utlgRB31KtudIv
	 KKu5Lk7oIg/Xg==
Message-ID: <90d89437-8a8f-4b6f-9aa1-3cf47ed9f9c3@kernel.org>
Date: Wed, 22 Oct 2025 10:37:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: Re: [BUG] f2fs: divide error in f2fs_all_cluster_page_ready on v6.17
To: "Bai, Shuangpeng" <SJB7183@PSU.EDU>
References: <44D8F7B3-68AD-425F-9915-65D27591F93F@psu.edu>
 <54ad259c-b29f-4444-8d3c-1ec37abc628d@kernel.org>
 <A08A3C40-FC46-4A14-A946-6C5D354FE9AB@psu.edu>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <A08A3C40-FC46-4A14-A946-6C5D354FE9AB@psu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/22/25 08:57, Bai, Shuangpeng wrote:
> 
> 
>> On Oct 19, 2025, at 23:15, Chao Yu <chao@kernel.org> wrote:
>>
>> Hi Bai,
>>
>> On 10/12/25 23:49, Bai, Shuangpeng wrote:
>>> Hi Kernel Maintainers,
>>> Our tool found a new kernel bug "divide error in f2fs_all_cluster_page_ready". Please see the details below.
>>> Kernel commit: 6.17
>>> Kernel config: attachment
>>> Reproducer: attachment
>>> The reproducer triggers the crash reliably in ~500 seconds on a QEMU x86_64 VM.
>>> I’m happy to test debug patches or provide additional information.
>>
>> Finally, I can reproduce this bug, thanks for your help. :)
>>
>> I have figured out a fix below, could you please help to test it?
>>
>> https://lore.kernel.org/linux-f2fs-devel/20251020023453.329467-1-chao@kernel.org
>>
> 
> I applied the patch to v6.18-rc2 and reran the reproducer. The issue no longer reproduces.

Thanks a lots for your help! :)

Thanks,

> 
> Thank you!
> 
> 
> 
>> Thanks,
>>
>>> Oops: divide error: 0000 [#1] SMP KASAN PTI
>>> CPU: 0 UID: 0 PID: 11441 Comm: syz.0.46 Not tainted 6.17.0 #1 PREEMPT(full)
>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>>> RIP: 0010:f2fs_all_cluster_page_ready+0x106/0x550 fs/f2fs/compress.c:857
>>> Code: 00 8b 4d 00 48 89 d8 48 c1 e8 20 74 19 48 89 d8 31 d2 48 f7 f1 48 89 d5 eb 14 48 89 5c 24 10 e8 40 a4 6d fd eb 2d 89 d8 31 d2 <f7> f1 89 d5 31 ff 48 89 ee e8 0c a9 6d fd 48 85 ed 74 0c e8 22 a4
>>> RSP: 0018:ffffc90006616e60 EFLAGS: 00010246
>>> RAX: 0000000000000003 RBX: 0000000000000003 RCX: 0000000000000000
>>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>>> RBP: ffffc90006617270 R08: ffffffff84552d26 R09: 0000000000000000
>>> R10: ffff888155ad2000 R11: ffffffff81d2aa26 R12: 0000000000000001
>>> R13: dffffc0000000000 R14: 0000000000000010 R15: ffffc90006617260
>>> FS:  00007f8bac5b5640(0000) GS:ffff888220f02000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 000056508a326000 CR3: 0000000117bec000 CR4: 00000000000006f0
>>> Call Trace:
>>>  <TASK>
>>>  f2fs_write_cache_pages fs/f2fs/data.c:3078 [inline]
>>>  __f2fs_write_data_pages fs/f2fs/data.c:3290 [inline]
>>>  f2fs_write_data_pages+0x1c19/0x3600 fs/f2fs/data.c:3317
>>>  do_writepages+0x38e/0x640 mm/page-writeback.c:2634
>>>  filemap_fdatawrite_wbc mm/filemap.c:386 [inline]
>>>  __filemap_fdatawrite_range mm/filemap.c:419 [inline]
>>>  file_write_and_wait_range+0x2ba/0x3e0 mm/filemap.c:794
>>>  f2fs_do_sync_file+0x6e6/0x1b00 fs/f2fs/file.c:294
>>>  generic_write_sync include/linux/fs.h:3043 [inline]
>>>  f2fs_file_write_iter+0x76e/0x2700 fs/f2fs/file.c:5259
>>>  new_sync_write fs/read_write.c:593 [inline]
>>>  vfs_write+0x7e9/0xe00 fs/read_write.c:686
>>>  ksys_write+0x19d/0x2d0 fs/read_write.c:738
>>>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>>  do_syscall_64+0xf7/0x470 arch/x86/entry/syscall_64.c:94
>>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>> RIP: 0033:0x7f8bab7ae49d
>>> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>>> RSP: 002b:00007f8bac5b4f98 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>>> RAX: ffffffffffffffda RBX: 00007f8baba26180 RCX: 00007f8bab7ae49d
>>> RDX: 000000000000ffbd RSI: 0000200000000240 RDI: 0000000000000007
>>> RBP: 00007f8bab848268 R08: 0000000000000000 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>>> R13: 00007f8baba26218 R14: 00007f8baba26180 R15: 00007f8bac595000
>>>  </TASK>
>>> Modules linked in:
>>> ---[ end trace 0000000000000000 ]---
>>> RIP: 0010:f2fs_all_cluster_page_ready+0x106/0x550 fs/f2fs/compress.c:857
>>> Code: 00 8b 4d 00 48 89 d8 48 c1 e8 20 74 19 48 89 d8 31 d2 48 f7 f1 48 89 d5 eb 14 48 89 5c 24 10 e8 40 a4 6d fd eb 2d 89 d8 31 d2 <f7> f1 89 d5 31 ff 48 89 ee e8 0c a9 6d fd 48 85 ed 74 0c e8 22 a4
>>> RSP: 0018:ffffc90006616e60 EFLAGS: 00010246
>>> RAX: 0000000000000003 RBX: 0000000000000003 RCX: 0000000000000000
>>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>>> RBP: ffffc90006617270 R08: ffffffff84552d26 R09: 0000000000000000
>>> R10: ffff888155ad2000 R11: ffffffff81d2aa26 R12: 0000000000000001
>>> R13: dffffc0000000000 R14: 0000000000000010 R15: ffffc90006617260
>>> FS:  00007f8bac5b5640(0000) GS:ffff888220f02000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 000056508a326000 CR3: 0000000117bec000 CR4: 00000000000006f0
>>> ----------------
>>> Code disassembly (best guess):
>>>    0: 00 8b 4d 00 48 89     add    %cl,-0x76b7ffb3(%rbx)
>>>    6: d8 48 c1              fmuls  -0x3f(%rax)
>>>    9: e8 20 74 19 48        call   0x4819742e
>>>    e: 89 d8                 mov    %ebx,%eax
>>>   10: 31 d2                 xor    %edx,%edx
>>>   12: 48 f7 f1              div    %rcx
>>>   15: 48 89 d5              mov    %rdx,%rbp
>>>   18: eb 14                 jmp    0x2e
>>>   1a: 48 89 5c 24 10        mov    %rbx,0x10(%rsp)
>>>   1f: e8 40 a4 6d fd        call   0xfd6da464
>>>   24: eb 2d                 jmp    0x53
>>>   26: 89 d8                 mov    %ebx,%eax
>>>   28: 31 d2                 xor    %edx,%edx
>>> * 2a: f7 f1                 div    %ecx <-- trapping instruction
>>>   2c: 89 d5                 mov    %edx,%ebp
>>>   2e: 31 ff                 xor    %edi,%edi
>>>   30: 48 89 ee              mov    %rbp,%rsi
>>>   33: e8 0c a9 6d fd        call   0xfd6da944
>>>   38: 48 85 ed              test   %rbp,%rbp
>>>   3b: 74 0c                 je     0x49
>>>   3d: e8                    .byte 0xe8
>>>   3e: 22                    .byte 0x22
>>>   3f: a4                    movsb  %ds:(%rsi),%es:(%rdi)
>>> Best,
>>> Shuangpeng
>>
> 


