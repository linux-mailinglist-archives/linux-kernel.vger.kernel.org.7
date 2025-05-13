Return-Path: <linux-kernel+bounces-645131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA289AB4957
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 04:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186FB3B825D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 02:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E49C1A2391;
	Tue, 13 May 2025 02:14:31 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AE31A7044
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 02:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747102470; cv=none; b=OR+dlkk8sw3VfMZbZ2Zmgu1Lbze+hlOj+DtTYJOwR+36xQ6cttYQNlrDtaLDsFv+VIxp57Y6LVMQJVZhjgtXS4ZTM6RTkf5jmWsKgvTemvnvBUoPAVMlUO2B7+0va9rx2LbOsKj0GHPPzyegL400P6e0esEtwC7Tj2ikug3eQXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747102470; c=relaxed/simple;
	bh=ieor3tLUVFxTnjlpkxp2nBfoSp2nUKu7NDxY9Ou46E4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=j7s5YkACDYe9Zm+nLHvHBoU+OqXnSgAuZ1F7lmBUHxhhTUfhAlnYq2htqPL2IKnNhMYNHebncKsBOmqDsJt2FD7y1y4AIiQazLFjTGZJFdayWNU57lxU9n5ZhDFFEjEUs3R5+6vyrZRm1cBQSbpjlI4O6bL4KJSCQWHumBnpCkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d90ba11afcso58127575ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 19:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747102466; x=1747707266;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kO4Jl/o7NJi0wFJPRurmXgjfPaKYJsRjlw2GZSDQy+E=;
        b=J864KxB4Vj+6dwfeZIskn3nvsAYHNjRVw4I1zkpaTMzZrZio8FptleyRCXw+1vnP04
         qJ+Su1f32xRxz7UQZCfmI9g1ikpPed/r8KegND1R5gATHnDhxAe73gpQN0Hzk9nfqXzV
         moMopAvj1+QgmcW9hZIAfg+o66iogljPvKzPgJ5KD6qXxdqH4NBm5BIF59CKTgdgNwCZ
         C4XKP/sCpvd/LWVZ86n3/u9zcziO+KfYPEE4KB+fyWLDAlV2Md7kpP4YHIq3rfvJkKHv
         +N0OLqCrnziumtm3pMKU4i4NuNYBKWxTNYYcIOSseaOw0UHISrwDDK75CC2mOtkcPvp9
         /4Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUuYNMR3hGa09WjQRdYxjHMKfNCWOGTlT+cye5AmwHci9GnVFQTyGR1YwPgAeXVOu29nyddjd6Qq45JQds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdR2LPiEqgZ+T9RE6S0sGy1APUAlJJkvFQOMScBkTg2Jl4BJWx
	9pBA+wJxcFMqsKXehxesU6dVByauAqhb9vSvyVwTos10FhgusHcTXDMo4g98xL9LVzF3P/1hnXx
	we8GsTjXlYKEz3K3xbNg3r4ac3IcNEAzVXf/H9iSiX6MUKW5B+hwMVKQ=
X-Google-Smtp-Source: AGHT+IH/QjShxlwUHaM/RREZP0ThnKVN3767LeOTQdPfCtfCtTt/5Cy+DhZEVPICLMHATNP1a13QnmKvnHi+8oHNea43DB4ApVr9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4513:b0:3d8:2032:ca67 with SMTP id
 e9e14a558f8ab-3da7e1e762bmr127904315ab.9.1747102466220; Mon, 12 May 2025
 19:14:26 -0700 (PDT)
Date: Mon, 12 May 2025 19:14:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6822ab02.050a0220.f2294.00cb.GAE@google.com>
Subject: [syzbot] [bcachefs?] possible deadlock in __bch2_fsck_err (2)
From: syzbot <syzbot+2c3ef91c9523c3d1a25c@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c32f8dc5aaf9 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10a7b4f4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea4635ffd6ad5b4a
dashboard link: https://syzkaller.appspot.com/bug?extid=2c3ef91c9523c3d1a25c
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1385f4f4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f694d4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b921498959d4/disk-c32f8dc5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/04e6ad946c4b/vmlinux-c32f8dc5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d4f0d8db50ee/Image-c32f8dc5.gz.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/bef5d39edee9/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/ae8072e17390/mount_8.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2c3ef91c9523c3d1a25c@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.15.0-rc5-syzkaller-gc32f8dc5aaf9 #0 Not tainted
------------------------------------------------------
kworker/u8:5/201 is trying to acquire lock:
ffff80008f4edda0 (console_lock){+.+.}-{0:0}, at: __bch2_print_string_as_lines fs/bcachefs/util.c:267 [inline]
ffff80008f4edda0 (console_lock){+.+.}-{0:0}, at: bch2_print_string_as_lines+0x34/0x150 fs/bcachefs/util.c:286

