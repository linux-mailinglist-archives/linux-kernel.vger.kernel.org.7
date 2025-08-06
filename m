Return-Path: <linux-kernel+bounces-757435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD03B1C21A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3FFB7AB45E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CED6221FD4;
	Wed,  6 Aug 2025 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yfmc2jAx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8854C17597
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754468706; cv=none; b=j/P8V325KvZOirhVOXcPNLs0uVPxTFqM07Obq2cB8zTG5aYyuBYCSNoH0T/8TT1t8g9viTy6tT2YAkzSuI+uH0lQlwVFilrB+wAc3hOv0HsdDZBl6EcqIcJh/yOPaI+a1CGm1XtNj3uK62P+NFVh5i6vs1R1HCewxbv1pm9VEYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754468706; c=relaxed/simple;
	bh=Zig5RC2roSyZ4m53lUqOLyUyUnpvkPpQtYiG6yC0Uek=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=gVe6mGBvcITw3qXCMnOGqGi7RZ2GQu41EDHquxDbyHVNKsfzqYrBNBd/iWh+0eeASd/bNDx/ImYhZRx9BtUpZbbyuE4MitxMR5g9v6o3i8/LEuNca3f6rzunlHenXC1BrmkX4tP6bkEHaLME3U/Wp0sWkpodFEFejGdEoWAaOdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yfmc2jAx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754468703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FLP5in3tI2IeRwy4TjPfeVazf60FxxiqoEOfpmJPj/k=;
	b=Yfmc2jAxlIzoWWPDY+ZAKTgr49ugjH/Npf58pW1SWFK8yoIbU4QDCY5MXuc6KwpyE2ZZK1
	vG/KIiZyZdD45ym1FZ8Hh82vS9VDZWAbAFc9uebdVluTZcnSHy05P3lWhT63qNdA6RDM34
	cnwSipeFo8Ilnds0Ipjh9qZsXPCluBc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-wlb9tWv2NlKNgSXf_TSE5Q-1; Wed, 06 Aug 2025 04:25:02 -0400
X-MC-Unique: wlb9tWv2NlKNgSXf_TSE5Q-1
X-Mimecast-MFC-AGG-ID: wlb9tWv2NlKNgSXf_TSE5Q_1754468701
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45526e19f43so16790785e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 01:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754468701; x=1755073501;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:cc
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLP5in3tI2IeRwy4TjPfeVazf60FxxiqoEOfpmJPj/k=;
        b=nBU5SqitiDHtU7k6E6dC6bzW56mNWj2nZra/vTkMeantcsEEW9lsGP6+P+TCFW6U8X
         xHUe/8iYdG1PTepFDsK8N1B94D+BfyelRg4rr6YtHtk/gDnLD1/ucSeeWwhWUhOemAU2
         NcdwfTTrrkzTQ62B8XWsPvSjP+zMtbWHPffkEkqdHCa+MU7FZf0rxUUrfZsivB/3EttV
         FBu8WGO1OSeEZIKM+xj6HfZ/Og822URm9HjWZ9XSjunAQI4iqgKg2Q/+gI9kk5Bh44c7
         dDtmB3AWAGpXQ8d74P9WFuIDRm8oMTDaPZDrzLN+WUk/pnB0Kx9DCEcvwtzvgOFrmj3k
         Vr+w==
X-Forwarded-Encrypted: i=1; AJvYcCUF6XtLPEEXuU8X2oVia1ixukBrGInwtKemtnC76BgC5J9KzdBO2nK5DkKPk2oE/ZVLR5YF7ObwvYfNc0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4eHt2y3a/WmowhMNVhrJKI3uqJyOQwWaEPgeNQr9mfYituEfg
	+umU6gJ/laboOn4ujgw/tEjonTPqbZ7f5kl8RPb6wpbXFRnzvSZuNzOkjsyvsj1EbPyiIVgmR09
	rX8GLJb+kZiM5EpAfJYURCO8/wfDnrf16dBpHVFz/9soEpJKdXKvRiR3s7PAWLTyCAQ==
