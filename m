Return-Path: <linux-kernel+bounces-790978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C84EB3B09C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81872188E762
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 01:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826641F3BB5;
	Fri, 29 Aug 2025 01:50:36 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796FE282F1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756432236; cv=none; b=DqgjAtOO+ZCDl1UkAaDhs+dy9nSr8N3kYn15R5lUSq0n/McANk/O77QVPyPc0SP9IHezgAzbWMBPbTkCwa9hM/g+mHhIpc7QuEOGAcGUIZAcPpuQtLTqKgyshUrO50dDpbDmlqAXpJcW+4elTJMR+G2ZMxU6Hij8xBm5zW2ei8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756432236; c=relaxed/simple;
	bh=Ca/Su6EOutUcSZeyQvAUYTHLgcnY3vtP8nzWYbnQk6s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fkQtZNM5ArxQzQ47YPkaO4zVe3PbsRVmE/C5igIstEI+f+j8skGbYlR7DO+UCtsTPc4w7YXWM721RFkSGq1p2EcS4N0Z+DQx6wXIvOk/qUVnznpYrp8WoCd+kpnGID1+be/9CIcSv3Q/+gV3XdkBUgMsMstJTy1kNJaMfRR52Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-887146211abso19110839f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756432233; x=1757037033;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xF4WlR4U5sOzkf0lXWrWEGQajRvphDBamnRJLAMzqEA=;
        b=jroUV0S5+QRVd+yYYt8cm2VJev0RsLzEAK0YUvJhnkibl1Xu4IeN4HGjocpyoWUZMB
         aBzAfqcLQXT41sYqFWEx2QmPf1MNTmqI7FLyi1jOSMykp4z2rcCE7w002x4YimLzV19V
         Co5ywT0TPD4NNKo1fXAVKEQDmLYocKDKq4fK2J+8cYSstPqd5W2Vn64O493+T+vYCcOs
         p+wthipJ7MiDE4OCYVS4ALmGb/YxH4Wn5WVWL28o7xyg2ZqIvM1jDA8aPmylZAdllfEG
         n941Ban5bKJniY+Zvd0nFAuCFg3Js9GaY8qXp/RrPSxMp+YRsqvfS/HRm0HIw3qGuhUW
         uefA==
X-Forwarded-Encrypted: i=1; AJvYcCWVuSLaR1YzkTo5XtIGdUnS+QTSRqhX1xYt5QV9oz8p4HtpJP/dHBv6nAcGyeC7LLA48DS4R+W44wY1CME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf9g/0CsrcTRkcLE4rVf2ZFmgPSk1A/VT8F9LM6qaSXiGRVPI7
	gemBYgjRUlgwEkz3byaaG7sEBf8wmXyksT8r4Q0FVm46Ji4MoydI28yTp8EmQ4GC688ZKcM/4V7
	DtFAz5UNDvMbT7CfGQH3aBoKWqYQmfes1CjtCb6JdXDEB2Jg5cnqaNUOR+WQ=
X-Google-Smtp-Source: AGHT+IFGW1TNPmr5d00/Ld35biXLP3TCR7PBBFLV1AUwWO6gPDGazbbcD+PdwbRQxK2AxKR8eAo0LgHSjz/o631pVguh0eifMeFS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c8d:b0:886:c49d:d3b6 with SMTP id
 ca18e2360f4ac-886c49de305mr3510427239f.18.1756432233639; Thu, 28 Aug 2025
 18:50:33 -0700 (PDT)
