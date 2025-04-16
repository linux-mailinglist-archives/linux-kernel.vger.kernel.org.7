Return-Path: <linux-kernel+bounces-607758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C313A90A65
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 19:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F8C3BE796
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 17:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90BD217671;
	Wed, 16 Apr 2025 17:47:35 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A48207DFC
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744825655; cv=none; b=jRl9lBsQ3fsbO6oS+uP6TXszT9e8Fr79kARK9CZbTqLqLIp3foCeQYU9UExRw/mYcvv1MfIvVdOhY0aNOcmfov22GbftO/NPtJSpXIp5L9oivBc/Wp8uATZcCHRjGHi0RmbMShrIPbX0IuOetcsv3zU+Y9d/dOJxn/f5w7BfwNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744825655; c=relaxed/simple;
	bh=krYe/ACIl1WDWBGw7/244gTQLqinviWRZm+F/EAb3/E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hu9E0NK1Kg//zA1UCgVU2qoKsBMGgj9KNwI+U+KvaPJBdh05zKEQvJzMiBSoN0sO9Z4ZxtW7Xjjvuau+4+yPObkUjivh+6gNozKRJnlEmmnQMA+7IbS3GFTOCXUf+pMG1aLGIFq0BKCHRg5gwbKseURpJOYpA8tuY54/Irn0V1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d5b38276deso120403155ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 10:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744825652; x=1745430452;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0rY6iI5XOo0w4pAoyldjWxA/FfsNm/1D7YvJpyzA5g8=;
        b=DfHp6MzgBmEpHXjJb8kJUFeKGztpm855eNcJCG8b439hklRgPJ9gNPYj2tRRjoB+zG
         0EtEzelhxYfcKj2/DSo23AAGzqOfI41e10rQd9w2p70uWTsV1ZaotbOoGxDTAPK1lkwP
         ZUzNfVOins3kET+4CCCuVxR+vK7WRUKvgPAv2d8T3MJMZHkqopXHCVn/aQiC/Q2GCEp0
         pEJYeZRqYhJVtkiFwYTl/fS8uV2cJV8NiuIVMoGunJ8HzG3GYTdxANYwB+mqc9CTmx2b
         cNXSWFTBJsV5InJfcjTpyPesNljuPu3ToyjN1mbWnwfrXQ0HzETX8zna/48QHpHKj3ZK
         Phow==
X-Forwarded-Encrypted: i=1; AJvYcCX9LdYw5O9w0qm4CSUpGBoFpzkYRpjI/6M2cuZyGhRYrUqII54He48QzAchd0kozWXFbgfIfUqBjwrYlmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnSBAU4QYNsUPmIcanXOXNAGqb68fyQ+pa1CJGXltlJcQWwhyv
	CucoKRgPwXn/jDFteTZ3YOk1+IYElkTwz8VuyxIFj5P0nKBWOoh50a1HPJF9hNOD/1otrCc0d9q
	WM3rOrBWM8vuV96M9s0pL7Fhzr11jP3yFmPXzdHlIe6miKf0QlKs7MSc=
X-Google-Smtp-Source: AGHT+IHIVy19yEIWwoYMuLlDCf8L7Q2KSp0lzhVNmXerZqlYXtAyV1TgD2ycJ5rFb3groK+1M5jeILQEtSU0nboSAja8yObmu0xL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:470d:b0:3d5:8908:92d0 with SMTP id
 e9e14a558f8ab-3d815af8368mr32715445ab.3.1744825652659; Wed, 16 Apr 2025
 10:47:32 -0700 (PDT)
Date: Wed, 16 Apr 2025 10:47:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ffed34.050a0220.5cdb3.0007.GAE@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_alloc_sectors_start_trans
 (2)
