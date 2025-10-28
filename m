Return-Path: <linux-kernel+bounces-873238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE9DC13788
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0006E5010DF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302322D062E;
	Tue, 28 Oct 2025 08:09:12 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694BF2AE8E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638951; cv=none; b=IrHtT+5foLff0ylLSwwcDV3dC/sJG8IW2sxR7v3tQnyN8p7CzNDXCOTrgEFZKTjWKh1nT6nv2S3Nks0++kJW+E0ihaXm6F2ZunSkWGRc5+G0dBroX2NhhvxLb6c0EIj7Uc+bobBfMLAf0CxSf1CV7ofNlR20G9O9aH5+zWC9Abw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638951; c=relaxed/simple;
	bh=1elN9SOhKDTqKBC7Sijm7QJsIvmaLJuXwvRu/IEV4g0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AiqS0m4OgJ1lt8k3MxV5IE0NRK63pjM2GfjpSkDwBik3D9afTwRgF2CgkYCeTMj+m/MrQq04hs7acq6ZOitUbr8kP+oDoceVU3CeAcllEtBpxwXzIXhbl8Gi0RSlmfbRKXykDD75G0euY828M1b1f/jv+dmyqzZtkGAhMKYG2d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430d4a4dec5so215767025ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761638946; x=1762243746;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4C7qszn/lM9Tl+ogHTCiBHrWVsWc7Vzs6z2DK2e8Nrk=;
        b=uytmT71EsyPjMYWp2gXeXu/acd/tomPAC43fvf4DICCcd6JD7YvjhD9kxKwRHGnOuJ
         fUQCihK/FhzqP2eT+yqzdqOAPShF2GVRS3k/dM3eVpzmbEJnNtEnoZjEScSFn9AGqxsa
         7ke3rLl6UPuV2AtsG+98+Ey2A+oTZGL3x1WdD8JzMr7A8z3mDYdTpEIuy28HFKEQVPIj
         BHRli8RlQEcJTtqaqv0eDUQqyO3e5GoarwD9NNLT9L01dURe45Wewt5SEWGRAYYaSO5M
         ZeQdqR1jsq9LVmgc7bvK8b4mjbN2BQwpRb3oLj8e7yufyNX/TsMxNoE87s1ZsBU6Uzbo
         WW4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8208SJbZRYDh9hPkzWFRWQognmD/YmJWzkZUZRF9Azxp+1bYe8enFWzwLFN4EsI4p7GDgNv7M2yqTVps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBjzKZQwG9eLiXDE1sVzBl462snxMFy+VMAhjwe0FlSKHnqSJL
	kIR4v77/QuvArPuE2+Pr79+eTsm+5gfZt2ns3EWkSSIkhQV4hCHDC7BeqSknox/mF14mSJ43Lme
	8a0An6FLdsMsl7eSvgIJnyey22B/CESOQEKGr0rSqSs+0GO0aMIyfIdqYTM8=
X-Google-Smtp-Source: AGHT+IFXX76eA4mnEuEiN7jFxOR686dz+xQuf1Qlnguvt/K+yD77qPznj8kdXzEIh8fnWSSdN+elD1EqYKnWsCAnXMdt+FCnz5m5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24f:0:b0:430:ac4a:4dc7 with SMTP id
 e9e14a558f8ab-4320f696048mr41117445ab.0.1761638946484; Tue, 28 Oct 2025
 01:09:06 -0700 (PDT)
Date: Tue, 28 Oct 2025 01:09:06 -0700
In-Reply-To: <tencent_BB9F66963C1B37B6964036B64A0E75957709@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69007a22.050a0220.3344a1.03ab.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] WARNING: ODEBUG bug in nilfs_detach_log_writer (2)
From: syzbot <syzbot+24d8b70f039151f65590@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: ODEBUG bug in nilfs_detach_log_writer

