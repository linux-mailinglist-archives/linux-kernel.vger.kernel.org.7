Return-Path: <linux-kernel+bounces-830333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B1BB996BA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146173A010D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916B82DE6F9;
	Wed, 24 Sep 2025 10:25:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8DA2D8DDB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709508; cv=none; b=bbas0rEwJ4fQXxe4vbZiSnOW6hJhMg3hXSpGCZVlnWh1/m8sLWiwKsBXcPUFgUsGXpgOHOGedJs8hqJErhP4M5bWdCv7G3CmyJ4fPu8krmjz74OP48RLqcxtexS+ybzzG11lFDsYBY9DHaPbgQ+n8Fn5TS7+Sc3CD3IoH9yj5yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709508; c=relaxed/simple;
	bh=21ygPBW0Q2SaQjsHuaYpj6QPvMffcYnhIEppAa/V1S8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=P42LmmbYXfi6R9LpMwAZFkMARtlxJyKyCmcBPZUJcKPOWdGoDxMCjFw0hVLPJ1LYdC2aimV9ccdtWlABP954CbxRT3ZKs++vpMfjQmv1eV9oMgwWLhuZTzhJAwMb6KD/g5Zf1xsTSo7TpZzjQ6PAFWa8nITiRxYhwxQa3+F9K5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4257a4638e0so43600915ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758709502; x=1759314302;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1CU3k4sLAmCdVsOAd+ssKByZLdQKKQqHTFBHY+YAjk=;
        b=ai5LBIxhHHDGwfAcxpAEQhoL9UAJslkEQq6PiCY/iU0jw0QZIfYV/lkRUC3DPMSRH9
         +mP7pMOO+RMpGfMITTcn6CR/fAUa5qu35lcflCllDUKOsyzg8CzYDPWpditLPZmtDZfF
         ESD3Sqs/irVbHsIpG9vsGtCZtWixydGrYp4Fr/k2m7QEcSfbfaGKnw2MdhV4xZSEG2+u
         wt4k33MTvk+vRS5q/d+VCf1qjv1xESpHfOYKj75gOeHlGRfHFgZ0zzBSmtrLnYqiZlmV
         aD2KnHuCxsRkYGHnTNKgXPZr4iTnfGgb9sQaa9X2Jy6svveGX+fWxNNh8ZNu3v6j+5R4
         U/4g==
X-Forwarded-Encrypted: i=1; AJvYcCUUNagdHxNVcxBDvpxq7ozU8VL/Gd75TBpNJpadxYeIqpKXzT+8sAQ6SBhP3JhKOJHY5COh+A/3E/lAgR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5VgdO3LSnyOS0XuXx/PIk+ZF8YZRk58GYoKPcOBsfOqoscOWK
	jDpfKB9sZxhnsse8qyWFupAeZbfVkQqxz+ZfD/G1AXUJoX9OmnC83XHo5kLo/idnDZfj+n2aCCE
	00Kdn968My+1FmiBwbKSYlLvKjFnR2VP3cX5NtBfq/D4RVj6+HIOMjJtMVe4=
X-Google-Smtp-Source: AGHT+IHTU9tjnP6zmsahUHTemrQS6Bvz8UTOBtQSThKQQQb4/XSmcgbf6iWZw6pzKUzWMA7VNk2+/4idCEDNYIlpHU+VsVQEXivP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1709:b0:423:fea3:51e2 with SMTP id
 e9e14a558f8ab-42581eaad31mr79506905ab.21.1758709501778; Wed, 24 Sep 2025
 03:25:01 -0700 (PDT)
Date: Wed, 24 Sep 2025 03:25:01 -0700
In-Reply-To: <tencent_364B6C75BD77B966CC3C1337A0968C36A609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d3c6fd.a70a0220.4f78.001b.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING: bad unlock balance in namespace_unlock
From: syzbot <syzbot+0d671007a95cd2835e05@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: bad unlock balance in copy_process

=====================================
WARNING: bad unlock balance detected!
syzkaller #0 Not tainted
-------------------------------------
syz.2.1222/11521 is trying to release lock (&sighand->siglock) at:
[<ffffffff818337dd>] spin_unlock include/linux/spinlock.h:391 [inline]
[<ffffffff818337dd>] copy_process+0x27bd/0x3c20 kernel/fork.c:2486
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz.2.1222/11521:
 #0: ffffffff8e374a90 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: copy_process+0x2154/0x3c20 kernel/fork.c:2328

