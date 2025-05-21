Return-Path: <linux-kernel+bounces-656882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257EBABEC07
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 08:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74564A85D2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 06:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC4C230BD5;
	Wed, 21 May 2025 06:35:42 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795EB219EB
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747809341; cv=none; b=Sbsq511KhtNRsqiHWDv9BejwpJt0BsZy2PvPYmqmr/vs+PLb69NMry/eHMjLNP+UMYjrtJryv/pXa291uT1XGwcItq3aS0oiQhp/BqEEMr30w9iHm54oCydHQ/pPGG0sZZNBoO8Xqs9v1Qs7NBvEktl7UADGhqISZbxly4NyB94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747809341; c=relaxed/simple;
	bh=TFqvisHZf3CA3VoI4wvKrURXilJZGOHs5xSikL5EnuY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ugNl88QRpguqFNFfyAQ8S4q5hSsQXxtrRpg8Rev/fNdhUX5n/W/Id49S8deOjeRPQV+HvAllYVbKvaQ0Ez1z/VCkpjiSryhs+pJzVkiylyF31LJyW3YcOTRp8RZjgcjElkdw1XO0TIRwDpM/elLVB2rHNIjnv7M+w2i8YP+SaUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3dc879a9d68so2473395ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 23:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747809338; x=1748414138;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OrmvUOhBw5T/0ZsffU+wUyrwVOsl0UmePiswaflQtYE=;
        b=ieu4r1GUJj+nJonQ/R5ZdBq7VVlkHas8lREdzgw2otQs8hnMMLDijX2bGIW/1vIg5T
         XtEbE106DV7MiBnECU5sJkZFJs3WUQGjO6/YyYgH2qA5oqxCyFHsFo+uUf7fUuPNQ+tm
         AX5AO/HJAQLDAMQsjJiKkaxVasJPgqYFdkpmNjafrJutU2Aan6S7jFji3stKizhi8erc
         fdqLzr3Hy/gJIT55kx94pOFDRS341Hu3uE5UYwr9KsWyxQgSUgYeBbCDu/w3KGNvXsrv
         UOi7y6ZdnHRl/TdxYenVQu6TG0V2mcaIr5gkPkwaVE2fNgKNQ3pbXM/gKheSpKWrqXnA
         0dtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPyay/TdQsTOK8IXNN1cGWEzkMYDiFer1L3RbyT6hcgxUa/gfxRRf6kpO3fZP0nqKufwmQkYm/RcS12mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxOClJoO8lwurLRJ+wr9rf53rLr/W8rojnLgEW0fKBSyGUlqgD
	asZRNIWSk0uqg7HOtQ25F3Hpf6ZadcIT1hfi3hWcqIhRi6bTN93nflTNolrDk1TWJMT1zybC4FH
	gHEihGafqx71cZayITjlS/5aEIAqqG9vsa94n2gxEG8Upou8UmzQRZfWff34=
X-Google-Smtp-Source: AGHT+IF8y7xTMt0Au/GlUnoxVWxORbYZ8feoTneEwUTiP7KlZsqaYVjku59U2j9nkAOk6ydfK7MLGpvOcbRCkATjPCQIwpRR95g+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b89:b0:3ce:8ed9:ca94 with SMTP id
 e9e14a558f8ab-3db84321c68mr205137185ab.14.1747809338514; Tue, 20 May 2025
 23:35:38 -0700 (PDT)
Date: Tue, 20 May 2025 23:35:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682d743a.a00a0220.29bc26.0289.GAE@google.com>
Subject: [syzbot] [f2fs?] INFO: task hung in freeze_super (6)
From: syzbot <syzbot+aa5bb5f6860e08a60450@syzkaller.appspotmail.com>
To: bp@alien8.de, chao@kernel.org, dave.hansen@linux.intel.com, hanqi@vivo.com, 
	hpa@zytor.com, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3c21441eeffc Merge tag 'acpi-6.15-rc7' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=176b22d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea35e429f965296e
dashboard link: https://syzkaller.appspot.com/bug?extid=aa5bb5f6860e08a60450
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167d2ef4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a81f68580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/57d40aff8cb0/disk-3c21441e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9f367fd8bfd5/vmlinux-3c21441e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4e70f31a61dc/bzImage-3c21441e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9e197e7beb8c/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=11108ef4580000)

The issue was bisected to:

