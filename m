Return-Path: <linux-kernel+bounces-835184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E50ABA6750
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FFA93B9B83
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96F926B2DA;
	Sun, 28 Sep 2025 03:56:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93CC26B0AE
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 03:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759031765; cv=none; b=JP9f5fSi3U7rMyt4DAHTCrIVtpm+wQ7GUwmm15V3VgeDGIxNzLuqOFjZzR3PbalcJHM8xNYPaTlB21obRYvMXFIkXrqiGIALeYmI5bzVLcBx3gsew6xOO2CzYFgDpbXcwp8d56xDWA0YQvPPYzXtOLCDwdUpX6DelXYIB2g/BQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759031765; c=relaxed/simple;
	bh=Lyn1PYhF709Is175jdL4uoFCuKHx8j08ZrVEBSDtrhE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XFbfpie8QZkxPgI06zFyFVSzY9532u8CNo7sVB1KuRYQsqXJ89UhSZyoEo9/XIkiedTXvQzcJyZ6M4dM0lU3W/SzHBXoATzYlrmc0zcmHP20WQzE/NlCquu5nSbx7tu5a2LPgEmqD2YvjA5KktxA0bca8hgoFq0v4gNp332wFkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42721b7023eso24407135ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 20:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759031763; x=1759636563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iz8AeoC8YQYHjlu89FqvEbgPQzVAr0ZU/+j3i45nWSE=;
        b=H0APv7KaDrIMixYZhIZql755JjhiArcCeUP5Af7hCjimxKSGR+UYiwwX9UkxKc2mRh
         UVb29qrtOHh9gU1SHcZmonPWhzzYSE8Pk6gmrJ4YNKP9d8mI2nVRG4zFuc9uHJf7Bo21
         vKec2NWeT92I6CJtbFZ6CdbzJLdhPMZtvBnsAWqJek73rIn9Xhr9RS7192yzX19Tipi1
         KnXrkq0CYd9pdXbhGKj6eO0uWT5C22tI1wqJXcsgZ+2IbstKWSdMvdm7xuPNkTlhfjaj
         iSlUs8/4d8ozYiJT1ItMsHyFbyLRF+GjUHjX8lRNcva+jXybiXCeX3WbEMmNukdXW2PL
         V7RQ==
X-Gm-Message-State: AOJu0Ywq7f/EHd1ZbQCR770A5iC16YPePWqx6mZu2kpnF1tyFNsfq3Uc
	9ijRDy6iPYLcZDOHo6Vukqw6tWorV8xcPoywTkkfKDN6oPffX3c04BiGx+zCLUu3P19nvK18pS5
	R3ewL493Q/4hnaLMyKSxddkiWvd80cRocMpL45pPPOq4iYnN9x1ytQJrvShg=
X-Google-Smtp-Source: AGHT+IHSLrrF4+OJODbxFNKWBy7NiiFLNJgZsCSxZawu5VNZfvpmv4rMuaQZ4yhJuAWLidCBG/Qn44ITXVIL+CIYvARxRUt2CEJO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b22:b0:425:7974:fe32 with SMTP id
 e9e14a558f8ab-425956541ddmr184491575ab.23.1759031762941; Sat, 27 Sep 2025
 20:56:02 -0700 (PDT)
Date: Sat, 27 Sep 2025 20:56:02 -0700
In-Reply-To: <87ms6f2r7w.fsf@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d8b1d2.050a0220.25d7ab.0468.GAE@google.com>
Subject: Re: [syzbot] [fs?] UBSAN: shift-out-of-bounds in minix_statfs
From: syzbot <syzbot+5ad0824204c7bf9b67f2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xandfury@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: shift-out-of-bounds in minix_statfs

loop0: detected capacity change from 0 to 64
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/minix/inode.c:399:57
shift exponent 768 is too large for 64-bit type 'unsigned long'
CPU: 1 UID: 0 PID: 6533 Comm: syz.0.16 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
 minix_statfs+0x31c/0x340 fs/minix/inode.c:399
 statfs_by_dentry fs/statfs.c:66 [inline]
 vfs_statfs+0x144/0x2d0 fs/statfs.c:90
 ovl_check_namelen fs/overlayfs/super.c:387 [inline]
 ovl_get_upper fs/overlayfs/super.c:505 [inline]
 ovl_fill_super+0x767/0x35b0 fs/overlayfs/super.c:1392
 vfs_get_super fs/super.c:1325 [inline]
 get_tree_nodev+0xb8/0x150 fs/super.c:1344
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f895c78d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f895b9fe038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f895c9a5fa0 RCX: 00007f895c78d169
RDX: 0000400000000000 RSI: 0000400000000080 RDI: 0000000000000000
RBP: 00007f895c80e2a0 R08: 00004000000002c0 R09: 0000000000000000
R10: 0000000000010000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f895c9a5fa0 R15: 00007ffffbd08258
 </TASK>
---[ end trace ]---


Tested on:

commit:         51a24b7d Merge tag 'trace-tools-v6.17-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=112e72e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5376b4bed9a84961
dashboard link: https://syzkaller.appspot.com/bug?extid=5ad0824204c7bf9b67f2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

