Return-Path: <linux-kernel+bounces-764548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EF2B2245B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724373A671A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2B12EB5B9;
	Tue, 12 Aug 2025 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0lYz0sV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6BE2D6E59
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993758; cv=none; b=jsYG6GAva2NRfEiTg4jxNm+Uh3nVYfj/QZdKAdk+ER6qrTMkR0u0oWt5iWeZw3cUl0D96BnBZQrplpyudFqhKD8Z6b3TKcsa7WsxFBanY+5MATszBUoTqbq6Ro4Bb4ETyvS0iDBBGQZ8h0hu4A0Ymc9DLXDaQxmsHGuJGHdL3tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993758; c=relaxed/simple;
	bh=upr5gTPfA5jEvog5a5LIT8yWlQej74MFP6ZeE5bVIUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdpqjiL/Wybt3ZuzVOcur3yBqLP/P6N6gni1oHzuSAe0RTtL87MpHU8HgcdK0fH+ezrmB2Job5cROln6pbSVnhytT0NmKQRvAjkxgOfaeEpLiBcA85s6XiADtPGRaRvnaK4+aL1ukfCZY8RWTxffu9uAuC67XTNTPqQscSz0k9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V0lYz0sV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754993755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I6rPgfUZWncjHqWz3Gs2f0Po8oy+srlfPWRWaLP7/JA=;
	b=V0lYz0sVMiSzURKFkGG1aw/E9dhlGxOLf3aoBTVzp1He/VmnxlEiXQPykWkYsqi5FH5WGZ
	StgVAREEsYZ+bx/WbEPjxL+a9rz2JC+WE+A6u6Xi0qaDjFLj3pV9MeHFfoLtQLmZBlWMiV
	+7jLX9fs1TXnkzHb48hO7fWRXaJgq2Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-wAf4fYDZMFSfPiW-hBlL5A-1; Tue, 12 Aug 2025 06:15:52 -0400
X-MC-Unique: wAf4fYDZMFSfPiW-hBlL5A-1
X-Mimecast-MFC-AGG-ID: wAf4fYDZMFSfPiW-hBlL5A_1754993751
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-459e4b85895so31064565e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754993750; x=1755598550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6rPgfUZWncjHqWz3Gs2f0Po8oy+srlfPWRWaLP7/JA=;
        b=Rw0Xm0O6oJOX3uttimDHCr+uyIJg9niW7oAYvf7MWt9LR3R+553Shjbaf5+QLDbNoM
         5sQOphr+O4ad7JWSAuHtNQESlotR8kwXaBgLoOoJ9En2whJTZnwAhkidEmZSw/qdC6na
         S2YKhCxWceTBsPhJ1sTvsOM/2M8ZyfPD3J+1vsdQK+8MRSX9DUDI2cxQawHe+EBNd26Q
         hFgsudkVH46dY1JeJgiK8iDV7kJY+SgiaHt0NiDBj81/wB0lnZBjl96FERis1qNgQqnp
         NyVHZjVJ6JlHpzKAsAZnpMHrHifc8w6PeIh8UhPkNN616GHzXRHU0w8IyCaQ09VM4XON
         Lymw==
X-Forwarded-Encrypted: i=1; AJvYcCWzZdEPpGP9sC8jbhORleCLU95Xk0OAEy8rQsP68DkIo+USwszq4zdDiexCrwRcx6dSt29VSJv9fx+xgZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIF/LYPUK/YNs+B7Qbalbrs8dcwvi9nVu5GEXTCovS4okTGyJ4
	COmWlkzIAj4etcNaYajoWSidu349ouKPhyF6KL0IvlBZggrQsbIsWk0tcHg1l41fMP5hFGRf8fu
	TM5kAuHSqik/gMKLAkcZeZDlxssh3Ox7qNElD456zead4i0m667yg4J/hewquCwCa5w==
X-Gm-Gg: ASbGncuzJSJzoFeXTj1ckRcP0OD0T6aHFMFEiwCK+s5162vFUqbo8/0KhtJNwbo+DCA
	7Zv+WrnQaYU+u5VGb4ZfTX0J2x3Xxmluq4XQV3qdBuJUyD8ZHTbO+GSyJ51aY90ctLASypFeXpC
	DcfyhSbL33S658145rjM8mau7sqboswrxzAmUPzpRrOQVIXUXvNUAPbMRO/Zr0i1dRjfOfqZRKN
	qKkm0FHi9smd95V8nBqQK+NgenqECHwc1aMawHzTAjHEDLZyNXXRHTuYSi0j82f/IOaLkTQ7uQ6
	QUkcWa56EVmzIHpkN9EKcVqBL+TFhA6y
X-Received: by 2002:a05:600c:4f86:b0:456:3b21:ad1e with SMTP id 5b1f17b1804b1-459f4f1278dmr156943565e9.17.1754993750421;
        Tue, 12 Aug 2025 03:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4hpwCPxI92uHx8TgM/s0ZsgXXko7udMPgKR65VR2LmUddnVMaoV0RM5rKfkQhEswaG8878g==
