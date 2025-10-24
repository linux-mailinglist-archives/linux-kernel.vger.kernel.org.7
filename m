Return-Path: <linux-kernel+bounces-869596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47C2C0845F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA124008CE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C74330DD11;
	Fri, 24 Oct 2025 23:10:32 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2772BF011
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761347431; cv=none; b=YhoXOHMBlvcboYAHgme/y81AZZHKh8g3uHQNk+2kqnrxapH3FO2gyZ921XYMjQSDfCkOfgxp1euONxN4KJP9tC8a9S5HQxmqchFAI68eq56hPmUYxnfZf3jCa3ZQNErGByc6I9RUU2zLYnGJrpeSIPctTmwBem1UmrB+Z2Ye0V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761347431; c=relaxed/simple;
	bh=85zQ6pLcbwmSZx4a8k2vxQAcSt4fPepqOnFXbmD4N+o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=N6NT4vNlRfZG4AuxFGeOTTdWHwp8fan8VR7a8OOp2p8YnKzEOl/n0SbLU0rMQrKTLAZMmWDAT5+RBpiDcCNTiRM0bEwHBFwl5wjuunUrTZW1j8u37IqH7H1H92NlFuYeJ/wo7jlOWjZ8KbOhA6Nf/o7vNtsrgJL6qw04RwUT2V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-430bee303f7so81191255ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761347429; x=1761952229;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IlIuR3X0nrtvfUiUN21ygHmaxQ5tdscIVZLWnjwUXYQ=;
        b=AQNjU7e5dkpRMhvHLlED2/zXZDeZjXqYAHCJw5oE9wbeCSIeZrqJS+BQejE6qNar4u
         srbPPu0gcPl12y99Ubp//EC9zR0gOJxioJXDRbkOwMl/CyT/s6Rz6Dqx02C0CR0T004A
         C8PFLQx602dmpOiqLZiWiYerp724RWmT+K5hQqaHLRkuQZ83SDXD2y+PZBbaiinxQaDw
         P9TBpPshy8bcP6WAXYajYPXQbgyx+TBElgAsLwpPKKn1NcqeQbnpmhadcK05fGnqthNx
         Z8WrfK/X4VH8fs5mjXSex1e4cwHS8fAX+cvfci69LtVFYYuiktcY6Tdkj4X6gYAErHRk
         rXfg==
X-Forwarded-Encrypted: i=1; AJvYcCXYiNenLFd/ZTkCCI3vwo7DPnsc+7lqncIl+Ys7SL+EMF6wXsUCuqmQz4BmMtPOVVd4NbSwrAW06MeYp0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx07VN1M1AyuuWS/63f0t5QZBapkh4nRfm2eBMmjsKWyx98z+r2
	LEsfrF8yKlnzeAR/22rksZe07U8cGfi3YzsCAg1ildcmQMd2fSFUnP9qJS5fwMfaUzvoQwm4KeL
	yX5G2I+7AKBjTC/uQvhMPJEHMeqyTdZZTiGNspxUhSyeEiVafg/seS//u7Lc=
X-Google-Smtp-Source: AGHT+IGgEKrhluaVSzpaO+kfU1FgofZUesjyDCWFOB39EWfVdDS/A8NL2rxm5Oeuoydi794RbuRicwSsz0LjuGhzOBZl+Zoqqte2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc6:b0:430:a65c:d7ce with SMTP id
 e9e14a558f8ab-430c527e505mr237770545ab.22.1761347429479; Fri, 24 Oct 2025
 16:10:29 -0700 (PDT)
