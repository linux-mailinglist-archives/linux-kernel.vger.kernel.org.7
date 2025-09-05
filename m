Return-Path: <linux-kernel+bounces-803397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62489B45E99
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752FB172318
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D22306B3A;
	Fri,  5 Sep 2025 16:48:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B35259CB3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090885; cv=none; b=TYQ8ytlgYoJ0CUm1Ti3iS0IfEXENrw6PgVy+F2trC6SIlYs7wvhelc8DQpLHksvY4QZEXwfAW6LWVVt4TFFCfE8KEBjBskP0QSrqu/J1qBXMarUZFzkQyRw4ZxMpKkeA3N00AJkCBGuBS1Ca6laoJAvx0XwAfAfKYPPLtU0GSOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090885; c=relaxed/simple;
	bh=vpFAyupKqUIPxdB7EanQJ7sA9RfZSCYLMiZsN1o0ESg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j8XMthYDrG89/s5sTg8EPMaIfIL9bYJR2t5+xqGg1gRhnM1nExhLWTh2BlrQnZ7hLP/wKu4bV8S3nAXB9wRYx1XX09+//QOdGvj+EGK3x94FyKOW2UfzBUhGiMkzCz9/SiuaUdum0KshFDgFCS4FmnblqSCnyiUDmD2oIGcntP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3f0c32654afso21838825ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757090882; x=1757695682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wu/5ukm0ZlTlcgF4Blqa4i3v1Jijb97FpXJs2n2sI7w=;
        b=o76GxUYoLKQt31yAn5SdWtm3jf9pGTbRdyTi1avxRL1l26uTfzVnSvrNsM7+bPYaav
         K76MPUGvbwAOs2rBAblX1mmhvvSV83RuN2ySLdCYkzR/CkGAJSprfb0pqwTdgeOkhjyx
         lhSCTaNdIariDO7EireM7TaE/Ocey50iIbNHKzq+NdOwVrNjSfYcTCXLJfFx+u9BgQkJ
         iVJ0wPlh+RcxMLAm8R9M78jId/PmnYMgl9KFpeYyCwjB0uySY2SfL93QsBAyBCxpFdex
         FZolXClB1jBUnw6rZGyWDh2efM2e8g/VRpBLjyXPtC+TDnkYTsJNqMOhPPJkHeLnTpND
         2OFg==
X-Forwarded-Encrypted: i=1; AJvYcCWTOeQzPjLl48hD7aLLb4psK3lFaSav5liK62xNuj61Sr58CeAekkgvIc4DDfCziWdg3POIT926EQ0XB9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEtQjGXkF+7Iz/KqwP2YX5/dzJ97+Syk3XUUGsoQXDk8QFxb2H
	NpJDbxb8cUV3rq5yilmv+7RxEbiXC7FusVXiGE7la9QwOg289cRp656ta4DFeP6PStqyvMXkZK8
	7BcYr7Uz1y/9O2PvRHiLIE+SymSwqwBtwwENaOnhDLl9+qBqlzzhhRpensVM=
X-Google-Smtp-Source: AGHT+IGIDS7a4z+EuDQHwpKYUNd2f0KIepTXhtKNl9epzuiHt3xEpg4nv/Gl7P2dl+jDGxn9tFdn5byIlGJL7wX1q5XmbYhCLOXg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2703:b0:3f3:dd9a:63e4 with SMTP id
 e9e14a558f8ab-3f7b6fb55e4mr57890345ab.0.1757090882595; Fri, 05 Sep 2025
 09:48:02 -0700 (PDT)
Date: Fri, 05 Sep 2025 09:48:02 -0700
In-Reply-To: <20250905160645.4152096-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bb1442.050a0220.192772.0195.GAE@google.com>
Subject: Re: [syzbot] [media?] BUG: corrupted list in az6007_i2c_xfer
From: syzbot <syzbot+0192952caa411a3be209@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in az6007_i2c_xfer

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(__owner_task(owner) != get_current())
WARNING: CPU: 1 PID: 6699 at kernel/locking/mutex.c:933 __mutex_unlock_slowpath+0x528/0x7b0 kernel/locking/mutex.c:933
Modules linked in:
CPU: 1 UID: 0 PID: 6699 Comm: syz.3.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__mutex_unlock_slowpath+0x528/0x7b0 kernel/locking/mutex.c:933
Code: 08 84 c9 0f 85 78 02 00 00 44 8b 15 f2 d0 1a 05 45 85 d2 75 19 90 48 c7 c6 a0 5a ad 8b 48 c7 c7 60 56 ad 8b e8 79 59 ea f5 90 <0f> 0b 90 90 90 48 c7 c1 80 40 e3 9a 48 b8 00 00 00 00 00 fc ff df
RSP: 0018:ffffc9000381f938 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff817a2388
RDX: ffff888030cbc880 RSI: ffffffff817a2395 RDI: 0000000000000001
RBP: 1ffff92000703f2c R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000003
R13: fffffbfff35c6810 R14: ffffc9000381f9c0 R15: ffff888022ff8000
FS:  00007fd9a0eac6c0(0000) GS:ffff8881247e3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557fb7ffc108 CR3: 0000000022b5f000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 az6007_i2c_xfer+0x8a3/0xa90 drivers/media/usb/dvb-usb-v2/az6007.c:832
 __i2c_transfer+0x6b3/0x2190 drivers/i2c/i2c-core-base.c:2264
 i2c_transfer drivers/i2c/i2c-core-base.c:2320 [inline]
 i2c_transfer+0x1da/0x380 drivers/i2c/i2c-core-base.c:2296
 i2c_transfer_buffer_flags+0x10c/0x190 drivers/i2c/i2c-core-base.c:2348
 i2c_master_recv include/linux/i2c.h:79 [inline]
 i2cdev_read+0x111/0x280 drivers/i2c/i2c-dev.c:155
 do_loop_readv_writev fs/read_write.c:847 [inline]
 do_loop_readv_writev fs/read_write.c:835 [inline]
 vfs_readv+0x5be/0x8b0 fs/read_write.c:1020
 do_preadv+0x1a6/0x270 fs/read_write.c:1132
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd99ff8e169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd9a0eac038 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00007fd9a01b5fa0 RCX: 00007fd99ff8e169
RDX: 0000000000000001 RSI: 00002000000025c0 RDI: 0000000000000004
RBP: 00007fd9a0010a68 R08: 000000000000007e R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fd9a01b5fa0 R15: 00007fffaa2a4bc8
 </TASK>


Tested on:

commit:         d69eb204 Merge tag 'net-6.17-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a31962580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b271b97d244fd0a
dashboard link: https://syzkaller.appspot.com/bug?extid=0192952caa411a3be209
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13626134580000


