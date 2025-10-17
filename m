Return-Path: <linux-kernel+bounces-857894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A47B5BE832D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6BC6E43B4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03161321428;
	Fri, 17 Oct 2025 10:52:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6737321426
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698325; cv=none; b=e17l/RXu3Kd8d3v7rLFLdLXIaQVNp9grXT9QHprVgfat3bLfrdzZfw2AlI/AtUi1R3FWnUD+ugM1cvbcMZtQ37TDIGPTc3zGoELexyQMp5onmjjv773uYGBQ8yPLIwlKxKzHvZvl9jmbZnBY8eGKXrlNmzXA+nKhWx//8lPe/kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698325; c=relaxed/simple;
	bh=WS238Cu3bDpTBRMXAM1Z08hgqvGtjH7a5kLfbscgq3M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mYJzUE4VTEyrXhgx+2PF1ae4SJ1nYNe+QXIOazWtCsyC8k17AupbLAspxD9pRatd8zDrGYyWpzUM3jIPphdU80IDdltxzm1olWxC6c28zqtLXoNQvBjsW987e9rYPl+qRcCbL5EFvZOZ+suQGvRu+Kml5PA/xIGh2Yz2wUwD5TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-9286199b46fso183205739f.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760698323; x=1761303123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YrVD2+wt400thVh0zpZCcgoCSJVZOHGCfjdO43pb434=;
        b=vcbaTFctSSVjyBAb2gS66EWc1zmH23qchUIjNHtyyLZk2z3HRXSmHilSnrxeh9zT6j
         qdeQQr3oipWRTWLIxDXG2U2jwKkdLm04L7FM7oO0EpYB7d74H8PSP986QEOPX17dcQEv
         rE25GF4j5mXqWPJ8CwtpyhWgUxL8BUfIw88Pa6ESdbDGi6uf/mTQWxzDs5gdN1ysUDV7
         4ZXvdAKwDPpKViqgMgSxmxD/VWv5ClC6KdIpzZRroY1eBHCfJpDBVBQ/fA3I/fgSGroH
         k1E0HbpKIGR1Dmo3Y3E1uTw80wyV9SDHr+ZK1wXMRO4lAmfDg8MKK3oHq4oamPLCrSeO
         cVvg==
X-Gm-Message-State: AOJu0YywKIiwodrXCvmhzMYEeevJdv0cFa+mfB+1W+Mwglf48ZUXxsx8
	rwSiGlg/1cXRtrZS/N5u7LC0gQa4MloIO1vkv4ol10zQxUD0fDiQR3gElno+FOVyiBCf9B58Njq
	GLTLxg4bOQGmw+Hq9wfCixKJRluZGjaQFlQYiu0JJXn3AZOLRG8BHTvglPBg=
X-Google-Smtp-Source: AGHT+IG+mWjXWQXEqcecHbVj/TqxYznOpVRcQy23d4akM3dJH+RCjGqn+5UvwecvpljMPbKvz13e6bYGVUybIJYQYuAg7W22j7ji
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca46:0:b0:430:aca2:53ca with SMTP id
 e9e14a558f8ab-430c51ebb58mr47337615ab.5.1760698322943; Fri, 17 Oct 2025
 03:52:02 -0700 (PDT)
Date: Fri, 17 Oct 2025 03:52:02 -0700
In-Reply-To: <d5067a639f2341e6cce0a48f810c22d2e36c33a8.1760688719.git.xiaopei01@kylinos.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f21fd2.050a0220.91a22.041b.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbAllocAG (3)
From: syzbot <syzbot+4b717071f1eecb2972df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in dbAllocAG

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6656 at fs/jfs/jfs_dmap.c:1440 dbAllocAG+0xd67/0x1080 fs/jfs/jfs_dmap.c:1440
Modules linked in:
CPU: 1 UID: 0 PID: 6656 Comm: syz.0.22 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:dbAllocAG+0xd67/0x1080 fs/jfs/jfs_dmap.c:1440
Code: 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 fe e7 e6 fe 48 8b 3b 48 c7 c6 a0 1a 24 8b e9 d2 f9 ff ff e8 ea 35 85 fe 90 <0f> 0b 90 48 8b 44 24 78 42 0f b6 04 20 84 c0 0f 85 d5 02 00 00 48
RSP: 0018:ffffc90004e4f300 EFLAGS: 00010293
RAX: ffffffff8339c746 RBX: ffff888036d4f000 RCX: ffff88802e0a8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000002 R12: dffffc0000000000
R13: 0000000000000155 R14: 0000000000000000 R15: 00000000000000ff
FS:  00007efe0bfed6c0(0000) GS:ffff888126cc6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000565151f06950 CR3: 0000000041956000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 dbAlloc+0x5a8/0xba0 fs/jfs/jfs_dmap.c:877
 extBalloc fs/jfs/jfs_extent.c:336 [inline]
 extAlloc+0x54a/0xfb0 fs/jfs/jfs_extent.c:127
 jfs_get_block+0x346/0xab0 fs/jfs/inode.c:254
 __block_write_begin_int+0x6b5/0x1900 fs/buffer.c:2145
 block_write_begin+0x8a/0x120 fs/buffer.c:2256
 jfs_write_begin+0x35/0x80 fs/jfs/inode.c:306
 generic_perform_write+0x29d/0x8c0 mm/filemap.c:4242
 generic_file_write_iter+0x118/0x550 mm/filemap.c:4385
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5d5/0xb40 fs/read_write.c:686
 ksys_write+0x14b/0x260 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efe0c99eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efe0bfed038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007efe0cbf6090 RCX: 00007efe0c99eec9
RDX: 0000000000000014 RSI: 0000200000000380 RDI: 0000000000000005
RBP: 00007efe0ca21f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007efe0cbf6128 R14: 00007efe0cbf6090 R15: 00007ffeba24aff8
 </TASK>


Tested on:

commit:         98ac9cc4 Merge tag 'f2fs-fix-6.18-rc2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1606cb04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=4b717071f1eecb2972df
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17cfbdcd980000


