Return-Path: <linux-kernel+bounces-865794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9CDBFE0DA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 21:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F00C04F8A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37B92F4A1B;
	Wed, 22 Oct 2025 19:35:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A9337160
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 19:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161705; cv=none; b=nLsTLEtYlvTapvK8ZgfssTpB0aoao+bCCvbhDKOaDVTChUavEe1aksq5AdJ/owOE1CSFIXvk+z29zcAnKlzUrL7i9kgG8NWjoAa+lHVTnBCthtzcNamybcYYaU8HDMkgSvdzXsaYrcFcsRdk+hTiH01BWrtbzyokQZKiwNiexew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161705; c=relaxed/simple;
	bh=GYdhCebkmdsPx+EA+OG3EtmMGa1Tgacoi1W3Eb9XOuY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SNSz5928UwTqwbuyCgO9WOJyzJfa793sUQscAixQQjZ+CzEENZhMYaK7KYOVkrHygGTDY44YqTZjqNp/rfkCQ6Va/XpIjgDRCioaIn6qUUYoC0SJK5szt0m/gWNWs/RIYIm9Lj37/gFg4V1n9MmZ+islzLcxjMl621toueU3YWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430d4a4dec5so1614335ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761161703; x=1761766503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7CcaC11LGbW2w6XQP1Btvq/QO8W43D6kYeGBH5iPK0=;
        b=n2PzD8em6zy1mNWUwUBJrzbc+iT7WmKerTAiFENTbYg9tIMo8lNqyIO4szcSbhWxgy
         +mXaixjeXI2YyC0UQg3zJ3ZgEc+Fxdsu1Szc0fk3r8RQk/hrXAV57oWY6Jq+tAnvLNvl
         O5TIU1uuWA0sbVoPahPwOAEkOp8LtxCklQ60aBu3soKOGwzDPd1oIYWDXHp6Ha6zGXvP
         Fe+BOlt9ymneCmlL089Zr+xyohIkRFihOF5RAkXtM3KdOVn75aO1aFg1lO7lrbIqsbhB
         ju5sLRVvIxdJYD6GbyaLSylHo/FOOebRjEaZFXRokUeMhOoNOiAG1lvgf1FpsahdXGGe
         JroQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlqHVguhPARdiIhgVAuOrjW7g8gMdVQC15fgibuYuVxC93iQhPvXFC1Y6/An7xuQvNvFYJ/jxI9XStIqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLVcDJ/cwzhpnLrFlPfdVm1jNhm51Up5Gawhlhd5yUNP2f7Rt8
	IicoiVdQ7QFfIoVCLj7Zo/vPJWGtVNkx3KJgv2tVEEjJN/KKGVVJEhjS/bj7WUQD8rcV/LXNncu
	R1GwnvTgOY5VVVePuMgQWE5gnNfZLyzxZ/vWNWDeZiAh6uCHP/SGyC1YAgcw=
X-Google-Smtp-Source: AGHT+IGpsNpGq9rk3bfH1s/PuajgDCd3G9iQK2xnNgndf2nCsgym5lzm7IQSp7iDb+ClqemnXotu0AvYQk65kv6fzheIPmKkEVVp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2291:b0:42f:9187:f6e0 with SMTP id
 e9e14a558f8ab-430c5270233mr343148535ab.13.1761161702988; Wed, 22 Oct 2025
 12:35:02 -0700 (PDT)
Date: Wed, 22 Oct 2025 12:35:02 -0700
In-Reply-To: <20251022150431.jNFth%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f931e6.a70a0220.3bf6c6.0024.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_iget
From: syzbot <syzbot+5bdd4953bc58c8fbd6eb@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in ocfs2_iget

(syz.0.17,6559,0):ocfs2_read_locked_inode:612 ERROR: Inode 66: system file state is ambiguous
------------[ cut here ]------------
kernel BUG at fs/ocfs2/inode.c:612!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6559 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:ocfs2_read_locked_inode fs/ocfs2/inode.c:609 [inline]
RIP: 0010:ocfs2_iget+0x19a3/0x1a90 fs/ocfs2/inode.c:157
Code: bc 24 60 01 00 00 4c 8b 84 24 a0 01 00 00 4c 89 f7 48 c7 c6 f0 55 d7 8c ba 64 02 00 00 48 c7 c1 00 c9 0a 8b e8 9e 65 15 00 90 <0f> 0b e8 a6 cb 23 fe 90 0f 0b e8 9e cb 23 fe 31 f6 65 ff 0d 65 3f
RSP: 0018:ffffc90003f66d40 EFLAGS: 00010246
RAX: 8f703e25fe532600 RBX: ffffc90003f66e80 RCX: 8f703e25fe532600
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003f66fb0 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed101710487b R12: ffff888044f6642c
R13: 1ffff920007ecdb0 R14: ffffc90003f66ea0 R15: 1000000000000000
FS:  00007f4a52cbe6c0(0000) GS:ffff888127012000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f45247a7000 CR3: 000000003fd50000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ocfs2_init_global_system_inodes+0x16c/0x660 fs/ocfs2/super.c:449
 ocfs2_initialize_super fs/ocfs2/super.c:2196 [inline]
 ocfs2_fill_super+0x447b/0x65f0 fs/ocfs2/super.c:993
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
 vfs_get_tree+0x92/0x2b0 fs/super.c:1751
 fc_mount fs/namespace.c:1208 [inline]
 do_new_mount_fc fs/namespace.c:3651 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3727
 do_mount fs/namespace.c:4050 [inline]
 __do_sys_mount fs/namespace.c:4238 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4215
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4a5365066a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4a52cbde68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f4a52cbdef0 RCX: 00007f4a5365066a
RDX: 0000200000004440 RSI: 00002000000000c0 RDI: 00007f4a52cbdeb0
RBP: 0000200000004440 R08: 00007f4a52cbdef0 R09: 00000000000008c0
R10: 00000000000008c0 R11: 0000000000000246 R12: 00002000000000c0
R13: 00007f4a52cbdeb0 R14: 0000000000004446 R15: 0000200000000240
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ocfs2_read_locked_inode fs/ocfs2/inode.c:609 [inline]
RIP: 0010:ocfs2_iget+0x19a3/0x1a90 fs/ocfs2/inode.c:157
Code: bc 24 60 01 00 00 4c 8b 84 24 a0 01 00 00 4c 89 f7 48 c7 c6 f0 55 d7 8c ba 64 02 00 00 48 c7 c1 00 c9 0a 8b e8 9e 65 15 00 90 <0f> 0b e8 a6 cb 23 fe 90 0f 0b e8 9e cb 23 fe 31 f6 65 ff 0d 65 3f
RSP: 0018:ffffc90003f66d40 EFLAGS: 00010246
RAX: 8f703e25fe532600 RBX: ffffc90003f66e80 RCX: 8f703e25fe532600
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003f66fb0 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed101710487b R12: ffff888044f6642c
R13: 1ffff920007ecdb0 R14: ffffc90003f66ea0 R15: 1000000000000000
FS:  00007f4a52cbe6c0(0000) GS:ffff888127012000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4524799000 CR3: 000000003fd50000 CR4: 00000000003526f0


Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12a64614580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1620e3721dc97c0
dashboard link: https://syzkaller.appspot.com/bug?extid=5bdd4953bc58c8fbd6eb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12b19b04580000


