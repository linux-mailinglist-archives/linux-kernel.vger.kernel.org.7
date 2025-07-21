Return-Path: <linux-kernel+bounces-739775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11529B0CAC3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 622477A80B6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538982206AC;
	Mon, 21 Jul 2025 18:59:39 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1A321FF2B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753124378; cv=none; b=n1tCY6ddWG3+lt/EdIgBmpFSYmru13q995NJVP8KzutnGCnmdYV1azUjQA8kkH2l1mxzK9ni/0MKROHlbBEltmWoN9+7RoBTYn+ujVtZxJYfmPB/20H9/TeY22fRE0IXHonX0vcpK5ue4lLVW6dzivtI/vI+jwwNU2kLxLrbtfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753124378; c=relaxed/simple;
	bh=Jfy5oeMjUGLIxY8R0unm69yWGmWYKR8kObgK09IF2n0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YCyERJ8qrna2rm2Msc3enkx4e1zenFSZZpHXLIwVj0Ed5Dd+kDvosTz+zxqdLxah/7Rb1dwn/Lbgf20lhUebfrFu8+gRYcWIbspiI6ro1R9ejTihHcbkNHtYMpvF2xRy3vIUMELfa52gISehSD5NIXcNk0+Yh771D/ZFAJZvYTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ddcc7e8266so56764245ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753124376; x=1753729176;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lC1NO+QHE3JoNsX8SEduqBmFcMzFfGB22ebkEkfngU=;
        b=K7Bbwf60LEROnBcurGVOTCPHpe7qxINqVvUdIW59ayXo46aaizpEw5vNSxtgZpu/5m
         Uzu7zH94BmuJYniBgbCmYpPhfCaoetmRc53md4aGusVz5HCkBhcfAHtBIvCGKcaeLacS
         VFx/LkROylTYGYrlDyk9oNAwnQzWs08J64davzFak4eETjx39SOzCDhTA7Axh/UU1vPu
         wHO0Thht0indPiEMfFvVSIhwyLt9B3nRoip0QFaUpIMl88ZobUbQxDrrS8LajZn4wzPY
         l5gY3x84mHuOftF+mZHhGPVLVUtP9qg68LApz9FLUv4KW0khsjrELrg/9KGRg++iWgAh
         v/ag==
X-Forwarded-Encrypted: i=1; AJvYcCWhL0Nv3ebliIoJSkmDbG4RVhfX15vzXF7cF4/JbBUS0REzNxWB+Pyp4ITDlFclEZPhTNLlYCj/0aD7xSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfGuT42JT9qXxYemjqWnamXePMmgrb75CWNKWEp+O3abjyecJm
	EzoqyQ9dcEyhiRIaypOExUhKNVkD7A7YOR+nZYzv/axeyc+w6ql4hDho+/fmhGcUyRnJ1gCqm89
	FqYSRdAzJIHJdp2HhuPi6gY6kyZwvSiecRxlDVEbtEbxaZmZbHh9pLU1ztWc=
X-Google-Smtp-Source: AGHT+IF5PIhF47vvN7O7wg1C2Q8ye9iG5AsvwYBuTDYtUmhylAVzD7CKlPGLYK5T6vngDSyCHOvnF0DMur2XdtjCMK6D8zm0Aqt4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cd:b0:3e2:9b05:d1e6 with SMTP id
 e9e14a558f8ab-3e2be732317mr9735915ab.8.1753124376451; Mon, 21 Jul 2025
 11:59:36 -0700 (PDT)
Date: Mon, 21 Jul 2025 11:59:36 -0700
In-Reply-To: <68794b99.a70a0220.693ce.0053.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687e8e18.a70a0220.693ce.00f4.GAE@google.com>
Subject: Re: [syzbot] [kernel?] KMSAN: kernel-infoleak in do_insn_ioctl
From: syzbot <syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, hsweeten@visionengravers.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    89be9a83ccf1 Linux 6.16-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=172b7722580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7753c32e11ff6a95
dashboard link: https://syzkaller.appspot.com/bug?extid=a5e45f768aab5892da5d
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13358fd4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146fc4f0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d81be8d18fda/disk-89be9a83.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/00dac9042245/vmlinux-89be9a83.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0d63e27252f4/bzImage-89be9a83.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak-after-free in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak-after-free in _inline_copy_to_user include/linux/uaccess.h:196 [inline]
BUG: KMSAN: kernel-infoleak-after-free in _copy_to_user+0xcc/0x120 lib/usercopy.c:26
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 _inline_copy_to_user include/linux/uaccess.h:196 [inline]
 _copy_to_user+0xcc/0x120 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:225 [inline]
 do_insn_ioctl+0x59c/0x6d0 drivers/comedi/comedi_fops.c:1661
 comedi_unlocked_ioctl+0x1432/0x1e80 drivers/comedi/comedi_fops.c:2286
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0x23c/0x400 fs/ioctl.c:893
 __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:893
 x64_sys_call+0x1ebe/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_free_hook mm/slub.c:2307 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x252/0xec0 mm/slub.c:4842
 put_css_set_locked+0xf5c/0x1440 kernel/cgroup/cgroup.c:971
 cgroup_migrate_finish+0x1d0/0x7c0 kernel/cgroup/cgroup.c:2758
 cgroup_attach_task+0x6ec/0x970 kernel/cgroup/cgroup.c:2957
 __cgroup1_procs_write+0x4ba/0x670 kernel/cgroup/cgroup-v1.c:528
 cgroup1_procs_write+0x44/0x60 kernel/cgroup/cgroup-v1.c:541
 cgroup_file_write+0x38d/0x920 kernel/cgroup/cgroup.c:4183
 kernfs_fop_write_iter+0x545/0x9e0 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0xb4b/0x1580 fs/read_write.c:686
 ksys_write fs/read_write.c:738 [inline]
 __do_sys_write fs/read_write.c:749 [inline]
 __se_sys_write fs/read_write.c:746 [inline]
 __x64_sys_write+0x1fb/0x4d0 fs/read_write.c:746
 x64_sys_call+0x38c3/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Bytes 4-59 of 60 are uninitialized
Memory access of size 60 starts at ffff88804acc6380
Data copied to user address 0000200000000080

CPU: 0 UID: 0 PID: 6052 Comm: syz.0.16 Not tainted 6.16.0-rc7-syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

