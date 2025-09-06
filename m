Return-Path: <linux-kernel+bounces-804019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 158D7B468CB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E5F1BC810E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8192248F7C;
	Sat,  6 Sep 2025 04:12:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4118238C0F
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 04:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757131927; cv=none; b=gxk1CujyT3rq2+d+jXEbz4YVv7gZhtwdDkYYh+aoNANZGCYJB2/q3nzTBd/9LoQLFtO/LwKyjScrMFjXsmyZSOibyPjOahhuZDAvyKb8F/u+XOsTT1zQ27SRfIQiVJDoDo46E61rZRrPP05f2p+gk5FKad1ILNUe5hIRIkc5qho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757131927; c=relaxed/simple;
	bh=eB/W4tkBPmMu6oLwf+rZqG2eTOgPjVzFf5ptCUd4s9g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hK+u0DwCQejuqFdn5HaH65trcYxlBwiK3gxRO0Y170hXmbnce3H4feqCdxDHacT/DOJT5CH+2R9Uo8VwcSETHLNzEPQE+dPR/3tPst9f1Pujg/WOgnC2bcicschWjtv53igMQ/KGl4YtHtn13RQZ0sWkGFmUQkrs8+Mv4Id77rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8876a952eccso168027339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 21:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757131925; x=1757736725;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfVZwPpTXhA3cwKje3bqf6wp+5ohNduT+A4cbC0mZws=;
        b=fHfJR03vutSYdvf1TweNEUubBr8Qw2R2TCa52/9RyOshETH19m3J/qIg8x5xlSPVNu
         r2+yIiEBIOQJCW4Oa333Q65kyBdQBXFtTK6st/nXo50CbiMx1baM73/OoZ94y7tFX9kc
         cdaLdpVD8yBbPSlycYFTLZ/Fis9IwiSz0NoNzeDpXBhLR91LHqfBg0dSHolJP4/UvoX1
         mQ24K4cjhp/wPNsuk1rSR0zmKo0w28oug4gYEfMmqIOcDcbFcicyQIy3J09pruGXcv03
         SKGHb/nzhV5LvBUMoB1xl8q0MHBD6bPfk3AKjAODM7ULdt7RAKrt/oIK5SFfLUzCvZqN
         u5cg==
X-Forwarded-Encrypted: i=1; AJvYcCVB0a7/1rvwP3biPjxvVLgHSGJ90wUsbNP+xgKxSLfvq5p3SXiT5X10ic1bYrdSOONYkJAGpnxwltavIf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm/pJzmTVc1nijkV+e54lkkQwLMN7++CwLgo9MlaBnl1SZ9oTv
	Kh1MOg/0RzrCVPGWmmCUfC7uVFu+9eZpFaaEJ1ODHsSyh6zSfV0GROIt357f/GqmDNfPzlU62Oj
	S6GTDB4onjVQUIb4KHWo4e+1T9Mx1cGYy71UIK7QXKUUed/gyIH/3ruZDINU=
X-Google-Smtp-Source: AGHT+IEyaGe0a58R/IDOnxbT8+kDg+CcWtYIp9YCqp2hX7eRFUMF+uXghjcVlc/LOYQeM1uaenQU5lx1pDVfKdEJf7TUl5dlkyk/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a41:b0:3f6:5688:a088 with SMTP id
 e9e14a558f8ab-3fd7fc2166fmr19874445ab.10.1757131924883; Fri, 05 Sep 2025
 21:12:04 -0700 (PDT)
Date: Fri, 05 Sep 2025 21:12:04 -0700
In-Reply-To: <20250906033247.31888-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bbb494.a00a0220.eb3d.001c.GAE@google.com>
Subject: Re: [syzbot] [media?] BUG: corrupted list in az6007_i2c_xfer
From: syzbot <syzbot+0192952caa411a3be209@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: array-index-out-of-bounds in az6007_i2c_xfer

usb read operation failed. (-71)
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in drivers/media/usb/dvb-usb-v2/az6007.c:821:30
index 4096 is out of range for type 'unsigned char [4096]'
CPU: 1 UID: 0 PID: 6553 Comm: syz.1.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:233 [inline]
 __ubsan_handle_out_of_bounds+0x11c/0x160 lib/ubsan.c:455
 az6007_i2c_xfer+0x549/0xc30 drivers/media/usb/dvb-usb-v2/az6007.c:821
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
RIP: 0033:0x7faff858e169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faff9313038 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00007faff87b5fa0 RCX: 00007faff858e169
RDX: 0000000000000001 RSI: 00002000000025c0 RDI: 0000000000000004
RBP: 00007faff8610a68 R08: 000000000000007e R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007faff87b5fa0 R15: 00007ffe8b6c0b08
 </TASK>
---[ end trace ]---


Tested on:

commit:         d1d10cea Merge tag 'perf-tools-fixes-for-v6.17-2025-09..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c5e134580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bce5d4c1cf285a6c
dashboard link: https://syzkaller.appspot.com/bug?extid=0192952caa411a3be209
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