but task is already holding lock:
ffff0000ebae1448 (&c->fsck_error_msgs_lock){+.+.}-{4:4}, at: __bch2_fsck_err+0x370/0xdd0 fs/bcachefs/error.c:455

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #9 (&c->fsck_error_msgs_lock){+.+.}-{4:4}:
       __mutex_lock_common+0x1d0/0x2190 kernel/locking/mutex.c:601
       __mutex_lock kernel/locking/mutex.c:746 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:798
       __bch2_count_fsck_err+0x58/0x98 fs/bcachefs/error.c:385
       __bch2_i_sectors_acct+0x328/0x3c4 fs/bcachefs/fs-io.c:155
       bch2_i_sectors_acct fs/bcachefs/fs-io.h:138 [inline]
       bchfs_truncate+0x684/0xa70 fs/bcachefs/fs-io.c:510
       bch2_setattr+0x198/0x20c fs/bcachefs/fs.c:1245
       notify_change+0x9a4/0xc50 fs/attr.c:552
       do_truncate+0x178/0x1f0 fs/open.c:65
       handle_truncate fs/namei.c:3501 [inline]
       do_open fs/namei.c:3884 [inline]
       path_openat+0x25a0/0x2c40 fs/namei.c:4039
       do_filp_open+0x18c/0x36c fs/namei.c:4066
       do_sys_openat2+0x11c/0x1b4 fs/open.c:1429
       do_sys_open fs/open.c:1444 [inline]
       __do_sys_openat fs/open.c:1460 [inline]
       __se_sys_openat fs/open.c:1455 [inline]
       __arm64_sys_openat+0x120/0x158 fs/open.c:1455
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x58/0x17c arch/arm64/kernel/entry-common.c:767
       el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:786
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

-> #8 (&inode->ei_quota_lock){+.+.}-{4:4}:
       __mutex_lock_common+0x1d0/0x2190 kernel/locking/mutex.c:601
       __mutex_lock kernel/locking/mutex.c:746 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:798
       bch2_quota_reservation_add fs/bcachefs/fs-io.h:97 [inline]
       __bch2_folio_reservation_get+0x5c0/0xa00 fs/bcachefs/fs-io-pagecache.c:460
       bch2_folio_reservation_get fs/bcachefs/fs-io-pagecache.c:477 [inline]
       bch2_page_mkwrite+0xa48/0xd60 fs/bcachefs/fs-io-pagecache.c:637
       do_page_mkwrite+0x138/0x2b8 mm/memory.c:3287
       wp_page_shared mm/memory.c:3688 [inline]
       do_wp_page+0x1b54/0x43a8 mm/memory.c:3907
       handle_pte_fault mm/memory.c:6013 [inline]
       __handle_mm_fault mm/memory.c:6140 [inline]
       handle_mm_fault+0x1064/0x4cec mm/memory.c:6309
       do_page_fault+0x428/0x1554 arch/arm64/mm/fault.c:647
       do_mem_abort+0x70/0x194 arch/arm64/mm/fault.c:919
       el0_da+0x64/0x160 arch/arm64/kernel/entry-common.c:627
       el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:789
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

-> #7 (sb_pagefaults){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:52 [inline]
       __sb_start_write include/linux/fs.h:1783 [inline]
       sb_start_pagefault include/linux/fs.h:1948 [inline]
       bch2_page_mkwrite+0x260/0xd60 fs/bcachefs/fs-io-pagecache.c:614
       do_page_mkwrite+0x138/0x2b8 mm/memory.c:3287
       wp_page_shared mm/memory.c:3688 [inline]
       do_wp_page+0x1b54/0x43a8 mm/memory.c:3907
       handle_pte_fault mm/memory.c:6013 [inline]
       __handle_mm_fault mm/memory.c:6140 [inline]
       handle_mm_fault+0x1064/0x4cec mm/memory.c:6309
       do_page_fault+0x428/0x1554 arch/arm64/mm/fault.c:647
       do_mem_abort+0x70/0x194 arch/arm64/mm/fault.c:919
       el0_da+0x64/0x160 arch/arm64/kernel/entry-common.c:627
       el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:789
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

