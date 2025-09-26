Return-Path: <linux-kernel+bounces-834059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E91BA3B52
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73503ADB8B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ADF2900A8;
	Fri, 26 Sep 2025 12:54:04 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8654248F48
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891243; cv=none; b=KoRme2lEMa+gVdLatAi4wRw+ag2PBG7zq5z/DBYFAXh1ESIFQDw+NvwxxX0vxbiNhUnI3EHR9TI/bIVGcF1QIFfLVCGTaYEXw50ePX7eScFWDmQs99kSaVN96O1Dj2cU2akjtkvjsodpxzZFagZnouth51iYyPViBBdI2DH51wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891243; c=relaxed/simple;
	bh=M8bxK0iXb2FRLKuLBsDiNvlwCoNKiuW5WSKZFjwMKEI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WyhPRTN79l17xzjP9tGATapbX3r7YjWg8RQyRFTgIjlrV+fW1+OaCUiP3tHDxJ/bCyChThiQT/va5oLNL/E8IXwRjCbW1+S4T4wsNYPONdk3Jm80YUMjs9yksnegGe33jrNpd4WIzqi5oSyhrWFf6QZvnTK4kO6QfbDDn4IyMcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-4248b59ea91so50411245ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 05:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758891241; x=1759496041;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gm+LwPqy3DYhZr5PODr6bTfwgQx+iWFWRByOeWwAtYE=;
        b=QhZGlNbesz5x6BCI43Qv2DCPxK+bNvIfx6hVq5kpBPRzQqY+KDD9TGcSnnJGlXL8Vb
         ZIi5wO9Jra82ngX0lcic9JvSK3qW307BdzdLCQXdz+3n8ZJ3URmo08qkCqqkYkxuoWXL
         PH1uv/spKAQdnKdhKITBV8y2hP57V9/XcDiedPBXc60VBk3XWEBVmPKqketL9t4gDt3r
         P+cY3NR4Zmato+CglqrJZoRQPdfNbPy2WL4pWGvepDMypUUO3IxlaMbsz8IWENRkz9EU
         kRSr5F2OBGiOe+IoF090X8Eh0dGm4xjQ7CVRDEOFgTWgXZGqhsoF55lB2Xg/CqNNg/eR
         136Q==
X-Gm-Message-State: AOJu0YxQD7t1pwwXr0J39B8YhLPNuSSdhN0gJNVdXMDfKUuUEAEd1qel
	/GvPn436AWerUP9pTZguC7u5D51AVG0h9NlEFoGiq3OL9Rt2Zj2sOcfkN0BR0Yl0OnO4jFp6fnL
	TWeBFJqCkG0KwqoRNmX9x2VnGRoBizIxwv5yObT3J9NEEaO+j+yrRJmDmqZWE/g==
X-Google-Smtp-Source: AGHT+IE8oNWbIAUpCAos5g1UoqJOK3ltnpE/tzQbLZM3MuHvsdIymbq4QL/f4RrXqHfo1KCC4BRHaCE8BeyhneufDbvMTxYCwWUp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26d:0:b0:425:b6a6:77cf with SMTP id
 e9e14a558f8ab-425b6a679d4mr39801765ab.26.1758891240799; Fri, 26 Sep 2025
 05:54:00 -0700 (PDT)
Date: Fri, 26 Sep 2025 05:54:00 -0700
In-Reply-To: <68d46aed.050a0220.57ae1.0002.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d68ce8.a00a0220.102ee.0002.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [exfat?] general protection fault in exfat_utf16_to_nls
From: syzbot <syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [exfat?] general protection fault in exfat_utf16_to_n=
ls
Author: ekffu200098@gmail.com

#syz test

