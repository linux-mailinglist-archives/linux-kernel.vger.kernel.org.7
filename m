Return-Path: <linux-kernel+bounces-673703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C48ACE4CB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 21:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8CC18996FE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 19:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA0920D4E2;
	Wed,  4 Jun 2025 19:25:29 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DD1202C38
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 19:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065129; cv=none; b=Uxl6PhEzf3F4ilcJcXxHE4fmdy916dmh3lUq4eE+gHHcqbi/w20U4jnWnXXz6ifaqxyGLui0Vsi0RXfsz3fbAJA8bqNAwPHqYuk3nir1Cz9YnNT0G0iFOVzI0fN9JZSL9rwa8kXX33fQr5Nmcgoakk8Lf2ESInGlh6A+rrhTTyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065129; c=relaxed/simple;
	bh=zfjUY8IckOSgrzCcNtle40WLudtu15Y3A74l/Zn9SDA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VAW/TfaJvs8aMpWqexV+GfSPTrqZ8Rre2ovwVl64nwiu+3iCIcjeD9YF3gtV+Ge9oaRC3DJpqDQf7gWgFMm+VSWfg7EpuDECFXyUtzYlg6vycVV1YA/A+s8dZjb13UALsvdzF6Al+J5q2xr02bq6JjduUjAFPdnxPi1yIx/Qj00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ddc65f95b8so2795245ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jun 2025 12:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749065126; x=1749669926;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P2XR+6/sdiawy8JEJk3AuMB0Odiprm5OieWbN+7SdAk=;
        b=RvZi2hg7kT9bucPSC/TkDUi4rQ5Qd79oKlAIpvLywt60tliR8CSqyxqpjZnhuaBwCf
         85+UEBJlzc+5kaXHSWPEEjXcugtKN13E5/AqWzwEMkidgo5Q7si3QhvgZwwmwl50X4mM
         Uh68COBJFVpsU/Ht9PX8qDmcOIc8cT5j4AjHt8L3VJSttPKGj2QMH6Knw3+wEtD0CoTZ
         aELIMO2CuM4OYzxL29x1xLe5qIWOAYlmftvjDuspKHkzF3nP/3OfqJzW0wlcSc5Vf65Z
         +gaURmjs0bw25Vgpt8t5jOlBP+YFplz8eb+8xUmfXqX9I/EJeRBmvJyrMnQvxnRZIznf
         QUpA==
X-Forwarded-Encrypted: i=1; AJvYcCWMYrzMhlR+fmRICWpKFzIjO040Te//P8z5UJE13OuHFs0zACMaeIbXW6mJ82SQs163ilSbcOxMUARjTi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/6IieOUmmZUhooETAfzC1SLYhE42CzkCrAWGpzO05vFUptQn7
	/zrRcaKaoiXcRlM0i2BqevEahraKsFWoWIbkJEchQ2XV41cLbk7jtxgDyANgKg549MJ3Pp1BI5C
	U7ITB7FC7nLseVk9hr64BucvwP5EzRW1P22yL732aXxvvzeOflajbrIOHcWo=
X-Google-Smtp-Source: AGHT+IFe8qYtlyOo7T34Lw+1Scx6V+wnlRhsRMmjumeb8eiOEbbYWTkFLZqR5xMrbfsN1uXgI5FnLRpWt6B1HXmP/Jfxch5Bfp8q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188d:b0:3dd:920f:d28e with SMTP id
 e9e14a558f8ab-3ddbfc504f2mr41743775ab.13.1749065126557; Wed, 04 Jun 2025
 12:25:26 -0700 (PDT)
