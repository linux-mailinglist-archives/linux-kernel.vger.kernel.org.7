Return-Path: <linux-kernel+bounces-638933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A39AAF094
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 03:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8ADF1B67A8C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 01:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7649219259E;
	Thu,  8 May 2025 01:23:48 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DE53FD1
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 01:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746667428; cv=none; b=YMLqbfzhGabDo8rXAxtY1c72FHA55p9cZd4E9uruvdJuseJxa9V7/tYuwQ/PsxyYHWfVEZ0IJ41bXUygfaBG6SeGeMt5UoJjMLgjLBgDJVQGBZy3QjzBhno6OQM3pM7wSMbEIo7OSLD38ddc2JPKAohjSRYtwzWZCkJsYektxyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746667428; c=relaxed/simple;
	bh=0wiN+b01chfenhkxqa6KglcTyGN4fkzpt+a/MaFBwoI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o/hl7BNoUs+M2OGy0ZUG9Wm8f5zctNGMoIWHVPX42wXdmT5aJpzVOjBoOdN2OZsqNw7YKCTQEyaFkwyf1uRdF8QzYPBFkZS3/yLIJFNvtZhnhuxzJ0I5w7Z75F7r+9aAjlOgLrlEGTmUoRTANgt2/RsLVBfNZfejPKoqilDt0RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3da644c8ffeso5438185ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 May 2025 18:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746667425; x=1747272225;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cn8+n2YqlG5ZBXqPKVrPe58LSo1TU9Oq9C5LLD1Jamg=;
        b=JhV63LC2kYX9PkhYNpjjnAfdEtbRw/D0v7RkEfSGHUZDvZ/YINgRpWFP7fJHc4iI6r
         nA2zLs91ZvV3W83W3K+8xf3Qe+ADB6W2pIdK9cYeVmHEQRiAgYt4rndRuhe9HPIl7yLZ
         LuvqqqGINUY6O4BxiVutPeZUR1jAJngk/nmeVcvWXiWbpVMSkdZ9tcbfmEqf4HaIVNlI
         d5MiOgSSKSP2S2S5VdZVF0oikIi1DF6juD2Oq3wPj4g3Hz7TrfEzyybQ3Yp8hJ6AVbi7
         ATsL0Ryc11WqkZwlsYdc+cIyBXSlRAjEZnD3ws9eLFZQLjv2OHGGI1zoN1xtJbJ9hwMs
         XRHw==
X-Forwarded-Encrypted: i=1; AJvYcCVZA0oFD1s1rSulZ8sWotqzo0P/4FKUqtvGGyg8Z1K4+gp7ZTHYXQtcxU0mNfK+BRM12R4LUSDxwo68tkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/1eT/pg939CD79nztsv8RlIHoZcJkRym8oZVk6BwB3T9q6sYf
	SF63Wjo2hhpZStDvb8A/dQ1N+5NUj333zf74a2vfqvt4+eZ1DMgO94YzH2YXZznilQnIBdApvhP
	IUtv+lOrSK3fOBzMZAlLr2eMjyQCGH2fY1aHeh2G3SHbA7VWQXcgOPBo=
X-Google-Smtp-Source: AGHT+IEmNr9VhBMrKMt6vjigLUzXWMdwhbB11J/yL4hhgUZepHx4nXVAD/95nrtEsEo5svIIo2WpKIrPXBsjLu5oqgwVCMBJToZl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194b:b0:3d8:20fb:f060 with SMTP id
 e9e14a558f8ab-3da738ed7c6mr64668425ab.4.1746667425480; Wed, 07 May 2025
 18:23:45 -0700 (PDT)
