Return-Path: <linux-kernel+bounces-782588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEDCB32279
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA4C6014D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084362C0327;
	Fri, 22 Aug 2025 18:55:32 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5E92BEFF9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755888931; cv=none; b=XPEoESwIkUKc9zllzsdDo7wlerTaVH0k4pKEPjNXYH58Tyl3N+Sw3jGwNvtFFwPliwemr8a5sVfCBDjaCIQa3hzXdv26p/BZ+9mGOYy0RsVuCfbTtcyewIgu+wzBLQlg9OrdALIelS5xORqnIieUwvr66tq8k8a3E6UwYrSLR4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755888931; c=relaxed/simple;
	bh=a63glzP/dR4Z5IDZyY0j0bnleFUXuQdCzY0jxb2znuA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DbL32HdWVmu1y+uRgEndlJujDrdnF9mrM8S30c5Oup+brlaQC8RGj3ybjs30le9qlrVFYQREMRrq4ea6fSX2CKXd06cAxmHLeQLwTEiU1gQw4gQjyrZcu12Yv+ILC7TxPeqscyPnBZ2Ldc5ztYA2dEJhiBDOVz6yzzc5iUvJMdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3e67fa671beso27306515ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755888929; x=1756493729;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ESxP4ps4VFtj/7eR3pxdRW3J+PLwa0Tgkn2AHSSMyOU=;
        b=o0TFDjs2wA19X49M9MrqX6LvADa0SIts7Y7ttviVzKIxLeqdmIBB1q9905GkwP4F7u
         d4TVaPdouce6lB/mo1PZXUYCDXv526+ntIX/P+Ju8cC5NmZilIQLo5QyodDkZcRgGkfG
         9AKDVZ3ES+RHWllZUrlWtqk7E8YqIAvee/acmRFVzoKqR4YwugeGSzd2WAAAi8HTpvCX
         /m4bz8F7vxjYL3sCazFmZvcvXol+3+MCE6g+qn5FYr6X10jm/q5+ku5MS9XTEOMCF2by
         EIjAmL00q9vf6nO6+tj4H4i3gzScs/eqp6BLdt8YnkOudwCzGm8r+Kt8XFaluWSoshYD
         AQow==
X-Forwarded-Encrypted: i=1; AJvYcCVlufeF9CccXh5y0fpEq+vMLfsrpQCS9KupvhD8d9c1wnetsjtfRZUY8iXYGbfok4eWmGCq2pdm4XqIC6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZJm9ACXRRsSw53aK9yw5mTOu/M/N2bJ8LVZYJp0HdkZ1l2/xZ
	hGF3AKC0RnFL+WfVZE1ADZSAqn0L3gXK+VTJsNqwy5ePUCft0Ohj6Dz5/GwTCAT3T9y+N6PIT4b
	bspJRqGrUgl6nOVjDOkAjOjEHePPulU5IyMCiVYHrLJVPB2xUZyzDtnBzOgA=
X-Google-Smtp-Source: AGHT+IHn2TTGvlJS+QXiOxYtabCHdCi0tpf3KzdhcZWwcEvafjQqrVOH2j8cD7Vv9XWBXm0PkEmCP4YyexYWtzea+iSw5oEMeGog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3801:b0:3e3:d8af:3847 with SMTP id
 e9e14a558f8ab-3e921c4d9bemr61966665ab.16.1755888928572; Fri, 22 Aug 2025
 11:55:28 -0700 (PDT)
Date: Fri, 22 Aug 2025 11:55:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a8bd20.050a0220.37038e.005a.GAE@google.com>
Subject: [syzbot] [erofs?] KASAN: global-out-of-bounds Read in z_erofs_decompress_queue
From: syzbot <syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com>
To: chao@kernel.org, dhavale@google.com, jefflexu@linux.alibaba.com, 
	lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xiang@kernel.org, zbestahu@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3957a5720157 Merge tag 'cgroup-for-6.17-rc2-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104f0062580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=5a398eb460ddaa6f242f
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16650c42580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1277dfa2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c5cbe8650b9a/disk-3957a572.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/51911bea9855/vmlinux-3957a572.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b07279b5fcc2/bzImage-3957a572.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b6ca0d9a661b/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=142187bc580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in z_erofs_decompress_pcluster fs/erofs/zdata.c:1274 [inline]
BUG: KASAN: global-out-of-bounds in z_erofs_decompress_queue+0x341/0x3580 fs/erofs/zdata.c:1411
Read of size 8 at addr ffffffff8e05df10 by task kworker/u9:1/5152

CPU: 1 UID: 0 PID: 5152 Comm: kworker/u9:1 Tainted: G        W           syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: erofs_worker z_erofs_decompressqueue_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 z_erofs_decompress_pcluster fs/erofs/zdata.c:1274 [inline]
 z_erofs_decompress_queue+0x341/0x3580 fs/erofs/zdata.c:1411
 z_erofs_decompressqueue_work+0x82/0xd0 fs/erofs/zdata.c:1423
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

The buggy address belongs to the variable:
 z_erofs_decomp+0x30/0xe0

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xe05d
flags: 0x80000000002000(reserved|node=0|zone=1)
raw: 0080000000002000 ffffea0000381748 ffffea0000381748 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffffffff8e05de00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffff8e05de80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffffff8e05df00: 00 00 f9 f9 f9 f9 f9 f9 00 00 00 00 00 00 00 00
                         ^
 ffffffff8e05df80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffff8e05e000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

