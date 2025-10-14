Return-Path: <linux-kernel+bounces-851895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D134BD78CE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 469AE4E1CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D261D5174;
	Tue, 14 Oct 2025 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdNgBk6/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E7C256D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760422716; cv=none; b=Q32R6n9x3R3n1sLUKQDm7mlzUNHvwaO7VFNdEs+Af252OY5F80rWI6InY7quPM3bm5koeYwUcI2PGL7Ezi7WNxZdC/h+5iR7RwtbtVUFTS4oJIa00xVophhfu2cCsS4Jnw9SlDSd9+BRhGRmHHl60zZ7MthY9oIetz48k6SFC2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760422716; c=relaxed/simple;
	bh=q1sZJvYxPyzTf40oD93pLYVFzRF8makD6Cf4A69LVPE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KK7ow16dH077ssofn9h8tBHDmKLQqImvb5152zXPpddTGT9OXARrG6h8Iy8p9khzYWF7YScdpqnrd4haUyCT38VyqCImc1GI1cfz4Y35IJncHJUTUGma6/hpcUf0FPO0OjXh1be4/fY5ZVd0cLYrNOyXcZEWZtlqOWYCNLHlmgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdNgBk6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E13C4CEE7;
	Tue, 14 Oct 2025 06:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760422716;
	bh=q1sZJvYxPyzTf40oD93pLYVFzRF8makD6Cf4A69LVPE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=UdNgBk6/f4EvsDr2jrvn1E6qCCJI0cgPZ+DfXUsxVqSGu7o+aLRgk1NxH+rxfiLQu
	 NN+0ixUZZB4XA3AiiYEL21KVL3k2TEErUA7OR5g/x6pwfXfEYq5EnmSCR9PAhtfrYK
	 lDFwZqPUMseN6iVhJMdMlOY1tSpMUHnq+jEXlfbUYPxxvtJnMKk8KoM3pPblr5yaRH
	 nJrtc5swZ120DmeAsyWw3wnvsmj9tIbVYVgbrA3kV0S3cbT4cuT3ilffsnMkCtR+Dh
	 PHzmYr4PNVjbN61Unyfr/oOH3I42+W5HwqLGgz/jpZmMrvH/B/9oBa/R/n6IAJJxMw
	 fAktfjDmI74tw==
Message-ID: <13833d95-cb78-49ce-9a29-1bee30dc6a38@kernel.org>
Date: Tue, 14 Oct 2025 14:18:32 +0800
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
 <61a3acc4-d541-41a4-b675-67b20f125117@kernel.org>
 <6E931354-7EF6-45B3-99A9-6E632FE98D03@psu.edu>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <6E931354-7EF6-45B3-99A9-6E632FE98D03@psu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/14/25 01:56, Bai, Shuangpeng wrote:
> 
> 
>> On Oct 13, 2025, at 08:41, Chao Yu <chao@kernel.org> wrote:
>>
>> On 10/13/25 07:49, Bai, Shuangpeng wrote:
>>> Hi Kernel Maintainers,
>>>
>>> Our tool found a new kernel bug "divide error in f2fs_all_cluster_page_ready". Please see the details below.
>>>
>>> Kernel commit: 6.17
>>> Kernel config: attachment
>>> Reproducer: attachment
>>>
>>> The reproducer triggers the crash reliably in ~500 seconds on a QEMU x86_64 VM.
>>>
>>> I’m happy to test debug patches or provide additional information.
>>
>> Hi Bai,
>>
>> Thanks for your report!
>>
>> Could you please share scripts and images for this issue? as I can not reproduce
>> w/ repro.c.
>>
> 
> Thanks for your reply!
> 
> I used clang-15 to compile the kernel v6.17 with the .config in the attachment.
> 
> The image I used is bullseye.img (https://drive.google.com/file/d/1krL9Mc-s07aA6m-0VjuuO767StacvZQV/view?usp=share_link).
> 
> The image is created by https://raw.githubusercontent.com/google/syzkaller/master/tools/create-image.sh.
> 
> I will also send the boot script as attachments.
> 
> This bug takes about 500 seconds to trigger the bug in our testing environment.
> 
> Please let me know if anything needed. Thanks!

Thanks for providing the information, however I still can not reproduce this bug w/
above images and scripts.

Could you please upload your kernel image as well? let me have a try w/ your image,
not sure it's related to clang-15 or not.

Thanks,

> 
> 
> 
> 
> 
> 
>> Thanks,
>>
>>>
>>>
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
>>> <TASK>
>>> f2fs_write_cache_pages fs/f2fs/data.c:3078 [inline]
>>> __f2fs_write_data_pages fs/f2fs/data.c:3290 [inline]
>>> f2fs_write_data_pages+0x1c19/0x3600 fs/f2fs/data.c:3317
>>> do_writepages+0x38e/0x640 mm/page-writeback.c:2634
>>> filemap_fdatawrite_wbc mm/filemap.c:386 [inline]
>>> __filemap_fdatawrite_range mm/filemap.c:419 [inline]
>>> file_write_and_wait_range+0x2ba/0x3e0 mm/filemap.c:794
>>> f2fs_do_sync_file+0x6e6/0x1b00 fs/f2fs/file.c:294
>>> generic_write_sync include/linux/fs.h:3043 [inline]
>>> f2fs_file_write_iter+0x76e/0x2700 fs/f2fs/file.c:5259
>>> new_sync_write fs/read_write.c:593 [inline]
>>> vfs_write+0x7e9/0xe00 fs/read_write.c:686
>>> ksys_write+0x19d/0x2d0 fs/read_write.c:738
>>> do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>> do_syscall_64+0xf7/0x470 arch/x86/entry/syscall_64.c:94
>>> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>> RIP: 0033:0x7f8bab7ae49d
>>> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>>> RSP: 002b:00007f8bac5b4f98 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>>> RAX: ffffffffffffffda RBX: 00007f8baba26180 RCX: 00007f8bab7ae49d
>>> RDX: 000000000000ffbd RSI: 0000200000000240 RDI: 0000000000000007
>>> RBP: 00007f8bab848268 R08: 0000000000000000 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>>> R13: 00007f8baba26218 R14: 00007f8baba26180 R15: 00007f8bac595000
>>> </TASK>
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
>>>   0: 00 8b 4d 00 48 89     add    %cl,-0x76b7ffb3(%rbx)
>>>   6: d8 48 c1              fmuls  -0x3f(%rax)
>>>   9: e8 20 74 19 48        call   0x4819742e
>>>   e: 89 d8                 mov    %ebx,%eax
>>>  10: 31 d2                 xor    %edx,%edx
>>>  12: 48 f7 f1              div    %rcx
>>>  15: 48 89 d5              mov    %rdx,%rbp
>>>  18: eb 14                 jmp    0x2e
>>>  1a: 48 89 5c 24 10        mov    %rbx,0x10(%rsp)
>>>  1f: e8 40 a4 6d fd        call   0xfd6da464
>>>  24: eb 2d                 jmp    0x53
>>>  26: 89 d8                 mov    %ebx,%eax
>>>  28: 31 d2                 xor    %edx,%edx
>>> * 2a: f7 f1                 div    %ecx <-- trapping instruction
>>>  2c: 89 d5                 mov    %edx,%ebp
>>>  2e: 31 ff                 xor    %edi,%edi
>>>  30: 48 89 ee              mov    %rbp,%rsi
>>>  33: e8 0c a9 6d fd        call   0xfd6da944
>>>  38: 48 85 ed              test   %rbp,%rbp
>>>  3b: 74 0c                 je     0x49
>>>  3d: e8                    .byte 0xe8
>>>  3e: 22                    .byte 0x22
>>>  3f: a4                    movsb  %ds:(%rsi),%es:(%rdi)
>>>
>>> Best,
>>> Shuangpeng
>>>
>>
> 


