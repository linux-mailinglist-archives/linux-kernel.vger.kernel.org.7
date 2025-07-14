Return-Path: <linux-kernel+bounces-730610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B9AB046ED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B994A5057
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98612676CE;
	Mon, 14 Jul 2025 17:53:31 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B656B258CEC
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515611; cv=none; b=qqyD2WXQz0kz41wm8ixrVjazxdaGAN1V1Yagqv72K9MuczyGEBe7wDcBQwNcOVvaqvtXE5sKHhy9cfu0tKfzgJR/QLEL/mZflKEW+h9kBziA0htCWTGvBQkFVF2S0dk4cWTiqbuRU+d9sglY8NwhnmX4VqlQwaYpslhWOnlmIj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515611; c=relaxed/simple;
	bh=F2b+Ednpve0YB9ttDK5V5SBpMel/RnIQ1vJ4JNaTcVk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=a7zmiopF5InNxfWuSTdrqACb5WjEWaQf0Humn+YEj2+vDa63ln8+ILx+7mjkLhXbQ299PXy7CwMo4kR+JuD+XvjnzutDxgYLZHdP/lty4lf2c3bCwFmu2v4EW1L9yEfreManPJ159lZsPrMXeUTkVEGVQ7hCiXUfW78SuZV34dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-8760733a107so516463639f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752515609; x=1753120409;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TaGOXg4zhvEEaLHkswYZBqwNrVR3sKsoC/Zf4llTmOI=;
        b=c0Pr+dfAnwbbOqYwgD19x0YjXEHoylIwPGSqw0QjSeAAdAb9Kp+WL97oPkeFIVMJGu
         ekwGAdhRZ085lyLKh+pLWwTZ3uFn9lFV4M6h7MW5Hc6zoC9KJqBI0C+A4R2TNXZXI/jp
         mYd6e4xdt6l0Dl0QDmUlKPXAcFS+VKhc478AsDbUJOq60GJJ94CUxm+hHqFFil7xvoIy
         uF3Dq1zwUo+0TtjPXS7bFInleCzZq9a9eFrspMgMuYFffDYdR+olr5D601Ad2CmCx0Kb
         l/o+2FhzAlztDSJSOpBQRGINAflGPMh7rkLi0C3inWpjIXsTDQaEPUn+ajX+d5xFoW8w
         XZOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQaz5EAGiE5Un93PWbNQQxsW8qMXIa8Pp4y+PAMqkvQVjHQxiFGt18YNl2E0NDiS0LVL1BD0WT6IlSeFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLysXm+XTPyIvywBI211rMjgQfwS9g16BLAgeErDPbrhz8jpua
	298ReVyi94/MCOJBbkxOlhusI9we6GcTik9REJq+Q0pTzUv8safxzjIBpvVk7Df8f4UYYQhvSf7
	gZ2C9NzcTlNbM5TcgptkR4rEomUxIL6qGyAswnbzhPnF4YfiZlJ4eiUhXPH0=
X-Google-Smtp-Source: AGHT+IFve6fuYUileRJn1yry//Lui3c6Zoi3p0X3LJMrk/zr1rkRiHa/Xp0DHgqnO9P+WZbAkNT23WLjFOQxBVYswrJnvj3YTlH/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d15:b0:86c:f0d9:553 with SMTP id
 ca18e2360f4ac-87977f74cc2mr1537575039f.5.1752515608914; Mon, 14 Jul 2025
 10:53:28 -0700 (PDT)
Date: Mon, 14 Jul 2025 10:53:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68754418.050a0220.33d347.000b.GAE@google.com>
Subject: [syzbot] [gfs2?] UBSAN: shift-out-of-bounds in gfs2_dir_read (2)
From: syzbot <syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    347e9f5043c8 Linux 6.16-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13c070f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62a2ef17395702a
dashboard link: https://syzkaller.appspot.com/bug?extid=4708579bb230a0582a57
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-347e9f50.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49ae91eb36e0/vmlinux-347e9f50.xz
kernel image: https://storage.googleapis.com/syzbot-assets/78497f74bd6b/bzImage-347e9f50.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
gfs2: fsid=syz:syz.s: journal 0 mapped with 5 extents in 0ms
gfs2: fsid=syz:syz.s: first mount done, others may mount
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/gfs2/dir.c:1544:15
shift exponent 32 is too large for 32-bit type 'u32' (aka 'unsigned int')
CPU: 0 UID: 0 PID: 5345 Comm: syz.0.0 Not tainted 6.16.0-rc6-syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
 dir_e_read fs/gfs2/dir.c:1544 [inline]
 gfs2_dir_read+0x1730/0x1780 fs/gfs2/dir.c:1585
 gfs2_readdir+0x14c/0x1b0 fs/gfs2/file.c:116
 iterate_dir+0x5ac/0x770 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:410 [inline]
 __se_sys_getdents64+0xe4/0x260 fs/readdir.c:396
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f97c858e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f97c94ce038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f97c87b5fa0 RCX: 00007f97c858e929
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f97c8610b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f97c87b5fa0 R15: 00007ffd76387a88
 </TASK>
---[ end trace ]---


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