commit 84b5bb8bf0f6a78c232a20c2eecdbb8112ac2703
Author: Qi Han <hanqi@vivo.com>
Date:   Fri Oct 25 09:18:23 2024 +0000

    f2fs: modify f2fs_is_checkpoint_ready logic to allow more data to be written with the CP disable

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f45ef4580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12f45ef4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14f45ef4580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa5bb5f6860e08a60450@syzkaller.appspotmail.com
Fixes: 84b5bb8bf0f6 ("f2fs: modify f2fs_is_checkpoint_ready logic to allow more data to be written with the CP disable")

INFO: task syz-executor328:5836 blocked for more than 143 seconds.
      Not tainted 6.15.0-rc6-syzkaller-00208-g3c21441eeffc #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor328 state:D stack:23432 pid:5836  tgid:5832  ppid:5826   task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x168f/0x4c70 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 percpu_down_write+0x28e/0x330 kernel/locking/percpu-rwsem.c:253
 sb_wait_write fs/super.c:1855 [inline]
 freeze_super+0x4c2/0xeb0 fs/super.c:2044
 fs_bdev_freeze+0x19f/0x310 fs/super.c:1484
 bdev_freeze+0xd8/0x220 block/bdev.c:298
 f2fs_do_shutdown+0x23d/0x5c0 fs/f2fs/file.c:2367
 f2fs_ioc_shutdown fs/f2fs/file.c:2459 [inline]
 __f2fs_ioctl+0x3de9/0xae80 fs/f2fs/file.c:4558
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f836b5ab109
RSP: 002b:00007f836b55f218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f836b6386c8 RCX: 00007f836b5ab109
RDX: 0000200000000080 RSI: 000000008004587d RDI: 0000000000000005
RBP: 00007f836b6386c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f836b604668
R13: 00002000000000c0 R14: 0000200000000180 R15: 00002000000000e0
 </TASK>
INFO: task syz-executor328:5856 blocked for more than 144 seconds.
      Not tainted 6.15.0-rc6-syzkaller-00208-g3c21441eeffc #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor328 state:D stack:24392 pid:5856  tgid:5832  ppid:5826   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x168f/0x4c70 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 io_schedule+0x81/0xe0 kernel/sched/core.c:7742
 f2fs_balance_fs+0x4b4/0x780 fs/f2fs/segment.c:444
 f2fs_map_blocks+0x3af1/0x43b0 fs/f2fs/data.c:1791
 f2fs_expand_inode_data+0x653/0xaf0 fs/f2fs/file.c:1872
 f2fs_fallocate+0x4f5/0x990 fs/f2fs/file.c:1975
 vfs_fallocate+0x6a0/0x830 fs/open.c:338
 ioctl_preallocate fs/ioctl.c:290 [inline]
 file_ioctl fs/ioctl.c:-1 [inline]
 do_vfs_ioctl+0x1b8f/0x1eb0 fs/ioctl.c:885
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl+0x82/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f836b5ab109
RSP: 002b:00007f836b53e218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f836b6386d8 RCX: 00007f836b5ab109
RDX: 00002000000000c0 RSI: 0000000040305828 RDI: 0000000000000004
RBP: 00007f836b6386d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f836b604668
R13: 00002000000000c0 R14: 0000200000000180 R15: 00002000000000e0
 </TASK>
INFO: task syz-executor328:5894 blocked for more than 145 seconds.
      Not tainted 6.15.0-rc6-syzkaller-00208-g3c21441eeffc #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor328 state:D stack:24152 pid:5894  tgid:5892  ppid:5825   task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x168f/0x4c70 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 percpu_down_write+0x28e/0x330 kernel/locking/percpu-rwsem.c:253
 sb_wait_write fs/super.c:1855 [inline]
 freeze_super+0x4c2/0xeb0 fs/super.c:2044
 fs_bdev_freeze+0x19f/0x310 fs/super.c:1484
 bdev_freeze+0xd8/0x220 block/bdev.c:298
 f2fs_do_shutdown+0x23d/0x5c0 fs/f2fs/file.c:2367
 f2fs_ioc_shutdown fs/f2fs/file.c:2459 [inline]
 __f2fs_ioctl+0x3de9/0xae80 fs/f2fs/file.c:4558
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f836b5ab109
RSP: 002b:00007f836b55f218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f836b6386c8 RCX: 00007f836b5ab109
RDX: 0000200000000080 RSI: 000000008004587d RDI: 0000000000000005
RBP: 00007f836b6386c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f836b604668
R13: 00002000000000c0 R14: 0000200000000180 R15: 00002000000000e0
 </TASK>
