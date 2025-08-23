Return-Path: <linux-kernel+bounces-782904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011CAB326A8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 05:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CC7A23D65
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8431D90DF;
	Sat, 23 Aug 2025 03:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz1p+MBM"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E161917F4
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 03:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755919861; cv=none; b=YyVtFAA73Qc2bFah54SFbHNBcHsp5C/CzVjunb5ercOighg4zS073z9K3d78afNIsBorACL+vfmKkiQweTVn9JDYNLQqt39IYfQ5m2wDX5q1QGeTwqzbKtCn+LSQKHOLqLVcc88mieP9rVSGpYeP565LO7aPKpaV571Pw/f0yXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755919861; c=relaxed/simple;
	bh=tvhPGSUhLYLbwhF0ZZrFKM8VEjkZx9vuqftGiXwnzPQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=lGPMJYRdHhZ5mYH1YBY4MFWHA0bsxEtCgeaa/zKvvqpUHdElcbOCnpfWYR40ET9FNdZisLA1brde2NeYlgzjoeBtVvZ51iuCK5lef8tZmye+s6D27Mc/zm1LG+PaQ3qbPxU4rf5SdIY4q+60Jwq31GQFtgtruaXjVlbNBUTlvyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lz1p+MBM; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b47052620a6so2803955a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 20:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755919858; x=1756524658; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D2PoBOZMCYl8EkuZw0KQkOT5J11R7R6GRcyZnZYHv98=;
        b=Lz1p+MBMxQyTpqCG0tOSaeJmwV9DmU2Cfkm9P7R6ktKTndF6uv6nohsniJrsr0AVV3
         PxvVgg6O5uIyYn7rTWP3Li0Dux+MC7ELMk9tFyNiwSD4nxHSiII2/DPK9RKAw/ISfF+5
         A0wttbqFTvLfTOJEy5Kp0nV4JGFMIHfE3KdcSyaSZ8Aw5rtCK9rPKT5QVwGXYbu4ANv9
         mUNQjeQL4luyPfPSAOBZmED/Tll9pfcSjzr7TUj9bQBQc8m4dWibI/hjnKCaxov/JB/0
         P2g6eG//DYfUfVezhlVjUYt2m1BXpsxEAHVf0zAyam32f+a3gBw5ofTPxAHG6hmLR78A
         xdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755919858; x=1756524658;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2PoBOZMCYl8EkuZw0KQkOT5J11R7R6GRcyZnZYHv98=;
        b=qT871I8o6SSvA9rD+h878xMsalB3YmHoBSMTFh450t0W10qxlsJGmrt6Y727L9bODq
         3odSYO8qpzcifdSiDqr5r1Ie9m5FeZSJg7ADigx7Cv6aaEc82kvRI81LDF67K4DahyTr
         daVKDhydyUEahIzkRoSwUFPtmh7LPHGK01FFCLplimhh+hWN7Q6v7y8vr+iNWumkjFTi
         hEy3ExnFVrN6UqQI1hzqbfq5SFrQ6Z+dHTMb5c2wPuMJzBidZ/fGnA4dU/TCebfb0l9F
         MdakfkVrEph3SMYjeo45ONNxtYQ66267dIHIetSidp9KWAb/2sbwdVpYoK8r2g+lTVQA
         YlyQ==
X-Gm-Message-State: AOJu0YyDBsLC4koItn6/nl5hLS46xhRoEuvoqg/xNrW4qqwcLvCFE3SE
	7VeltNajlAThNKP0UM5vjQHnrbLSVkrq0TEnP0qzjq+5za3+aFmJwjXv
X-Gm-Gg: ASbGncsl9ssfYgOuuUnGF7Is8Wnark11AydeEBEqw20tl0RQ3TfNc8cV+6BXqjyfqSq
	2AyYx9dDU0Vycz2VL22u522SAtgiqPnpi7+GgX8IuUR9DhM0VOH9RCq9eyLwkAaoBgkq1IBMz9D
	vLLHPV1/cCf1uSUZlTbTfCAWqp+1Wp272IJubA10ce7oavvQh1gzSYY8Vjwqchn0V6kwoj+HmyS
	Kb4nxFmmpJClzTI0rVEfsPxwFb+9sx6eseQeStSKl+v9gK/65tC4CQZFF0GZIrB0B78FRoat/xh
	2LzMQzlU6azR0R8cLGR5znQ4u9lD1pgbEwYo4f+h1may8DExDyw6AP0WslBj23wG7f0e3n/dCNe
	OECq2QI7lt+0Hzw==
X-Google-Smtp-Source: AGHT+IFmj7aQFwvEpvF0QoxrLVJzRODk9vf1gxSaWNQf3S/lCJxMZH19RSe9Ih133SJS671Y8wg+rQ==
X-Received: by 2002:a17:903:3d0c:b0:234:8a4a:ad89 with SMTP id d9443c01a7336-2463292ce7cmr60060995ad.1.1755919858315;
        Fri, 22 Aug 2025 20:30:58 -0700 (PDT)
