Return-Path: <linux-kernel+bounces-862413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D7CBF5394
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A363A8BE6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9845E303A15;
	Tue, 21 Oct 2025 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfW8AN84"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABF72BF015
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035275; cv=none; b=IQCPmnXWR9nsxb4JWeStNqhlkMJAtYKsq5lAUveAdo47/8XtFEAkVBTbqms4Wzs6QYKe0kS03ZPzkwQkh/6kkAPTlkKagt/bVb2PdowwYnG3IhBPMqUR/JVXG1MdhgwVaf8Tevz4ciV5kH9IYrFzLE3fgbNSge7RoYAcs3HtTgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035275; c=relaxed/simple;
	bh=VNODx/HaklHD3t9XKv5ayfNCvTqm2/znumo71rMHvZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jd/VeddYHt4Kt/xnZLZGW5F6Ui1Djw+oYpKpO6+fhawPZ76MVW1F3RaYXdH079S0q+593EFjzXHUS1oUSi+UqxCSU4rKAi61ubJUFMWmUEqKQPKNNhkPV6twEBiPRiIjeMLBozpN2hZK2n+8xEtp3wGq/VcMJ3PtPNx45HF9StA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfW8AN84; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761035271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rXjgjEJV0R26d68vKPPbMezY41IiNglwJMANKlvSw4o=;
	b=KfW8AN84TrOPBZYjvAWQ3rVR4yDuskX2dITwTt7IRLcmirmaj7zXhXftS6UfnIurgIzKCF
	59lGO931nka7brxvEiz1AckwhtZZgyIfo+NRoyki+LKlO/PYy0ukx1kOSfyjlTDuce4VAv
	OcOv7pSqjeVdI6SrQ/SRqRA2UKxhfEM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-OjzIi6w2Mua7m0zycjuNWg-1; Tue, 21 Oct 2025 04:27:50 -0400
X-MC-Unique: OjzIi6w2Mua7m0zycjuNWg-1
X-Mimecast-MFC-AGG-ID: OjzIi6w2Mua7m0zycjuNWg_1761035269
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4710d174c31so54466835e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761035268; x=1761640068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXjgjEJV0R26d68vKPPbMezY41IiNglwJMANKlvSw4o=;
        b=LReJMmnFddwMOkzvVyC4mq8J3NGDxZeY3zBb6rI4iUrbE6KDkO4ChPCy+aR4+tGtj2
         PyPyv2IU+bWukl9BT7QODw2D7pv4vyg1SsXyb4FipEFQy5ile3Wve2FwSmoZ7vX/wzMy
         9YbL8RqIyhsGhe+lp1tf/a7gFzLCezNFD+40mjf6ud/jSebG2e0TzgYj3nFnjXXnMdQP
         viCxcDlTPU5Us8FB6/Qgo0XDGjvnN4vHkDcAyQwysvaReGD0ZIYWo795/bvbATUzdWYl
         bdQG476sg59qBOEO79cd+d/f3A3a9qGtqUAVYb8p2Zv2OGSLX6pich48vFHXkvpyemKA
         x6dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMGfnZ51+N3zmrbN4VUS306jD6kNlG6IeQj3j/ursXgwDfI6qb1LOxbUmnTyYFrHXl4kc7N0/nS9gNFno=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu++/haMUL2aTepm7ux72wL98opDjdG+qhmcPmLVDPKptRJUrY
	Hgx2JR5ZzAflrn5a91+gtBL5jMXc8p+BnbjMqZ487bCKHyA/323qsLTLlOoVX+fuDXrIHeD1AG1
	un/nuBPr4bxpP3IX5BcmGUQUwtTI0M4oXRJiFl1TBtixw0oiitJEiR0t8mF116i1pxA==
X-Gm-Gg: ASbGncso6HgLAmI/8C1VXW1/hFeyZQYSKd+2Z4F7TYLrylT7Jd5RFLUomqkqEhC/mBP
	4v9V5A+IcfRI+vDLgTqd0PW1YwuAPKkt175YshtnUTl9D99w24w2eo6wWUgXiizEMiduDFtmpqR
	LbRtiukvFQte+wPJc1TmDKk+t61IiEWbkh/BwOcdEdyH+RIzKJFRdZTLbNBTZXBMnHytase05uV
	YRCOw9YnJE0TSYq4jTvu4XTXCb9owdEG58chZB4VwS81ZIxnGj8zMq+tkf+UW8Arasu+XR63bqO
	ipKcZLGX8JcI2n2vGfVe5nHp3kRt5IOdfc4a2LldkQE6dKt9QCPN7OUjauCptCMnOP3/aepJ1on
	xrNSae9rb5HI19Dbq4/hHbCyWEmqxYspFDD/Ev4dGMYBvzSgnIho=
