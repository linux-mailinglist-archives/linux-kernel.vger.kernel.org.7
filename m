Return-Path: <linux-kernel+bounces-862786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB4ABF628C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E9A550275F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B7733B962;
	Tue, 21 Oct 2025 11:45:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FCD3321CA
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047106; cv=none; b=rsnWRV1P4D1KmC4zvpM6fGbrhqmwAmsPlgOVUiL3QKlfAX/ETZpVnjyP7o8nCRFWoI7e8qw9QV5JyhLZKoj+qQW+zeh7N2n8BYHmYlGI4Um5yu1Ux/v8YK+sJcR/Bg7RpkLJAskltcFKB4AW42+ZwlicsrIlxfWCU/hk4o/qmOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047106; c=relaxed/simple;
	bh=vBmyi/M+j3rwx1iAgbDVKel+EYv313WWTIT6nvxplA4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NjjIIbytK+yhNGXjBn5ohFGpGHYZeYcTYHovuLyntey+wYmpGqvsgMsa4Lakc2hEAXq5mLR0aCLqXIxv6CyOwgv+9Jg37cW2HmU16FnUlfCUXcG1aX0nLdeTG06PmDmq0FO+e7zgI7RHWxK7ENlR/Wn4b6OOfivn0kytpT5lagI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-92c122eb2bdso382567639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 04:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761047103; x=1761651903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vMriW33hoIv/dhiY3DV9VdCnm6vs4nr3aKXhG7L1V4I=;
        b=wi58XPZqByirjjy9roWsvMGQcA6goDWsI8gQD3CELKFLKWh3188Z/74G+yRapPGUEI
         uXWk2Fh2EFY7QRu41V8qJS1FrLXDyOGYDPI4aHYkVEbrdynYnO5Q1Btp9LAKJosA6GcW
         mcDZ/sHcCeyn3atr+n3pAShw9lqXz6kQF9rgT0qTNDGpQ7NnHBDB2XXUqN4EZRlIwPI8
         bsH3EgF2uRoBhJb6s4q9j2nCbr4N3wg2RFpzRqJljcyHH892vxKItHPS++l08+GBkwvK
         Tv4N9BrSbHf5BiUWTbefJhW00k1vEUEBTAKigfGpUk2WYfu1rgDtj/XaZi8mBbyRCcgC
         rGJA==
X-Gm-Message-State: AOJu0YyY/r6/flous2XYcctDjEzP12HsjiYptpHfQn630ak3bi7iAV5K
	u7xkAEqQXlCTd0nUYBd67Fj4BhEDtubNu3k/yHzJCpd1VHyV9m30e2Rmj0+FrlPdznoK2nzPZhC
	4V/MCgm78Xogd9q8597EVqPo7lokw/GoM8IU3u20oM68+jVfmSYOq2z2z9No=
X-Google-Smtp-Source: AGHT+IExKDmXhu4V9FNEqsrOV45RTq7IscM5AbEPuM7bsqSjq+njZzF3ySLBAHGSdhHR1aTtVHuvDQXMF9ky/5xBudCFUJFd2Xwj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:8d0b:0:b0:8a9:4e94:704 with SMTP id
 ca18e2360f4ac-93e6a8a3ea7mr2518560939f.3.1761047103397; Tue, 21 Oct 2025
 04:45:03 -0700 (PDT)
Date: Tue, 21 Oct 2025 04:45:03 -0700
In-Reply-To: <wqkakifycanfamcfrznmrgy6wmuxqd6gcwl636mgcddwmg3wlv@spos7m2vkpbu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f7723f.050a0220.346f24.0015.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in bpf_bprintf_prepare (3)
From: syzbot <syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, listout@listout.xyz, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: bad unlock balance in bpf_test_timer_leave

=====================================
WARNING: bad unlock balance detected!
syzkaller #0 Not tainted
-------------------------------------
syz.2.19/6466 is trying to release lock (rcu_read_lock) at:
[<ffffffff896fd470>] rcu_lock_release include/linux/rcupdate.h:341 [inline]
[<ffffffff896fd470>] rcu_read_unlock include/linux/rcupdate.h:897 [inline]
[<ffffffff896fd470>] bpf_test_timer_leave+0x1d0/0x290 net/bpf/test_run.c:48
but there are no more locks to release!

other info that might help us debug this:
no locks held by syz.2.19/6466.

stack backtrace:
CPU: 1 UID: 0 PID: 6466 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_unlock_imbalance_bug+0xdc/0xf0 kernel/locking/lockdep.c:5298
 __lock_release kernel/locking/lockdep.c:5527 [inline]
 lock_release+0x212/0x3e0 kernel/locking/lockdep.c:5889
 rcu_lock_release include/linux/rcupdate.h:341 [inline]
 rcu_read_unlock include/linux/rcupdate.h:897 [inline]
 bpf_test_timer_leave+0x1dc/0x290 net/bpf/test_run.c:48
 bpf_test_timer_continue+0x244/0x320 net/bpf/test_run.c:74
 bpf_prog_test_run_flow_dissector+0x39c/0x5c0 net/bpf/test_run.c:1417
 bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4688
 __sys_bpf+0x562/0x860 kernel/bpf/syscall.c:6167
 __do_sys_bpf kernel/bpf/syscall.c:6259 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6257 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6257
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa2f6f8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa2f7e1c038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fa2f71e5fa0 RCX: 00007fa2f6f8efc9
RDX: 0000000000000050 RSI: 0000200000000180 RDI: 000000000000000a
RBP: 00007fa2f7011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa2f71e6038 R14: 00007fa2f71e5fa0 R15: 00007ffee539e9b8
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6466 at kernel/rcu/tree_plugin.h:443 __rcu_read_unlock+0x7a/0xe0 kernel/rcu/tree_plugin.h:443


Tested on:

commit:         1c64efcb Merge tag 'rust-rustfmt' of git://git.kernel...
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=144e83e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=b0cff308140f79a9c4cb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177bbc58580000


