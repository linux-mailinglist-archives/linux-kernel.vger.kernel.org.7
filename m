Return-Path: <linux-kernel+bounces-783924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29484B33461
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 05:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F111B16391D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B603D236457;
	Mon, 25 Aug 2025 03:00:27 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7E438DD8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756090827; cv=none; b=gZnUor0nmCCDXKtpxr+9Sya4ngRfKRLdiWg9vmXvhOBLZzZy6iyrGJF94VpAFhpEz+35w73dq5YfKohFG7QwRzRmRNXeCHvNfgZDl9a1yxay3hIx1DPYmjJxTCAvNtre3p6DLy2qs+ApNYF5SEJeiINYSKJt3F//JYppTBnpbXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756090827; c=relaxed/simple;
	bh=On6NNufLc7evAAFEvhqoiJszbm2w+txgPivoOzA49fM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=co49VyyG4DE8kPBng5+SwxnP5kt40STPvahCmF8RZhKoljv8eRdS3BxMiVX2eozdPba/Gv9sbilZsR80odffv6pjvCDltilrDPo/K4uvfg4WcaF0ZzHmqLIHMapRgtGH9zR04oMhB6no5gP80WlGB3cQS7pwi13yszUP/ie6jbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3eab737b99cso12986495ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 20:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756090825; x=1756695625;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tmrcDEBilQc0uWyoBAIxRFxht9mBBW+yjQf1/xXJYDU=;
        b=K9mvKgRyr71UuJuRujp6JiHCg0iY9t0CuQiq2cX9WSwl5qM1PnLpEtFbpAkDPhTkxn
         LNvIjuEfWPuNaICTglYKUJJNlPmCbog8ON+Yn0lB7hKavRbgW0vSKeIt7WevcDU66Tg+
         URGwZlYA1pdVjeqEW8FwsZT3asXjLblqQcJNTl4ziyU0yrPsTYUTxqn25NmTyj1H5EDM
         lNwUAw9kv0Dwuv5iXSdNaLk5Vq4gZOIfxe/4PvK9bhaXmBidSa2CHi7kn5y95foC67te
         gMKsHs3dA2nvbVKr3EdJI5a9QvJlv9A1LiMNSaIBTvx3XvBJVma/ke3++zcMpVwCr64a
         xTRA==
X-Forwarded-Encrypted: i=1; AJvYcCW/ZSRqWslSiXi1NVAwjf7AvkngpafufV06uRrQ0L/cQCEloiwnpM5BGYxsqZhcBiXRS8HJyZxfIueRFbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAZyBEYZNUm7JaV/cNrNw8j3kfSNH6JqE7GRtrG+lsyZGGaxmo
	LiF13nhbNMs2LRbFrGjWhSznccEZrW1dOTO4/BD1t26/4GTQ0ff90WOw9ejRcNzSo5rGNStJiWs
	RmQvk5P8u0s7bkza+j6Wmz5DEmQ8lrgU6sNK2tr5H8NInz51JLrGBjGCBq8o=
X-Google-Smtp-Source: AGHT+IGbyIv5d3/3s3gokcpaIbNdipPWCOYcMgcaz6q5tQHLSuKntrkGcUJM1rnLVeKtP9yYYFE5fw+4uQjgep4npvZZqhoDv0kX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a43:b0:3e9:e4ca:4aa8 with SMTP id
 e9e14a558f8ab-3e9e4ca4fe2mr125602185ab.25.1756090824779; Sun, 24 Aug 2025
 20:00:24 -0700 (PDT)
Date: Sun, 24 Aug 2025 20:00:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68abd1c8.050a0220.37038e.0083.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in copy_process
From: syzbot <syzbot+69c74d38464686431506@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, bsegall@google.com, 
	david@redhat.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com, 
	kees@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lorenzo.stoakes@oracle.com, mgorman@suse.de, mhocko@suse.com, 
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, rppt@kernel.org, 
	surenb@google.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz, 
	vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    41cd3fd15263 Merge tag 'pci-v6.17-fixes-2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d8b3bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fecbb496f75d3d61
