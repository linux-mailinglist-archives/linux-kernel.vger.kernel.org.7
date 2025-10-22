Return-Path: <linux-kernel+bounces-865373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B82BFCE92
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCF019A1389
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469A8221FBF;
	Wed, 22 Oct 2025 15:36:10 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2777027281D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147369; cv=none; b=p9SzZfFqhHiDcKQPfrcNRx8w969kv4Qb8DzWklzXRGc9G2z/C090PRnucxcPcDrQ1Ij3nGzVIXaf5bYg+Wv/EHBWKhRaf6YBcb/SBLQVrmB+UEO7s051P/nySPoz6OAMAv+nEm0qcdeoRXH/rcNEu1yrLyTITm3V/zMXhKv57eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147369; c=relaxed/simple;
	bh=oMKLXDrI+x3q8L6+l67ytYfU5BP0HlAHxymiMm8nxjQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pQJAudoFsv1kgO9b5wDYfbogZ/9Y4eJZqAkZvAQXcpVktuhfc7Gn/JwLt7yBAwmaadYVXC+bb5W7eHcRDYCe5O7qODqr48krUke6PuGYOHty96KFAOkSzKEiLxJMybZqqfx4T4lHRRAJL1JmN1UPzLlLuKKOk213ngJQsZtCO/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-431d84fdb91so12035305ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761147364; x=1761752164;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ilm5j6Knalm3iFZB0CyEqW6BPEmZbZ5iAckFa10bnFg=;
        b=Wsuy7t8hQ5YKsHIlRt5x2mG565hgdjtDtLQvCu5GvFXRK0szHd4mcdmhM0Hu56LbMY
         lJ84WfSnjqqL5taJr8sYnmsjJ/GA8zmzX/FQEP7rI3obshwpogvPyZMp3TwjAsdh8sYv
         rmHs0Ene0Hd4tpG06IrZV7Uz0IzN+pOJNxEaRDscoxqXTaJBb6BX/y6ua6vNPjSuZqq/
         zivBWO9WvPdVZFshX++nhNFOuzK+7Q1hSd8TRqvYKU9lBjHTu5UQ76a05jPNNsclb5y7
         UGkA/M88zgLYhcrXsVrPimFbAYs5+jZfCwN7+Fy6SmgA4QKP0ja0YuZRcrrwHJKQw0yY
         IW8g==
X-Forwarded-Encrypted: i=1; AJvYcCULbKOu9ObJe9QfP2BGa6pcAzd3LapYAyPvEgXidW342hnFc0yBwWjntrmTonUdbXbQFzDW8elS8XKKd5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrnJBy/ctwhGdHegDURk4DxwE5qVwP961+RuDTl5DzNOWCsW47
	9jxjQaBqZc5P00nXRFjMaSvdlp1qlVAD5pEUC+EaKh3l6gF45YG5JE9pV7nlK1W0sv1kA9sVUkx
	3QhGkZ5VFPDUTpYVUNX1A7JUrRdWNDb+mJUoTVhdoQi+MAzQV0/YaGbPSPwE=
X-Google-Smtp-Source: AGHT+IGJpJG2QvrlVe9lpjd3uBNZA7g3FhzXSgiOpU7LBhuZ3u6qeQhSqM8aMfEhRZ4Iz8DGDerG/hcewpiQiyDVsZqMePLVAis4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3101:b0:431:d76b:d133 with SMTP id
 e9e14a558f8ab-431d76bd17cmr27617175ab.12.1761147364391; Wed, 22 Oct 2025
 08:36:04 -0700 (PDT)
Date: Wed, 22 Oct 2025 08:36:04 -0700
In-Reply-To: <20251022150519.sco_Q%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8f9e4.050a0220.346f24.0059.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_reserve_suballoc_bits
From: syzbot <syzbot+fd05de09d1267725aa95@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in ocfs2_reserve_suballoc_bits

