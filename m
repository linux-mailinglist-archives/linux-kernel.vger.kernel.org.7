Return-Path: <linux-kernel+bounces-596056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D163DA82657
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 15:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE6E1B88322
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 13:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537E725DCEE;
	Wed,  9 Apr 2025 13:33:29 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01708149C64
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744205608; cv=none; b=E7hXYxXiy6D3H9ZJaYYjXSAd69YqEi20ZgN1KEGkeycGtGKQB5AOVjv7u/CXtohpkHDMPTkLEXRcwjpqevOVDim0ZwgabvhMhN5Kt5TsN5mi6RfUhVIvlEzH25HXkMDKjIbVsoDIr60AjzluT/P4rKzq9YVIoCdr//FLx1kv4kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744205608; c=relaxed/simple;
	bh=XmCFDw2N8JTBu8W1qsinMonlyaKJqlYymorQGEckcqU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M6QjSZxbDgdgnpE4Ip/ehh3aBuuP0aDMXkUcP5+Eo1zgWRD5dwk5ncSRwShf6ST9CXneXM5Pqac2jKYDLCdkCp/qgN/HQg6m5FLplG/agq1ZvazdOy1tDF9l7KI0xzFUZ1yVfVg4gdTOB0dPdYq9NpNSjsfQaaD4dvcp4VCGWLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d43621bb7eso7009615ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Apr 2025 06:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744205606; x=1744810406;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbrhkULFZ0N80l8MZVCVmzIIhcWzn8Ju/2/e1cG4Ocs=;
        b=UV3kxvvXj/V9Du/o9JSxjN/AuwY6Zrs+ByBD0r343eLQ5ry14/JRzvODS8rB/SDxX+
         lCyLpQ9RFVfsyqUAl/0DPjPMRhHAcJ8cUTy7gIjsZWsSmclw6gBmUmVxUgghML5PLTLL
         OkjnQ2GkxCuEkFHeKqakcrXmVX7V/YkhRsaugdUIwm5CyvywIo4gpZWpse5Hct1LNkpA
         LY3Nl45dcE0d7ejttu2q1cvVa2fVz5pFdwkK4FAXS7DzK+m795yDxOxTioO8hAngCTHk
         9Gl/Ta2KIEe98+WZyu2h29kvl0SamaMctnWSzOlO80TKQhHwfH0Gccs5vXJS/VhEmndf
         XYuA==
X-Gm-Message-State: AOJu0YwrX9ke1PDUVC+h0zlOiQqYOQV+ubH8YwYhfkgpZoIqVZLPchDj
	crZ6Hww9N6sG+i2ZUJ6AgQEKYsGJJOjW0cJY7T40BxW5gGMfU7aN8HjG32uTsmB5Ih1MlmgLTOj
	m9R9r90waprQAwW3hZ4ES61KSBmBivQYc2XxGEplqbD4QvOUDQMwQC25uCg==
X-Google-Smtp-Source: AGHT+IEE6DjV3r+8OaWb9RqeImpw62k1ZAjG0fnmOrSNGArg6HJ6qbpudcnTBXjQ3uM8brpXo83njYx7QeQYoV0I4ZzQCjXHWgb+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:510:0:b0:3d6:cb49:1e5f with SMTP id
 e9e14a558f8ab-3d703629a67mr67918015ab.2.1744205606165; Wed, 09 Apr 2025
 06:33:26 -0700 (PDT)
Date: Wed, 09 Apr 2025 06:33:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f67726.050a0220.25d1c8.0004.GAE@google.com>
Subject: [syzbot] [trace?] possible deadlock in ring_buffer_resize
From: syzbot <syzbot+b1a3058aa9ba1555eb89@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f867ba24d36 Merge tag '6.15-rc-part2-smb3-client-fixes' o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130a423f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b296730575c90b2a
dashboard link: https://syzkaller.appspot.com/bug?extid=b1a3058aa9ba1555eb89
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/81b34e4e575d/disk-9f867ba2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0984745ca43f/vmlinux-9f867ba2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5364b23e2846/bzImage-9f867ba2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b1a3058aa9ba1555eb89@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.14.0-syzkaller-13408-g9f867ba24d36 #0 Not tainted
------------------------------------------------------
syz.2.506/8033 is trying to acquire lock:
ffffffff8e2643f0 (cpu_hotplug_lock){++++}-{0:0}, at: ring_buffer_resize+0x7ea/0x1560 kernel/trace/ring_buffer.c:2894