stack backtrace:
CPU: 1 UID: 0 PID: 11521 Comm: syz.2.1222 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_unlock_imbalance_bug+0xdc/0xf0 kernel/locking/lockdep.c:5298
 __lock_release kernel/locking/lockdep.c:5537 [inline]
 lock_release+0x269/0x3e0 kernel/locking/lockdep.c:5889
 __raw_spin_unlock include/linux/spinlock_api_smp.h:141 [inline]
 _raw_spin_unlock+0x16/0x50 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:391 [inline]
 copy_process+0x27bd/0x3c20 kernel/fork.c:2486
 kernel_clone+0x21e/0x840 kernel/fork.c:2657
 __do_sys_clone3 kernel/fork.c:2980 [inline]
 __se_sys_clone3+0x292/0x300 kernel/fork.c:2959
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4df65c3609
Code: d7 08 00 48 8d 3d 9c d7 08 00 e8 e2 28 f6 ff 66 90 b8 ea ff ff ff 48 85 ff 74 2c 48 85 d2 74 27 49 89 c8 b8 b3 01 00 00 0f 05 <48> 85 c0 7c 18 74 01 c3 31 ed 48 83 e4 f0 4c 89 c7 ff d2 48 89 c7
RSP: 002b:00007ffef05e2ba8 EFLAGS: 00000206 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007f4df65459f0 RCX: 00007f4df65c3609
RDX: 00007f4df65459f0 RSI: 0000000000000058 RDI: 00007ffef05e2bf0
RBP: 00007f4df73456c0 R08: 00007f4df73456c0 R09: 00007ffef05e2cd7
R10: 0000000000000008 R11: 0000000000000206 R12: ffffffffffffffa8
R13: 000000000000000b R14: 00007ffef05e2bf0 R15: 00007ffef05e2cd8
 </TASK>
------------[ cut here ]------------
pvqspinlock: lock 0xffff8880280b8000 has corrupted value 0x0!
WARNING: kernel/locking/qspinlock_paravirt.h:506 at __pv_queued_spin_unlock_slowpath+0x1fe/0x2a0 kernel/locking/qspinlock_paravirt.h:504, CPU#0: syz.2.1222/11521
Modules linked in:
CPU: 0 UID: 0 PID: 11521 Comm: syz.2.1222 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:__pv_queued_spin_unlock_slowpath+0x1fe/0x2a0 kernel/locking/qspinlock_paravirt.h:504
Code: 88 f8 a4 f6 48 89 d8 48 c1 e8 03 42 0f b6 04 28 84 c0 0f 85 93 00 00 00 8b 13 48 c7 c7 e0 1c ab 8b 48 89 de e8 83 56 03 f6 90 <0f> 0b 90 90 eb 95 48 c7 c7 10 f5 20 8e 4c 89 f6 4c 89 fa e8 da c9
RSP: 0018:ffffc900040df8e0 EFLAGS: 00010246
RAX: b9dfea7c18b7cb00 RBX: ffff8880280b8000 RCX: ffff88802f4bbc80
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 1ffff11005017001 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1c3a654 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff8880280b8010 R15: ffff8880280b8008
FS:  0000555588b1a500(0000) GS:ffff888125a0a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f41bcd45f98 CR3: 00000000667c6000 CR4: 00000000003526f0
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
 copy_process+0x27bd/0x3c20 kernel/fork.c:2486
 kernel_clone+0x21e/0x840 kernel/fork.c:2657
 __do_sys_clone3 kernel/fork.c:2980 [inline]
 __se_sys_clone3+0x292/0x300 kernel/fork.c:2959
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4df65c3609
Code: d7 08 00 48 8d 3d 9c d7 08 00 e8 e2 28 f6 ff 66 90 b8 ea ff ff ff 48 85 ff 74 2c 48 85 d2 74 27 49 89 c8 b8 b3 01 00 00 0f 05 <48> 85 c0 7c 18 74 01 c3 31 ed 48 83 e4 f0 4c 89 c7 ff d2 48 89 c7
RSP: 002b:00007ffef05e2ba8 EFLAGS: 00000206 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007f4df65459f0 RCX: 00007f4df65c3609
RDX: 00007f4df65459f0 RSI: 0000000000000058 RDI: 00007ffef05e2bf0
RBP: 00007f4df73456c0 R08: 00007f4df73456c0 R09: 00007ffef05e2cd7
R10: 0000000000000008 R11: 0000000000000206 R12: ffffffffffffffa8
R13: 000000000000000b R14: 00007ffef05e2bf0 R15: 00007ffef05e2cd8
 </TASK>


Tested on:

commit:         ce7f1a98 Add linux-next specific files for 20250923
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13f04f12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91ae0b9529ab8226
dashboard link: https://syzkaller.appspot.com/bug?extid=0d671007a95cd2835e05
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12932142580000


