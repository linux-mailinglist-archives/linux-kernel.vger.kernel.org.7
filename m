Return-Path: <linux-kernel+bounces-739789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7078CB0CAF7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927215446C1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7C91F418E;
	Mon, 21 Jul 2025 19:30:39 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0C821B191
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753126238; cv=none; b=I5yWZJQ+WnP5EN4hvOonHMREsMr0A/+Vym79W/fXgiA7IJvbKOuF33B8a9s8Xsy9feccnivtwROukZj39u+9LMP9Ct5i6m08inQTw4ex4qnNTHC7aX28boD/MG8nCW3g6UMfL69HruNVn43NZ/tBF4fMOePd6aVBymT+v6lcRpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753126238; c=relaxed/simple;
	bh=jT+g/mqIuUTeQlWlhkprOz60l3b1SLhTNKYUIOCnDn8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fsSU6qQqDyppvMB0Fy0C6OdOfJtVlyaGciWtmWUQ1WTg0Mu2yObgoSsCwdOgwjIfnjia8izt1PW19y1gEYEjGL6B+Swevk3/sEIEH7TlhVtXrClBfnkdflUCJ110zVjYRlQLza+PuGb/HrWgT84cyv5KC0bMaIAWFtgzMPqortU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-879c1688420so517053439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 12:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753126236; x=1753731036;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cGo91Q6aA34osh/yojqksTmY/0FjF2pqIO/CO9H37EY=;
        b=N0J9ETzub+bf2XbMSHjeebjOIrEYhBWAKZeyU72vK6TjvhvgmJlDDS8d+A9jt2FxJS
         FlFJ5UTsKpU6B6JxfLzHOZmd6ptda1zuEsvmuwcaSLXQOUGr3VRwzMZONKQAr5U13vkl
         g9c3itDyl78az51Ktb32pk2tCpCw7QPL2I7awoIBdWkY3Dod8e1Bk1cw6hr4d+c3Em38
         4LtmSJQxow6RSS2llDr71AVs4u+pt8Phx6Y1MM+Vm3er/W41drr/crx6nwFWzQG2Ph41
         Hcg7YokqkZpOIg5J/DOt4lIdtueFFo8p+NLsaFDW13JODshpLmWheSOrk6Jykma2FpJU
         ve3w==
X-Forwarded-Encrypted: i=1; AJvYcCXK3nL1UaEVY+GPvyx7hsHQVnyU67KAm95fvC+9oXBWwW/4+tY/HpSEpTMnKL0kW8ZcQC/Mc+bfBlp7294=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnEZmiiMBavs8zgcbm3Y+w56bpQPiFHK130T/8tiV6Vna2OoEU
	wdvf7y+/F4v5U7xZE7aVCL2B8FyHibuonjmqtJv2XjMocfnbEwrdmHcaFGDEPcT3CQoH7a048SB
	m/1T1q13MP59fcucjMkxAscx79hTMhnxhRIqLwKsVJ9bR90o7eaGuIvb8jRc=
X-Google-Smtp-Source: AGHT+IFvSiBttdPKfnOIiqcLyxtI3YeOoaIU3e1C0cs1TEYOSgKchN0Yal3fSGWyZJXgJYnMf9ieUKjGjVoDgVD7tLd70SzChD9E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c68:b0:3dd:bf91:23f7 with SMTP id
 e9e14a558f8ab-3e2be777104mr10050295ab.7.1753126236181; Mon, 21 Jul 2025
 12:30:36 -0700 (PDT)
Date: Mon, 21 Jul 2025 12:30:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687e955c.a70a0220.21b99c.0001.GAE@google.com>
Subject: [syzbot] [kernel?] KMSAN: kernel-infoleak in do_insnlist_ioctl
From: syzbot <syzbot+fb4362a104d45ab09cf9@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, hsweeten@visionengravers.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e2291551827f Merge tag 'probes-fixes-v6.16-rc6' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110a9382580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5227c65742122bdd
dashboard link: https://syzkaller.appspot.com/bug?extid=fb4362a104d45ab09cf9
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ae9623994cef/disk-e2291551.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/64b2bf4d3527/vmlinux-e2291551.xz
kernel image: https://storage.googleapis.com/syzbot-assets/05541379d4f6/bzImage-e2291551.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fb4362a104d45ab09cf9@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in _inline_copy_to_user include/linux/uaccess.h:196 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0xcc/0x120 lib/usercopy.c:26
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 _inline_copy_to_user include/linux/uaccess.h:196 [inline]
 _copy_to_user+0xcc/0x120 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:225 [inline]
 do_insnlist_ioctl+0x596/0x890 drivers/comedi/comedi_fops.c:1572
 comedi_unlocked_ioctl+0x1c6b/0x1e00 drivers/comedi/comedi_fops.c:2253
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0x239/0x400 fs/ioctl.c:893
 __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:893
 x64_sys_call+0x1ebe/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4154 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_noprof+0x95f/0x1310 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kmalloc_array_noprof include/linux/slab.h:948 [inline]
 do_insnlist_ioctl+0x1b2/0x890 drivers/comedi/comedi_fops.c:1551
 comedi_unlocked_ioctl+0x1c6b/0x1e00 drivers/comedi/comedi_fops.c:2253
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0x239/0x400 fs/ioctl.c:893
 __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:893
 x64_sys_call+0x1ebe/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Bytes 4-583 of 584 are uninitialized
Memory access of size 584 starts at ffff888053394400

CPU: 1 UID: 0 PID: 22163 Comm: syz.9.4290 Not tainted 6.16.0-rc6-syzkaller-00037-ge2291551827f #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