but task is already holding lock:
ffff88801b480488 (&buffer->mutex){+.+.}-{4:4}, at: ring_buffer_resize+0x113/0x1560 kernel/trace/ring_buffer.c:2851

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&buffer->mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:746
       ring_buffer_map+0x144/0xa40 kernel/trace/ring_buffer.c:7157
       tracing_buffers_mmap+0x120/0x1c0 kernel/trace/trace.c:8516
       call_mmap include/linux/fs.h:2243 [inline]
       mmap_file mm/internal.h:167 [inline]
       __mmap_new_file_vma mm/vma.c:2310 [inline]
       __mmap_new_vma mm/vma.c:2374 [inline]
       __mmap_region+0x1485/0x27c0 mm/vma.c:2476
       mmap_region+0x1ab/0x3f0 mm/vma.c:2554
       do_mmap+0xd8e/0x11b0 mm/mmap.c:561
       vm_mmap_pgoff+0x281/0x450 mm/util.c:579
       ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:607
       __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
       __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
       __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&cpu_buffer->mapping_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:746
       ring_buffer_map+0xdc/0xa40 kernel/trace/ring_buffer.c:7146
       tracing_buffers_mmap+0x120/0x1c0 kernel/trace/trace.c:8516
       call_mmap include/linux/fs.h:2243 [inline]
       mmap_file mm/internal.h:167 [inline]
       __mmap_new_file_vma mm/vma.c:2310 [inline]
       __mmap_new_vma mm/vma.c:2374 [inline]
       __mmap_region+0x1485/0x27c0 mm/vma.c:2476
       mmap_region+0x1ab/0x3f0 mm/vma.c:2554
       do_mmap+0xd8e/0x11b0 mm/mmap.c:561
       vm_mmap_pgoff+0x281/0x450 mm/util.c:579
       ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:607
       __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
       __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
       __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&mm->mmap_lock){++++}-{4:4}:
       down_read_killable+0x9e/0x4b0 kernel/locking/rwsem.c:1547
       mmap_read_lock_killable include/linux/mmap_lock.h:193 [inline]
       get_mmap_lock_carefully mm/memory.c:6355 [inline]
       lock_mm_and_find_vma+0x3e7/0x6e0 mm/memory.c:6406
       do_user_addr_fault+0x2ac/0x1370 arch/x86/mm/fault.c:1360
       handle_page_fault arch/x86/mm/fault.c:1480 [inline]
       exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1538
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       filldir+0x29c/0x5f0 fs/readdir.c:290
       dir_emit include/linux/fs.h:3861 [inline]
       kernfs_fop_readdir+0x3d5/0x930 fs/kernfs/dir.c:1907
       iterate_dir+0x293/0xb40 fs/readdir.c:108
       __do_sys_getdents fs/readdir.c:322 [inline]
       __se_sys_getdents fs/readdir.c:308 [inline]
       __x64_sys_getdents+0x14d/0x2c0 fs/readdir.c:308
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&root->kernfs_rwsem){++++}-{4:4}:
       down_write+0x92/0x200 kernel/locking/rwsem.c:1577
       kernfs_add_one+0x38/0x840 fs/kernfs/dir.c:791
       kernfs_create_dir_ns+0xfc/0x1a0 fs/kernfs/dir.c:1091
       internal_create_group+0x34d/0xf30 fs/sysfs/group.c:170
       cpuhp_invoke_callback+0x3d2/0xa10 kernel/cpu.c:194
       cpuhp_issue_call+0x1c0/0x980 kernel/cpu.c:2372
       __cpuhp_setup_state_cpuslocked+0x3a1/0x7b0 kernel/cpu.c:2518
       __cpuhp_setup_state+0xf4/0x300 kernel/cpu.c:2547
       do_one_initcall+0x120/0x6e0 init/main.c:1257
       do_initcall_level init/main.c:1319 [inline]
       do_initcalls init/main.c:1335 [inline]
       do_basic_setup init/main.c:1354 [inline]
       kernel_init_freeable+0x5c2/0x900 init/main.c:1567
       kernel_init+0x1c/0x2b0 init/main.c:1457
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (cpuhp_state_mutex){+.+.}-{4:4}:

-> #0 (cpu_hotplug_lock){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3166 [inline]
       check_prevs_add kernel/locking/lockdep.c:3285 [inline]
       validate_chain kernel/locking/lockdep.c:3909 [inline]
       __lock_acquire+0x1173/0x1ba0 kernel/locking/lockdep.c:5235
       lock_acquire kernel/locking/lockdep.c:5866 [inline]
       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
       percpu_down_read include/linux/percpu-rwsem.h:52 [inline]
       cpus_read_lock+0x42/0x160 kernel/cpu.c:490
       ring_buffer_resize+0x7ea/0x1560 kernel/trace/ring_buffer.c:2894
       __tracing_resize_ring_buffer.part.0+0x52/0x1f0 kernel/trace/trace.c:5943
       __tracing_resize_ring_buffer kernel/trace/trace.c:5937 [inline]
       tracing_update_buffers+0x102/0x130 kernel/trace/trace.c:6168
       event_pid_write.isra.0+0xf8/0x7c0 kernel/trace/trace_events.c:2415
       vfs_write+0x25c/0x1180 fs/read_write.c:682
       ksys_write+0x12a/0x240 fs/read_write.c:736
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  cpu_hotplug_lock --> &cpu_buffer->mapping_lock --> &buffer->mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&buffer->mutex);
                               lock(&cpu_buffer->mapping_lock);
                               lock(&buffer->mutex);
  rlock(cpu_hotplug_lock);

 *** DEADLOCK ***

4 locks held by syz.2.506/8033:
 #0: ffff88807cd2a0f8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2a2/0x370 fs/file.c:1213
 #1: ffff888145eba420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12a/0x240 fs/read_write.c:736
 #2: ffffffff8e4451a8 (trace_types_lock){+.+.}-{4:4}, at: tracing_update_buffers+0x1e/0x130 kernel/trace/trace.c:6163
 #3: ffff88801b480488 (&buffer->mutex){+.+.}-{4:4}, at: ring_buffer_resize+0x113/0x1560 kernel/trace/ring_buffer.c:2851

stack backtrace:
CPU: 0 UID: 0 PID: 8033 Comm: syz.2.506 Not tainted 6.14.0-syzkaller-13408-g9f867ba24d36 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2079
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2211
 check_prev_add kernel/locking/lockdep.c:3166 [inline]
 check_prevs_add kernel/locking/lockdep.c:3285 [inline]
 validate_chain kernel/locking/lockdep.c:3909 [inline]
 __lock_acquire+0x1173/0x1ba0 kernel/locking/lockdep.c:5235
 lock_acquire kernel/locking/lockdep.c:5866 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
 percpu_down_read include/linux/percpu-rwsem.h:52 [inline]
 cpus_read_lock+0x42/0x160 kernel/cpu.c:490
 ring_buffer_resize+0x7ea/0x1560 kernel/trace/ring_buffer.c:2894
 __tracing_resize_ring_buffer.part.0+0x52/0x1f0 kernel/trace/trace.c:5943
 __tracing_resize_ring_buffer kernel/trace/trace.c:5937 [inline]
 tracing_update_buffers+0x102/0x130 kernel/trace/trace.c:6168
 event_pid_write.isra.0+0xf8/0x7c0 kernel/trace/trace_events.c:2415
 vfs_write+0x25c/0x1180 fs/read_write.c:682
 ksys_write+0x12a/0x240 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb813f8d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb811df6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fb8141a6320 RCX: 00007fb813f8d169
RDX: 0000000000000001 RSI: 0000200000001240 RDI: 0000000000000006
RBP: 00007fb81400e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb8141a6320 R15: 00007ffde8fb74c8
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

