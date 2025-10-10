Return-Path: <linux-kernel+bounces-847763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE897BCBA19
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 06:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D25740523F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 04:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20A920C038;
	Fri, 10 Oct 2025 04:19:29 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD2A1E5B70
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 04:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760069969; cv=none; b=Pkji9Fe7EZ5g+BusROy68kf9dZ9woXwXHB9KeDNATMVRTOiW3Uz1r7pPSQ+g4ziL4tmR9w9KRTquP8djfkTxscz7W4oNfy5cu5Yaj9jeBLLb0P3o7HZ2a5bszMsMp6NEvvM8EvwxvUGOF4dzJyYXFcqr/5aLDmjxVhd3nTjXYlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760069969; c=relaxed/simple;
	bh=X4vWqucx5Kcwu2eSTvHDuRtPw9jJFsHk8sz1Or4c9i0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=psPwfG4hgNvwZ+xndR7mX0MtUSj5Ldb8NZfQbtiaFewMBpuSwWmh40Uar5B/0WJqWSXoeQ0ndOJix2/3uKWsq9c7Glcgfmw1IlMyJEPEkMH0aeDD3HGwQGqwdGp1GiiUtETr1v+lszV5JdYcnqR03ofbcCfjpZ+r245YRt6EJIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-90e469a7f6bso483329339f.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 21:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760069966; x=1760674766;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yGQltiHAB8hMnc/QahGJ3qmDYxqfKV7yfoDqevYiDBM=;
        b=Jwzv4bkMDp37brVMg/ov1NQ/Nvo3j2e8jaMmP0sGrC7OjfJLJ215icf183NUZ1/xrP
         DpaykaOOT5OFKiGLuE1iXx1QYOC88PY675P05wHTiGLa2zcZaWEk2YNK7O7xJ4/jmGi6
         Ri4blpoFB5ryMcLqhx7aGyDwDKLVpGYQ0EwI7ofpcV/DsQ3L80H47esaR6V8gBwhhB4Q
         K06EZUS8V67HvCskJQ4MLB1xorP+tHErj51AAjM2Lc2OmeheuwdwImx6FfgjHWlHzLlT
         JzdhjB69l4WHpmCSCcNL/MYhYBxqVbGWvWlqfPovSw23Ow1PBBrG8Ft9gUv+wD6+H7QT
         ovpA==
X-Gm-Message-State: AOJu0YxD7HIEYArPM8FMdgRuWE/hV4+LuxMEwOGZWJ9Kvc0fOc1FUC8W
	U89tQWUVBBNXWs7hwoK9z1WsvvDUEXZ9hFyezRLcZ4TxJY6rlvxcgeb73zChbsEf9HbQcLXNabt
	4RaX/mYtlR1Q6FIv4PZ2CfPHbhjBYktS0AW1cy5+gyoC/baGVL4SuRf9TxNwFPQ==
X-Google-Smtp-Source: AGHT+IFLyIC7w3GTy4an7qyQzYnUGImlJBgOEQ8FhxciyBeNEOe81IUTgHvK8Pz1FRTccr2G1exi3zkIw8VJtsKx18HvUGdIpyJW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:134a:b0:91e:c3a4:537c with SMTP id
 ca18e2360f4ac-93bd19a54edmr1211148939f.14.1760069966635; Thu, 09 Oct 2025
 21:19:26 -0700 (PDT)
Date: Thu, 09 Oct 2025 21:19:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e8894e.050a0220.91a22.0056.GAE@google.com>
Subject: [syzbot] [media?] KMSAN: uninit-value in pctv452e_i2c_msg
From: syzbot <syzbot+480edd2cadb85ddb4bbe@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	mchehab@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9b0d551bcc05 Merge tag 'pull-misc' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e89a7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50fb29d81ff5a3df
dashboard link: https://syzkaller.appspot.com/bug?extid=480edd2cadb85ddb4bbe
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/90b0fb888152/disk-9b0d551b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1120c646f284/vmlinux-9b0d551b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/df9bbfa8cbe6/bzImage-9b0d551b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+480edd2cadb85ddb4bbe@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in hex_string+0x681/0x740 lib/vsprintf.c:1220
 hex_string+0x681/0x740 lib/vsprintf.c:1220
 pointer+0x2c7/0x1bd0 lib/vsprintf.c:2520
 vsnprintf+0xf8a/0x1bd0 lib/vsprintf.c:2930
 vscnprintf+0x6d/0x120 lib/vsprintf.c:2991
 printk_sprint+0x53/0x5c0 kernel/printk/printk.c:2189
 vprintk_store+0xbb9/0x1530 kernel/printk/printk.c:2309
 vprintk_emit+0x21a/0xb60 kernel/printk/printk.c:2399
 vprintk_default+0x3f/0x50 kernel/printk/printk.c:2438
 vprintk+0x36/0x50 kernel/printk/printk_safe.c:82
 _printk+0x17e/0x1b0 kernel/printk/printk.c:2448
 pctv452e_i2c_msg+0x82a/0x8f0 drivers/media/usb/dvb-usb/pctv452e.c:467
 pctv452e_i2c_xfer+0x2e6/0x4c0 drivers/media/usb/dvb-usb/pctv452e.c:502
 __i2c_transfer+0xecd/0x3110 drivers/i2c/i2c-core-base.c:-1
 i2c_transfer+0x300/0x4b0 drivers/i2c/i2c-core-base.c:2317
 i2c_transfer_buffer_flags+0x138/0x200 drivers/i2c/i2c-core-base.c:2345
 i2c_master_recv include/linux/i2c.h:79 [inline]
 i2cdev_read+0x1b2/0x3c0 drivers/i2c/i2c-dev.c:155
 vfs_read+0x27c/0xf90 fs/read_write.c:570
 ksys_pread64 fs/read_write.c:763 [inline]
 __do_sys_pread64 fs/read_write.c:771 [inline]
 __se_sys_pread64 fs/read_write.c:768 [inline]
 __x64_sys_pread64+0x2ab/0x3b0 fs/read_write.c:768
 x64_sys_call+0x3370/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:18
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5245 [inline]
 __kmalloc_cache_noprof+0x8f5/0x16b0 mm/slub.c:5719
 kmalloc_noprof include/linux/slab.h:957 [inline]
 pctv452e_i2c_msg+0x98/0x8f0 drivers/media/usb/dvb-usb/pctv452e.c:425
 pctv452e_i2c_xfer+0x2e6/0x4c0 drivers/media/usb/dvb-usb/pctv452e.c:502
 __i2c_transfer+0xecd/0x3110 drivers/i2c/i2c-core-base.c:-1
 i2c_transfer+0x300/0x4b0 drivers/i2c/i2c-core-base.c:2317
 i2c_transfer_buffer_flags+0x138/0x200 drivers/i2c/i2c-core-base.c:2345
 i2c_master_recv include/linux/i2c.h:79 [inline]
 i2cdev_read+0x1b2/0x3c0 drivers/i2c/i2c-dev.c:155
 vfs_read+0x27c/0xf90 fs/read_write.c:570
 ksys_pread64 fs/read_write.c:763 [inline]
 __do_sys_pread64 fs/read_write.c:771 [inline]
 __se_sys_pread64 fs/read_write.c:768 [inline]
 __x64_sys_pread64+0x2ab/0x3b0 fs/read_write.c:768
 x64_sys_call+0x3370/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:18
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 10013 Comm: syz.1.697 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
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

