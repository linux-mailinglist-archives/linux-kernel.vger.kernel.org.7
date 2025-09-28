Return-Path: <linux-kernel+bounces-835115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B7EBA6508
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 02:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338DB3B73D9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 00:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EC43C465;
	Sun, 28 Sep 2025 00:12:00 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F8A139D
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 00:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759018320; cv=none; b=sA685nT+gNsbER+M+2rT6Ad+bJtz7GjlpwkyZAeN2saCLGMcLImbAYhPaZWQs9fkIjiM9hVYC4IhdeXBUO1/8UVu8bgVLWUjdFJsOBBQgNIu9yTNMGLmTR3tw0SBjvYELbK83+tZpl6iE44BiaysvCOi08mDehBiCs7uLI8uoXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759018320; c=relaxed/simple;
	bh=AGFpgq2U4rLhZl8J3XW2R7dqc8dGNbXmLSi6/EfpDp0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CtOran26sa0MglzAIDI/3qujb/HRsPKymxQf3NfQDTG9xtwKtphflINYGsOfmMJLvSmZwTUOSnQaShuuVGtO0HfAFL9oa0A2AEstSVYtQgc6x9nQYpJF8904SjnaRQ5H9YjZh/1V9V94nTdeVRDOkNsFahKrd1fYG2WCloH0TgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-4284df6ceaaso43843185ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 17:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759018318; x=1759623118;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWyoECItMY5m9nYB5mJR3opCUyyShfz7IgD2mdm/xdQ=;
        b=lFzm4u3M0mlIm6O1lEX0eL8Cfr778//ZfwsjKVm7gasKfwfcHXsoFeadsHaKp+Qges
         KRp8pkHRGx2hPXuqqKkQ870b0qjsjO/bPRf40QJ4L2nHQMhOByYN4oW0M7z2Y3Jn3chI
         PwR/4k5mbJq8hMSj8xLVfMFb60+U/27JoAXCC1i1GeKhc1v4u+Ymn1JHSraEtFNqUr9o
         fHt2i1g7/8cK78EYBBjbUjrgewG9BM7CywKz/0kt5dKIUdvmEHzEc+dfKlnq0OkGF+S6
         1HjMasMHZypcZn+R++qmh7YfHmrxLYafc4Z3dS2u9NnJWPFZ5xQ4lbESn8JAfl2j8WvJ
         AEyg==
X-Gm-Message-State: AOJu0Yw51VtTQnK3VlXOwiAW22cVEXAAABmTskxiD6tNSs+7gL7xJML3
	9pOYIUX9mfQsOu/Xel/e4woBeLxUR8oW3YUS5f35NlB1ri6WwZkrZtBQU7fyjbzLhBHbRiHAFwu
	z/2tMFeeYpiEwDhNPg4zBfOkDTwW/qIMfMTPYW//mXAGnHYIebIEVPyZBF8QktA==
X-Google-Smtp-Source: AGHT+IEfSvVWa5PD4946Q4ZluzvS3F6afj09ujMqqU0cxv0ktLfWwpoByDT8633IZc2K0JW9fdPskYQ8qERjjp8Sb5Pgw9SAymTh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e6:b0:427:c8d1:bea5 with SMTP id
 e9e14a558f8ab-427c8e105eemr84498235ab.21.1759018317790; Sat, 27 Sep 2025
 17:11:57 -0700 (PDT)
Date: Sat, 27 Sep 2025 17:11:57 -0700
In-Reply-To: <66fd2663.050a0220.f28ec.0510.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d87d4d.a00a0220.102ee.0020.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in __btree_node_pinned
From: syzbot <syzbot+9f41e4b255897d99d4e9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in __btree_nod=
e_pinned
Author: xandfury@gmail.com

syzbot <syzbot+9f41e4b255897d99d4e9@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    ad46e8f95e93 Merge tag =E2=80=99pm-6.12-rc1-2=E2=80=99 of=
 git://git.kernel..
