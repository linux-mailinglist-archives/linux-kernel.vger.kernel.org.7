Return-Path: <linux-kernel+bounces-744101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61522B107FE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD301CE5C74
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0318C267B9B;
	Thu, 24 Jul 2025 10:44:33 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C80125DAF0
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353872; cv=none; b=ajnuUe179/6AOi6Ng/uFkw2Y/EfeeLpvJnW1btvV7v7byakqLdufHTeJ+4FTgonfh079gtkO6suFDOkyXkLhrIzTTyti7yRNQW38ITLzyQQ7z7Nse40JiKLogNCfmow/Ia/hrUWy6kL2PNYiEhWDHw34QaVU8CTTGpOxZOmn+JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353872; c=relaxed/simple;
	bh=ClG6q54a5lBl1NKCJt07q67C5WOkG1Ft1JWXb3cUwHI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ceIqUx+ezFXLbf7TR7s97DbtwhfQAlF/cfEei0Q1masGFK5oUWWtxsvALh2A2ZFDwUpj9604af7pbjxU7QKPdLu5C6T2jsZUZscad0UrDqSxHIDKRswY+oBjFbA2Ao+sbvp5jct22hDnwgi/w25EyNhigWTFdl7fe+sqVdOpYuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-87c43c2af72so95898239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 03:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753353870; x=1753958670;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WHNLdLaWAvFQ06/dX1A0QL+mVzYnYIsWtU3obir3xlE=;
        b=jFIkCLJ5gXwIpj9T7nQMQY103KeDibv9pGS/TR4LLVCWuZNcz3DspmhSoKQjBQjuSO
         K6jCmnX3aSR6IrhLL4d50sgIHxy9eMNF80jnhd1RRSR0gE7Mjab7f26HSbeWUruu2aYl
         T7Zuq7C4brvMn0A2pJo4TlureR2cOI5CIUSdWoSPYnpZDw7/r2Q0IZSZSY2BusqvE2T+
         BWlgIt45Wk1kIqUQos+1mDetAvsyb/upvJCI229VJaaHdzcD0AZ3xgcPFkGjK6eUzfj7
         2xNA9KoHraTKnTfgyDrATahfOXh+ffNhDKgAFhlTv/8NH3v6/ky+FnS1NAkDstnerqdl
         3zaA==
X-Forwarded-Encrypted: i=1; AJvYcCUw3LaNv0kbjCojIT+IfbbcdSqP8oEn08UI3L24XlTD7r0ktRx9FUV4WK9H5r1UckEJ/YzkMOrgNGxXwiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeYo2r4ihnztC7rHSgaTqwV3lchUh4GbwhJ+BinvxvCoWvn5Wf
	4TVVQKUp8zpIObr04BMriFDo67qkjEeqvKQVkrw0pS3tZVVOrVdMR41VVsSPtkMsZmy6lQBT36f
	UWFc8vG4zlUdEvDzVnPjWIuVatNPjC5W7cy0rEAj9oE5qrM0ch25GskqD6xQ=
X-Google-Smtp-Source: AGHT+IGzPeiYlxtLes5JWty/tcmMQYsqm2aqGPTggCJEj308MjXFQC3amVZwlAdbFy6NoMGbIFEc58NdYmvSh4gdQ36A8NwhIrt2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6414:b0:876:a7cc:6eb7 with SMTP id
 ca18e2360f4ac-87c64ff4d1dmr1213377139f.9.1753353870126; Thu, 24 Jul 2025
 03:44:30 -0700 (PDT)
Date: Thu, 24 Jul 2025 03:44:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68820e8e.a00a0220.2f88df.0022.GAE@google.com>
Subject: [syzbot] [kernel?] KMSAN: uninit-value in hrtimer_wakeup
From: syzbot <syzbot+e84a763987edd173d82f@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bf61759db409 Merge tag 'sched_ext-for-6.16-rc6-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1693938c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5227c65742122bdd
dashboard link: https://syzkaller.appspot.com/bug?extid=e84a763987edd173d82f
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c9e297bb553f/disk-bf61759d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7f2d1bf53414/vmlinux-bf61759d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9a4f67426eab/bzImage-bf61759d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e84a763987edd173d82f@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in hrtimer_wakeup+0xcb/0xd0 kernel/time/hrtimer.c:1997
 hrtimer_wakeup+0xcb/0xd0 kernel/time/hrtimer.c:1997
 __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
 __hrtimer_run_queues+0x556/0xd80 kernel/time/hrtimer.c:1825
 hrtimer_interrupt+0x456/0xb80 kernel/time/hrtimer.c:1887
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1039 [inline]
 __sysvec_apic_timer_interrupt+0xa7/0x420 arch/x86/kernel/apic/apic.c:1056
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0x7f/0x90 arch/x86/kernel/apic/apic.c:1050
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:702
 memmove+0x28/0x1b0 arch/x86/lib/memmove_64.S:45
 ext4_xattr_set_entry+0x1928/0x3440 fs/ext4/xattr.c:1773
 ext4_xattr_block_set+0xc82/0x5010 fs/ext4/xattr.c:2020
 ext4_xattr_set_handle+0x2a44/0x2c00 fs/ext4/xattr.c:2447
 ext4_xattr_set+0x2ff/0x5b0 fs/ext4/xattr.c:2549
 ext4_xattr_trusted_set+0x51/0x70 fs/ext4/xattr_trusted.c:38
 __vfs_setxattr+0x742/0x850 fs/xattr.c:200
 __vfs_setxattr_noperm+0x224/0xad0 fs/xattr.c:234
 __vfs_setxattr_locked+0x448/0x490 fs/xattr.c:295
 vfs_setxattr+0x27f/0x640 fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 filename_setxattr+0x3a4/0xcc0 fs/xattr.c:665
 path_setxattrat+0x734/0x820 fs/xattr.c:713
 __do_sys_lsetxattr fs/xattr.c:754 [inline]
 __se_sys_lsetxattr fs/xattr.c:750 [inline]
 __x64_sys_lsetxattr+0x103/0x1c0 fs/xattr.c:750
 x64_sys_call+0x2464/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:190
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable t created at:
 hrtimer_nanosleep+0x48/0x480 kernel/time/hrtimer.c:2142
 common_nsleep+0x118/0x160 kernel/time/posix-timers.c:1353

CPU: 0 UID: 0 PID: 17784 Comm: syz.6.3366 Not tainted 6.16.0-rc6-syzkaller-00279-gbf61759db409 #0 PREEMPT(none) 
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