-> #6 (vm_lock){++++}-{0:0}:
       __vma_enter_locked+0x184/0x354 mm/memory.c:6473
       __vma_start_write+0x34/0x158 mm/memory.c:6497
       vma_start_write include/linux/mm.h:829 [inline]
       vma_expand+0x1b8/0x8f0 mm/vma.c:1086
       relocate_vma_down+0x234/0x400 mm/mmap.c:1767
       setup_arg_pages+0x4b4/0x920 fs/exec.c:800
       load_elf_binary+0x8c4/0x1ebc fs/binfmt_elf.c:1019
       search_binary_handler fs/exec.c:1778 [inline]
       exec_binprm fs/exec.c:1810 [inline]
       bprm_execve+0x77c/0x10dc fs/exec.c:1862
       kernel_execve+0x70c/0x7f4 fs/exec.c:2028
       run_init_process+0x1bc/0x1ec init/main.c:1378
       try_to_run_init_process+0x20/0x7c init/main.c:1385
       kernel_init+0xa8/0x1dc init/main.c:1513
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847

-> #5 (&mm->mmap_lock){++++}-{4:4}:
       __might_fault+0xc4/0x124 mm/memory.c:7151
       drm_mode_object_get_properties+0x1f0/0x524 drivers/gpu/drm/drm_mode_object.c:407
       drm_mode_getconnector+0xd78/0x1254 drivers/gpu/drm/drm_connector.c:3399
       drm_ioctl_kernel+0x238/0x310 drivers/gpu/drm/drm_ioctl.c:796
       drm_ioctl+0x65c/0xa5c drivers/gpu/drm/drm_ioctl.c:893
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __arm64_sys_ioctl+0x14c/0x1c4 fs/ioctl.c:892
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x58/0x17c arch/arm64/kernel/entry-common.c:767
       el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:786
       el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

-> #4 (crtc_ww_class_mutex){+.+.}-{4:4}:
       ww_acquire_init include/linux/ww_mutex.h:162 [inline]
       drm_modeset_acquire_init+0x1d8/0x374 drivers/gpu/drm/drm_modeset_lock.c:250
       drmm_mode_config_init+0xb0c/0x10d8 drivers/gpu/drm/drm_mode_config.c:462
       vkms_modeset_init drivers/gpu/drm/vkms/vkms_drv.c:146 [inline]
       vkms_create drivers/gpu/drm/vkms/vkms_drv.c:207 [inline]
       vkms_init+0x2c0/0x5ac drivers/gpu/drm/vkms/vkms_drv.c:242
       do_one_initcall+0x250/0x990 init/main.c:1257
       do_initcall_level+0x154/0x214 init/main.c:1319
       do_initcalls+0x84/0xf4 init/main.c:1335
       do_basic_setup+0x8c/0xa0 init/main.c:1354
       kernel_init_freeable+0x2dc/0x444 init/main.c:1567
       kernel_init+0x24/0x1dc init/main.c:1457
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847