X-Received: by 2002:a05:600c:4f86:b0:456:3b21:ad1e with SMTP id 5b1f17b1804b1-459f4f1278dmr156943275e9.17.1754993749988;
        Tue, 12 Aug 2025 03:15:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459db3048bdsm393003455e9.29.2025.08.12.03.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 03:15:49 -0700 (PDT)
Date: Tue, 12 Aug 2025 06:15:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: syzbot <syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, eperezma@redhat.com,
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, syzkaller-bugs@googlegroups.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	Will Deacon <will@kernel.org>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] WARNING in
 virtio_transport_send_pkt_info
Message-ID: <20250812061425-mutt-send-email-mst@kernel.org>
References: <20250812052645-mutt-send-email-mst@kernel.org>
 <689b1156.050a0220.7f033.011c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <689b1156.050a0220.7f033.011c.GAE@google.com>

On Tue, Aug 12, 2025 at 03:03:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in virtio_transport_send_pkt_info

OK so the issue triggers on
commit 6693731487a8145a9b039bc983d77edc47693855
Author: Will Deacon <will@kernel.org>
Date:   Thu Jul 17 10:01:16 2025 +0100

    vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers
    

but does not trigger on:

commit 8ca76151d2c8219edea82f1925a2a25907ff6a9d
Author: Will Deacon <will@kernel.org>
Date:   Thu Jul 17 10:01:15 2025 +0100

    vsock/virtio: Rename virtio_vsock_skb_rx_put()
    


Will, I suspect your patch merely uncovers a latent bug
in zero copy handling elsewhere.
Want to take a look?



> ------------[ cut here ]------------
> 'send_pkt()' returns 0, but 65536 expected
> WARNING: CPU: 0 PID: 5936 at net/vmw_vsock/virtio_transport_common.c:428 virtio_transport_send_pkt_info+0xd11/0xf00 net/vmw_vsock/virtio_transport_common.c:426
> Modules linked in:
> CPU: 0 UID: 0 PID: 5936 Comm: syz.0.17 Not tainted 6.16.0-rc6-syzkaller-00030-g6693731487a8 #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:virtio_transport_send_pkt_info+0xd11/0xf00 net/vmw_vsock/virtio_transport_common.c:426
> Code: 0f 0b 90 bd f2 ff ff ff eb bc e8 2a 15 74 f6 c6 05 17 6f 40 04 01 90 48 c7 c7 00 4b b7 8c 44 89 f6 4c 89 ea e8 e0 f7 37 f6 90 <0f> 0b 90 90 e9 e1 fe ff ff e8 01 15 74 f6 90 0f 0b 90 e9 c5 f7 ff
> RSP: 0018:ffffc9000cc2f530 EFLAGS: 00010246
> RAX: 72837a5a4342cf00 RBX: 0000000000010000 RCX: ffff888033218000
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
> RBP: ffffffff8f8592b0 R08: 0000000000000003 R09: 0000000000000004
> R10: dffffc0000000000 R11: fffffbfff1bfa6ec R12: dffffc0000000000
> R13: 0000000000010000 R14: 0000000000000000 R15: ffff8880406730e4
> FS:  00007fc0bd7eb6c0(0000) GS:ffff88808d230000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fd5857ec368 CR3: 00000000517cf000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  virtio_transport_stream_enqueue net/vmw_vsock/virtio_transport_common.c:1111 [inline]
>  virtio_transport_seqpacket_enqueue+0x143/0x1c0 net/vmw_vsock/virtio_transport_common.c:839
>  vsock_connectible_sendmsg+0xac4/0x1050 net/vmw_vsock/af_vsock.c:2123
>  sock_sendmsg_nosec net/socket.c:712 [inline]
>  __sock_sendmsg+0x219/0x270 net/socket.c:727
>  ____sys_sendmsg+0x52d/0x830 net/socket.c:2566
>  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
>  __sys_sendmmsg+0x227/0x430 net/socket.c:2709
>  __do_sys_sendmmsg net/socket.c:2736 [inline]
>  __se_sys_sendmmsg net/socket.c:2733 [inline]
>  __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2733
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc0bc98ebe9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fc0bd7eb038 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
> RAX: ffffffffffffffda RBX: 00007fc0bcbb5fa0 RCX: 00007fc0bc98ebe9
> RDX: 0000000000000001 RSI: 0000200000000100 RDI: 0000000000000004
> RBP: 00007fc0bca11e19 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000024008094 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fc0bcbb6038 R14: 00007fc0bcbb5fa0 R15: 00007ffdb7bf09f8
>  </TASK>
> 
> 
> Tested on:
> 
> commit:         66937314 vsock/virtio: Allocate nonlinear SKBs for han..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=159d75bc580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=84141250092a114f
> dashboard link: https://syzkaller.appspot.com/bug?extid=b4d960daf7a3c7c2b7b1
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> 
> Note: no patches were applied.


