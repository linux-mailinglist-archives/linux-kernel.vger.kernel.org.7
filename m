Return-Path: <linux-kernel+bounces-788980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B57B38EFC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 01:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35703BAEFF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 23:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B95728689A;
	Wed, 27 Aug 2025 23:15:34 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3706F30CD80
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 23:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756336533; cv=none; b=bmTscG3oAQRKNwMM25JPH43nr9E5dYVlyUonvMAo7wBZ6U7f4+fWxlocLig/8ZfQ1JYyShT6pBiohM45NuUsWWSbX0ytX9BVYoGflQ/K4/zp9u4EbLUbVsmMoZUr3/Wj0ABqxwQedRhaxiQ8JihgypdikhIrSl/5yQzL4+JMWo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756336533; c=relaxed/simple;
	bh=kEjl+u/cqC+s6i1mXOFWfgoaJnO8Kvnla8FlkCnSAn8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=koGK0FvhZwAu07u15cdoVbdrNP2hbwlVWy5CFnFXwJsgPu/kgT+A2zP9YD6IhOiEUVK/KbzFxD/pKyI+ecbeAZWYfb0aPYkJ/HTdWvia+nd2JlyNLdh5Dud/hNmMwWml5Kj2zD6d09XDK0N4g0O+HRG3Wmm9pScc/p9HMmt6mZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-884418a2614so78393039f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 16:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756336531; x=1756941331;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGDUKp6Jifkzk/nND6NoukxFoNU6RlGCAv9Hj9lFmmg=;
        b=bnjUztDZnxJ9+oBiOTrCtiGluCGyEfdNxdUN1KFZ4lLCGQf2h1+LDFAQEZkbJfqkcI
         8GuiO6ev+qWh/ArGQvU3b3dTwIlopl7QkdnLEZPincRTYgVEcqSKP/7m+rP9SF5zYKpp
         /YdEuM79hJuTeEnE/fHzDmig5McJ7nl+Cw/QtRabUctMsWYCuFfWlqRxWYMLr0XjK1nN
         3RBY6ZXZcYEzQrgV03iSxXl+zSQxKNHwMv43JhMfL3i4beyFlCxxFm6EcT3jq+eiAOcx
         TdGKDHElKKOakb+jW9zAfWsl+T7IZRNJd7v9pPl29JNeAoBCBvo3Xps/GI7NN693BNqt
         kDUA==
X-Forwarded-Encrypted: i=1; AJvYcCW3f8ylHTVz+UkpRwfmM0TEu26ZXiSwW6ZK/4x6g7HL1Sx3DGFgOLm+oRLxiqE/OkzhTeHK5ksaArLblSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpoI1wjjbNgNAU7E1IqJ5bRi5glInmOxuBscQZOjuy7eUuev3S
	HhukAyf5hXVTwUJZ4QCz5xkSaWdQGLcCGtztB9P5ZTfFuIzU1YBKkyCbg7I1orGDloz16VNs45v
	iXV43KfOFlvIHG9x/zgKXMOYyMx2iiNSEVwcCsr8Yvvifqj8yucJqnbYaCvA=
X-Google-Smtp-Source: AGHT+IGBD/jbzm4LO4d90l1K5n08kpgz7DPRgUulbX5bDNiMrQfC/SyAfyapVvZs2qeQ1RInlZ/3O5lc9bXiObx+3TsyrG9ODKBe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa3:b0:3ef:88d6:1cfc with SMTP id
 e9e14a558f8ab-3ef88d61d2amr82393825ab.24.1756336531207; Wed, 27 Aug 2025
 16:15:31 -0700 (PDT)
