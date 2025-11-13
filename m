Return-Path: <linux-kernel+bounces-898646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EADEEC55A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A490E3B300E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FF92FE58F;
	Thu, 13 Nov 2025 04:27:34 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45E32FD69C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763008054; cv=none; b=K7Al+3YIZoKplsCiuPbUyMVTq2tsVoADF/hA+R9IH35J/LT6Ekgjrbp6zvnhLHkFW6FX2vj5KAXQrB6jEJa3lhEqmGZMKVj++27gNaHutA742u07r9qBaVhX6gfusAsQM5j9GGAu6+9+YdjFKs9pbGCZCeE0wnzswN2Wh5PGwiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763008054; c=relaxed/simple;
	bh=7tu9SqzwK9TfzeC272RqnZMMCSZFz7zsUFIoQFuwaRM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lkoG36bUWILv0h8MmoJFiTk21vd6nr7aaVxvtpLvmtV1LOXriBQ1Xc2cFGj3+tWMDCPsfGRvydfjNDu5BSxcsSS/VSCIo7QAeFICj4u0Vn2ZiOKP83u7NggKxUdYPSYoLpf9fFoqniG51nbcYbbfU4bOVtQD0fYvEwa98rod2Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-432fb58f876so24495895ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:27:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763008052; x=1763612852;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLGKLzPKzjs7w6K2eLL+xaFYyvPSpqSoxoz823gZM28=;
        b=hExwuaJIBceDcGY210yy6wSw5N9PZzA2o+/DCh74JR9gVz14gGoWWOzgv8vD4F73Cm
         C8WGe1JLcRI5e73VLYI/PcUsjcvrEtEHLNdICFJy9Ee336wkiHu7SQmlDx8JWCN6PX6L
         CouqWdE1j8Ah1oXQajLskqfCN3/qGpL080jrztwuAdICZxeK7xZmHoHMzzVT2kb8LHD5
         j+csLEAExaU7uB/kjCzR3+Ut3wv/UyHFh6y1hBtAZcvVklSr3+yIRFuqujge+yuUK+N+
         55Xe5UNrMr1txLhS6wWUnDkBcp0TRxXSAf/J09aDQ8716g/dKEHVp4nagkiMLFEuA7Hb
         zu+A==
X-Gm-Message-State: AOJu0YxKxCv4ymlpIqwXjt43LPd51gs97ycHYI97ObyHII+yG3W19UmK
	oYqKsN5bqtEM/4FZRpojH2W/F1DARdkNULxP2fOlyKg6sQhVk5wTDrCmC5f0atAbsc0q/sjLFmi
	GP9iYYCQMnElYUJggbqpKcFjDrzHIms3Kg9PljBpLurol+t9yvRcozYwlOCE/zQ==
X-Google-Smtp-Source: AGHT+IGydEkBnrJIwYZL4xfoVkecygIInEGfTMBRlIXefrJbiOyfGrLi+3zfGCRPtOVd9ZGDcOedkJIE5Vp0/oT5i0hQ8joGmZhg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a61:b0:433:296a:df1b with SMTP id
 e9e14a558f8ab-43473cff360mr71240295ab.5.1763008052009; Wed, 12 Nov 2025
 20:27:32 -0800 (PST)
