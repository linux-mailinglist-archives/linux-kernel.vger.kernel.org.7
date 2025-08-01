Return-Path: <linux-kernel+bounces-753711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12601B186C8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB001C21517
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E0E27A931;
	Fri,  1 Aug 2025 17:38:40 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E42272E63
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 17:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754069920; cv=none; b=sOy1A/1fJiyJr3E1Z73nmN1H9n2/W5/+kpmxxT3HH+KqS1HdD9qHu70PrTf2hE78EwOcuhQTQBnLbonZ0INtPUz8KyGztosIAuXdwAFt9jLahjNzE12LotbPsHkvugU7HEM+M80P+rWJTzdCu/m7rNEQHPgtAKzun4qO00LeTws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754069920; c=relaxed/simple;
	bh=XlYxRB6g94pbyBNMU+NHqn+SfVBTiWFB4blcO11nBS0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MvDgmyx5ZP54XXGw9l/C1uzi8w8+hIq6eRwTMAqnXZLYHTjBwl8Hfy9VTZEwUk4Ayyd0PrU3TrS88Sn7brsmKHnF9utqD4wTmfMufK2ITNiqAxJ2cvWHZ3lWIGZZ/6yxsdkO/1M/ZlutJU4Dy6z2O0UD0w598ngURi39ZUduDwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3e3e69b2951so20988105ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 10:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754069918; x=1754674718;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jC6+HaDPuCHZJYlINPrCsO+9NjDfze3yT/eVSA8l9YA=;
        b=ZkbRjDUYHOatlphdVjuYBMR+dt1hgiLcx2oO9mMkdEzUkdLN0vK5VmSB4bo63jmJAi
         3leo/0+7evJDvyOp3ipXB+JzDz52uI+h+YtaDyKWEyz8D1j4oKD3+38lNYrf7Q0l0oPN
         pehMBf/pG1LNhy+QO/GV/p879A2M3rkQq99LmPh+AmuoVgTR7CH9aXg0aJpj3ROV+nfS
         9Gtii6lRHErUUiK27iEIbY3NOr7fRKJ/xyrQWOIO1j48aKZIG+RGoS6rf2AnPybbinDO
         2taJUM3RWD0/wEqVkVrNxiEe8UwDj6ddSfVnioYaxC8UcuttR59VD0pgebhJouIZCdjh
         4PTg==
X-Forwarded-Encrypted: i=1; AJvYcCUFE6iIq4urZtiU8L5PsDoH52dxf1Q9HtzHkqdeIcXnVO4iqxCG10bSo5lXjATfW3aQXezP6SuOE30d1Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHxf6fvLmRUa/2SnjQY11MJGV4tkUVANejpqLPHg7u+jxmMr8x
	OxG00KZsTfQpnlYwSIuJVc2q71Aguc3JrQwEnsec0q7EpUO9zV7+VXxm4KGjrv4w8lODbCk6Dyh
	+qe1TcFUvdhF1Wx06//0XIOqmpRrDXbOCfaVczmwRUkuXCN+d7lLxBQ8ljo0=
X-Google-Smtp-Source: AGHT+IEgrz79XLf17kxz+VSuZ/DrVwHlAKwGFOv3ARCEw+DM/XZ9vs9zQlH1y9gTYLROUBFW4w95QdOgEB3lvUsw5NVxl/nCNqdT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2166:b0:3e3:dcfa:eadb with SMTP id
 e9e14a558f8ab-3e4057ce907mr111020085ab.1.1754069917770; Fri, 01 Aug 2025
 10:38:37 -0700 (PDT)
Date: Fri, 01 Aug 2025 10:38:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688cfb9d.050a0220.f0410.012f.GAE@google.com>
Subject: [syzbot] [mm?] [ntfs3?] kernel BUG in set_page_refcounted
From: syzbot <syzbot+2a0d2af125c01db73079@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, almaz.alexandrovich@paragon-software.com, 
	apopple@nvidia.com, byungchul@sk.com, david@redhat.com, gourry@gourry.net, 
	joshua.hahnjy@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	matthew.brost@intel.com, ntfs3@lists.linux.dev, rakie.kim@sk.com, 
	syzkaller-bugs@googlegroups.com, ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    260f6f4fda93 Merge tag 'drm-next-2025-07-30' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c31834580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb7581d3fb1bb0d7