dashboard link: https://syzkaller.appspot.com/bug?extid=69c74d38464686431506
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea83f558e101/disk-41cd3fd1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a35b75cdd97b/vmlinux-41cd3fd1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/37d76e9636c2/bzImage-41cd3fd1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+69c74d38464686431506@syzkaller.appspotmail.com

oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=/,mems_allowed=0-1,oom_memcg=/syz1,task_memcg=/syz1,task=syz.1.3237,pid=23388,uid=0
Memory cgroup out of memory: Killed process 23388 (syz.1.3237) total-vm:101828kB, anon-rss:940kB, file-rss:21532kB, shmem-rss:0kB, UID:0 pgtables:116kB oom_score_adj:1000
------------[ cut here ]------------
pvqspinlock: lock 0xffff88803512c0c0 has corrupted value 0x0!
WARNING: CPU: 0 PID: 23388 at kernel/locking/qspinlock_paravirt.h:504 __pv_queued_spin_unlock_slowpath+0x237/0x330 kernel/locking/qspinlock_paravirt.h:504
Modules linked in:
CPU: 0 UID: 0 PID: 23388 Comm: syz.1.3237 Tainted: G     U              syzkaller #0 PREEMPT(full) 
Tainted: [U]=USER
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__pv_queued_spin_unlock_slowpath+0x237/0x330 kernel/locking/qspinlock_paravirt.h:504
Code: 03 0f b6 14 02 4c 89 e8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 67 41 8b 55 00 4c 89 ee 48 c7 c7 00 81 ad 8b e8 fa aa e6 f5 90 <0f> 0b 90 90 e9 64 ff ff ff 90 0f 0b 48 89 df 4c 89 04 24 e8 71 15
RSP: 0018:ffffc9000e9c79c8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88803512c0c0 RCX: ffffffff817a02c8
RDX: ffff88802fa9bc00 RSI: ffffffff817a02d5 RDI: 0000000000000001
RBP: ffff88803512c0c8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 00000000000d4550 R12: ffff88803512c0d0
R13: ffff88803512c0c0 R14: 00000000003d0f00 R15: ffff88802ab43c00
FS:  0000555568154500(0000) GS:ffff8881246c4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f86cc8e86ec CR3: 0000000060c0e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __raw_callee_save___pv_queued_spin_unlock_slowpath+0x15/0x30
 .slowpath+0x9/0x18
 pv_queued_spin_unlock arch/x86/include/asm/paravirt.h:562 [inline]
 queued_spin_unlock arch/x86/include/asm/qspinlock.h:57 [inline]
 do_raw_spin_unlock+0x172/0x230 kernel/locking/spinlock_debug.c:142
 __raw_spin_unlock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_unlock+0x1e/0x50 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:391 [inline]
 copy_process+0x6b72/0x7690 kernel/fork.c:2432
 kernel_clone+0xfc/0x930 kernel/fork.c:2605
 __do_sys_clone3+0x212/0x290 kernel/fork.c:2909
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f86cbbc3449
Code: d7 08 00 48 8d 3d fc d7 08 00 e8 02 29 f6 ff 66 90 b8 ea ff ff ff 48 85 ff 74 2c 48 85 d2 74 27 49 89 c8 b8 b3 01 00 00 0f 05 <48> 85 c0 7c 18 74 01 c3 31 ed 48 83 e4 f0 4c 89 c7 ff d2 48 89 c7
RSP: 002b:00007ffe52a9ff08 EFLAGS: 00000206 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007f86cbb45850 RCX: 00007f86cbbc3449
RDX: 00007f86cbb45850 RSI: 0000000000000058 RDI: 00007ffe52a9ff50
RBP: 00007f86c9dee6c0 R08: 00007f86c9dee6c0 R09: 00007ffe52aa0037
R10: 0000000000000008 R11: 0000000000000206 R12: ffffffffffffffa8
R13: 000000000000000b R14: 00007ffe52a9ff50 R15: 00007ffe52aa0038
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

