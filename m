Return-Path: <linux-kernel+bounces-720834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B360AFC0E7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F144A0F67
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0329E2253A5;
	Tue,  8 Jul 2025 02:36:30 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17D01754B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 02:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751942189; cv=none; b=hpDqCiYW9dM8m7+2NhEvPpmQTIXlOEitXCJ3vKZOhNQuSItX2WWc/IYuoU04UGRARPKrHjuXTrw45q0/pNqwyDCEBVXkxh55Bafg+rUNJgoZZSEThJoq/L0AVUIhleihbenVuFOcHajISzOTfnxFPBAE4MHU94njWdeh8E0WkjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751942189; c=relaxed/simple;
	bh=yUGcfd0+KZlglYLC2UqKPgE2Qwez7H1uf7u66md4I1c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HuLqNNsf35HYXWmRIHF0/6hKFNGGl7ZwEE/BJ9Kmkvcta0BdOy5+3vRX/qHr1WVSBm44OVeknG6bSBHKmLSVkzCdcJBaet4cAQs4+ZolnJSFvtTrJMdLM0T45P+hl0ZqyBHYrnJL9UKBIJBp/NRbAQIP+WR6qliRm0Va/yva5sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ddd5cd020dso91461515ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 19:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751942187; x=1752546987;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FG8oKEqnu4KIueTRy0JxUzjPMxRg83UmLWw9sM+NIls=;
        b=ON4ifaitWiHCxI+6BPnkZ7yQ4Fy7ZXbRYfkyQUi5QmhnHQO4PQsO2Sqg2hJgPkFJFZ
         Ks8ukJgU+UWL8eCe2WnrufLhS8HGdsQe82C8Kona0scSm1sPELPEtIRyWVn2l0TBSDtI
         OHnES+7KQHSi92G2kGSKGa7GS16VVGMBw6djlbOGI88zgt8Zpe+BRh+EEU8TjRH9ZxSF
         3RNk7v19l/rPydkFU22FpGLs2+Pj82TqeR/MgB716eXjePWpH00V5RSmclNhzZp/DC4R
         dDzJSJ2crTDv9k0lIF3JnvtrpbEBOt2fFuza5agADuwNS6LIhMLWbYCwGzLO9u3nakTx
         2OQA==
X-Forwarded-Encrypted: i=1; AJvYcCUhFGp/dIQv/WIG2DEF3PzGo81T/rWY56YQplHZKn2o5Az044760jHKJaXosizZZZ12frf7XopKDQzZ2q0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz27oRwaADzBaaz9yTj23t75iHFXPWZJa/vF//HGbNcmHNOvtLr
	R7AbEVlvpnjZNLbT2ebq4amxqQ/vMpP57kuAuhxtha+LdoDmz0/nH6QG/CfFqhVZ9AypU5wa4rW
	QxgtRfAR9cR18oPMppClXvPAtm6Oo9jCWJaGbU7wfepFEUg1uzVTz1rUzzpo=
X-Google-Smtp-Source: AGHT+IHuHCE8xFLzlz62OF6BDKG9Ivjp9WMIQPZOiOUYTZPQLVzAXsjcTNCpiW+Oogynhmcw/0+gfcArja9dfkwAflgSU97Mflti
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1748:b0:3e0:ec1e:18fe with SMTP id
 e9e14a558f8ab-3e1355a80f9mr137997595ab.15.1751942187067; Mon, 07 Jul 2025
 19:36:27 -0700 (PDT)
