Return-Path: <linux-kernel+bounces-835294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4E0BA6A76
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 10:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119003BD5BA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC99929D29B;
	Sun, 28 Sep 2025 08:00:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B041B19F43A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759046405; cv=none; b=ZiVqSB3AdtFKZLq//aZK22xjT0o9b5DrMlODPWj8yiQ1DG1Sv83IpA0KPtLh8HsL4amNEAPZxzEwoX0nMExqP25aHomfTPNVb2drdbBAfDyesBcqohzRG/zutzlyRNVW+Glq7AnaqfqG8kbZTKoAypLrOwLQA0npmQer7ij8YR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759046405; c=relaxed/simple;
	bh=NmyfrREGFF9VICMIGdK6QKK4a43Kj9pf+OSuNd31bGc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GK6AhoCLm124EBqmoYfeujnwZIUqWCr32Vrll805hJAPwDEiIN4+wyxrrmH3cQHuY5OJq2x5h4tiBqCzfAwwDHfAcKQQ4pSFb9vGFgJ3h8I9A6qS3o+1/ETWWWIUYxfr5Zge+2ZEYfUuK+qOgrA0W1B9lkKSy1LMCOyNaCha3yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42594db9398so97610245ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 01:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759046403; x=1759651203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBT40lBmCabm047ojNcxNawF89FCkERNeoTWSn7tnuo=;
        b=HJiPxC6ipXg93Qy6n0U0TrbYC0ioDLqrkXSRymE3WfK3oV9OC6pG8vHV2+jwB8IycR
         ImSlsZvNmVhFGX3VRXYgZ5nxoBHT+NjMQwok8f3Mbn9+NcXRpos6Wcj//oVgU3VD8NHg
         YWPs6A9qoTp8VcXu69HQPVhR/JbIFKm+pZtEe2nhI0j/rmTIt/Q6CbNZget1FqewxijO
         GmcgByWu3glhT7GUuojDnGTt5W/OFcvnde4/oY4S5vRCflrh6T66nAsrbmhVlWp8/mcs
         Aak91JjeP/NbUC7ZLwkNGat9AFO0GR27pJh/4UoNPiSk9YYgGhYXUDQ/57fzqMcZqa+S
         hdFA==
X-Forwarded-Encrypted: i=1; AJvYcCWMjwSDb1ARoIA2nwRcp/3BlAIU5rmMvgiIqjWdHuvW0YAqzN9g86+UYNNZZSNV8BX0xuSKZKErrwbXgVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+8t6/2YzJXKcLA9HMfug/8d/hr+Ml+EYBi//vNLL2arRxvVmJ
	WZgFsgrX0AbheAG4ItMPE5eu82MQ3VIbKLiTLBUBwihUSVkbyD2Cx8959a6AK0r5WXPbhWmsk+6
	R/R2a24daXglo44w6VRe5HIKGZAbtQtfIzBwYpjnnqaXD/HDIff0PNzKZ+xE=
X-Google-Smtp-Source: AGHT+IHQqNrVWxsxfP4+OYrs0V3darqNcFiKAq1HJdXio3xFOYKsuiHYad8CJRWkdMnNqyO74gty/IucAE0kaj4Ilph/iML71zRA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe5:b0:427:6510:650b with SMTP id
 e9e14a558f8ab-427651066e6mr109245255ab.22.1759046402792; Sun, 28 Sep 2025
 01:00:02 -0700 (PDT)
Date: Sun, 28 Sep 2025 01:00:02 -0700
In-Reply-To: <20250928074511.6263-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d8eb02.a00a0220.102ee.0026.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_es_cache_extent (3)
From: syzbot <syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in ext4_es_cache_extent

EXT4-fs (loop0): 1 truncate cleaned up
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
------------[ cut here ]------------
kernel BUG at fs/ext4/extents_status.c:1012!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5828 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ext4_es_cache_extent+0x698/0x700 fs/ext4/extents_status.c:1012
Code: ff df 80 3c 08 00 74 08 48 89 df e8 c2 a7 b3 ff 48 8b 3b 48 8b 74 24 28 48 8d 54 24 60 e8 00 c3 0d 00 eb 14 e8 89 ab 4e ff 90 <0f> 0b e8 81 ab 4e ff eb 28 e8 7a ab 4e ff 31 f6 65 ff 0d 01 71 50
RSP: 0018:ffffc90002bcf420 EFLAGS: 00010293
RAX: ffffffff82711f17 RBX: 00000000ffffffff RCX: ffff888033530000
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000000052ce
RBP: ffffc90002bcf528 R08: ffffffff8fc3c837 R09: 1ffffffff1f87906
R10: dffffc0000000000 R11: fffffbfff1f87907 R12: 00000000000052d0
R13: 0000000000000004 R14: 00000000000052ce R15: dffffc0000000000
FS:  00007fa99e5616c0(0000) GS:ffff88808d007000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2d130e10a0 CR3: 0000000042911000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 ext4_cache_extents fs/ext4/extents.c:548 [inline]
 ext4_find_extent+0x482/0xcc0 fs/ext4/extents.c:932
 ext4_get_verity_descriptor_location fs/ext4/verity.c:292 [inline]
 ext4_get_verity_descriptor+0x102/0x590 fs/ext4/verity.c:346
 fsverity_get_descriptor+0x90/0x4b0 fs/verity/open.c:323
 ensure_verity_info fs/verity/open.c:363 [inline]
 __fsverity_file_open+0xd7/0x1f0 fs/verity/open.c:384
 fsverity_file_open include/linux/fsverity.h:300 [inline]
 ext4_file_open+0x32d/0xa40 fs/ext4/file.c:909
 do_dentry_open+0x950/0x13f0 fs/open.c:965
 vfs_open+0x3b/0x340 fs/open.c:1095
 do_open fs/namei.c:3887 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4046
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa99d78ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa99e561038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fa99d9c5fa0 RCX: 00007fa99d78ebe9
RDX: 0000000000000000 RSI: 0000200000000100 RDI: ffffffffffffff9c
RBP: 00007fa99d811e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa99d9c6038 R14: 00007fa99d9c5fa0 R15: 00007ffcadbf0f68
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_es_cache_extent+0x698/0x700 fs/ext4/extents_status.c:1012
Code: ff df 80 3c 08 00 74 08 48 89 df e8 c2 a7 b3 ff 48 8b 3b 48 8b 74 24 28 48 8d 54 24 60 e8 00 c3 0d 00 eb 14 e8 89 ab 4e ff 90 <0f> 0b e8 81 ab 4e ff eb 28 e8 7a ab 4e ff 31 f6 65 ff 0d 01 71 50
RSP: 0018:ffffc90002bcf420 EFLAGS: 00010293
RAX: ffffffff82711f17 RBX: 00000000ffffffff RCX: ffff888033530000
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000000052ce
RBP: ffffc90002bcf528 R08: ffffffff8fc3c837 R09: 1ffffffff1f87906
R10: dffffc0000000000 R11: fffffbfff1f87907 R12: 00000000000052d0
R13: 0000000000000004 R14: 00000000000052ce R15: dffffc0000000000
FS:  00007fa99e5616c0(0000) GS:ffff88808d007000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc8e551f4c CR3: 0000000042911000 CR4: 0000000000352ef0


Tested on:

commit:         51a24b7d Merge tag 'trace-tools-v6.17-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=114f72e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=038b7bf43423e132b308
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=138cfd34580000