------------[ cut here ]------------
kernel BUG at fs/ocfs2/suballoc.c:820!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5814 Comm: syz.0.16 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ocfs2_reserve_suballoc_bits+0x3f67/0x46f0 fs/ocfs2/suballoc.c:820
Code: 24 98 00 00 00 80 e1 07 fe c1 38 c1 0f 8c a0 f0 ff ff 48 8b bc 24 98 00 00 00 e8 a4 15 79 fe e9 8e f0 ff ff e8 3a d6 11 fe 90 <0f> 0b 89 d1 80 e1 07 fe c1 38 c1 0f 8c d7 db ff ff 48 8b 7c 24 30
RSP: 0018:ffffc90002bbdca0 EFLAGS: 00010293
RAX: ffffffff83addc46 RBX: ffff888040d64fb8 RCX: ffff8880002cc900
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: ffffc90002bbe170 R08: ffffffff8f7c7677 R09: 1ffffffff1ef8ece
R10: dffffc0000000000 R11: fffffbfff1ef8ecf R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88804306ce00 R15: 00000000ffffffff
FS:  00007f125eda36c0(0000) GS:ffff88808d75f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f125ed80fb8 CR3: 00000000578b5000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 ocfs2_reserve_cluster_bitmap_bits+0xc4/0x1c0 fs/ocfs2/suballoc.c:1148
 ocfs2_local_alloc_reserve_for_window fs/ocfs2/localalloc.c:1106 [inline]
 ocfs2_local_alloc_slide_window fs/ocfs2/localalloc.c:1242 [inline]
 ocfs2_reserve_local_alloc_bits+0x88f/0x24b0 fs/ocfs2/localalloc.c:669
 ocfs2_reserve_clusters_with_limit+0x1be/0xba0 fs/ocfs2/suballoc.c:1182
 ocfs2_reserve_clusters fs/ocfs2/suballoc.c:1243 [inline]
 ocfs2_lock_allocators+0x2fa/0x5c0 fs/ocfs2/suballoc.c:2789
 ocfs2_write_begin_nolock+0x2279/0x4340 fs/ocfs2/aops.c:1719
 ocfs2_dio_wr_get_block+0xb6f/0x1770 fs/ocfs2/aops.c:2214
 get_more_blocks fs/direct-io.c:648 [inline]
 do_direct_IO fs/direct-io.c:936 [inline]
 __blockdev_direct_IO+0x16ff/0x3490 fs/direct-io.c:1243
 ocfs2_direct_IO+0x25f/0x2d0 fs/ocfs2/aops.c:2441
 generic_file_direct_write+0x1db/0x3e0 mm/filemap.c:4176
 __generic_file_write_iter+0x11d/0x230 mm/filemap.c:4345
 ocfs2_file_write_iter+0x157a/0x1d10 fs/ocfs2/file.c:2469
 iter_file_splice_write+0x975/0x10e0 fs/splice.c:738
 do_splice_from fs/splice.c:938 [inline]
 direct_splice_actor+0x101/0x160 fs/splice.c:1161
 splice_direct_to_actor+0x5a8/0xcc0 fs/splice.c:1105
 do_splice_direct_actor fs/splice.c:1204 [inline]
 do_splice_direct+0x181/0x270 fs/splice.c:1230
 do_sendfile+0x4da/0x7e0 fs/read_write.c:1370
 __do_sys_sendfile64 fs/read_write.c:1431 [inline]
 __se_sys_sendfile64+0x13e/0x190 fs/read_write.c:1417
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f125df8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f125eda3038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f125e1b5fa0 RCX: 00007f125df8e929
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000008
RBP: 00007f125e010b39 R08: 0000000000000000 R09: 0000000000000000
R10: 000000080000000c R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f125e1b5fa0 R15: 00007fff162fbea8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ocfs2_reserve_suballoc_bits+0x3f67/0x46f0 fs/ocfs2/suballoc.c:820
Code: 24 98 00 00 00 80 e1 07 fe c1 38 c1 0f 8c a0 f0 ff ff 48 8b bc 24 98 00 00 00 e8 a4 15 79 fe e9 8e f0 ff ff e8 3a d6 11 fe 90 <0f> 0b 89 d1 80 e1 07 fe c1 38 c1 0f 8c d7 db ff ff 48 8b 7c 24 30
RSP: 0018:ffffc90002bbdca0 EFLAGS: 00010293
RAX: ffffffff83addc46 RBX: ffff888040d64fb8 RCX: ffff8880002cc900
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: ffffc90002bbe170 R08: ffffffff8f7c7677 R09: 1ffffffff1ef8ece
R10: dffffc0000000000 R11: fffffbfff1ef8ecf R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88804306ce00 R15: 00000000ffffffff
FS:  00007f125eda36c0(0000) GS:ffff88808d75f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f125ed80fb8 CR3: 00000000578b5000 CR4: 0000000000352ef0


Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=154c3734580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb89820a01e5d251
dashboard link: https://syzkaller.appspot.com/bug?extid=fd05de09d1267725aa95
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13d43734580000


