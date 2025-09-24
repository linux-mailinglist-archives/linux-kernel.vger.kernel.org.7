Return-Path: <linux-kernel+bounces-830385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37D1B9985C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4634F7ABBF2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255332E4266;
	Wed, 24 Sep 2025 11:02:10 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CCF2DECD3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758711729; cv=none; b=C5jzsZUOrwYEX4XYE/+EuGTGZsPRVI6F7zPGCzWofNd8o9PfuNrm+pn9Wro3pbkSE7P1Kzlx+DttUp+IJ4UrSIASovXIxHC7Rh2UOyKbh6Ng3lI1KHyJYwwX8RdB4SSY5GBHPQthEq5UZ1r9S5F/TazJNqPeU4mpI53zFwpIl38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758711729; c=relaxed/simple;
	bh=Tb9enl8DiV6BO7835oLvIgPigsCcIfJUYclx9xA1aNw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OO5ieHPbx2vv+JoBAVuP5GnLqRPpi8JCgTSfzitJ9wo8kYx7pdq3pUbkdaTEIbSMdwnWMTnXNbiw37YMG3A9fqj6gxtResVRmJhkdDFvk8BKrvm4HldaVZWEno7hQcwXm8cONBhHJH8vkG927Oi+vK+YSizMXjXLjsIoj238aBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42575c5c876so41001875ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758711723; x=1759316523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u14xAhFIYJ8iBrwgxzSPy3VprpDahf7H052DcuYQois=;
        b=l13qP/MLQU9POVOTXn2OJILd1ocwd6OMuSaUnR0GlP2U+aw2CvONND7buzW3LNieLk
         dQ/gzpjsbYBtBQ4YTE90w4W6Y7VZmqq4bMyeAb3J9uNHdFymzePVx72S5oBKuRLhwZl6
         pE7nSdRQzAKGJoJTXprT2Hgw6GKRREtKoQ7Vy0IqV+c0Bl+vi7VSznVxh0w+dMkpcOHF
         4feyU+IRFsvZPEY9ACq+LaqrsSZp3v002jxovh45k3M6hWzfTFTwjgRsiGiVkGoAcv/X
         TKoBA6I4bGV72Vp7IhvY8LDcaSbScpxM2Yslp57oekn2VIIj/AWu5vZAuxz0Gq/LU3cy
         l8iA==
X-Forwarded-Encrypted: i=1; AJvYcCUta9dun4BdcZ8tt1+I0X2tsCsl6l4hDPdrfTPefdJ5L4BsliLJbDPvmTaPjnWp60r1FPopT7aqhN0QV8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7QaYwCbMGMsv/lpiNdCgHUvnJjqvFq/kBbXfJhUAVwALNmSjH
	8Zyw+p3q4+KW6onZxOPWBBaKyJCWT/jVbaPwYE7xqI4IxQVqHAp+ULnREtqHJaScqTT7BL2lkw6
	jrtELWum2YJpo9T/HwMRehe78HEhsBbvlAJliXFOCzy5p2FxX5n3eRK8Y854=
X-Google-Smtp-Source: AGHT+IH+siDKdFbZtTVGW7dEqtBN8fVjf37uuXsXnaxWSUi3MPhiVKouuoIOYEvnmll1Nb6gVcfOyLsShM3X1S1juwr/6D+VKpm3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2181:b0:424:71e8:3a2e with SMTP id
 e9e14a558f8ab-42581e7a670mr75765285ab.16.1758711722915; Wed, 24 Sep 2025
 04:02:02 -0700 (PDT)
Date: Wed, 24 Sep 2025 04:02:02 -0700
In-Reply-To: <20250924100341.1255033-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d3cfaa.a70a0220.1b52b.02c9.GAE@google.com>
Subject: Re: [syzbot] [fs?] [mm?] WARNING: bad unlock balance in hugetlb_vmdelete_list
From: syzbot <syzbot+62edf7e27b2e8f754525@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in hugetlb_vma_assert_locked

------------[ cut here ]------------
WARNING: mm/hugetlb.c:368 at hugetlb_vma_assert_locked+0x1dd/0x250 mm/hugetlb.c:368, CPU#1: syz.0.28/6594
Modules linked in:
CPU: 1 UID: 0 PID: 6594 Comm: syz.0.28 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:hugetlb_vma_assert_locked+0x1dd/0x250 mm/hugetlb.c:368
Code: 2e e8 97 6e a1 ff eb 0c e8 90 6e a1 ff eb 05 e8 89 6e a1 ff 5b 41 5c 41 5d 41 5e 41 5f 5d e9 da 41 6a 09 cc e8 74 6e a1 ff 90 <0f> 0b 90 eb e5 e8 69 6e a1 ff 90 0f 0b 90 eb da 48 c7 c1 70 7c e4
RSP: 0018:ffffc90003637368 EFLAGS: 00010293
RAX: ffffffff821f22cc RBX: 0000000000000000 RCX: ffff888030330000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff520006c6e70 R12: ffff888026856500
R13: 1ffff1100bd744fc R14: dffffc0000000000 R15: 0000000000000080
FS:  00007fb2310906c0(0000) GS:ffff8881258c5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb23108ff98 CR3: 0000000075cce000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 huge_pmd_unshare+0x2c8/0x540 mm/hugetlb.c:7622
 __unmap_hugepage_range+0x6e3/0x1aa0 mm/hugetlb.c:5901
 unmap_hugepage_range+0x32e/0x410 mm/hugetlb.c:6089
 hugetlb_vmdelete_list+0x189/0x1f0 fs/hugetlbfs/inode.c:495
 hugetlb_vmtruncate fs/hugetlbfs/inode.c:643 [inline]
 hugetlbfs_setattr+0x4d1/0x6d0 fs/hugetlbfs/inode.c:881
 notify_change+0xc1a/0xf40 fs/attr.c:546
 do_truncate+0x1a4/0x220 fs/open.c:68
 handle_truncate fs/namei.c:3516 [inline]
 do_open fs/namei.c:3899 [inline]
 path_openat+0x306c/0x3830 fs/namei.c:4054
 do_filp_open+0x1fa/0x410 fs/namei.c:4081
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_open fs/open.c:1460 [inline]
 __se_sys_open fs/open.c:1456 [inline]
 __x64_sys_open+0x11e/0x150 fs/open.c:1456
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb23018eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb231090038 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fb2303e5fa0 RCX: 00007fb23018eec9
RDX: 0000000000000100 RSI: 000000000014927e RDI: 0000200000000340
RBP: 00007fb230211f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb2303e6038 R14: 00007fb2303e5fa0 R15: 00007fff95fa5748
 </TASK>


Tested on:

commit:         ce7f1a98 Add linux-next specific files for 20250923
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=129a4d34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1be6fa3d47bce66e
dashboard link: https://syzkaller.appspot.com/bug?extid=62edf7e27b2e8f754525
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17b2cce2580000


