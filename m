Return-Path: <linux-kernel+bounces-835565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 497DCBA777F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 22:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E747C175DA6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 20:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0700A276028;
	Sun, 28 Sep 2025 20:14:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC5D6D1A7
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 20:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759090445; cv=none; b=tRNdZS83OCGzZlaJ7goxOiV1KSkKfAH60OCR3NEP3FNdNXGVJoWUVz2jwgCgUaX6DeG8fLpG0J+ti94dCDu99pN/3J+gbts/YqlwzA5LBy1w0Xo8jQhHdjYxex/XHR4jjYYguvUAvpFCc3Y8mFlFzClQqRWmjpPLidcVR4U6gnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759090445; c=relaxed/simple;
	bh=f4il41tlpaKAJnqIHH6xdEdqP8ZC7/vasoqLXn3VrYs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ea/5mlAsYHXhBvSbI18nnPsPpUTyD7sMoD3bO1gAode0Na5Tp8Z5pZsEOpytZDljJpxp3VwICVct7ltN/zq17eGvaJOqyP/cyNJJGIQaITpdyl/44ginW8wPOSp/B0xl7+IUZK8QTZwVgAwtjOi0itKxqlNhyKj6McuO/GuaukY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42b2a51fad2so5878235ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 13:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759090443; x=1759695243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gsAp00mq3VzR7ajf7zZdFKNO8nKeezzytzpiT45fjHM=;
        b=OEmq9jb5Jo1tihsJyGyFS7hztVlgRXDEayFlBgp6psoQYxcOw6vRbdb6buz4pSGnLj
         u4y56nO9B14bti4MLJMglK2WwSl3EK8Ks0e/sKOjyMefGgOXVxaozMk0k63NKOGQyHsQ
         o5Z2a6HbLW3ZDj87aiMMItwaRKhJb0SXQt7i/tlrzybk3gSVR8ZqYE8wia9bXLgpYtze
         3KJX9fMOR6w6xCY6yrm8uj5ZBySM0xuVd2RCU5lGFWIC/qfF83VHXBs839Sos7sG5MT2
         75vxYx+LCqLIQ1t3Kd6TlEWVHahrOL0fedKH4ttrI5cMHdMWjm1YLFkEr0cgSFoq1RFZ
         /lDQ==
X-Gm-Message-State: AOJu0YyT3rfYNvggNV/BVxaUL/uppgQbaMIJ7kWwzRhhmAh6clUaBgr4
	xyv9SDgm95AviSJX+AK9q6DRf77y8UgILlbhPSOdlBOQLgB7DwPKk+7WggC3nCe0ahMTNcbK7kb
	40+3QQlteUD88rzTU8HL6k/4tkuyjoaDFRRFAb++473CN+FofKoBUNmeCpoY=
X-Google-Smtp-Source: AGHT+IHeIVh5rTnEztc8JKASCCxmxCa0ABqcQjx/rpA2Kn9WOOQ2dIz4bsPJZmGuAgQhB+epJ6PJzNlVIOUnuB0KasUD6N3JdSLx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214c:b0:427:5ee7:2efb with SMTP id
 e9e14a558f8ab-4275ee73002mr47855795ab.8.1759090443390; Sun, 28 Sep 2025
 13:14:03 -0700 (PDT)
Date: Sun, 28 Sep 2025 13:14:03 -0700
In-Reply-To: <87bjmu2vsk.fsf@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d9970b.050a0220.1696c6.0008.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbSplit (3)
From: syzbot <syzbot+4c1966e88c28fa96e053@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xandfury@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: shift-out-of-bounds in dbSplit

loop0: detected capacity change from 0 to 32768
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:2641:11
shift exponent 110 is too large for 32-bit type 'int'
CPU: 0 UID: 0 PID: 5828 Comm: syz.0.16 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
 dbSplit+0x1f8/0x200 fs/jfs/jfs_dmap.c:2641
 dbAdjCtl+0x34c/0xa20 fs/jfs/jfs_dmap.c:2533
 dbAllocDmap fs/jfs/jfs_dmap.c:2044 [inline]
 dbAllocNear+0x2ee/0x3d0 fs/jfs/jfs_dmap.c:1247
 dbAlloc+0x933/0xba0 fs/jfs/jfs_dmap.c:832
 ea_write+0x374/0xdd0 fs/jfs/xattr.c:232
 ea_put fs/jfs/xattr.c:619 [inline]
 __jfs_setxattr+0xa01/0x1120 fs/jfs/xattr.c:792
 __jfs_xattr_set+0xda/0x170 fs/jfs/xattr.c:941
 __vfs_setxattr+0x43c/0x480 fs/xattr.c:200
 __vfs_setxattr_noperm+0x12d/0x660 fs/xattr.c:234
 vfs_setxattr+0x16b/0x2f0 fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 filename_setxattr+0x274/0x600 fs/xattr.c:665
 path_setxattrat+0x364/0x3a0 fs/xattr.c:713
 __do_sys_lsetxattr fs/xattr.c:754 [inline]
 __se_sys_lsetxattr fs/xattr.c:750 [inline]
 __x64_sys_lsetxattr+0xbf/0xe0 fs/xattr.c:750
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f643b38e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f643c1ce038 EFLAGS: 00000246 ORIG_RAX: 00000000000000bd
RAX: ffffffffffffffda RBX: 00007f643b5b5fa0 RCX: 00007f643b38e969
RDX: 0000000000000000 RSI: 0000200000000200 RDI: 0000200000000040
RBP: 00007f643b410ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f643b5b5fa0 R15: 00007fff5f732f08
 </TASK>
---[ end trace ]---


Tested on:

commit:         8f973663 Merge tag 'trace-v6.17-rc7' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154abf12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71b8dca8b0315854
dashboard link: https://syzkaller.appspot.com/bug?extid=4c1966e88c28fa96e053
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

