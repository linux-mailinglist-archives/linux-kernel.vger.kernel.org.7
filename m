Return-Path: <linux-kernel+bounces-765621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46384B23B65
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 23:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F7A582A61
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54682E1C57;
	Tue, 12 Aug 2025 21:56:39 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D59A2DAFB9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755035799; cv=none; b=rLxGZ7ruNLXfYFiZ0IBOPgcm3XemtJKtyu30AQ/S/Bt8eYq0kzD/1ZA2TGkapAi7HPZjYeHIRD6FFxpfC9BMSKfCgUrFg1YzV+zN+OEMqZS+y7Yl9JgPsQ2SYsCVEq/RLpQbLzHFaTXDtOSChcccnOQ6Rk3cDsUNX9Ezpuh1l+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755035799; c=relaxed/simple;
	bh=jFfN1oc+P2s+Q1s8kvrqd2kGCk0engEME9GdqmW8tgk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DtgMUyznXlQIO9PrV1WxCcc0WK7z6D9rXAnWqu14wlb7VYK1JlzU7WYkxkVhUclVLjjjL8XtSaykMNi+lgT3peWSUKiHPx77kdiAk4u1Wvv7vOKFpoanbGLcLXV6+KMzX7tmVSXp5yKnn+EvGk+c4l11eN6eYCPh9kvdDv/vb1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-884030b4235so634426239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755035795; x=1755640595;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s948BEEvRcc/uArh6KDeaDqAh8A68ZPiEwhKz7MmlQ4=;
        b=hI+Mn4My/txSMsdLE1ezaivtHnPsnrSwDOlx/IbDMhFqV+LIe493HX/VtIIWYa0a1d
         am2fvyZaFGcS9o5tjCp2iqySLOnlzbt/ZKoKmbMKcMxyl/mEmQ5JtUskaG83rXcGPd2n
         rtpj4/uQZYNOxNQQaqtNjBSxnQla9XiyRpzy3g8u30HdPcfggUpB3tb/IQjmzz+ZdjHf
         o8YmqhXmGzwGoYwhkRKBc1XEi046gy0xYXV3+PvFqOf2Kotj9121H+zz1v/3HvTerBjf
         a6WMj+uU5ncIlrhch0OS4wUCTMe7tTEJFty2PPTxJpG0vHGiKYSFigZwp6pdez78/aUb
         fCXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/nFX2kGIwy2d2Mx9ZuNBRC88IBoQrlMbxzhyh6Cx1EsIfT2AmG371yylo2THKMV1PxSmQp0MLe/mVHGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxuXCclML7RTr/rFMJDr5NVLuG5apGckOOtfGbRmuXULuJTwXv
	Xw9cjdf/WcHDPq9OYMmEDbVKLSPkUZO/mGNUK/AiA0V97QVzeQCIVpsAy2480AIVJaTTx4sp1it
	8hfS3td6TTR5Kc0abtu2lKI+jf2yc5mf2HK3ZAIj4iD0E+OQu4M6Tjo53t7A=
X-Google-Smtp-Source: AGHT+IGKRhGHEcoOe7azehPWKa/W0V5pGAhIBJ65HDvvFACzwf6m1h82XEXRxgPfULCYJ+PS/kEbQSqCAZaHeZAcG1WRYUk33JFf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:e709:0:b0:873:1c2d:18e7 with SMTP id
 ca18e2360f4ac-88429689784mr108620539f.10.1755035795654; Tue, 12 Aug 2025
 14:56:35 -0700 (PDT)
Date: Tue, 12 Aug 2025 14:56:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689bb893.050a0220.7f033.013b.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in alloc_frozen_pages_noprof
From: syzbot <syzbot+3f9768ec54c86997ddfb@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com, 
	rakie.kim@sk.com, syzkaller-bugs@googlegroups.com, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1568cc34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
