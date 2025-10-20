Return-Path: <linux-kernel+bounces-861790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BE7BF3ABA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC9254293B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F336330319;
	Mon, 20 Oct 2025 21:08:28 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F582E7166
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994507; cv=none; b=Shdw7cLdCXfuqkLUZbQiTYF4CvXySZyJmqqOPITKh+C/6buTqOlvw6C+HC2Q8j4AIfq/nTg2sEs8GUdSGXjh0OuQH1HsW7IMXAIzdrRcDbEMHdLskqa6Ur+r4UCx9xvRX4pKZBe4cLw18Oj78+BFslRSUjMsPCknmWTWiiLQXkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994507; c=relaxed/simple;
	bh=jD4feNh0rO7Q5ebHNcKQcavCCncn4VVuktWvcV4A4A8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LAm3IZuYC7ZWtSmSlZijlLjtWbg+vfWTTgI6JU20AWIZ78QfgvYfeARjHF4kaA+t/yX1P2IBS0uJnXwtx08rtVgPfPyNiMTQXJfGgKwIiZu2raWTvBKR2EmMoaSp5gY8L/Xk5omzeE8XqYbpp8UqDW4N56SMkILNLWP1kBgGSiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-430ced58cd2so97302595ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760994504; x=1761599304;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X4v5WIS//FhLKXZLZx8vcqGUMiCy3eGKryGUGQ8f7hE=;
        b=MDLXhGSaIik8DN9572Tvh9BMOvmbHis+wBkJVWRFKufvb89u1gZUT7G9+8oCoxdrD5
         r6YLFabP4r0evAe67fvsJ1MXgJpQWKxwY3lGTWj4EsO7P/7Ziv/S5QpAStbGFsw5GEh4
         oMwh2zXSU3Gmi4GujNy8sg2cqBpZ0c3tuIbzP4ZtvQz4ywODnpw5AY7nVWWlZebrjVsf
         cAbMOiurwCGxpRZA7N70+fLa9X68NbZMgmPZey1wVN/gIPhgmxDgHBA7FQ9TtXtXN8ov
         ko3Zv/zlUg8RRmb/A+aWUwToF2S7dmrEtOrB8KL2nQh+xt2aO6kFH/D002YyY8V1LD00
         b2LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPlO/lq3C699doPhKAdPBA2YIFfH88oJgtgSlEPVldfTw/rh/QSLGIyxYjeyEL/wkDouwZGoKq13MUtTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGcM4F4bypjj8h2/b7xpQCSevGoQXaPu5S0sEyQjwnZvmvwUJG
	h+VPzecYoErPwt1eLVaVuTebXlRNLwQQWfXhJ2ii0gMwWtoTTmpfF56RBhgIspmODhK1GMDuCue
	gBMerAljp+EIJi6e+8ymiFexbvr3L4rdv9E151b6iWT37hUtBxax5K+WoFEI=
X-Google-Smtp-Source: AGHT+IHtjkwxPCBMvAwzd/MHAs8fhSE1wp5mxiSzZK7ofOqbOADUzoHLQxzsHXyJtH5ydcVURGaWEU/YKSJIpCVHk2Vl0HI+EW8D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144e:b0:42f:9560:f733 with SMTP id
 e9e14a558f8ab-430c522fd64mr218366055ab.13.1760994504617; Mon, 20 Oct 2025
 14:08:24 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:08:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f6a4c8.050a0220.1be48.0013.GAE@google.com>
Subject: [syzbot] [btrfs?] general protection fault in btrfs_evict_inode
From: syzbot <syzbot+d991fea1b4b23b1f6bf8@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f406055cb18c Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a1b52f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2d7b4143707d3a0
dashboard link: https://syzkaller.appspot.com/bug?extid=d991fea1b4b23b1f6bf8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1430f67c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-f406055c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c7e9d41abcc8/vmlinux-f406055c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/545562cd43ff/bzImage-f406055c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ed6f0c604e16/mount_2.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=1087e734580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d991fea1b4b23b1f6bf8@syzkaller.appspotmail.com