From: syzbot <syzbot+2caec1f3fc52004d4f3c@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1a1d569a75f3 Merge tag 'edac_urgent_for_v6.15_rc3' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157c6470580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e30b69a28cc940e1
dashboard link: https://syzkaller.appspot.com/bug?extid=2caec1f3fc52004d4f3c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e7fecf1a4718/disk-1a1d569a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7823b994817c/vmlinux-1a1d569a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7ce169c73b39/bzImage-1a1d569a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2caec1f3fc52004d4f3c@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __writepoint_find include/linux/rcupdate.h:-1 [inline]
BUG: KMSAN: uninit-value in writepoint_find fs/bcachefs/alloc_foreground.c:1248 [inline]
BUG: KMSAN: uninit-value in bch2_alloc_sectors_start_trans+0x44a/0x32d0 fs/bcachefs/alloc_foreground.c:1348
 __writepoint_find include/linux/rcupdate.h:-1 [inline]
 writepoint_find fs/bcachefs/alloc_foreground.c:1248 [inline]
 bch2_alloc_sectors_start_trans+0x44a/0x32d0 fs/bcachefs/alloc_foreground.c:1348
 __bch2_write+0x7bd/0x6a10 fs/bcachefs/io_write.c:1494
 bch2_write+0xdfe/0x1b30 fs/bcachefs/io_write.c:1681
 closure_queue include/linux/closure.h:270 [inline]
 closure_call include/linux/closure.h:432 [inline]
 bch2_writepage_do_io fs/bcachefs/fs-io-buffered.c:494 [inline]
 bch2_writepages+0x24a/0x3c0 fs/bcachefs/fs-io-buffered.c:677
 do_writepages+0x427/0xc30 mm/page-writeback.c:2656
 __writeback_single_inode+0x103/0x1290 fs/fs-writeback.c:1680
 writeback_sb_inodes+0xac4/0x1c90 fs/fs-writeback.c:1976
 wb_writeback+0x4df/0xcb0 fs/fs-writeback.c:2156
 wb_do_writeback fs/fs-writeback.c:2303 [inline]
 wb_workfn+0x40b/0x1970 fs/fs-writeback.c:2343
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xc1d/0x1e80 kernel/workqueue.c:3319
 worker_thread+0xea3/0x1500 kernel/workqueue.c:3400
 kthread+0x6ce/0xf10 kernel/kthread.c:464
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was stored to memory at:
 bch2_writepage_io_alloc fs/bcachefs/fs-io-buffered.c:522 [inline]
 __bch2_writepage+0x3754/0x3ab0 fs/bcachefs/fs-io-buffered.c:644
 write_cache_pages+0xc9/0x280 mm/page-writeback.c:2613
 bch2_writepages+0x11f/0x3c0 fs/bcachefs/fs-io-buffered.c:675
 do_writepages+0x427/0xc30 mm/page-writeback.c:2656
 __writeback_single_inode+0x103/0x1290 fs/fs-writeback.c:1680
 writeback_sb_inodes+0xac4/0x1c90 fs/fs-writeback.c:1976
 wb_writeback+0x4df/0xcb0 fs/fs-writeback.c:2156
 wb_do_writeback fs/fs-writeback.c:2303 [inline]
 wb_workfn+0x40b/0x1970 fs/fs-writeback.c:2343
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xc1d/0x1e80 kernel/workqueue.c:3319
 worker_thread+0xea3/0x1500 kernel/workqueue.c:3400
 kthread+0x6ce/0xf10 kernel/kthread.c:464
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4157 [inline]
 slab_alloc_node mm/slub.c:4200 [inline]
 kmem_cache_alloc_lru_noprof+0x92d/0xe30 mm/slub.c:4219
 __bch2_new_inode+0x98/0x450 fs/bcachefs/fs.c:438
 __bch2_create+0x284/0x1700 fs/bcachefs/fs.c:541
 bch2_mknod fs/bcachefs/fs.c:728 [inline]
 bch2_create+0xc0/0x1d0 fs/bcachefs/fs.c:742
 lookup_open fs/namei.c:3666 [inline]
 open_last_lookups fs/namei.c:3765 [inline]
 path_openat+0x2efe/0x6280 fs/namei.c:4001
 do_filp_open+0x26b/0x610 fs/namei.c:4031
 do_sys_openat2+0x1ca/0x300 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1455
 x64_sys_call+0x1fe/0x3c80 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 3648 Comm: kworker/u8:11 Not tainted 6.15.0-rc2-syzkaller-00042-g1a1d569a75f3 #0 PREEMPT(undef) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: writeback wb_workfn (flush-bcachefs-66)
=====================================================


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