Date: Wed, 27 Aug 2025 16:15:31 -0700
In-Reply-To: <68abd1c8.050a0220.37038e.0083.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68af9193.a00a0220.2929dc.0006.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in copy_process
From: syzbot <syzbot+69c74d38464686431506@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, bsegall@google.com, 
	david@redhat.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com, 
	kees@kernel.org, liam.howlett@oracle.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, mgorman@suse.de, 
	mhocko@suse.com, mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	rppt@kernel.org, surenb@google.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz, vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    7fa4d8dc380f Add linux-next specific files for 20250821
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1036def0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae76068823a236b3
dashboard link: https://syzkaller.appspot.com/bug?extid=69c74d38464686431506
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13595c62580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63178c6ef3f8/disk-7fa4d8dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c5c27b0841e0/vmlinux-7fa4d8dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9a8832715cca/bzImage-7fa4d8dc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+69c74d38464686431506@syzkaller.appspotmail.com

------------[ cut here ]------------
pvqspinlock: lock 0xffff8881c5419bc0 has corrupted value 0x0!
WARNING: kernel/locking/qspinlock_paravirt.h:506 at __pv_queued_spin_unlock_slowpath+0x1fe/0x2a0 kernel/locking/qspinlock_paravirt.h:504, CPU#1: syz.6.106/8286
Modules linked in:
CPU: 1 UID: 0 PID: 8286 Comm: syz.6.106 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__pv_queued_spin_unlock_slowpath+0x1fe/0x2a0 kernel/locking/qspinlock_paravirt.h:504
Code: f8 a8 9b f6 48 89 d8 48 c1 e8 03 42 0f b6 04 28 84 c0 0f 85 93 00 00 00 8b 13 48 c7 c7 00 0c ab 8b 48 89 de e8 73 9c fb f5 90 <0f> 0b 90 90 eb 95 48 c7 c7 90 e4 40 8e 4c 89 f6 4c 89 fa e8 fa c5
RSP: 0018:ffffc900100c78c0 EFLAGS: 00010246
RAX: 9e0501aa69750800 RBX: ffff8881c5419bc0 RCX: ffff8881921f9e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 1ffff11038a83379 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1c7a604 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff8881c5419bd0 R15: ffff8881c5419bc8
FS:  0000555565514500(0000) GS:ffff8881258c4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8801a12e9c CR3: 00000001d6f0c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __raw_callee_save___pv_queued_spin_unlock_slowpath+0x15/0x30
 .slowpath+0x9/0x18
 pv_queued_spin_unlock arch/x86/include/asm/paravirt.h:562 [inline]
 queued_spin_unlock arch/x86/include/asm/qspinlock.h:57 [inline]
 do_raw_spin_unlock+0x122/0x240 kernel/locking/spinlock_debug.c:142
 __raw_spin_unlock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_unlock+0x1e/0x50 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:391 [inline]
 copy_process+0x2793/0x3c00 kernel/fork.c:2435
 kernel_clone+0x21e/0x840 kernel/fork.c:2608
 __do_sys_clone3 kernel/fork.c:2912 [inline]
 __se_sys_clone3+0x256/0x2d0 kernel/fork.c:2891
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb44b1c3449
Code: d7 08 00 48 8d 3d fc d7 08 00 e8 12 29 f6 ff 66 90 b8 ea ff ff ff 48 85 ff 74 2c 48 85 d2 74 27 49 89 c8 b8 b3 01 00 00 0f 05 <48> 85 c0 7c 18 74 01 c3 31 ed 48 83 e4 f0 4c 89 c7 ff d2 48 89 c7
RSP: 002b:00007ffc514a7578 EFLAGS: 00000206 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007fb44b145860 RCX: 00007fb44b1c3449
RDX: 00007fb44b145860 RSI: 0000000000000058 RDI: 00007ffc514a75c0
RBP: 00007fb44a7fe6c0 R08: 00007fb44a7fe6c0 R09: 00007ffc514a76a7
R10: 0000000000000008 R11: 0000000000000206 R12: ffffffffffffffa8
R13: 000000000000000b R14: 00007ffc514a75c0 R15: 00007ffc514a76a8
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

