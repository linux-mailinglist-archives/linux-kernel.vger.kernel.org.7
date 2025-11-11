Return-Path: <linux-kernel+bounces-895700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22525C4EB28
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7201886DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB17534DCEC;
	Tue, 11 Nov 2025 15:03:31 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7093AA191
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873411; cv=none; b=by+fb7jfK8W+PzSqgYZQzEYfgcnII8uA3sRUOdi67cZirDDyxiRJcFSDvs7IkKXcrndNt30K2PHP/gRwcxmAqywuGkYlOmXlKP+3SdmCxqZR5MkX/HqJyNYna87rn7o2nx175iEQMc46kRxzJIb9j5jIaUbOjjaKtSwRQkn/g74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873411; c=relaxed/simple;
	bh=hUJRcIkcd8MJeRSicslyC17V8FIUbkHQankf4Vhpl5g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mTMVny0yfEBdsFJfZqCy8ByL6duHoYCohKCKwKuw+Io10uxBUNxURGU0pgUgfHVlHpCggh1waJ+zj2GaHjuSh8Tg1Wb6qC3tip3Lp1CJSVkg6j/4TBfeTRNe3Mhb9xP4CZn0jXZFVxWNeuiEDpefdDD5/d3MS5pyn/T5VkSj+4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-4337e3aca0cso31708125ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:03:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762873409; x=1763478209;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VWIKko+/f7wc1ywhv8E+Wq3D2G+PPdWhYhHhlr/Wf/0=;
        b=xRctxG6R1YJy7gNPQtRVbd+jcYwlZpJ+3OINu6BhFpI6waWFbGaj5W1PwuEzfZxgkN
         mOf6eJtgt8NOsdFqYLbPb1RAC4Ei6PNvEENspX6ctqpOjBqZDsYmcBbeI9k9NC+hAzsC
         Bf55ZyDOT/0lrY8YsQ6rh2y2kRpMEzgDBPdr1jAA/KjRZWBKxnvhAcRbYzPYclwZKgJF
         xYYHA+SrF0QO0JxqC6NM3J6GQspA4gSFP94exRIfPxgz9asmIH1+nkOVqQSVlybChvde
         taw1mohKHGavh/iUnjrkZj2HV49ytWzr8yxkufYJNz2/iw9kzm64Fxi3EGz9JF5wQEww
         3Bqw==
X-Forwarded-Encrypted: i=1; AJvYcCVu4Fc8EtoSvN/IcJk6nSFXDvg3MtBOyVZ/Tva+D+Xx41YiXhUR2aBrkc18Qd+t27PQ+uwr2Dn+x+xWMcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzJ2aak7/7Y70UWhhVS+KxMubQ1F9OV4HBnEkA7qwXdvVPqs6u
	1boxDkT/XEWulog18RDetpRX9ti7ROqBKIQ3ek5d2smGbRx7EIElItkDVGSFN1awibOKZXaJZEA
	EPr+3JRM1CIbkwURvh/c6DYXsnVTXo2Qrk4hg9xA07qcvCT9JQOyxEz8lJ98=
X-Google-Smtp-Source: AGHT+IENJ936kW7WzuEjQC+SSyFflsRYlWjNqxIz+22D2/kU0o9wO1DV5AoyZKptNtCYWA+ibYQGku8g4phivNClA661eTyDbu0q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:318b:b0:433:23f0:1ebf with SMTP id
 e9e14a558f8ab-43367dd8574mr190866465ab.9.1762873408970; Tue, 11 Nov 2025
 07:03:28 -0800 (PST)
Date: Tue, 11 Nov 2025 07:03:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69135040.a70a0220.22f260.013d.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in swap_cache_get_folio
From: syzbot <syzbot+d7bc9ec4a100437aa7a2@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, baohua@kernel.org, bhe@redhat.com, 
	chrisl@kernel.org, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, shikemeng@huaweicloud.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ab40c92c74c6 Add linux-next specific files for 20251110
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17f69a58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84a798f69f994783
dashboard link: https://syzkaller.appspot.com/bug?extid=d7bc9ec4a100437aa7a2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/34ed0f0c2fd0/disk-ab40c92c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a781fa106d0c/vmlinux-ab40c92c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/367c75242dc9/bzImage-ab40c92c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7bc9ec4a100437aa7a2@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: mm/swap.h:87 at __swap_offset_to_cluster mm/swap.h:87 [inline], CPU#0: swapoff/15184
WARNING: mm/swap.h:87 at __swap_entry_to_cluster mm/swap.h:93 [inline], CPU#0: swapoff/15184
WARNING: mm/swap.h:87 at swap_cache_get_folio+0x365/0x530 mm/swap_state.c:94, CPU#0: swapoff/15184
Modules linked in:
CPU: 0 UID: 0 PID: 15184 Comm: swapoff Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__swap_offset_to_cluster mm/swap.h:87 [inline]
RIP: 0010:__swap_entry_to_cluster mm/swap.h:93 [inline]
RIP: 0010:swap_cache_get_folio+0x365/0x530 mm/swap_state.c:94
Code: ff 31 ed e9 2a ff ff ff e8 a8 d5 a2 ff 90 0f 0b 90 e9 3d fd ff ff e8 9a d5 a2 ff 90 0f 0b 90 e9 44 fd ff ff e8 8c d5 a2 ff 90 <0f> 0b 90 e9 6b fd ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 3e
RSP: 0018:ffffc90003237a40 EFLAGS: 00010293
RAX: ffffffff821e8784 RBX: 00000000000001ff RCX: ffff88802e633d00
RDX: 0000000000000000 RSI: 0000000000007a12 RDI: 0003ffffffffffff
RBP: ffffffff99cad4e0 R08: 0000000000000000 R09: ffffffff82139c79
R10: dffffc0000000000 R11: fffff9400022a327 R12: ffff8880317bf000
R13: dffffc0000000000 R14: 0000000000007a12 R15: 0003ffffffffffff
FS:  00007f3bed90fc80(0000) GS:ffff888125a83000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005640123d7005 CR3: 0000000034d9a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 unuse_pte_range mm/swapfile.c:2282 [inline]
 unuse_pmd_range mm/swapfile.c:2332 [inline]
 unuse_pud_range mm/swapfile.c:2352 [inline]
 unuse_p4d_range mm/swapfile.c:2372 [inline]
 unuse_vma mm/swapfile.c:2393 [inline]
 unuse_mm mm/swapfile.c:2411 [inline]
 try_to_unuse+0xd6f/0x2ce0 mm/swapfile.c:2488
 __do_sys_swapoff mm/swapfile.c:2884 [inline]
 __se_sys_swapoff+0x431/0xa10 mm/swapfile.c:2824
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3bedad6ed7
Code: 00 66 90 48 83 fe 01 48 8b 15 1d 1f 0d 00 19 c0 83 e0 f0 83 c0 26 64 89 02 b8 ff ff ff ff c3 0f 1f 40 00 b8 a8 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f1 1e 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd9a359118 EFLAGS: 00000246 ORIG_RAX: 00000000000000a8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3bedad6ed7
RDX: 0000564029c35a70 RSI: 00007f3bedc5c4e8 RDI: 0000564029c35a20
RBP: 0000564029c35a20 R08: 0000000000000100 R09: 00007f3bedba9ac0
R10: 0000000000000004 R11: 0000000000000246 R12: 00007ffd9a359338
R13: 0000564029c352a0 R14: 00007f3bedcb9000 R15: 00005640123d8d98
 </TASK>


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