!!! sci 00000000654d1193 sctask 000000001d256998 nilfs_segctor_destroy
------------[ cut here ]------------
ODEBUG: free active (active state 0) object: 00000000cb289602 object type: timer_list hint: __ll_sc_atomic64_andnot arch/arm64/include/asm/atomic_ll_sc.h:-1 [inline]
ODEBUG: free active (active state 0) object: 00000000cb289602 object type: timer_list hint: arch_atomic64_andnot arch/arm64/include/asm/atomic.h:64 [inline]
ODEBUG: free active (active state 0) object: 00000000cb289602 object type: timer_list hint: raw_atomic64_andnot include/linux/atomic/atomic-arch-fallback.h:3675 [inline]
ODEBUG: free active (active state 0) object: 00000000cb289602 object type: timer_list hint: raw_atomic_long_andnot include/linux/atomic/atomic-long.h:964 [inline]
ODEBUG: free active (active state 0) object: 00000000cb289602 object type: timer_list hint: arch_clear_bit include/asm-generic/bitops/atomic.h:25 [inline]
ODEBUG: free active (active state 0) object: 00000000cb289602 object type: timer_list hint: clear_bit include/asm-generic/bitops/instrumented-atomic.h:42 [inline]
ODEBUG: free active (active state 0) object: 00000000cb289602 object type: timer_list hint: clear_nilfs_purging fs/nilfs2/the_nilfs.h:206 [inline]
ODEBUG: free active (active state 0) object: 00000000cb289602 object type: timer_list hint: nilfs_construction_timeout+0x0/0x50 fs/nilfs2/segment.c:2897
WARNING: CPU: 0 PID: 7171 at lib/debugobjects.c:615 debug_print_object lib/debugobjects.c:612 [inline]
WARNING: CPU: 0 PID: 7171 at lib/debugobjects.c:615 __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
WARNING: CPU: 0 PID: 7171 at lib/debugobjects.c:615 debug_check_no_obj_freed+0x390/0x470 lib/debugobjects.c:1129
Modules linked in:
CPU: 0 UID: 0 PID: 7171 Comm: syz-executor Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:612 [inline]
pc : __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
pc : debug_check_no_obj_freed+0x390/0x470 lib/debugobjects.c:1129
lr : debug_print_object lib/debugobjects.c:612 [inline]
lr : __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
lr : debug_check_no_obj_freed+0x390/0x470 lib/debugobjects.c:1129
sp : ffff80009d0378f0
x29: ffff80009d037930 x28: ffff0000d5f63c00 x27: 0000000000000000
x26: ffff80008aed7f20 x25: ffff0000d5f63a70 x24: ffff800082080abc
x23: ffff0000c6402188 x22: ffff0000d5f63000 x21: dfff800000000000
x20: 0000000000000000 x19: ffff0000d5f63800 x18: 1fffe000337db690
x17: 626f203230363938 x16: ffff800082de95c0 x15: 0000000000000001
x14: 1fffe000337db6fa x13: 0000000000000000 x12: 0000000000000000
x11: ffff6000337db6fb x10: 0000000000ff0100 x9 : b75f7cbc17284200
x8 : b75f7cbc17284200 x7 : ffff8000805638d4 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000807d4f2c
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 debug_print_object lib/debugobjects.c:612 [inline] (P)
 __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline] (P)
 debug_check_no_obj_freed+0x390/0x470 lib/debugobjects.c:1129 (P)
 slab_free_hook mm/slub.c:2454 [inline]
 slab_free mm/slub.c:6611 [inline]
 kfree+0x120/0x600 mm/slub.c:6818
 nilfs_segctor_destroy fs/nilfs2/segment.c:2815 [inline]
 nilfs_detach_log_writer+0x69c/0x93c fs/nilfs2/segment.c:2881
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
irq event stamp: 199786
hardirqs last  enabled at (199785): [<ffff800080559f90>] vprintk_store+0x898/0xac8 kernel/printk/printk.c:2329
hardirqs last disabled at (199786): [<ffff80008ade9700>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:434
softirqs last  enabled at (199286): [<ffff8000801f95fc>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (199284): [<ffff8000801f95c8>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer
NILFS (loop1): disposed unprocessed dirty file(s) when stopping log writer


Tested on:

commit:         b98c94ee arm64: mte: Do not warn if the page is alread..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1554dd42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=158bd6857eb7a550
dashboard link: https://syzkaller.appspot.com/bug?extid=24d8b70f039151f65590
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=178d832f980000


