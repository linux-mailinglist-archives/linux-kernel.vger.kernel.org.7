Return-Path: <linux-kernel+bounces-754070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09A8B18DB8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 11:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F060D164705
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 09:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E7823ABBF;
	Sat,  2 Aug 2025 09:35:33 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E117222128B
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 09:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754127333; cv=none; b=E+2O4ZZrR1zRegoMVoth0B9i2QIGJ3iAXClspgzfqwJSv2esyBSpYfKlU/Z0gK5z2OnTPPyM4RtGzcpVMPXw90SBlbG8TDhr0ItMwTMSCQaIbXKtijGU7oPS2W/n7lvQFBXgucHCCGCjg0XVv5IPF4oSxM8wGJP2wF6TMwp/UMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754127333; c=relaxed/simple;
	bh=1dEMloXnn2Mfem08pSw5Fw4s2Xcn36gvmZmjIrQJuyw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mb3E/GFHS9q22eakY1DrqeQ0Cyh16XcrIClr5ZWi4HHDKME91WxZZIz31z2YQ3ubpyGJssZKVNC5z/O0vD/RrCKGX/je2+kNRGw4ds8vODds5N1OI1d0J8LERtEZEbhFm3XnwcCEjW/JdroELCmpQKtKiZoITEsqOqGrEXXfn7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3e3e69b2951so26702365ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 02:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754127331; x=1754732131;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQwx3Sq+pnVku4ytCpRaq1hDK/lw6DwplbnCrXcc8TY=;
        b=ro1o61v1Afk1dvq9w6kGj8gHfZM0PdQ4Qs83v9ar/D2l2NRLH/XZdA1mKcyd880DIb
         Ebks3nDWUNO66Hdr3JWyZIJZdHJOrvlxga0rjoWpLeWKVBUDS8NR425Dbgy5/y6p+39o
         c2ta2ZFFzv4awwfwiUINrnG5hxGO77ld5sDiCI+QCBmQvDFKxyT73+FOj3eH8tykIRa7
         9utLM38ffX48K81UOgFG/JNEKB8nF5xQAr4wqXLL8o7jtbf0vGLCZAlaZxoijQ6hLzN9
         32UeqCXbjDMjBAiiharSZcZozf74ZOmtA5LaaCVdA/W0I98Rl6PAwd+QuqpkxBIv+iOP
         GZ6Q==
X-Gm-Message-State: AOJu0YySFAokf87nJyID2ZQn/mT2Jcx6Eh3D318IPcgUXr2xmMhcxO5o
	tpdkYF7zq4hzvOB7VWloxdAmtsW855adf9rS524xnXy1m6chKUlZ5MqTOXmxyHISCyd6lg6zdeZ
	O1k5A6FgM5j2n0DwuDqjlLcinJzIwnBNiChpfZDEn7wIKebQ4nvTmPyIQFHlnPg==
X-Google-Smtp-Source: AGHT+IHvitcWIJaasnUlvlnb9+ehTMoVEmrSDSV1nInOP/6ivGvLlZDmvVNym+rkcNot7a7BvdiStMC7TSo8x4FSbiI+fCflvsPw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:349c:b0:3e3:cbaa:e630 with SMTP id
 e9e14a558f8ab-3e415e3f11fmr50156675ab.8.1754127331020; Sat, 02 Aug 2025
 02:35:31 -0700 (PDT)
Date: Sat, 02 Aug 2025 02:35:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688ddbe3.050a0220.f0410.0137.GAE@google.com>
Subject: [syzbot] [raid?] WARNING: refcount bug in mddev_delayed_delete
From: syzbot <syzbot+a288de079aaa1fa42f6f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4b290aae788e Merge tag 'sysctl-6.17-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110d2ca2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1638650a7e3ca3ea
dashboard link: https://syzkaller.appspot.com/bug?extid=a288de079aaa1fa42f6f
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-4b290aae.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f278b497a6e/vmlinux-4b290aae.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c6155ee31a71/Image-4b290aae.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a288de079aaa1fa42f6f@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 962 at lib/refcount.c:28 refcount_warn_saturate+0x138/0x19c lib/refcount.c:28
Modules linked in:
CPU: 1 UID: 0 PID: 962 Comm: kworker/1:2 Not tainted 6.16.0-syzkaller-04405-g4b290aae788e #0 PREEMPT 
Hardware name: linux,dummy-virt (DT)
Workqueue: md_misc mddev_delayed_delete
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : refcount_warn_saturate+0x138/0x19c lib/refcount.c:28
lr : refcount_warn_saturate+0x138/0x19c lib/refcount.c:28
sp : ffff80008e927a80
x29: ffff80008e927a80 x28: 0000000000000001 x27: ffff80008708df78
x26: 0000000000000000 x25: ffff0000150e1f00 x24: ffff800087090000
x23: ffff000026240130 x22: 0000000000000004 x21: 1fffe00004c48026
x20: ffff000026240130 x19: 0000000000000003 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: ffff700011d24ec7
x11: 1ffff00011d24ec6 x10: ffff700011d24ec6 x9 : dfff800000000000
x8 : ffff80008e927638 x7 : ffff80008e927760 x6 : ffff80008e9276b0
x5 : ffff80008e927698 x4 : 0000000000000002 x3 : 1fffe0000d419d16
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000152c5ac0
Call trace:
 refcount_warn_saturate+0x138/0x19c lib/refcount.c:28 (P)
 __refcount_sub_and_test include/linux/refcount.h:400 [inline]
 __refcount_dec_and_test include/linux/refcount.h:432 [inline]
 refcount_dec_and_test include/linux/refcount.h:450 [inline]
 kref_put include/linux/kref.h:64 [inline]
 kobject_put+0x29c/0x430 lib/kobject.c:737
 mddev_delayed_delete+0x14/0x20 drivers/md/md.c:5893
 process_one_work+0x7cc/0x18d4 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x734/0xb84 kernel/workqueue.c:3402
 kthread+0x348/0x5fc kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
irq event stamp: 146962
hardirqs last  enabled at (146961): [<ffff800085407ea4>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1534 [inline]
hardirqs last  enabled at (146961): [<ffff800085407ea4>] __schedule+0x23c0/0x31cc kernel/sched/core.c:6962
hardirqs last disabled at (146962): [<ffff8000853f7d30>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (146934): [<ffff8000801b7810>] softirq_handle_end kernel/softirq.c:425 [inline]
softirqs last  enabled at (146934): [<ffff8000801b7810>] handle_softirqs+0x88c/0xdb4 kernel/softirq.c:607
softirqs last disabled at (146921): [<ffff800080010760>] __do_softirq+0x14/0x20 kernel/softirq.c:613
---[ end trace 0000000000000000 ]---


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

