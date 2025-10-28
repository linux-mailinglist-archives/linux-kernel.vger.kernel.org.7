Return-Path: <linux-kernel+bounces-873143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F785C13366
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04E26353142
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863DF28507B;
	Tue, 28 Oct 2025 06:54:11 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D5125D202
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761634450; cv=none; b=fP2D0XwldlImkMJaJ0HtC7PcKvwq6EsC6jvqXX/DNa+HZcU2q+zE66TbO2orGnEc9WRwlFcbNTZf/6uHo33905a8fSuID2WplHxwiSBNANiEkuI3r1K6D0ulDVlG+tLvHKtid8225CIwC5qS4iAy4g2cK3gWWJIPo55S7eDH7AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761634450; c=relaxed/simple;
	bh=35sSDvfgPAFSAKNuKYG1eyzV8pFiLlq+9MC6xBvPIzM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MXCgFDmaGY83l8IqxtimWPZdCdugrrvovyKeH3oXCLdkfhVhq8x7cim/UofuQB3uuPUbgl99SUKZpSuf1O4Bi64Q6JjjuJco3mKRJ9DF34MjtOa/cNXnir9pHfui8oMdeegoeOyhIJkYCOiAbDMDXEu10vyHu1mvu10KDb7vK/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-431d999ebe8so178948465ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761634445; x=1762239245;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtLvIOA2ATVl8Q/+n1RrtWhwreUfMqmfgd9BhZq3tkY=;
        b=sxU3S3QojRRvVhGODjHvvmEK45Fhbt8i0beDY4hcg2sIa/SilWoqjJe8yPDYzkeNtW
         MRxn/fKyNKwmLhsnB4r4eU905tXrJjvk5yEZLxKh34RAL3B+WQ9KDWwIKYSs7FKyTG9R
         tRZavmp+RLzpsFwGynTnstUZ995S+rhQNVXLNnnuC2Lnz+St7U5SLztxua7pFeEolZ/u
         P1yJa7ABSD6hi0FAw210SFu5mH8bBcX35KZrqXP1c43WxNvcrqUQL1Z56KeXBJE7ojAJ
         erApWRZUXEwUQzgYrD0zEV108tsoZkUw4vDd4s1K/5vwgiQc57UIQ+P4SiHuM5QAoNyS
         bBlA==
X-Forwarded-Encrypted: i=1; AJvYcCVCxJ50x6ciek5b5pAhf+8MUYaK7kCsq1JoXNR1yZ5xF3YhDWmovdmqr/s0MFGUAmiiRCk0GbASGI7Knno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6DT8SRep2VG/Id+Isph/tMJgJvR7TxkgDWxOkJO9RDfLI3DSI
	7c898Rsgj4dmdbvAG8+UjOkciQX8jtWF/SWHbV1Nt07ObrM2z69GUWaeAGV5YlSMLIjUERcKxxL
	OnEvBCXVhWvFXaHkexnkhA9xt0xzwTBeGwdzpt5+gQe4lOmXe8KtLiwtmQ50=
X-Google-Smtp-Source: AGHT+IH+qN0YHIR5qHmzelLLDCbI4x7jtFoHVE6tyoLVVuQGc6HPBwsI3+gLCu3zZ/fq6dx++EWjAwqIYEcOpRS2PIEwuJDd5G1G
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3983:b0:430:c78c:75d6 with SMTP id
 e9e14a558f8ab-4320f7a5ee9mr39505485ab.2.1761634445589; Mon, 27 Oct 2025
 23:54:05 -0700 (PDT)
Date: Mon, 27 Oct 2025 23:54:05 -0700
In-Reply-To: <tencent_1D087BFE6C682D456CDC95E8E8EEECF6CD0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6900688d.050a0220.32483.011d.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] WARNING: ODEBUG bug in nilfs_detach_log_writer (2)
From: syzbot <syzbot+24d8b70f039151f65590@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: ODEBUG bug in nilfs_detach_log_writer

