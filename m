Return-Path: <linux-kernel+bounces-804152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3278FB46ACC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFB45C01A1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 10:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF9928C03E;
	Sat,  6 Sep 2025 10:24:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D3D217704
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757154246; cv=none; b=hvWEZO64h5wCK2y6X9JCJQ+OAnU8GRVNEIoNtPDWDy7KbBhE3tbJz+ovxemY5xyLlGnvj5WRdj9Pb7Xqo+ag/k+d7n0cEysK3ajnm5YoSiPi5uVM2iohTwiOsJl+phdSprbrGxJhhQbbXcUGAMjdyOC4Zr5ykM8OUPpcK2ct+MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757154246; c=relaxed/simple;
	bh=PnPj4lgAf8sQLQh6W3X0Dm0o0seN+WZKd5ecozOohk0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Psa47IG11Zpv6+BZYhfX/vmUfhJ917ksID4aMlGQN23oBEjuC5kYQykmDYAEgEMz+8oH3qVqhfkT5gH2eeDubp0xTjxRAwZBiPDdsSG2VYssUCNiWg9zoBOii7qoTdHxrFBJ1JHZVlpwddpPc+NJo5qkvyDgxg5vGuU11+hT9u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-40194dd544eso364455ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 03:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757154243; x=1757759043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bqVxasFx0f2YshXKgDEHGIEPl6nT+Omnjx6a/pDg4og=;
        b=Q1qz56FUO9sfvdYMyyaEa/+GAD6XJGqgh5gdqnXwCMyZx8feG+yeK30cOel1Vdt2ye
         W2B3AlNRBmKeY+LsV3364+l+TyEVRZ6nWWDCCtzaCIyWEqLx0PruTv462lJwuQv2y/JV
         B71/ZpwlNbNnPK+kyxbmiRL+jatGcSg0CKYtg1zssHR533hD7hO11dXy+jbIXQD9KvLL
         qRujWFf0w9gxsIH69bzeVDYwjnmyYv4FlPYuZoeQmb2QCF7AQVVOgzohRxeTKPW8ziJp
         MBx7xy3ENJFn/rfzKmxd2KR9shQM3J9TGSNQ2M8LZwUc/KYXKJ92vpMUDbBT8IVkPdUE
         OW9A==
X-Forwarded-Encrypted: i=1; AJvYcCWEKawZZiHkmILa8Av+BTQDemxiu2HdJJSuD0qd5iUwcujbEN6iQklPcoZ7oQ7EeVCfVX6joIu27JZqjdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRWHwyNWot+8uMCBkmZLJYkWYYKZ6PcsdlwzOMfSf1y/dtM64p
	pZaBCl6MGvTBZAtPYQYk5OozfaaqOdB0wW1QoZdC5/zXaVWk9bV9H8iJsV2nFn8o75RUe2FNYmG
	YkQo2Ji7zBJhWgKLLoMZA4TvmQ+OQ3XWo2kMlscOX0mNL/yNf//K8aXyfO0c=
X-Google-Smtp-Source: AGHT+IEsAR1UUovtyYMLH3RRr9c/d4fmemFfDKRJI2IHVRnNdVD6Kr2DqDpU0cpZTxFFKRa4TcP/r5TCbnU/gYQEZkmpHcBd6b9a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9d:b0:3f6:80ec:bae with SMTP id
 e9e14a558f8ab-3fd853158bamr23643845ab.21.1757154243427; Sat, 06 Sep 2025
 03:24:03 -0700 (PDT)
Date: Sat, 06 Sep 2025 03:24:03 -0700
In-Reply-To: <20250906100415.80589-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bc0bc3.050a0220.192772.01aa.GAE@google.com>
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
WARNING: CPU: 0 PID: 6849 at kernel/locking/mutex.c:933 __mutex_unlock_slowpath+0x528/0x7b0 kernel/locking/mutex.c:933
Modules linked in:
CPU: 0 UID: 0 PID: 6849 Comm: syz.4.34 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__mutex_unlock_slowpath+0x528/0x7b0 kernel/locking/mutex.c:933
Code: 08 84 c9 0f 85 78 02 00 00 44 8b 15 f2 ba 1a 05 45 85 d2 75 19 90 48 c7 c6 a0 5a ad 8b 48 c7 c7 60 56 ad 8b e8 79 39 ea f5 90 <0f> 0b 90 90 90 48 c7 c1 80 60 e3 9a 48 b8 00 00 00 00 00 fc ff df
RSP: 0018:ffffc9000423f928 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88802ada2440 RCX: ffffffff817a2388
RDX: ffff888031ee8000 RSI: ffffffff817a2395 RDI: 0000000000000001
RBP: 1ffff92000847f2a R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 284e4f5f4e524157 R12: 0000000000000003
R13: fffffbfff35c6c10 R14: ffffc9000423f9b0 R15: ffff88803569c000
FS:  00007f0c02ffb6c0(0000) GS:ffff8881246e1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005652c153a008 CR3: 000000005260a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 az6007_i2c_xfer+0x619/0xb30 drivers/media/usb/dvb-usb-v2/az6007.c:851
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
RIP: 0033:0x7f0c0218e169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0c02ffb038 EFLAGS: 00000246
 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00007f0c023b5fa0 RCX: 00007f0c0218e169
RDX: 0000000000000001 RSI: 00002000000025c0 RDI: 0000000000000004
RBP: 00007f0c02210a68 R08: 000000000000007e R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f0c023b5fa0 R15: 00007ffc233dccf8
 </TASK>


Tested on:

commit:         d1d10cea Merge tag 'perf-tools-fixes-for-v6.17-2025-09..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1351a962580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bce5d4c1cf285a6c
dashboard link: https://syzkaller.appspot.com/bug?extid=0192952caa411a3be209
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1341a962580000