BTRFS info (device loop0): turning on async discard
BTRFS info (device loop0): enabling free space tree
Oops: general protection fault, probably for non-canonical address 0xdffffc000000003e: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x00000000000001f0-0x00000000000001f7]
CPU: 0 UID: 0 PID: 5682 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btrfs_root_id fs/btrfs/ctree.h:333 [inline]
RIP: 0010:do_perf_trace_btrfs__inode include/trace/events/btrfs.h:204 [inline]
RIP: 0010:perf_trace_btrfs__inode+0x44d/0x580 include/trace/events/btrfs.h:204
Code: c1 e8 03 42 80 3c 30 00 74 08 4c 89 ff e8 5b 44 66 fe 4d 8b 2f 4d 8d bd f7 01 00 00 49 81 c5 fe 01 00 00 4c 89 f8 48 c1 e8 03 <42> 0f b6 04 30 84 c0 0f 85 e4 00 00 00 4c 89 e8 48 c1 e8 03 42 0f
RSP: 0018:ffffc9000d246d60 EFLAGS: 00010203
RAX: 000000000000003e RBX: ffffe8ffffc990a0 RCX: ffffffff83c14767
RDX: 0000000000000010 RSI: ffff888058fd0400 RDI: ffffe8ffffc99068
RBP: ffffc9000d246e30 R08: e443157bdb42d614 R09: f8256aac8f4be681
R10: e443157bdb42d614 R11: f8256aac8f4be681 R12: ffffe8ffffc99060
R13: 00000000000001fe R14: dffffc0000000000 R15: 00000000000001f7
FS:  00007fa645d796c0(0000) GS:ffff88808d300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056106e704950 CR3: 000000003f1ca000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __do_trace_btrfs_inode_evict include/trace/events/btrfs.h:255 [inline]
 trace_btrfs_inode_evict include/trace/events/btrfs.h:255 [inline]
 btrfs_evict_inode+0x107a/0x1110 fs/btrfs/inode.c:5480
 evict+0x504/0x9c0 fs/inode.c:810
 btrfs_rename fs/btrfs/inode.c:8640 [inline]
 btrfs_rename2+0x264f/0x3fd0 fs/btrfs/inode.c:8660
 vfs_rename+0xb34/0xe80 fs/namei.c:5216
 ovl_do_rename fs/overlayfs/overlayfs.h:373 [inline]
 ovl_check_rename_whiteout fs/overlayfs/super.c:595 [inline]
 ovl_make_workdir fs/overlayfs/super.c:714 [inline]
 ovl_get_workdir+0x846/0x17b0 fs/overlayfs/super.c:837
 ovl_fill_super+0x154a/0x3da0 fs/overlayfs/super.c:1468
 vfs_get_super fs/super.c:1324 [inline]
 get_tree_nodev+0xbb/0x150 fs/super.c:1343
 vfs_get_tree+0x92/0x2b0 fs/super.c:1751
 fc_mount fs/namespace.c:1208 [inline]
 do_new_mount_fc fs/namespace.c:3651 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3727
 do_mount fs/namespace.c:4050 [inline]
 __do_sys_mount fs/namespace.c:4238 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4215
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa644f8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa645d79038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fa6451e5fa0 RCX: 00007fa644f8efc9
RDX: 0000200000000b80 RSI: 0000200000000000 RDI: 0000000000000000
RBP: 00007fa645011f91 R08: 0000200000000780 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa6451e6038 R14: 00007fa6451e5fa0 R15: 00007ffdeeb9aa68
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_root_id fs/btrfs/ctree.h:333 [inline]
RIP: 0010:do_perf_trace_btrfs__inode include/trace/events/btrfs.h:204 [inline]
RIP: 0010:perf_trace_btrfs__inode+0x44d/0x580 include/trace/events/btrfs.h:204
Code: c1 e8 03 42 80 3c 30 00 74 08 4c 89 ff e8 5b 44 66 fe 4d 8b 2f 4d 8d bd f7 01 00 00 49 81 c5 fe 01 00 00 4c 89 f8 48 c1 e8 03 <42> 0f b6 04 30 84 c0 0f 85 e4 00 00 00 4c 89 e8 48 c1 e8 03 42 0f
RSP: 0018:ffffc9000d246d60 EFLAGS: 00010203
RAX: 000000000000003e RBX: ffffe8ffffc990a0 RCX: ffffffff83c14767
RDX: 0000000000000010 RSI: ffff888058fd0400 RDI: ffffe8ffffc99068
RBP: ffffc9000d246e30 R08: e443157bdb42d614 R09: f8256aac8f4be681
R10: e443157bdb42d614 R11: f8256aac8f4be681 R12: ffffe8ffffc99060
R13: 00000000000001fe R14: dffffc0000000000 R15: 00000000000001f7
FS:  00007fa645d796c0(0000) GS:ffff88808d300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056106e704950 CR3: 000000003f1ca000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	c1 e8 03             	shr    $0x3,%eax
   3:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
   8:	74 08                	je     0x12
   a:	4c 89 ff             	mov    %r15,%rdi
   d:	e8 5b 44 66 fe       	call   0xfe66446d
  12:	4d 8b 2f             	mov    (%r15),%r13
  15:	4d 8d bd f7 01 00 00 	lea    0x1f7(%r13),%r15
  1c:	49 81 c5 fe 01 00 00 	add    $0x1fe,%r13
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 e4 00 00 00    	jne    0x11b
  37:	4c 89 e8             	mov    %r13,%rax
  3a:	48 c1 e8 03          	shr    $0x3,%rax
  3e:	42                   	rex.X
  3f:	0f                   	.byte 0xf


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

