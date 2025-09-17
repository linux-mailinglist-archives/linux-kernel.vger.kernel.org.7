Return-Path: <linux-kernel+bounces-821635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD6FB81CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C77481A86
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D470D2E2F0E;
	Wed, 17 Sep 2025 20:40:32 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8472DAFCA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758141632; cv=none; b=YDrF6axDNpMVHnfYLNsjXBVAr77Dllzts9skVvxfMVgUuDNje4OlT1SS0orz0L2vJXQ6H1JzKDgNRrol0cgCODc7a50Fuizksrw9Gk3gbIwXcJIPVVodit22XwYeqTPCAsojq0GBdO8RBF+CDmzFb2OCzPc3kBtXnMRwlPETewc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758141632; c=relaxed/simple;
	bh=vwP0GenJdk6bZCTcVwM7MWlgruFCVXuQFEX+unH5AEM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ueNejyD0c3eypRRy8RdhzYaq6oubd29EHBZ+WgKqN2PbHvHjgIPj7WG3F83+fab6ZF7Rt7W6C1REYuivN9T367NH+jRGSkN1e+519fRXiHs35Ct44u6tFGnLERcYeookBv0FUDc6GfaSOlm28Qh+nqnogdPw3sSCZ1lw2eyKOHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3f65e91bfa9so3402165ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758141630; x=1758746430;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUCYj0fhxjvce8cBgXv45Gpv57iRXT6SbAGiU7Ajbu0=;
        b=EdrEGlWUHswJ84i5l9WCzCWb+G8YUe6t1v+iynsRd2PwZbJDUn2Y7Oqxa32csmAOes
         VdT7ocbzT4etliH08V42+Dpcu57y7tYMbZXkGuf0Qj5XGpa4ZagFdQn4gYFcPnbMmB6z
         8P/U55v0IF8wqLEjoVKBBDWCpZVb8mk2dxW/py/UTcJW+HpI3xA1dFcE/adLrMkjn0wL
         OX1HoHHpZwyfkImAMoV21XbssYqisVFNjicnfTd8HPC4gDDvY3MuDSLmaSJahADU1QSt
         fBAHukR0qzAy8R6LCqrlhqUMmLfdbkd7wrBi7NktAM/EkWPf9tUU14Xy1oQj0qB835vI
         nDJg==
X-Forwarded-Encrypted: i=1; AJvYcCUs1OHNwtCMQxJDuWAxW/WaBCmF//ja9gEeuyL/ddL0RSdrUY7AoP8MJLbRO86RcTAw0ubRCWRqQjiI4tE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyohvPYhwokPv0Qp7zkeuNVc4w5l/FWQMtS5Amz3G9cNUuEDDmF
	w60lFIneGc6xhLCHlio+BTkasS4SqlnGkq9VRqmsLAEz9CkfZePEOVwfHzZNT6KxNVUKyhqKdXI
	jL82608qy3hbnu9URrNfcz1eNPXiD17iGuYK0QyTRXz3+bxZqLEuN+czY6VI=
X-Google-Smtp-Source: AGHT+IGdPxS4H9dRvFlHe6Wk8P+TELA29Ig2qHHSvPSczHZXvjurzZu60fowB+sTUUIXjlKJVMIyB7j3CQDGyoJXkfcafvV894vG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cf:b0:423:f9c6:f21b with SMTP id
 e9e14a558f8ab-4241a4deb08mr46830165ab.8.1758141629862; Wed, 17 Sep 2025
 13:40:29 -0700 (PDT)
Date: Wed, 17 Sep 2025 13:40:29 -0700
In-Reply-To: <683adb33.a70a0220.1a6ae.000b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cb1cbd.050a0220.2ff435.0599.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING: bad unlock balance in copy_process
From: syzbot <syzbot+80cb3cc5c14fad191a10@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, bsegall@google.com, 
	david@redhat.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com, 
	kees@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lorenzo.stoakes@oracle.com, mgorman@suse.de, mhocko@suse.com, 
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, rppt@kernel.org, 
	surenb@google.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz, 
	vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    6edf2885ebeb Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16d14c7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8b6789b42526d72
dashboard link: https://syzkaller.appspot.com/bug?extid=80cb3cc5c14fad191a10
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179d9f62580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d14c7c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c72239eb6d76/disk-6edf2885.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b67e9820b2be/vmlinux-6edf2885.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0c4ab7e562f6/Image-6edf2885.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+80cb3cc5c14fad191a10@syzkaller.appspotmail.com

=====================================
WARNING: bad unlock balance detected!
syzkaller #0 Not tainted
-------------------------------------
syz.1.48/6865 is trying to release lock (&sighand->siglock) at:
[<ffff8000803b8634>] spin_unlock include/linux/spinlock.h:391 [inline]
[<ffff8000803b8634>] copy_process+0x22d4/0x31ec kernel/fork.c:2432
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz.1.48/6865:
 #0: ffff80008fa00450 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: copy_process+0x2228/0x31ec kernel/fork.c:2274

stack backtrace:
CPU: 0 UID: 0 PID: 6865 Comm: syz.1.48 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 print_unlock_imbalance_bug+0xf4/0xfc kernel/locking/lockdep.c:5298
 __lock_release kernel/locking/lockdep.c:-1 [inline]
 lock_release+0x244/0x39c kernel/locking/lockdep.c:5889
 __raw_spin_unlock include/linux/spinlock_api_smp.h:141 [inline]
 _raw_spin_unlock+0x24/0x78 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:391 [inline]
 copy_process+0x22d4/0x31ec kernel/fork.c:2432
 kernel_clone+0x1d8/0x84c kernel/fork.c:2605
 __do_sys_clone kernel/fork.c:2748 [inline]
 __se_sys_clone kernel/fork.c:2716 [inline]
 __arm64_sys_clone+0x144/0x1a0 kernel/fork.c:2716
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:763
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