On Thu, Sep 25, 2025 at 7:04=E2=80=AFAM syzbot
<syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    b5a4da2c459f Add linux-next specific files for 20250924
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15ffad3458000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfc64d939cce41=
d2
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3e9cb93e3c5f90d=
28e19
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b797=
6-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1704cf12580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15c8d4e258000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/127c931e6696/dis=
k-b5a4da2c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/cf4957abd39e/vmlinu=
x-b5a4da2c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/860d3ac61bac/b=
zImage-b5a4da2c.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/9006b1673f=
9f/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=3D=
11c8d4e2580000)
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com
>
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc0000000002: 0000 [#1] SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> CPU: 1 UID: 0 PID: 5979 Comm: syz-executor Not tainted syzkaller #0 PREEM=
PT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/18/2025
> RIP: 0010:exfat_convert_ucs2_to_char fs/exfat/nls.c:441 [inline]
> RIP: 0010:__exfat_utf16_to_nls fs/exfat/nls.c:554 [inline]
> RIP: 0010:exfat_utf16_to_nls+0x21c/0x840 fs/exfat/nls.c:638
> Code: 2e 29 ff 66 41 83 fc 7f 77 14 e8 7f 2a 29 ff e9 b6 00 00 00 e8 75 2=
a 29 ff e9 a9 00 00 00 48 8b 4c 24 40 48 89 c8 48 c1 e8 03 <42> 80 3c 38 00=
 74 0f 48 8b 7c 24 40 e8 d3 6b 8e ff 48 8b 4c 24 40
> RSP: 0018:ffffc90003fef760 EFLAGS: 00010202
> RAX: 0000000000000002 RBX: 0000000000000004 RCX: 0000000000000010
> RDX: ffff88802f18bc80 RSI: 00000000000000e1 RDI: 0000000000000080
> RBP: ffffc90003fef850 R08: 0000000000000005 R09: 0000000000000000
> R10: ffffc90003fef7e0 R11: fffff520007fdefc R12: 00000000000000e1
> R13: ffffc90003fefa48 R14: 0000000000000000 R15: dffffc0000000000
> FS:  000055557b9c2500(0000) GS:ffff888125b03000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055557b9e5608 CR3: 00000000734c8000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  exfat_readdir fs/exfat/dir.c:143 [inline]
>  exfat_iterate+0x19a7/0x2050 fs/exfat/dir.c:243
>  wrap_directory_iterator+0x96/0xe0 fs/readdir.c:65
>  iterate_dir+0x399/0x570 fs/readdir.c:108
>  __do_sys_getdents64 fs/readdir.c:410 [inline]
>  __se_sys_getdents64+0xe4/0x260 fs/readdir.c:396
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2c837c1833
> Code: c1 66 0f 1f 44 00 00 48 83 c4 08 48 89 ef 5b 5d e9 32 3d f8 ff 66 9=
0 b8 ff ff ff 7f 48 39 c2 48 0f 47 d0 b8 d9 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 05 c3 0f 1f 40 00 48 c7 c2 a8 ff ff ff f7 d8
> RSP: 002b:00007ffc8cf73ff8 EFLAGS: 00000293 ORIG_RAX: 00000000000000d9
> RAX: ffffffffffffffda RBX: 000055557b9dd600 RCX: 00007f2c837c1833
> RDX: 0000000000008000 RSI: 000055557b9dd600 RDI: 0000000000000005
> RBP: 000055557b9dd5d4 R08: 0000000000028a41 R09: 0000000000000000
> R10: 00007f2c839b7cc0 R11: 0000000000000293 R12: ffffffffffffffa8
> R13: 0000000000000010 R14: 000055557b9dd5d0 R15: 00007ffc8cf762b0
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:exfat_convert_ucs2_to_char fs/exfat/nls.c:441 [inline]
> RIP: 0010:__exfat_utf16_to_nls fs/exfat/nls.c:554 [inline]
> RIP: 0010:exfat_utf16_to_nls+0x21c/0x840 fs/exfat/nls.c:638
> Code: 2e 29 ff 66 41 83 fc 7f 77 14 e8 7f 2a 29 ff e9 b6 00 00 00 e8 75 2=
a 29 ff e9 a9 00 00 00 48 8b 4c 24 40 48 89 c8 48 c1 e8 03 <42> 80 3c 38 00=
 74 0f 48 8b 7c 24 40 e8 d3 6b 8e ff 48 8b 4c 24 40
> RSP: 0018:ffffc90003fef760 EFLAGS: 00010202
> RAX: 0000000000000002 RBX: 0000000000000004 RCX: 0000000000000010
> RDX: ffff88802f18bc80 RSI: 00000000000000e1 RDI: 0000000000000080
> RBP: ffffc90003fef850 R08: 0000000000000005 R09: 0000000000000000
> R10: ffffc90003fef7e0 R11: fffff520007fdefc R12: 00000000000000e1
> R13: ffffc90003fefa48 R14: 0000000000000000 R15: dffffc0000000000
> FS:  000055557b9c2500(0000) GS:ffff888125a03000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c000692800 CR3: 00000000734c8000 CR4: 00000000003526f0
> ----------------
> Code disassembly (best guess):
>    0:   2e 29 ff                cs sub %edi,%edi
>    3:   66 41 83 fc 7f          cmp    $0x7f,%r12w
>    8:   77 14                   ja     0x1e
>    a:   e8 7f 2a 29 ff          call   0xff292a8e
>    f:   e9 b6 00 00 00          jmp    0xca
>   14:   e8 75 2a 29 ff          call   0xff292a8e
>   19:   e9 a9 00 00 00          jmp    0xc7
>   1e:   48 8b 4c 24 40          mov    0x40(%rsp),%rcx
>   23:   48 89 c8                mov    %rcx,%rax
>   26:   48 c1 e8 03             shr    $0x3,%rax
> * 2a:   42 80 3c 38 00          cmpb   $0x0,(%rax,%r15,1) <-- trapping in=
struction
>   2f:   74 0f                   je     0x40
>   31:   48 8b 7c 24 40          mov    0x40(%rsp),%rdi
>   36:   e8 d3 6b 8e ff          call   0xff8e6c0e
>   3b:   48 8b 4c 24 40          mov    0x40(%rsp),%rcx
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller=
-bugs/68d46aed.050a0220.57ae1.0002.GAE%40google.com.