Date: Wed, 07 May 2025 18:23:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681c07a1.050a0220.a19a9.007c.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in mld_clear_delrec
From: syzbot <syzbot+888c7330963d4b45da35@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    92a09c47464d Linux 6.15-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b23b68580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b39cb28b0a399ed3
dashboard link: https://syzkaller.appspot.com/bug?extid=888c7330963d4b45da35
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bb9b7be3962f/disk-92a09c47.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d4048c02a409/vmlinux-92a09c47.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f1a81e88c04e/bzImage-92a09c47.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+888c7330963d4b45da35@syzkaller.appspotmail.com

veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed
Oops: general protection fault, probably for non-canonical address 0xdffffc001ffee000: 0000 [#1] SMP KASAN NOPTI
KASAN: probably user-memory-access in range [0x00000000fff70000-0x00000000fff70007]
CPU: 0 UID: 0 PID: 13 Comm: kworker/u8:1 Not tainted 6.15.0-rc5-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
Workqueue: netns cleanup_net
RIP: 0010:mld_clear_delrec+0x2a6/0x640 net/ipv6/mcast.c:838
Code: 20 00 0f 85 91 03 00 00 49 8b 5d 28 49 c7 45 28 00 00 00 00 48 85 db 75 37 e9 d4 00 00 00 e8 21 86 96 f7 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 39 03 00 00 48 8b 2b 48 8d 7b 30 48 89 de e8
RSP: 0018:ffffc900001275f8 EFLAGS: 00010206
RAX: 000000001ffee000 RBX: 00000000fff70000 RCX: ffffffff8a24ad36
RDX: ffff88801ca80000 RSI: ffffffff8a24accf RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff888033bf3c00 R14: ffff88805babf000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8881249df000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f87f8f59348 CR3: 000000000e180000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ipv6_mc_destroy_dev+0x49/0x690 net/ipv6/mcast.c:2842
 addrconf_ifdown.isra.0+0x13ef/0x1a90 net/ipv6/addrconf.c:3997
 addrconf_notify+0x220/0x19e0 net/ipv6/addrconf.c:3777
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2176
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 unregister_netdevice_many_notify+0xf9a/0x26f0 net/core/dev.c:11982
 unregister_netdevice_many net/core/dev.c:12046 [inline]
 default_device_exit_batch+0x853/0xaf0 net/core/dev.c:12538
 ops_exit_list+0x128/0x180 net/core/net_namespace.c:177
 cleanup_net+0x5c1/0xb30 net/core/net_namespace.c:654
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mld_clear_delrec+0x2a6/0x640 net/ipv6/mcast.c:838
Code: 20 00 0f 85 91 03 00 00 49 8b 5d 28 49 c7 45 28 00 00 00 00 48 85 db 75 37 e9 d4 00 00 00 e8 21 86 96 f7 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 39 03 00 00 48 8b 2b 48 8d 7b 30 48 89 de e8
RSP: 0018:ffffc900001275f8 EFLAGS: 00010206
RAX: 000000001ffee000 RBX: 00000000fff70000 RCX: ffffffff8a24ad36
RDX: ffff88801ca80000 RSI: ffffffff8a24accf RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff888033bf3c00 R14: ffff88805babf000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888124adf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe3317d4800 CR3: 000000000e180000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	20 00                	and    %al,(%rax)
   2:	0f 85 91 03 00 00    	jne    0x399
   8:	49 8b 5d 28          	mov    0x28(%r13),%rbx
   c:	49 c7 45 28 00 00 00 	movq   $0x0,0x28(%r13)
  13:	00
  14:	48 85 db             	test   %rbx,%rbx
  17:	75 37                	jne    0x50
  19:	e9 d4 00 00 00       	jmp    0xf2
  1e:	e8 21 86 96 f7       	call   0xf7968644
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	0f 85 39 03 00 00    	jne    0x36e
  35:	48 8b 2b             	mov    (%rbx),%rbp
  38:	48 8d 7b 30          	lea    0x30(%rbx),%rdi
  3c:	48 89 de             	mov    %rbx,%rsi
  3f:	e8                   	.byte 0xe8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

