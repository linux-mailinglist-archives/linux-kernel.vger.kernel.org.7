Return-Path: <linux-kernel+bounces-881868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 01099C291AA
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 17:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9E9D347642
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3462224B1F;
	Sun,  2 Nov 2025 16:12:09 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA47134D3BD
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762099929; cv=none; b=MNrQALwLJGPGM4GEFe7lAXHrnMW0WkJgKoE9q17pKaNQsnkfrI1F66yEil3oEzCKJDIdrW+qeuw3iKZA4MzXBs3dscZeW/tw96ldSqEl6XjKOCKFdNNhDvws+uImhw0F3ElLqjvpw/znrXYKeW3GODf8pO1tSoAwU4BTgJtgKVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762099929; c=relaxed/simple;
	bh=uM18kc2ZM4sZ4LvqUqOHsCF2x/JnWt+Wtz2HECvfUiQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uf/2RqSEWViff+FHwvYDInE4zC/heA79GmxsU3TdSzpIdQ38gXaIPoPLOH+Lt5XSbHUCvJlMtcZ5k68FT/TKDbMUSjR7tMCYpD/S7Ueoz97SVmGv8/7fpjqqer7TJoJtqZSiB0FUGUEkKuQQdVu0DcaGPYJkaXDdVG4870HxWok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-937e5f9ea74so514100739f.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 08:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762099924; x=1762704724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCbKtKemi+gmlwMzoNrJ2zPYZkwedy4TXqKQRGEKjlA=;
        b=omvTeHzRpenq9Jb/FZFbjvqU5moSg9DPT+8q7eG0C4TCQqfmZOFrRp/Sn05aovgn5f
         pH/6BTuJy1ZIOqV+XfLBB7ID2XBu/aArWbiMbCXAG9uptJC88OMWFEObgfIvWO/G7EE2
         KOOsbB5G6BntdmsldqS+406MecSvfdaQdtOgioELa0gYfgUyeR/z0udDoP/kfHa3UtwH
         ksAXFm/36MDO3wOD+OIVV1Ah4Z3zNZASBezL4LgKy4TAoRpvzdp+DyHlo8lUIhEAFMH9
         ZpKDxphzK4dQS7jws4uQfT7sdANfNxOixqPg2DPLv8iWvT0KMD8wnsSSJmrSyhDqzDrj
         L4BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFPKNa71HuEf9oiy8iAsdDH7qHxO5sa69VHyEwlmEXhlIfki8w/LRReHyA8U2AbJp1GX8vvUE6kf6v1Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvHemngIwAy5j2x6dnd3YBjS4ne6kk48i8q6iPo2NeXsHiiNfe
	WJ1jO5mttHEKighqwubRzOpeWTVq28cb+VBdxtl2yiuTf4bye5k1z0r7J//oNRiIN4Qxbrd2quH
	EJzfWaZQ6gVJ3owDE6ZvOluwXGcDogmnMbt8/tc8eATfcRavT0PTLbiSNWGc=
X-Google-Smtp-Source: AGHT+IFM7bvQLEsyqxzKU/JVsGiXvvabpnDsHjnZTGZj1mnVxocf+6E9wvmwMCBiX+N1029X0kC9s/co9a9ZbrRQZG/lunUtwjav
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3498:b0:433:2597:8cc with SMTP id
 e9e14a558f8ab-433259711f3mr61058085ab.29.1762099923824; Sun, 02 Nov 2025
 08:12:03 -0800 (PST)
Date: Sun, 02 Nov 2025 08:12:03 -0800
In-Reply-To: <857840797.3476876.1762098642816@kpc.webmail.kpnmail.nl>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690782d3.050a0220.29fc44.0026.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in minix_rename
From: syzbot <syzbot+a65e824272c5f741247d@syzkaller.appspotmail.com>
To: jkoolstra@xs4all.nl, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in minix_unlink

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6330 at fs/inode.c:417 drop_nlink+0xc5/0x110 fs/inode.c:417
Modules linked in:
CPU: 1 UID: 0 PID: 6330 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:drop_nlink+0xc5/0x110 fs/inode.c:417
Code: 70 07 00 00 be 08 00 00 00 e8 47 dc e7 ff f0 48 ff 83 70 07 00 00 5b 41 5c 41 5e 41 5f 5d e9 d2 6f f2 08 cc e8 7c cf 82 ff 90 <0f> 0b 90 eb 81 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 5b ff ff ff
RSP: 0018:ffffc90002f27c50 EFLAGS: 00010293
RAX: ffffffff823cd494 RBX: ffff8880741d9a58 RCX: ffff888026821e40
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8f5a5977 R09: 1ffffffff1eb4b2e
R10: dffffc0000000000 R11: fffffbfff1eb4b2f R12: 1ffff1100e83b354
R13: ffffea0001c8f900 R14: ffff8880741d9aa0 R15: dffffc0000000000
FS:  00005555875cf500(0000) GS:ffff8881264c8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555587602688 CR3: 00000000336f8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 inode_dec_link_count include/linux/fs.h:2655 [inline]
 minix_unlink+0x1de/0x290 fs/minix/namei.c:157
 vfs_unlink+0x394/0x650 fs/namei.c:4673
 do_unlinkat+0x345/0x560 fs/namei.c:4737
 __do_sys_unlink fs/namei.c:4783 [inline]
 __se_sys_unlink fs/namei.c:4781 [inline]
 __x64_sys_unlink+0x47/0x50 fs/namei.c:4781
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7a5978ded7
Code: 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdec37a198 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7a5978ded7
RDX: 00007ffdec37a1c0 RSI: 00007ffdec37a250 RDI: 00007ffdec37a250
RBP: 00007ffdec37a250 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000206 R12: 00007ffdec37b340
R13: 00007f7a59810925 R14: 000000000001ff83 R15: 00007ffdec37d500
 </TASK>


Tested on:

commit:         691d401c Merge tag 'spi-fix-v6.18-rc3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16fda342580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=824b00f06adfda3c
dashboard link: https://syzkaller.appspot.com/bug?extid=a65e824272c5f741247d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=133f9012580000


