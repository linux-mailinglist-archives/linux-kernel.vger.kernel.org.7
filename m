Return-Path: <linux-kernel+bounces-821774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CC2B8236D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC741B20406
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37FF3128D9;
	Wed, 17 Sep 2025 22:55:32 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DD13128C7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758149732; cv=none; b=cnM3YJIJXNNYkPkdsHJrIWe/T6vQnevRai2fm3GnX8UJmzuPBVHTjdXjyybhE6ZrMSv3Gs1ZvOHc+vsuILz16rz41FiBb7Jt13kLfqzT4AR22M4Q8BmJwIhcNgYj36RLirZ3Yxh8XzzNbqHoWD8NEWfr8LpT7/foVdPyhaT51tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758149732; c=relaxed/simple;
	bh=3jhBY7+wsKj1bBkVc3VxmlYrH/ct5bxfP9wsQ936tHg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ntid/ew5ZOi5tUE1C/BqFIy4XyxtDpy/paJ2BoZs8h95aJcqciATIoPXPwMVzfhZCE7PmXw2dSXgBU9QEX2wviBDOg2zJS5rDUrRm1pOIgPrBapVbSM7UV9ZjvGD/5MHCx9fFlbxAgqypfJP7wPsY7MZKLX5qH18zs13LJPD+Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-424395c6ad3so3442425ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758149730; x=1758754530;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vyy3BaSjUaRB27lkP3rDudjHOfOhxLUWwF9tjiXX6xw=;
        b=hqsokOdPW+/KvIcch3WgtkVZVwor76+2nhLvceWAdO2uhijQb6BSCGbPs+VtQLWcAp
         KASzE2m81Uy7OrYsrVZ24mqBm1SzmqOH4bmpLqpMX1kceE46K5iIC7mzsZocdWnh3TTg
         9iHfMqOyI5HzcZzeuNb3uzJ7XYq0oJIbyImSfTdtIeQw9xXn5scsQnnIXW3UR7zh6cMF
         pdJJq+9s/MpGgnheKX18oflGI4qzWOTlr7oqd0TeLrYIpJd1VrBQ5t+xhjIrbMm8C1Pq
         Y0NcnShk+fKPo/4UTKG4Dkvs9qK+gyxKnbiZue57u4g4m6nUcAUIt9BstBTmooRLMRKD
         L1BA==
X-Forwarded-Encrypted: i=1; AJvYcCVJi26c3b8CBmlSSsXk9ToVMxH/4jNV0kHRPolJwedLC/0hPkmW7WrCW4K6UjtpUmSmVcrb4hI9yVNIFyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+6hqseb/Jwe1t6OwTH9tV78uA4QEsDg/PPbNEOHAVmR+9LHxy
	kuWnd97f1sFwH3KKbKbvEVY3JnmmyVIPsBEdsWW1lXZrUpOlW9N6sC0FoFh8LMt7hWhy1zfRlyT
	l8A0qJX0iUWWePr6vNcRxzvVpg/NAXrcj9zutTpIbzhsH+ZFRYBukYnowzDc=
X-Google-Smtp-Source: AGHT+IGuYh75Y60zj7Y/gHFM/I67F7Vl1AwrWJRBeRODoKjYWT1WvezaqxPPx54gfsrIG1iuHQ8PWhCQYzwZLiHytsAIskMPspqP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c245:0:b0:424:64c:5b5a with SMTP id
 e9e14a558f8ab-4241a412e23mr46960825ab.0.1758149730125; Wed, 17 Sep 2025
 15:55:30 -0700 (PDT)
