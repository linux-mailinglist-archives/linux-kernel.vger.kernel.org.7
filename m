Return-Path: <linux-kernel+bounces-884144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6281EC2F731
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 07:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE488189C1C4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 06:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E8F35962;
	Tue,  4 Nov 2025 06:34:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119DC1B7F4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762238045; cv=none; b=eNon1VORxJeJwG4m4GEgcPl7VIJfdDydET6FXGPg/a3is6EpgQIcBDYJD5uzbmyLyiAkUR4rcsjU90vBZ1iu2UfEjfbsykCwVewBFI1PkIMKU685AR+rzt3J0MU3QCIEagq4h8P/V4vBxrH52WcDrtL7kYBuLPEqgt2uiMYKuAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762238045; c=relaxed/simple;
	bh=x8YZdzL/tZVXUmkQ5Tzj1U5Guxj9yUfEJWY6s0YT3so=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mFEdQl1hM32jIwrPXnN9q/CLs+7PhGvr+JYdzowX6sYulK3Kq8vNipEW/65uD4wttXVb8cNlom0uhAQXGxVywseDtumoJuPPQpFm+iMg1ONHfn9jC/UDOUKoFxsaMF1UkXhLkThdtf177W0n2nmGOtn8aQdU0rPwjIAN1oWSskU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-937e5f9ea74so754987339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 22:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762238043; x=1762842843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0ZnxBr7metABhqcvt5CCeBCbK8dZlok0WJ484JGXKM=;
        b=AsIexywyNlzCQPKHQSirs331vimVwvrQgGgy10UPV7AaZFj3Ho7+XHEn9xtrsBlfob
         a5AZPaor8E+pSlAeOChmexo+srkM2ShvKNWAzw+gbGbwgI/xyjfe+JFE8igvfSwqXzX3
         DqOr/qJJYru5HC8oQsctmBgKjRtN81smXinOGxiFLV+9AEkEUCfHjQLhztKCt52LOkNk
         UaefP/UWeMFF/VciHshZIfd54+Nd3ea+egH6XYLevDhQ3v9nYJ8s946H2S2GkrcWkk4b
         h8zojHN5PzT8BqSgbKqPLRZ2ukpQt8xVfHM5lEzgikd4rgPZ7wzXUNNK1AGUtrmKxf0/
         r7MQ==
X-Gm-Message-State: AOJu0Yzs4l/WbGtp910iXyeto/o1tS8Sgf02yvrniGrYl4iZNFHdnfzJ
	AKAgkzjzrOIhKDbdj/HHW7l4AAHz1oPBMprvYEZpKL69SRyQ8lyKCBHWSniOsoCzyqChplwSK0h
	L3mOG1IVPSmfgr8hVnFgAGR8HuauIhDDu1pTQ5ROzmij8KLoNoZiRiKorzQQ=
X-Google-Smtp-Source: AGHT+IHopg71eAti+VgHELDNCFrqnJCsoq1RtcnK6OYEDaczW6xk07fE5L1Zd3HKc5ip/T9JzkJzONQOqUhQ9E5tH9yGEpU7Qjxr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:d:b0:433:3192:4a5 with SMTP id
 e9e14a558f8ab-4333192069fmr76967775ab.3.1762238043151; Mon, 03 Nov 2025
 22:34:03 -0800 (PST)
Date: Mon, 03 Nov 2025 22:34:03 -0800
In-Reply-To: <uzq2pgc3ufm7iewqzhfnujt5pwqcsadnfgufywp5gx6guzdtye@4pxj7vqewujt>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69099e5b.a70a0220.88fb8.000c.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in ni_rename (2)
From: syzbot <syzbot+4d8e30dbafb5c1260479@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, listout@listout.xyz, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: sleeping function called from invalid context in indx_insert_entry

