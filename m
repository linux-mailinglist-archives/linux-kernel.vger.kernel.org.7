Return-Path: <linux-kernel+bounces-896366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 687F6C50347
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555D61898F23
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873952264CB;
	Wed, 12 Nov 2025 01:25:13 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30FC1B142D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762910713; cv=none; b=pcM6SS8uzBdPIquf9CuY3kAhYIiETJHHbkzPhYihSIA9Tbyx87wyTukSd4dlUQ8ydJWHKvoQLNOMKrKVapYydzzlbQd/0oKamBQiwzMT27aSXdD7bC1zDQj7oSYDY1ZFF/ZaNUuLIE+dcKtcuzyWisVlcswlr2k2p+3WmHaF6uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762910713; c=relaxed/simple;
	bh=pLB/kIQGK0SuZZERrMjldSD6SsrWRihSSaUH+N2kviE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aXYtpvu5TM/sOqKF/gBy8iZaGjA21e5D9TSnys/cBdb7cI7yuOPa+TE6LhCHxYxle3kcE26HVkV6UHFcycyV1kA9o0/h7+pH+2powkuuC8zvOOXNmd1bVCEh+98AQc/LSCUcA2O+CDwgql2C4n3yBQRfF6hMTaPs4aEWXQbC4Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-43322fcfae7so4607735ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762910705; x=1763515505;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncXaA+9TnQ13+rGb1+wb1nZPYswGmuvyO1VvGUdF6PM=;
        b=vGTLal5sXz+6ewx0cMBKz8XgC3LxMhaNqwNj01pONCozWq4SmmUSBT43TjVlHM2xPk
         ljtNYVN+uKha+3iCR9RndVrzMGVZsddJslYMkdWnGbd6yjX1uhIJsEyBiPgTL3XURz5e
         wxhzg4hz6P/7+C1H9/xUXgS+e1GaKXx+HZgOE89Xx5tmr5hIs8I4WTyZBXUSAfyd44ON
         LIf2jl44jpHE6ryk1rFGhbkfn6pIl1mOi9Ohxqcs7xuFBypZoDKdsQQqUKmGYLY9DQRe
         YNRLk2d/XZxtiODfF3RedS0Z/KvXfMbyTlAuIuZYe0jnKgpfBz30XDEAIjsiuUo3RuA2
         xt6A==
X-Forwarded-Encrypted: i=1; AJvYcCU9Vi/T8mJteVM49xRqviab9QxXaA7ipZsGs5dxx2HPRQl69QRXfWnEPi/jsPZVWNT3cj6Y/88Ip9iPtd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa8cEpSBAoPqhPp14Kv+rCpUevdx2vIhCfDbgSdYRhuYCc+Y2V
	kqF/WweiJWAqVUDw7oomtsQIAjK0xdw39PIyHOu2+WNTHM7ZdKXdrWc3F5bDtBQcKPwqB/YJrkx
	aPaG9kpGMy2/urslDZi3PvvEoafVKkcUDkQy6sQDLmrCYJMxFG9laS5aehdc=
X-Google-Smtp-Source: AGHT+IEGU4GUi36Mpn7C1FnTXsrbqmpe2xwzOBwgOdclIJFheI4zPDB8xsf79rZcfiI43H6+bFA6ygnAfCvRaDtVU21nwwm363R8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1522:b0:433:283c:b9f with SMTP id
 e9e14a558f8ab-43473cfef3dmr16201015ab.3.1762910704899; Tue, 11 Nov 2025
 17:25:04 -0800 (PST)
Date: Tue, 11 Nov 2025 17:25:04 -0800
In-Reply-To: <20251112005422.2038252-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6913e1f0.a70a0220.22f260.0152.GAE@google.com>
Subject: Re: [syzbot] [fs?] [mm?] KMSAN: kernel-infoleak in hugetlbfs_read_iter
From: syzbot <syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: kernel-infoleak in hugetlbfs_read_iter

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inline]
BUG: KMSAN: kernel-infoleak in iterate_iovec include/linux/iov_iter.h:52 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_iter.h:330 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x4e4/0x33f0 lib/iov_iter.c:185
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 copy_to_user_iter lib/iov_iter.c:24 [inline]
 iterate_iovec include/linux/iov_iter.h:52 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
 iterate_and_advance include/linux/iov_iter.h:330 [inline]
 _copy_to_iter+0x4e4/0x33f0 lib/iov_iter.c:185
 copy_page_to_iter+0x482/0x910 lib/iov_iter.c:362
 copy_folio_to_iter include/linux/uio.h:204 [inline]
 hugetlbfs_read_iter+0x6cd/0xe10 fs/hugetlbfs/inode.c:281
 do_iter_readv_writev+0x9e1/0xc20 fs/read_write.c:-1
 vfs_readv+0x34a/0xf30 fs/read_write.c:1018
 do_preadv fs/read_write.c:1132 [inline]
 __do_sys_preadv fs/read_write.c:1179 [inline]
 __se_sys_preadv fs/read_write.c:1174 [inline]
 __x64_sys_preadv+0x2a3/0x510 fs/read_write.c:1174
 x64_sys_call+0x3064/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:296
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_frozen_pages_noprof+0x689/0xf00 mm/page_alloc.c:5206
 alloc_buddy_hugetlb_folio mm/hugetlb.c:1944 [inline]
 only_alloc_fresh_hugetlb_folio+0x2b0/0x1280 mm/hugetlb.c:1984
 alloc_pool_huge_folio+0x60f/0x760 mm/hugetlb.c:2042
 set_max_huge_pages mm/hugetlb.c:3912 [inline]
 __nr_hugepages_store_common+0x609/0x1420 mm/hugetlb.c:4206
 hugetlb_sysctl_handler_common mm/hugetlb.c:5129 [inline]
 hugetlb_sysctl_handler+0x1f7/0x2a0 mm/hugetlb.c:5139
 proc_sys_call_handler+0x86b/0xdc0 fs/proc/proc_sysctl.c:600
 proc_sys_write+0x3b/0x50 fs/proc/proc_sysctl.c:626
 __kernel_write_iter+0x6fa/0xdd0 fs/read_write.c:619
 __kernel_write fs/read_write.c:639 [inline]
 kernel_write+0x322/0x710 fs/read_write.c:660
 process_sysctl_arg+0x74b/0x1150 fs/proc/proc_sysctl.c:1687
 parse_one kernel/params.c:153 [inline]
 parse_args+0x652/0x1190 kernel/params.c:186
 do_sysctl_args+0xf8/0x210 fs/proc/proc_sysctl.c:1719
 kernel_init+0xf7/0x5e0 init/main.c:1506
 ret_from_fork+0x1f5/0x4c0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Bytes 0-5 of 6 are uninitialized
Memory access of size 6 starts at ffff88811b20000f
Data copied to user address 0000200000000080

CPU: 0 UID: 0 PID: 6511 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
=====================================================


Tested on:

commit:         24172e0d Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14cbdc12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbf50e713aaa5cb0
dashboard link: https://syzkaller.appspot.com/bug?extid=f64019ba229e3a5c411b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13508692580000


