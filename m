Return-Path: <linux-kernel+bounces-628994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA33AA65D7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 23:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3651817E5C2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 21:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A69A257449;
	Thu,  1 May 2025 21:53:33 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA3021019C
	for <linux-kernel@vger.kernel.org>; Thu,  1 May 2025 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746136413; cv=none; b=qXVTSXPsrqQ6Z+xODKUsoB97s9JWagnZdjUaB0nNeYH320lbrhiByuu1Z3YtEm4T0HPefXuUAV74uXpDTk/9wz2ZHFCInb91Nn+4wxOIMm+s5jB03wu0HH2EN/gU0SVtxCD896Ct0vtr5x9DI+KDoaGSYAaOYt1JeLtY6arwtg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746136413; c=relaxed/simple;
	bh=QnRrSBZIOtwngpwuXJDGcgZz0+GWfqQ6d7GU8Lt2roU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nXy4v7kKWcTX3iy5ReUv90pf1nA0E2YSfeJsekqj9b+1Z8sNnXlPIsJPkfYaLd64KkFYRVmB4eCo/Enhsfi42MQyreFovY+OUe6PZ9KRTgFrcX9KFCeDRDVDtz9dcz6M9lQ5VjaKWaBD2uc2mkQAEFFWQNaMw9HR2G67LxpK9qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-85b3b781313so303340939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 May 2025 14:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746136410; x=1746741210;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axhrz9mfwO1YV96KHmFjTlwohYF2Wd2VRoI8/0hH6rM=;
        b=q64ihpfw3ZlOcOaiJuKfjt+1UpBOVYgGMHQo1x4Y2StOBlL/3Ucaf53YHKpCpaAEJA
         JOm3u3+QrG6kCkh0RjBovr58bPXA9K0m/l7JutLJtNZ32HLl/2FS72+qjgvGCfBscn8L
         UFdN12MpE07iLBo68YwVVvZ+JOktKHI2O/L2cyAyYKyKUO63dHB6Ttstg/hU6YmNkU2q
         HrFp+l4KUudYWKHiKQDdkmBwbhbHja9kkIuyp6Tww0jSjnDEpxBi/F17a/rPF15KwJoK
         64rFstjKJVcd0hh2M26X57AkH3siDHTkSFQum5ahuxpK2R5tZDyDRixqdvYNTu41/j0I
         c8Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWXNBFV2jgq5NDCJQ4DBMlej1l3R0FhQtsGg82e+mGm3AFvrYaIY2kzys6QQ6bvtmZzNdL2muOt7rcS0MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU4dFZUQLQ3CpwA+2xlFhs9DMzjzfQKTYHnLDMaJCk/hrNmLnu
	DyFGWjbEvZ7sXNXb3OYhHaSeNoY0vMNKkI4fq8AL/qj7QTWv8qvvFxbbXkc6bJE+wjWSnFVsA24
	GsHbrdhVBvXXd/t3nIHHsOCHFxJKfRvey98HG+8RnVfu/92OI/zovuQM=
X-Google-Smtp-Source: AGHT+IEFiFcI+AFjY1RM0Ne4xQOEklFLWng7UFp/phcaHBhfjFR/5601pUggbs+LxpGnFQOAWQZtP0f4vwXwu1/hN5SqrDcOn2V7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3799:b0:85e:aa76:db6b with SMTP id
 ca18e2360f4ac-8669f98c40emr129080539f.1.1746136410428; Thu, 01 May 2025
 14:53:30 -0700 (PDT)
Date: Thu, 01 May 2025 14:53:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6813ed5a.050a0220.53db9.0002.GAE@google.com>
Subject: [syzbot] [bcachefs?] WARNING in bch2_writepage_io_done (3)
From: syzbot <syzbot+0652cd10dc5ea0a2eb6f@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b4432656b36e Linux 6.15-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117c9270580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=714654674710be70
dashboard link: https://syzkaller.appspot.com/bug?extid=0652cd10dc5ea0a2eb6f
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-b4432656.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/11ce2d7fde6b/vmlinux-b4432656.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8bb54830a28f/bzImage-b4432656.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0652cd10dc5ea0a2eb6f@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5337 at fs/bcachefs/fs-io-buffered.c:464 bch2_writepage_io_done+0x765/0x800 fs/bcachefs/fs-io-buffered.c:464
Modules linked in:
CPU: 0 UID: 0 PID: 5337 Comm: syz.0.0 Not tainted 6.15.0-rc4-syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:bch2_writepage_io_done+0x765/0x800 fs/bcachefs/fs-io-buffered.c:464
Code: 0e 48 3b 84 24 80 00 00 00 75 72 4c 89 f7 48 81 c4 88 00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d e9 61 c6 61 00 e8 1c 7d 8b fd 90 <0f> 0b 90 42 80 3c 3b 00 74 08 4c 89 ef e8 09 72 ed fd 4d 8b 65 00
RSP: 0018:ffffc9000d637300 EFLAGS: 00010283
RAX: ffffffff843441b4 RBX: 1ffff11007d7402c RCX: 0000000000100000
RDX: ffffc9000efa4000 RSI: 000000000000183d RDI: 000000000000183e
RBP: 0000000000000008 R08: ffff88801e108303 R09: 1ffff11003c21060
R10: dffffc0000000000 R11: ffffed1003c21061 R12: 0000000000000008
R13: ffff88803eba0160 R14: ffff88803eba0368 R15: dffffc0000000000
FS:  00007fa079ff56c0(0000) GS:ffff88808d6cc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa0797d1fc8 CR3: 000000004210c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_write_data_inline fs/bcachefs/io_write.c:1611 [inline]
 bch2_write+0xb8d/0x11e0 fs/bcachefs/io_write.c:1677
 closure_queue include/linux/closure.h:270 [inline]
 closure_call include/linux/closure.h:432 [inline]
 bch2_writepage_do_io fs/bcachefs/fs-io-buffered.c:494 [inline]
 bch2_writepages+0x269/0x360 fs/bcachefs/fs-io-buffered.c:677
 do_writepages+0x3ae/0x7b0 mm/page-writeback.c:2656
 filemap_fdatawrite_wbc mm/filemap.c:386 [inline]
 __filemap_fdatawrite_range mm/filemap.c:419 [inline]
 filemap_write_and_wait_range+0x217/0x310 mm/filemap.c:691
 bchfs_truncate+0x6a8/0xb70 fs/bcachefs/fs-io.c:-1
 notify_change+0xb33/0xe40 fs/attr.c:552
 do_truncate+0x19a/0x220 fs/open.c:65
 do_ftruncate+0x489/0x540 fs/open.c:192
 do_sys_ftruncate fs/open.c:207 [inline]
 __do_sys_ftruncate fs/open.c:212 [inline]
 __se_sys_ftruncate fs/open.c:210 [inline]
 __x64_sys_ftruncate+0x92/0xf0 fs/open.c:210
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa07db8e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa079ff5038 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007fa07ddb6160 RCX: 00007fa07db8e969
RDX: 0000000000000000 RSI: 00000000000081fd RDI: 0000000000000008
RBP: 00007fa07dc10ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa07ddb6160 R15: 00007ffe9ece0348
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

