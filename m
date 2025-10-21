Return-Path: <linux-kernel+bounces-862664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22484BF5DF8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA87E18C6DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6E9328B65;
	Tue, 21 Oct 2025 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNBZkr97"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DAB2E8B8A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043703; cv=none; b=OtxQJqn3vdb7QUqG38xvs29X5GzeyQY5n7MmqXMy/SRPRU3H2HrVfPv0clAHUMQHQeryskUWjm0MYm2Y2ewExWGZn+D7gA8VsMDSz52MdlpaXauwy+0vgzKTqoJ4MRzk//w3nsFb8ax6BiL7oErw/vEDoXEBwkeKRn4xi+FIKgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043703; c=relaxed/simple;
	bh=37FUHQYRPFdR624jqh50grzYWOkv/L3OsF6TjUUEeCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LscwcLeyRKpAo+acJJPRxCjyYaKx/HlUMjsCVy4JNZTkShCFPSb1xGjCcbCgDWwYHf9GBHsN2SE8OcpbiNMxcqQrG7hH7PSUC5sgUC7Jja+TZzyHcEfynKRU16gE18WvuQ3bHqkvB52cLvMI6yTQ6n/+T9seeNBoYHSYFCvepdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QNBZkr97; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761043699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BlIfiaacBP1BdYrHMrSvHFNSxdpvzLC4bMDqMkuNAHI=;
	b=QNBZkr97uSAzOaVL/Jk47biS514r6voCFPvtLeWSGvbFJzS1YZjwjWSsu5qgSlUM3aQZ2T
	yy565/YXmfM8+fSpUMwNAc0njP8wb+WxrLIot3ivHwXHiCVAtEKNi9HdEXY8kSHrukAHra
	WWba/eLLqWmVwuzjqyozn8Uh4Vtgmj8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-zoRwLb_5MU2GtCkC8TnJ7A-1; Tue, 21 Oct 2025 06:48:18 -0400
X-MC-Unique: zoRwLb_5MU2GtCkC8TnJ7A-1
X-Mimecast-MFC-AGG-ID: zoRwLb_5MU2GtCkC8TnJ7A_1761043697
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33826e101ecso6746856a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761043695; x=1761648495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlIfiaacBP1BdYrHMrSvHFNSxdpvzLC4bMDqMkuNAHI=;
        b=Rzy5kmvMuMYWlEzK03CKXwuHxry1mfXzSMgJl7UyeymihDfOVw0OhREapcPr51kHlv
         aY50BgjxA6G/IMCtD2mBuRYwA8qMRA+6yswQCSWu/P7dEQrDPiLV+SqUrPfqAjn5TSiD
         p3JgZlBTX6BwH9JkDfdhxnRoN3j7UpYKKZmuw/1uJRj4E7ngiSAzXnaZFs90YSY/TH2d
         29vNb9A2ujJ9aBUioGUYM8sBMF1ssz33Gmb93zRhvYRwjQ3lvLZOzoI9vo9ULBFv4R23
         EIdL3SGjWB2pJvnP23t7/x9XSp/ipxSmvo00ZzHgQtz6iD9Bhksd/ZVFIzfKqEeWdMq1
         rPRg==
X-Forwarded-Encrypted: i=1; AJvYcCWHSR6puv22th3SjGKAnZTHQA5a5/ybEedFxdWTId4pG3DWadRTfwDJ4Y3Wh9pmH1NVOv5yemTAMyjm4eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeoZm8DOqtgFa/OT8jy+JXxIo4NINb+OqSEpWZvElods9HP8FA
	sxkGfhG/zKOG2PrTPoOhnugp7lNvLeWiJKmohoJ8M+6qfdhDkcqZA/7ZYS202oN/jEcUJpqvf+4
	tIpcwxzQsdDRHC5xRZYu/qzeSbSw3HGwULSGkTsoAzh4VZgdn/rdus9EWp9LjK6c1N56VV4Xx8j
	lV235eqZWOgcdMNCPnIqO/KbkZOfY0OTDXjOOhHKAN