X-Gm-Gg: ASbGncseGqerrzGYkIuh7qhZMm88LNrtTwpPjh2LwrXMbi/K8SFkC26PkTy6XTujkqa
	npfS6BVm78393rbUCvUvH5aMMRFwy2fP6zVl5bm8RmfvQd8Csb8DuQmGZxhY75lIDxrwKw5baHx
	TmP6Sw2uz/Lg4yyVjUPy9L0dZgfYR4z7XP02Go3lDDHZY6DK/uj1QdLmqfJBVV0gfJD3g2zci3S
	NzHM91hnQwFwu7+oAWQxraIz6vz91Pyqn557EUvkooXa58F2eK3+Dv/Oh0VbBZIIAS8iK9KesaD
	r0JZ9whHHgt0Wq67gksIwh+mwmY0lHB6qXa7wafjx0qV/qEqoPc2Vy2OAe4baT+LeokQ5qx5eLl
	OehoIUhCVjck7KQKAEceVUXo5P0MeICFDXiMoe9i7VMo2BdLg2XJPYo3ROyLU1w==
X-Received: by 2002:a05:6000:288a:b0:3b7:644f:9ca7 with SMTP id ffacd0b85a97d-3b8f41aaafemr1494904f8f.25.1754468700746;
        Wed, 06 Aug 2025 01:25:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxMMUgIo4hylg2WYrYkA0yknGLg0J1j/iFbdpD0p8FLOg1GQjWWhZ6at5eeUsYBunjJHa84g==
