Return-Path: <linux-kernel+bounces-718970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1DCAFA836
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 00:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5775918990A7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jul 2025 22:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE061F8744;
	Sun,  6 Jul 2025 22:48:31 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881BD1A7253
	for <linux-kernel@vger.kernel.org>; Sun,  6 Jul 2025 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751842111; cv=none; b=DOeTd98OknHfwH156EnznNGf0OgHFwP/sB4ZGbFUHGl1x8wJAJAbeVdd5yqP7wonVish15ladZY7UtmY1qJgJcXC6AcRVtR1NsuvWr3xIiKJdAoYoZBqoH05yCPDL7XnKqQFebe3S3BZPaMZZn/z6j65aJeB5MiDgVbwVWzkZQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751842111; c=relaxed/simple;
	bh=5no+m8CtR+iGIJ8552Om7paBco+wW3sa50nKMbQ1Bcg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nik1tevYE7KFZHGemE9Ww9G4O6w4WnnZEdzMljG6F406bmu1r848jkTx05/g0R3vx1Ze1J9nlxRekS++WAIqbYKNv5Vp7qkReAYRH7VointWq/KpEORIcJ7k+q9Z+nVO0h/RPJBdSSb8JZ3rZG5/9iQTMPXT3ImXqhyNXDST0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-86f4f032308so513434539f.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jul 2025 15:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751842108; x=1752446908;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysEpUGqYjTyHMD1DIQit3jf1lGgLyPyb19cPIjKTjnU=;
        b=SuieStzgzw7f08DBufh6P+y5EpDlhUCu7oW6EoACXcxpfwsASwmsJRGR+dbtT64IAL
         ty/SJ5xJ5AwIj7d6SLVLCEful3nWd95/DQo55kWzrzzqKqaDoYqv3hQgs+BFctFLIMox
         5AlbW/lSCLJN8gvfU05g7LNAw0Vvdk+evb2bPlKSePtYB2DI2euA84UhPAn6AR1GGPc7
         TXTWCIYUNv6DXLYqJq1FvK2+eab79LLyKiim/93OvYFjnxKAsxhehv8TS0l+jVIqY7m4
         /7DHmDkz4f1v4jDBMt7eJ+pbORQdZq26z34ywRzCUtBku//99qzKmBCNUcUZlqZU1o8W
         PpMA==
X-Forwarded-Encrypted: i=1; AJvYcCU+GoJF+S2GbL6zkxff3gn+B5kvXEtcTvlmRWcpVrODaZaduXnffnX+/Dx40hxaZiA5grEXS9jTVcC/k1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYahEl+CdqzvbOthS/f/493C+ndY4gVo28ZnCI5Ol/UGy8m5vO
	lZL35IEZz6fAYe61rE7ssewGHFd8ZZl5GhsoWSAf9YrsIFWlyD4TAO9lxp15QnKWg4rAF83eNep
	I4qTv7GO1wGINpiz5t9+pKE9mQZpZECQTiOs9FST1bbZqofyC38b/Bpmqgm0=
X-Google-Smtp-Source: AGHT+IGEdZ8Z+R9TcIlPP0doyUeIr+3tAxMSVdyOfeDsufyYK381yosVpRcCRYCfZ2k5R1+WXRTgJ+YxhMKN1EEZJk8lZDjWOH/T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c245:0:b0:3df:2f9e:3db4 with SMTP id
 e9e14a558f8ab-3e13eefb660mr54804495ab.13.1751842108671; Sun, 06 Jul 2025
 15:48:28 -0700 (PDT)
Date: Sun, 06 Jul 2025 15:48:28 -0700
In-Reply-To: <6853f202.a00a0220.137b3.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686afd3c.a00a0220.c7b3.0067.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_trans_update_by_path
From: syzbot <syzbot+210dfbddd64294066983@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    7482bb149b9f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1675e582580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c06e3e2454512b3
dashboard link: https://syzkaller.appspot.com/bug?extid=210dfbddd64294066983
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1412628c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d5ef70580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f623d741d651/disk-7482bb14.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/483e23ae71b1/vmlinux-7482bb14.xz
kernel image: https://storage.googleapis.com/syzbot-assets/79b5baaa1b50/Image-7482bb14.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/da659f915c60/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+210dfbddd64294066983@syzkaller.appspotmail.com

bcachefs (loop0): bucket 0:34 gen 0 data type need_discard has wrong dirty_sectors: got 16, should be 0, fixing
 done
bcachefs (loop0): going read-write
bcachefs (loop0): journal_replay...
------------[ cut here ]------------
kernel BUG at fs/bcachefs/btree_update.c:375!
Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 6741 Comm: syz.0.16 Not tainted 6.16.0-rc4-syzkaller-g7482bb149b9f #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : bch2_trans_update_by_path+0x17bc/0x17f0 fs/bcachefs/btree_update.c:375
lr : bch2_trans_update_by_path+0x17bc/0x17f0 fs/bcachefs/btree_update.c:375
sp : ffff80009e1165c0
x29: ffff80009e116780 x28: 0000000000008540 x27: ffff0000c34aca80
x26: ffff0000ec7e0000 x25: ffff700013c22ce0 x24: 1fffe0001d8fc002
x23: ffff0000ec7e0010 x22: ffff0000ec7e02f0 x21: 1fffe0001d8fc05e
x20: dfff800000000000 x19: ffff0000eb400000 x18: 00000000ffffffff
x17: ffff800093363000 x16: ffff80008aefca08 x15: 0000000000000003
x14: 0000000000000000 x13: 0000000000000003 x12: 0000000000ff0100
x11: ffff0000c8ae3d00 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c8ae3d00 x7 : ffffffffffffffff x6 : ffffffffffffffff
x5 : ffff0000ec7e02f0 x4 : ffff800082a4ca28 x3 : 0000000000180000
x2 : ffff0000c34aca80 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 bch2_trans_update_by_path+0x17bc/0x17f0 fs/bcachefs/btree_update.c:375 (P)
 bch2_trans_update_ip+0x7bc/0x17ec fs/bcachefs/btree_update.c:531
 bch2_trans_update+0x4c/0x60 fs/bcachefs/btree_update.h:123
 bch2_journal_replay_key+0x348/0x68c fs/bcachefs/recovery.c:311
 bch2_journal_replay+0xfdc/0x1c44 fs/bcachefs/recovery.c:396
 bch2_run_recovery_pass fs/bcachefs/recovery_passes.c:484 [inline]
 __bch2_run_recovery_passes+0x29c/0xd18 fs/bcachefs/recovery_passes.c:539
 bch2_run_recovery_passes+0x174/0x1f4 fs/bcachefs/recovery_passes.c:610
 bch2_fs_recovery+0x1c34/0x2fb4 fs/bcachefs/recovery.c:1005
 bch2_fs_start+0x914/0xbc0 fs/bcachefs/super.c:1212
 bch2_fs_get_tree+0x880/0x1030 fs/bcachefs/fs.c:2490
 vfs_get_tree+0x90/0x28c fs/super.c:1804
 do_new_mount+0x228/0x814 fs/namespace.c:3902
 path_mount+0x5b4/0xde0 fs/namespace.c:4226
 do_mount fs/namespace.c:4239 [inline]
 __do_sys_mount fs/namespace.c:4450 [inline]
 __se_sys_mount fs/namespace.c:4427 [inline]
 __arm64_sys_mount+0x3e8/0x468 fs/namespace.c:4427
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
Code: 17fffe3f 977aae52 d4210000 977aae50 (d4210000) 
---[ end trace 0000000000000000 ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