INFO: task syz-executor328:5907 blocked for more than 145 seconds.
      Not tainted 6.15.0-rc6-syzkaller-00208-g3c21441eeffc #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor328 state:D stack:25432 pid:5907  tgid:5892  ppid:5825   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x168f/0x4c70 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 io_schedule+0x81/0xe0 kernel/sched/core.c:7742
 f2fs_balance_fs+0x4b4/0x780 fs/f2fs/segment.c:444
 f2fs_map_blocks+0x3af1/0x43b0 fs/f2fs/data.c:1791
 f2fs_expand_inode_data+0x653/0xaf0 fs/f2fs/file.c:1872
 f2fs_fallocate+0x4f5/0x990 fs/f2fs/file.c:1975
 vfs_fallocate+0x6a0/0x830 fs/open.c:338
 ioctl_preallocate fs/ioctl.c:290 [inline]
 file_ioctl fs/ioctl.c:-1 [inline]
 do_vfs_ioctl+0x1b8f/0x1eb0 fs/ioctl.c:885
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl+0x82/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f836b5ab109
RSP: 002b:00007f836b53e218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f836b6386d8 RCX: 00007f836b5ab109
RDX: 00002000000000c0 RSI: 0000000040305828 RDI: 0000000000000004
RBP: 00007f836b6386d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f836b604668
R13: 00002000000000c0 R14: 0000200000000180 R15: 00002000000000e0
 </TASK>
INFO: task syz-executor328:5896 blocked for more than 147 seconds.
      Not tainted 6.15.0-rc6-syzkaller-00208-g3c21441eeffc #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor328 state:D stack:25144 pid:5896  tgid:5893  ppid:5827   task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x168f/0x4c70 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 percpu_down_write+0x28e/0x330 kernel/locking/percpu-rwsem.c:253
 sb_wait_write fs/super.c:1855 [inline]
 freeze_super+0x4c2/0xeb0 fs/super.c:2044
 fs_bdev_freeze+0x19f/0x310 fs/super.c:1484
 bdev_freeze+0xd8/0x220 block/bdev.c:298
 f2fs_do_shutdown+0x23d/0x5c0 fs/f2fs/file.c:2367
 f2fs_ioc_shutdown fs/f2fs/file.c:2459 [inline]
 __f2fs_ioctl+0x3de9/0xae80 fs/f2fs/file.c:4558
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f836b5ab109
RSP: 002b:00007f836b55f218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f836b6386c8 RCX: 00007f836b5ab109
RDX: 0000200000000080 RSI: 000000008004587d RDI: 0000000000000005
RBP: 00007f836b6386c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f836b604668
R13: 00002000000000c0 R14: 0000200000000180 R15: 00002000000000e0
 </TASK>
INFO: task syz-executor328:5908 blocked for more than 147 seconds.
      Not tainted 6.15.0-rc6-syzkaller-00208-g3c21441eeffc #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor328 state:D stack:24984 pid:5908  tgid:5893  ppid:5827   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x168f/0x4c70 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 io_schedule+0x81/0xe0 kernel/sched/core.c:7742
 f2fs_balance_fs+0x4b4/0x780 fs/f2fs/segment.c:444
 f2fs_map_blocks+0x3af1/0x43b0 fs/f2fs/data.c:1791
 f2fs_expand_inode_data+0x653/0xaf0 fs/f2fs/file.c:1872
 f2fs_fallocate+0x4f5/0x990 fs/f2fs/file.c:1975
 vfs_fallocate+0x6a0/0x830 fs/open.c:338
 ioctl_preallocate fs/ioctl.c:290 [inline]
 file_ioctl fs/ioctl.c:-1 [inline]
 do_vfs_ioctl+0x1b8f/0x1eb0 fs/ioctl.c:885
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl+0x82/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f836b5ab109
RSP: 002b:00007f836b53e218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f836b6386d8 RCX: 00007f836b5ab109
RDX: 00002000000000c0 RSI: 0000000040305828 RDI: 0000000000000004
RBP: 00007f836b6386d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f836b604668
R13: 00002000000000c0 R14: 0000200000000180 R15: 00002000000000e0
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u8:1/13:
 #0: ffff888143ad3148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff888143ad3148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x9b1/0x17a0 kernel/workqueue.c:3319
 #1: ffffc90000127c60 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc90000127c60 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ec/0x17a0 kernel/workqueue.c:3319
 #2: ffff888079b0a0e0 (&type->s_umount_key#43){++++}-{4:4}, at: super_trylock_shared+0x20/0xf0 fs/super.c:562
1 lock held by khungtaskd/31:
 #0: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6764
5 locks held by kworker/u8:2/36:
3 locks held by kworker/u8:3/53:
 #0: ffff888143ad3148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff888143ad3148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x9b1/0x17a0 kernel/workqueue.c:3319
 #1: ffffc90000be7c60 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc90000be7c60 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ec/0x17a0 kernel/workqueue.c:3319
 #2: ffff8880240c40e0 (&type->s_umount_key#43){++++}-{4:4}, at: super_trylock_shared+0x20/0xf0 fs/super.c:562
