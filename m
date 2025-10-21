Return-Path: <linux-kernel+bounces-862625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 950F5BF5C84
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D8619818D2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8130732C949;
	Tue, 21 Oct 2025 10:30:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D69732BF40
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042605; cv=none; b=bOMdb8iiLvq5hBU0HkcClNlCCLLvwgK6r8XGW4KxH9cSIXoRFsGnY5pCTB/1LIxKBB/XGpfB8n/Dn+jGCo49fCEwjNlnfKusu2YbVFhjYMgXhYGsVswAnCuy4ipxinAiZmNNSw2ywdwt43OZhUmsMrJjWJyRpdUTHf2EOby6j5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042605; c=relaxed/simple;
	bh=ba92ZCaLSrFbTakAqUS+7a9wqQ6yNp8OihEI0CLwPVk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JUAuiKQJMdz+NvNJ310R1FZLAo8ShtsbDOu5ViIUFg97tZhl5dt0ELd6tKIMa0ZW5CrJKGbUNs2IypV0RrGnixD7yROqNrMavM8aX9p0Hzn3FYHl1uJwLx6vXmRbp8XzSDuLhi4hpGcAWXzDDC/WJ4o9/q8RLTaVBXSmX1lsu+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93e809242d0so986729839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761042602; x=1761647402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXSxkzjbwtGmJhGcySsnjpN4sygoTHK1MyL+PLfqk9s=;
        b=q/HabPkmKu/lI0C8dN3Zd3pr9gjNoyQqlNcx9bWewsGBBAfjVlISyYISN7tsJFsJw/
         Xc68nF439g5rb7VhD2diAZh0pMjhCdbMXTf6lWS59A9uQmd1LANjmwd0FNBkCuzNbUhn
         yhuLaDlpQFjzMDl4zk3Du7ueVXwC0fng6FjI6HpCA4a9IvhRb5U/IevvUGPu/Klv3GSM
         3BdfMo9sKYraQ3C3MjUgxm43VfwBBv3ld84EQZ7780XfXy0zeIngzuNnytaGnLia4alO
         FDOSp0RsO2zlcorShbT+pcQH3IHkoTBIry9P9/suS1FagRk3IuBwzDdr65SHtxkWHq5h
         qaOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTZK8h5N+ZpFipvKZcAVv2SrT6tYfijsklQUq0QMVvjf64wimqXh/IUuFmHoTA+fPVtY/zfdg4X1YDU5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw68lzbqXqXgTYfgI6ccDXu5HDPtTo0CFns8Dh22eAWZLayOrMk
	9mbbjUlnzepE0h4Ld2g6wehhl86z/0uuF9f+HgzAPN7xk3AUx3ipwgyqymuOkZB8ECYTuI5lhrf
	cl8pNAkw8KUB/9umHQLhdQUhvomOkHt/tRCe/IcUS1GyH76ZymSMnKEOA/Qc=
X-Google-Smtp-Source: AGHT+IG06J3L1XW+DZ5LbGn7uIFP7KU+5mmoBslNxd/mYtvcjn7tb7bHBFtCd6Q7iYtLJtff3ds5pJwk+L2+RZmZcUkSq3Vot/jX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c05:b0:940:f0a7:30d7 with SMTP id
 ca18e2360f4ac-940f0a7354emr90628639f.15.1761042602505; Tue, 21 Oct 2025
 03:30:02 -0700 (PDT)
Date: Tue, 21 Oct 2025 03:30:02 -0700
In-Reply-To: <u6mwe4gtor7cgqece6ctyabmlxcaxn7t2yk7k3xivifwxreu65@z5tjmfkoami7>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f760aa.050a0220.346f24.000d.GAE@google.com>
Subject: Re: [syzbot] [virt?] [net?] possible deadlock in vsock_linger
From: syzbot <syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in vsock_linger

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.17/6384 is trying to acquire lock:
ffff888055028b18 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1679 [inline]
ffff888055028b18 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_linger+0x25e/0x4d0 net/vmw_vsock/af_vsock.c:1080