loop0: detected capacity change from 0 to 4096
BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:321
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6503, name: syz.0.17
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
6 locks held by syz.0.17/6503:
 #0: ffff888032ba6480 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:508
 #1: ffff888054585088 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1025 [inline]
 #1: ffff888054585088 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3360 [inline]
 #1: ffff888054585088 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: do_renameat2+0x3b9/0xa50 fs/namei.c:5311
 #2: ffff888054585838 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:980 [inline]
 #2: ffff888054585838 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: lock_two_nondirectories+0xe7/0x180 fs/inode.c:1232
 #3: ffff888054586f48 (&sb->s_type->i_mutex_key#20/4){+.+.}-{4:4}, at: vfs_rename+0x665/0xe80 fs/namei.c:5187
 #4: ffff888054584dd0 (&ni->ni_lock/6){+.+.}-{4:4}, at: ni_lock_dir fs/ntfs3/ntfs_fs.h:1118 [inline]
 #4: ffff888054584dd0 (&ni->ni_lock/6){+.+.}-{4:4}, at: ntfs_rename+0x6de/0xbf0 fs/ntfs3/namei.c:327
 #5: ffff888054586c90 (&ni->ni_lock#3/5){+.+.}-{4:4}, at: ni_lock fs/ntfs3/ntfs_fs.h:1113 [inline]
 #5: ffff888054586c90 (&ni->ni_lock#3/5){+.+.}-{4:4}, at: ntfs_rename+0x6f7/0xbf0 fs/ntfs3/namei.c:328
Preemption disabled at:
[<ffffffff8301e706>] ni_rename+0x46/0x130 fs/ntfs3/frecord.c:3026
CPU: 0 UID: 0 PID: 6503 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x44b/0x5d0 kernel/sched/core.c:8927
 might_alloc include/linux/sched/mm.h:321 [inline]
 slab_pre_alloc_hook mm/slub.c:4921 [inline]
 slab_alloc_node mm/slub.c:5256 [inline]
 __kmalloc_cache_noprof+0x60/0x6c0 mm/slub.c:5758
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 fnd_get fs/ntfs3/ntfs_fs.h:670 [inline]
 indx_insert_entry+0xd9/0x720 fs/ntfs3/index.c:1954
 ni_add_name+0x8a8/0xc90 fs/ntfs3/frecord.c:2995
 ni_rename+0x54/0x130 fs/ntfs3/frecord.c:3027
 ntfs_rename+0x735/0xbf0 fs/ntfs3/namei.c:332
 vfs_rename+0xb34/0xe80 fs/namei.c:5216
 do_renameat2+0x6a2/0xa50 fs/namei.c:5364
 __do_sys_rename fs/namei.c:5411 [inline]
 __se_sys_rename fs/namei.c:5409 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5409
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efd9b34efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efd9a9be038 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007efd9b5a5fa0 RCX: 00007efd9b34efc9
RDX: 0000000000000000 RSI: 00002000000002c0 RDI: 0000200000000580
RBP: 00007efd9b3d1f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007efd9b5a6038 R14: 00007efd9b5a5fa0 R15: 00007ffd3bf7c298
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6503 at fs/ntfs3/frecord.c:3031 ni_rename+0x122/0x130 fs/ntfs3/frecord.c:3030
Modules linked in:
CPU: 0 UID: 0 PID: 6503 Comm: syz.0.17 Tainted: G        W           syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:ni_rename+0x122/0x130 fs/ntfs3/frecord.c:3030
Code: 75 2d 89 d8 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d e9 91 37 c2 07 cc e8 4b d8 bc fe e8 46 f0 30 fe eb cf e8 3f d8 bc fe 90 <0f> 0b 90 eb 98 e8 04 79 be 07 0f 1f 40 00 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000488fa98 EFLAGS: 00010293
RAX: ffffffff8301e7e1 RBX: 00000000fffffffe RCX: ffff88803dc5bc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000fffffffe R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1dac5ef R12: ffff888054584ce0
R13: ffff8880268d2200 R14: ffff8880268d2a00 R15: ffff888054586ba0
FS:  00007efd9a9be6c0(0000) GS:ffff888126df9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe9d3cde000 CR3: 0000000023140000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ntfs_rename+0x735/0xbf0 fs/ntfs3/namei.c:332
 vfs_rename+0xb34/0xe80 fs/namei.c:5216
 do_renameat2+0x6a2/0xa50 fs/namei.c:5364
 __do_sys_rename fs/namei.c:5411 [inline]
 __se_sys_rename fs/namei.c:5409 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5409
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efd9b34efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efd9a9be038 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007efd9b5a5fa0 RCX: 00007efd9b34efc9
RDX: 0000000000000000 RSI: 00002000000002c0 RDI: 0000200000000580
RBP: 00007efd9b3d1f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007efd9b5a6038 R14: 00007efd9b5a5fa0 R15: 00007ffd3bf7c298
 </TASK>


Tested on:

commit:         c9cfc122 Merge tag 'for-6.18-rc4-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1041c114580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=4d8e30dbafb5c1260479
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17dfc532580000


