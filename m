Return-Path: <linux-kernel+bounces-728526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 135DBB02985
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 07:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038FC1BC28C4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 05:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8E31FFC46;
	Sat, 12 Jul 2025 05:57:35 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F131624C0
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 05:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752299855; cv=none; b=VwbgQjZPqTJC4HonZLaYCYQG2kod4R4QIo3olKri24AUbrmMNTfsa9hwqqhZY+7Vre10I37oT5uvqHJGJSmLTmFSUK011eCf0HwSm7LnXw9v6fRT4J9MTKGzvQlH8bitP9Lmu85Rw+42glGe1FLBTYet/VOyoMfgfQUbuIF183Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752299855; c=relaxed/simple;
	bh=2qy9otVmXntNHj2feBYWdoJ846zDJuFxReVcTv4d2Pk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hMMEO5gotd4zijKx49JFsQbpDKyb9q8q9DqyogD62CeJN6fMehBejSuQqxXq6FEFCuKMG5EkdnswjxNLa56UoSzU9LL1lsOnH8L4mdDK9yYZtjY7tVTSg0wnfYLBAgUA/SVn46ApTsUsA8eibdHPwPL7C7KcnmsiZSkqttAXNzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86cf753423cso248483539f.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 22:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752299852; x=1752904652;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cPNMrF484Dbfnhhp5tZ0FCQePgb0YtzJfoKVrOiLIJQ=;
        b=Q3R5WQIHX9Tt806Qjn0iIZV8glr2U2Gid0762e1j1x1Zj5ltmtZO4E6AE7Mv0EW5fx
         ecuFp2U9Kp8UF6MzrMUi4xvawGrCc5EsY2eNpEefyfx3GEKztXntjXD4GsM+5H01RruD
         8Nu65DrvNVfLVkFLIxhI2XDxFMfkz6pA3nESwBA/XzMtrivNx4H1UXmSCEx7KhqA2Mw5
         TiVm1wlhBS5qf++Bs0DUDM5RvtIq2/jju6tIb5Nd2bPpDZrC7TGU9Y2L/t+NJUO1+1Ec
         UfkxjiQmZPmmydw08Rhwf0/HkrkkbcPDnVL4ptolFm2yCIvARg3Q+C5aJtsuzZQpcfAE
         ht8g==
X-Forwarded-Encrypted: i=1; AJvYcCUjy+BjjZuAEVoKzKq6PgmGWdQC/Eu0yS49swHtNrZuSrtdU355/D0iNfnvAC4+t8RYB7iCELT+7gaMODc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKjJ68YCPslRqGvK1agAiof9YSXCPXJGNSIL0JGpP2S009Bc08
	Afr0MuB568PEOaph9vJP0Q979eeKv2n25SSrG9yGP6IazfygGmmbuufRfpLe82yMWFE4onA3aRx
	nrUC0fhcfmfOyLyV7Fj/mKO/vcdktdHCATszZHEVZjknlpOGGLi10UnpfVp4=
X-Google-Smtp-Source: AGHT+IEhQ6Af9mYMbBsGH05ipB+JFmzOoRIUn3SWsh9RIbI5r6JbDqM8JaovKNxONp96/IxdZl/OiJT+gnDSseps0MeiuZrkxr3r
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6a96:b0:862:fe54:df4e with SMTP id
 ca18e2360f4ac-879787e2f72mr710785239f.7.1752299851965; Fri, 11 Jul 2025
 22:57:31 -0700 (PDT)
Date: Fri, 11 Jul 2025 22:57:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6871f94b.a00a0220.26a83e.0070.GAE@google.com>
Subject: [syzbot] [mm?] possible deadlock in lock_next_vma
From: syzbot <syzbot+159a3ef1894076a6a6e9@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	shakeel.butt@linux.dev, surenb@google.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    26ffb3d6f02c Add linux-next specific files for 20250704
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12d4df70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e4f88512ae53408
dashboard link: https://syzkaller.appspot.com/bug?extid=159a3ef1894076a6a6e9
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd5569903143/disk-26ffb3d6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1b0c9505c543/vmlinux-26ffb3d6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9d864c72bed1/bzImage-26ffb3d6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+159a3ef1894076a6a6e9@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.16.0-rc4-next-20250704-syzkaller #0 Not tainted
------------------------------------------------------
syz.4.1737/14243 is trying to acquire lock:
ffff88807634d1e0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock_killable include/linux/mmap_lock.h:432 [inline]
ffff88807634d1e0 (&mm->mmap_lock){++++}-{4:4}, at: lock_vma_under_mmap_lock mm/mmap_lock.c:189 [inline]
ffff88807634d1e0 (&mm->mmap_lock){++++}-{4:4}, at: lock_next_vma+0x802/0xdc0 mm/mmap_lock.c:264

