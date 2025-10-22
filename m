Return-Path: <linux-kernel+bounces-865811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B98BFE188
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 21:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC3564F4D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0A92F619C;
	Wed, 22 Oct 2025 19:51:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412E820ADD6
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761162666; cv=none; b=pbRhFFo7DoIvZEU0YWI11mT9SvBzs2xaIHFfanz0ehhDaBAdwDBI1U2JgxVLQNo97NTjYftl2t8o4MrI9mXNgP8ik6gMzs1BGeXkGHgNM/ZnrD+AokT657DEKJInyzi0FSkb2SrTpqog7N0r+hPDONmFsGfYSnJnMdf4h53L9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761162666; c=relaxed/simple;
	bh=zCVOLAKCg9pnZDUjCK7muAd5bMVQoWVGQPKoyWNFKXQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QpaXGE0BoDNiWdsDyfUSd4ocyXlS9BamrDdIj+fmWzZ+6MjRIYhXrUwVniN17gbOAEUP54QAEUjOFECV24ThLVlTCznESVPxDdAbKurVC6oqfu01HyW4GFRELBIYdR8r4DwoPPzcBdVU2vhYL2o7AOglqGTEZhEoehE+hX6lQM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430c8321bc1so1144305ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761162664; x=1761767464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PVwDEys9AQr02E5jbaiRd6B6Vn16tiIjO85cBQkdA70=;
        b=Tls7Trt8L+86N3fMVq8smHpS413gcOjKJvjZ3GFbHB4dXlOZwV5I8nVv4butsK6VdR
         1HcK1JypxwQyOYwtSzy5uKnbEEnyEoUv67TqrsQ7iGZaXGVrxjJ+Z85wG42nVLxexJGX
         60N+ZlOlEJpzxbzK9TBsA7A3TvIf7n6akD1zPE9YcWTpCoYLLTZ9HDzc+CEBWliagY3t
         I5iAGrU3AQUC8EtNOIhNhD+OTBVnDIwfOawpVHzN6rQMZkUwXBkEx0sioaMbXZCw7f6y
         AkRwYd+46TUYZ6agr4b4nziCmsBW+wVtVUZD5ZVcUDCA+4kNEHTvK5nyjoahjjMkrr7Z
         Xkcg==
X-Forwarded-Encrypted: i=1; AJvYcCXdL3UkW5h87OH9HBc6FwNW5qplCL60IBDcX7I4TDGIHNmt5F48H24n0kelk8aE8w7djxG8dfFIiiFAlIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/qHpDbqSU+QDmI2K7GPCCxEVWzVbWSPL/tRRxiNaMfVH0ySsB
	OxgDQFRzWWaWh9aOBrQVEbMvG3gXuhLOgl0MUpZt/Vb6HC3ZFRw/P8AtDAD4+8GtforgllFcZ6b
	fm+Hxtfxd8GNw3ENNnfearaftlP0hzuUikZ/Q2G0DoCgAs9vxrlrMypzy4ko=
X-Google-Smtp-Source: AGHT+IGbMLZUuiwUrKyXcUuW4zycngLdRguWQ8WhQV51YLmHmn/6dQc0AuBo8bBtQJMRpARGs5Y1uNF+HByUO5hrfe6R0b8E4nql
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2197:b0:430:ae26:7c37 with SMTP id
 e9e14a558f8ab-430c524ceb5mr313357225ab.3.1761162664436; Wed, 22 Oct 2025
 12:51:04 -0700 (PDT)
Date: Wed, 22 Oct 2025 12:51:04 -0700
In-Reply-To: <20251022150507.AgqUs%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f935a8.a70a0220.3bf6c6.0025.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_commit_truncate
From: syzbot <syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in ocfs2_commit_truncate