> git tree:       upstream
> console output: <https://syzkaller.appspot.com/x/log.txt?x=3D13b3d5079800=
00>
> kernel config:  <https://syzkaller.appspot.com/x/.config?x=3D62086b2fd100=
a029>
> dashboard link: <https://syzkaller.appspot.com/bug?extid=3D9f41e4b255897d=
99d4e9>
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      <https://syzkaller.appspot.com/x/repro.syz?x=3D11b69e8058=
0000>
> C reproducer:   <https://syzkaller.appspot.com/x/repro.c?x=3D1567c6a99800=
00>
>
> Downloadable assets:
> disk image (non-bootable): <https://storage.googleapis.com/syzbot-assets/=
7feb34a89c2a/non_bootable_disk-ad46e8f9.raw.xz>
> vmlinux: <https://storage.googleapis.com/syzbot-assets/72b7539cbeb1/vmlin=
ux-ad46e8f9.xz>
> kernel image: <https://storage.googleapis.com/syzbot-assets/73c9b9cebaf4/=
bzImage-ad46e8f9.xz>
> mounted in repro: <https://storage.googleapis.com/syzbot-assets/54e2032c8=
f9d/mount_0.gz>
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+9f41e4b255897d99d4e9@syzkaller.appspotmail.com
>
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94[ cut here ]=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94
> UBSAN: shift-out-of-bounds in fs/bcachefs/btree_cache.c:198:18
> shift exponent 227 is too large for 64-bit type =E2=80=99unsigned long lo=
ng=E2=80=99
> CPU: 0 UID: 0 PID: 5109 Comm: read_btree_node Not tainted 6.11.0-syzkalle=
r-11728-gad46e8f95e93 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  ubsan_epilogue lib/ubsan.c:231 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
>  __btree_node_pinned+0x80b/0x850 fs/bcachefs/btree_cache.c:198
>  __bch2_btree_node_hash_insert+0xcfd/0x13e0 fs/bcachefs/btree_cache.c:270
>  bch2_btree_node_hash_insert fs/bcachefs/btree_cache.c:287 [inline]
>  bch2_btree_node_fill+0x94e/0x1200 fs/bcachefs/btree_cache.c:932
>  bch2_btree_node_get_noiter+0x9d5/0xf70 fs/bcachefs/btree_cache.c:1238
>  found_btree_node_is_readable fs/bcachefs/btree_node_scan.c:85 [inline]
>  try_read_btree_node fs/bcachefs/btree_node_scan.c:190 [inline]
>  read_btree_nodes_worker+0x122c/0x20b0 fs/bcachefs/btree_node_scan.c:239
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> =E2=80=94[ end trace ]=E2=80=94
> Kernel panic - not syncing: UBSAN: panic_on_warn set =E2=80=A6
> CPU: 0 UID: 0 PID: 5109 Comm: read_btree_node Not tainted 6.11.0-syzkalle=
r-11728-gad46e8f95e93 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  panic+0x349/0x880 kernel/panic.c:354
>  check_panic_on_warn+0x86/0xb0 kernel/panic.c:243
>  ubsan_epilogue lib/ubsan.c:236 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x3e7/0x420 lib/ubsan.c:468
>  __btree_node_pinned+0x80b/0x850 fs/bcachefs/btree_cache.c:198
>  __bch2_btree_node_hash_insert+0xcfd/0x13e0 fs/bcachefs/btree_cache.c:270
>  bch2_btree_node_hash_insert fs/bcachefs/btree_cache.c:287 [inline]
>  bch2_btree_node_fill+0x94e/0x1200 fs/bcachefs/btree_cache.c:932
>  bch2_btree_node_get_noiter+0x9d5/0xf70 fs/bcachefs/btree_cache.c:1238
>  found_btree_node_is_readable fs/bcachefs/btree_node_scan.c:85 [inline]
>  try_read_btree_node fs/bcachefs/btree_node_scan.c:190 [inline]
>  read_btree_nodes_worker+0x122c/0x20b0 fs/bcachefs/btree_node_scan.c:239
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> =E2=80=94
> This report is generated by a bot. It may contain errors.
> See <https://goo.gl/tpsmEJ> for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> <https://goo.gl/tpsmEJ#status> for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report=E2=80=99s subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master

