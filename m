Return-Path: <linux-kernel+bounces-754772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58133B19C53
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60AE03AFACB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 07:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07B8235045;
	Mon,  4 Aug 2025 07:18:39 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C417B215073
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754291919; cv=none; b=gQCODhPqzEBvOq2bPLW58sVn1cQc0my43xdWroHaVSj3r/30QIQPbn/K0Erz29VhC8w4SFI1NoKA7YaRRXmnCBtirQB0ffflZ27vFr89u5yPtggkT0GgWbANA2xD4zDovswUPM4Y3mpKRoTF6yA9ojUI/KcfsMQNVmJ2iEMsT18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754291919; c=relaxed/simple;
	bh=ZjCuUiyTzpd3UeODtecLVlTigMekhPys+29NLLlNW3w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XlTZcJUBAS93k7+4s3emCMRbXOMZ9xImOexIs/Q2uwxweF66BQ9MW0MQUEHiTgt3BfhjcbdfQvlYyLhtl1aFnmJMtZ8K6hscz0LFUNYxkPVvgD/gs4Ysey993/BEnmMFFHpmYP7C9uXcFMTOUAdfppwywpAYI3ntNR1BJpfmK2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-88170a3e085so131568439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 00:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754291916; x=1754896716;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z17DyzNxPkiI2YUZz4soZreG//rdEQjseJD0Rw+gpoo=;
        b=xIJaaEnJr7YvVgOiLxQiCLRQw679IfEBL7mxMQTSuPnj+47VkD/kArz0nt2KHzFFEO
         ITEJSOltnY/9rQ3zzDGe1wGwc6+dG5apfWgTYbL4HMNw3KJYBuCHK7Y4c60TE4qcttG2
         tcfhIBup474vRoOVbJDfOWkpOJ6lBN7z5EsbzV2OJGG+lW9iuu5CBjEi/WbiDDWv1+JN
         iHBJfbgSF+vT3ABOHnqArOj+NzNtKjmJ63zSED8ScDZe3v35ZVvHweB/qJxI/2nwT8+e
         dp6rsWd/zp6ZQjZo/utjXsFVGEcNoOf4qu7hSmW7Fgd8/oOcFNqvCa0phEX9xZZroLXz
         +CDA==
X-Forwarded-Encrypted: i=1; AJvYcCVa519zxcjG8ntJj9ladqjDN7jTHA8NZ7WbhcWOMQjH//ty9I1V5UVPJYmWohTTTYckJyLdVWmjKHL6Ia4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwszfiAfR3hzWrQTxglvvq2K7kKMURlGyuRRS6vEgzndCFdLn4Q
	kMj7hD6498wtxKsZdgkxUg7gf7bzd7PshaS0N/ukgRYRdhKJ5XjcV1aM3vrieLomicHO3WJ0VGe
	Ko/GtJAT8M0IqWG7CkiJ/xvs441rbMHfxy7RDXZTXITrEfInZEdOb8g0yOf8=
X-Google-Smtp-Source: AGHT+IEffIXFbn4TwPlopWwvoBrIZ29XcugjOATO11IpLsQQFff5K61XQzFKra4Phudkhr07PcON7beNsc0PSRrKvS03LLzTh041
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cd2:b0:87c:1237:cef7 with SMTP id
 ca18e2360f4ac-881683cfb64mr1506476739f.13.1754291916404; Mon, 04 Aug 2025
 00:18:36 -0700 (PDT)
Date: Mon, 04 Aug 2025 00:18:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68905ecc.050a0220.7f033.0004.GAE@google.com>
Subject: [syzbot] [bcachefs?] UBSAN: array-index-out-of-bounds in bch2_accounting_validate
From: syzbot <syzbot+cd063f869beedf5b9cd7@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    352af6a011d5 Merge tag 'rust-6.17' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=135d7aa2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cae1291240e8962a
dashboard link: https://syzkaller.appspot.com/bug?extid=cd063f869beedf5b9cd7
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14dcc6a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=133e02f0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a762497d1fce/disk-352af6a0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3055e1e47995/vmlinux-352af6a0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aa300ee98202/bzImage-352af6a0.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/de2a4b00a48a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cd063f869beedf5b9cd7@syzkaller.appspotmail.com

bcachefs (loop0): error reading btree root btree=subvolumes level=0: btree_node_read_error, fixing
bcachefs (loop0): invalid bkey in btree_node btree=snapshot_trees level=0: u64s 6 type snapshot_tree POS_MIN len 0 ver 0: subvol 1 root snapshot 4294967295
  bad pos, deleting
bcachefs (loop0): error reading btree root btree=snapshot_trees level=0: btree_node_read_error, fixing
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/bcachefs/disk_accounting.c:238:2
index 175 is out of range for type 'const unsigned int[9]'
CPU: 0 UID: 0 PID: 5849 Comm: syz-executor427 Tainted: G        W           6.16.0-syzkaller-11322-g352af6a011d5 #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_out_of_bounds+0xe9/0xf0 lib/ubsan.c:455
 bch2_accounting_validate+0x112f/0x1400 fs/bcachefs/disk_accounting.c:238
 bch2_bkey_val_validate+0x202/0x3e0 fs/bcachefs/bkey_methods.c:143
 btree_node_bkey_val_validate fs/bcachefs/btree_io.c:880 [inline]
 bch2_btree_node_read_done+0x4051/0x5550 fs/bcachefs/btree_io.c:1303
 btree_node_read_work+0x40e/0xe60 fs/bcachefs/btree_io.c:1440
 bch2_btree_node_read+0x887/0x2a00 fs/bcachefs/btree_io.c:-1
 __bch2_btree_root_read fs/bcachefs/btree_io.c:1906 [inline]
 bch2_btree_root_read+0x5f0/0x760 fs/bcachefs/btree_io.c:1928
 read_btree_roots+0x2c6/0x840 fs/bcachefs/recovery.c:615
 bch2_fs_recovery+0x261f/0x3a50 fs/bcachefs/recovery.c:1006
 bch2_fs_start+0xaaf/0xda0 fs/bcachefs/super.c:1213
 bch2_fs_get_tree+0xb39/0x1520 fs/bcachefs/fs.c:2488
 vfs_get_tree+0x92/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5016bf5eaa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd552f5c58 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd552f5c70 RCX: 00007f5016bf5eaa
RDX: 0000200000001000 RSI: 0000200000000000 RDI: 00007ffd552f5c70
RBP: 0000200000000000 R08: 00007ffd552f5cb0 R09: 000000000000492c
R10: 0000000000000000 R11: 0000000000000282 R12: 0000200000001000
R13: 00007ffd552f5cb0 R14: 0000000000000003 R15: 0000000000000000
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

