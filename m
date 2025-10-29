Return-Path: <linux-kernel+bounces-874913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EF8C177D6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDFDF4E53DC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527E11EB5C2;
	Wed, 29 Oct 2025 00:12:36 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A33F3594A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696755; cv=none; b=eI4QcI4gWrc2rM22St4NPY4u1Xje7H0e+jv8OS53gyKrRXTAbeCRSRUsm5MFbAPrWqTdaElkX92FCHfJPdCKKnTl7cOUxcrjlnUA+HFnFOt9hkOy0sOk7IM38EMsrVFAFnaMk6Fs5G9Xv1GlePtyjICsJ884dr2CReSee6kYgUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696755; c=relaxed/simple;
	bh=TxfJzeeOtsA3FbdScXC6349w3nXdDKVZ6VLrHuHk3n4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=W3EU7mjbvUqbgTTobkIFlFuTssOCdvq4ohwgnLycL+TEUZuzOEB1sybhx8HPXEshwBV1lUe1pOATdS+Aq8EHRMaj25/rZw9Spf0v/55Xb1C11aRpsnhvm9qMn7I61eQe+Jfmtq/i4ylJnWBMkpSS3u+2m829nmrJIi+TktqvgWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-431d84fdb91so191798955ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761696753; x=1762301553;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KYH0Lf0zECdAJVsig9Ez1BWRZSVB36LCUHGY+aZ6ReA=;
        b=oeO68VTbwpP6basl+mtE1WMpjmXyQrXEr3rLq8Oz6dA9+G7KbLlMLqOvgHzOR6vxuF
         ZhD3IfxvqN17UxW36vOQLTRek2CTKVeVMiPQ0JJSmProlRRvVaLUGJH/f+Oiick6r1iG
         vsbALinUMQvLxepKf7PBnlGOFzdcCwm54JGXKV9qgrNxmAk41m6lk1UNBYue7byRc4JJ
         39msMW4lFLgzJMQm9QdyYPKv1OPK3ZdtTEz2rd+tGc0XP7Vm2hx8aIRaYfuJcxZzVe/v
         Pn9MdC8wv6jX5oyXIQsgUmgDsnOCTiS6K82n6QEaB3kOa9aRyhFe5YwZUXswWAdMCm04
         ftPg==
X-Forwarded-Encrypted: i=1; AJvYcCVH3ENBMhNf9y52gE5exGPdVjZHGuMkknACqLnvCzFGoSuWqfqNmeQX1B3NAVZhvoZff3kDScKlMMo+Sgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyISW3j+4+l1tHnHdFFUSEBasAJIZQCc7Hhfe1OoOM9RZIJ8LMy
	agrlmhwvlU7UXtmEQcWrt1DaOZtHSeZnWWojhdv4CLpnSPKMGknsHBn9A/LCa/VU71Cbwu+1ihE
	C9eI1Aft4SDkrxQMP+7ZrS7r9+g/L4Uk9VlCtK0vGwC+RfsqsQAYgILodP+4=
X-Google-Smtp-Source: AGHT+IGVJXZC0Ra5LNTx5+cgnwJVeBORWoEgpnGTfQdjWrHe9773cpQX4lgXsDhBEx6hvLkr3H95abs9LgrHjpdYsJLcbhVcAlmo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4602:b0:430:b32d:c1a1 with SMTP id
 e9e14a558f8ab-432f8f87244mr16541865ab.7.1761696753493; Tue, 28 Oct 2025
 17:12:33 -0700 (PDT)
Date: Tue, 28 Oct 2025 17:12:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69015bf1.050a0220.3344a1.03f7.GAE@google.com>
Subject: [syzbot] [ntfs3?] WARNING in ntfs_put_super
From: syzbot <syzbot+cc433e4cd6d54736bf80@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f7d2388eeec2 Add linux-next specific files for 20251028
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12169f34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ecdce5bceba74f
dashboard link: https://syzkaller.appspot.com/bug?extid=cc433e4cd6d54736bf80
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dedfe2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15eaf614580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8aa0aaa475d1/disk-f7d2388e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fc97cba5a8b0/vmlinux-f7d2388e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/30e4617d837c/bzImage-f7d2388e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4f46697dcc18/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cc433e4cd6d54736bf80@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: mm/slub.c:6752 at free_large_kmalloc+0x15c/0x1f0 mm/slub.c:6752, CPU#1: syz-executor/5941
Modules linked in:
CPU: 1 UID: 0 PID: 5941 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:free_large_kmalloc+0x15c/0x1f0 mm/slub.c:6752
Code: 44 89 f6 e8 16 d1 fc ff 65 48 8b 05 1e c3 57 10 48 3b 44 24 08 75 57 48 83 c4 10 5b 41 5c 41 5e 41 5f 5d e9 86 7b 3b 09 cc 90 <0f> 0b 90 65 48 8b 05 f9 c2 57 10 48 3b 44 24 08 75 32 48 89 df 48
RSP: 0018:ffffc900037ffc88 EFLAGS: 00010206
RAX: 00000000ff000000 RBX: ffffea0000389440 RCX: ffffea0000389448
RDX: 0000000000000000 RSI: ffffffff8e251920 RDI: ffffea0000389440
RBP: 1ffff1100f55d143 R08: ffffffff8f7d5a77 R09: 1ffffffff1efab4e
R10: dffffc0000000000 R11: fffffbfff1efab4f R12: 1ffff1100f55d136
R13: dffffc0000000000 R14: ffff88807aae89b0 R15: ffff8880793b0ec8
FS:  000055557fea9500(0000) GS:ffff888125feb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055557fec45c8 CR3: 0000000029608000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ntfs_put_super+0x15b/0x1b0 fs/ntfs3/super.c:708
 generic_shutdown_super+0x135/0x2c0 fs/super.c:642
 kill_block_super+0x44/0x90 fs/super.c:1722
 ntfs3_kill_sb+0x44/0x1b0 fs/ntfs3/super.c:1847
 deactivate_locked_super+0xbc/0x130 fs/super.c:473
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1327
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2e3c7902f7
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffcc218b908 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f2e3c811d7d RCX: 00007f2e3c7902f7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffcc218b9c0
RBP: 00007ffcc218b9c0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffcc218ca50
R13: 00007f2e3c811d7d R14: 0000000000019cb4 R15: 00007ffcc218ca90
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

