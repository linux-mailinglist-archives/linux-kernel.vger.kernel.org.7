Return-Path: <linux-kernel+bounces-889882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254D8C3EC1A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4883B02D0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84715306B21;
	Fri,  7 Nov 2025 07:30:31 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97EB26A08F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500630; cv=none; b=EMN0V8eZeZq3B0J0U8NQyl0K5I3po81DHOOlhA2CS7lwd6JG/Yg53wsZLkDkLpQYE/pAkRyI3pCJOYquojmvp44PokkhDR7EYKj3/+CaHg8UCac2TUejc+3CeElIdN1/DHLJKCpAL3zPhAf6b+zNh7+Vz2jhYAoDjZLq6z2d3S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500630; c=relaxed/simple;
	bh=UAl14U6B5q+JxSbC6zOGXXeST/5imgK01d1/ubbPwLg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GOCWGXORHVCTw8vkNx+u9LLjSVyCBAndGu60NVNeTHM9gyd1GeHQppnWGFZleXa6ynKTB1fnyvZw5wYya51k9cxCd5volipPRT6bi8J+O5tIat86LzdzO6seyVscpDhcZNRqzbN+DAteUPZcYd6szZuxu3wmeWaKd7Wsq/NpQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-43331f93979so4671375ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 23:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762500628; x=1763105428;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=heKd22WotK6iLCFnkpjRxex8mc4gSmHavY8BDrJ+pOM=;
        b=E9ck+DvCjqrj8EjrEc4lCTSbwUyJ6w/RfdaIE6UQAcCTTntJ9Bj6la5kK59uicByLo
         Iem9Soz2vprLobkBpANpv475Cqdfx4Fu9bp8l4NxOIChwmRy3l7EZeS8CLxaOOR6t+2Y
         cKK6CPesp9srbzWbXi1ubl5DYNbeXqCUX+CA3cOxwVrp+srCC9Ad1L3g0faOq0N2pLil
         qtaC/UGEBPNGpdBMMSP5t9klbx5teOrHG63H2lMGvgUxuH7Zmfmn35HU65dsypnC7qiD
         p1N9d3y5vu/FtctlTQYauDXFFpPYQx0pM5O2xRE6X93eRGZ5Dv6/nkOUOMrOXabQWSPm
         UFtA==
X-Forwarded-Encrypted: i=1; AJvYcCUhbx4gsMUT+hj2TsQihCJsh7tAyqV34nfZvfeWWp5f475uj+P7GzLfrBYl7mB1TX2fMdLv5mma7eSZvCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkrK/bYTyQPwS4yMEucesRaWZkNpjlWjGKWSrQ5b0eboOtOci4
	REljnMVwrFg56PcYFyMzKA2GhSNLIQnYrTaXeKOkjaA8CDxSP10lI2mCaeHaOdA+mp99/20i9a9
	kYJNDCjHcUXszCCV1mK9syj5KAzVT/HKOFY1n3WCYMObhSVPvlfKlxBM2IMY=
X-Google-Smtp-Source: AGHT+IGhJ0q+jJIYSQuGSW5DTUmmUPhYBkaKKYwmwYvagBVwQ1SuE9hq+G1NX+r8i3arXD8hVFdOjr4kCMOoV5/BRIlEkuigt3YZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2282:b0:433:3060:f5b with SMTP id
 e9e14a558f8ab-43362a19bc9mr8881485ab.12.1762500627906; Thu, 06 Nov 2025
 23:30:27 -0800 (PST)
Date: Thu, 06 Nov 2025 23:30:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690da013.a70a0220.22f260.0025.GAE@google.com>
Subject: [syzbot] [gfs2?] memory leak in gfs2_trans_begin (2)
From: syzbot <syzbot+63ba84f14f62e61a5fd0@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2c2ccfd4ba7 Merge tag 'net-6.18-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a39084580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb128cd5cb439809
dashboard link: https://syzkaller.appspot.com/bug?extid=63ba84f14f62e61a5fd0
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171a7812580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1375dbcd980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b0451ba3fe41/disk-c2c2ccfd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d3e8c67119ab/vmlinux-c2c2ccfd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1d8e176e5054/bzImage-c2c2ccfd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1af9667b349a/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=131a7812580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+63ba84f14f62e61a5fd0@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888126cf1000 (size 144):
  comm "syz.2.26", pid 6030, jiffies 4294942626
  hex dump (first 32 bytes):
    c0 ef 59 82 ff ff ff ff 05 00 00 00 db 1a 00 00  ..Y.............
    0b 00 00 00 00 00 00 00 06 00 00 00 00 00 00 00  ................
  backtrace (crc f56b339f):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    kmem_cache_alloc_noprof+0x397/0x5a0 mm/slub.c:5287
    gfs2_trans_begin+0x29/0xa0 fs/gfs2/trans.c:115
    alloc_dinode fs/gfs2/inode.c:418 [inline]
    gfs2_create_inode+0xca0/0x1890 fs/gfs2/inode.c:807
    gfs2_atomic_open+0x98/0x190 fs/gfs2/inode.c:1387
    atomic_open fs/namei.c:3656 [inline]
    lookup_open fs/namei.c:3767 [inline]
    open_last_lookups fs/namei.c:3895 [inline]
    path_openat+0x13ef/0x1eb0 fs/namei.c:4131
    do_filp_open+0x102/0x1f0 fs/namei.c:4161
    do_sys_openat2+0xc1/0x140 fs/open.c:1437
    do_sys_open fs/open.c:1452 [inline]
    __do_sys_openat fs/open.c:1468 [inline]
    __se_sys_openat fs/open.c:1463 [inline]
    __x64_sys_openat+0xb2/0x100 fs/open.c:1463
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