X-Gm-Gg: ASbGncsmAQzdbZgWuJ5YuNUQqPmIAoo8+9uqZjr6gF9mqqDEnrCDgbUr/aNJxb1UXrF
	UtSiCnDiSqAcB5nJ8NU+iRxTw66Dhx7cMq/JFgoe5dIM81Ff+bE1ctkKmDPFtlg/dEQMaRrnN6j
	Tu8mRWB6WTyZK7L2OEdWZkyWjOstuh3SRUlQWwx0UOw9p5aUGWB8/CQ3o=
X-Received: by 2002:a17:90b:1d09:b0:339:e8c7:d47d with SMTP id 98e67ed59e1d1-33bc9c11c65mr24820388a91.9.1761043695005;
        Tue, 21 Oct 2025 03:48:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCzhKZbhQf91y5uB35xwvYzl3MPHYKpEm3aC1dH+nNH3d9jmjh0pfUBGmRgxgOaZDfHHl8Ee7ZOU8rfE2+sPw=
X-Received: by 2002:a17:90b:1d09:b0:339:e8c7:d47d with SMTP id
 98e67ed59e1d1-33bc9c11c65mr24820359a91.9.1761043694575; Tue, 21 Oct 2025
 03:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68f6cdb0.a70a0220.205af.0039.GAE@google.com> <pehr4umqwjv3a7p4uudrz3uuqacu3ut66kmazw2ovm73gimyry@oevxmd4o664k>
In-Reply-To: <pehr4umqwjv3a7p4uudrz3uuqacu3ut66kmazw2ovm73gimyry@oevxmd4o664k>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 21 Oct 2025 12:48:01 +0200
X-Gm-Features: AS18NWAUnf_cDwJCO-xz9TQNId5mc_VG0fdD_J3-l5bGY8xJaFrDeoT1zsSFpIw
Message-ID: <CAGxU2F5y+kdByEwAq-t15fyrfrgQGpmapmLgkmDmY4xH4TJSDw@mail.gmail.com>
Subject: Re: [syzbot] [virt?] [net?] possible deadlock in vsock_linger
To: syzbot <syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com>, 
	Michal Luczaj <mhal@rbox.co>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Oct 2025 at 10:27, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Hi Michal,