Date: Mon, 07 Jul 2025 19:36:27 -0700
In-Reply-To: <68679e81.a70a0220.29cf51.0016.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686c842b.050a0220.20334d.0002.GAE@google.com>
Subject: Re: [syzbot] [net?] general protection fault in qfq_qlen_notify
From: syzbot <syzbot+4dadc5aecf80324d5a51@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d7b8f8e20813 Linux 6.16-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17335f70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a09d8660a55f005f
dashboard link: https://syzkaller.appspot.com/bug?extid=4dadc5aecf80324d5a51
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117ac28c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17505582580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d7b8f8e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b7f4e475deea/vmlinux-d7b8f8e2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/474d459b180b/bzImage-d7b8f8e2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4dadc5aecf80324d5a51@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000b: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
CPU: 2 UID: 0 PID: 6105 Comm: syz.0.16 Not tainted 6.16.0-rc5-syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:list_empty include/linux/list.h:373 [inline]
RIP: 0010:qfq_qlen_notify+0x32/0x230 net/sched/sch_qfq.c:1422
Code: 41 55 41 54 49 89 fc 55 53 48 89 f3 4c 8d 7b 58 48 83 ec 08 e8 1f b7 26 f8 4c 89 fa 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 67 01 00 00 48 8b 43 58 49 39 c7 0f 84 30 01 00
RSP: 0018:ffffc9000322f2c0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff11006e3505a
RDX: 000000000000000b RSI: ffffffff89952f91 RDI: ffff8880371a8000
RBP: 00000000000afff2 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000000afff2 R11: 0000000000000001 R12: ffff8880371a8000
R13: 0000000000000000 R14: ffffffff8ce8f1e0 R15: 0000000000000058
FS:  0000555583a75500(0000) GS:ffff8880d6918000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000019580 CR3: 0000000050c10000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 qdisc_tree_reduce_backlog+0x221/0x500 net/sched/sch_api.c:811
 fq_codel_change+0xb1a/0x11b0 net/sched/sch_fq_codel.c:450
 fq_codel_init+0x4ce/0xa60 net/sched/sch_fq_codel.c:487
 qdisc_create+0x457/0xfc0 net/sched/sch_api.c:1324
 __tc_modify_qdisc net/sched/sch_api.c:1749 [inline]
 tc_modify_qdisc+0x12bb/0x2130 net/sched/sch_api.c:1813
 rtnetlink_rcv_msg+0x3c9/0xe90 net/core/rtnetlink.c:6953
 netlink_rcv_skb+0x155/0x420 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x53a/0x7f0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 ____sys_sendmsg+0xa95/0xc70 net/socket.c:2566
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
 __sys_sendmsg+0x16d/0x220 net/socket.c:2652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f57a6b8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc86511388 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f57a6db5fa0 RCX: 00007f57a6b8e929
RDX: 0000000000000800 RSI: 0000200000000100 RDI: 0000000000000003
RBP: 00007f57a6c10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f57a6db5fa0 R14: 00007f57a6db5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:list_empty include/linux/list.h:373 [inline]
RIP: 0010:qfq_qlen_notify+0x32/0x230 net/sched/sch_qfq.c:1422
Code: 41 55 41 54 49 89 fc 55 53 48 89 f3 4c 8d 7b 58 48 83 ec 08 e8 1f b7 26 f8 4c 89 fa 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 67 01 00 00 48 8b 43 58 49 39 c7 0f 84 30 01 00
RSP: 0018:ffffc9000322f2c0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff11006e3505a
RDX: 000000000000000b RSI: ffffffff89952f91 RDI: ffff8880371a8000
RBP: 00000000000afff2 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000000afff2 R11: 0000000000000001 R12: ffff8880371a8000
R13: 0000000000000000 R14: ffffffff8ce8f1e0 R15: 0000000000000058
FS:  0000555583a75500(0000) GS:ffff8880d6918000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000019580 CR3: 0000000050c10000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	41 55                	push   %r13
   2:	41 54                	push   %r12
   4:	49 89 fc             	mov    %rdi,%r12
   7:	55                   	push   %rbp
   8:	53                   	push   %rbx
   9:	48 89 f3             	mov    %rsi,%rbx
   c:	4c 8d 7b 58          	lea    0x58(%rbx),%r15
  10:	48 83 ec 08          	sub    $0x8,%rsp
  14:	e8 1f b7 26 f8       	call   0xf826b738
  19:	4c 89 fa             	mov    %r15,%rdx
  1c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  23:	fc ff df
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 67 01 00 00    	jne    0x19b
  34:	48 8b 43 58          	mov    0x58(%rbx),%rax
  38:	49 39 c7             	cmp    %rax,%r15
  3b:	0f                   	.byte 0xf
  3c:	84 30                	test   %dh,(%rax)
  3e:	01 00                	add    %eax,(%rax)


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

