Return-Path: <linux-kernel+bounces-730636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D29B0476B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21744A4E39
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BA2223DCF;
	Mon, 14 Jul 2025 18:31:40 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9966A33DF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 18:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752517900; cv=none; b=mRkK9aSGDnT2kxIjWLNMrM8WgaBAbgnooBkWV5k453zcZk5SulxsfxBXjB3FojExbJzTTmahiiPH4fqG3DzOIPj9o2bRcsAborCkrSdJddBzfEzcCzF7XbANuyms3/aREZUxpzkYi7hG4IMvipi4lDgTL+7tFqyGoECMzEAeCr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752517900; c=relaxed/simple;
	bh=6583giDmVSRTZxZrK3xpeMWrT/CIFMuzm/B0AR8zIok=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uIFSC4vzYfN3khxLUwkgakiVeS9Wr1Nk0YMzylcsqrNrYjryZbm+khTd31aIf0LKg4OKoyxH/4t0PZ/UEnAhQehRTEXmxBiVuW1TQhoaSxuLfyBxgkkChA+c8eEHuF+zyCNSeHz1Bh2LUTiYGqKDGXFx0CiMxHbjXG1B07UIboY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-86cfea700daso434098639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752517898; x=1753122698;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JaaHf/gWPNeBrtGS3XVFozF9NqzyUVddep+JlG6cXZ0=;
        b=m+mTFVZD6swiqnQlFuuUdiWr3gemrFJHsyOEhqYv3AVMVGPsaYDxZKiqDyEHNWXBWR
         cr/77EJEBWpFOvWvee2l1c3n4SRjjoIFuTFi8IwfnDG8A9XxtcVzYB0xSPnbueSHWtAt
         h/CveRCpya8h+YFX+aTgNI1/eo88MNtZYeppq3Tc5jDl7w5oSzNuFmpilF8pLj2q3/+3
         +XvyRp0+AeMSZ1WEn4h51jda3CmzBZ+c4KMdT9cY+vnlwKF+yzFW6ep1mJGYLq1Baami
         NyIcQPRPNlXW3wZiRnnw0nathiHrlVNU6A9/IcaRMxLhC8R3Ex5P9MmaURM1MNliq+VF
         PLRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSAXxWDJn3UOtRQA+zmk//DpMhR0p2BGQt3Va5PgN1zVHylnNPdC/NLQ3GL5zu6e6/FloDqNis4aI6X48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnxVH+AQHYW7yZACUX7qJ1xSeWQT79tsuP0sdxZEy/Q5a7PjED
	Iarayu6GlA8fpfD2+KexBERqk6rddSmVLubzhq0s2JXuAnaKY5Eap0LRiIoghtO7qZSsr6fPTIo
	UbYr4K/lBOBy7MHZVuadrYBCXYc5c1u2hnUxEHyWm95AkYXCjRBg81ZFdjkg=
X-Google-Smtp-Source: AGHT+IHx4rjWpZgBf4f4xi3F+dj21gckVW6LdB6IhJG64Z7pYRkMj7AdaV6XsslJtuy2M0gtOUaAUbmIWRi5NjTg3eby+1nTmPXf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1696:b0:875:d675:55f2 with SMTP id
 ca18e2360f4ac-8797880842cmr1533157139f.7.1752517897803; Mon, 14 Jul 2025
 11:31:37 -0700 (PDT)
Date: Mon, 14 Jul 2025 11:31:37 -0700
In-Reply-To: <68754418.050a0220.33d347.000b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68754d09.a70a0220.5f69f.0001.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] UBSAN: shift-out-of-bounds in gfs2_dir_read (2)
From: syzbot <syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    347e9f5043c8 Linux 6.16-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11afb18c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62a2ef17395702a
dashboard link: https://syzkaller.appspot.com/bug?extid=4708579bb230a0582a57
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172470f0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d0fd82580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-347e9f50.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49ae91eb36e0/vmlinux-347e9f50.xz
kernel image: https://storage.googleapis.com/syzbot-assets/78497f74bd6b/bzImage-347e9f50.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2445b7dba270/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=15d7918c580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com

gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
gfs2: fsid=syz:syz.s: journal 0 mapped with 5 extents in 0ms
gfs2: fsid=syz:syz.s: first mount done, others may mount
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/gfs2/dir.c:1544:15
shift exponent 32 is too large for 32-bit type 'u32' (aka 'unsigned int')
CPU: 0 UID: 0 PID: 5508 Comm: syz.0.16 Not tainted 6.16.0-rc6-syzkaller #0 PREEMPT(full) 
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
RIP: 0033:0x7f9672d8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd2be2c848 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f9672fb5fa0 RCX: 00007f9672d8e929
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f9672e10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9672fb5fa0 R14: 00007f9672fb5fa0 R15: 0000000000000003
 </TASK>
---[ end trace ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

