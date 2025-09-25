Return-Path: <linux-kernel+bounces-832201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F8AB9EA05
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BF537B2CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636402EAB9D;
	Thu, 25 Sep 2025 10:26:30 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2528A2E9756
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758795989; cv=none; b=mj8Zmo/QBCzqghuJfst2Ae6yzMXHgQhu9BgC84Ouu5I4CDdC1DOKIh4NfRo1LFKNbhmUT6q+qsl6h3tSEZWcbMErCORwJYl8x5Ke65rLlxx9ysYl1StfUEeFC25DlWVbF9usJ9F7cWsmbkCgypXeeluhWETajy3hxClaSv6ROhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758795989; c=relaxed/simple;
	bh=cWh/VaZQcBjXsPpKRX+7tYs35sQuiNXVjeIEiD0TzSk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f8d/0d/q5rMbMhjAxvG5Ea4EsL5bjIEl+YxYCgmtWebang1EGhejcU5yYXSRVY9NPGkk80513oq3TGbLAbjwlK5rp/iPfB7+6qk6u9SfXUCE/PX2bV8D/IwOqzf0X6ZLdjQlOat8P4bUOeosd+Eqxiij7V063HGpd1zUjFl6rYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-8e621d97671so234523739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758795987; x=1759400787;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBMg4Yrzu2EpD6Kbgv792iOKp+UCMNKTGonr77XbgpM=;
        b=FoMJuntC0NZLFWWG+tbsYpGX7kbOtM7KmOdVkLikggG8l/mEQ5W4lAsjAqvvV+OJOw
         wRxmKtNVwBstJ3K5GYidnGIbzKU8GKpuav3JgLUHP4go6GxJ01M6+dn/i7lzb5A0ayRu
         iPlLegXlFZqa9lRsgfWKAo0t6oiyL5gv64qlvgBQ2vAqeGm4DTKL1TGqT4urhJ5C8TQ/
         TtxwfvKKLqzRUENa3HEDUPbCmvvgaB8Etdys6fOv41ejb5nngIsehi8LP2p7fWU4Ez+E
         XejqU7JOOQJsnp7/aHAD704HdoVa3cQTx2zdyb+6oN2t+NefN8+w0vWw/79y1ZcqkQ5h
         CIxw==
X-Forwarded-Encrypted: i=1; AJvYcCX7UG1Hf9ovbOIqKdZ1DNQ/Ucz7suTq7AfddWZh1TrUsM6h/tjXqLPwWu60HRU49x++dnGCF9GWyuInBFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx26hVZHBT5nsVDKblV4rsmzrabro4hPILlQ/lm4bMexHMqWGFY
	LqUm7CtK52Q496LXoLdf6r6HVqIO+p8Xg6Tc5hNuCAJHhNlANv//gr+wwbQt6jM2buuVtz2iseM
	Pud/CU9KtIGiuWeIaekYHeNZoPhWwCCOJO8fAI6Q+SkMWfGqSvjUIrEg4W2E=
X-Google-Smtp-Source: AGHT+IGdlai8nHoW3lf77d/OsgTl77Ju6GM1K6KyfhyxzJma9NQje6THEYzJnAKmKjgDIuZb7fIXxrTWkd3b7XMjQRrLwsSsu+1N
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c841:0:b0:424:19c4:3000 with SMTP id
 e9e14a558f8ab-425956089cemr37522335ab.14.1758795987318; Thu, 25 Sep 2025
 03:26:27 -0700 (PDT)
Date: Thu, 25 Sep 2025 03:26:27 -0700
In-Reply-To: <68c3c675.050a0220.2ff435.0354.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d518d3.050a0220.3a612a.0009.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_trans_update_by_path (2)
From: syzbot <syzbot+e7b9dfa79acffd3aabdd@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    0f3be52b8e37 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15205ce2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=714d45b6135c308e
dashboard link: https://syzkaller.appspot.com/bug?extid=e7b9dfa79acffd3aabdd
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123cace2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1374e142580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a2c3b345c3da/disk-0f3be52b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/54368457365a/vmlinux-0f3be52b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3544cf9b3f24/Image-0f3be52b.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/09727f6cbd01/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e7b9dfa79acffd3aabdd@syzkaller.appspotmail.com