Date: Wed, 04 Jun 2025 12:25:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68409da6.a00a0220.68b4a.0009.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in ip6_mc_clear_src (2)
From: syzbot <syzbot+cea6d5c85e63d691dfc1@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1af80d00e1e0 Merge tag 'slab-for-6.16' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15259282580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c3a43fc2c7a5747d
dashboard link: https://syzkaller.appspot.com/bug?extid=cea6d5c85e63d691dfc1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/71ae01bedc1a/disk-1af80d00.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e4e400b63650/vmlinux-1af80d00.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ee506a0eb7e1/bzImage-1af80d00.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cea6d5c85e63d691dfc1@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc001fffe000: 0000 [#1] SMP KASAN NOPTI
KASAN: probably user-memory-access in range [0x00000000ffff0000-0x00000000ffff0007]
CPU: 0 UID: 0 PID: 1099 Comm: kworker/u8:6 Not tainted 6.15.0-syzkaller-11802-g1af80d00e1e0 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: netns cleanup_net
RIP: 0010:ip6_mc_clear_src+0x89/0x5a0 net/ipv6/mcast.c:2599
Code: 49 bc 00 00 00 00 00 fc ff df 48 8d 45 10 49 89 c5 48 89 04 24 49 c1 ed 03 4d 01 e5 eb 32 e8 3e 55 88 f7 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 80 04 00 00 4c 8b 3b 48 8d 7b 30 48 89 de e8
RSP: 0018:ffffc90004067308 EFLAGS: 00010206
RAX: 000000001fffe000 RBX: 00000000ffff0000 RCX: ffffffff8a33c19b
RDX: ffff888028444880 RSI: ffffffff8a33c122 RDI: 0000000000000005
RBP: ffff88802af2f800 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: dffffc0000000000
R13: ffffed10055e5f02 R14: ffff88802af2f828 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888124765000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000002e5030 CR3: 000000002a0c0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mld_clear_delrec+0xfb/0x640 net/ipv6/mcast.c:826
 ipv6_mc_destroy_dev+0x49/0x690 net/ipv6/mcast.c:2842
 addrconf_ifdown.isra.0+0x13ef/0x1a90 net/ipv6/addrconf.c:4000
 addrconf_notify+0x220/0x19e0 net/ipv6/addrconf.c:3780
 notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
 call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
 call_netdevice_notifiers net/core/dev.c:2282 [inline]
 unregister_netdevice_many_notify+0xf9a/0x26f0 net/core/dev.c:12076
 unregister_netdevice_many net/core/dev.c:12139 [inline]
 unregister_netdevice_queue+0x305/0x3f0 net/core/dev.c:11983
 unregister_netdevice include/linux/netdevice.h:3379 [inline]
 nsim_destroy+0x197/0x5d0 drivers/net/netdevsim/netdev.c:1068
 __nsim_dev_port_del+0x189/0x240 drivers/net/netdevsim/dev.c:1428
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1440 [inline]
 nsim_dev_reload_destroy+0x10a/0x4d0 drivers/net/netdevsim/dev.c:1661
 nsim_dev_reload_down+0x6e/0xd0 drivers/net/netdevsim/dev.c:968
 devlink_reload+0x1a1/0x7c0 net/devlink/dev.c:461
 devlink_pernet_pre_exit+0x1a0/0x2b0 net/devlink/core.c:509
 ops_pre_exit_list net/core/net_namespace.c:162 [inline]
 ops_undo_list+0x187/0xab0 net/core/net_namespace.c:235
 cleanup_net+0x408/0x890 net/core/net_namespace.c:686
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ip6_mc_clear_src+0x89/0x5a0 net/ipv6/mcast.c:2599
Code: 49 bc 00 00 00 00 00 fc ff df 48 8d 45 10 49 89 c5 48 89 04 24 49 c1 ed 03 4d 01 e5 eb 32 e8 3e 55 88 f7 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 80 04 00 00 4c 8b 3b 48 8d 7b 30 48 89 de e8
RSP: 0018:ffffc90004067308 EFLAGS: 00010206
RAX: 000000001fffe000 RBX: 00000000ffff0000 RCX: ffffffff8a33c19b
RDX: ffff888028444880 RSI: ffffffff8a33c122 RDI: 0000000000000005
RBP: ffff88802af2f800 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: dffffc0000000000
R13: ffffed10055e5f02 R14: ffff88802af2f828 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888124865000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000404030 CR3: 0000000034f3f000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	49 bc 00 00 00 00 00 	movabs $0xdffffc0000000000,%r12
   7:	fc ff df
   a:	48 8d 45 10          	lea    0x10(%rbp),%rax
   e:	49 89 c5             	mov    %rax,%r13
  11:	48 89 04 24          	mov    %rax,(%rsp)
  15:	49 c1 ed 03          	shr    $0x3,%r13
  19:	4d 01 e5             	add    %r12,%r13
  1c:	eb 32                	jmp    0x50
  1e:	e8 3e 55 88 f7       	call   0xf7885561
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	0f 85 80 04 00 00    	jne    0x4b5
  35:	4c 8b 3b             	mov    (%rbx),%r15
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