dashboard link: https://syzkaller.appspot.com/bug?extid=2a0d2af125c01db73079
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149062a2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1fce1d4d56ce/disk-260f6f4f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/01688cdba884/vmlinux-260f6f4f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eba9b2f77e6a/bzImage-260f6f4f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/95ad5335ac08/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2a0d2af125c01db73079@syzkaller.appspotmail.com

 do_group_exit+0x21c/0x2d0 kernel/exit.c:1105
 __do_sys_exit_group kernel/exit.c:1116 [inline]
 __se_sys_exit_group kernel/exit.c:1114 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1114
 x64_sys_call+0x21f7/0x2200 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
------------[ cut here ]------------
kernel BUG at mm/internal.h:491!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 7687 Comm: syz.0.738 Tainted: G        W           6.16.0-syzkaller-08685-g260f6f4fda93 #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:set_page_refcounted+0x142/0x1e0 mm/internal.h:491
Code: 48 89 d8 48 25 ff 0f 00 00 74 21 e8 18 4e a4 ff e9 2c ff ff ff e8 0e 4e a4 ff 48 89 df 48 c7 c6 a0 47 17 8b e8 4f 05 e9 ff 90 <0f> 0b 48 89 df be 08 00 00 00 e8 3f 27 03 00 48 89 d8 48 c1 e8 03
RSP: 0018:ffffc900065f7670 EFLAGS: 00010246
RAX: 0ebb44fe4874cf00 RBX: ffffea00011839ff RCX: 0ebb44fe4874cf00
RDX: 0000000000000001 RSI: ffffffff8d1dbecc RDI: ffff88802f581dc0
RBP: 00000000000000ff R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1017124863 R12: 1ffffd4000230746
R13: 0000000000000000 R14: ffffea0001183a33 R15: dffffc0000000000
FS:  00007f4368d266c0(0000) GS:ffff888126c1e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007feecfc73000 CR3: 0000000034c06000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 alloc_pages_noprof+0xe4/0x1e0 mm/mempolicy.c:2513
 folio_alloc_noprof+0x22/0xc0 mm/mempolicy.c:2520
 filemap_alloc_folio_noprof+0xdf/0x510 mm/filemap.c:1007
 do_read_cache_folio+0x1c0/0x560 mm/filemap.c:3885
 do_read_cache_page mm/filemap.c:3989 [inline]
 read_cache_page+0x5d/0x170 mm/filemap.c:3998
 read_mapping_page include/linux/pagemap.h:993 [inline]
 inode_read_data+0xa7/0x480 fs/ntfs3/inode.c:1054
 ntfs_fill_super+0x39c8/0x40b0 fs/ntfs3/super.c:1533
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4369ac030a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4368d25e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f4368d25ef0 RCX: 00007f4369ac030a
RDX: 0000200000000080 RSI: 000020000001f740 RDI: 00007f4368d25eb0
RBP: 0000200000000080 R08: 00007f4368d25ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000020000001f740
R13: 00007f4368d25eb0 R14: 000000000001f771 R15: 0000200000000100
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:set_page_refcounted+0x142/0x1e0 mm/internal.h:491
Code: 48 89 d8 48 25 ff 0f 00 00 74 21 e8 18 4e a4 ff e9 2c ff ff ff e8 0e 4e a4 ff 48 89 df 48 c7 c6 a0 47 17 8b e8 4f 05 e9 ff 90 <0f> 0b 48 89 df be 08 00 00 00 e8 3f 27 03 00 48 89 d8 48 c1 e8 03
RSP: 0018:ffffc900065f7670 EFLAGS: 00010246
RAX: 0ebb44fe4874cf00 RBX: ffffea00011839ff RCX: 0ebb44fe4874cf00
RDX: 0000000000000001 RSI: ffffffff8d1dbecc RDI: ffff88802f581dc0
RBP: 00000000000000ff R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1017124863 R12: 1ffffd4000230746
R13: 0000000000000000 R14: ffffea0001183a33 R15: dffffc0000000000
FS:  00007f4368d266c0(0000) GS:ffff888126c1e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007feecfc73000 CR3: 0000000034c06000 CR4: 00000000003526f0


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

