Return-Path: <linux-kernel+bounces-732957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE83B06E24
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6C1188AF66
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1DF28850E;
	Wed, 16 Jul 2025 06:44:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30BF1C68F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752648244; cv=none; b=pf8z03ObVkmje+K81T3p/vcWquWBjP/vnqrGxSd15tdfU2ui8JflfHMPsfKZScuNQw3CBg37AB7KOWwOgdk079JYuZP9AYlnpUEOKFrWfXl4x36ozVuFnu1dkyFdTAxSa4fypt5Wfn2sO2rgvnfhppnTAsryqqYbmfDp1kw05Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752648244; c=relaxed/simple;
	bh=3X2cIWei7RuKd9PRudLRstoo2IrhrHEG/GsZOjW8pvE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LE/gOi3kxN6X7qXYOS6iS71VdT1XUuTmERdO4qmWdM0RDxOrU/w0Y0BhzIrIhXLKTboRvt2ef3D4EK9WKaNBsahxf3/jZnvhXEWe5Dnl0zwGMs+MBQ4GifVDVCosaGF9lYckFRKc93JYrYQZgYOe18cf0p1uERFdcnH+f7Zpm4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86d1218df67so665431639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 23:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752648242; x=1753253042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJJmt3tprj5fiQ/uFdqWw2kXxlcNWTWNwPzb9QcWl1o=;
        b=sqcVdqNXgaa9ag8mfxedybUoltBezlydwQ0BEm0zeAtKHJsjeTmHZpuibrHRDArGL2
         wFyjX7Iso+nvNgtMsJfzQWFhh+u+6UTx84Ry/CyIA7wA4GC4eN7gElqMm6vjWrrEF/Nd
         PO2U7hx5G1T2U5FKGfFk4KrUeJu10RchU/qGPKw40VauxET/iQ2M4PQZt02yAEFkuuVT
         uMx7CjEOTRn086VfMgIlKcB+s9JDSoyDgBnoR2p9u4EduP9gBhBH36okyPciSi3cOofX
         5lW+uQush4O9bj/Si77oYXnjTtfekc2VKzU4hHToZ9byI4/eqYhkazqXKo/1hQo3cje7
         tvnQ==
X-Gm-Message-State: AOJu0YyAhWL/Y7KS52gq9ncARQxJK9jgOTe6tmiakkQe6HjnwHCSnzZq
	W7pR1DakhA9TgQMizW3XdZell7bTbZ0o2Xoas9nIgg9iXxJeUumQ3DJFlvy0x2FaGzBo0CpnZ1b
	FpYXAEErgz/TIlfr07dtH3g1IEmib97idq7/I9k8zV5ZN4rUPta58PMSDgNY=
X-Google-Smtp-Source: AGHT+IF92A13SYlfNk6fo6N33dXq983dKTV5AWTlkWs7BrA8FESJsdGoyfq/1DqVQY4t+esRfpCYY2MzCDm7tlCdvnQiQr7Xv4SP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:c116:0:b0:862:fe54:df4e with SMTP id
 ca18e2360f4ac-879c28b1addmr93784639f.7.1752648242001; Tue, 15 Jul 2025
 23:44:02 -0700 (PDT)
Date: Tue, 15 Jul 2025 23:44:01 -0700
In-Reply-To: <CAMp3bLXm0gv=SWKwU_U6uBkxu12NawKyPPdrHVCYQDf-vyofdA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68774a31.a70a0220.693ce.0020.GAE@google.com>
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
CPU: 0 UID: 0 PID: 5893 Comm: syz.0.16 Not tainted 6.16.0-rc6-syzkaller-g155a3c003e55-dirty #0 PREEMPT(full) 
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
RIP: 0033:0x7f9c54f8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9c55da0038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f9c551b5fa0 RCX: 00007f9c54f8e929
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f9c55010b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f9c551b5fa0 R15: 00007ffeba75d678
 </TASK>
---[ end trace ]---


Tested on:

commit:         155a3c00 Merge tag 'for-6.16/dm-fixes-2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122b88f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62a2ef17395702a
dashboard link: https://syzkaller.appspot.com/bug?extid=4708579bb230a0582a57
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1449a7d4580000


