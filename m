Return-Path: <linux-kernel+bounces-835168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C3EBA66DB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CFFE17E4F6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE851AC88A;
	Sun, 28 Sep 2025 03:16:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C534C8FE
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 03:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759029364; cv=none; b=i7eWMoVkEYm86POIrFANHUaWBIeyntgdyTR/1Pa78pP2wup84dullhPN3VdjN0O4n7jPzcwSYJ3T6erYUw5terN8SX0HkJR743jzdqe8wXDuIH097LY+Q24VpM4UGtPTXOAh6sTPS6RL/4ySOfVFQga/LoFlBB+FifPgLYZPDJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759029364; c=relaxed/simple;
	bh=gVCMLMcyaRQYqH4z8mFh4cDCq/QO4B43DQapNofwB6I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pb41/mnxqELUYB0dNT4LyU98nw3p3F8rhTaejvB9p36W7t1DviMc0G3rtz4XvF8ELUkenmzEPh8vyd5IO+NIL3ZgCEJToP0LwIrDResLP7Nw4XdQL6m4r5BrNdXD4YXmAWFCuFaA66i1xKD2AHDz4mS336bGux/ZO/PQqwxpPFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-911c5f72370so225918439f.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 20:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759029361; x=1759634161;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xn0MSC/QvByKn+Kpg7Cakx4+vVGbIKO+vsOAI4JB5AM=;
        b=iFRGxlTB/JtTGHGYs97i31IuzLYFwlvC+9g2cneq+VbMuM/eRQQ6r0L9rNZixnqBw3
         u3yDFOZlftoEtVzHyiKDj4hEDtRh5Zxi4RrUbOESr/jfqKFPeC3evSMOMuS3QfW6zlTa
         y2i3Y5SSOaytPlWrDNAWnA3/Fpu14Yrfab7Ezz11QFRy8mGREje6TfIvhpyvxxlDlycS
         wSWOvxb7Wp0PXlOczZoyLTygrCmrPr5xG8gfz81AgKaOEKozBJHZYZr3yBGLVic+cVt+
         5sohh+2EKvJmPh2l/0C80tCjqya5/VrqKnkSynOZqJi21wsk3VJuLFv289+bbeCXaf/s
         eOKw==
X-Gm-Message-State: AOJu0Yw5eMxrVwTPiUMsQDoykeUCyRxYOdwD1D1KoKSyxakanS1alM8v
	p3bfj+JXnFwuEa0IPfa37XyE784DZSq7nrWNOK0jRkZwDoGuqeM12iu7BIiq6sTIn+xgkabXOdE
	3sH/8/kMwuzmfH7NyUlQklYFeb5/lTgHSW+r0MgX0Wk0HLle7aeQApllvTeA=
X-Google-Smtp-Source: AGHT+IFiXNZhfBjyeDsDCbtIPT5TjmQ0fSXyA2UGnYJNXFZVvaogCuG9caYzNFNwvlQ2Q8BopQKGqq8pBgMxvNOXkOHTDgv2v2yH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1807:b0:425:6e9c:9443 with SMTP id
 e9e14a558f8ab-425955084b3mr182059685ab.0.1759029361715; Sat, 27 Sep 2025
 20:16:01 -0700 (PDT)
Date: Sat, 27 Sep 2025 20:16:01 -0700
In-Reply-To: <87zfafi8w9.fsf@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d8a871.a00a0220.102ee.0024.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in extAlloc (2)
From: syzbot <syzbot+13e8cd4926977f8337b6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xandfury@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: shift-out-of-bounds in extAlloc

loop0: detected capacity change from 0 to 32768
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/jfs/jfs_extent.c:329:16
shift exponent 64 is too large for 64-bit type 's64' (aka 'long long')
CPU: 0 UID: 0 PID: 6607 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
 extBalloc fs/jfs/jfs_extent.c:329 [inline]
 extAlloc+0xd52/0xfb0 fs/jfs/jfs_extent.c:127
 jfs_get_block+0x346/0xab0 fs/jfs/inode.c:248
 __block_write_begin_int+0x6b2/0x1900 fs/buffer.c:2145
 block_write_begin+0x8a/0x120 fs/buffer.c:2256
 jfs_write_begin+0x35/0x80 fs/jfs/inode.c:300
 generic_perform_write+0x29a/0x8c0 mm/filemap.c:4175
 generic_file_write_iter+0x118/0x550 mm/filemap.c:4318
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5d2/0xb40 fs/read_write.c:686
 ksys_write+0x14b/0x260 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fddbbcbebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fddbb32e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fddbbee5fa0 RCX: 00007fddbbcbebe9
RDX: 00000000fffffdef RSI: 00002000000000c0 RDI: 0000000000000005
RBP: 00007fddbbd41e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fddbbee6038 R14: 00007fddbbee5fa0 R15: 00007ffefffbcc18
 </TASK>
---[ end trace ]---


Tested on:

commit:         51a24b7d Merge tag 'trace-tools-v6.17-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f67142580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=13e8cd4926977f8337b6
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