X-Received: by 2002:a05:600c:818f:b0:46f:b42e:ed86 with SMTP id 5b1f17b1804b1-4711791fbdemr109053025e9.39.1761035267903;
        Tue, 21 Oct 2025 01:27:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxLGyAkJwNwmi09pKR+RPoEkOxJgFzFbtoNAsFJr9kt9UwUMZqxcBb8wCBCLNMnB3tg2dusQ==
X-Received: by 2002:a05:600c:818f:b0:46f:b42e:ed86 with SMTP id 5b1f17b1804b1-4711791fbdemr109052755e9.39.1761035267279;
        Tue, 21 Oct 2025 01:27:47 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47114423862sm272405965e9.1.2025.10.21.01.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 01:27:46 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:27:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: syzbot <syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com>, 
	Michal Luczaj <mhal@rbox.co>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [syzbot] [virt?] [net?] possible deadlock in vsock_linger
Message-ID: <pehr4umqwjv3a7p4uudrz3uuqacu3ut66kmazw2ovm73gimyry@oevxmd4o664k>
References: <68f6cdb0.a70a0220.205af.0039.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <68f6cdb0.a70a0220.205af.0039.GAE@google.com>

Hi Michal,

On Mon, Oct 20, 2025 at 05:02:56PM -0700, syzbot wrote:
>Hello,
>
>syzbot found the following issue on:
>
>HEAD commit:    d9043c79ba68 Merge tag 'sched_urgent_for_v6.18_rc2' of git..
>git tree:       upstream
>console output: https://syzkaller.appspot.com/x/log.txt?x=130983cd980000
>kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
>dashboard link: https://syzkaller.appspot.com/bug?extid=10e35716f8e4929681fa
>compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f0f52f980000
>C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ea9734580000
>
>Downloadable assets:
>disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d9043c79.raw.xz
>vmlinux: https://storage.googleapis.com/syzbot-assets/0546b6eaf1aa/vmlinux-d9043c79.xz
>kernel image: https://storage.googleapis.com/syzbot-assets/81285b4ada51/bzImage-d9043c79.xz
>
>IMPORTANT: if you fix the issue, please add the following tag to the commit:
>Reported-by: syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com
>
>======================================================
>WARNING: possible circular locking dependency detected
>syzkaller #0 Not tainted
>------------------------------------------------------
>syz.0.17/6098 is trying to acquire lock:
>ffff8880363b8258 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1679 [inline]
>ffff8880363b8258 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_linger+0x25e/0x4d0 net/vmw_vsock/af_vsock.c:1066

Could this be related to our recent work on linger in vsock?

>
>but task is already holding lock:
>ffffffff906260a8 (vsock_register_mutex){+.+.}-{4:4}, at: vsock_assign_transport+0xf2/0x900 net/vmw_vsock/af_vsock.c:469
>
>which lock already depends on the new lock.
>
>
>the existing dependency chain (in reverse order) is:
>
>-> #1 (vsock_register_mutex){+.+.}-{4:4}:
>       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
>       vsock_registered_transport_cid net/vmw_vsock/af_vsock.c:560 [inline]