bcachefs (loop0): pointer to missing indirect extent in (disconnected) offset 0: -12288
  u64s 7 type reflink_p 4102:24:U32_MAX len 24 ver 0: idx 0 front_pad 0 back_pad 0
  missing reflink btree range 0-24, fixing
------------[ cut here ]------------
kernel BUG at fs/bcachefs/btree_update.c:410!
Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 6643 Comm: syz-executor Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : bch2_trans_update_by_path+0x17ec/0x17f0 fs/bcachefs/btree_update.c:410
lr : bch2_trans_update_by_path+0x17ec/0x17f0 fs/bcachefs/btree_update.c:410
sp : ffff8000a10661c0
x29: ffff8000a1066380 x28: 0000000000000004 x27: ffff0000c83cc000
x26: 0000000000000000 x25: ffff0000d6c81268 x24: 1fffe00019079802
x23: 0000000000000000 x22: ffff0000c83ce4d8 x21: 0000000000004000
x20: dfff800000000000 x19: ffff0000c83ce4d8 x18: 00000000ffffffff
x17: 3233553a303a3230 x16: ffff80008af86288 x15: 0000000000000003
x14: 0000000000000000 x13: 0000000000000006 x12: 0000000000ff0100
x11: ffff0000d33bbd00 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d33bbd00 x7 : 0000100600000000 x6 : ffff800082901c6c
x5 : 0000000000000812 x4 : ffff8000828fcb24 x3 : 0000000000100000
x2 : ffff0000d6c81268 x1 : 0000000000004000 x0 : 0000000000000000
Call trace:
 bch2_trans_update_by_path+0x17ec/0x17f0 fs/bcachefs/btree_update.c:410 (P)
 bch2_trans_update_ip+0x7bc/0x17ec fs/bcachefs/btree_update.c:531
 bch2_trans_update+0x4c/0x60 fs/bcachefs/btree_update.h:123
 bch2_btree_insert_nonextent fs/bcachefs/btree_update.c:625 [inline]
 bch2_trans_update_extent fs/bcachefs/btree_update.c:321 [inline]
 bch2_trans_update_ip+0x1320/0x17ec fs/bcachefs/btree_update.c:503
 bch2_trans_update+0x4c/0x60 fs/bcachefs/btree_update.h:123
 bch2_btree_insert_trans+0x180/0x2a8 fs/bcachefs/btree_update.c:637
 bch2_indirect_extent_missing_error+0x778/0xafc fs/bcachefs/reflink.c:239
 bch2_lookup_indirect_extent+0x334/0x558 fs/bcachefs/reflink.c:279
 trans_trigger_reflink_p_segment fs/bcachefs/reflink.c:308 [inline]
 __trigger_reflink_p+0x270/0xf40 fs/bcachefs/reflink.c:419
 bch2_trigger_reflink_p+0x114/0x244 fs/bcachefs/reflink.c:454
 run_one_trans_trigger fs/bcachefs/btree_trans_commit.c:-1 [inline]
 bch2_trans_commit_run_triggers fs/bcachefs/btree_trans_commit.c:554 [inline]
 __bch2_trans_commit+0x800/0x625c fs/bcachefs/btree_trans_commit.c:1023
 bch2_trans_commit fs/bcachefs/btree_update.h:241 [inline]
 bch2_inode_delete_keys+0x3d8/0x584 fs/bcachefs/inode.c:1115
 bch2_inode_rm+0x214/0x4e0 fs/bcachefs/inode.c:1146
 bch2_evict_inode+0x1b4/0x444 fs/bcachefs/fs.c:2182
 evict+0x414/0x928 fs/inode.c:810
 iput_final fs/inode.c:1897 [inline]
 iput+0x6e4/0x83c fs/inode.c:1923
 do_unlinkat+0x300/0x488 fs/namei.c:4657
 __do_sys_unlinkat fs/namei.c:4691 [inline]
 __se_sys_unlinkat fs/namei.c:4684 [inline]
 __arm64_sys_unlinkat+0xdc/0xf8 fs/namei.c:4684
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:763
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
Code: d4210000 9778c3b9 d4210000 9778c3b7 (d4210000) 
---[ end trace 0000000000000000 ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