but task is already holding lock:
ffffffff906260a8 (vsock_register_mutex){+.+.}-{4:4}, at: vsock_assign_transport+0xf2/0x900 net/vmw_vsock/af_vsock.c:469

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (vsock_register_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
       vsock_assign_transport+0xf2/0x900 net/vmw_vsock/af_vsock.c:469
       vsock_connect+0x201/0xee0 net/vmw_vsock/af_vsock.c:1592
       __sys_connect_file+0x141/0x1a0 net/socket.c:2102
       __sys_connect+0x13b/0x160 net/socket.c:2121
       __do_sys_connect net/socket.c:2127 [inline]
       __se_sys_connect net/socket.c:2124 [inline]
       __x64_sys_connect+0x72/0xb0 net/socket.c:2124
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sk_lock-AF_VSOCK){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
       lock_sock_nested+0x41/0xf0 net/core/sock.c:3720
       lock_sock include/net/sock.h:1679 [inline]
       vsock_linger+0x25e/0x4d0 net/vmw_vsock/af_vsock.c:1080
       virtio_transport_close net/vmw_vsock/virtio_transport_common.c:1271 [inline]
       virtio_transport_release+0x52a/0x640 net/vmw_vsock/virtio_transport_common.c:1291
       vsock_assign_transport+0x320/0x900 net/vmw_vsock/af_vsock.c:502
       vsock_connect+0x201/0xee0 net/vmw_vsock/af_vsock.c:1592
       __sys_connect_file+0x141/0x1a0 net/socket.c:2102
       __sys_connect+0x13b/0x160 net/socket.c:2121
       __do_sys_connect net/socket.c:2127 [inline]
       __se_sys_connect net/socket.c:2124 [inline]
       __x64_sys_connect+0x72/0xb0 net/socket.c:2124
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(vsock_register_mutex);
                               lock(sk_lock-AF_VSOCK);
                               lock(vsock_register_mutex);
  lock(sk_lock-AF_VSOCK);

 *** DEADLOCK ***

1 lock held by syz.0.17/6384:
 #0: ffffffff906260a8 (vsock_register_mutex){+.+.}-{4:4}, at: vsock_assign_transport+0xf2/0x900 net/vmw_vsock/af_vsock.c:469

stack backtrace:
CPU: 1 UID: 0 PID: 6384 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2043
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
 lock_sock_nested+0x41/0xf0 net/core/sock.c:3720
 lock_sock include/net/sock.h:1679 [inline]
 vsock_linger+0x25e/0x4d0 net/vmw_vsock/af_vsock.c:1080
 virtio_transport_close net/vmw_vsock/virtio_transport_common.c:1271 [inline]
 virtio_transport_release+0x52a/0x640 net/vmw_vsock/virtio_transport_common.c:1291
 vsock_assign_transport+0x320/0x900 net/vmw_vsock/af_vsock.c:502
 vsock_connect+0x201/0xee0 net/vmw_vsock/af_vsock.c:1592
 __sys_connect_file+0x141/0x1a0 net/socket.c:2102
 __sys_connect+0x13b/0x160 net/socket.c:2121
 __do_sys_connect net/socket.c:2127 [inline]
 __se_sys_connect net/socket.c:2124 [inline]
 __x64_sys_connect+0x72/0xb0 net/socket.c:2124
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f300598efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3006912038 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f3005be5fa0 RCX: 00007f300598efc9
RDX: 0000000000000010 RSI: 0000200000000000 RDI: 0000000000000004
RBP: 00007f3005a11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3005be6038 R14: 00007f3005be5fa0 R15: 00007ffdba0a0048
 </TASK>


Tested on:

commit:         6548d364 Merge tag 'cgroup-for-6.18-rc2-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162a5492580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
dashboard link: https://syzkaller.appspot.com/bug?extid=10e35716f8e4929681fa
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a04e7c580000