X-Received: by 2002:a05:6000:288a:b0:3b7:644f:9ca7 with SMTP id ffacd0b85a97d-3b8f41aaafemr1494864f8f.25.1754468700184;
        Wed, 06 Aug 2025 01:25:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1e:2200:30f4:30:4011:370e? (p200300d82f1e220030f400304011370e.dip0.t-ipconnect.de. [2003:d8:2f1e:2200:30f4:30:4011:370e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458be70c5f7sm158797335e9.26.2025.08.06.01.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 01:24:59 -0700 (PDT)
Message-ID: <18e151e1-6963-49eb-9e45-60c7cb8af15a@redhat.com>
Date: Wed, 6 Aug 2025 10:24:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] general protection fault in __pte_offset_map_lock
 (2)
To: syzbot <syzbot+45ad2baf16fce6bc81f3@syzkaller.appspotmail.com>,
 Liam.Howlett@oracle.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, mhocko@suse.com, rppt@kernel.org,
 surenb@google.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
References: <689307aa.050a0220.7f033.003c.GAE@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Cc: Barry Song <21cnbao@gmail.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <689307aa.050a0220.7f033.003c.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.08.25 09:43, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5998f2bca43e Merge tag 'exfat-for-6.17-rc1' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=136cc434580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=eb90b5976661bfd8
> dashboard link: https://syzkaller.appspot.com/bug?extid=45ad2baf16fce6bc81f3
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102eb6a2580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134d16a2580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/616a65da77ea/disk-5998f2bc.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0f3838a6bd07/vmlinux-5998f2bc.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/298a57ed56ee/bzImage-5998f2bc.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+45ad2baf16fce6bc81f3@syzkaller.appspotmail.com
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
> CPU: 0 UID: 0 PID: 6221 Comm: syz.2.42 Not tainted 6.16.0-syzkaller-11741-g5998f2bca43e #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> RIP: 0010:kasan_byte_accessible+0x15/0x30 mm/kasan/generic.c:199
> Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 03 48 01 c7 <0f> b6 07 3c 07 0f 96 c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00
> RSP: 0018:ffffc90003cdf6d8 EFLAGS: 00010286
> RAX: dffffc0000000000 RBX: 0000000000000018 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff8b92232e RDI: dffffc0000000003
> RBP: 0000000000000018 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff8b92232e
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8881246ce000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f3e8b1dff98 CR3: 000000000e380000 CR4: 00000000003526f0
> Call Trace:
>   <TASK>
>   __kasan_check_byte+0x13/0x50 mm/kasan/common.c:567
>   kasan_check_byte include/linux/kasan.h:399 [inline]
>   lock_acquire kernel/locking/lockdep.c:5842 [inline]
>   lock_acquire+0xfc/0x350 kernel/locking/lockdep.c:5825
>   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>   spin_lock include/linux/spinlock.h:351 [inline]
>   __pte_offset_map_lock+0x10f/0x310 mm/pgtable-generic.c:401
>   pte_offset_map_lock include/linux/mm.h:3029 [inline]
>   zap_pte_range mm/memory.c:1712 [inline]
>   zap_pmd_range mm/memory.c:1818 [inline]
>   zap_pud_range mm/memory.c:1847 [inline]
>   zap_p4d_range mm/memory.c:1868 [inline]
>   unmap_page_range+0xacf/0x42c0 mm/memory.c:1889
>   unmap_single_vma.constprop.0+0x153/0x240 mm/memory.c:1932
>   unmap_vmas+0x218/0x470 mm/memory.c:1976
>   exit_mmap+0x1b9/0xb90 mm/mmap.c:1280
>   __mmput+0x12a/0x410 kernel/fork.c:1129
>   mmput+0x62/0x70 kernel/fork.c:1152
>   exit_mm kernel/exit.c:582 [inline]
>   do_exit+0x7c7/0x2bf0 kernel/exit.c:949
>   do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
>   __do_sys_exit_group kernel/exit.c:1113 [inline]
>   __se_sys_exit_group kernel/exit.c:1111 [inline]
>   __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
>   x64_sys_call+0x14fa/0x1720 arch/x86/include/generated/asm/syscalls_64.h:232
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f412178eb69
> Code: Unable to access opcode bytes at 0x7f412178eb3f.
> RSP: 002b:00007ffcf2965e78 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f412178eb69
> RDX: 0000000000000064 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 00007ffcf2965edc R08: 0000000af2965f6f R09: 00000000000927c0
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
> R13: 00000000000927c0 R14: 00000000000215e0 R15: 00007ffcf2965f30
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:kasan_byte_accessible+0x15/0x30 mm/kasan/generic.c:199
> Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 03 48 01 c7 <0f> b6 07 3c 07 0f 96 c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00
> RSP: 0018:ffffc90003cdf6d8 EFLAGS: 00010286
> RAX: dffffc0000000000 RBX: 0000000000000018 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff8b92232e RDI: dffffc0000000003
> RBP: 0000000000000018 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff8b92232e
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8881246ce000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f3e8b1dff98 CR3: 000000000e380000 CR4: 00000000003526f0
> ----------------
> Code disassembly (best guess):
>     0:	00 00                	add    %al,(%rax)
>     2:	0f 1f 00             	nopl   (%rax)
>     5:	90                   	nop
>     6:	90                   	nop
>     7:	90                   	nop
>     8:	90                   	nop
>     9:	90                   	nop
>     a:	90                   	nop
>     b:	90                   	nop
>     c:	90                   	nop
>     d:	90                   	nop
>     e:	90                   	nop
>     f:	90                   	nop
>    10:	90                   	nop
>    11:	90                   	nop
>    12:	90                   	nop
>    13:	90                   	nop
>    14:	90                   	nop
>    15:	66 0f 1f 00          	nopw   (%rax)
>    19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>    20:	fc ff df
>    23:	48 c1 ef 03          	shr    $0x3,%rdi
>    27:	48 01 c7             	add    %rax,%rdi
> * 2a:	0f b6 07             	movzbl (%rdi),%eax <-- trapping instruction
>    2d:	3c 07                	cmp    $0x7,%al
>    2f:	0f 96 c0             	setbe  %al
>    32:	c3                   	ret
>    33:	cc                   	int3
>    34:	cc                   	int3
>    35:	cc                   	int3
>    36:	cc                   	int3
>    37:	66                   	data16
>    38:	66                   	data16
>    39:	2e                   	cs
>    3a:	0f                   	.byte 0xf
>    3b:	1f                   	(bad)
>    3c:	84 00                	test   %al,(%rax)
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

I assume this is fixed by [1]

[1] https://lkml.kernel.org/r/20250805035447.7958-1-21cnbao@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git 366a4532d96fc357998465133db34d34edb79e4c

-- 
Cheers,

David / dhildenb


