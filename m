Return-Path: <linux-kernel+bounces-842504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F504BBCDE2
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 01:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FDCC4E4F07
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 23:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064F5233722;
	Sun,  5 Oct 2025 23:30:28 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44DE18B0A
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759707027; cv=none; b=Hi3WL1JLTxhaqNsXOwOBABGl6Y4+w4xQZ25kqSHYOfhBTMYosf7SpKFud/VSVSLwxpRdKo8qjlQqweBaDUOD5TzJ97Vy+FZI28D4Teg5y6pYXSYt6CvKqaEMAVQBFOZe13AIuZUZbdqkH/3nBGVFisDVLmeA6AGWnZw0OLM+9FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759707027; c=relaxed/simple;
	bh=75ERC6mVlcP+0s7urdWwm4NONtCuHEvmI1LGy4VtD1I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=njp2/L0nUlmSePRpNTmj901vf3GQeZZ/1bTWXrF92kFbX3zSso9831u/eVTiMCSkjDKqpO6Sc5EQkbF3OqHskNzozUZNmZLxDjhf0W75Hma9q5sg1yxSell3cGp4iq6s6kOWHvbaEEo4lyaufNJhzPvX5rx+7h1XmKLXZHNm8Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-42f64261ab8so50514475ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 16:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759707025; x=1760311825;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=trZlZImbmcaAhlE8sigTqJv3T3ChaC7LfmvwDqEqkS0=;
        b=gulJiuvOzdpHNKUjqilyB7F7LqkaEVY6ZdPZjPsIRln09vWdGYs6TT9GWD4cC5OEFf
         G+Aasuy824vBsr/9A9fQtyY7Y0Aofhr3qicbu4fsoQmv+g4L8p7FkH94+GiAA4sEDDkg
         4bAa7kKRsVgh/pP24ByjWo0+2C/uhwEHb2NRajDg4oHUrPrNaaGoLmEqFOr8B5jnqUhx
         yUT04d4S4rZGPcP/54tzUZ6983yhrj8VBh9qSDcXKg5fkSU7IxyVBxAId9Aj6+z7V29D
         V+Jgk2NVGdNmRNp6GLWZCrhd4AMUngk8g4znfVI596uItX9mPoRv55gzUguRC2+g7cva
         a+EA==
X-Forwarded-Encrypted: i=1; AJvYcCXx+LdLwj4IpGD9gj3jDbs1BCvdTQdUx6Zj0DANF0s1OgHlB1lOYIgGl5y1JnPdDVbyVzZ5q4GiUPq0r+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH68ojWyW1VQoTyzJ15i+3aBsu3dv/ZGnvDdFay7OWgft7rnDc
	yW9UuhlvFmTJZUI49kolb9HbaHbGZg5hBdCvGpzfafF8f3py+DvxBaWo+tH0/iYDMVYHDj/jDFq
	8XZ+jRhXxS6pXn3oHw4xhSW1Lz2rRxyV6G0x7x0TzsE/MmkSZku2XwhYTfW4=
X-Google-Smtp-Source: AGHT+IEJffKj5NbuytLavLNmtzhrY1Xa4KENymvle9KZlbxZ/n7Iib8GRsIT0u3bDAZXwx3KxV/fX+YlUekbZvrx+NzB6I04ugWQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ef:b0:427:1de5:e10f with SMTP id
 e9e14a558f8ab-42e7ad9c5e9mr141692915ab.22.1759707025190; Sun, 05 Oct 2025
 16:30:25 -0700 (PDT)
Date: Sun, 05 Oct 2025 16:30:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e2ff91.050a0220.2c17c1.003a.GAE@google.com>
Subject: [syzbot] [ntfs3?] WARNING in indx_insert_into_buffer (3)
From: syzbot <syzbot+3a1878433bc1cb97b42a@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6093a688a07d Merge tag 'char-misc-6.18-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13962458580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e654219ed2546322
dashboard link: https://syzkaller.appspot.com/bug?extid=3a1878433bc1cb97b42a
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104b692f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17962458580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/660883fc9bdb/disk-6093a688.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/29f543ec9187/vmlinux-6093a688.xz
kernel image: https://storage.googleapis.com/syzbot-assets/456918818f89/bzImage-6093a688.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/dc6369359d19/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3a1878433bc1cb97b42a@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
------------[ cut here ]------------
memcpy: detected field-spanning write (size 3656) of single field "hdr1" at fs/ntfs3/index.c:1927 (size 16)
WARNING: CPU: 0 PID: 6065 at fs/ntfs3/index.c:1927 indx_insert_into_buffer.isra.0+0x1041/0x12a0 fs/ntfs3/index.c:1927
Modules linked in:
CPU: 0 UID: 0 PID: 6065 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:indx_insert_into_buffer.isra.0+0x1041/0x12a0 fs/ntfs3/index.c:1927
Code: b5 ed a3 fe c6 05 52 41 31 0d 01 90 48 8b 74 24 68 b9 10 00 00 00 48 c7 c2 20 53 a7 8b 48 c7 c7 80 53 a7 8b e8 a0 74 62 fe 90 <0f> 0b 90 90 e9 df fd ff ff e8 71 6d 0b ff e9 4d f4 ff ff e8 67 6d
RSP: 0018:ffffc900039af748 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 00000000ffffffe4 RCX: ffffffff81799b88
RDX: ffff88802ed50000 RSI: ffffffff81799b95 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888146f46800
R13: ffff888069637800 R14: 0000000000000e48 R15: ffff88807ae74018
FS:  0000555563ff7500(0000) GS:ffff888124e6a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdbd7fd4286 CR3: 0000000069517000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 indx_insert_entry+0x1a0/0x460 fs/ntfs3/index.c:1996
 ni_add_name+0x4dd/0x820 fs/ntfs3/frecord.c:2995
 ni_rename+0x98/0x170 fs/ntfs3/frecord.c:3026
 ntfs_rename+0xab9/0xf00 fs/ntfs3/namei.c:332
 vfs_rename+0xfa3/0x2290 fs/namei.c:5216
 do_renameat2+0x7d8/0xc20 fs/namei.c:5364
 __do_sys_rename fs/namei.c:5411 [inline]
 __se_sys_rename fs/namei.c:5409 [inline]
 __x64_sys_rename+0x7d/0xa0 fs/namei.c:5409
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f780118eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcbf706748 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f78013e5fa0 RCX: 00007f780118eec9
RDX: 0000000000000000 RSI: 0000200000000f40 RDI: 00002000000003c0
RBP: 00007f7801211f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f78013e5fa0 R14: 00007f78013e5fa0 R15: 0000000000000002
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