3 locks held by kworker/u8:5/969:
 #0: ffff888143ad3148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff888143ad3148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x9b1/0x17a0 kernel/workqueue.c:3319
 #1: ffffc90003787c60 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc90003787c60 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ec/0x17a0 kernel/workqueue.c:3319
 #2: ffff8880230a20e0 (&type->s_umount_key#43){++++}-{4:4}, at: super_trylock_shared+0x20/0xf0 fs/super.c:562
2 locks held by getty/5576:
 #0: ffff888030c370a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900036e32f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
2 locks held by syz-executor328/5836:
 #0: ffff888022856930 (&bdev->bd_fsfreeze_mutex){+.+.}-{4:4}, at: bdev_freeze+0x2a/0x220 block/bdev.c:289
 #1: ffff8880230a2420 (sb_writers#9){++++}-{0:0}, at: sb_wait_write fs/super.c:1855 [inline]
 #1: ffff8880230a2420 (sb_writers#9){++++}-{0:0}, at: freeze_super+0x4c2/0xeb0 fs/super.c:2044
3 locks held by syz-executor328/5856:
 #0: ffff8880230a2420 (sb_writers#9){++++}-{0:0}, at: file_start_write include/linux/fs.h:3041 [inline]
 #0: ffff8880230a2420 (sb_writers#9){++++}-{0:0}, at: vfs_fallocate+0x62a/0x830 fs/open.c:337
 #1: ffff888078bcbfd8 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:867 [inline]
 #1: ffff888078bcbfd8 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: f2fs_fallocate+0x24e/0x990 fs/f2fs/file.c:1940
 #2: ffff888033c5d4f8 (&sbi->pin_sem){+.+.}-{4:4}, at: f2fs_down_write fs/f2fs/f2fs.h:2213 [inline]
 #2: ffff888033c5d4f8 (&sbi->pin_sem){+.+.}-{4:4}, at: f2fs_expand_inode_data+0x430/0xaf0 fs/f2fs/file.c:1839
2 locks held by syz-executor328/5894:
 #0: ffff888022855db0 (&bdev->bd_fsfreeze_mutex){+.+.}-{4:4}, at: bdev_freeze+0x2a/0x220 block/bdev.c:289
 #1: ffff888079b0a420 (sb_writers#9){++++}-{0:0}, at: sb_wait_write fs/super.c:1855 [inline]
 #1: ffff888079b0a420 (sb_writers#9){++++}-{0:0}, at: freeze_super+0x4c2/0xeb0 fs/super.c:2044
3 locks held by syz-executor328/5907:
 #0: ffff888079b0a420 (sb_writers#9){++++}-{0:0}, at: file_start_write include/linux/fs.h:3041 [inline]
 #0: ffff888079b0a420 (sb_writers#9){++++}-{0:0}, at: vfs_fallocate+0x62a/0x830 fs/open.c:337
 #1: ffff888074156398 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:867 [inline]
 #1: ffff888074156398 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: f2fs_fallocate+0x24e/0x990 fs/f2fs/file.c:1940
 #2: ffff888079f554f8 (&sbi->pin_sem){+.+.}-{4:4}, at: f2fs_down_write fs/f2fs/f2fs.h:2213 [inline]
 #2: ffff888079f554f8 (&sbi->pin_sem){+.+.}-{4:4}, at: f2fs_expand_inode_data+0x430/0xaf0 fs/f2fs/file.c:1839
2 locks held by syz-executor328/5896:
 #0: ffff8880228574b0 (&bdev->bd_fsfreeze_mutex){+.+.}-{4:4}, at: bdev_freeze+0x2a/0x220 block/bdev.c:289
 #1: ffff8880240c4420 (sb_writers#9){++++}-{0:0}, at: sb_wait_write fs/super.c:1855 [inline]
 #1: ffff8880240c4420 (sb_writers#9){++++}-{0:0}, at: freeze_super+0x4c2/0xeb0 fs/super.c:2044
3 locks held by syz-executor328/5908:
 #0: ffff8880240c4420 (sb_writers#9){++++}-{0:0}, at: file_start_write include/linux/fs.h:3041 [inline]
 #0: ffff8880240c4420 (sb_writers#9){++++}-{0:0}, at: vfs_fallocate+0x62a/0x830 fs/open.c:337
 #1: ffff888074157578 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:867 [inline]
 #1: ffff888074157578 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: f2fs_fallocate+0x24e/0x990 fs/f2fs/file.c:1940
 #2: ffff88807f9ad4f8 (&sbi->pin_sem){+.+.}-{4:4}, at: f2fs_down_write fs/f2fs/f2fs.h:2213 [inline]
 #2: ffff88807f9ad4f8 (&sbi->pin_sem){+.+.}-{4:4}, at: f2fs_expand_inode_data+0x430/0xaf0 fs/f2fs/file.c:1839
