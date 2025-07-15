Return-Path: <linux-kernel+bounces-731380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE90B05372
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CAAC4A1DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF97B26FA6F;
	Tue, 15 Jul 2025 07:40:33 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB32726CE18
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752565233; cv=none; b=ChJ2/2GTx5iOJJ1rCcTjpO3MFrQzvZBWMHfmvz9TbNRqwOIc9W8+nC+Iok4sA9gzboLwKLmmYEW5OdZd/uz2lmrr+uWyttC3RoaQgnJZ0scXw0+niBWazEvjI8atZOu3vpxB4RbaHVevTSkg3b9oQp3GnocJUMop8MyAPfFppUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752565233; c=relaxed/simple;
	bh=XabCYADV5oq320B01NvGx75prAEwtGcF+dNLCyHWIAQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DUgnlOEf2s/gWtq5xnSQ++EVlw7M7p2Lb4EjfFvl7BAiHcGuY/bxlxJ9EDQoDM0QjHhtfkeHxmxjKrm4GVawf4OO2o6RdZXsWVGF29Al0UGvJGWj+4+1uwrpFTcRXqNJjMCit3Db/oTIv4zd1JvaP/DT7ANteyC9JPtKIxl/hYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-86cf9bad8e9so545870939f.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752565231; x=1753170031;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qSM+78FKblvXJBoy0tTE2ejwxXtyTLe36RrT6lNENdM=;
        b=adTpsOPHIWr8KIkehEwr+f23dKb/rRaVVdA1MgUnvS/DsOG5kXbYGR0ovcK7RsazZ0
         jiOyu6GcENSaidyD2rj2VMf2f0na4p+Ta8kgyPiRcvvYQbeNAtXXv8RRFzJBAR9Jln+a
         XYIO8qnwIXvk34rmh6h4Qe5h/roQeOJSPrb9+jg5iQBloWeGsGwUDW0C67uJHGoS0/oY
         MyL8r8VlXTcmsvDtRCDds8dkRNgJwHttwbIdZ53CPmirABylKphU8hzUDkYriq+tmllQ
         ET3QUzYwIPdpXZc6ZFPODy7Cfi6O7Yfq4bifxiCb10E90ONHFtkkbLK1M5jH7lIgn8sA
         yLVA==
X-Forwarded-Encrypted: i=1; AJvYcCXTM+YHgHoZzsK3WSiKM1OmoVuez3GDK6p/XHBJ7MTDukFIFisOIDApNiIG39FSj6xGexa0vW2xQwgVmuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNOzECatpI55zOlnNJ+vbXPNvIe/gYHsvG/HlJOaRShE0rz+eX
	0MaScpvTMX4yAdtCoIRh7AsOOlMU/lwSAAZdCOuU2m0CFtZpchoRq+ZAPGGwWDX0JFx2esKUvaK
	BJ1tejPeH5Ju4d5iSEL9vXq+jfAm8byJqPVcY/f90Z9Yzs4XnPMXbOR84HGA=
X-Google-Smtp-Source: AGHT+IG0ICav9y5C9dNWvzB/xnKNbRw0nvre5qkrALe6p4Aio36r4OAVswPr/ezik01oaPfzOTjnbeZZIjHBoKvTstFqSPGtm8nL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4802:b0:86d:9ec4:effe with SMTP id
 ca18e2360f4ac-879787e7038mr1759757239f.8.1752565231091; Tue, 15 Jul 2025
 00:40:31 -0700 (PDT)
Date: Tue, 15 Jul 2025 00:40:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687605ef.050a0220.158d12.0000.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_fill_extent (2)
From: syzbot <syzbot+397f6fe952a0defb9424@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bc9ff192a6c9 Merge tag 'net-6.16-rc6' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10daba8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=397f6fe952a0defb9424
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-bc9ff192.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/481157442741/vmlinux-bc9ff192.xz
kernel image: https://storage.googleapis.com/syzbot-assets/97943fefb22f/bzImage-bc9ff192.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+397f6fe952a0defb9424@syzkaller.appspotmail.com

netlink: 'syz.0.0': attribute type 1 has an invalid length.
bcachefs (loop0): /file3 offset 0: key_type_error
  u64s 5 type error 536870913:24:U32_MAX len 24 ver 0
------------[ cut here ]------------
kernel BUG at fs/bcachefs/fs.c:1323!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5339 Comm: syz.0.0 Not tainted 6.16.0-rc5-syzkaller-00121-gbc9ff192a6c9 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:bch2_fill_extent+0x96e/0x970 fs/bcachefs/fs.c:1323
Code: 0f 0b e8 75 7a 86 fd 90 0f 0b e8 6d 7a 86 fd e9 f7 fe ff ff e8 63 7a 86 fd 90 0f 0b e8 5b 7a 86 fd 90 0f 0b e8 53 7a 86 fd 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 41 57 41
RSP: 0018:ffffc9000d4af520 EFLAGS: 00010293
RAX: ffffffff8439bc1d RBX: 0000000000000014 RCX: ffff88803310c880
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000007
RBP: 0000000000000001 R08: ffff88803310c880 R09: 0000000000000004
R10: 0000000000000012 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc9000d4af9a8 R14: 0000000000000002 R15: 0000000000000002
FS:  00007ffbb4c046c0(0000) GS:ffff88808d21b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5297547000 CR3: 00000000435be000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 bch2_fiemap+0x2871/0x2a90 fs/bcachefs/fs.c:1538
 ioctl_fiemap fs/ioctl.c:220 [inline]
 do_vfs_ioctl+0x16d3/0x1990 fs/ioctl.c:841
 __do_sys_ioctl fs/ioctl.c:905 [inline]
 __se_sys_ioctl+0x82/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffbb3d8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffbb4c04038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffbb3fb6080 RCX: 00007ffbb3d8e929
RDX: 0000200000000240 RSI: 00000000c020660b RDI: 0000000000000007
RBP: 00007ffbb3e10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffbb3fb6080 R15: 00007ffc38ab3c78
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_fill_extent+0x96e/0x970 fs/bcachefs/fs.c:1323
Code: 0f 0b e8 75 7a 86 fd 90 0f 0b e8 6d 7a 86 fd e9 f7 fe ff ff e8 63 7a 86 fd 90 0f 0b e8 5b 7a 86 fd 90 0f 0b e8 53 7a 86 fd 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 41 57 41
RSP: 0018:ffffc9000d4af520 EFLAGS: 00010293
RAX: ffffffff8439bc1d RBX: 0000000000000014 RCX: ffff88803310c880
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000007
RBP: 0000000000000001 R08: ffff88803310c880 R09: 0000000000000004
R10: 0000000000000012 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc9000d4af9a8 R14: 0000000000000002 R15: 0000000000000002
FS:  00007ffbb4c046c0(0000) GS:ffff88808d21b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000435be000 CR4: 0000000000352ef0


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