>
> On Mon, Oct 20, 2025 at 05:02:56PM -0700, syzbot wrote:
> >Hello,
> >
> >syzbot found the following issue on:
> >
> >HEAD commit:    d9043c79ba68 Merge tag 'sched_urgent_for_v6.18_rc2' of git..
> >git tree:       upstream
> >console output: https://syzkaller.appspot.com/x/log.txt?x=130983cd980000
> >kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
> >dashboard link: https://syzkaller.appspot.com/bug?extid=10e35716f8e4929681fa
> >compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> >syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f0f52f980000
> >C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ea9734580000
> >
> >Downloadable assets:
> >disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d9043c79.raw.xz
> >vmlinux: https://storage.googleapis.com/syzbot-assets/0546b6eaf1aa/vmlinux-d9043c79.xz
> >kernel image: https://storage.googleapis.com/syzbot-assets/81285b4ada51/bzImage-d9043c79.xz
> >
> >IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >Reported-by: syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com
> >
> >======================================================
> >WARNING: possible circular locking dependency detected
> >syzkaller #0 Not tainted
> >------------------------------------------------------
> >syz.0.17/6098 is trying to acquire lock:
> >ffff8880363b8258 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1679 [inline]
> >ffff8880363b8258 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_linger+0x25e/0x4d0 net/vmw_vsock/af_vsock.c:1066
>
> Could this be related to our recent work on linger in vsock?
>
> >
> >but task is already holding lock:
> >ffffffff906260a8 (vsock_register_mutex){+.+.}-{4:4}, at: vsock_assign_transport+0xf2/0x900 net/vmw_vsock/af_vsock.c:469
> >
> >which lock already depends on the new lock.
> >
> >
> >the existing dependency chain (in reverse order) is:
> >
> >-> #1 (vsock_register_mutex){+.+.}-{4:4}:
> >       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
> >       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
> >       vsock_registered_transport_cid net/vmw_vsock/af_vsock.c:560 [inline]
>
> Ah, no maybe this is related to commit 209fd720838a ("vsock:
> Fix transport_{g2h,h2g} TOCTOU") where we added locking in
> vsock_find_cid().
>
> Maybe we can just move the checks on top of __vsock_bind() to the
> caller. I mean:
>
>         /* First ensure this socket isn't already bound. */
>         if (vsock_addr_bound(&vsk->local_addr))
>                 return -EINVAL;
>
>         /* Now bind to the provided address or select appropriate values if
>          * none are provided (VMADDR_CID_ANY and VMADDR_PORT_ANY).  Note that
>          * like AF_INET prevents binding to a non-local IP address (in most
>          * cases), we only allow binding to a local CID.
>          */
>         if (addr->svm_cid != VMADDR_CID_ANY && !vsock_find_cid(addr->svm_cid))
>                 return -EADDRNOTAVAIL;
>
> We have 2 callers: vsock_auto_bind() and vsock_bind().
>
> vsock_auto_bind() is already checking if the socket is already bound,
> if not is setting VMADDR_CID_ANY, so we can skip those checks.
>
> In vsock_bind() we can do the checks before lock_sock(sk), at least the
> checks on vm_addr, calling vsock_find_cid().
>
> I'm preparing a patch to do this.

mmm, no, this is more related to vsock_linger() where sk_wait_event()
releases and locks again the sk_lock.
So, it should be related to commit 687aa0c5581b ("vsock: Fix
transport_* TOCTOU") where we take vsock_register_mutex in
vsock_assign_transport() while calling vsk->transport->release().

So, maybe we need to move the release and vsock_deassign_transport()
after unlocking vsock_register_mutex.

Stefano

>
> Stefano
>
>
> >       vsock_find_cid net/vmw_vsock/af_vsock.c:570 [inline]
> >       __vsock_bind+0x1b5/0xa10 net/vmw_vsock/af_vsock.c:752
> >       vsock_bind+0xc6/0x120 net/vmw_vsock/af_vsock.c:1002
> >       __sys_bind_socket net/socket.c:1874 [inline]
> >       __sys_bind_socket net/socket.c:1866 [inline]
> >       __sys_bind+0x1a7/0x260 net/socket.c:1905
> >       __do_sys_bind net/socket.c:1910 [inline]
> >       __se_sys_bind net/socket.c:1908 [inline]
> >       __x64_sys_bind+0x72/0xb0 net/socket.c:1908
> >       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
> >       entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> >-> #0 (sk_lock-AF_VSOCK){+.+.}-{0:0}:
> >       check_prev_add kernel/locking/lockdep.c:3165 [inline]
> >       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
> >       validate_chain kernel/locking/lockdep.c:3908 [inline]
> >       __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5237
> >       lock_acquire kernel/locking/lockdep.c:5868 [inline]
> >       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
> >       lock_sock_nested+0x41/0xf0 net/core/sock.c:3720
> >       lock_sock include/net/sock.h:1679 [inline]
> >       vsock_linger+0x25e/0x4d0 net/vmw_vsock/af_vsock.c:1066
> >       virtio_transport_close net/vmw_vsock/virtio_transport_common.c:1271 [inline]
> >       virtio_transport_release+0x52a/0x640 net/vmw_vsock/virtio_transport_common.c:1291
> >       vsock_assign_transport+0x320/0x900 net/vmw_vsock/af_vsock.c:502
> >       vsock_connect+0x201/0xee0 net/vmw_vsock/af_vsock.c:1578
> >       __sys_connect_file+0x141/0x1a0 net/socket.c:2102
> >       __sys_connect+0x13b/0x160 net/socket.c:2121
> >       __do_sys_connect net/socket.c:2127 [inline]
> >       __se_sys_connect net/socket.c:2124 [inline]
> >       __x64_sys_connect+0x72/0xb0 net/socket.c:2124
> >       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
> >       entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> >other info that might help us debug this:
> >
> > Possible unsafe locking scenario:
> >
> >       CPU0                    CPU1
> >       ----                    ----
> >  lock(vsock_register_mutex);
> >                               lock(sk_lock-AF_VSOCK);
> >                               lock(vsock_register_mutex);
> >  lock(sk_lock-AF_VSOCK);
> >
> > *** DEADLOCK ***
> >
> >1 lock held by syz.0.17/6098:
> > #0: ffffffff906260a8 (vsock_register_mutex){+.+.}-{4:4}, at: vsock_assign_transport+0xf2/0x900 net/vmw_vsock/af_vsock.c:469
> >
> >stack backtrace:
> >CPU: 3 UID: 0 PID: 6098 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
> >Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> >Call Trace:
> > <TASK>
> > __dump_stack lib/dump_stack.c:94 [inline]
> > dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
> > print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2043
> > check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2175
> > check_prev_add kernel/locking/lockdep.c:3165 [inline]
> > check_prevs_add kernel/locking/lockdep.c:3284 [inline]
> > validate_chain kernel/locking/lockdep.c:3908 [inline]
> > __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5237
> > lock_acquire kernel/locking/lockdep.c:5868 [inline]
> > lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
> > lock_sock_nested+0x41/0xf0 net/core/sock.c:3720
> > lock_sock include/net/sock.h:1679 [inline]
> > vsock_linger+0x25e/0x4d0 net/vmw_vsock/af_vsock.c:1066
> > virtio_transport_close net/vmw_vsock/virtio_transport_common.c:1271 [inline]
> > virtio_transport_release+0x52a/0x640 net/vmw_vsock/virtio_transport_common.c:1291
> > vsock_assign_transport+0x320/0x900 net/vmw_vsock/af_vsock.c:502
> > vsock_connect+0x201/0xee0 net/vmw_vsock/af_vsock.c:1578
> > __sys_connect_file+0x141/0x1a0 net/socket.c:2102
> > __sys_connect+0x13b/0x160 net/socket.c:2121
> > __do_sys_connect net/socket.c:2127 [inline]
> > __se_sys_connect net/socket.c:2124 [inline]
> > __x64_sys_connect+0x72/0xb0 net/socket.c:2124
> > do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
> > entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >RIP: 0033:0x7f767bf8efc9
> >Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> >RSP: 002b:00007fff0a2857b8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
> >RAX: ffffffffffffffda RBX: 00007f767c1e5fa0 RCX: 00007f767bf8efc9
> >RDX: 0000000000000010 RSI: 0000200000000000 RDI: 0000000000000004
> >RBP: 00007f767c011f91 R08: 0000000000000000 R09: 0000000000000000
> >R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> >R13: 00007f767c1e5fa0 R14: 00007f767c1e5fa0 R15: 0000000000000003
> > </TASK>
> >
> >
> >---
> >This report is generated by a bot. It may contain errors.
> >See https://goo.gl/tpsmEJ for more information about syzbot.
> >syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> >syzbot will keep track of this issue. See:
> >https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> >If the report is already addressed, let syzbot know by replying with:
> >#syz fix: exact-commit-title
> >
> >If you want syzbot to run the reproducer, reply with:
> >#syz test: git://repo/address.git branch-or-commit-hash
> >If you attach or paste a git patch, syzbot will apply it before testing.
> >
> >If you want to overwrite report's subsystems, reply with:
> >#syz set subsystems: new-subsystem
> >(See the list of subsystem names on the web dashboard)
> >
> >If the report is a duplicate of another one, reply with:
> >#syz dup: exact-subject-of-another-report
> >
> >If you want to undo deduplication, reply with:
> >#syz undup
> >