but task is already holding lock:
ffff888020b36a88 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x146/0xdc0 mm/mmap_lock.c:220

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (vm_lock){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       __vma_enter_locked+0x182/0x380 mm/mmap_lock.c:63
       __vma_start_write+0x1e/0x120 mm/mmap_lock.c:87
       vma_start_write include/linux/mmap_lock.h:267 [inline]
       mprotect_fixup+0x571/0x9b0 mm/mprotect.c:670
       setup_arg_pages+0x53a/0xaa0 fs/exec.c:670
       load_elf_binary+0xb9f/0x2730 fs/binfmt_elf.c:1013
       search_binary_handler fs/exec.c:1670 [inline]
       exec_binprm fs/exec.c:1702 [inline]
       bprm_execve+0x99c/0x1450 fs/exec.c:1754
       kernel_execve+0x8f0/0x9f0 fs/exec.c:1920
       try_to_run_init_process+0x13/0x60 init/main.c:1397
       kernel_init+0xad/0x1d0 init/main.c:1525
       ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (&mm->mmap_lock){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       down_read_killable+0x50/0x350 kernel/locking/rwsem.c:1547
       mmap_read_lock_killable include/linux/mmap_lock.h:432 [inline]
       lock_vma_under_mmap_lock mm/mmap_lock.c:189 [inline]
       lock_next_vma+0x802/0xdc0 mm/mmap_lock.c:264
       get_next_vma fs/proc/task_mmu.c:182 [inline]
       query_vma_find_by_addr fs/proc/task_mmu.c:516 [inline]
       query_matching_vma+0x28f/0x4b0 fs/proc/task_mmu.c:545
       do_procmap_query fs/proc/task_mmu.c:637 [inline]
       procfs_procmap_ioctl+0x406/0xce0 fs/proc/task_mmu.c:748
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:598 [inline]
       __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:584
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(vm_lock);
                               lock(&mm->mmap_lock);
                               lock(vm_lock);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

2 locks held by syz.4.1737/14243:
 #0: ffff888020b36e48 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x146/0xdc0 mm/mmap_lock.c:220
 #1: ffff888020b36a88 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x146/0xdc0 mm/mmap_lock.c:220

stack backtrace:
CPU: 1 UID: 0 PID: 14243 Comm: syz.4.1737 Not tainted 6.16.0-rc4-next-20250704-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2046
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3168 [inline]
 check_prevs_add kernel/locking/lockdep.c:3287 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
 down_read_killable+0x50/0x350 kernel/locking/rwsem.c:1547
 mmap_read_lock_killable include/linux/mmap_lock.h:432 [inline]
 lock_vma_under_mmap_lock mm/mmap_lock.c:189 [inline]
 lock_next_vma+0x802/0xdc0 mm/mmap_lock.c:264
 get_next_vma fs/proc/task_mmu.c:182 [inline]
 query_vma_find_by_addr fs/proc/task_mmu.c:516 [inline]
 query_matching_vma+0x28f/0x4b0 fs/proc/task_mmu.c:545
 do_procmap_query fs/proc/task_mmu.c:637 [inline]
 procfs_procmap_ioctl+0x406/0xce0 fs/proc/task_mmu.c:748
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f79bc78e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f79bd5c8038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f79bc9b6080 RCX: 00007f79bc78e929
RDX: 0000200000000180 RSI: 00000000c0686611 RDI: 0000000000000006
RBP: 00007f79bc810b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f79bc9b6080 R15: 00007ffcdd82ae18
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

