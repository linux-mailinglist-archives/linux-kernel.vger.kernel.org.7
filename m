Return-Path: <linux-kernel+bounces-800129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FE4B433BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D3B5E2D90
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEED929B79A;
	Thu,  4 Sep 2025 07:22:38 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89DB29ACC2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970558; cv=none; b=J+9xQZcDh7bSw1arNsxyzRa5jQhstjNPbYG45cB2R7WL+k39IRTJebvb/LHUbJknXHt0dJcuHOBJuA1KHTtaBW/msUV15H/1sna0Ut98PTkDiMAVAvbDrsu0PiZi+kE+nLmZP5Tmqs0MFoOLyL80YtBa+azo33rT8XyjXnsZUsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970558; c=relaxed/simple;
	bh=KppOLAdsUJo2qiBy+tz0vcNBJLzvlC3nWx+sS0nqn4E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iS2v9kHJrn1LUe8TTphN0CEPIj0NL3YnBW86exwZNnhLCVasVk7pGnCC2c9157KZxz3xexH6IxucT2tovGSvsj2lCxgRVkhvXXg6+pKrq4Rr7z6TIFER+YBwaYcikE4d6J77LdpLoJAVbFy8u9pwlpIPqMvq/2BordeO2t5HyHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-8870b07643bso66333139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 00:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756970556; x=1757575356;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OcjnFAjuxl7mwvEumPZ/g5Nvfxg6mUeVW++dB5oB3ok=;
        b=W8VG37/0puFhSpAFhuE0eEpfKD+EFRFD3yCyf2dT8Hjg/d258s/ruPmPQzHMWJgf0u
         T6CF3Ad9SB7u6TwgGXJar38oVTplvjY2MfgYSmDlJcJj5CCWTZPxWsguandISylWeGHy
         uwOE1gnoNfYGG310tmILNzpNAiQa6nnvi0Hlv4GyxEelo76ka7YUL2LJBkyaIiP2dpsy
         ulf98mcZJi5SJ0wJo3g9jTVnUSfdyNk44Y4SaE8hce7KFkkGqtADFw3ySKCTbsKpOaoD
         Dz7xGglwQQRQ2LNFNqAymfz4UIDyhJkAXYc1XRBs1Vlj7A7/40fxUN5fDYAoEHZBKkWY
         Jofw==
X-Gm-Message-State: AOJu0YyDA/5ewJdvm/phdINzWXrSSCMgg5M9PE3b9weuBcKhhkB1ukt+
	j8vc4auRbGo14CHyKgOEoIz09if0NKgCXHPFyJwiA6pxrf7GiZZghXpk3p7L+Y80v1bVs+Ki/D2
	rBd+YQ6n+B8arttt2l4fIMwKqEb2UIrCMHTdaaPo3w47YFB3pQwSRF8goSCI1oQ==
X-Google-Smtp-Source: AGHT+IFH8Oxon5L9NQ69KTnQ3pI0VZnQ3c6nHD/sGZeIi99K6vhk7/LtWIvBqibZfC0k280KbwM0qDIsCy9hYMeCboRRDgfA+l2w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:228a:b0:3f6:58b8:4da5 with SMTP id
 e9e14a558f8ab-3f658b84e04mr114306935ab.5.1756970556044; Thu, 04 Sep 2025
 00:22:36 -0700 (PDT)
Date: Thu, 04 Sep 2025 00:22:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b93e3c.a00a0220.eb3d.0000.GAE@google.com>
Subject: [syzbot] [kernel?] INFO: trying to register non-static key in
 skb_dequeue (4)
From: syzbot <syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5d50cf9f7cf2 Add linux-next specific files for 20250903
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12fade62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d2429dff5531d80
dashboard link: https://syzkaller.appspot.com/bug?extid=bb185b018a51f8d91fd2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b9a312580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16819e62580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/779c4c33db6a/disk-5d50cf9f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f80abaffa076/vmlinux-5d50cf9f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/65fcb4766d7b/bzImage-5d50cf9f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com

RBP: 00007ffc4d7c4a10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fc6a7fc5fa0 R14: 00007fc6a7fc5fa0 R15: 0000000000000003
 </TASK>
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 6073 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 assign_lock_key+0x133/0x150 kernel/locking/lockdep.c:984
 register_lock_class+0x105/0x320 kernel/locking/lockdep.c:1299
 __lock_acquire+0x99/0xd20 kernel/locking/lockdep.c:5112
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
 skb_dequeue+0x2e/0x150 net/core/skbuff.c:3897
 audit_buffer_free kernel/audit.c:1820 [inline]
 audit_buffer_alloc kernel/audit.c:1850 [inline]
 audit_log_start+0x47b/0xa90 kernel/audit.c:1954
 audit_seccomp+0x64/0x190 kernel/auditsc.c:2976
 seccomp_log kernel/seccomp.c:1048 [inline]
 __seccomp_filter+0x9a0/0x1a30 kernel/seccomp.c:1344
 syscall_trace_enter+0xaa/0x160 kernel/entry/syscall-common.c:44
 syscall_enter_from_user_mode_work include/linux/entry-common.h:95 [inline]
 syscall_enter_from_user_mode include/linux/entry-common.h:125 [inline]
 do_syscall_64+0xd3/0xfa0 arch/x86/entry/syscall_64.c:90
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc6a7d8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc4d7c49b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007fc6a7fc5fa0 RCX: 00007fc6a7d8ebe9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffffffffff
RBP: 00007ffc4d7c4a10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fc6a7fc5fa0 R14: 00007fc6a7fc5fa0 R15: 0000000000000003
 </TASK>
audit: audit_lost=1 audit_rate_limit=0 audit_backlog_limit=64
audit: out of memory in audit_log_start


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

