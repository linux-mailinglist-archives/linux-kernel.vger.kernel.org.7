Return-Path: <linux-kernel+bounces-778817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1191B2EB89
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B7144E3955
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A112D3EEB;
	Thu, 21 Aug 2025 02:58:34 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777441C4A10
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755745114; cv=none; b=bq85eY6cvmW+lFkt8UpINRRcHH3bM4XeKSvGtnoB0OVrSf1DzfCvV2m1iNDese/9oQs1DqBXDHfAxJ1rQA/XnGdZ2nE7BcuvID8JwaDCFplb3NQPBt8VZvlK43Il9bC1VuQLdA4j15a08j9Y70hzAp8h8mJBeNgDj37loGp18TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755745114; c=relaxed/simple;
	bh=Ckzyyo8fMNJ1pKXd2LuWDzsluunYZETjwc3xFjhjF8E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e/Kta7RhiQN3X4+tQBPZWH8tLIt+MD01fkCegSiWBW4VHjOk3ZTrS+/DxQHQq75Z2tju967o/F9DRf/gpmt95ExPnbB0nAjZigLTGANgn9OXPyiBCOV25cL1IUxGRGwNZNxX+8yOXn5G8IqdT8DYkvFajHGdazrteOogfgQRREc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3e7172dea48so6053185ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 19:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755745111; x=1756349911;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HahCLua8zUrTqOzXr4U9vE+qOFX9I1AwrpiJRZveyPs=;
        b=YeOsm6tlG47Qm1cuGQwldTKT62e4J5eEEevB16LhIGpchzdjdD3yI0G2WUWX+PmxHR
         KzZebxTg9U7CMZZ9Zy8OgxRA+HomGkIzhjGbCsKlKA/Yp3mpa+cDQqf2INVVwVEsO6AI
         q4jR8EPIqtDPuvE21rnaeGoKvMQW6DEznwydn74zyUNGEYccLn59OrWjsVlDbWvCiNC7
         ShNwg4lzSdol3rKphjL09/p7PCyCvL+mbrNcMNIIGDG54nujEmOq+3dZeljalxKzDBlb
         tU82A9yz8csKGaqDIqHs7JE5Z5XMm8giCvNF54EbOtAXm2fP58CgPRQzyOWbMq8UtBBB
         O5UA==
X-Forwarded-Encrypted: i=1; AJvYcCUloG/qrzAZzHizRqr4ra2bUYcHKF18rw8iec+jcivXYUCsUk09/i+oI2odgRyxQxAlb/MTlJaMBrntl2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9woaZCozKOesn87MhT8RZUw9jrXmnXwm9vM5j1HDAzanNmuRv
	FxUaMid4vBT1NPWKWWQXW5mw0qf5CP62ky9j0TVzCSBcpyVc7IizwBe5GKPEv34keiBe/4H4gFr
	2/XHYnbrhEEgqllUIZ5Um2qk0kMr3O7XoO3R4o6dzcw9KtwmRbZefNtizTMk=
X-Google-Smtp-Source: AGHT+IHslzf/hk+X+HthHyVz9yOLGrLH/CQVRtSQ53f0E0gtvbiEL1S8Fb7DRaqQ5HM3GthZ4IEjMx0f1lrJamHWW/gdSlWybJ+o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c248:0:b0:3e5:5937:e555 with SMTP id
 e9e14a558f8ab-3e6d4060f71mr17648015ab.6.1755745111642; Wed, 20 Aug 2025
 19:58:31 -0700 (PDT)
Date: Wed, 20 Aug 2025 19:58:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a68b57.050a0220.3d78fd.0012.GAE@google.com>
Subject: [syzbot] [v9fs?] UBSAN: shift-out-of-bounds in v9fs_get_tree
From: syzbot <syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3ac864c2d9bb Add linux-next specific files for 20250818
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13706442580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d1acc6b9e1fca1b
dashboard link: https://syzkaller.appspot.com/bug?extid=30c83da54e948f6e9436
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141586f0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124c9ba2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/37dbe82593f0/disk-3ac864c2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d2fea0824445/vmlinux-3ac864c2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f2a83735a01/bzImage-3ac864c2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/9p/vfs_super.c:57:22
shift exponent 32 is too large for 32-bit type 'int'
CPU: 0 UID: 0 PID: 5861 Comm: syz-executor379 Not tainted 6.17.0-rc2-next-20250818-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
 v9fs_fill_super fs/9p/vfs_super.c:57 [inline]
 v9fs_get_tree+0x957/0xa90 fs/9p/vfs_super.c:125
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1752
 do_new_mount+0x2a2/0xa30 fs/namespace.c:3810
 do_mount fs/namespace.c:4138 [inline]
 __do_sys_mount fs/namespace.c:4349 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4326
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff35edd46a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeee8a4078 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00002000000025c0 RCX: 00007ff35edd46a9
RDX: 00002000000000c0 RSI: 00002000000025c0 RDI: 0000000000000000
RBP: 0000200000000280 R08: 0000200000000280 R09: 00007ffeee8a4258
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff35ee1d017
R13: 00007ffeee8a4248 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
---[ end trace ]---


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