2 locks held by syz-executor328/6364:
 #0: ffff8880228546b0 (&bdev->bd_fsfreeze_mutex){+.+.}-{4:4}, at: bdev_freeze+0x2a/0x220 block/bdev.c:289
 #1: ffff88807dedc420 (sb_writers#9){++++}-{0:0}, at: sb_wait_write fs/super.c:1855 [inline]
 #1: ffff88807dedc420 (sb_writers#9){++++}-{0:0}, at: freeze_super+0x4c2/0xeb0 fs/super.c:2044
3 locks held by syz-executor328/6374:
 #0: ffff88807dedc420 (sb_writers#9){++++}-{0:0}, at: file_start_write include/linux/fs.h:3041 [inline]
 #0: ffff88807dedc420 (sb_writers#9){++++}-{0:0}, at: vfs_fallocate+0x62a/0x830 fs/open.c:337
 #1: ffff88806d35a508 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:867 [inline]
 #1: ffff88806d35a508 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: f2fs_fallocate+0x24e/0x990 fs/f2fs/file.c:1940
 #2: ffff888079e4d4f8 (&sbi->pin_sem){+.+.}-{4:4}, at: f2fs_down_write fs/f2fs/f2fs.h:2213 [inline]
 #2: ffff888079e4d4f8 (&sbi->pin_sem){+.+.}-{4:4}, at: f2fs_expand_inode_data+0x430/0xaf0 fs/f2fs/file.c:1839
2 locks held by syz-executor328/6379:
 #0: ffff888022855230 (&bdev->bd_fsfreeze_mutex){+.+.}-{4:4}, at: bdev_freeze+0x2a/0x220 block/bdev.c:289
 #1: ffff888033604420 (sb_writers#9){++++}-{0:0}, at: sb_wait_write fs/super.c:1855 [inline]
 #1: ffff888033604420 (sb_writers#9){++++}-{0:0}, at: freeze_super+0x4c2/0xeb0 fs/super.c:2044
3 locks held by syz-executor328/6382:
 #0: ffff888033604420 (sb_writers#9){++++}-{0:0}, at: file_start_write include/linux/fs.h:3041 [inline]
 #0: ffff888033604420 (sb_writers#9){++++}-{0:0}, at: vfs_fallocate+0x62a/0x830 fs/open.c:337
 #1: ffff88806d037578 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:867 [inline]
 #1: ffff88806d037578 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: f2fs_fallocate+0x24e/0x990 fs/f2fs/file.c:1940
 #2: ffff8880286b14f8 (&sbi->pin_sem){+.+.}-{4:4}, at: f2fs_down_write fs/f2fs/f2fs.h:2213 [inline]
 #2: ffff8880286b14f8 (&sbi->pin_sem){+.+.}-{4:4}, at: f2fs_expand_inode_data+0x430/0xaf0 fs/f2fs/file.c:1839

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.15.0-rc6-syzkaller-00208-g3c21441eeffc #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:274 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:437
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5905 Comm: f2fs_gc-7:4 Not tainted 6.15.0-rc6-syzkaller-00208-g3c21441eeffc #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70 kernel/kcov.c:210
Code: 89 fb e8 23 00 00 00 48 8b 3d 5c c3 d5 0b 48 89 de 5b e9 33 41 55 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 48 8b 04 24 65 48 8b 0c 25 08 70 72 92 65 8b 15 18 7f
RSP: 0018:ffffc90004697b90 EFLAGS: 00000206
RAX: ffffffff818dcd2c RBX: ffff88802fa49e00 RCX: 0000000000000000
RDX: ffff88802fa49e00 RSI: 0000000000200000 RDI: 0000000000000000
RBP: 0000000000200000 R08: ffff88803342a007 R09: 1ffff11006685400
R10: dffffc0000000000 R11: ffffed1006685401 R12: ffff88807f9ac000
R13: dffffc0000000000 R14: ffff88802fa49e2c R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8881261f9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f836b5fec18 CR3: 000000000dd38000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 to_kthread kernel/kthread.c:84 [inline]
 kthread_should_stop+0x59/0xf0 kernel/kthread.c:169
 gc_thread_func+0x344/0x2b30 fs/f2fs/gc.c:49
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

