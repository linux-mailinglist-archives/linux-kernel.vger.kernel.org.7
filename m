Return-Path: <linux-kernel+bounces-804359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4781B47397
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841B9A439B0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 16:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79A1215F7C;
	Sat,  6 Sep 2025 16:09:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6E5AD2C
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757174945; cv=none; b=r+s7CeFyIiZAMx/LD9T8Z+hOF7u3aHT5TCGSun1th3isF2G7X4gZXcc/E1rmxcOyeRC8+7lD8P6DEVAFX5xDH1Sm2PxesL170mLrXUDNgHjd0psjCc/afgkMuEXbw9dEo8QmQn5Mv2m2kzaIFYWdyhGhZUdAkf+LL2f3c+O6EYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757174945; c=relaxed/simple;
	bh=GQZOH+hKK1c3MMLW71VLhm1ZIcEVUhro17kgzzLTvnY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GctXirlEzVjT8ZhJOgzPpUEeHePkkwQg6KuZygqhskkSVwv5R8biJCWbLCnn+2+WHnwGOQLxgQFAeNNpwwrVPJRTzJJzmOqoWJsuhhOFysA5OarOYkJy7YBo5JAbunGNzJbVeEW/EMrPxgie0+TmPK3xENaoJ533HYYyNmKu9do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3f6665a4754so77059975ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 09:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757174943; x=1757779743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6H24EAYH632uZmAhZjRyyaMlzOoii0BBoqBeAJmP44=;
        b=nf02DmZktDALv8vsMbcC9XMvK8lxCQ5W/Ddz1ZyK/p4K9V5fvBnz2BDQKkNtCXpjkk
         fk3O8CcR7ckKdIIMlWU/b2cE7hVnd0aCflt77GI2ZuUWyOZy2midCCOlbhVTeAxGrbwG
         J8YMG3QdHFfnTt1yaRt8M5X8ieAyp/VEAeVj8fIpRvicAiOGl2uZfkAFNkUAzHkL4g/b
         W6Y/L2Xt500SPL9C+Rm87pBBTvkI7mc4hQ5iyU3KoMo1ovTwxwY9wSF3Wq1xvFgjVwv1
         8KJeGdHnpZ8GAwPk//FmhQs/5xGQezuH2sd25nzYg+JVA1P6T1lodzy+ZmY6K+kkIlkm
         T/Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWGfSOx+l+bMKRGvmTkmB2JdHbdG/VN2fK5E1t/SC8lHPnABoBkI9wT/7MoU8TLH44VLGfuVOSB5iSKC0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAW7dQk5L+VAkflQwaQjmQ1pexIb5WJrgSX2VwZU2izZl6bAmZ
	yK1FKB7hhraDuhLwTyYN9je1kmexFrgBiz3EPKVlvm/wlJ/x1UPQnx3rXqhbTIyk97ngHCFGp7j
	EuKeaoUG4JCu+HLaBJivjr5IMoa/34kDa81roMpsvKutZfiXgzDqP3MFtJCM=
X-Google-Smtp-Source: AGHT+IHGAWMPEL/Mi5Yjb6kbNO9bxFcwKgTUCDYFUkl4On8OxQPE8BmlxJQ6IVYhq9FFvX22yCA78SKWqPxcBQm+bS1gHRacQEx/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:749:b0:402:c7f3:6d73 with SMTP id
 e9e14a558f8ab-402c7f36e62mr7040035ab.4.1757174942858; Sat, 06 Sep 2025
 09:09:02 -0700 (PDT)
Date: Sat, 06 Sep 2025 09:09:02 -0700
In-Reply-To: <20250906152420.141374-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bc5c9e.050a0220.192772.01ae.GAE@google.com>
Subject: Re: [syzbot] [media?] BUG: corrupted list in az6007_i2c_xfer
From: syzbot <syzbot+0192952caa411a3be209@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in az6007_i2c_xfer

az6007_i2c_xfer 8 : ffff88802743c880
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(__owner_task(owner) != get_current())
WARNING: CPU: 1 PID: 7034 at kernel/locking/mutex.c:933 __mutex_unlock_slowpath+0x528/0x7b0 kernel/locking/mutex.c:933
Modules linked in:
CPU: 1 UID: 0 PID: 7034 Comm: syz.3.115 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__mutex_unlock_slowpath+0x528/0x7b0 kernel/locking/mutex.c:933
Code: 08 84 c9 0f 85 78 02 00 00 44 8b 15 f2 ac 1a 05 45 85 d2 75 19 90 48 c7 c6 a0 5a ad 8b 48 c7 c7 60 56 ad 8b e8 79 29 ea f5 90 <0f> 0b 90 90 90 48 c7 c1 80 60 e3 9a 48 b8 00 00 00 00 00 fc ff df
RSP: 0018:ffffc9000420f918 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88802743c880 RCX: ffffffff817a2388
RDX: ffff888027188000 RSI: ffffffff817a2395 RDI: 0000000000000001
RBP: 1ffff92000841f28 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 205d313636365420 R12: 0000000000000003
R13: fffffbfff35c6c10 R14: ffffc9000420f9a0 R15: ffff888029d58000
FS:  00007f0406c336c0(0000) GS:ffff8881247e1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000025c0 CR3: 0000000062914000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 az6007_i2c_xfer+0x821/0xe50 drivers/media/usb/dvb-usb-v2/az6007.c:857
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
RIP: 0033:0x7f0405d8e169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0406c33038 EFLAGS: 00000246
 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00007f0405fb5fa0 RCX: 00007f0405d8e169
RDX: 0000000000000001 RSI: 00002000000025c0 RDI: 0000000000000004
RBP: 00007f0405e10a68 R08: 000000000000007e R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f0405fb5fa0 R15: 00007ffdf15e6ff8
 </TASK>


Tested on:

commit:         d1d10cea Merge tag 'perf-tools-fixes-for-v6.17-2025-09..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15986962580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bce5d4c1cf285a6c
dashboard link: https://syzkaller.appspot.com/bug?extid=0192952caa411a3be209
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12cda87c580000


