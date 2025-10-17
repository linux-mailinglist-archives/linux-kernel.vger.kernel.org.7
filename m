Return-Path: <linux-kernel+bounces-857249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A2CBE6516
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF971A62628
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 04:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46252D9EE6;
	Fri, 17 Oct 2025 04:35:35 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC38334689
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760675735; cv=none; b=MzYXTWpzk3GUoPzxahBdGYZ9R577rggb7mpJFxmxlJMkbba6Np2JFAvCr46LJCs+GIlMM0NEtuYVBiGNIJktgPnPZZC8l9DNwBvDlxinIVLH2VBHv5K9/k+e5bLvjnHNhnN6lej8FfpHG6aMDd7OWFRwlnQlQyu1QrsHt7XU4pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760675735; c=relaxed/simple;
	bh=+cpUET2RaiwVbSCnhJHGDy3gjTOjlFIKyyNUZceAlxw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ultZ8YY7XUhxy14R/tzwnj9eOVwujl30fgW2xUaamj+POhjMh+E89NrVVxZbKg4DWm9/Pg48CRTzuK/os0NSZHfz1FS0LCJJl6ylJofZHd7j7lZZRtIm4V2lnAuiCP9/v0Czw5dYJMop5NVCTdD44MiOWL59VZXXhWnwSi3vNVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-42f81a589caso44994285ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760675732; x=1761280532;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QrrA6yogJoytvN1hF9nAET8Z+V5twXRPGUL0SN6HeuE=;
        b=KNigBvYDxvMoucM5EvPy3ljTXhW2rc3XJ/yA3ns2Pmeq0UULIBmKE20HU350lngcRd
         GYu5e4C9MGWELVJeazGGTG4ILDW8/HGciOS4QoW1FvRgj9rA5XF31nB70rbEwctbX/MC
         5G7BX6IAxRQf6bhEl9KLurLrx3K2WKU5ojo+u8Qmb31p8ep5lcZJogwy136BmWekPAiE
         IFxQWJlE0ZiQD+mD+/KyNDILFjWLlEWuk9gGJZcUZ6JukW4L0x1EFRQGVePwA9VnYjxi
         lF/osYZvL0MrSqyykJijdIrQdgEGEJWTSMv9GSXCdPdFFdGoIsAiWFuWFdGkdTaPA2IE
         4bdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7TARWEICDSbQ8Xphnk1qjvHcJT50y1sjMOrpkINrxs9qZpKZre++PE/F7jpnpgqyGDsuuetwwRI+JVx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH4aN4hCC6CTKedBXfialWK498NnJrp43SMfN/vLVSlpep7Grx
	WT8x8wTrpcipuYqJZfUY1d/Ya7Ir8oMAkhH1Qa3ua2WnvoUtljSPtmKEKb2+qi+Q2fL8q7FAtZ4
	ju/p1IdQx7hoh5398r8mHTky2pOoFJOOBEbKijyIry+NRAPGsc6/w1jk5hTg=
X-Google-Smtp-Source: AGHT+IH6UbAeecHDuAvKxcgIbUdjXm6ThLX5Z1PFdR7HStKUtHJb37/hGofOkznOzs0WR8f7YiMgLVCXf0PYmZDHeUFRFSxpnx+R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e9:b0:430:c0e4:9e43 with SMTP id
 e9e14a558f8ab-430c52343e2mr39728875ab.6.1760675732668; Thu, 16 Oct 2025
 21:35:32 -0700 (PDT)
Date: Thu, 16 Oct 2025 21:35:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f1c794.a00a0220.361615.000f.GAE@google.com>
Subject: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbAllocAG (3)
From: syzbot <syzbot+4b717071f1eecb2972df@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7ea30958b305 Merge tag 'vfs-6.18-rc2.fixes' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10eee5e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=4b717071f1eecb2972df
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a64b04580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c8bdcd980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e5414d12be0/disk-7ea30958.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f88a30954acd/vmlinux-7ea30958.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aa2283ab9f73/bzImage-7ea30958.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ffc7d81ee40c/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=1585552f980000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4b717071f1eecb2972df@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:1440:48
shift exponent -1 is negative
CPU: 0 UID: 0 PID: 6076 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
 dbAllocAG+0xfc0/0xff0 fs/jfs/jfs_dmap.c:1440
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
RIP: 0033:0x7fa99272eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffa62c1048 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fa992985fa0 RCX: 00007fa99272eec9
RDX: 0000000000000014 RSI: 0000200000000380 RDI: 0000000000000005
RBP: 00007fa9927b1f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa992985fa0 R14: 00007fa992985fa0 R15: 0000000000000003
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