-> #3 (crtc_ww_class_acquire){+.+.}-{0:0}:
       ww_acquire_init include/linux/ww_mutex.h:161 [inline]
       drm_modeset_acquire_init+0x1b8/0x374 drivers/gpu/drm/drm_modeset_lock.c:250
       drm_client_modeset_commit_atomic+0xcc/0x6ac drivers/gpu/drm/drm_client_modeset.c:1018
       drm_client_modeset_commit_locked+0xd0/0x4a0 drivers/gpu/drm/drm_client_modeset.c:1182
       drm_client_modeset_commit+0x50/0x7c drivers/gpu/drm/drm_client_modeset.c:1208
       __drm_fb_helper_restore_fbdev_mode_unlocked+0x94/0x198 drivers/gpu/drm/drm_fb_helper.c:237
       drm_fb_helper_set_par+0xa4/0x108 drivers/gpu/drm/drm_fb_helper.c:1359
       fbcon_init+0xe4c/0x1d18 drivers/video/fbdev/core/fbcon.c:1112
       visual_init+0x27c/0x540 drivers/tty/vt/vt.c:1011
       do_bind_con_driver+0x7b8/0xdd8 drivers/tty/vt/vt.c:3831
       do_take_over_console+0x824/0x97c drivers/tty/vt/vt.c:4397
       do_fbcon_takeover+0x158/0x25c drivers/video/fbdev/core/fbcon.c:548
       do_fb_registered drivers/video/fbdev/core/fbcon.c:2989 [inline]
       fbcon_fb_registered+0x354/0x4c8 drivers/video/fbdev/core/fbcon.c:3009
       do_register_framebuffer drivers/video/fbdev/core/fbmem.c:449 [inline]
       register_framebuffer+0x44c/0x5ec drivers/video/fbdev/core/fbmem.c:515
       __drm_fb_helper_initial_config_and_unlock+0x103c/0x159c drivers/gpu/drm/drm_fb_helper.c:1851
       drm_fb_helper_initial_config+0x3c/0x58 drivers/gpu/drm/drm_fb_helper.c:1916
       drm_fbdev_client_hotplug+0x154/0x22c drivers/gpu/drm/clients/drm_fbdev_client.c:52
       drm_client_register+0x13c/0x1d4 drivers/gpu/drm/drm_client.c:140
       drm_fbdev_client_setup+0x194/0x3d0 drivers/gpu/drm/clients/drm_fbdev_client.c:159
       drm_client_setup+0x78/0x140 drivers/gpu/drm/clients/drm_client_setup.c:39
       vkms_create drivers/gpu/drm/vkms/vkms_drv.c:218 [inline]
       vkms_init+0x4b8/0x5ac drivers/gpu/drm/vkms/vkms_drv.c:242
       do_one_initcall+0x250/0x990 init/main.c:1257
       do_initcall_level+0x154/0x214 init/main.c:1319
       do_initcalls+0x84/0xf4 init/main.c:1335
       do_basic_setup+0x8c/0xa0 init/main.c:1354
       kernel_init_freeable+0x2dc/0x444 init/main.c:1567
       kernel_init+0x24/0x1dc init/main.c:1457
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847

-> #2 (&client->modeset_mutex){+.+.}-{4:4}:
       __mutex_lock_common+0x1d0/0x2190 kernel/locking/mutex.c:601
       __mutex_lock kernel/locking/mutex.c:746 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:798
       drm_client_modeset_probe+0x2f0/0x4e88 drivers/gpu/drm/drm_client_modeset.c:843
       __drm_fb_helper_initial_config_and_unlock+0xf0/0x159c drivers/gpu/drm/drm_fb_helper.c:1828
       drm_fb_helper_initial_config+0x3c/0x58 drivers/gpu/drm/drm_fb_helper.c:1916
       drm_fbdev_client_hotplug+0x154/0x22c drivers/gpu/drm/clients/drm_fbdev_client.c:52
       drm_client_register+0x13c/0x1d4 drivers/gpu/drm/drm_client.c:140
       drm_fbdev_client_setup+0x194/0x3d0 drivers/gpu/drm/clients/drm_fbdev_client.c:159
       drm_client_setup+0x78/0x140 drivers/gpu/drm/clients/drm_client_setup.c:39
       vkms_create drivers/gpu/drm/vkms/vkms_drv.c:218 [inline]
       vkms_init+0x4b8/0x5ac drivers/gpu/drm/vkms/vkms_drv.c:242
       do_one_initcall+0x250/0x990 init/main.c:1257
       do_initcall_level+0x154/0x214 init/main.c:1319
       do_initcalls+0x84/0xf4 init/main.c:1335
       do_basic_setup+0x8c/0xa0 init/main.c:1354
       kernel_init_freeable+0x2dc/0x444 init/main.c:1567
       kernel_init+0x24/0x1dc init/main.c:1457
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847