------------[ cut here ]------------
kernel BUG at fs/ocfs2/alloc.c:686!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6423 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:ocfs2_new_path fs/ocfs2/alloc.c:686 [inline]
RIP: 0010:ocfs2_commit_truncate+0x223f/0x2250 fs/ocfs2/alloc.c:7254
Code: 10 e8 35 f5 8b fe e9 3a fc ff ff e8 fb fc 26 fe 44 89 fe 48 c7 c7 00 ab 24 8e e8 7c 61 1f 01 e9 45 fc ff ff e8 e2 fc 26 fe 90 <0f> 0b 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffc90003e2f1a0 EFLAGS: 00010293
RAX: ffffffff8397c64e RBX: ffff8880769bce80 RCX: ffff88802e9a9e40
RDX: 0000000000000000 RSI: 0000000000000138 RDI: 0000000000000004
RBP: ffffc90003e2f4d0 R08: ffffc90003e2f38f R09: 0000000000000000
R10: ffffc90003e2f380 R11: fffff520007c5e72 R12: dffffc0000000000
R13: 1ffff920007c5e54 R14: 0000000000000138 R15: 1ffff1100cc73e58
FS:  0000555560f90500(0000) GS:ffff888126504000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555560fbb648 CR3: 0000000076f74000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ocfs2_truncate_for_delete fs/ocfs2/inode.c:699 [inline]
 ocfs2_wipe_inode fs/ocfs2/inode.c:866 [inline]
 ocfs2_delete_inode fs/ocfs2/inode.c:1155 [inline]
 ocfs2_evict_inode+0x1138/0x4100 fs/ocfs2/inode.c:1295
 evict+0x504/0x9c0 fs/inode.c:810
 d_delete_notify include/linux/fsnotify.h:377 [inline]
 vfs_rmdir+0x3ec/0x520 fs/namei.c:4561
 do_rmdir+0x25f/0x550 fs/namei.c:4603
 __do_sys_unlinkat fs/namei.c:4777 [inline]
 __se_sys_unlinkat fs/namei.c:4771 [inline]
 __x64_sys_unlinkat+0xc2/0xf0 fs/namei.c:4771
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcf61f852f7
Code: 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 07 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed1eb5598 EFLAGS: 00000207 ORIG_RAX: 0000000000000107
RAX: ffffffffffffffda RBX: 0000000000000065 RCX: 00007fcf61f852f7
RDX: 0000000000000200 RSI: 00007ffed1eb6740 RDI: 00000000ffffff9c
RBP: 00007fcf6200180c R08: 0000555560fb366b R09: 0000000000000000
R10: 0000000000001000 R11: 0000000000000207 R12: 00007ffed1eb6740
R13: 00007fcf6200180c R14: 00007ffed1eb88f0 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ocfs2_new_path fs/ocfs2/alloc.c:686 [inline]
RIP: 0010:ocfs2_commit_truncate+0x223f/0x2250 fs/ocfs2/alloc.c:7254
Code: 10 e8 35 f5 8b fe e9 3a fc ff ff e8 fb fc 26 fe 44 89 fe 48 c7 c7 00 ab 24 8e e8 7c 61 1f 01 e9 45 fc ff ff e8 e2 fc 26 fe 90 <0f> 0b 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffc90003e2f1a0 EFLAGS: 00010293
RAX: ffffffff8397c64e RBX: ffff8880769bce80 RCX: ffff88802e9a9e40
RDX: 0000000000000000 RSI: 0000000000000138 RDI: 0000000000000004
RBP: ffffc90003e2f4d0 R08: ffffc90003e2f38f R09: 0000000000000000
R10: ffffc90003e2f380 R11: fffff520007c5e72 R12: dffffc0000000000
R13: 1ffff920007c5e54 R14: 0000000000000138 R15: 1ffff1100cc73e58
FS:  0000555560f90500(0000) GS:ffff888126404000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0070ed000 CR3: 0000000076f74000 CR4: 00000000003526f0


Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=146b2d42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1215729170d20fc
dashboard link: https://syzkaller.appspot.com/bug?extid=c16daba279a1161acfb0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=126afc58580000


