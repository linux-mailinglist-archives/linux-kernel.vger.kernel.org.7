Return-Path: <linux-kernel+bounces-783285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 734C8B32B52
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 19:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CDBB7B7969
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6342E283A;
	Sat, 23 Aug 2025 17:35:29 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58D92CCC5
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755970529; cv=none; b=NCg4jhlsyYY2KVe6rSJHP3QSgSaJfOAjEEXn6/U6o+24cn4Z2RnlWuiLZvfcFqd5DdvonrN36A/LOlYrGxhIsdWtboob9Vy65GtuQN/V09t3eTaXbD7lLHO9yJ1Xf0dXEYzA1NqVJ93N1enHVAQIDVdNBoh425Un8M3nLjkXOZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755970529; c=relaxed/simple;
	bh=z4XDfxPwGdpmWWAQPeZGINlm7pxbA2dIEUnQ6LjogNQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l0XLv0ahgIdgaKu6IbogRvM5vtxSxWJm/+gQzquAYbvvTLyv/xh+fU36X6Qk+nOfL6n+e0l40ci9u7GelfPiO7FxzSW3MkzSwgUkn7r3N0UpvcnnHQ1/UpLKToCB/ZIv0zmtAc6jcwwNadtbNGpVh6VpBks7UZGM/awzlva3cms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-886b489984cso735261639f.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 10:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755970527; x=1756575327;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIK+Z64BawigwUNtIIcncS8nuJuKSIHFqAyEqu8pJP0=;
        b=btuiKqUtdGCUr3jkBtWXgGk7hQUk+OrQ/JSFMR7BArRTd5Pgk8Tf+tcxJnuzm1fQZm
         au48R4j1pf6pQ2DGIXfdsC8xn+UQlYmyRT5UrueDJHzoZJODYqGx56pt0Z80+rHvyNay
         SkDTb2S4+6Qi1zK5FZQ0qOTWoQPuNo4DKB8iCnwc/nCyKbUKZFkfGjRKo9/1oIHK/sh8
         s6l3IiKhbIg+ED00DUbjsuYExlWSSp+qhxPHKk9atJfOwcNUzWXOV1AIoFiSbnAKzFaf
         +EkEZtVK0pfKtBfTlIS7Cr0vosLEBgbINi74zzAcC9YozY5DgfOOIKqtvf6IG88EwG39
         BGJw==
X-Forwarded-Encrypted: i=1; AJvYcCVgpH+T2wUovAStQpjJQ08hrcD2g9vud3KfX4YzHx89oC7xSL6Ay6ND1tMyoXn3iS+oqobVUPYY0pgLHWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5O79ma6IzyWIk0jnJ0uzcObtBeqWBxxZkqPhN8du4WK9f/T0M
	p+D9eebxLuvNDZdNti1c4ZcRvWzrXERQFtDd+E+rBpxT0PQLjZZU54ZineUgTTboVZHH2Ha2luj
	aBiQJZ4krW19FPE8pP1oQjEMcWCrIuXctIZ7GwBwuyIq126mZl2DkT0sRScY=
X-Google-Smtp-Source: AGHT+IFN4sYUS+3wAl1sVL8cHYrc7JAzF9MqsftD3EXoo0iiSvEpqOhgRpfvi2nx2QwAa4mn8DCk9OBwnTm2Q77cA9lnkxuLzR3W
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd88:0:b0:3e5:7c6d:ec8a with SMTP id
 e9e14a558f8ab-3e921f3c3d3mr103125815ab.16.1755970526888; Sat, 23 Aug 2025
 10:35:26 -0700 (PDT)
Date: Sat, 23 Aug 2025 10:35:26 -0700
In-Reply-To: <68721d9e.a00a0220.26a83e.0074.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a9fbde.050a0220.37038e.0067.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in __bch2_trans_commit (3)
From: syzbot <syzbot+b6ef9edaba01d5b4e43f@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1157bfa2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
dashboard link: https://syzkaller.appspot.com/bug?extid=b6ef9edaba01d5b4e43f
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1424cc42580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1120a7bc580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/18a2e4bd0c4a/disk-8f5ae30d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3b5395881b25/vmlinux-8f5ae30d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e875f4e3b7ff/Image-8f5ae30d.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/42de714fb1cc/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6ef9edaba01d5b4e43f@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/bcachefs/btree_trans_commit.c:348!
Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 15 Comm: kworker/u8:1 Not tainted 6.17.0-rc1-syzkaller-g8f5ae30d69d7 #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
Workqueue: writeback wb_workfn (flush-bcachefs-1)
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : btree_insert_entry_checks fs/bcachefs/btree_trans_commit.c:343 [inline]
pc : bch2_trans_commit_write_locked fs/bcachefs/btree_trans_commit.c:725 [inline]
pc : do_bch2_trans_commit fs/bcachefs/btree_trans_commit.c:854 [inline]
pc : __bch2_trans_commit+0x6054/0x625c fs/bcachefs/btree_trans_commit.c:1085
lr : btree_insert_entry_checks fs/bcachefs/btree_trans_commit.c:343 [inline]
lr : bch2_trans_commit_write_locked fs/bcachefs/btree_trans_commit.c:725 [inline]
lr : do_bch2_trans_commit fs/bcachefs/btree_trans_commit.c:854 [inline]
lr : __bch2_trans_commit+0x6054/0x625c fs/bcachefs/btree_trans_commit.c:1085
sp : ffff800097c46c40
x29: ffff800097c46f60 x28: 00000000ffffffff x27: ffff0000cbb7e4d8
x26: ffff800092df2000 x25: 0000000000000000 x24: dfff800000000000
x23: ffff800092df2000 x22: ffff0000cbb7c020 x21: ffff0000cbb7c042
x20: 0000000000000001 x19: 0000000000000001 x18: 00000000ffffffff
x17: ffff800093507000 x16: ffff80008b007340 x15: 0000000000000002
x14: 1ffff00012f88cb0 x13: 0000000000000000 x12: 0000000000000000
x11: 00000000eacee03a x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c1a03d00 x7 : ffff8000828f3158 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000002
x2 : 0000000000000008 x1 : 0000000000000080 x0 : ffff0000c1a03d00
Call trace:
 btree_insert_entry_checks fs/bcachefs/btree_trans_commit.c:343 [inline] (P)
 bch2_trans_commit_write_locked fs/bcachefs/btree_trans_commit.c:725 [inline] (P)
 do_bch2_trans_commit fs/bcachefs/btree_trans_commit.c:854 [inline] (P)
 __bch2_trans_commit+0x6054/0x625c fs/bcachefs/btree_trans_commit.c:1085 (P)
 bch2_trans_commit fs/bcachefs/btree_update.h:241 [inline]
 bch2_write_inode+0x52c/0x92c fs/bcachefs/fs.c:136
 bch2_vfs_write_inode+0x84/0xcc fs/bcachefs/fs.c:2148
 write_inode fs/fs-writeback.c:1525 [inline]
 __writeback_single_inode+0x5ac/0x13e8 fs/fs-writeback.c:1745
 writeback_sb_inodes+0x55c/0xe40 fs/fs-writeback.c:1976
 wb_writeback+0x3cc/0xd70 fs/fs-writeback.c:2156
 wb_do_writeback fs/fs-writeback.c:2303 [inline]
 wb_workfn+0x338/0xdc0 fs/fs-writeback.c:2343
 process_one_work+0x7e8/0x155c kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3400
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
Code: f940abe0 978e09e2 17ffffe0 97790f85 (d4210000) 
---[ end trace 0000000000000000 ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

