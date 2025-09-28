Return-Path: <linux-kernel+bounces-835194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 505DBBA6796
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E054E17D21E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 04:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D994283695;
	Sun, 28 Sep 2025 04:14:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA6D259CA7
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 04:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759032845; cv=none; b=J6/qIthDFWU4ivgzmGiQR//hgZQ9n9qGNza/cMXzNt4bbZj0YZt9Xg8/xFGVLtzBQiGlqjf6CJEpQGRpnS0Xj3cy9+TwoHtJfBON/RUP/s8CTeLdjURDCck3uM5zMZLMdGdbZ0NKSDyIQc8lz2yyrGwjEm7Xz/qRLBiPEQuA6Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759032845; c=relaxed/simple;
	bh=vQimOkF5oYJ0zY/CAafdCkLmikyRtTXld7q1/rezQmw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Eonw+YVb0HLWXFRCsgWFN+xZMWeSWZfVpyftCFef8CvJy48UOJql+R5scOWkfR98qVp+9IfKJ8mkBpnVR2LKjwunvaXfKH2wS8Wctvjdb2QgIdILB1Qra60DDz5Lco9gIETQt8OKXoIKHWHIwS7tTmsIY/ETmpr3D/u/R1B48ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42628f7c151so69420255ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 21:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759032842; x=1759637642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cpdnLRAUIeF4suDP0hGEyYk+xBUj1SjdNdHexH1+cpg=;
        b=BXjzzwHPfNFc696qNkbUKeHles1cwlL5Q2kjRf72Az8GVewgW/JLTX+6hqbWgEodvp
         5/rD2K2BPVJk9u9BmSueYgLYyh64mgOdGY4XSDWMkCV+a4CM58q1ncwvenIt5jPZu3l4
         VMi5pKTvL4t1gf1wj6W9fXE2eDyxm4PwuJfyiWr9RCAARTKA2yHd2z/fvvm8qd1yphyd
         3nPJKQ+g2JX09rWq4pnfgVnZjh8a592kcHWDFpFnzjAyDVg1NKKSdidNO3qFw0/aoxjt
         KJJ4AuPfHF5DxChCB8Qo7MP5258of3vli6R3lQuhkGV+VT1vdQf2LoCpDlET/mXqPECp
         lLWw==
X-Gm-Message-State: AOJu0Yz7/mjGkJnCdNHoPbQ6n+SZnFrn3RvdgngEfaAUdDw6ZE9Tb58M
	XsK9zT2YDQK5d2QVIJqH9aPgrjuzHVI+v2KZGqUphm7LFJSNH0tE6o3nIf6NK/gSzBTkLQlTA7U
	hyH5rIsGqHcH7QnFmOvsPvQMnpXGvl4E34GnhIMU+WObjYI1fLwJ4668d+rk=
X-Google-Smtp-Source: AGHT+IFHET44afhLJ0t1uEcgBM3r8Ix8CcJ75n+od1J3alJV5Luhz7Qwd4kafCU5NPv34XmqQnz3PQEHrKT2a25MpLC9AqQXt81j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca09:0:b0:425:70c5:61b3 with SMTP id
 e9e14a558f8ab-4259562e522mr214558695ab.27.1759032842470; Sat, 27 Sep 2025
 21:14:02 -0700 (PDT)
Date: Sat, 27 Sep 2025 21:14:02 -0700
In-Reply-To: <87jz1j2pq0.fsf@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d8b60a.050a0220.25d7ab.046f.GAE@google.com>
Subject: Re: [syzbot] [scsi?] UBSAN: shift-out-of-bounds in sg_build_indirect
From: syzbot <syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xandfury@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: shift-out-of-bounds in sg_build_indirect

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in drivers/scsi/sg.c:1896:13
shift exponent 64 is too large for 32-bit type 'int'
CPU: 0 UID: 0 PID: 6529 Comm: syz.0.16 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:233 [inline]
 __ubsan_handle_shift_out_of_bounds+0x27f/0x420 lib/ubsan.c:494
 sg_build_indirect.cold+0x1b/0x20 drivers/scsi/sg.c:1896
 sg_build_reserve+0xc4/0x180 drivers/scsi/sg.c:2006
 sg_add_sfp drivers/scsi/sg.c:2188 [inline]
 sg_open+0xc88/0x1a10 drivers/scsi/sg.c:348
 chrdev_open+0x234/0x6a0 fs/char_dev.c:414
 do_dentry_open+0x97f/0x1530 fs/open.c:965
 vfs_open+0x82/0x3f0 fs/open.c:1095
 do_open fs/namei.c:3887 [inline]
 path_openat+0x1de4/0x2cb0 fs/namei.c:4046
 do_filp_open+0x20b/0x470 fs/namei.c:4073
 do_sys_openat2+0x11b/0x1d0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x174/0x210 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fac63f8cde9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fac64de2038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fac641a5fa0 RCX: 00007fac63f8cde9
RDX: 000000000008a002 RSI: 00004000000000c0 RDI: ffffffffffffff9c
RBP: 00007fac6400e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fac641a5fa0 R15: 00007ffc0932dc28
 </TASK>
---[ end trace ]---


Tested on:

commit:         51a24b7d Merge tag 'trace-tools-v6.17-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1203df12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0765aa9a4a8b6b6
dashboard link: https://syzkaller.appspot.com/bug?extid=270f1c719ee7baab9941
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

