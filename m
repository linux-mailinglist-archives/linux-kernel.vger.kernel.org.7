Return-Path: <linux-kernel+bounces-781090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 472D6B30D75
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD68D1CE3776
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76B128643F;
	Fri, 22 Aug 2025 04:16:36 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8522A285C9C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755836196; cv=none; b=qJlr3o2j2bYy6b5oe6YR+mZxilyW110AFfAZeX788dgfXCH30vdt9hPBXxEQg1Kvr8JQDFm69BBEyD0AvcIM5sVR3VibEUR1flcKZITKRAufvQVSRBIkIwHwv6x2x7FXiRBz8835DKNDULjPoqihdo+/5SgJQbqx7dBIuHgceJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755836196; c=relaxed/simple;
	bh=j0Y/IfFVjlXLBC4I3A/gXSt4jLrb/HR2+4WyXBZEyh0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HGCWZSGGJG0EYUzP4m40UwhE2K0dSfnc5lhvQVE9SXc3VMk4EaXmvGaMruDhFj1rjzwnJXm/KVloWvTQ0gXlgUNSojon/Sbdxs7bKKSYEBuxEyY3FP2he9pJsbTUM9N+Ru/MlqAWamPsn7dGtlZLemuCTMMrgLFhuk/hTIcEPcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3e6e61caefeso38126375ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755836193; x=1756440993;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S7uvD8/Hh04Ray/dr3eqanRrtzDNDO2JwOba62dm4Lc=;
        b=J0Ljm0J/PJR0ltgWbJmnr9b42IZHKgZsycFKy1pRBuiNnGAxghi3Pu9pIO81lyCNof
         Oikp0xOCYsdRLEBWLoCcehfZL881+DCuO12VsXIR16E0NQoJIjGVTNWOVIH2LPo3EuAk
         yAnnRlmVt1ticiZ15ZAwsSG/7DJkIzqzERG+XbPXMjLkdP4wKW6EKT4RS74KpqDqRPiw
         J0ih5dHAwsZ8G7peQja6k/2+DuNJebFujg4v98hLWUrdxGAkAi3Rd9IKw54sK+PxtTJq
         9XNHN+vicYiBaDWrAur/0q3/t5pIuMJFmYOP0ivQG5HRovohmgGYjRlaQoGmpUlgKtPd
         tJaA==
X-Forwarded-Encrypted: i=1; AJvYcCWWacBFjtHTpyVeEapv8iXU+EPYdc009pIXngUIC97J7H6IMtRintaw009pxcP6XJxf+qFBatKYyT9CMJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI8euR3UALXjvVmjhygf4uqMVJXnigeyK3O8EoxQY4njqK8/AL
	mk0WzU2hJwEjtsW53xW/9QgEE1YqqdwiGy2IG3H4+X7HokMwNJ0WIXg/7Q/p0GS4HtVYnWMFlud
	viaQX/a6BrmIab6YFTdlYAOan2BIqBcBKcWLIllc661SZ8l7JSe66zj9Oa0Q=
X-Google-Smtp-Source: AGHT+IFwaCdiJ7lqFBsIffoZ1+cf64BbbV3JJhJA0zUvyfvTiZhbAzeFa5Q4fe2blHl8Ox+pYco9jyeLZObmcrIFIR5B/RD+Y5iA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c6:b0:3e5:6a2e:e3bb with SMTP id
 e9e14a558f8ab-3e921a5d824mr30051815ab.13.1755836192799; Thu, 21 Aug 2025
 21:16:32 -0700 (PDT)
Date: Thu, 21 Aug 2025 21:16:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a7ef20.050a0220.37038e.004d.GAE@google.com>
Subject: [syzbot] [mm?] kernel BUG in page_table_check_set
From: syzbot <syzbot+49a796ed2c9709652f1e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, pasha.tatashin@soleen.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15f926f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
dashboard link: https://syzkaller.appspot.com/bug?extid=49a796ed2c9709652f1e
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15faa7a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144143bc580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/18a2e4bd0c4a/disk-8f5ae30d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3b5395881b25/vmlinux-8f5ae30d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e875f4e3b7ff/Image-8f5ae30d.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+49a796ed2c9709652f1e@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/page_table_check.c:118!
Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 6740 Comm: syz.0.17 Not tainted 6.17.0-rc1-syzkaller-g8f5ae30d69d7 #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : page_table_check_set+0x584/0x590 mm/page_table_check.c:118
lr : page_table_check_set+0x584/0x590 mm/page_table_check.c:118
sp : ffff80009c9674c0
x29: ffff80009c9674d0 x28: ffff80008fae0000 x27: 0000000000000002
x26: ffff0000c079ca80 x25: 0000000000000001 x24: 0000000000000001
x23: ffff0000c079ca80 x22: 000000000012b950 x21: 0000000000000001
x20: 0000000000000003 x19: 1ffff00012eb65b0 x18: 0000000000000000
x17: 0000000000000000 x16: ffff800080528a28 x15: 0000000000000001
x14: 1fffe000180f3950 x13: 0000000000000000 x12: 0000000000000000
x11: ffff6000180f3951 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000cdb05b80 x7 : ffff800080d16554 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff800080d15b5c
x2 : 0000000000000001 x1 : 0000000000000002 x0 : 0000000000000001
Call trace:
 page_table_check_set+0x584/0x590 mm/page_table_check.c:118 (P)
 __page_table_check_ptes_set+0x2a8/0x2e0 mm/page_table_check.c:209
 page_table_check_ptes_set include/linux/page_table_check.h:76 [inline]
 __set_ptes_anysz arch/arm64/include/asm/pgtable.h:709 [inline]
 __set_ptes+0x4a0/0x504 arch/arm64/include/asm/pgtable.h:741
 contpte_set_ptes+0x120/0x188 arch/arm64/mm/contpte.c:464
 set_ptes arch/arm64/include/asm/pgtable.h:1794 [inline]
 modify_prot_commit_ptes+0x4e4/0x694 arch/arm64/mm/mmu.c:1556
 prot_commit_flush_ptes mm/mprotect.c:197 [inline]
 commit_anon_folio_batch mm/mprotect.c:246 [inline]
 set_write_prot_commit_flush_ptes mm/mprotect.c:273 [inline]
 change_pte_range mm/mprotect.c:354 [inline]
 change_pmd_range mm/mprotect.c:570 [inline]
 change_pud_range mm/mprotect.c:633 [inline]
 change_p4d_range mm/mprotect.c:659 [inline]
 change_protection_range mm/mprotect.c:687 [inline]
 change_protection+0x1e84/0x3ff0 mm/mprotect.c:721
 mprotect_fixup+0x504/0x744 mm/mprotect.c:837
 do_mprotect_pkey+0x864/0xb30 mm/mprotect.c:993
 __do_sys_mprotect mm/mprotect.c:1014 [inline]
 __se_sys_mprotect mm/mprotect.c:1011 [inline]
 __arm64_sys_mprotect+0x80/0x98 mm/mprotect.c:1011
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
Code: d4210000 97e865fd d4210000 97e865fb (d4210000) 
---[ end trace 0000000000000000 ]---


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