Date: Wed, 17 Sep 2025 15:55:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cb3c62.050a0220.50883.002b.GAE@google.com>
Subject: [syzbot] [ntfs3?] KMSAN: uninit-value in ntfs_read_hdr (3)
From: syzbot <syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5aca7966d2a7 Merge tag 'perf-tools-fixes-for-v6.17-2025-09..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12998c7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b093ccee5a9e08c
dashboard link: https://syzkaller.appspot.com/bug?extid=332bd4e9d148f11a87dc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ccc534580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16998c7c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7dcf9f15bc6a/disk-5aca7966.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8836a30085d9/vmlinux-5aca7966.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b00f10dc0558/bzImage-5aca7966.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/78b7a2febda1/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ntfs_dir_emit fs/ntfs3/dir.c:335 [inline]
BUG: KMSAN: uninit-value in ntfs_read_hdr+0xfcc/0x13e0 fs/ntfs3/dir.c:385
 ntfs_dir_emit fs/ntfs3/dir.c:335 [inline]
 ntfs_read_hdr+0xfcc/0x13e0 fs/ntfs3/dir.c:385
 ntfs_readdir+0xf21/0x1a30 fs/ntfs3/dir.c:496
 iterate_dir+0x452/0x620 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:410 [inline]
 __se_sys_getdents64+0x17e/0x550 fs/readdir.c:396
 __x64_sys_getdents64+0x97/0xe0 fs/readdir.c:396
 x64_sys_call+0x3a14/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:218
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 ntfs_write_bh+0x6ae/0xe90 fs/ntfs3/fsntfs.c:1430
 indx_write fs/ntfs3/index.c:1027 [inline]
 indx_insert_into_buffer+0x287/0x2010 fs/ntfs3/index.c:1809
 indx_insert_entry+0xcde/0x1050 fs/ntfs3/index.c:1986
 ni_add_name+0xef7/0x11e0 fs/ntfs3/frecord.c:2995
 ntfs_link_inode+0x221/0x350 fs/ntfs3/inode.c:1728
 ntfs_link+0x20e/0x500 fs/ntfs3/namei.c:146
 vfs_link+0x8eb/0xb30 fs/namei.c:4854
 do_linkat+0x4af/0x1040 fs/namei.c:4924
 __do_sys_link fs/namei.c:4958 [inline]
 __se_sys_link fs/namei.c:4956 [inline]
 __x64_sys_link+0xd7/0x140 fs/namei.c:4956
 x64_sys_call+0x162f/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:87
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 hdr_insert_de+0x4c8/0x550 fs/ntfs3/index.c:838
 indx_insert_into_buffer+0x1b6/0x2010 fs/ntfs3/index.c:1805
 indx_insert_entry+0xcde/0x1050 fs/ntfs3/index.c:1986
 ni_add_name+0xef7/0x11e0 fs/ntfs3/frecord.c:2995
 ntfs_link_inode+0x221/0x350 fs/ntfs3/inode.c:1728
 ntfs_link+0x20e/0x500 fs/ntfs3/namei.c:146
 vfs_link+0x8eb/0xb30 fs/namei.c:4854
 do_linkat+0x4af/0x1040 fs/namei.c:4924
 __do_sys_link fs/namei.c:4958 [inline]
 __se_sys_link fs/namei.c:4956 [inline]
 __x64_sys_link+0xd7/0x140 fs/namei.c:4956
 x64_sys_call+0x162f/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:87
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4197 [inline]
 slab_alloc_node mm/slub.c:4240 [inline]
 kmem_cache_alloc_noprof+0x81b/0xec0 mm/slub.c:4247
 ntfs_link_inode+0x90/0x350 fs/ntfs3/inode.c:1716
 ntfs_link+0x20e/0x500 fs/ntfs3/namei.c:146
 vfs_link+0x8eb/0xb30 fs/namei.c:4854
 do_linkat+0x4af/0x1040 fs/namei.c:4924
 __do_sys_link fs/namei.c:4958 [inline]
 __se_sys_link fs/namei.c:4956 [inline]
 __x64_sys_link+0xd7/0x140 fs/namei.c:4956
 x64_sys_call+0x162f/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:87
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5963 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(none) 
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