sci 000000002fc63a1f sctask 00000000cb1c8b43 nilfs_segctor_destroy
------------[ cut here ]------------
ODEBUG: free active (active state 0) object: 00000000243cd50f object type: timer_list hint: __ll_sc_atomic64_andnot arch/arm64/include/asm/atomic_ll_sc.h:-1 [inline]
ODEBUG: free active (active state 0) object: 00000000243cd50f object type: timer_list hint: arch_atomic64_andnot arch/arm64/include/asm/atomic.h:64 [inline]
ODEBUG: free active (active state 0) object: 00000000243cd50f object type: timer_list hint: raw_atomic64_andnot include/linux/atomic/atomic-arch-fallback.h:3675 [inline]
ODEBUG: free active (active state 0) object: 00000000243cd50f object type: timer_list hint: raw_atomic_long_andnot include/linux/atomic/atomic-long.h:964 [inline]
ODEBUG: free active (active state 0) object: 00000000243cd50f object type: timer_list hint: arch_clear_bit include/asm-generic/bitops/atomic.h:25 [inline]
ODEBUG: free active (active state 0) object: 00000000243cd50f object type: timer_list hint: clear_bit include/asm-generic/bitops/instrumented-atomic.h:42 [inline]
ODEBUG: free active (active state 0) object: 00000000243cd50f object type: timer_list hint: clear_nilfs_purging fs/nilfs2/the_nilfs.h:206 [inline]
ODEBUG: free active (active state 0) object: 00000000243cd50f object type: timer_list hint: nilfs_construction_timeout+0x0/0x50 fs/nilfs2/segment.c:2899
WARNING: CPU: 1 PID: 7086 at lib/debugobjects.c:615 debug_print_object lib/debugobjects.c:612 [inline]
WARNING: CPU: 1 PID: 7086 at lib/debugobjects.c:615 __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
WARNING: CPU: 1 PID: 7086 at lib/debugobjects.c:615 debug_check_no_obj_freed+0x390/0x470 lib/debugobjects.c:1129
Modules linked in:
CPU: 1 UID: 0 PID: 7086 Comm: syz-executor Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:612 [inline]
pc : __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
pc : debug_check_no_obj_freed+0x390/0x470 lib/debugobjects.c:1129
lr : debug_print_object lib/debugobjects.c:612 [inline]
lr : __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
lr : debug_check_no_obj_freed+0x390/0x470 lib/debugobjects.c:1129
sp : ffff8000a1b578f0
x29: ffff8000a1b57930 x28: ffff0000dbe26c00 x27: 0000000000000000
x26: ffff80008aed7f20 x25: ffff0000dbe26a70 x24: ffff800082080b44
x23: ffff0000ca04be70 x22: ffff0000dbe26000 x21: dfff800000000000
x20: 0000000000000000 x19: ffff0000dbe26800 x18: 00000000ffffffff
x17: 626f206630356463 x16: ffff800082de9640 x15: 0000000000000001
x14: 1ffff0001436ae54 x13: 0000000000000000 x12: 0000000000000000
x11: 00000000778946ad x10: 0000000000ff0100 x9 : 73910471fe57b500
x8 : 73910471fe57b500 x7 : ffff8000805638d4 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000002
x2 : 0000000000000002 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 debug_print_object lib/debugobjects.c:612 [inline] (P)
 __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline] (P)
 debug_check_no_obj_freed+0x390/0x470 lib/debugobjects.c:1129 (P)
 slab_free_hook mm/slub.c:2454 [inline]
 slab_free mm/slub.c:6611 [inline]
 kfree+0x120/0x600 mm/slub.c:6818
 nilfs_segctor_destroy fs/nilfs2/segment.c:2817 [inline]
 nilfs_detach_log_writer+0x684/0x9c4 fs/nilfs2/segment.c:2883
 nilfs_put_super+0x4c/0x12c fs/nilfs2/super.c:509
 generic_shutdown_super+0x12c/0x2b8 fs/super.c:642
 kill_block_super+0x44/0x90 fs/super.c:1722
 deactivate_locked_super+0xc4/0x12c fs/super.c:473
 deactivate_super+0xe0/0x100 fs/super.c:506
 cleanup_mnt+0x31c/0x3ac fs/namespace.c:1327
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1334
 task_work_run+0x1dc/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xfc/0x178 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 arm64_exit_to_user_mode arch/arm64/kernel/entry-common.c:103 [inline]
 el0_svc+0x170/0x254 arch/arm64/kernel/entry-common.c:747
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
irq event stamp: 393728
hardirqs last  enabled at (393727): [<ffff800080559f90>] vprintk_store+0x898/0xac8 kernel/printk/printk.c:2329
hardirqs last disabled at (393728): [<ffff80008ade9780>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:434
softirqs last  enabled at (393526): [<ffff8000803d7488>] softirq_handle_end kernel/softirq.c:468 [inline]
softirqs last  enabled at (393526): [<ffff8000803d7488>] handle_softirqs+0xaf8/0xc88 kernel/softirq.c:650
softirqs last disabled at (392817): [<ffff800080022024>] __do_softirq+0x14/0x20 kernel/softirq.c:656
---[ end trace 0000000000000000 ]---
kthread start to stop (sci 000000005be7e884)sctask 000000008631ea2b, nilfs_segctor_destroy
kthread stopped (sci 000000005be7e884)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 000000009d71d04a)sctask 00000000a0141cfe, nilfs_segctor_destroy
kthread stopped (sci 000000009d71d04a)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 000000002b2f1418)sctask 000000006c451d11, nilfs_segctor_destroy
kthread stopped (sci 000000002b2f1418)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 00000000effbdfa6)sctask 00000000a6318a24, nilfs_segctor_destroy
kthread stopped (sci 00000000effbdfa6)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 000000000fdbe516)sctask 0000000026c32dd0, nilfs_segctor_destroy
kthread stopped (sci 000000000fdbe516)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 000000001905d913)sctask 0000000050a4687e, nilfs_segctor_destroy
kthread stopped (sci 000000001905d913)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 00000000a3eeddcd)sctask 0000000079f3d7c8, nilfs_segctor_destroy
kthread stopped (sci 00000000a3eeddcd)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 0000000095360f23)sctask 0000000017af06a9, nilfs_segctor_destroy
kthread stopped (sci 0000000095360f23)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 000000005a9a2e80)sctask 00000000450f99c2, nilfs_segctor_destroy
kthread stopped (sci 000000005a9a2e80)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 00000000a5326494)sctask 000000003bc4f8b8, nilfs_segctor_destroy
kthread stopped (sci 00000000a5326494)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 00000000a603b099)sctask 000000008631ea2b, nilfs_segctor_destroy
kthread stopped (sci 00000000a603b099)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 00000000affd4105)sctask 0000000064524a43, nilfs_segctor_destroy
kthread stopped (sci 00000000affd4105)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 0000000028cafbde)sctask 000000005945da3a, nilfs_segctor_destroy
kthread stopped (sci 0000000028cafbde)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 000000004d042e5c)sctask 0000000034209c98, nilfs_segctor_destroy
kthread stopped (sci 000000004d042e5c)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 00000000d5a02571)sctask 000000008197e345, nilfs_segctor_destroy
kthread stopped (sci 00000000d5a02571)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 00000000cb8a270a)sctask 00000000a075cdeb, nilfs_segctor_destroy
kthread stopped (sci 00000000cb8a270a)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 0000000023a2d3ea)sctask 00000000952a7887, nilfs_segctor_destroy
kthread stopped (sci 0000000023a2d3ea)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 00000000ce675362)sctask 000000000df5a992, nilfs_segctor_destroy
kthread stopped (sci 00000000ce675362)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 00000000576731dc)sctask 0000000082cdf5af, nilfs_segctor_destroy
kthread stopped (sci 00000000576731dc)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 00000000e5b3a0b0)sctask 00000000e4102e6b, nilfs_segctor_destroy
kthread stopped (sci 00000000e5b3a0b0)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 000000008c9fa24c)sctask 00000000ca2032a8, nilfs_segctor_destroy
kthread stopped (sci 000000008c9fa24c)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 0000000072959ad0)sctask 00000000d02d4a8e, nilfs_segctor_destroy
kthread stopped (sci 0000000072959ad0)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 00000000dc9d7abc)sctask 00000000979ed9ea, nilfs_segctor_destroy
kthread stopped (sci 00000000dc9d7abc)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 00000000b18846c3)sctask 0000000076687d8f, nilfs_segctor_destroy
kthread stopped (sci 00000000b18846c3)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 00000000536e8ffd)sctask 000000007798b86f, nilfs_segctor_destroy
kthread stopped (sci 00000000536e8ffd)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 000000006b6f7633)sctask 0000000087ea6322, nilfs_segctor_destroy
kthread stopped (sci 000000006b6f7633)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 00000000eadf0db0)sctask 0000000020355604, nilfs_segctor_destroy
kthread stopped (sci 00000000eadf0db0)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 000000007344f784)sctask 00000000e08f1ab4, nilfs_segctor_destroy
kthread stopped (sci 000000007344f784)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 0000000010fbc4d9)sctask 00000000f03c335c, nilfs_segctor_destroy
kthread stopped (sci 0000000010fbc4d9)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 00000000f46a4493)sctask 00000000ba507f0b, nilfs_segctor_destroy
kthread stopped (sci 00000000f46a4493)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 0000000060b110ed)sctask 000000003b1ab5ad, nilfs_segctor_destroy
kthread stopped (sci 0000000060b110ed)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 00000000694aac4c)sctask 0000000060a56e61, nilfs_segctor_destroy
kthread stopped (sci 00000000694aac4c)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 000000009864c2ac)sctask 000000006e998649, nilfs_segctor_destroy
kthread stopped (sci 000000009864c2ac)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 00000000e0e3a3e5)sctask 00000000ac1e6b29, nilfs_segctor_destroy
kthread stopped (sci 00000000e0e3a3e5)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 000000005a10065e)sctask 00000000057002a4, nilfs_segctor_destroy
kthread stopped (sci 000000005a10065e)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 00000000e4f1117f)sctask 00000000d1405353, nilfs_segctor_destroy
kthread stopped (sci 00000000e4f1117f)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 000000001b211764)sctask 000000006280584a, nilfs_segctor_destroy
kthread stopped (sci 000000001b211764)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 00000000090abbc6)sctask 00000000c3e1a812, nilfs_segctor_destroy
kthread stopped (sci 00000000090abbc6)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 000000006e76001d)sctask 00000000eed8bd1d, nilfs_segctor_destroy
kthread stopped (sci 000000006e76001d)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 0000000009c3f81c)sctask 00000000030407b5, nilfs_segctor_destroy
kthread stopped (sci 0000000009c3f81c)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 000000006c06e552)sctask 00000000368252a8, nilfs_segctor_destroy
kthread stopped (sci 000000006c06e552)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 0000000000ea9b08)sctask 0000000026c266fc, nilfs_segctor_destroy
kthread stopped (sci 0000000000ea9b08)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 00000000694aac4c)sctask 0000000012ac78da, nilfs_segctor_destroy
kthread stopped (sci 00000000694aac4c)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 0000000040949351)sctask 00000000a59115fd, nilfs_segctor_destroy
kthread stopped (sci 0000000040949351)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 0000000020aa063d)sctask 00000000b617a775, nilfs_segctor_destroy
kthread stopped (sci 0000000020aa063d)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 000000006c416ffd)sctask 00000000da61bfc3, nilfs_segctor_destroy
kthread stopped (sci 000000006c416ffd)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 00000000cb84fb3c)sctask 0000000030bae658, nilfs_segctor_destroy
kthread stopped (sci 00000000cb84fb3c)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer
kthread start to stop (sci 0000000023c9588c)sctask 00000000bfd16b12, nilfs_segctor_destroy
kthread stopped (sci 0000000023c9588c)sctask 0000000000000000 thread return 0, nilfs_segctor_destroy
NILFS (loop4): disposed unprocessed dirty file(s) when stopping log writer


Tested on:

commit:         b98c94ee arm64: mte: Do not warn if the page is alread..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1252d3cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=158bd6857eb7a550
dashboard link: https://syzkaller.appspot.com/bug?extid=24d8b70f039151f65590
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16fbef34580000


