Return-Path: <linux-kernel+bounces-849759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC03BD0CD1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 23:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CB094E5D9A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4668B23D7E9;
	Sun, 12 Oct 2025 21:35:32 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CFABE49
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 21:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760304931; cv=none; b=GuzUd18tj0rvbnUhy+xfUUd2S6/UhosfN3zpuxuf1FSniUlr33lSU/QSI+n+dnd433N1D+9+mjodoXO8GbROuA1QhJNfgUjHpOF1lVlSmyePt2WM9lFKs+0OZ/gQog+uD2M3XcFfNTfaQlTXzvAMJO4v5+UOsIRU7SfCY4wzsrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760304931; c=relaxed/simple;
	bh=se/DCxn1OBoHpc/2Lht6ciW+yLjJEqvAhmi4Wwuq8lE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=f9bbSjCwWG8Df6KC5bsp1uqsjNsgiHCu/UrNy/GXKst7dKSDxkT8Li4uBTePedwQ/syn/tDqofuhtiSVx7YuOEup6INqEuJTMCS7w8QGGgYeNnzQQT4KXLB/zYGaCZBlxa8NjQ95wg7HCScI7ZOa794DG8KLh3n3pXATYDy0lUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-42f8befcb06so98997815ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 14:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760304929; x=1760909729;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=21oSMvOkuBDgTJsiHpGrC6RxwBfmzfyAFDNnNmLkhn8=;
        b=T0cU3CeMpOvwj9ewCQCl/8mC/WFqkQW+p8jXpXeNGd6op/LAqOjwuKLPwlgwSdvb0a
         GLJ7706WfLSeVQ0GK+sQgHHKrvJyKnjWvaK0Sdf9kNU3wIjcubAkx90cuTlac9eFMLdP
         Wp8Zj6X6cI1xvInxIX9RW8hEz1rWa60ujpO/TI3VviCUw+3ZBFeGUgq5my6r9KT3LhHh
         fGYOpE/EheRzHQq/HXFE5uPDgb0SPK3fwei6DAWS4gcYfIby+MqD/BoyPp7p6DZW9g83
         +c3HAIXQgdTXX+49kCBS6teauDDsANXIiXxJ3JsxUP4efGVUN6wVsx1Nz1TM0UrR+thU
         I+vA==
X-Forwarded-Encrypted: i=1; AJvYcCWcVFG6VsJAcUgc/DzNY1Py0SsJuKmfoH21r3YNSYd7rpQu/CCt78ASJ7rT8xToZ27dGZQZHuVy8zbYfzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YypA7d2qAm78BlMMVolMqyoYfxNV9jR2YlGXPL7iT+r91i8Bbii
	sXSL0KB9rD5I55BehnqAUeO9RyvefEakIYJRERoBr740WgmRkM1OB+S9TGYq3zPsbo3pMLZkiwh
	0RRx7tmKUKJ3fQJpySdQHzW8dCZ85PP8AZzxBzROa4R1+TEbJ6pm53dvWDKA=
X-Google-Smtp-Source: AGHT+IHlwEB3MDiTqQ5LJt/wuyG48zs/HorkirurbLHc9mmu4f9I1OU8ZwJLQWGy43tRmndEqXCGPQX3v5hivH0thyUO5Mjre6IJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214d:b0:426:9b42:24ce with SMTP id
 e9e14a558f8ab-42f87370ab0mr219434105ab.13.1760304929480; Sun, 12 Oct 2025
 14:35:29 -0700 (PDT)
Date: Sun, 12 Oct 2025 14:35:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ec1f21.050a0220.ac43.000f.GAE@google.com>
Subject: [syzbot] [net?] WARNING in xfrm_state_fini (4)
From: syzbot <syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ffce84bccb4d Merge branch 'bpf-avoid-rcu-context-warning-w..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=112559e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e0e0bf7e51565cd
dashboard link: https://syzkaller.appspot.com/bug?extid=999eb23467f83f9bf9bf
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1514d304580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cd489c5f530a/disk-ffce84bc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e4a06e8e5022/vmlinux-ffce84bc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c1111b7581ab/bzImage-ffce84bc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 36 at net/xfrm/xfrm_state.c:3306 xfrm_state_fini+0x26d/0x2f0 net/xfrm/xfrm_state.c:3306
Modules linked in:
CPU: 1 UID: 0 PID: 36 Comm: kworker/u8:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: netns cleanup_net
RIP: 0010:xfrm_state_fini+0x26d/0x2f0 net/xfrm/xfrm_state.c:3306
Code: c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 4b f0 36 f8 48 8b 3b 5b 41 5c 41 5d 41 5e 41 5f 5d e9 99 e1 16 f8 e8 64 4d d1 f7 90 <0f> 0b 90 e9 fd fd ff ff e8 56 4d d1 f7 90 0f 0b 90 e9 60 fe ff ff
RSP: 0018:ffffc90000ac7878 EFLAGS: 00010293
RAX: ffffffff89edd6ec RBX: ffff888058e08000 RCX: ffff88801ce99e40
RDX: 0000000000000000 RSI: ffffffff8d9cc7ae RDI: ffff88801ce99e40
RBP: ffffc90000ac7990 R08: ffffffff8f9db437 R09: 1ffffffff1f3b686
R10: dffffc0000000000 R11: fffffbfff1f3b687 R12: ffffffff8f5d4bc0
R13: 1ffff92000158f3c R14: ffff888058e094c0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125e27000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007eff78efa6b0 CR3: 000000007788c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 xfrm_net_exit+0x2d/0x70 net/xfrm/xfrm_policy.c:4354
 ops_exit_list net/core/net_namespace.c:199 [inline]
 ops_undo_list+0x497/0x990 net/core/net_namespace.c:252
 cleanup_net+0x4d8/0x820 net/core/net_namespace.c:695
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

