Return-Path: <linux-kernel+bounces-804059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE6CB4695B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 07:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63FB73B7A43
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 05:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C9A27B32E;
	Sat,  6 Sep 2025 05:54:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B7B4C85
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 05:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757138046; cv=none; b=lsZ351k09ODMZb3i4Ec2fQbqdzRhur5708DEVJZGLi0TwAgLu/r1UPTPzT//4NKI0CoSdeUbvWtazpE3xbyXWbyQHEp9irvu3WGbGoe7g4Ks5ExG9DKUED8lH6LX5qF+3gHPKcynkXLln4/a3w/QT79ZSDWMQ6coscuiZa84Dco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757138046; c=relaxed/simple;
	bh=fF7Wi/cpc2nt6QylKcMoy9Rm+ZuHIrT0O2hmI06OF8s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=txX2wUObRPN8HMI7KJkbTIrcoZmpd00MKIKo2Xg/ER74Ys4z6C20imUWRuPiCSWZT/ex430HW+HCg891x5I5OCBJiV36T2oyZ71V/yJXeyF/DYig6NUbWc5Rg1KD8cJveL7a9eFaxIBzZcCk7PDNLaqTKy5tM6Pa9r5Ns/HGHGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8875735aecfso918616339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 22:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757138044; x=1757742844;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDMNtQEYtHCzzkEaVgJxszKxDq8bvlphez7b5kaFw6M=;
        b=Y3poBzHgg/hC7/I2JHA2p9KhtewgJrV0bi+mF6hJr46ag9dyKn/KiJLofabdSCU/mv
         AleZZ5JkCk+oDi2c4KMw2+yP0A5lPJE4rg3Xr9qinCsn0V5wJrVNdO/Re6gHEU5M+loA
         2EneDEWRJQNcbIui0uQiei3sUhqjD2Xos2y5bUVuzCL6XGxdONNyaWY/KPPmog4J6BEw
         YWG4bPcwAiT6sMY6iLe38xIBlaTV65on/CPKCU/LpcFPwOdgJHnpZXp0FIQDEd8SMrzA
         k8WBgKfmV9SbZDtdrPCwJQ/NpVmFubAG0+79JhUWO/nc7FiyiBwE8GxJTjlLY1Uc7Vfm
         zX6A==
X-Forwarded-Encrypted: i=1; AJvYcCVF8x1ZSLXCw0rlznDJWkhbFpB71LfK5H3SCWhqL6l6Xv71Be8zrAbbKIYyQlSeS3LlfMaYe5uE0oUnvIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOKlMUZWHUbe9VAlWoV+nLfNF8y9ANc29GQqARaVDKif9Ro12Q
	P04RSgBrxFCNFC2Z2ZziV4e/LN82gZn5BD73PMXaIq1tDnB/cYTfCIO55ti4ouXaOYiJDcJG8wA
	pmcQ0I8xmPhw2Jc/osRth8D0AP3uxK3Mtt6RVCkbt4jDkM37Ucc9saSCqf6E=
X-Google-Smtp-Source: AGHT+IGXsgv5dTjVfNVYsmxiBgaj84EnzJdLUUKRVc05EXfXtx1WjbRZNsgztA7LtTkrHWXd/dUtUdRgCnPp6Eu1af8QlqY0f12t
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:640b:b0:873:f23:ff5 with SMTP id
 ca18e2360f4ac-8877768cf07mr166943239f.12.1757138044030; Fri, 05 Sep 2025
 22:54:04 -0700 (PDT)
Date: Fri, 05 Sep 2025 22:54:04 -0700
In-Reply-To: <20250906045607.41590-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bbcc7c.a00a0220.eb3d.001d.GAE@google.com>
Subject: Re: [syzbot] [media?] BUG: corrupted list in az6007_i2c_xfer
From: syzbot <syzbot+0192952caa411a3be209@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in az6007_i2c_xfer

az6007: tried to read 4109 bytes, but I2C max size is 4096 bytes
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(__owner_task(owner) != get_current())
WARNING: CPU: 0 PID: 6583 at kernel/locking/mutex.c:933 __mutex_unlock_slowpath+0x528/0x7b0 kernel/locking/mutex.c:933
Modules linked in:
CPU: 0 UID: 0 PID: 6583 Comm: syz.0.16 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__mutex_unlock_slowpath+0x528/0x7b0 kernel/locking/mutex.c:933
Code: 08 84 c9 0f 85 78 02 00 00 44 8b 15 f2 ba 1a 05 45 85 d2 75 19 90 48 c7 c6 a0 5a ad 8b 48 c7 c7 60 56 ad 8b e8 79 39 ea f5 90 <0f> 0b 90 90 90 48 c7 c1 80 60 e3 9a 48 b8 00 00 00 00 00 fc ff df
RSP: 0018:ffffc90003a77928 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888031910000 RCX: ffffffff817a2388
RDX: ffff8880269ca440 RSI: ffffffff817a2395 RDI: 0000000000000001
RBP: 1ffff9200074ef2a R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000003
R13: fffffbfff35c6c10 R14: ffffc90003a779b0 R15: ffff888034e30000
FS:  00007f21b41c16c0(0000) GS:ffff8881246e1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffff5afe0c8 CR3: 000000005b1e0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 az6007_i2c_xfer+0x619/0xb30 drivers/media/usb/dvb-usb-v2/az6007.c:836
 __i2c_transfer+0x6b6/0x2190 drivers/i2c/i2c-core-base.c:2264
 i2c_transfer drivers/i2c/i2c-core-base.c:2320 [inline]
 i2c_transfer+0x1da/0x380 drivers/i2c/i2c-core-base.c:2296
 i2c_transfer_buffer_flags+0x10c/0x190 drivers/i2c/i2c-core-base.c:2348
 i2c_master_recv include/linux/i2c.h:79 [inline]
 i2cdev_read+0x111/0x280 drivers/i2c/i2c-dev.c:155
 do_loop_readv_writev fs/read_write.c:847 [inline]
 do_loop_readv_writev fs/read_write.c:835 [inline]
 vfs_readv+0x5c1/0x8b0 fs/read_write.c:1020
 do_preadv+0x1a6/0x270 fs/read_write.c:1132
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f21b338e169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f21b41c1038 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00007f21b35b5fa0 RCX: 00007f21b338e169
RDX: 0000000000000001 RSI: 00002000000025c0 RDI: 0000000000000004
RBP: 00007f21b3410a68 R08: 000000000000007e R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f21b35b5fa0 R15: 00007fff05cabdd8
 </TASK>


Tested on:

commit:         d1d10cea Merge tag 'perf-tools-fixes-for-v6.17-2025-09..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1772ba42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bce5d4c1cf285a6c
dashboard link: https://syzkaller.appspot.com/bug?extid=0192952caa411a3be209
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13080962580000