Date: Thu, 28 Aug 2025 18:50:33 -0700
In-Reply-To: <683bef14.a70a0220.1a6ae.0011.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b10769.050a0220.3db4df.00f3.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_remove_extent
From: syzbot <syzbot+8882b2f5f48a7170a726@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    07d9df80082b Merge tag 'perf-tools-fixes-for-v6.17-2025-08..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17bdfc42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7016efe6aaa498c
dashboard link: https://syzkaller.appspot.com/bug?extid=8882b2f5f48a7170a726
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115a4262580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13087ef0580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-07d9df80.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/64a01edfb5ff/vmlinux-07d9df80.xz
kernel image: https://storage.googleapis.com/syzbot-assets/78c915400ff9/bzImage-07d9df80.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7dc3c9b29fa5/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=165a4262580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8882b2f5f48a7170a726@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ocfs2/alloc.c:5581!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5722 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ocfs2_remove_extent+0x1ecf/0x2020 fs/ocfs2/alloc.c:5581
Code: fa ff ff 48 8b 4c 24 08 80 e1 07 fe c1 38 c1 0f 8c 95 fa ff ff 48 8b 7c 24 08 e8 4c 35 8d fe e9 86 fa ff ff e8 f2 48 28 fe 90 <0f> 0b f3 0f 1e fa 44 89 6c 24 10 65 8b 1d d3 9d 09 0f bf 07 00 00
RSP: 0018:ffffc9000d56e640 EFLAGS: 00010293
RAX: ffffffff8397724e RBX: ffffc9000d56ee38 RCX: ffff88803eab8000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000007
RBP: ffffc9000d56e990 R08: ffff88803eab8000 R09: 0000000000000006
R10: 00000000fffffffc R11: 0000000000000000 R12: 1ffff11008b38e9a
R13: 0000000000000007 R14: ffff8880459c74d0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88808d20f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2cce600218 CR3: 000000004b419000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 ocfs2_remove_btree_range+0xdef/0x1540 fs/ocfs2/alloc.c:5778
 ocfs2_commit_truncate+0xb64/0x21d0 fs/ocfs2/alloc.c:7373
 ocfs2_truncate_for_delete fs/ocfs2/inode.c:699 [inline]
 ocfs2_wipe_inode fs/ocfs2/inode.c:866 [inline]
 ocfs2_delete_inode fs/ocfs2/inode.c:1155 [inline]
 ocfs2_evict_inode+0x1138/0x40e0 fs/ocfs2/inode.c:1292
 evict+0x501/0x9c0 fs/inode.c:810
 ocfs2_dentry_iput+0x247/0x370 fs/ocfs2/dcache.c:407
 __dentry_kill+0x209/0x660 fs/dcache.c:669
 dput+0x19f/0x2b0 fs/dcache.c:911
 __fput+0x68e/0xa70 fs/file_table.c:476
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6b5/0x2300 kernel/exit.c:961
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1102
 get_signal+0x1286/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:40 [inline]
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 irqentry_exit_to_user_mode+0x81/0x120 kernel/entry/common.c:73
 exc_page_fault+0x9f/0xf0 arch/x86/mm/fault.c:1535
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f018c18ebf1
Code: Unable to access opcode bytes at 0x7f018c18ebc7.
RSP: 002b:00000000fffffeb0 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007f018c3b5fa0 RCX: 00007f018c18ebe9
RDX: 0000000000000000 RSI: 00000000fffffeb0 RDI: 0000000002000400
RBP: 00007f018c211e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 00007f018c3b6038 R14: 00007f018c3b5fa0 R15: 00007ffc298dcef8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ocfs2_remove_extent+0x1ecf/0x2020 fs/ocfs2/alloc.c:5581
Code: fa ff ff 48 8b 4c 24 08 80 e1 07 fe c1 38 c1 0f 8c 95 fa ff ff 48 8b 7c 24 08 e8 4c 35 8d fe e9 86 fa ff ff e8 f2 48 28 fe 90 <0f> 0b f3 0f 1e fa 44 89 6c 24 10 65 8b 1d d3 9d 09 0f bf 07 00 00
RSP: 0018:ffffc9000d56e640 EFLAGS: 00010293
RAX: ffffffff8397724e RBX: ffffc9000d56ee38 RCX: ffff88803eab8000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000007
RBP: ffffc9000d56e990 R08: ffff88803eab8000 R09: 0000000000000006
R10: 00000000fffffffc R11: 0000000000000000 R12: 1ffff11008b38e9a
R13: 0000000000000007 R14: ffff8880459c74d0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88808d20f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f67141f3000 CR3: 00000000333eb000 CR4: 0000000000352ef0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