Date: Wed, 12 Nov 2025 20:27:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69155e34.050a0220.3565dc.0018.GAE@google.com>
Subject: [syzbot] [kernel?] general protection fault in put_pid_ns
From: syzbot <syzbot+983e44006c89c92789a4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b179ce312baf Add linux-next specific files for 20251112
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16e83c12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94a763b28bedecbc
dashboard link: https://syzkaller.appspot.com/bug?extid=983e44006c89c92789a4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113a8692580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f017cd980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e65122f908cc/disk-b179ce31.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/af947f05c76b/vmlinux-b179ce31.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6678ef895114/bzImage-b179ce31.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+983e44006c89c92789a4@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000017: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000000b8-0x00000000000000bf]
CPU: 0 UID: 0 PID: 6035 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:is_ns_init_id include/linux/ns_common.h:25 [inline]
RIP: 0010:__ns_ref_put include/linux/ns_common.h:70 [inline]
RIP: 0010:put_pid_ns+0x37/0x2a0 kernel/pid_namespace.c:187
Code: 53 48 89 fb e8 0a ba 03 00 48 85 db 0f 84 e8 00 00 00 49 bc 00 00 00 00 00 fc ff df 4c 8d b3 d0 00 00 00 4d 89 f5 49 c1 ed 03 <43> 80 7c 25 00 00 74 08 4c 89 f7 e8 49 12 6a 00 4d 8b 3e 31 ff 4c
RSP: 0018:ffffc90003327cd0 EFLAGS: 00010206
RAX: ffffffff81bdd646 RBX: ffffffffffffffea RCX: ffff888031968000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffffffffffea
RBP: 0000000000000002 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000664f78 R12: dffffc0000000000
R13: 0000000000000017 R14: 00000000000000ba R15: ffff88801d325e24
FS:  000055558fdcd500(0000) GS:ffff888125a76000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30363fff CR3: 00000000742bc000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 nsproxy_free+0x20f/0x7c0 kernel/nsproxy.c:68
 __free_nsproxy_free kernel/nsproxy.c:76 [inline]
 create_new_namespaces+0x47a/0x540 kernel/nsproxy.c:132
 unshare_nsproxy_namespaces+0x11c/0x170 kernel/nsproxy.c:197
 ksys_unshare+0x4c8/0x8c0 kernel/fork.c:3129
 __do_sys_unshare kernel/fork.c:3200 [inline]
 __se_sys_unshare kernel/fork.c:3198 [inline]
 __x64_sys_unshare+0x38/0x50 kernel/fork.c:3198
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f20f058f6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd15b97998 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f20f07e5fa0 RCX: 00007f20f058f6c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000022020400
RBP: 00007f20f0611f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f20f07e5fa0 R14: 00007f20f07e5fa0 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:is_ns_init_id include/linux/ns_common.h:25 [inline]
RIP: 0010:__ns_ref_put include/linux/ns_common.h:70 [inline]
RIP: 0010:put_pid_ns+0x37/0x2a0 kernel/pid_namespace.c:187
Code: 53 48 89 fb e8 0a ba 03 00 48 85 db 0f 84 e8 00 00 00 49 bc 00 00 00 00 00 fc ff df 4c 8d b3 d0 00 00 00 4d 89 f5 49 c1 ed 03 <43> 80 7c 25 00 00 74 08 4c 89 f7 e8 49 12 6a 00 4d 8b 3e 31 ff 4c
RSP: 0018:ffffc90003327cd0 EFLAGS: 00010206
RAX: ffffffff81bdd646 RBX: ffffffffffffffea RCX: ffff888031968000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffffffffffea
RBP: 0000000000000002 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000664f78 R12: dffffc0000000000
R13: 0000000000000017 R14: 00000000000000ba R15: ffff88801d325e24
FS:  000055558fdcd500(0000) GS:ffff888125a76000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30363fff CR3: 00000000742bc000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	53                   	push   %rbx
   1:	48 89 fb             	mov    %rdi,%rbx
   4:	e8 0a ba 03 00       	call   0x3ba13
   9:	48 85 db             	test   %rbx,%rbx
   c:	0f 84 e8 00 00 00    	je     0xfa
  12:	49 bc 00 00 00 00 00 	movabs $0xdffffc0000000000,%r12
  19:	fc ff df
  1c:	4c 8d b3 d0 00 00 00 	lea    0xd0(%rbx),%r14
  23:	4d 89 f5             	mov    %r14,%r13
  26:	49 c1 ed 03          	shr    $0x3,%r13
* 2a:	43 80 7c 25 00 00    	cmpb   $0x0,0x0(%r13,%r12,1) <-- trapping instruction
  30:	74 08                	je     0x3a
  32:	4c 89 f7             	mov    %r14,%rdi
  35:	e8 49 12 6a 00       	call   0x6a1283
  3a:	4d 8b 3e             	mov    (%r14),%r15
  3d:	31 ff                	xor    %edi,%edi
  3f:	4c                   	rex.WR


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

