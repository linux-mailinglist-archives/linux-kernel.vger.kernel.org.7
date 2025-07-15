Return-Path: <linux-kernel+bounces-732088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFA1B061C1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4F818857D6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F360719CCF5;
	Tue, 15 Jul 2025 14:44:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2552D1E519
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590648; cv=none; b=GtZRnAy+2PaF4yFSfUQSfdIjFmC1UZnQY6ReVix0TNrlSFvUrRMBz6nBTcwDgW1CBx6PPTKD8T+Eoncn4lml+Y/hrNKBJUB8VncZppdrP1knt/T1R9TJhFV6eWy6+Dren2gkrvdOX5ZC908rLB5IXZ74VKTzSArAmNQOtd7XAnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590648; c=relaxed/simple;
	bh=Y46NR/ZYoQE2jXKriLWaGteAEs4wrMHJD17aKgfZuV4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sGSTRL1q+Ovr8WwbwMKAQ8X5HCdXayH3jz11yfkY9/bK4hGtYnCLBQLnlHTC+NWECasIijIctEvhsJIBn/VNWjjHssMY4u5nqanQksTi9cI5JDGbaqiNLUIt6XNEmrxJXyLA27r7pJzqVjsvi6ypGW8UVwwFbgEJrEdi42b+3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8760733a107so622095439f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752590646; x=1753195446;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sXLahVgU7BFqVcbCjxZivr7COQnJHG1Nc4SOC/KDyqE=;
        b=Kwsj7VgEyBxgE043rdHpDGPyjnHmylRYDPljIeG8Jry+VywiVYI9sJfEMyeaSWN0lj
         iC7yhPoCDoly11fQiKXUyfsirvYVDJ45WVN923KSnKtAJ2ib7o5iwwCU9e4mwfX4bV8z
         9YqlMrjGU54r+TN95MNy2doF5YUKPRRRIXsQkwCcaw5+TFw0cHD5kLIO3yMInm2W9osH
         CNsOzGqTRYTeqZ/mvF9/B0tS4qjGfPdI9Cvg5/c7ayGRZndxCjCdM/NLAGng5NKu+Jxb
         rnE3Okfq+FhvGF9HIlxQW+qjIR8hRxx/xI4ThY0qzspC6XNLgCHRXc5VdkJPMS0F2L4e
         VnFA==
X-Gm-Message-State: AOJu0YyUQpRvWkcr6Cbcztc7vXVdCusbfZYdQImCZc4v3nnSRYd6XyDg
	CBLelMwL/JDzjZ1uTbiwRKd2heqStuBfJlVIJf8YVzYPkwCBxEmeEnbPuWCNBmFyVG/t9AGoJl+
	+JFHT4FFsWmuB4RM99ew4GHhw4/CbAKvS3FBVeW6AqFhZZ0nCb6BpHXmtU3E=
X-Google-Smtp-Source: AGHT+IFK7dUJqWGU1ByDEs4qDxleHIIO8khNmtxvKNKDDF5H3XrwUUQOfOVOOBXzG7Oy19izwc+o10T+6xHckPRon3537RIaHwdm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7181:b0:879:652a:ac7 with SMTP id
 ca18e2360f4ac-87977fe76b3mr1668207739f.13.1752590646241; Tue, 15 Jul 2025
 07:44:06 -0700 (PDT)
Date: Tue, 15 Jul 2025 07:44:06 -0700
In-Reply-To: <CAMp3bLUBvH+e1Zg+GhB7g+wDTfTi34F=fpPBXi=zQkE5sLBxsA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68766936.a70a0220.693ce.000e.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] UBSAN: shift-out-of-bounds in gfs2_dir_read (2)
From: syzbot <syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, purvayeshi550@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: shift-out-of-bounds in gfs2_dir_read

gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
gfs2: fsid=syz:syz.s: journal 0 mapped with 5 extents in 0ms
gfs2: fsid=syz:syz.s: first mount done, others may mount
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/gfs2/dir.c:1544:15
shift exponent 32 is too large for 32-bit type 'u32' (aka 'unsigned int')
CPU: 0 UID: 0 PID: 5955 Comm: syz.0.16 Not tainted 6.16.0-rc6-syzkaller-g155a3c003e55-dirty #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
 dir_e_read fs/gfs2/dir.c:1544 [inline]
 gfs2_dir_read+0x1730/0x1780 fs/gfs2/dir.c:1585
 gfs2_readdir+0x14c/0x1b0 fs/gfs2/file.c:116
 iterate_dir+0x5ac/0x770 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:410 [inline]
 __se_sys_getdents64+0xe4/0x260 fs/readdir.c:396
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc24d78e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc24e530038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007fc24d9b5fa0 RCX: 00007fc24d78e929
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007fc24d810b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fc24d9b5fa0 R15: 00007fffd0c6e0b8
 </TASK>
---[ end trace ]---


Tested on:

commit:         155a3c00 Merge tag 'for-6.16/dm-fixes-2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c44382580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62a2ef17395702a
dashboard link: https://syzkaller.appspot.com/bug?extid=4708579bb230a0582a57
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=167ff18c580000