dashboard link: https://syzkaller.appspot.com/bug?extid=3f9768ec54c86997ddfb
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132b19a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164da842580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/18a2e4bd0c4a/disk-8f5ae30d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3b5395881b25/vmlinux-8f5ae30d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e875f4e3b7ff/Image-8f5ae30d.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f9768ec54c86997ddfb@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6777 at mm/page_alloc.c:5124 __alloc_frozen_pages_noprof+0xd0/0x318 mm/page_alloc.c:5124
Modules linked in:
CPU: 1 UID: 0 PID: 6777 Comm: syz.0.17 Not tainted 6.17.0-rc1-syzkaller-g8f5ae30d69d7 #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/18/2025
pstate: 23400005 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : __alloc_frozen_pages_noprof+0xd0/0x318 mm/page_alloc.c:5124
lr : __alloc_frozen_pages_noprof+0xac/0x318 mm/page_alloc.c:5118
sp : ffff8000a3d575e0
x29: ffff8000a3d576b0 x28: 1fffe00018f73d00 x27: ffff8000a3d57980
x26: 1ffff00012eb431c x25: dfff800000000000 x24: ffff8000a3d57600
x23: ffff7000147aaec0 x22: 0000000000000000 x21: 0000000000040d40
x20: 0000000000000000 x19: 0000000000000024 x18: 1fffe000337a0688
x17: ffff0001fea8c8b0 x16: ffff80008af6de48 x15: 0000000000000005
x14: 1ffff000147aaec4 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7000147aaec9 x10: dfff800000000000 x9 : 0000000000000001
x8 : ffff800092df4000 x7 : 0000000000000000 x6 : ffff8000802312a4
x5 : ffff0000c7b3db38 x4 : 0000000000000000 x3 : 0000000000000020
x2 : 0000000000000008 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 __alloc_frozen_pages_noprof+0xd0/0x318 mm/page_alloc.c:5124 (P)
 alloc_pages_mpol+0x1e4/0x460 mm/mempolicy.c:2416
 alloc_frozen_pages_noprof+0xe0/0x210 mm/mempolicy.c:2487
 ___kmalloc_large_node+0xac/0x154 mm/slub.c:4306
 __kmalloc_large_node_noprof+0x2c/0x8c mm/slub.c:4337
 __do_kmalloc_node mm/slub.c:4353 [inline]
 __kmalloc_noprof+0x3bc/0x4c8 mm/slub.c:4377
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 v9fs_fid_get_acl+0x64/0x114 fs/9p/acl.c:32
 __v9fs_get_acl fs/9p/acl.c:66 [inline]
 v9fs_get_acl+0xa8/0x3ac fs/9p/acl.c:92
 v9fs_qid_iget_dotl fs/9p/vfs_inode_dotl.c:131 [inline]
 v9fs_inode_from_fid_dotl+0x1d8/0x26c fs/9p/vfs_inode_dotl.c:154
 v9fs_get_new_inode_from_fid fs/9p/v9fs.h:251 [inline]
 v9fs_mount+0x5b8/0x910 fs/9p/vfs_super.c:144
 legacy_get_tree+0xd4/0x16c fs/fs_context.c:666
 vfs_get_tree+0x90/0x28c fs/super.c:1815
 do_new_mount+0x278/0x7f4 fs/namespace.c:3805
 path_mount+0x5b4/0xde0 fs/namespace.c:4120
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount fs/namespace.c:4321 [inline]
 __arm64_sys_mount+0x3e8/0x468 fs/namespace.c:4321
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
irq event stamp: 3156
hardirqs last  enabled at (3155): [<ffff800080c6f5fc>] kasan_quarantine_put+0x1a0/0x1c8 mm/kasan/quarantine.c:234
hardirqs last disabled at (3156): [<ffff80008b001bfc>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (2974): [<ffff800080aab748>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (2974): [<ffff800080aab748>] bdi_register_va+0x534/0x7e4 mm/backing-dev.c:1114
softirqs last disabled at (2972): [<ffff800080aab534>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (2972): [<ffff800080aab534>] bdi_register_va+0x320/0x7e4 mm/backing-dev.c:1104
---[ end trace 0000000000000000 ]---


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