Received: from dw-tp ([171.76.85.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668879763sm10092605ad.108.2025.08.22.20.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 20:30:57 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, syzbot <syzbot+49a796ed2c9709652f1e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, pasha.tatashin@soleen.com, syzkaller-bugs@googlegroups.com, Andrew
 Donnellan <ajd@linux.ibm.com>
Subject: Re: [syzbot] [mm?] kernel BUG in page_table_check_set
In-Reply-To: <20250822181653.cd2024360870ef94cdb7db07@linux-foundation.org>
Date: Sat, 23 Aug 2025 08:53:28 +0530
Message-ID: <875xeeafgv.fsf@gmail.com>
References: <68a7ef20.050a0220.37038e.004d.GAE@google.com> <20250822181653.cd2024360870ef94cdb7db07@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Andrew Morton <akpm@linux-foundation.org> writes:

> On Thu, 21 Aug 2025 21:16:32 -0700 syzbot <syzbot+49a796ed2c9709652f1e@syzkaller.appspotmail.com> wrote:
>
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>> console output: https://syzkaller.appspot.com/x/log.txt?x=15f926f0580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
>> dashboard link: https://syzkaller.appspot.com/bug?extid=49a796ed2c9709652f1e
>> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
>> userspace arch: arm64
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15faa7a2580000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144143bc580000
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/18a2e4bd0c4a/disk-8f5ae30d.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/3b5395881b25/vmlinux-8f5ae30d.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/e875f4e3b7ff/Image-8f5ae30d.gz.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+49a796ed2c9709652f1e@syzkaller.appspotmail.com
>> 
>> ------------[ cut here ]------------
>> kernel BUG at mm/page_table_check.c:118!
>
> Thanks.
>
> Presumably due to the series "Support page table check on PowerPC". 

The syzbot triggered this on:
 HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
 git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci

This tree does not have "Support page table check on PowerPC", correct?

Also, I guess Dev's change fixes this reported problem which could happen in
this path: commit_anon_folio_batch() -> change_pte_range() ... 

[1]: https://lore.kernel.org/all/20250812060124.C9344C4CEF0@smtp.kernel.org/
[2]: https://lore.kernel.org/all/68a80cc6.050a0220.3809a8.0002.GAE@google.com/

-ritesh


> Andrew, could you please take a look?
>
> The series has been in mm.git for a week so I guess the impact of this
> is small.  I won't drop it at this time, but prompt attention would be
> appreciated.
>
>> Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
>> Modules linked in:
>> CPU: 1 UID: 0 PID: 6740 Comm: syz.0.17 Not tainted 6.17.0-rc1-syzkaller-g8f5ae30d69d7 #0 PREEMPT 
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
>> pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
>> pc : page_table_check_set+0x584/0x590 mm/page_table_check.c:118
>> lr : page_table_check_set+0x584/0x590 mm/page_table_check.c:118
>> sp : ffff80009c9674c0
>> x29: ffff80009c9674d0 x28: ffff80008fae0000 x27: 0000000000000002
>> x26: ffff0000c079ca80 x25: 0000000000000001 x24: 0000000000000001
>> x23: ffff0000c079ca80 x22: 000000000012b950 x21: 0000000000000001
>> x20: 0000000000000003 x19: 1ffff00012eb65b0 x18: 0000000000000000
>> x17: 0000000000000000 x16: ffff800080528a28 x15: 0000000000000001
>> x14: 1fffe000180f3950 x13: 0000000000000000 x12: 0000000000000000
>> x11: ffff6000180f3951 x10: 0000000000ff0100 x9 : 0000000000000000
>> x8 : ffff0000cdb05b80 x7 : ffff800080d16554 x6 : 0000000000000000
>> x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff800080d15b5c
>> x2 : 0000000000000001 x1 : 0000000000000002 x0 : 0000000000000001
>> Call trace:
>>  page_table_check_set+0x584/0x590 mm/page_table_check.c:118 (P)
>>  __page_table_check_ptes_set+0x2a8/0x2e0 mm/page_table_check.c:209
>>  page_table_check_ptes_set include/linux/page_table_check.h:76 [inline]
>>  __set_ptes_anysz arch/arm64/include/asm/pgtable.h:709 [inline]
>>  __set_ptes+0x4a0/0x504 arch/arm64/include/asm/pgtable.h:741
>>  contpte_set_ptes+0x120/0x188 arch/arm64/mm/contpte.c:464
>>  set_ptes arch/arm64/include/asm/pgtable.h:1794 [inline]
>>  modify_prot_commit_ptes+0x4e4/0x694 arch/arm64/mm/mmu.c:1556
>>  prot_commit_flush_ptes mm/mprotect.c:197 [inline]
>>  commit_anon_folio_batch mm/mprotect.c:246 [inline]
>>  set_write_prot_commit_flush_ptes mm/mprotect.c:273 [inline]
>>  change_pte_range mm/mprotect.c:354 [inline]
>>  change_pmd_range mm/mprotect.c:570 [inline]
>>  change_pud_range mm/mprotect.c:633 [inline]
>>  change_p4d_range mm/mprotect.c:659 [inline]
>>  change_protection_range mm/mprotect.c:687 [inline]
>>  change_protection+0x1e84/0x3ff0 mm/mprotect.c:721
>>  mprotect_fixup+0x504/0x744 mm/mprotect.c:837
>>  do_mprotect_pkey+0x864/0xb30 mm/mprotect.c:993
>>  __do_sys_mprotect mm/mprotect.c:1014 [inline]
>>  __se_sys_mprotect mm/mprotect.c:1011 [inline]
>>  __arm64_sys_mprotect+0x80/0x98 mm/mprotect.c:1011
>>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>>  el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
>>  el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
>>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
>> Code: d4210000 97e865fd d4210000 97e865fb (d4210000) 
>> ---[ end trace 0000000000000000 ]---
>> 
>> 
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>> 
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> 
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>> 
>> If you want syzbot to run the reproducer, reply with:
>> #syz test: git://repo/address.git branch-or-commit-hash
>> If you attach or paste a git patch, syzbot will apply it before testing.
>> 
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>> 
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>> 
>> If you want to undo deduplication, reply with:
>> #syz undup

