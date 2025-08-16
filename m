Return-Path: <linux-kernel+bounces-771680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6CFB28A41
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 05:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5AB7583EE7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 03:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E6A1D8E1A;
	Sat, 16 Aug 2025 03:18:37 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A4A19D8A2
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 03:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755314317; cv=none; b=mhooYxqVy4OwU8XL/udefA/Kce/4KvBrAoxN9c9jN/gA3Slk8ghIVuPWHpVMiEmURRxcp/SJNjxw7yj2dHaJo10soGqT8/DO1cN2NYtNQxz9u3pKWtzrqJYU5g3AjWyDCeqv81AG5sjnJui1W/F4TJfz+/oXzbhwnO04szI0qHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755314317; c=relaxed/simple;
	bh=l7Ug0HsMeGBqp8w83bJVDxj3i9DEMYGiTaY3nxE8ozE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=vDJJpWs5xRMDOZwSKccWq85O9408Hb6dICbA6zXr+z2FGePH+fKqW2RbHS6mJBUeJjwrJy9Pkd1o9ws+EBiXV0cv3ZJuAcMhbVCVe/WP64/aCn9Aa8bF1agZMBSGfv2QyvGx5ZvjQz98nF/5Fdv57ExHtVi3BBicxw2b6xKyUos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3e570051e69so32077575ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 20:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755314313; x=1755919113;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qTS0YG+WjR/K90OTphXPqWiWegdcs5FpL33ZQpVQSSo=;
        b=OG073UIXfRDVQByACW2q8CkLYg4qRhyR1CoF0H3gj2rqjXUab4VuZc4f9yUZ4cmRVT
         U12UfVB2Bya46xck+e8zR/YHPZr64X32xSxbOY6f8MyMwNC6k5hBEJYxNSq4LyjXbaen
         a0erpMkkh3NfTsisnMFw+6LFD2rJ3I3DKdaQRGt8I9afC5fH7Rs/69iZPhlk5Bo/wqo0
         WFCHLtfqThEaYqeA4MTSaz7fnxWISNTdlCiK9OxhYwwLwEMlFSbPhEIR5L2aDfrENuU6
         jL8pNRRT2vdGlRFkL6BkrS7jMn5QneU4CRHI8RuY6PBHUDBdgydsFLRjI+JdGMcT7Qzn
         NUvA==
X-Forwarded-Encrypted: i=1; AJvYcCWclMf15KA8Ei+2YL14CEEWgUt99+4vSRZUDUruJsiOJ/70cez74iK/qWof3Uk5VAHOJGXFQQnyDefqPPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/FatmHuLImaZ+p2k5t8Waob7K9XXq4tUyLJrqKgJ31CY5ye8H
	ztI5ZKvacv0xGVCYtxXTrjdAslUoVSwZzH1c8YzXaIuTyk73r/9UnjJIWlHERC3fJ3C3GOBYzm4
	df1ngqlwNY70CpgEUPiy109D+8N82LdaaVfTsTeyM+yZ5Fl7Cpm6MFzrOJZg=
X-Google-Smtp-Source: AGHT+IHO14K/pxFu46JpzUszf2OR8j9ZNyNWhTgYR+wxmKSgPWHIr5SfnDGRc/4t7FrWSdArG/jvforGFCQ6u63+a5NRYlNsHk0F
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a85:b0:3e5:408b:b748 with SMTP id
 e9e14a558f8ab-3e57e9c1adbmr76275335ab.16.1755314313343; Fri, 15 Aug 2025
 20:18:33 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:18:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689ff889.050a0220.e29e5.0037.GAE@google.com>
Subject: [syzbot] [f2fs?] general protection fault in f2fs_check_opt_consistency
From: syzbot <syzbot+d371efea57d5aeab877b@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, lihongbo22@huawei.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	sandeen@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0e39a731820a Merge tag 'for-6.17-rc1-tag' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13344da2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13f39c6a0380a209
dashboard link: https://syzkaller.appspot.com/bug?extid=d371efea57d5aeab877b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c22c34580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a125a2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e0297ec5b8e1/disk-0e39a731.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0396bfd57e65/vmlinux-0e39a731.xz
kernel image: https://storage.googleapis.com/syzbot-assets/68482d381f43/bzImage-0e39a731.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f909676ebee0/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=15344da2580000)

The issue was bisected to:

commit d185351325237da688de006a2c579e82ea97bdfe
Author: Hongbo Li <lihongbo22@huawei.com>
Date:   Thu Jul 10 12:14:13 2025 +0000

    f2fs: separate the options parsing and options checking

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=137ca5a2580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10fca5a2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=177ca5a2580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d371efea57d5aeab877b@syzkaller.appspotmail.com
Fixes: d18535132523 ("f2fs: separate the options parsing and options checking")