-> #1 (&helper->lock){+.+.}-{4:4}:
       __mutex_lock_common+0x1d0/0x2190 kernel/locking/mutex.c:601
       __mutex_lock kernel/locking/mutex.c:746 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:798
       __drm_fb_helper_restore_fbdev_mode_unlocked+0x74/0x198 drivers/gpu/drm/drm_fb_helper.c:228
       drm_fb_helper_set_par+0xa4/0x108 drivers/gpu/drm/drm_fb_helper.c:1359
       fbcon_init+0xe4c/0x1d18 drivers/video/fbdev/core/fbcon.c:1112
       visual_init+0x27c/0x540 drivers/tty/vt/vt.c:1011
       do_bind_con_driver+0x7b8/0xdd8 drivers/tty/vt/vt.c:3831
       do_take_over_console+0x824/0x97c drivers/tty/vt/vt.c:4397
       do_fbcon_takeover+0x158/0x25c drivers/video/fbdev/core/fbcon.c:548
       do_fb_registered drivers/video/fbdev/core/fbcon.c:2989 [inline]
       fbcon_fb_registered+0x354/0x4c8 drivers/video/fbdev/core/fbcon.c:3009
       do_register_framebuffer drivers/video/fbdev/core/fbmem.c:449 [inline]
       register_framebuffer+0x44c/0x5ec drivers/video/fbdev/core/fbmem.c:515
       __drm_fb_helper_initial_config_and_unlock+0x103c/0x159c drivers/gpu/drm/drm_fb_helper.c:1851
       drm_fb_helper_initial_config+0x3c/0x58 drivers/gpu/drm/drm_fb_helper.c:1916
       drm_fbdev_client_hotplug+0x154/0x22c drivers/gpu/drm/clients/drm_fbdev_client.c:52
       drm_client_register+0x13c/0x1d4 drivers/gpu/drm/drm_client.c:140
       drm_fbdev_client_setup+0x194/0x3d0 drivers/gpu/drm/clients/drm_fbdev_client.c:159
       drm_client_setup+0x78/0x140 drivers/gpu/drm/clients/drm_client_setup.c:39
       vkms_create drivers/gpu/drm/vkms/vkms_drv.c:218 [inline]
       vkms_init+0x4b8/0x5ac drivers/gpu/drm/vkms/vkms_drv.c:242
       do_one_initcall+0x250/0x990 init/main.c:1257
       do_initcall_level+0x154/0x214 init/main.c:1319
       do_initcalls+0x84/0xf4 init/main.c:1335
       do_basic_setup+0x8c/0xa0 init/main.c:1354
       kernel_init_freeable+0x2dc/0x444 init/main.c:1567
       kernel_init+0x24/0x1dc init/main.c:1457
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847

-> #0 (console_lock){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3166 [inline]
       check_prevs_add kernel/locking/lockdep.c:3285 [inline]
       validate_chain kernel/locking/lockdep.c:3909 [inline]
       __lock_acquire+0x1728/0x3058 kernel/locking/lockdep.c:5235
       lock_acquire+0x14c/0x2e0 kernel/locking/lockdep.c:5866
       console_lock+0x194/0x1ec kernel/printk/printk.c:2849
       __bch2_print_string_as_lines fs/bcachefs/util.c:267 [inline]
       bch2_print_string_as_lines+0x34/0x150 fs/bcachefs/util.c:286
       __bch2_fsck_err+0xb5c/0xdd0 fs/bcachefs/error.c:562
       __need_discard_or_freespace_err+0x14c/0x1cc fs/bcachefs/alloc_background.c:678
       bch2_bucket_do_index+0x320/0x490 fs/bcachefs/alloc_background.c:729
       bch2_trigger_alloc+0xd1c/0x2d54 fs/bcachefs/alloc_background.c:885
       bch2_key_trigger fs/bcachefs/bkey_methods.h:88 [inline]
       bch2_key_trigger_new fs/bcachefs/bkey_methods.h:116 [inline]
       run_one_trans_trigger fs/bcachefs/btree_trans_commit.c:516 [inline]
       bch2_trans_commit_run_triggers fs/bcachefs/btree_trans_commit.c:550 [inline]
       __bch2_trans_commit+0x634/0x62d0 fs/bcachefs/btree_trans_commit.c:990
       bch2_trans_commit fs/bcachefs/btree_update.h:195 [inline]
       btree_update_nodes_written fs/bcachefs/btree_update_interior.c:705 [inline]
       btree_interior_update_work+0xb80/0x1cfc fs/bcachefs/btree_update_interior.c:843
       process_one_work+0x7e8/0x156c kernel/workqueue.c:3238
       process_scheduled_works kernel/workqueue.c:3319 [inline]
       worker_thread+0x958/0xed8 kernel/workqueue.c:3400
       kthread+0x5fc/0x75c kernel/kthread.c:464
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847

other info that might help us debug this:

Chain exists of:
  console_lock --> &inode->ei_quota_lock --> &c->fsck_error_msgs_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&c->fsck_error_msgs_lock);
                               lock(&inode->ei_quota_lock);
                               lock(&c->fsck_error_msgs_lock);
  lock(console_lock);

 *** DEADLOCK ***

