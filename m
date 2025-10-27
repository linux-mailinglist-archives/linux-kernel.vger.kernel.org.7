Return-Path: <linux-kernel+bounces-871180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AB3C0C95C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B5F188AB33
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8713F2F49F7;
	Mon, 27 Oct 2025 09:05:27 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427062F4A10
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555927; cv=none; b=gkf1xKki9RdnN2usD1kvSePNF1yHpONYr9kA0i5shYhtCAXnG9yqJ7S7K6DHHot18ilTM2xn4ZjP7und9ISHh3xvCNBq3ofvA6FJiSewPN/qyzz7z9IFVb/S4b3nuKyPbIVfyzoNs0r0a6bg9ZgjqMncPnw/RT8FpjjNHFOynig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555927; c=relaxed/simple;
	bh=WN7JmBbMhnhmgm/t+Z5YXXVpvW73Fd5nCOl4uzqYrJ0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lK+k2k8DnnSVhYBTHIfvotUp/i/GUOYRJOEzCDcbmWhYovqiCV4gLc7vWdDgJsYEGBNRXyfFItHKBMZ/XAcoORKXTWWOmniZ7GMV5BNxYJyg1Pu90gibTknXbKarrKVth4+m5uRshain1zYtPsxycPmfcyp31Q4ojb7vMcbew8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-430e1a4a129so56328765ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761555924; x=1762160724;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4348gTcAqcyYWGcqdLHPY+sADMiypVC1sIHy52muuig=;
        b=BCiba5a9+Ndp9xWuIHkwRhHLtzaYYxwq+JYIJeZBOtcnOFhDaT4R/m0JUZgvg7T+7i
         XpOTQdSMZDWj1MXsueicp94vZ+OXD1Fyog4J+vix/zkEmUM3rOSnBrkaUg2WjDSFn4xR
         T0NSNDv/+FxfqsbGEAEQs014YyZ9+3ibzseINzFzFPk/fkis5+a6uNNOfS6jynSdLImp
         wIdzCCMYWIYpiO3w7Yh4yMcNnn2r79xXvVpTCrHu6lv2SMOZVw6ItndpKXEyCTNQsM++
         3H/vLuFaWL1Kl8kTZGKsq3zAjT0to89DdPbCBJM62cgg/5LgoBjRny3pBHAIGEKWbkNV
         Z/1g==
X-Forwarded-Encrypted: i=1; AJvYcCXy+wc8irGKXxHCOx72P8rYolt0UjrLqB27HPyb/z6di+CAYOtsx5rY3sdVZa9C8WVnV1sPdmIlCpuwSjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxdrXgTeyGo8I9lsdzg/GERXONLkaa78jBfSs1yOi5yYhf6gGn
	7RsmD+U6tTX4lDO1DjkKaGAL/neCglxgcuh0PI+Hoq0Y2dZEzyM0i8tcXxOkeLx3DsM4vL+Fh5y
	KPBSN+mtIr3NNBWokOOhYAdxpLYlLD9Tn2+2em7TsOTdiCZp1r4EaHXPowmQ=
X-Google-Smtp-Source: AGHT+IHxMi6PV+TDJc3vwkPLg41bpxh9geXRcKNug531WUUS2N+LETudRT3A12NLxoo+XYJXQfcqdF95VBEZ6J0FerovQSBhMd3y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2143:b0:42f:96ec:50a5 with SMTP id
 e9e14a558f8ab-431ebea144emr104006355ab.20.1761555924284; Mon, 27 Oct 2025
 02:05:24 -0700 (PDT)
Date: Mon, 27 Oct 2025 02:05:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ff35d4.050a0220.32483.0015.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in lookup_inline_extent_backref (2)
From: syzbot <syzbot+b0e66d3779134f468156@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dbfc6422a34d Merge tag 'x86_urgent_for_v6.18_rc3' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d993cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25811b07889c90db
dashboard link: https://syzkaller.appspot.com/bug?extid=b0e66d3779134f468156
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-dbfc6422.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/73c799811c6a/vmlinux-dbfc6422.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e1bb4619e00f/bzImage-dbfc6422.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b0e66d3779134f468156@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5319 at fs/btrfs/extent-tree.c:836 lookup_inline_extent_backref+0x12c7/0x17f0 fs/btrfs/extent-tree.c:836
Modules linked in:
CPU: 0 UID: 0 PID: 5319 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:lookup_inline_extent_backref+0x12c7/0x17f0 fs/btrfs/extent-tree.c:836
Code: 05 fe 26 a5 0e 48 3b 84 24 e0 01 00 00 0f 85 8e 04 00 00 89 d8 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 5b 4b 81 07 cc 90 <0f> 0b 90 48 8b 44 24 78 42 80 3c 30 00 74 0a 48 8b 7c 24 20 e8 90
RSP: 0000:ffffc9000d23e820 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888000784900 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000d23ea48 R08: 0000000000000000 R09: 1ffffd40002891c8
R10: dffffc0000000000 R11: fffff940002891c9 R12: 1ffff1100a23a242
R13: 00000000000000b2 R14: dffffc0000000000 R15: ffff8880110e2000
FS:  00007f1616ed56c0(0000) GS:ffff88808d733000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7e2ed37000 CR3: 000000003f2e0000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 insert_inline_extent_backref+0xa8/0x2f0 fs/btrfs/extent-tree.c:1205
 __btrfs_inc_extent_ref+0x263/0x9e0 fs/btrfs/extent-tree.c:1503
 run_one_delayed_ref fs/btrfs/extent-tree.c:-1 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1972 [inline]
 __btrfs_run_delayed_refs+0xebd/0x4130 fs/btrfs/extent-tree.c:2047
 btrfs_run_delayed_refs+0xe6/0x3b0 fs/btrfs/extent-tree.c:2159
 btrfs_start_dirty_block_groups+0xd3d/0x10a0 fs/btrfs/block-group.c:3534
 btrfs_commit_transaction+0x674/0x3950 fs/btrfs/transaction.c:2241
 btrfs_sync_file+0xd30/0x1160 fs/btrfs/file.c:1818
 generic_write_sync include/linux/fs.h:3046 [inline]
 btrfs_do_write_iter+0x59a/0x710 fs/btrfs/file.c:1469
 iter_file_splice_write+0x975/0x10e0 fs/splice.c:738
 do_splice_from fs/splice.c:938 [inline]
 direct_splice_actor+0x101/0x160 fs/splice.c:1161
 splice_direct_to_actor+0x5a8/0xcc0 fs/splice.c:1105
 do_splice_direct_actor fs/splice.c:1204 [inline]
 do_splice_direct+0x181/0x270 fs/splice.c:1230
 do_sendfile+0x4da/0x7e0 fs/read_write.c:1370
 __do_sys_sendfile64 fs/read_write.c:1431 [inline]
 __se_sys_sendfile64+0x13e/0x190 fs/read_write.c:1417
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1615f8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1616ed5038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f16161e6090 RCX: 00007f1615f8efc9
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000008
RBP: 00007f1616011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 000000007ffff000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f16161e6128 R14: 00007f16161e6090 R15: 00007fff32122a28
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

