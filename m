Return-Path: <linux-kernel+bounces-751031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE47B16461
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744271AA47BB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDF32DE71E;
	Wed, 30 Jul 2025 16:09:38 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A180E2DE711
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753891778; cv=none; b=S2mXw06TK6p7Dk6g61U2ILd+YC2il2HvENGqhvUWYhnrWlzl9WG5I5Zy0jTJcPYi5DCxovF9UeeUJ+XNMDjD7NUrT/U0WrGWp6czsZyb1nfjpkuE30bUtICGnURVTf7ByW6mpd6aANejCNHdHmTpmGTsFAWDlOL4W19xGw0HyZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753891778; c=relaxed/simple;
	bh=kRMFaP3uDFy9AtnSJJbnU7XeE3l2zaYmlEcIV6keUYs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AhLVn2zIARJPyes3SvtAdPGFk9MCask2s/Q9RXqg9MQi0iUTdJAhfMWfDjTz6OiFJX7y/hSLDym3Pmk9q+5TZxaJd7paLOcXq2q/PqJuQcyUrTMg0QaPfGyBTzguJQ7HBvFhsTmUTfrDNnRlOYoGDbvFd0TfLPVsYCH9JhIwzQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3e3f6ae4d0fso14230285ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753891776; x=1754496576;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V6sU9wcsAFaB8MjEXUXjl60SDL+4Ms1KtUD6ELWGeD8=;
        b=Lo6mxuOS/yJS4gNwXC6a8GvV6iQ/C3vxKl6vkX4dOKtV3VhQ0REssbHlP1/A2EDJ3P
         fQDqWxqZ7lSeNI62rmU/zPdm7FZ6cHVauYDEJ51mqeK7XpTQfPeLUT5Ciwel//BUhj5e
         Hy2aotbZ9BaaKoHjoHS/ER9jwVCtoM373EVCdEN1Z/mq/Bh6IdFIEQVrrxu7RiDwhVoR
         2Ngx3ZvZlLs6pNYfhDAkppkSr1EtThgotQUW4Ige/lsubL+WkmbOPDHWa/8wxgL6K3Ll
         e8fijZKxhYq9MEM6PdlEX/vAY7Wu0mdnVU65nZnn6EibSxzL93klSvoY84uJBZok4fE7
         z6jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSyqXQwnZ+7rDNkMtS9IXjoz7sEF0SxJcBeRFwMRNqBDtfflY0TJlzyIQC3aCLNwjNAJDK/lOfNvVUC/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH3bwowdwHds4emnhLzaootH++wnlMmNp4KXfG9HCMJdk39qoR
	wgwOvwB3nWe4DzOUz7V27pDc0593fM2xngvxwoywfJp7z3vnjLOJZATrPGML4dMdGIi3Vt4Zuji
	2LFsBUFH+6d4FKhtDGt8Gg5nbMUcenKmwuhkF+jtddbPPIpMAo6Tlm7lYw4s=
X-Google-Smtp-Source: AGHT+IHofyv55TPFRJtG29cCv7oY5anOxPw9dQhV3YeIrZXjGKHsY+hOqswB+cCAwc/JEIpgDTfwEFT42d90jwXtxxDd+ccyeDrA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2388:b0:3e3:b4ff:15e3 with SMTP id
 e9e14a558f8ab-3e3f621a48emr56479425ab.4.1753891775703; Wed, 30 Jul 2025
 09:09:35 -0700 (PDT)
Date: Wed, 30 Jul 2025 09:09:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688a43bf.050a0220.5d226.000a.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_bio_compress (3)
From: syzbot <syzbot+1733f08e3b98628b164a@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5f33ebd2018c Merge tag 'drm-fixes-2025-07-26' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15fa4034580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8adfe52da0de2761
dashboard link: https://syzkaller.appspot.com/bug?extid=1733f08e3b98628b164a
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-5f33ebd2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a554f67105dc/vmlinux-5f33ebd2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b3d52a10bce9/bzImage-5f33ebd2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1733f08e3b98628b164a@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/bcachefs/compress.c:525!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5346 Comm: bch-copygc/loop Not tainted 6.16.0-rc7-syzkaller-00120-g5f33ebd2018c #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__bio_compress fs/bcachefs/compress.c:525 [inline]
RIP: 0010:bch2_bio_compress+0x14b1/0x14c0 fs/bcachefs/compress.c:555
Code: fd 90 0f 0b e8 20 30 90 fd 90 0f 0b e8 18 30 90 fd 90 0f 0b e8 10 30 90 fd 90 0f 0b e8 08 30 90 fd 90 0f 0b e8 00 30 90 fd 90 <0f> 0b 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc9000f51e600 EFLAGS: 00010293
RAX: ffffffff84300110 RBX: 0000000000000003 RCX: ffff88803d990000
RDX: 0000000000000000 RSI: 0000000000000800 RDI: 0000000000000000
RBP: ffffc9000f51e850 R08: 0000000000000005 R09: 0000000000000003
R10: ffffc90001a23033 R11: fffff52000344800 R12: 0000000000000800
R13: 0000000100000001 R14: 0000000000000000 R15: 0000000000002800
FS:  0000000000000000(0000) GS:ffff88808d218000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555e44a5168 CR3: 0000000011b80000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 bch2_write_extent fs/bcachefs/io_write.c:1060 [inline]
 __bch2_write+0xfb5/0x3900 fs/bcachefs/io_write.c:1554
 move_write fs/bcachefs/move.c:217 [inline]
 bch2_moving_ctxt_do_pending_writes+0x5a7/0xe60 fs/bcachefs/move.c:248
 bch2_move_ratelimit+0x8e8/0x1330 fs/bcachefs/move.c:585
 __bch2_move_data_phys+0x110f/0x1c50 fs/bcachefs/move.c:904
 bch2_evacuate_bucket+0x228/0x3a0 fs/bcachefs/move.c:1082
 bch2_copygc+0x3be3/0x4510 fs/bcachefs/movinggc.c:234
 bch2_copygc_thread+0x97a/0xe00 fs/bcachefs/movinggc.c:409
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__bio_compress fs/bcachefs/compress.c:525 [inline]
RIP: 0010:bch2_bio_compress+0x14b1/0x14c0 fs/bcachefs/compress.c:555
Code: fd 90 0f 0b e8 20 30 90 fd 90 0f 0b e8 18 30 90 fd 90 0f 0b e8 10 30 90 fd 90 0f 0b e8 08 30 90 fd 90 0f 0b e8 00 30 90 fd 90 <0f> 0b 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc9000f51e600 EFLAGS: 00010293
RAX: ffffffff84300110 RBX: 0000000000000003 RCX: ffff88803d990000
RDX: 0000000000000000 RSI: 0000000000000800 RDI: 0000000000000000
RBP: ffffc9000f51e850 R08: 0000000000000005 R09: 0000000000000003
R10: ffffc90001a23033 R11: fffff52000344800 R12: 0000000000000800
R13: 0000000100000001 R14: 0000000000000000 R15: 0000000000002800


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

