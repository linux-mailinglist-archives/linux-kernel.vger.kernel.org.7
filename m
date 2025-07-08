Return-Path: <linux-kernel+bounces-721185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A26AFC5DE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865121662C0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE946221FB5;
	Tue,  8 Jul 2025 08:38:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258812BCF4D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963884; cv=none; b=o8MjSZ0paGaXaDqdR7oaSoDIvjFh06rDKJ8P3fxngdVLxhxeLU64EiiIGHtp1QjdlDfrINKo7GoF9LFb5Cn51neNGdtDU3NGVJvEmyTinHGcYo1S2f7U67dtnZ1bXQqJM7PqWoU++cMF/wz044428rEug37HeyWgjUcpFPE7b1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963884; c=relaxed/simple;
	bh=AfCRptvM+8vPR0YsPkweAVjbdKNVmdEuWNbW9x5kht0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EQbN23nELVxJGXQXStog90nJKcjBPh7qZwUX0zbpV2hvPKhMoBgPP7r3yLrY9AgVla4Cz3m8cTbBlzFGGBzutPtoFX8ooQfkEcq+ePNjXuCeOyQvoHR4ZZrwhg5cKtHuLg89zGrl+De68PUIfBjkXHyyA6MUcZWhVXGtN34eyBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3df2d907c23so18602025ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 01:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751963882; x=1752568682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FP5ANYKkfvQ6lu6trr2cX17en6Ozu8rR1+B7KUQBXsU=;
        b=HuRYqfSAXr/uFdHSCOIYWah1EDDcdNlaO9x5JHxUepoEs0jh5sY64V1F1NUi6YtuQS
         rVftisIqVSwQc0E1jgDT7ijf0gQZbCRntKHNBZGBP70zmMMRxywH/KqG0UTuXT0e0kFi
         6HDKtNWAgL+LeheFOc74qAheUNWIlE6nlUS05b9k/HkF0zOTokPf/rm/BEXoJvO4mWAn
         vGLtSp4PHECfvEIDW7luQODedkjZJpHHXVxfHJyWHF9nKrKfEeRYS5qD2Gryb5dFvyqa
         Lbe4RKo60ek1cMq4l3kQSLX8Nz3C/HZ87zKQZNADD4Wl1qE+SB7ohbQDoFrrgp5eZKuY
         KkJA==
X-Forwarded-Encrypted: i=1; AJvYcCUDUravbCEmSemTBFNbkoXsrVIo3BmDUtcVV9rmDmH/YbYB+WyqP5dDJtUbanFzCVlukTytw8lpb/v0krc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylbRfJjj47w40EHkO620NgVd7/2aimJDq0LgRjl5WVrHiGnIrq
	+PlpRDI9IvlK1C4IVep0uirtDGMkCLuIHCZp0M2KiAzYrHmPagPtbwQO4C4kHHOFhNb3WawIsdX
	nLkKjVYmIFQigbAAjLo0o6Z+FsJhyWzCXAH3Tq4YU0IfXNf/4ONGyD1mlIB8=
X-Google-Smtp-Source: AGHT+IH3jsYpnC+LlP/QNW/8dzjyMyCsvVGskrcx72E0sGcP0xzTu++E01MJKP7Hn7jRLn2/zFAZd6vM8K0gVU/Cx96F9W0nGShm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f:b0:3df:3bc5:bac1 with SMTP id
 e9e14a558f8ab-3e1538fd850mr26479275ab.5.1751963882275; Tue, 08 Jul 2025
 01:38:02 -0700 (PDT)
Date: Tue, 08 Jul 2025 01:38:02 -0700
In-Reply-To: <CAF3JpA5ZaFem=oPLQbuE4ThT0wpmkw-y-hSvypWu1-evpx8TrA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686cd8ea.a00a0220.338033.000a.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in ni_rename
From: syzbot <syzbot+b0373017f711c06ada64@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	moonhee.lee.ca@gmail.com, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in ni_rename

loop0: detected capacity change from 0 to 4096
------------[ cut here ]------------
WARNING: fs/ntfs3/frecord.c:3030 at ni_rename+0xee/0x100 fs/ntfs3/frecord.c:3029, CPU#1: syz.0.16/6603
Modules linked in:
CPU: 1 UID: 0 PID: 6603 Comm: syz.0.16 Not tainted 6.16.0-rc4-next-20250704-syzkaller-07381-g26ffb3d6f02c-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:ni_rename+0xee/0x100 fs/ntfs3/frecord.c:3029
Code: 8b 05 b6 5d 9a 0f 48 3b 44 24 10 75 22 44 89 e0 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d e9 d9 a6 6c 08 cc e8 f3 7d b9 fe 90 <0f> 0b 90 eb c5 e8 68 cc 69 08 0f 1f 84 00 00 00 00 00 90 90 90 90
RSP: 0018:ffffc90003007ab8 EFLAGS: 00010293
RAX: ffffffff8306228d RBX: 00000000fffffffe RCX: ffff8880274e5a00
RDX: 0000000000000000 RSI: 00000000fffffffe RDI: 0000000000000000
RBP: 00000000fffffffe R08: ffffffff8fa18a37 R09: 1ffffffff1f43146
R10: dffffc0000000000 R11: fffffbfff1f43147 R12: 0000000000000000
R13: ffff88802d5e3300 R14: ffff88805b6e8758 R15: ffff88805b6e66d0
FS:  00007f5d3eea16c0(0000) GS:ffff888125d18000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001060 CR3: 0000000032258000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ntfs_rename+0x6e2/0xb40 fs/ntfs3/namei.c:316
 vfs_rename+0xbd7/0xf00 fs/namei.c:5129
 do_renameat2+0x6ce/0xa80 fs/namei.c:5278
 __do_sys_rename fs/namei.c:5325 [inline]
 __se_sys_rename fs/namei.c:5323 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5323
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5d3df8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5d3eea1038 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f5d3e1b5fa0 RCX: 00007f5d3df8e929
RDX: 0000000000000000 RSI: 0000200000001040 RDI: 0000200000000280
RBP: 00007f5d3e010b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f5d3e1b5fa0 R15: 00007ffe542eb158
 </TASK>


Tested on:

commit:         26ffb3d6 Add linux-next specific files for 20250704
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1484abd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59817f9ef599726c
dashboard link: https://syzkaller.appspot.com/bug?extid=b0373017f711c06ada64
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16ecf28c580000


