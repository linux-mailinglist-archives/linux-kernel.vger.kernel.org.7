Return-Path: <linux-kernel+bounces-889878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 969D7C3EBFF
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D58104EB804
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14473093D7;
	Fri,  7 Nov 2025 07:29:27 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8043081CA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500566; cv=none; b=WP95UtiRcZ1W58NvZ784RjuND9aCmlGEm6MNCycG85/aAjxTfdin7ouIlrT4w9ZCHG/01BYbRCoqzuAs623OIg0qo59bbecye+R1fq69WEwCtkXQei/VBTfr6K84TM5G5mzueZHY+zEYWDXsCGJeAIhX2nWCzGFqMlj0KiBapNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500566; c=relaxed/simple;
	bh=T/6l23nZi52zglUNYwge3hIIaiT/4LeSIyGyn4yQr8A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UXJi8StmUN6EziyWCCHqb9KzpNJpTiHnqW2v4wQo8XrRyc+EnlQDCF/GrnTA49jrn9jyjj43mUrpOTVaojK3NJdFfAPJRU/QNUInbHf9Gq67Ck1HvOIuPzhcVkPT6MSEbd/xjCLR7U1XcAzMozmMcFve925KKZfSA8AuDHP27ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-940d88b8c15so39068739f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 23:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762500564; x=1763105364;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5W+rFgUZ/uJudC5g+eSdKAW0wXp+cC7dSDBHEAlSa4=;
        b=FmXuIMNInpxWPPBl4Qv/BXpe8NC5x/ogM5FAcrj3vd+6A4b7mH292bfHxZZJDxV+Yl
         cIA1jz22uZl/SaRjlVa1EqOM+GLH0fUa9XtM9Hyn2LDhOHcDWoKGMIMaTYvivy1d3uo9
         htFQkfn8ScobztqhchBMY92N4N6s55ktKujC1iXy3FjCSnbl7XYYBJAmt0frFW8BM2L5
         oK6n/U7NmSDVTd1zmtKIgpV3VWZxrRtWmFO1lAg8hFiq9Nz7MgIWd1PEBXiObP84fHSD
         DjE7DM6ehBEumy439cbIaVIXhw4RBTvflkbxzUTMG9Flxe21FgdZbmsn7GTwBsvaXoLx
         Qmtw==
X-Gm-Message-State: AOJu0YyBgJNt8g2r+o/sx7IwYfvrScIWJjDOHUmrEC0xj7VOK2oiQv4k
	h4n2mlaRRIwIQ8jCqGETuolPh7CSdIZDcP1B4qY0wXNdodDzwwWxlvO11Z7gWcqPHZaCSdKEVqn
	EKrQVGaHEHzrK/MNwO/V9xRDy5LNpexwwNq4K6F+9tl7NE1YX6zSsbMdv86vVIA==
X-Google-Smtp-Source: AGHT+IGJzTWQwoZJc4ZKPxmx0SxA2vnLX7i5ExPqU93a6I8oqil7cn132KQRnvDTiYgs7hTyXDz4fidWzX1eaIFdHKsNdN5qTU4r
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:308d:b0:433:3498:6906 with SMTP id
 e9e14a558f8ab-4335f4b5c8emr35355525ab.32.1762500564354; Thu, 06 Nov 2025
 23:29:24 -0800 (PST)
Date: Thu, 06 Nov 2025 23:29:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690d9fd4.a70a0220.22f260.0023.GAE@google.com>
Subject: [syzbot] [lsm?] memory leak in prepare_creds (5)
From: syzbot <syzbot+099461f8558eb0a1f4f3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, sergeh@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2c2ccfd4ba7 Merge tag 'net-6.18-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d6ca92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb128cd5cb439809
dashboard link: https://syzkaller.appspot.com/bug?extid=099461f8558eb0a1f4f3
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ac7012580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12aa10b4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b0451ba3fe41/disk-c2c2ccfd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d3e8c67119ab/vmlinux-c2c2ccfd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1d8e176e5054/bzImage-c2c2ccfd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+099461f8558eb0a1f4f3@syzkaller.appspotmail.com

