Return-Path: <linux-kernel+bounces-823125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8145DB8596F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D466A587165
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6360330C63A;
	Thu, 18 Sep 2025 15:24:36 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D33155A25
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209076; cv=none; b=PNKKFx3S3lUKn423f8v59pUvY4Gv5HFH41shKOp5auqWnlGaYSu4qNnSzkIc+ZSTc4ooNjSL900myDbuhmf+IIcW1/jkQ5x0EY81drgaCa76lYumYv46HtUh8dqskaadrHx/ALgdRBGHugnBnRz/78paGnfAS4G37uDf/gDL6ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209076; c=relaxed/simple;
	bh=d8HB8EbxDjzEOd+WvUpdBYcLoAPVFdf86iSFac+icys=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uaLGEPrf4hwDQtN4lzi0Spx9JxhM5/bIS+g3Lkctt1vQGAt4IE+YXg461sZHeZiHwkL+sq8v38biAuWsHkQEMqC6DxuwPsO8S1pGKjvA5Z8jnza7iT7TPdXhkmN42ZpKn1gjpAxz9xo1LlHY5nKIJKBuNXsddb5PCb0xS19rQGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-42408b5749aso30920165ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758209073; x=1758813873;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oxe4BRn3UgndFd3J4kssfioKhp/GJ3w0+JbW61RAXLU=;
        b=vrxJVgry2kYf11DLhMiAwqNCYLOKMCscNr8XLKAAUD7l6VdsIeMzi6/LDhbS8cM6df
         /RdV9pROVqQfTQy7dZ9RihoW6vIdJpyH4Pp5URLLXx+Qi1eby78u+qkJRazRMCxVQ8uP
         iy6DDRuiKuWdnBsoXVwT5tLZZXgSCt6/Ujz0F9QVzEysSj+Id/ysttLBQvaR7UXT7a3s
         LqgIRuq9m381/ujBaxfYW/YFWzQSgyRD9vr/+5WL34B2EO1c2NSRuU3YvT7lgiQSlNIr
         3ZlSZQB6WSntfhingj/iC2KdX0fIX6CPbpz15D0q1pqovcVB5xoDFA84MFo8YrnC3law
         3SvA==
X-Gm-Message-State: AOJu0Yy0rjmivOInDcOLf44pU8Qyiq7l/WbqbSggnYf1YMPwVitdqHxY
	sR+MtXIZQxe39lk4R21/U0fKxhx57JqFCMCCLxZUh5AQQqNEjAfEWQEv02yZ5w87vWnJZscGCmr
	tc7otNe3VlUf9kdm9+eVUviRXadFcSLOB/f1cvi8Q+sFUFaVkDOInEQjJpzNSFA==
X-Google-Smtp-Source: AGHT+IE8WM53hWy0oqz/VYR4QGzPnqskIxMuWOVNWMwyXhPCfRZ7OINoYzE0Mcyb3ouXqCbKFdHRClcMg6cUP4k3Ab1OztMjvnlS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2187:b0:424:7128:a06a with SMTP id
 e9e14a558f8ab-42481724fb3mr1383585ab.7.1758209073258; Thu, 18 Sep 2025
 08:24:33 -0700 (PDT)
Date: Thu, 18 Sep 2025 08:24:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cc2431.050a0220.139b6.0001.GAE@google.com>
Subject: [syzbot] [squashfs?] KMSAN: uninit-value in squashfs_get_parent
From: syzbot <syzbot+157bdef5cf596ad0da2c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, phillip@squashfs.org.uk, 
	squashfs-devel@lists.sourceforge.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d4b779985a6c Merge tag 'for-6.17/dm-fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f35f62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b093ccee5a9e08c
dashboard link: https://syzkaller.appspot.com/bug?extid=157bdef5cf596ad0da2c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11eb8712580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f35f62580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dfaa51c15f16/disk-d4b77998.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b0cba4bd6519/vmlinux-d4b77998.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6d7ca6f9de66/bzImage-d4b77998.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/adb7ed65b055/mount_4.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/93757edce8f3/mount_7.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=10f9ef62580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+157bdef5cf596ad0da2c@syzkaller.appspotmail.com

loop2: detected capacity change from 0 to 8
=====================================================
BUG: KMSAN: uninit-value in squashfs_inode_lookup fs/squashfs/export.c:50 [inline]
BUG: KMSAN: uninit-value in squashfs_export_iget fs/squashfs/export.c:74 [inline]
BUG: KMSAN: uninit-value in squashfs_get_parent+0x3e9/0x540 fs/squashfs/export.c:108
 squashfs_inode_lookup fs/squashfs/export.c:50 [inline]
 squashfs_export_iget fs/squashfs/export.c:74 [inline]
 squashfs_get_parent+0x3e9/0x540 fs/squashfs/export.c:108
 reconnect_one fs/exportfs/expfs.c:130 [inline]
 reconnect_path+0x305/0xd30 fs/exportfs/expfs.c:220
 exportfs_decode_fh_raw+0x8bf/0xef0 fs/exportfs/expfs.c:535
 do_handle_to_path+0xe5/0x310 fs/fhandle.c:270
 handle_to_path fs/fhandle.c:394 [inline]
 do_handle_open+0xcb4/0x1220 fs/fhandle.c:409
 __do_sys_open_by_handle_at fs/fhandle.c:449 [inline]
 __se_sys_open_by_handle_at fs/fhandle.c:440 [inline]
 __x64_sys_open_by_handle_at+0xa6/0x100 fs/fhandle.c:440
 x64_sys_call+0x2f60/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:305
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_frozen_pages_noprof+0x689/0xf00 mm/page_alloc.c:5171
 alloc_pages_mpol+0x328/0x860 mm/mempolicy.c:2416
 alloc_frozen_pages_noprof+0xf7/0x200 mm/mempolicy.c:2487
 alloc_slab_page mm/slub.c:2492 [inline]
 allocate_slab+0x24d/0x1220 mm/slub.c:2660
 new_slab mm/slub.c:2714 [inline]
 ___slab_alloc+0xff3/0x3470 mm/slub.c:3901
 __slab_alloc mm/slub.c:3992 [inline]
 __slab_alloc_node mm/slub.c:4067 [inline]
 slab_alloc_node mm/slub.c:4228 [inline]
 kmem_cache_alloc_lru_noprof+0x922/0xed0 mm/slub.c:4259
 squashfs_alloc_inode+0x5a/0xd0 fs/squashfs/super.c:673
 alloc_inode+0x8a/0x4a0 fs/inode.c:346
 new_inode+0x39/0x460 fs/inode.c:1145
 squashfs_fill_super+0x218c/0x3670 fs/squashfs/super.c:339
 get_tree_bdev_flags+0x6e3/0x920 fs/super.c:1692
 get_tree_bdev+0x38/0x50 fs/super.c:1715
 squashfs_get_tree+0x35/0x40 fs/squashfs/super.c:493
 vfs_get_tree+0xb0/0x5c0 fs/super.c:1815
 do_new_mount+0x733/0x1420 fs/namespace.c:3808
 path_mount+0x6db/0x1e90 fs/namespace.c:4123
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount+0x6eb/0x7d0 fs/namespace.c:4324
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4324
 x64_sys_call+0x3604/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 6220 Comm: syz.2.23 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
=====================================================


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

