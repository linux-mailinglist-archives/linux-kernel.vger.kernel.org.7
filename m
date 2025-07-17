Return-Path: <linux-kernel+bounces-735865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E177B094B0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01ECD7B9BA2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E632FE321;
	Thu, 17 Jul 2025 19:14:36 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB87259498
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779676; cv=none; b=YHFJBF2tCPFdCCFWauENvW0m7EGEe6CSKG5nRoUp/9Xx+MfOJ1irEM31fReVJk8iAIlqJj3y+lm6DPA2BY0KlvCCRgafAK9B7BjSzqRy/8v5py5fBadrbjplZsxs/XW+W7ZL6vWiAO6Q1qmy9VfzpChYE6lv9kEC7zKIq8i6VBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779676; c=relaxed/simple;
	bh=80cPVP8dBRTgeAxGBf+/AfuHQGI9WJpJi/WRFLrDWLM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MyVCz9RHO7Gdm5xKRTJ0znhgIfz8+dTvuOUurrx6r5yO0f/IvLXGS+cr/YpiqtBaae56zWWwmpjKCPMLROKhqYrw/2vzChSz2mnCPcaoYd+YfjRvaHnK+P+xfIzMJ1lrO2lsPQ8Z4nuZR5X/5Qzz5I53NLstPkg1ADvCQ5MsDbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-86a5def8869so254845139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752779673; x=1753384473;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rCvWwIUHFfj/ZL2xvMKgnwA5ggfoc4ARfan9WjRjStI=;
        b=Ght9y4EDk01glFTetKkJ0hYslQzMpso18RlIw/h3G9gdu95phaA8DHvkCxwGXkEsl6
         nO3GX01IHk/+lH/Ph0oYfctRmMj+r1JJWtbWHugF/zcHcmV6pIDwscQueAbW4mgjccM3
         yDLqmNXS1Z92th8cU+U+ceUqAGfmd2TIVnN5dzcNIgyEIhRa3Ebz45q5r6UXEghO3HvZ
         +pb1tpeKfmslPzset1sB20W3ti3JSOsJ96wqGalkhvIHCzZdINzHnG0Xwn36lvoFMr4P
         P0U8f52QuMUrqhibAZaMH/rTl7qy5yXlmXx6MFJp1CyiIsRfRwaliseVkMozxsUmywq9
         bibA==
X-Forwarded-Encrypted: i=1; AJvYcCXpZEnQDDedlJWNw+fV/mVlvP68i8pebeflqPhfbEC3nyZg0IzpeX1CFDi3khYHp9OtXQjXtFGQzxXJj/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBFeD+XZmsbOEYrCDQAtZTA1ZF1krPehQbZ/vka/i986rqXS7d
	U5VWq7c9zoKMGyFkBOnVKGANGkcH+flX3O0oT7o0LFWq9MzUOS4CnR2Vdc9j84C7ea+AelqJCMD
	KN5NMjVOPyxT7VdNbdTUQxcMHn6eTiqP5J9ZXuepBQDzGLmdq/1Gd5+voh88=
X-Google-Smtp-Source: AGHT+IEs3uSgllDfnSgpisaG+tnTs3pgXQiG/aAmabB18s6MBLd2pysJAyFiFLpEFlxSzVPCzNVpcvPwrNPwzdcrsUYV2ytZ+ExC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:485:b0:879:c608:d1d5 with SMTP id
 ca18e2360f4ac-879c608d725mr868453339f.14.1752779673649; Thu, 17 Jul 2025
 12:14:33 -0700 (PDT)
Date: Thu, 17 Jul 2025 12:14:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68794b99.a70a0220.693ce.0053.GAE@google.com>
Subject: [syzbot] [kernel?] KMSAN: kernel-infoleak in do_insn_ioctl
From: syzbot <syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, hsweeten@visionengravers.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e2291551827f Merge tag 'probes-fixes-v6.16-rc6' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1220e7d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fdecd0cbf7c2893
dashboard link: https://syzkaller.appspot.com/bug?extid=a5e45f768aab5892da5d
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/45d0dd363fc0/disk-e2291551.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2ac861991e19/vmlinux-e2291551.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a6c77d2eaafd/bzImage-e2291551.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in _inline_copy_to_user include/linux/uaccess.h:196 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0xcc/0x120 lib/usercopy.c:26
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 _inline_copy_to_user include/linux/uaccess.h:196 [inline]
 _copy_to_user+0xcc/0x120 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:225 [inline]
 do_insn_ioctl+0x516/0x630 drivers/comedi/comedi_fops.c:1641
 comedi_unlocked_ioctl+0x13dd/0x1e00 drivers/comedi/comedi_fops.c:2263
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
 do_insn_ioctl+0x108/0x630 drivers/comedi/comedi_fops.c:1623
 comedi_unlocked_ioctl+0x13dd/0x1e00 drivers/comedi/comedi_fops.c:2263
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0x239/0x400 fs/ioctl.c:893
 __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:893
 x64_sys_call+0x1ebe/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Bytes 4-583 of 584 are uninitialized
Memory access of size 584 starts at ffff88810355d000

CPU: 0 UID: 0 PID: 12350 Comm: syz.1.1721 Tainted: G        W           6.16.0-rc6-syzkaller-00037-ge2291551827f #0 PREEMPT(none) 
Tainted: [W]=WARN
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

