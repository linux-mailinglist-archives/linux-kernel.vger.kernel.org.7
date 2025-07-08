Return-Path: <linux-kernel+bounces-722136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E24AFD5BA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C481C23363
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1A52E716E;
	Tue,  8 Jul 2025 17:51:30 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DEA2E540C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997089; cv=none; b=c0BO2cDvNOx8oLDmjpzvmHrClvi6NvhFY6l9swn1GP/fzrgkEmWY6M2pkxzidWXwV9tzhk4wxccYcZlfCBFnHaWb4Z4Ec0bsNNDNXC+HbYc6TrkEl5JDRiDnUWAoXgFkrcU/27hd4xUVSKC8MNmOY18uLyUp12uVjDHGRxh5n/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997089; c=relaxed/simple;
	bh=16snbKbPrv8rHmFVZTG3K8M4q+P3FCRpUHEua0CsI6A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HXcTInTLfolswlhGVTEA2DdKc3f47QKqW8Kb/V8kKveYVXzPJXB8kkpdz6bkkwplNnxj9m+9ZKZ+/g9ElayNxRuZiSPGSOi0KA7lp6N6Q6r0IKA2BdL3s7+RilHkCIxCv4KsP3dw9ngJL0nnWjEu3Oi2vCAYmVYXf7Y5MvKV53A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3e055be2288so41585915ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 10:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997087; x=1752601887;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJemdCw5jND5Annd3/nq9OT4Nf4Nr8oL4Q80bImD8XA=;
        b=tLlXYD4DKRScM6/w1JJeotD94pL4YBFxApY0wF65iwVu4botV4T3hMDO6hVtvcWYu9
         MkPk1Xl+3UXgt2NPDFdRyiHAsg9+pdSxcoeddqb2IngZkFJKVjo2naMaOX2HIJR912zt
         bjf9fQ0tmjdkDlMPgdnfT1xjOQ/co+j/CkMtTsLxfounVI6hOjPjM808536y/C91qY9R
         kjW5L/01RhtSmVTEBDBD2r5VYNlGIMQxIDJLmfA2XVOJ0Mnosm+K9FHAX9lp4orePXtZ
         e0AxLGBJ5LJK2vwDHp4W/ZxUJtC8nmf5bhbGDXkU7MtMhCW/ZFO5nKniSK2Hb+1uz2ze
         Bufg==
X-Forwarded-Encrypted: i=1; AJvYcCUqzeU8PgStFqM/a+gUGe3YU09k9QK0xs+dWTkOPWmHGKbjzeJUSy3KLjkdDT2jJTlCsNZSFzR3QHQjDpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5swRxMLcIvGZRSzk6i3V34fXqy4UMDPCNlsPWaMWwBHJNYllP
	K5EzHi6AwhNb/saEl0LT3D6lHF1Ncuw/t8Ss/09UIm30WVgbtqyklBo0O6wBnDpAM4qFfALkQ+3
	LEy8s+s7A00B/j2q955RHaGHvc1zF/L9VJoAt0Yr0REnUIndx9pnccl+LoKQ=
X-Google-Smtp-Source: AGHT+IFRnNn9sgDNyHJt23b7Mr7Ft7Q+dyuXSydoZ0gp2f60eUG3E0i27e/t7AxHn/AAywySkoC92IHPOfSdCltId0sqofMbm4qs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2591:b0:3df:3222:278e with SMTP id
 e9e14a558f8ab-3e136ea4bf6mr178291795ab.1.1751997087355; Tue, 08 Jul 2025
 10:51:27 -0700 (PDT)
Date: Tue, 08 Jul 2025 10:51:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686d5a9f.050a0220.1ffab7.0016.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in move_to_new_folio (2)
From: syzbot <syzbot+3a24467a5470194c4175@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com, 
	rakie.kim@sk.com, syzkaller-bugs@googlegroups.com, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d7b8f8e20813 Linux 6.16-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ff728c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6cfc97245100778
dashboard link: https://syzkaller.appspot.com/bug?extid=3a24467a5470194c4175
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132adf70580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ff728c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d7b8f8e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/88e0e9607487/vmlinux-d7b8f8e2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c0e31868d902/bzImage-d7b8f8e2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/02a26963f634/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=150e5582580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3a24467a5470194c4175@syzkaller.appspotmail.com

------------[ cut here ]------------
gfs2_meta_aops does not implement migrate_folio
WARNING: CPU: 0 PID: 30 at mm/migrate.c:944 fallback_migrate_folio mm/migrate.c:942 [inline]
WARNING: CPU: 0 PID: 30 at mm/migrate.c:944 move_to_new_folio+0x696/0x7a0 mm/migrate.c:996
Modules linked in:
CPU: 0 UID: 0 PID: 30 Comm: kcompactd1 Not tainted 6.16.0-rc5-syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:fallback_migrate_folio mm/migrate.c:942 [inline]
RIP: 0010:move_to_new_folio+0x696/0x7a0 mm/migrate.c:996
Code: 0d 01 90 42 80 7c 3d 00 00 74 0a 48 8b 7c 24 20 e8 3f 53 fe ff 48 8b 44 24 20 48 8b 30 48 c7 c7 80 b4 97 8b e8 bb b0 5e ff 90 <0f> 0b 90 90 49 bf 00 00 00 00 00 fc ff df e9 7e fd ff ff e8 62 d0
RSP: 0018:ffffc900005171d0 EFLAGS: 00010246
RAX: 07a7b0ed2cfb0500 RBX: ffffea0000fecc00 RCX: ffff888030f20000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 1ffff1100a4b8921 R08: ffff88801fc24293 R09: 1ffff11003f84852
R10: dffffc0000000000 R11: ffffed1003f84853 R12: ffffea00012c1a80
R13: ffff8880525c47e8 R14: ffffea0000fecc08 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88808d21d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0000cc000 CR3: 000000003fab7000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 migrate_folio_move mm/migrate.c:1301 [inline]
 migrate_folios_move mm/migrate.c:1653 [inline]
 migrate_pages_batch+0x1c34/0x2830 mm/migrate.c:1900
 migrate_pages_sync mm/migrate.c:1930 [inline]
 migrate_pages+0x1bcc/0x2930 mm/migrate.c:2039
 compact_zone+0x23f4/0x4ad0 mm/compaction.c:2683
 kcompactd_do_work mm/compaction.c:3134 [inline]
 kcompactd+0x97d/0x1290 mm/compaction.c:3228
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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

