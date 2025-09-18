Return-Path: <linux-kernel+bounces-753952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFB0B18A98
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 05:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915F81C21B78
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 03:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2405D2AD11;
	Sat,  2 Aug 2025 03:33:31 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9F913C8FF
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 03:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754105610; cv=none; b=GLqMfaylVAO8hKH9ogEwOZMl073bmFqoqdVBbvfAz6Kxv7pEypIi+ItpJuQmhASJsXx2qnQu0tOSUJSehzbeHeXmXf7J+vggt29tYGApUo/tR1xGunZd1iN6AYAqIrpZtUFnxAbrmwfoFT5Zb0lWYUz1uGulzv3tIiJkJ6j5+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754105610; c=relaxed/simple;
	bh=5Cq1exZhWFLjrp8oBDKR6trzjHvPpLCE/AAS8QfIBUg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=H8sKG2do13GP+FMW0dAaStUd6+UypTpGCV2OxbOIo2m8jvQZWnRzCCdDdeOKuFRuezh/LKEZ4OweTtn+Lf6ym7GsTHrEtiVl9svoFZ9F6iF9wdGQDB4V7QIiRJOFEQEIG+XsFHqN787cLMIrAVmYRCfnsMlEv1iGF5SNN5P8UB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3e3f75449b4so18794375ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 20:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754105608; x=1754710408;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=laegd8mbnk5HeXrbQDy+tFC7eBnbymZo13VgtL9j0PE=;
        b=PXR5jue6RK02Ij1zLMlj25m4GLymvkU76Jy7eAt1Sg+eA4qjy5U507QWNHUu2V/d6l
         3ydgBYRVncRp0X27C+qddry15OTBfQdfN+UnCp4rHoPKPIx6nsqvN50Nzv/tFUoanN+3
         dRZCTJse4/8f5+66nUyzdZUFiawdmt2fmeIeBoWqneKzOxA5bzTkf7KFmr+dtO/DUG4T
         48HDrdLlVlXEUXf5xLhkYgqZEskk5+2yR6LZmiFFB2B7l3l2+CnDn4AuX/gh6CzJInX3
         lwl4dMhE5gxylsk6G6mBnCQnyOV2qscrNEXoED3NIoP4zkNIHdloLQgA2nTSlyO1TBpT
         3CwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsyWchzSFWGuDJDSvTlCbEnoskCMQ2zlGd+i9klP+/NFMLUeJIpBfuL04A6KxgMSo5rfuV6QsEYLlYLr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD6tFZYULFHmBIONnsadVTeU/tDhUzJHkLCidPxdfALHhZI3tQ
	r93NRLujeKf+SC06phyUu/Mt76hhEq73QvnGFEda+ns7EPA6N7F0xZ036/EYPpVFfx7HQo62jnE
	WMFzZKwZ7q13pPUispVPSKW9OQSUSJemMSjvVMeT7uKU2qLUbiVabuOz3DIQ=
X-Google-Smtp-Source: AGHT+IGTWEHqJnWLhSs5jk10Y04IZkkIsyVJt1jogy6UoXblzZ+sfoCsOAYRbhrqvpGCj1bBjLDhbJnZ8JD27EAtuv9+c45Jos20
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f0d:b0:3e3:fdd9:8972 with SMTP id
 e9e14a558f8ab-3e41615d9c0mr38318945ab.11.1754105608292; Fri, 01 Aug 2025
 20:33:28 -0700 (PDT)
Date: Fri, 01 Aug 2025 20:33:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688d8708.050a0220.f0410.0135.GAE@google.com>
Subject: [syzbot] [block?] WARNING: ODEBUG bug in disk_release
From: syzbot <syzbot+1fe2f3ddc7f8f83fb196@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    89748acdf226 Merge tag 'drm-next-2025-08-01' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=151c12a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff858d5d4508232d
dashboard link: https://syzkaller.appspot.com/bug?extid=1fe2f3ddc7f8f83fb196
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4f34b67c9cfc/disk-89748acd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2f11bb9a095b/vmlinux-89748acd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e15dbd303fb/bzImage-89748acd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1fe2f3ddc7f8f83fb196@syzkaller.appspotmail.com

md: md2 stopped.
------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff88801f3b4448 object type: work_struct hint: mddev_delayed_delete+0x0/0x20 drivers/md/md.c:721
WARNING: CPU: 0 PID: 11789 at lib/debugobjects.c:612 debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
Modules linked in:
CPU: 0 UID: 0 PID: 11789 Comm: syz.5.1495 Not tainted 6.16.0-syzkaller-10499-g89748acdf226 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 54 41 56 48 8b 14 dd e0 0a 16 8c 4c 89 e6 48 c7 c7 60 ff 15 8c e8 bf 92 90 fc 90 <0f> 0b 90 90 58 83 05 b6 a5 bf 0b 01 48 83 c4 18 5b 5d 41 5c 41 5d
RSP: 0018:ffffc90004a6f928 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffc9001b884000
RDX: 0000000000080000 RSI: ffffffff817a2815 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff8c160600
R13: ffffffff8bac16a0 R14: ffffffff8856a0a0 R15: ffffc90004a6fa28
FS:  00007f777160f6c0(0000) GS:ffff8881246fb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020000011a000 CR3: 000000005441a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
 debug_check_no_obj_freed+0x4b7/0x600 lib/debugobjects.c:1129
 slab_free_hook mm/slub.c:2348 [inline]
 slab_free mm/slub.c:4680 [inline]
 kfree+0x28f/0x4d0 mm/slub.c:4879
 disk_release+0x2a1/0x410 block/genhd.c:1310
 device_release+0xa4/0x240 drivers/base/core.c:2565
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e7/0x5a0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3797
 blkdev_release+0x15/0x20 block/fops.c:699
 __fput+0x3ff/0xb70 fs/file_table.c:468
 task_work_run+0x14d/0x240 kernel/task_work.c:227
 get_signal+0x1d1/0x26d0 kernel/signal.c:2807
 arch_do_signal_or_restart+0x8f/0x7d0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x84/0x110 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:224 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f777078eb69
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f777160f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00007f77709b6160 RCX: 00007f777078eb69
RDX: 0000000000000007 RSI: 0000000000000932 RDI: 0000000000000007
RBP: 00007f7770811df1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f77709b6160 R15: 00007ffcb194e248
 </TASK>


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