5 locks held by kworker/u8:5/201:
 #0: ffff0000d985d948 ((wq_completion)btree_update#5){+.+.}-{0:0}, at: process_one_work+0x658/0x156c kernel/workqueue.c:3212
 #1: ffff80009b8d7bc0 ((work_completion)(&c->btree_interior_update_work)){+.+.}-{0:0}, at: process_one_work+0x6ec/0x156c kernel/workqueue.c:3212
 #2: ffff0000eba84228 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_lock_acquire+0x18/0x54 include/linux/srcu.h:160
 #3: ffff0000cf2bc140 (bcachefs_btree){+.+.}-{0:0}, at: trans_set_locked+0x68/0x200 fs/bcachefs/btree_locking.h:197
 #4: ffff0000ebae1448 (&c->fsck_error_msgs_lock){+.+.}-{4:4}, at: __bch2_fsck_err+0x370/0xdd0 fs/bcachefs/error.c:455

stack backtrace:
CPU: 1 UID: 0 PID: 201 Comm: kworker/u8:5 Not tainted 6.15.0-rc5-syzkaller-gc32f8dc5aaf9 #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: btree_update btree_interior_update_work
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 print_circular_bug+0x324/0x32c kernel/locking/lockdep.c:2079
 check_noncircular+0x154/0x174 kernel/locking/lockdep.c:2211
 check_prev_add kernel/locking/lockdep.c:3166 [inline]
 check_prevs_add kernel/locking/lockdep.c:3285 [inline]
 validate_chain kernel/locking/lockdep.c:3909 [inline]
 __lock_acquire+0x1728/0x3058 kernel/locking/lockdep.c:5235
 lock_acquire+0x14c/0x2e0 kernel/locking/lockdep.c:5866
 console_lock+0x194/0x1ec kernel/printk/printk.c:2849
 __bch2_print_string_as_lines fs/bcachefs/util.c:267 [inline]
 bch2_print_string_as_lines+0x34/0x150 fs/bcachefs/util.c:286
 __bch2_fsck_err+0xb5c/0xdd0 fs/bcachefs/error.c:562
 __need_discard_or_freespace_err+0x14c/0x1cc fs/bcachefs/alloc_background.c:678
 bch2_bucket_do_index+0x320/0x490 fs/bcachefs/alloc_background.c:729
 bch2_trigger_alloc+0xd1c/0x2d54 fs/bcachefs/alloc_background.c:885
 bch2_key_trigger fs/bcachefs/bkey_methods.h:88 [inline]
 bch2_key_trigger_new fs/bcachefs/bkey_methods.h:116 [inline]
 run_one_trans_trigger fs/bcachefs/btree_trans_commit.c:516 [inline]
 bch2_trans_commit_run_triggers fs/bcachefs/btree_trans_commit.c:550 [inline]
 __bch2_trans_commit+0x634/0x62d0 fs/bcachefs/btree_trans_commit.c:990
 bch2_trans_commit fs/bcachefs/btree_update.h:195 [inline]
 btree_update_nodes_written fs/bcachefs/btree_update_interior.c:705 [inline]
 btree_interior_update_work+0xb80/0x1cfc fs/bcachefs/btree_update_interior.c:843
 process_one_work+0x7e8/0x156c kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3400
 kthread+0x5fc/0x75c kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847
bcachefs (loop2): bucket incorrectly unset in freespace btree
  u64s 5 type deleted 0:1:0 len 0 ver 0, , continuing
bcachefs (loop2): bucket incorrectly unset in freespace btree
  u64s 5 type deleted 0:4:0 len 0 ver 0, , continuing
bcachefs (loop2): bucket incorrectly unset in freespace btree
  u64s 5 type deleted 0:6:0 len 0 ver 0, , continuing
bcachefs (loop2): bucket incorrectly unset in freespace btree
  u64s 5 type deleted 0:9:0 len 0 ver 0, , continuing
bcachefs (loop0): bucket incorrectly unset in freespace btree
  u64s 5 type deleted 0:1:0 len 0 ver 0, , continuing
bcachefs (loop0): bucket incorrectly unset in freespace btree
  u64s 5 type deleted 0:4:0 len 0 ver 0, , continuing
bcachefs (loop0): bucket incorrectly unset in freespace btree
  u64s 5 type deleted 0:6:0 len 0 ver 0, , continuing
bcachefs (loop0): bucket incorrectly unset in freespace btree
  u64s 5 type deleted 0:9:0 len 0 ver 0, , continuing


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

