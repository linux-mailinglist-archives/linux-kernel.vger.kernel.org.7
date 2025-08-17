Return-Path: <linux-kernel+bounces-772375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00967B291ED
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 09:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3AA9170EA0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 07:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751F023C507;
	Sun, 17 Aug 2025 07:02:34 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9760B238C0B
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 07:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755414153; cv=none; b=Kmv4dkc7qZiMbX6s3wnLdfOG2OtOUaCpAn5QnMfx4P8tW/MqCjwe7x/TQ2tWX4VuzpflmQqB59v7NwMHYkYsIW3KFLuCnAl8nhoyvT+SL47hs7X2/Mkr0oex2mKc3mf5jNgmGMX8Ep+HgHfPPzxhPMZxmsJJX/3QaFEy4gFbML4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755414153; c=relaxed/simple;
	bh=o3QLQYgeDsVb+/u/JKVr+vGOLp71D9/mQ4+k0ijL90Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NEbrwOh6UARgxtgs2pTMKDjDjteIGTjvz2SF++U5JNSqoCFVqFQ4xeAHVDmCcg3moN5bfwtygzWefty/1K4tDq6S3DqnlkwBUGM116MrzJJjagPQ7KHn6Jst9NKPs9MlT2eIT7qp/bzbQj6JzTQJIlMY0fJquZOjpt2FA7neOZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3e570090105so41200655ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 00:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755414150; x=1756018950;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7sPtWuap8m1e30xPj3NEMlKamUmbMnprbVc8MvxtxcE=;
        b=VEkrYCCGM8HKy3bonyy5XGOwOm3TVecOdq3EEaZJEKeSKvo1FOOB11ljN+nrXTMsFT
         DScHOfishSaWJrzlgUwXoke6mSEcCa6KC+J3Rznj+SoAsnElngmA3u3H9swUckR1qBkQ
         WuDoqf8KDfta8PGE2PQA6s62kaSZC4BH568QfLb3rIRPhB7K3eAT4rBHFpWjoGdjBkjE
         7rQP9QJIQRYqPQVda61sDMpTidhXMPGBw5U2CckWN0a3Fexx1zo7g2Lfay0dfmG3MHNb
         wPjcLLODYgQDgQWOlyBBFZMrj92CbV0Sz6uLOi15zVO08E57DDD0nmGhOGgzNOSLDrP6
         5FjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzbELaYP61MywtDYDoymvdGg9Iq08laNB1NnzvfYwcJR3HGt5DBDxnZFddlLvHLC3ArrjOhsYe3A/L9Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVj45kE/DNhbcZ34Qb4hnwriWldLpaAOK34M3+1r0ZL7wEVMZh
	89TjtTiHaCa+cQYLSNfHYbT8wcQ+M2c6pwcawTNMsGBQ3HAtq+W1uR1aDiaBJOfLNbmiveGhUmG
	NUoe1svXtZ6QIdBRPPfCTqDtq6HN+K4lzTug332kSzgQ3j+bmBfIJ8kvRh94=
X-Google-Smtp-Source: AGHT+IFop1XXXZ68Prwax9EQT57UkaU4kd4qm0VkORb5sw5TSk8SRsJDyVYbc5WR2+fGgwO55Z+G7JNS9LmkvK/k/OvhAmRSuNt/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4d:b0:3e5:7281:eb6c with SMTP id
 e9e14a558f8ab-3e57e9dbcd2mr148641105ab.24.1755414150588; Sun, 17 Aug 2025
 00:02:30 -0700 (PDT)
Date: Sun, 17 Aug 2025 00:02:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a17e86.050a0220.e29e5.0060.GAE@google.com>
Subject: [syzbot] [ntfs3?] kernel panic: stack is corrupted in rt_spin_lock
From: syzbot <syzbot+37fb05d692157c085e99@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    90d970cade8e Merge tag 'ata-ata-6.17-rc2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1077baf0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98e114f4eb77e551
dashboard link: https://syzkaller.appspot.com/bug?extid=37fb05d692157c085e99
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143173a2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/db659c83faa4/disk-90d970ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1d736b8a5536/vmlinux-90d970ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3ed0655ad73d/bzImage-90d970ca.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/11f86826b4f2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+37fb05d692157c085e99@syzkaller.appspotmail.com

loop0: detected capacity change f[  188.250627][ T7465] loop0: detected capacity change from 0 to 4096
ntfs3(loop0): Different NTFS sector size (1024) and media sector size (512).
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: rt_spin_lock+0x2b8/0x2c0 kernel/locking/spinlock_rt.c:-1
CPU: 1 UID: 0 PID: 7465 Comm: syz.0.701 Tainted: G        W           6.17.0-rc1-syzkaller-00211-g90d970cade8e #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x99/0x250 lib/dump_stack.c:120
 vpanic+0x281/0x750 kernel/panic.c:430
 panic+0xb9/0xc0 kernel/panic.c:566
 __stack_chk_fail+0x26/0x30 kernel/panic.c:929
 rt_spin_lock+0x2b8/0x2c0 kernel/locking/spinlock_rt.c:-1
 spin_lock_irq include/linux/spinlock_rt.h:93 [inline]
 __filemap_add_folio+0x964/0x11c0 mm/filemap.c:884
 filemap_add_folio+0xd5/0x270 mm/filemap.c:969
 do_read_cache_folio+0x1de/0x560 mm/filemap.c:3924
 do_read_cache_page mm/filemap.c:4023 [inline]
 read_cache_page+0x5d/0x170 mm/filemap.c:4032
 read_mapping_page include/linux/pagemap.h:985 [inline]
 inode_read_data+0xa7/0x480 fs/ntfs3/inode.c:1054
 ntfs_fill_super+0x39c8/0x40b0 fs/ntfs3/super.c:1533
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2805e8038a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f28054ede68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f28054edef0 RCX: 00007f2805e8038a
RDX: 00002000000000c0 RSI: 00002000000001c0 RDI: 00007f28054edeb0
RBP: 00002000000000c0 R08: 00007f28054edef0 R09: 0000000000800014
R10: 0000000000800014 R11: 0000000000000246 R12: 00002000000001c0
R13: 00007f28054edeb0 R14: 000000000001f854 R15: 00002000000004c0
 </TASK>
Kernel Offset: disabled


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

