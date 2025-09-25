Return-Path: <linux-kernel+bounces-831868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDB2B9DBDF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5AD19C6E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB482E8B98;
	Thu, 25 Sep 2025 07:02:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3841D5CFB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758783724; cv=none; b=m+ZzqFXywOaEWu/3nmaPrwD4D/XOPVNc8LaStNZK5MOycy0Tp9tS3Z9cziExWIFnmYHO94YVDo9Xo72VF4xAXyiPK8tf/0IihRWKyz4jGV22NBXGJ4o71aEMzFGhJZ3THBe4kTX+z9VrZFXSZZYM9bAyqIcf5NLEVIaIiLFofyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758783724; c=relaxed/simple;
	bh=8CYWCR/BeMPDWS88LGPM/SxCo7VL2Wem6HsRzFNySLs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RWTK7rfEchIoM3FUNYyUS/PU346OoDTgqSdHaCB08z51Y7uPF0jow3tF8EBwRESAXkA5n2zpmoeB6F2PCpQRWmVJZF4a5mspPq3vI3vpsh1T33Uwsn6fkVrWCrGFyUQKXpIpGCZ9/N0kjRQ8MWWiT9XIjV7dktWDdeVdhY8z3CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42628f7c151so4364675ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758783722; x=1759388522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3mA/FWp9NwaeYd+HLUxiHlNKvPyoCDpMeZOz5k4iT8=;
        b=o8eWwKCA/MvIJBx5NHSopv+LxtUjGlPPEJ8015EKZijvo2CVSucSogJoRBR9U4ZCMl
         oPwdzXixlruW9b0TZMxsSmyntDKKadzvROcRBrD13Y4u3YEYJAZdvzD9/8CMc1AN9fEj
         CXVPX9y+r5dLVJnDYRdJFzzofNLioLWZun0hx8f7wM0rxgmQ8Kld6Wb1B5NxrsaDUgnt
         X1Buwf4XZFpk4PqlpqfsmcKnz5epqnxd9mD1Z+MYG0Ue4HF1aroRvoCZmZIaYFXOLPB7
         Xhg0EyOzp4qQ3nQ3z9FUIAkacTLi2ABKoDf0pBK5CPE28lb15pJP+jYdCItADLfhKP3f
         sRYw==
X-Forwarded-Encrypted: i=1; AJvYcCUCXN0sR7qp/nbfZLQe7/rhSbvKLipm25RgEiZCGs/cu/QKZ9TMt3ZGrCICclFz2vHQPURbFC9vMs661Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn57YP/Ij4sNQZ5mwhVAYFhx57tLPFx8GLq8aKlUvoeCaElh+W
	rP11YvCBmnsrroxHAvyUBXCCNqubMPPQGJlAZ0rMd7BrVA0TjNsPCXLq8xGDl0KbYN+d0jhm7ww
	VA+R6LZ8jM8jY4lSH3SUFjuraoKyA+xh4aJBwIgZfoAudttuJA6b1I416xUE=
X-Google-Smtp-Source: AGHT+IHnzW4LARFoBqN+PhuvGc44UYjiVtkMi98VsqTRh/A7c+y/mDDkdOPkpHjYv+jm1SkK/ii+e/EgTyanVNybyAst249i4wJc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d08c:0:b0:425:8744:de9b with SMTP id
 e9e14a558f8ab-42595614302mr26325845ab.18.1758783722190; Thu, 25 Sep 2025
 00:02:02 -0700 (PDT)
Date: Thu, 25 Sep 2025 00:02:02 -0700
In-Reply-To: <20250925062317.1281522-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d4e8ea.050a0220.25d7ab.0002.GAE@google.com>
Subject: Re: [syzbot] [fs?] [mm?] WARNING: bad unlock balance in hugetlb_vmdelete_list
From: syzbot <syzbot+62edf7e27b2e8f754525@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in hugetlb_vma_assert_locked

------------[ cut here ]------------
WARNING: mm/hugetlb.c:368 at hugetlb_vma_assert_locked+0x1dd/0x250 mm/hugetlb.c:368, CPU#0: syz.0.2369/13821
Modules linked in:
CPU: 0 UID: 0 PID: 13821 Comm: syz.0.2369 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:hugetlb_vma_assert_locked+0x1dd/0x250 mm/hugetlb.c:368
Code: 2e e8 e7 42 a1 ff eb 0c e8 e0 42 a1 ff eb 05 e8 d9 42 a1 ff 5b 41 5c 41 5d 41 5e 41 5f 5d e9 9a a0 6a 09 cc e8 c4 42 a1 ff 90 <0f> 0b 90 eb e5 e8 b9 42 a1 ff 90 0f 0b 90 eb da 48 c7 c1 70 b5 e4
RSP: 0018:ffffc9000c487368 EFLAGS: 00010293
RAX: ffffffff821f540c RBX: 0000000000000000 RCX: ffff88805edc1e40
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52001890e70 R12: ffff88814d805d00
R13: 1ffff1100d65a80c R14: dffffc0000000000 R15: 0000000000000080
FS:  00007f73df6f86c0(0000) GS:ffff8881257be000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31963fff CR3: 000000002f73a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 huge_pmd_unshare+0x2c8/0x540 mm/hugetlb.c:7622
 __unmap_hugepage_range+0x6e3/0x1aa0 mm/hugetlb.c:5901
 unmap_hugepage_range+0x32e/0x410 mm/hugetlb.c:6089
 hugetlb_vmdelete_list+0x264/0x310 fs/hugetlbfs/inode.c:517
 hugetlb_vmtruncate fs/hugetlbfs/inode.c:667 [inline]
 hugetlbfs_setattr+0x4d1/0x6d0 fs/hugetlbfs/inode.c:905
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
RIP: 0033:0x7f73de78eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f73df6f8038 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f73de9e5fa0 RCX: 00007f73de78eec9
RDX: 0000000000000100 RSI: 000000000014927e RDI: 0000200000000340
RBP: 00007f73de811f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f73de9e6038 R14: 00007f73de9e5fa0 R15: 00007ffe0f23a218
 </TASK>


Tested on:

commit:         b5a4da2c Add linux-next specific files for 20250924
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=156434e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=841973c5ab4f4157
dashboard link: https://syzkaller.appspot.com/bug?extid=62edf7e27b2e8f754525
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=114ced34580000


