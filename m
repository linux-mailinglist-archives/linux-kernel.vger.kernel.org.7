Return-Path: <linux-kernel+bounces-842698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B06BBD52A
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 10:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABB13B42A1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 08:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D6525A2A7;
	Mon,  6 Oct 2025 08:18:28 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAF42580D7
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738708; cv=none; b=SLnjmjgvERfDqMAdSp/1v+zaXXvXer5W3jT/NcgyXsLAkkVssk3n6cxqLhgrvxduFlLCQzldCIut2Hfiqy8RFXttfHgOXuYmiPQ/TgELal3z1Jh9F4UM9s3TAOj/OHs0c8yxf1XvVZ7wqeZ+ZQzRK8gGC8Do6szHWFlY98s1CcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738708; c=relaxed/simple;
	bh=4NK+9aJ7ZIq643eVYG3WMnIeN+oFodOoPPf9mJ7yKeg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qDAE/hTp48j4+h/92JTsDlzkXDQeGPmllwLR38uR88b/SeWBW7vyC0IJKG5TUT7JQR70uKmWb9orouCxhGFrftNGEzswslQ8sHzeDMlGs2sob5ru4YDpiRkWz992qTLDNClw/V1EvJ+u/0Ieo52YqkpkcnatmZ38X/E5d66gEWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-8877131dec5so544280139f.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 01:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759738706; x=1760343506;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vCaTE872Wt8rqgxjuAZNXaNvcHL24W/ZDko1qWz8/yk=;
        b=N9814FIqn9scvnTVD2UXUWlTrYW6Wwa1kdkOEc7edm3PTCNO2cu7epjey/jNMRZXSp
         Vc6wQHcVmWi6/myQxDl5xxh/u2nBo+EcHTsWdiM6vRmejNFgXeV081Bt/M7x0sB/XVet
         /bu99tq9w9p0iIDIhn707Tt+m57mF3nXFdG0XxzDNljFQZ5WOs922CDsckVSZcMidLv/
         35JkFVaddrlXGpgpUSoAavHeVA3Zo6ML2x1EHSVzULYCbpxE32gZ5/t+sJ1CkGVbpB2h
         qGbN/EOz6YXSJLhOcqhZAeNVWrJJBjI66YYGDMxIr/gWP8voEEOBj244ukTL4XXzvFWs
         l/UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRQnR5M5oGuagpHRmImieqzokFJEENWSpmAPjUcgTHULQtpHbUQVaDIuqBZYrMph8JnlzskHDn2QIomDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5EdPw66v85sdDIYdRtekh/miHgGj7RYLyvmHtwNbMvK47dO3s
	nEm0BTPhfrzV9NOY5SMC2/QNozrH5ZHAKeV6EMi+aJMgRHFkc19QyMGZt8zh1KvIQjiBKSOKDO7
	/iFViJFcpJl0TxmHjjbxCCvuzX+qd/rPSJBkny4/yGR7ZG519ySRiBRn3CXU=
X-Google-Smtp-Source: AGHT+IFCIlvyuZTehwtVD2bRRw5L7fdQigXI0qygmNBV6KrJb4W1XTGSh+xe7ReMhaBkMo3Wt/QqQ3vgRzrtUPc7caXBS5FB0OQY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:27d0:b0:8e8:a857:1f89 with SMTP id
 ca18e2360f4ac-93b96948dfcmr1677643439f.3.1759738705879; Mon, 06 Oct 2025
 01:18:25 -0700 (PDT)
Date: Mon, 06 Oct 2025 01:18:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e37b51.050a0220.2c17c1.0042.GAE@google.com>
Subject: [syzbot] [comedi?] possible deadlock in comedi_do_insn
From: syzbot <syzbot+4a6138c17a47937dcea1@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, hsweeten@visionengravers.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3b9b1f8df454 Add linux-next specific files for 20250929
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10e08458580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c7c078c891391b1
dashboard link: https://syzkaller.appspot.com/bug?extid=4a6138c17a47937dcea1
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1ccfc1a8eb22/disk-3b9b1f8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c4e52fa84079/vmlinux-3b9b1f8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9eacf34feeec/bzImage-3b9b1f8d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4a6138c17a47937dcea1@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz.3.705/8631 is trying to acquire lock:
ffff88814c4ae0f8 (&dev->mutex#4){+.+.}-{4:4}, at: comedi_do_insn+0x38/0x3d0 drivers/comedi/kcomedilib/kcomedilib_main.c:73

but task is already holding lock:
ffff88814c4ac8f8 (&dev->mutex#4){+.+.}-{4:4}, at: comedi_unlocked_ioctl+0x13a/0x1020 drivers/comedi/comedi_fops.c:2166

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&dev->mutex#4);
  lock(&dev->mutex#4);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by syz.3.705/8631:
 #0: ffff88814c4ac8f8 (&dev->mutex#4){+.+.}-{4:4}, at: comedi_unlocked_ioctl+0x13a/0x1020 drivers/comedi/comedi_fops.c:2166

stack backtrace:
CPU: 0 UID: 0 PID: 8631 Comm: syz.3.705 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_deadlock_bug+0x28b/0x2a0 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain+0x1a3f/0x2140 kernel/locking/lockdep.c:3895
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 __mutex_lock_common kernel/locking/mutex.c:598 [inline]
 __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
 comedi_do_insn+0x38/0x3d0 drivers/comedi/kcomedilib/kcomedilib_main.c:73
 comedi_dio_bitfield2+0x2d7/0x3b0 drivers/comedi/kcomedilib/kcomedilib_main.c:204
 bonding_dio_insn_bits+0x2a5/0x590 drivers/comedi/drivers/comedi_bond.c:100
 insn_rw_emulate_bits+0x34d/0x5f0 drivers/comedi/drivers.c:642
 parse_insn+0xa26/0x1910 drivers/comedi/comedi_fops.c:1454
 do_insnlist_ioctl+0x331/0x690 drivers/comedi/comedi_fops.c:1594
 comedi_unlocked_ioctl+0xdeb/0x1020 drivers/comedi/comedi_fops.c:2298
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f96e618eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f96e700b038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f96e63e5fa0 RCX: 00007f96e618eec9
RDX: 0000200000000080 RSI: 000000008010640b RDI: 0000000000000003
RBP: 00007f96e6211f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f96e63e6038 R14: 00007f96e63e5fa0 R15: 00007ffde94ae9d8
 </TASK>


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

