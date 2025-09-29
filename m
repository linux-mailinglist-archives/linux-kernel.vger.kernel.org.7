Return-Path: <linux-kernel+bounces-836754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 802F0BAA79E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 21:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CAA21924109
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F2725228B;
	Mon, 29 Sep 2025 19:33:38 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2B724DCE9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759174417; cv=none; b=FFuu4mGFoyDD9cyG7on/qZgQwaUpfPp0TtLNIlIL/ze0ygZSWdoY0zWQilVSks8PFcGOY+iOMrUazdcxNPQbn6u7zzNLy1djO8F6jc6x4fkoXp1D+ijiovur+kwsfpUMoQOUMhullRxoTr2oJa0CasGau97HnapkroIa8QHL3+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759174417; c=relaxed/simple;
	bh=ZnqCTP8AsVQ7SCtFa0gLgdOUx6f6d2ov5XcMgKFFhOI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=izTmwRKfWzTg2olo66W8RjBRftJ/p8dxcgz8SCv2rQVcdKuMHNtgTZc603kn5YnXsSV2CjITiEj1vYqs1L6lnhUxDlSimbrMEpME58JvBBTEBpf78hXxgn+rtw67Rr7f0Yr4Anfem4Lf9oy7RWhzvK8p+2gWZ+AwF6msknDdfXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-42591c9fca7so57275135ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 12:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759174415; x=1759779215;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8GrA/dxNmeCNKoRCIKfSaDXkaBQWFsISbwSfBgBLiZ8=;
        b=cO1RMPrBCVLtE2jCatE2VLrI5ibICeJm30y6HQzSdrPdZM1xSAJZoc5BVtYxSmJHG/
         WXucDJN3nbdUv2Z48962A1n6cZP0pDaQyvO3BDYosahBe7/uiygu/BoKAYKVFLcZrRvJ
         7LGdAbbG/zl/uu/s4wTw4nKOgKO1gLwqTp8Xg5b5tan5JPDgTa3S//dPs8rPFGk+UCtK
         TaS+XuvDjrlDFkjwTCQquzxZM5lG/jpJY6J1cGdYbznigfi8q49OqRNpGduT9Zz5AD1I
         Ceeq9PG0NtD9+CJiX/iACGGVunbhlgCsew/HvOhtZFf7F9fQlkU87NEAwep7vvcbcneT
         kmzw==
X-Forwarded-Encrypted: i=1; AJvYcCWRB7tSIzcfl7xQBj19YwDfaEnZIYkiBUl+hzJTN3zScWTTgs/Q7tVO+9ILVVafLzoMNJSWSScgcrx3Z1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+quLYHnqIR/CFOIyc2skStbskEXd9kz9vJPimv7STlLmeacXe
	ZO6csEE2MQVYY7YkrhugrejugTVJOYm191B5KpWDxp8f5Qq14GQWLHxpDCHRq2myv5R5QyC7ELG
	qACTssdE+PKwb4RrmoPASQ15X4CggYkSn5nPkXNdNNNmz6b7It0w8t5m92QM=
X-Google-Smtp-Source: AGHT+IG/ZuGyC0whfkXft9y1iVjwscYzOZ6qkOU7Ohgx6BuMWXQEwT9VY5IGEOzlFq5MUmmk0n1PFlUZWA6+1UtZDegaTkY8HK1U
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c262:0:b0:42a:7339:94a3 with SMTP id
 e9e14a558f8ab-42a7348dce0mr77929405ab.1.1759174414939; Mon, 29 Sep 2025
 12:33:34 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:33:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dadf0e.050a0220.1696c6.001d.GAE@google.com>
Subject: [syzbot] [f2fs?] WARNING in f2fs_delete_entry (2)
From: syzbot <syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2213e57a69f0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12a822e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=714d45b6135c308e
dashboard link: https://syzkaller.appspot.com/bug?extid=c07d47c7bc68f47b9083
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1341fce2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144ddd34580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bf4625d47a8f/disk-2213e57a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/270abffcbf3c/vmlinux-2213e57a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1f0f6eb3e385/Image-2213e57a.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2f5997142143/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=135f62e2580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6642 at fs/inode.c:417 drop_nlink+0xe4/0x138 fs/inode.c:417
Modules linked in:
CPU: 0 UID: 0 PID: 6642 Comm: syz-executor Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:417
lr : drop_nlink+0xe4/0x138 fs/inode.c:417
sp : ffff8000a54b79a0
x29: ffff8000a54b79a0 x28: dfff800000000000 x27: ffff0000efc5d000
x26: dfff800000000000 x25: 0000000200000000 x24: 0000000000000000
x23: 1fffe0001d284485 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000e9422428 x19: ffff0000e94223e0 x18: 0000000000000000
x17: 0000000000000000 x16: ffff8000805379bc x15: 0000000000000001
x14: 1fffe0001bd69171 x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001bd69172 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000cdeb8000 x7 : ffff8000826e1b78 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800080537ac4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:417 (P)
 f2fs_i_links_write fs/f2fs/f2fs.h:3233 [inline]
 f2fs_drop_nlink+0x104/0x2e8 fs/f2fs/dir.c:849
 f2fs_delete_entry+0x740/0x9a8 fs/f2fs/dir.c:911
 f2fs_unlink+0x344/0xa3c fs/f2fs/namei.c:590
 f2fs_rmdir+0x5c/0x7c fs/f2fs/namei.c:755
 vfs_rmdir+0x328/0x464 fs/namei.c:4461
 do_rmdir+0x214/0x4c4 fs/namei.c:4516
 __do_sys_unlinkat fs/namei.c:4690 [inline]
 __se_sys_unlinkat fs/namei.c:4684 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4684
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:763
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
irq event stamp: 143176
hardirqs last  enabled at (143175): [<ffff8000806302f8>] seqcount_lockdep_reader_access+0x80/0x104 include/linux/seqlock.h:74
hardirqs last disabled at (143176): [<ffff80008b01a2c4>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:434
softirqs last  enabled at (142090): [<ffff800080201608>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (142088): [<ffff8000802015d4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
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