2025/11/07 06:07:22 executed programs: 5
BUG: memory leak
unreferenced object 0xffff888101ad8900 (size 184):
  comm "syz-executor", pid 5986, jiffies 4294942797
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 45b79b1):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    kmem_cache_alloc_noprof+0x397/0x5a0 mm/slub.c:5287
    prepare_creds+0x22/0x4f0 kernel/cred.c:212
    copy_creds+0x44/0x290 kernel/cred.c:312
    copy_process+0x706/0x27d0 kernel/fork.c:2046
    kernel_clone+0x119/0x6c0 kernel/fork.c:2609
    __do_sys_clone+0x7b/0xb0 kernel/fork.c:2750
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88810096ace0 (size 32):
  comm "syz-executor", pid 5986, jiffies 4294942797
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    f8 f2 85 00 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace (crc 894df7a1):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    __do_kmalloc_node mm/slub.c:5641 [inline]
    __kmalloc_noprof+0x3e3/0x6b0 mm/slub.c:5654
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    lsm_blob_alloc+0x4d/0x70 security/security.c:690
    lsm_cred_alloc security/security.c:707 [inline]
    security_prepare_creds+0x30/0x270 security/security.c:3310
    prepare_creds+0x346/0x4f0 kernel/cred.c:242
    copy_creds+0x44/0x290 kernel/cred.c:312
    copy_process+0x706/0x27d0 kernel/fork.c:2046
    kernel_clone+0x119/0x6c0 kernel/fork.c:2609
    __do_sys_clone+0x7b/0xb0 kernel/fork.c:2750
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888128f3ca00 (size 1264):
  comm "kworker/1:1", pid 42, jiffies 4294942797
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    28 00 0b 40 00 00 00 00 00 00 00 00 00 00 00 00  (..@............
  backtrace (crc fdfa4398):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    kmem_cache_alloc_noprof+0x397/0x5a0 mm/slub.c:5287
    sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:2233
    sk_alloc+0x36/0x360 net/core/sock.c:2295
    __vsock_create.constprop.0+0x38/0x2f0 net/vmw_vsock/af_vsock.c:788
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1527 [inline]
    virtio_transport_recv_pkt+0x7fd/0xf30 net/vmw_vsock/virtio_transport_common.c:1655
    vsock_loopback_work+0xfe/0x140 net/vmw_vsock/vsock_loopback.c:133
    process_one_work+0x26b/0x620 kernel/workqueue.c:3263
    process_scheduled_works kernel/workqueue.c:3346 [inline]
    worker_thread+0x2c4/0x4f0 kernel/workqueue.c:3427
    kthread+0x15b/0x310 kernel/kthread.c:463
    ret_from_fork+0x210/0x240 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888146540100 (size 32):
  comm "kworker/1:1", pid 42, jiffies 4294942797
  hex dump (first 32 bytes):
    f8 f2 85 00 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc e7cc8a40):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    __do_kmalloc_node mm/slub.c:5641 [inline]
    __kmalloc_noprof+0x3e3/0x6b0 mm/slub.c:5654
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    lsm_blob_alloc+0x4d/0x70 security/security.c:690
    lsm_sock_alloc security/security.c:4922 [inline]
    security_sk_alloc+0x30/0x270 security/security.c:4938
    sk_prot_alloc+0x8f/0x1b0 net/core/sock.c:2242
    sk_alloc+0x36/0x360 net/core/sock.c:2295
    __vsock_create.constprop.0+0x38/0x2f0 net/vmw_vsock/af_vsock.c:788
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1527 [inline]
    virtio_transport_recv_pkt+0x7fd/0xf30 net/vmw_vsock/virtio_transport_common.c:1655
    vsock_loopback_work+0xfe/0x140 net/vmw_vsock/vsock_loopback.c:133
    process_one_work+0x26b/0x620 kernel/workqueue.c:3263
    process_scheduled_works kernel/workqueue.c:3346 [inline]
    worker_thread+0x2c4/0x4f0 kernel/workqueue.c:3427
    kthread+0x15b/0x310 kernel/kthread.c:463
    ret_from_fork+0x210/0x240 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888109c274e0 (size 96):
  comm "kworker/1:1", pid 42, jiffies 4294942797
  hex dump (first 32 bytes):
    00 ca f3 28 81 88 ff ff 00 00 00 00 00 00 00 00  ...(............
    00 00 00 00 00 00 00 00 00 00 04 00 00 00 00 00  ................
  backtrace (crc 4f48ed20):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5758
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    virtio_transport_do_socket_init+0x2b/0xf0 net/vmw_vsock/virtio_transport_common.c:910
    vsock_assign_transport+0x31b/0x3a0 net/vmw_vsock/af_vsock.c:537
    virtio_transport_recv_listen net/vmw_vsock/virtio_transport_common.c:1545 [inline]
    virtio_transport_recv_pkt+0x861/0xf30 net/vmw_vsock/virtio_transport_common.c:1655
    vsock_loopback_work+0xfe/0x140 net/vmw_vsock/vsock_loopback.c:133
    process_one_work+0x26b/0x620 kernel/workqueue.c:3263
    process_scheduled_works kernel/workqueue.c:3346 [inline]
    worker_thread+0x2c4/0x4f0 kernel/workqueue.c:3427
    kthread+0x15b/0x310 kernel/kthread.c:463
    ret_from_fork+0x210/0x240 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888101a80f00 (size 184):
  comm "syz-executor", pid 5986, jiffies 4294942798
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 51e903bf):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    kmem_cache_alloc_noprof+0x397/0x5a0 mm/slub.c:5287
    prepare_creds+0x22/0x4f0 kernel/cred.c:212
    copy_creds+0x44/0x290 kernel/cred.c:312
    copy_process+0x706/0x27d0 kernel/fork.c:2046
    kernel_clone+0x119/0x6c0 kernel/fork.c:2609
    __do_sys_clone+0x7b/0xb0 kernel/fork.c:2750
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


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