F2FS-fs (loop0): f2fs_recover_fsync_data: recovery fsync data, check_only: 0
F2FS-fs (loop0): Mounted with checkpoint version = 48b305e4
Oops: gen[  107.736417][ T5848] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 5848 Comm: syz-executor263 Tainted: G        W           6.17.0-rc1-syzkaller-00014-g0e39a731820a #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:strcmp+0x3c/0xc0 lib/string.c:284
Code: 00 fc ff df 45 31 f6 4a 8d 04 37 48 89 c1 48 c1 e9 03 0f b6 0c 19 84 c9 75 2c 42 0f b6 2c 37 4a 8d 04 36 48 89 c1 48 c1 e9 03 <0f> b6 0c 19 84 c9 75 33 42 0f b6 0c 36 40 38 cd 75 48 49 ff c6 40
RSP: 0018:ffffc90004adf8f8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000021ec2c00 RSI: 0000000000000000 RDI: ffff888021ec2c80
RBP: 0000000000000066 R08: 0000000000000000 R09: 0000000000000000
R10: ffff88803d2c9768 R11: ffffed1007a592fb R12: 1ffff1100611a891
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888021ec2c80
FS:  0000555575c20480(0000) GS:ffff8881269c5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001000 CR3: 000000003d342000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 f2fs_check_quota_consistency fs/f2fs/super.c:1188 [inline]
 f2fs_check_opt_consistency+0x1378/0x2c10 fs/f2fs/super.c:1436
 __f2fs_remount fs/f2fs/super.c:2653 [inline]
 f2fs_reconfigure+0x482/0x1770 fs/f2fs/super.c:5297
 reconfigure_super+0x224/0x890 fs/super.c:1077
 do_remount fs/namespace.c:3314 [inline]
 path_mount+0xd18/0xfe0 fs/namespace.c:4112
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f13267ca259
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff3d15d4a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f13267ca259
RDX: 0000000000000000 RSI: 0000200000000040 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000200000000140 R09: 00007fff3d15d4e0
R10: 0000000000000020 R11: 0000000000000246 R12: 00007fff3d15d4e0
R13: 00007fff3d15d768 R14: 431bde82d7b634db R15: 00007f132681303b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strcmp+0x3c/0xc0 lib/string.c:284
Code: 00 fc ff df 45 31 f6 4a 8d 04 37 48 89 c1 48 c1 e9 03 0f b6 0c 19 84 c9 75 2c 42 0f b6 2c 37 4a 8d 04 36 48 89 c1 48 c1 e9 03 <0f> b6 0c 19 84 c9 75 33 42 0f b6 0c 36 40 38 cd 75 48 49 ff c6 40
RSP: 0018:ffffc90004adf8f8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000021ec2c00 RSI: 0000000000000000 RDI: ffff888021ec2c80
RBP: 0000000000000066 R08: 0000000000000000 R09: 0000000000000000
R10: ffff88803d2c9768 R11: ffffed1007a592fb R12: 1ffff1100611a891
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888021ec2c80
FS:  0000555575c20480(0000) GS:ffff8881268c5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000003d342000 CR4: 00000000003526f0
----------------
Code disassembly (best guess), 4 bytes skipped:
   0:	45 31 f6             	xor    %r14d,%r14d
   3:	4a 8d 04 37          	lea    (%rdi,%r14,1),%rax
   7:	48 89 c1             	mov    %rax,%rcx
   a:	48 c1 e9 03          	shr    $0x3,%rcx
   e:	0f b6 0c 19          	movzbl (%rcx,%rbx,1),%ecx
  12:	84 c9                	test   %cl,%cl
  14:	75 2c                	jne    0x42
  16:	42 0f b6 2c 37       	movzbl (%rdi,%r14,1),%ebp
  1b:	4a 8d 04 36          	lea    (%rsi,%r14,1),%rax
  1f:	48 89 c1             	mov    %rax,%rcx
  22:	48 c1 e9 03          	shr    $0x3,%rcx
* 26:	0f b6 0c 19          	movzbl (%rcx,%rbx,1),%ecx <-- trapping instruction
  2a:	84 c9                	test   %cl,%cl
  2c:	75 33                	jne    0x61
  2e:	42 0f b6 0c 36       	movzbl (%rsi,%r14,1),%ecx
  33:	40 38 cd             	cmp    %cl,%bpl
  36:	75 48                	jne    0x80
  38:	49 ff c6             	inc    %r14
  3b:	40                   	rex


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

