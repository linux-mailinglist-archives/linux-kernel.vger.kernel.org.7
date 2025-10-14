Return-Path: <linux-kernel+bounces-853029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E159BDA7B5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65BDB19A1A59
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4758A3009CA;
	Tue, 14 Oct 2025 15:50:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499612FF166
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457004; cv=none; b=jP5ZGHZm7ABV1uC5gTAlarWb9IEigWrnUDIFRVp5sUyvYfod6FsPyyuqFmZ13ZHHWNo2g4tiS0vaA6S1RqEymSU2CHbYtmvOlNUd0O5aIPuoHY+7cw9AA8m/hBMiD3WLNW99FLhQuKqkQ48do2huO3eJ/q8YA6wjWRY2DecYMH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457004; c=relaxed/simple;
	bh=FghIUoCkYeS7U2pglUXDq90HJmcce0kwzidU+OmxqvU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kz7vx0Qk3+D7qUqn9YHzkkhoefjm2gV8nZ/LAB8OY+pj+6YBgIjlIeYWeOlfliJtGymZtiGlBzIA1g6zIJ1D7AHY6HH0mpINkeaLQ5ouRxGuhhg0JwfWc93iQIuwWpCf+z6FgEu9TGVmYxaLsUYwKidZV5A4DOxIQaCSxvcdECQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4257567fb7cso136160425ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760457002; x=1761061802;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQ1KiN0D/BxhYpxPMTYUlzas285aubBVUbcG/oeFcIY=;
        b=xVTocajQgRTguz+rdZLKiZRK9SDej6lrDYA0ka7cG3+mBvYqFuZ7SoUx35l3JY67Xn
         FVc6n2U1Yx2VeqrlX7peTEna0NQJvQEJ9THNt3oci5JZVvdnlb6YIVTeE8iyVkBe18yd
         Np4HCm4CtTOYHNKMwGFEhlXHqtXooBCA3c0o+5gwK6wbMo2K3X9/+z8Xx8nY0Y18l8PA
         vkoYKmMl50CPV2LaqTD4B0744I2fAM2Gr8yYfIcFbzwf6W8uJcXcROB9AxMC0NMJ2u6a
         ci85GM628O2isIwroFB2ADem6JLdEWqSYzhh08QQ6afiboxsVjYeXfnedlEag5B14mhh
         RbGw==
X-Forwarded-Encrypted: i=1; AJvYcCWcl/4di07hZpweBvSIcT3H/7SyRH+0jfNvgenO1drvAOmalNejDA/v8plHOfpsLUoVJUgWW4JFbxhYz4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBxxPMZNUpIVt/T4GLdTFXo22QZF0nQKaXCpM2gqms4ccgD5Mt
	WM77+eLcSevBCs5URBh+zR7ufz3DMBHR/pL5pYvV2kCsV9R+6hXY60OyiMR/jHc59E0yCZX2mq3
	Kjdp2KxnFdyqkvucO5GURJ7HX4U7Fc4ihjmKlwzwoiszlTDpxq2nrQ5CRXD0=
X-Google-Smtp-Source: AGHT+IHb78LHdAsmVHl0mtSS5fLriOkhyOnsS/qv8gcBV6X+6+toJDnqoTV7pJOY/KCGQrGHCV17/Mkd+KRIMA2bEcmls8LD5JDT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174e:b0:430:ab46:8f9e with SMTP id
 e9e14a558f8ab-430ab469b4emr2143895ab.28.1760457002416; Tue, 14 Oct 2025
 08:50:02 -0700 (PDT)
Date: Tue, 14 Oct 2025 08:50:02 -0700
In-Reply-To: <1558240174.1174599.1760455481777@kpc.webmail.kpnmail.nl>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ee712a.050a0220.1186a4.0034.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in minix_rename
From: syzbot <syzbot+a65e824272c5f741247d@syzkaller.appspotmail.com>
To: jkoolstra@xs4all.nl, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in minix_rename

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6502 at fs/inode.c:417 drop_nlink+0xc5/0x110 fs/inode.c:417
Modules linked in:
CPU: 1 UID: 0 PID: 6502 Comm: syz.1.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:drop_nlink+0xc5/0x110 fs/inode.c:417
Code: 70 07 00 00 be 08 00 00 00 e8 57 df e7 ff f0 48 ff 83 70 07 00 00 5b 41 5c 41 5e 41 5f 5d e9 92 ba f1 08 cc e8 9c d7 82 ff 90 <0f> 0b 90 eb 81 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 5b ff ff ff
RSP: 0018:ffffc90003cefa30 EFLAGS: 00010293
RAX: ffffffff823cc9d4 RBX: ffff8880560b0fe8 RCX: ffff888058c0dac0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8f5a6577 R09: 1ffffffff1eb4cae
R10: dffffc0000000000 R11: fffffbfff1eb4caf R12: 1ffff1100ac16206
R13: 0000000000000000 R14: ffff8880560b1030 R15: dffffc0000000000
FS:  00007fc01f0c26c0(0000) GS:ffff8881264ca000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc01f0c1f98 CR3: 0000000032b16000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 inode_dec_link_count include/linux/fs.h:2655 [inline]
 minix_rename+0x3cf/0x700 fs/minix/namei.c:228
 vfs_rename+0xb34/0xe80 fs/namei.c:5216
 do_renameat2+0x6a2/0xa50 fs/namei.c:5364
 __do_sys_rename fs/namei.c:5411 [inline]
 __se_sys_rename fs/namei.c:5409 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5409
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc01e18e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc01f0c2038 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007fc01e3b6080 RCX: 00007fc01e18e929
RDX: 0000000000000000 RSI: 00002000000001c0 RDI: 0000200000001980
RBP: 00007fc01e210b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fc01e3b6080 R15: 00007ffc5451e3e8
 </TASK>


Tested on:

commit:         3a866087 Linux 6.18-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17642c58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4dacb8e711c7e98e
dashboard link: https://syzkaller.appspot.com/bug?extid=a65e824272c5f741247d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=126705e2580000