Date: Fri, 24 Oct 2025 16:10:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fc0765.a00a0220.9662e.000e.GAE@google.com>
Subject: [syzbot] [f2fs?] WARNING in get_data
From: syzbot <syzbot+f5d91b1897d5b094c6b4@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mchehab@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    72fb0170ef1f Add linux-next specific files for 20251024
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13eb2d2f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e812d103f45aa955
dashboard link: https://syzkaller.appspot.com/bug?extid=f5d91b1897d5b094c6b4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fc3b04580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/be1fa3d1f761/disk-72fb0170.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/57302bf7af40/vmlinux-72fb0170.xz
kernel image: https://storage.googleapis.com/syzbot-assets/91c806bb2a2b/bzImage-72fb0170.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f5d91b1897d5b094c6b4@syzkaller.appspotmail.com

vivid-000: DV Timings: 640x480p59 inactive
vivid-000: DV Timings Aspect Ratio: Source Width x Height
vivid-000: Maximum EDID Blocks: 2
vivid-000: Limited RGB Range (16-235): false
vivid-000: Rx RGB Quantization Range: Automatic
------------[ cut here ]------------
WARNING: kernel/printk/printk_ringbuffer.c:1278 at get_data+0x48a/0x840 kernel/printk/printk_ringbuffer.c:1278, CPU#1: syz.0.61/6175
Modules linked in:
CPU: 1 UID: 0 PID: 6175 Comm: syz.0.61 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:get_data+0x48a/0x840 kernel/printk/printk_ringbuffer.c:1278
Code: 83 c4 f8 48 b8 00 00 00 00 00 fc ff df 41 0f b6 04 07 84 c0 0f 85 ee 01 00 00 44 89 65 00 49 83 c5 08 eb 13 e8 57 cd 1e 00 90 <0f> 0b 90 eb 05 e8 4c cd 1e 00 45 31 ed 4c 89 e8 48 83 c4 28 5b 41
RSP: 0018:ffffc90003bff440 EFLAGS: 00010093
RAX: ffffffff81a1ac59 RBX: 00003fffffffffff RCX: ffff888079e33c80
RDX: 0000000000000000 RSI: 00003fffffffffff RDI: 0000000000000000
RBP: 0000000000000012 R08: ffffc90003bff587 R09: 1ffff9200077feb0
R10: dffffc0000000000 R11: fffff5200077feb1 R12: 0000000000000012
R13: 0000000000000000 R14: ffffffff8e0327c0 R15: 1ffffffff1c0aa96
FS:  00007ff3c0d146c0(0000) GS:ffff888125ddc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff3bfd722e0 CR3: 0000000031710000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 prb_reserve_in_last+0x574/0x18f0 kernel/printk/printk_ringbuffer.c:1447
 vprintk_store+0x641/0xd00 kernel/printk/printk.c:2273
 vprintk_emit+0x15f/0x590 kernel/printk/printk.c:2399
 _printk+0xcf/0x120 kernel/printk/printk.c:2448
 log_ctrl drivers/media/v4l2-core/v4l2-ctrls-core.c:2718 [inline]
 v4l2_ctrl_handler_log_status+0x236/0x3b0 drivers/media/v4l2-core/v4l2-ctrls-core.c:2751
 v4l2_ctrl_log_status+0x96/0xb0 drivers/media/v4l2-core/v4l2-ctrls-api.c:1260
 vidioc_log_status+0x64/0x120 drivers/media/test-drivers/vivid/vivid-core.c:452
 v4l_log_status+0x89/0xf0 drivers/media/v4l2-core/v4l2-ioctl.c:2640
 __video_do_ioctl+0xa59/0xc10 drivers/media/v4l2-core/v4l2-ioctl.c:3129
 video_usercopy+0x82d/0x1450 drivers/media/v4l2-core/v4l2-ioctl.c:3471
 v4l2_ioctl+0x18d/0x1e0 drivers/media/v4l2-core/v4l2-dev.c:366
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff3bfd8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff3c0d14038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff3bffe5fa0 RCX: 00007ff3bfd8efc9
RDX: 0000000000000000 RSI: 0000000000005646 RDI: 0000000000000003
RBP: 00007ff3bfe11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff3bffe6038 R14: 00007ff3bffe5fa0 R15: 00007ffed8034df8
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

