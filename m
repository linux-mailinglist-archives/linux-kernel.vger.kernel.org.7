Return-Path: <linux-kernel+bounces-749931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC130B154EC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A264E7EB5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5D727F18F;
	Tue, 29 Jul 2025 21:59:34 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83919238D53
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753826374; cv=none; b=Z0enm614EOAInXayqf3FEOJMcQZU+EdqQIZ9H5Mo3bNEH4JB9vFSQaTmrHDIpauSPS7mVb37m+ZMDOrEYJAOKXesSEbgp6OrlWSPxxLrxXNY60Lv9TgI4u3WMUvZdsj3gU9EfQlbIoZm/1LY6pwmclzZZXsHEo8yIbanJcrsMzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753826374; c=relaxed/simple;
	bh=YRFpxV4BWVaPQXqT/sVspwiaGrUu+GkIHK18/WjN1uE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oIUMr1kBTFHLm+tgB5hp2BQ2BykwfpANdmmKfhFsA1ivBJK9xmgxSQJdaQ2YVYnUTkp2hdwkiblJ+WeSwYEXlb8naSpP2WaVlGPI2HhLxz12c38IwhKs5TrdCIwuMfiF00Gd0IBEmSxIm8GzSHvliHQtvfsjY8i1KmMRciBebhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3e3eec010b9so12773215ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753826371; x=1754431171;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w4i3DmsI+e9RvNOSMGjTmBe3p3py/apqNamFPP6nbds=;
        b=bkWuu30axT9XRDLlA/610tfG/EdbysYZJOqJh767X0jIKIDrUvwfoiS5CVPrUFuG8c
         RowhLPGL4un9W28mwUBSKP29M+4dyep6cAy5YGyhdZAyapqK0z8Bq6ciizygh5Rl7Lpa
         orRfwUFkd+6gqGLvcGlzu85f/PRew9cZWCqdthEFxNqIHS44G9PdYx5q5h3NjlUi+7PZ
         0tHsyPagvT1b6OhrI+/AfOu3DPw5zta9Pa1J3e65J4smWcc/nQtoopWAGZItFB8APmH/
         LIeZ8V0ykzSuFfhVdomIg7XysuTUlX02FDWULyIkDw4ByTAA/elNO3A+d+aALYqwH2eq
         8aog==
X-Forwarded-Encrypted: i=1; AJvYcCWYBRDlUQ1whjI6X+2wksrO68rb9CHAHTY7RkzlAHbZYcpDpz/zbOKC7vOpr6NlUZqEFIPEH5ZJnfjO31g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6M2pO4u73bw+41U23vUMfAtoFxEie74KsRwK2xm33IwVCcjwp
	8EWwDyE0sI7Kid2Lz7f72xtbg7IRadBVuEbZxAeqMyKvWq75gIzQwvfiJe4feh26X6LF2W+aSom
	Cr/UXYIOGvZciMjDJRYPMtQpMLlzhrdq38uZS3dCehu9BqsakaUWiks/M7YY=
X-Google-Smtp-Source: AGHT+IEqWXRKyjxRWtIYrW77iYkgRU41DtQPOoB0SxD37GQqCoobMtJPcldlIoELJXkfGRF6BsNf4fFyfkYuqIGunRPhD1ZGQ/Qv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b28:b0:3e3:d185:9163 with SMTP id
 e9e14a558f8ab-3e3f62b8420mr16305895ab.20.1753826371609; Tue, 29 Jul 2025
 14:59:31 -0700 (PDT)
Date: Tue, 29 Jul 2025 14:59:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68894443.a00a0220.26d0e1.0015.GAE@google.com>
Subject: [syzbot] [dri?] WARNING in __ww_mutex_wound
From: syzbot <syzbot+602c4720aed62576cd79@syzkaller.appspotmail.com>
To: airlied@gmail.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, simona@ffwll.ch, syzkaller-bugs@googlegroups.com, 
	tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d086c886ceb9 Add linux-next specific files for 20250718
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=161204a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=69896dd7b8c4e81e
dashboard link: https://syzkaller.appspot.com/bug?extid=602c4720aed62576cd79
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fff4f0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111204a2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/54504fbc2437/disk-d086c886.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b427b00abffe/vmlinux-d086c886.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5a87731b006b/bzImage-d086c886.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+602c4720aed62576cd79@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: ./include/linux/sched.h:2173 at __clear_task_blocked_on include/linux/sched.h:2173 [inline], CPU#1: syz.1.8698/395
WARNING: ./include/linux/sched.h:2173 at __ww_mutex_wound+0x21a/0x2b0 kernel/locking/ww_mutex.h:346, CPU#1: syz.1.8698/395
Modules linked in:
CPU: 1 UID: 0 PID: 395 Comm: syz.1.8698 Not tainted 6.16.0-rc6-next-20250718-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__clear_task_blocked_on include/linux/sched.h:2173 [inline]
RIP: 0010:__ww_mutex_wound+0x21a/0x2b0 kernel/locking/ww_mutex.h:346
Code: 5f 5d c3 cc cc cc cc cc 90 0f 0b 90 e9 89 fe ff ff 90 0f 0b 90 e9 39 ff ff ff 90 0f 0b 90 4d 85 ff 0f 85 67 ff ff ff eb 95 90 <0f> 0b 90 eb 8f 48 c7 c1 70 00 e4 8f 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc900030e7720 EFLAGS: 00010046
RAX: ffff888024a1b000 RBX: dffffc0000000000 RCX: 8f1a7ab232ebe500
RDX: 00000000000003ef RSI: ffffffff8de5b067 RDI: ffffffff8c04d400
RBP: 0000000000000001 R08: ffff888024a224bf R09: 1ffff11004944497
R10: dffffc0000000000 R11: ffffed1004944498 R12: ffff88802dee8a78
R13: ffffc900030e7ae8 R14: ffff88802dee8000 R15: ffff888024a224b8
FS:  00007fe6e4a7f6c0(0000) GS:ffff8881258ab000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe6e4a5ed58 CR3: 000000003115e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __ww_mutex_add_waiter kernel/locking/ww_mutex.h:574 [inline]
 __mutex_lock_common kernel/locking/mutex.c:642 [inline]
 __ww_mutex_lock+0xba3/0x2930 kernel/locking/mutex.c:771
 ww_mutex_lock_interruptible+0x3f/0x1c0 kernel/locking/mutex.c:904
 modeset_lock+0x21a/0x650 drivers/gpu/drm/drm_modeset_lock.c:-1
 drm_modeset_lock drivers/gpu/drm/drm_modeset_lock.c:398 [inline]
 drm_modeset_lock_all_ctx+0x62/0x300 drivers/gpu/drm/drm_modeset_lock.c:459
 setplane_internal drivers/gpu/drm/drm_plane.c:1118 [inline]
 drm_mode_setplane+0x577/0xba0 drivers/gpu/drm/drm_plane.c:1175
 drm_ioctl_kernel+0x2cc/0x390 drivers/gpu/drm/drm_ioctl.c:796
 drm_ioctl+0x67f/0xb10 drivers/gpu/drm/drm_ioctl.c:893
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe6e3b8e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe6e4a7f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe6e3db5fa0 RCX: 00007fe6e3b8e9a9
RDX: 0000200000000080 RSI: 00000000c03064b7 RDI: 0000000000000003
RBP: 00007fe6e3c10d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe6e3db5fa0 R15: 00007ffdf1fa90a8
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