Ah, no maybe this is related to commit 209fd720838a ("vsock:
Fix transport_{g2h,h2g} TOCTOU") where we added locking in
vsock_find_cid().

Maybe we can just move the checks on top of __vsock_bind() to the
caller. I mean:

	/* First ensure this socket isn't already bound. */
	if (vsock_addr_bound(&vsk->local_addr))
		return -EINVAL;

	/* Now bind to the provided address or select appropriate values if
	 * none are provided (VMADDR_CID_ANY and VMADDR_PORT_ANY).  Note that
	 * like AF_INET prevents binding to a non-local IP address (in most
	 * cases), we only allow binding to a local CID.
	 */
	if (addr->svm_cid != VMADDR_CID_ANY && !vsock_find_cid(addr->svm_cid))
		return -EADDRNOTAVAIL;

We have 2 callers: vsock_auto_bind() and vsock_bind().

vsock_auto_bind() is already checking if the socket is already bound,
if not is setting VMADDR_CID_ANY, so we can skip those checks.

In vsock_bind() we can do the checks before lock_sock(sk), at least the
checks on vm_addr, calling vsock_find_cid().

I'm preparing a patch to do this.

Stefano


>       vsock_find_cid net/vmw_vsock/af_vsock.c:570 [inline]
>       __vsock_bind+0x1b5/0xa10 net/vmw_vsock/af_vsock.c:752
>       vsock_bind+0xc6/0x120 net/vmw_vsock/af_vsock.c:1002
>       __sys_bind_socket net/socket.c:1874 [inline]
>       __sys_bind_socket net/socket.c:1866 [inline]
>       __sys_bind+0x1a7/0x260 net/socket.c:1905
>       __do_sys_bind net/socket.c:1910 [inline]
>       __se_sys_bind net/socket.c:1908 [inline]
>       __x64_sys_bind+0x72/0xb0 net/socket.c:1908
>       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
>       entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>-> #0 (sk_lock-AF_VSOCK){+.+.}-{0:0}:
>       check_prev_add kernel/locking/lockdep.c:3165 [inline]
>       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>       validate_chain kernel/locking/lockdep.c:3908 [inline]
>       __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5237
>       lock_acquire kernel/locking/lockdep.c:5868 [inline]
>       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
>       lock_sock_nested+0x41/0xf0 net/core/sock.c:3720
>       lock_sock include/net/sock.h:1679 [inline]
>       vsock_linger+0x25e/0x4d0 net/vmw_vsock/af_vsock.c:1066
>       virtio_transport_close net/vmw_vsock/virtio_transport_common.c:1271 [inline]
>       virtio_transport_release+0x52a/0x640 net/vmw_vsock/virtio_transport_common.c:1291
>       vsock_assign_transport+0x320/0x900 net/vmw_vsock/af_vsock.c:502
>       vsock_connect+0x201/0xee0 net/vmw_vsock/af_vsock.c:1578
>       __sys_connect_file+0x141/0x1a0 net/socket.c:2102
>       __sys_connect+0x13b/0x160 net/socket.c:2121
>       __do_sys_connect net/socket.c:2127 [inline]
>       __se_sys_connect net/socket.c:2124 [inline]
>       __x64_sys_connect+0x72/0xb0 net/socket.c:2124
>       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
>       entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>other info that might help us debug this:
>
> Possible unsafe locking scenario:
>
>       CPU0                    CPU1
>       ----                    ----
>  lock(vsock_register_mutex);
>                               lock(sk_lock-AF_VSOCK);
>                               lock(vsock_register_mutex);
>  lock(sk_lock-AF_VSOCK);
>
> *** DEADLOCK ***
>
>1 lock held by syz.0.17/6098:
> #0: ffffffff906260a8 (vsock_register_mutex){+.+.}-{4:4}, at: vsock_assign_transport+0xf2/0x900 net/vmw_vsock/af_vsock.c:469
>
>stack backtrace:
>CPU: 3 UID: 0 PID: 6098 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
>Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:94 [inline]
> dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
> print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2043
> check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2175
> check_prev_add kernel/locking/lockdep.c:3165 [inline]
> check_prevs_add kernel/locking/lockdep.c:3284 [inline]
> validate_chain kernel/locking/lockdep.c:3908 [inline]
> __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5237
> lock_acquire kernel/locking/lockdep.c:5868 [inline]
> lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
> lock_sock_nested+0x41/0xf0 net/core/sock.c:3720
> lock_sock include/net/sock.h:1679 [inline]
> vsock_linger+0x25e/0x4d0 net/vmw_vsock/af_vsock.c:1066
> virtio_transport_close net/vmw_vsock/virtio_transport_common.c:1271 [inline]
> virtio_transport_release+0x52a/0x640 net/vmw_vsock/virtio_transport_common.c:1291
> vsock_assign_transport+0x320/0x900 net/vmw_vsock/af_vsock.c:502
> vsock_connect+0x201/0xee0 net/vmw_vsock/af_vsock.c:1578
> __sys_connect_file+0x141/0x1a0 net/socket.c:2102
> __sys_connect+0x13b/0x160 net/socket.c:2121
> __do_sys_connect net/socket.c:2127 [inline]
> __se_sys_connect net/socket.c:2124 [inline]
> __x64_sys_connect+0x72/0xb0 net/socket.c:2124
> do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>RIP: 0033:0x7f767bf8efc9
>Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>RSP: 002b:00007fff0a2857b8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
>RAX: ffffffffffffffda RBX: 00007f767c1e5fa0 RCX: 00007f767bf8efc9
>RDX: 0000000000000010 RSI: 0000200000000000 RDI: 0000000000000004
>RBP: 00007f767c011f91 R08: 0000000000000000 R09: 0000000000000000
>R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>R13: 00007f767c1e5fa0 R14: 00007f767c1e5fa0 R15: 0000000000000003
> </TASK>
>
>
>---
>This report is generated by a bot. It may contain errors.
>See https://goo.gl/tpsmEJ for more information about syzbot.
>syzbot engineers can be reached at syzkaller@googlegroups.com.
>
>syzbot will keep track of this issue. See:
>https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
>If the report is already addressed, let syzbot know by replying with:
>#syz fix: exact-commit-title
>
>If you want syzbot to run the reproducer, reply with:
>#syz test: git://repo/address.git branch-or-commit-hash
>If you attach or paste a git patch, syzbot will apply it before testing.
>
>If you want to overwrite report's subsystems, reply with:
>#syz set subsystems: new-subsystem
>(See the list of subsystem names on the web dashboard)
>
>If the report is a duplicate of another one, reply with:
>#syz dup: exact-subject-of-another-report
>
>If you want to undo deduplication, reply with:
>#syz undup
>


