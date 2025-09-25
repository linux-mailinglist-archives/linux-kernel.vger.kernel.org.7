Return-Path: <linux-kernel+bounces-832032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 842B0B9E300
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70AB3B0282
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5708626FA5B;
	Thu, 25 Sep 2025 09:05:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB768488
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791104; cv=none; b=Hbkzv7U+0u+BHaGIakq3jX89lJNvqIWV/ewBRtx+5VSvBDEzt6aT8HGsrQYRfDUgUlAqaw8IVGu/VSVYhsw/f2bzma91eza4/lxnn68FIwdwo0UzDVlBjfODsN3DC9XGHu4mRETcs61k5oLeMm5BjiEfwdOdxW115n/CLtEobgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791104; c=relaxed/simple;
	bh=ENoRoXPrhyLv5DEJI3cEjHwsC6+A5zmiK7ACdvJnyTQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YELi6UBqa4oiSrqnnpzOqQ7SQvZmlXrSNMetpJcOs9w9bxrxorXE+RHgIc/Uk+V56ALPNFXLItpnkm9zenzoJjTZELRfo34Cq8UUVMFA82AwALgGDfu8g3ttSzCNSV/3Ayry77r6Exk8IIM5XBgO+pjU5XJRG8+Br9DfY7PWhWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42594b7f2ddso9904605ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758791102; x=1759395902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bLHA2C9953oAHyPn2w2N6kgA/umlQX7Hn7svRva9lHU=;
        b=mXR0ZSb5zxhp2PaS+jpFcU/GKp7/4wQGNKb2jLXlXkV9ho/aBOzEECLvi1MtyArWER
         aWWYTZFiXfrq8Rre5g97WH09Z1CgLg4o3b54G46xe4aNxGrs+toABxwNLLQx0p92jjtp
         LrrKHYzhCo8TEfAJpsAqYrDeLTm37+xtKGbt7T4LP/lMqHWOVM6h2dA+rjK7T/MH5I01
         Ivdz8d4sDU0Eevmlqs/jJ20rpAEIPu7IBwyVBikOTmcSoZ/nO6DzrvNEUXHsUbVx+ne2
         00sEVMEgqAAAryrXfUvjeBmyc1GUt2+aWdrpnghNT3nPAXa9uHdyaU6OdFCfTZGLQY2h
         WolA==
X-Gm-Message-State: AOJu0Yy1FxtUCOXZKisV217T+iVQghVd9RFJIQw8Ngef3/NPraD8Giz/
	alrCXwQAZcBX1Whco7ylu98zSZlE+/+zXzbl7dLimiCmx62nVG05nSEM0sbQ1uWf79osqqXSUf0
	EUwXtmKv9Lr3/svywS2c/h7OSYZ/JHrjKmdOUMV2zJ1iocw0TdZtfVB7lRPI=
X-Google-Smtp-Source: AGHT+IFj4dXPJDfHVk8U8AT3JmZ7qzAdyw4NbiMSnjjWIkkPZUO/7EMKioWEXgJPFg5dOSjcjY361BXoFftzQb5ZtCpZ9JCHmu8Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c00c:0:b0:424:8c15:888a with SMTP id
 e9e14a558f8ab-42595685dedmr32193935ab.32.1758791102453; Thu, 25 Sep 2025
 02:05:02 -0700 (PDT)
Date: Thu, 25 Sep 2025 02:05:02 -0700
In-Reply-To: <905bb5a8bc3e969ef332dd604864ba67b93e1a85.1758789532.git.xiaopei01@kylinos.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d505be.a00a0220.303701.0005.GAE@google.com>
Subject: Re: [syzbot] [fs?] [mm?] WARNING: bad unlock balance in hugetlb_vmdelete_list
From: syzbot <syzbot+62edf7e27b2e8f754525@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in hugetlb_vma_assert_locked

------------[ cut here ]------------
WARNING: mm/hugetlb.c:368 at hugetlb_vma_assert_locked+0x1dd/0x250 mm/hugetlb.c:368, CPU#0: syz.0.41/6582
Modules linked in:
CPU: 0 UID: 0 PID: 6582 Comm: syz.0.41 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:hugetlb_vma_assert_locked+0x1dd/0x250 mm/hugetlb.c:368
Code: 2e e8 e7 42 a1 ff eb 0c e8 e0 42 a1 ff eb 05 e8 d9 42 a1 ff 5b 41 5c 41 5d 41 5e 41 5f 5d e9 9a a0 6a 09 cc e8 c4 42 a1 ff 90 <0f> 0b 90 eb e5 e8 b9 42 a1 ff 90 0f 0b 90 eb da 48 c7 c1 70 b5 e4
RSP: 0018:ffffc9000217f388 EFLAGS: 00010293
RAX: ffffffff821f540c RBX: 0000000000000000 RCX: ffff88807af68000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff5200042fe74 R12: ffff88805df6aa00
R13: 1ffff110064fdfc4 R14: dffffc0000000000 R15: 0000000000000080
FS:  00007fc7b46136c0(0000) GS:ffff8881257be000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc7b45f2d58 CR3: 0000000077790000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 huge_pmd_unshare+0x2c8/0x540 mm/hugetlb.c:7622
 __unmap_hugepage_range+0x6e3/0x1aa0 mm/hugetlb.c:5901
 unmap_hugepage_range+0x32e/0x410 mm/hugetlb.c:6089
 hugetlb_vmdelete_list+0x171/0x1c0 fs/hugetlbfs/inode.c:494
 hugetlb_vmtruncate fs/hugetlbfs/inode.c:641 [inline]
 hugetlbfs_setattr+0x4d1/0x6d0 fs/hugetlbfs/inode.c:879
 notify_change+0xc1a/0xf40 fs/attr.c:546
 do_truncate+0x1a4/0x220 fs/open.c:68
 handle_truncate fs/namei.c:3596 [inline]
 do_open fs/namei.c:3979 [inline]
 path_openat+0x306c/0x3830 fs/namei.c:4134
 do_filp_open+0x1fa/0x410 fs/namei.c:4161
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_open fs/open.c:1460 [inline]
 __se_sys_open fs/open.c:1456 [inline]
 __x64_sys_open+0x11e/0x150 fs/open.c:1456
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc7b378eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc7b4613038 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fc7b39e5fa0 RCX: 00007fc7b378eec9
RDX: 0000000000000100 RSI: 000000000014927e RDI: 0000200000000340
RBP: 00007fc7b3811f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc7b39e6038 R14: 00007fc7b39e5fa0 R15: 00007ffc872255b8
 </TASK>


Tested on:

commit:         b5a4da2c Add linux-next specific files for 20250924
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10f02f12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=841973c5ab4f4157
dashboard link: https://syzkaller.appspot.com/bug?extid=62edf7e27b2e8f754525
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1581ed34580000


