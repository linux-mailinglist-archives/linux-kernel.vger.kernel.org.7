Return-Path: <linux-kernel+bounces-865687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBFFBFDBFE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A72C189B3D0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3A12E7637;
	Wed, 22 Oct 2025 18:00:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0FA24634F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761156007; cv=none; b=ZXdXWXuycwmQZgVD9Oir4UVaupczW6Bxsj7ZuHLoU4dnm+UTFDuhQlLFa+TjwD6bRguDiCUB+5OymE3M5Zoc1MHc/p9N8xsKwyCl5FWow1D0sXs0WJCTa0pqVZIzxJpDvQqajjq0SG47RdrTLNAJ8CoaC0X4O96f66CpzSc3OGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761156007; c=relaxed/simple;
	bh=Iy23dOk2Xws00AQtshp2ZfIqszeR9BuoSWSsqdFbTVc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rGgKQcDfZa3iQYylz0WinCnXyfOHe4z65gCRksoKNQ9oMYXl188rMMQs5kNOHQIOuFjlpE6YefxJPjJyxgAeLHHO4FfRNh21U3vvt8aSDqwr6col8e6VjrGcrNpzcqlD8p3EFPzAQ/Hyg/ruhHewAHuOIpICcePJF2+BXiO/HVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430e1a4a129so52256715ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761156004; x=1761760804;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6TRX+0wa09P5DS+E74Lm/QP3pffhgmywZN35ZMF9YM=;
        b=kW/r5N5uE7UYJ2vbseRGZ+Zp36sZvg18yRXKSvQJXPc9jyOsUsqcqQE/OE75/bl3hF
         nkZkbxpOm7y3/winis1Y6e3731T461VyiPOS0bIbcLLv7RU77nX1rifm0EeLzyFa0HMB
         vJPHLmO0UVS48S/zqlxjPYmsHJ/4aVpbJ0zuZxEtsUpdqKYKM8kiEQUXKUvGi2zF8RBe
         oTJBcbfCbYHBpiEHU0wMlDkYAU8AgIDczakoQC4mO/H2RO89KyjeRQeZ3vRroyMpvsTA
         MpxiE4faPH5QfXkGZqdr54neWYzZehs0f/SF+n/PIO4cRA8nzojOUW0kWVVunvT93k71
         syMQ==
X-Gm-Message-State: AOJu0YxAh+l50c6VZ9P/VAXTVH4J7iNk93HBIp4+955Gd/JUqTHRkca7
	i4K1ubxqCeHA+XGGxu7R8CkCkosFaSBD/Y7vjPHMhzcuP6JEvV0o+FXbWV9DKxFhQE0/rVjpUr6
	CiqsjMqTv2zXi0lveYmCPxF48YpIiGVmpnkvMYLpd5179Z+/jdrbEJgcdZDE=
X-Google-Smtp-Source: AGHT+IG4rN14vgA5HcFiSADqEn3X4IKsIXdKFBt36khE0pl5tJKuQPSBg/F0aJP467viLwzjjhrH76w3TYiC0WjAq69QqJbQuoxM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1745:b0:42f:91aa:510b with SMTP id
 e9e14a558f8ab-430c51eac3dmr281711575ab.4.1761156004367; Wed, 22 Oct 2025
 11:00:04 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:00:04 -0700
In-Reply-To: <68f659cd.050a0220.91a22.044c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f91ba4.050a0220.346f24.005f.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [sctp?] KMSAN: uninit-value in sctp_inq_pop (3)
From: syzbot <syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [sctp?] KMSAN: uninit-value in sctp_inq_pop (3)
Author: vnranganath.20@gmail.com

#syz test

On Wed, Oct 22, 2025 at 5:23=E2=80=AFPM syzbot <
syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com> wrote:

> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still
> triggering an issue:
> KMSAN: uninit-value in sctp_inq_pop
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in sctp_inq_pop+0x159c/0x1aa0
> net/sctp/inqueue.c:213
>  sctp_inq_pop+0x159c/0x1aa0 net/sctp/inqueue.c:213
>  sctp_assoc_bh_rcv+0x1a0/0xbc0 net/sctp/associola.c:980
>  sctp_inq_push+0x2a6/0x350 net/sctp/inqueue.c:88
>  sctp_backlog_rcv+0x3c7/0xda0 net/sctp/input.c:331
>  sk_backlog_rcv+0x142/0x420 include/net/sock.h:1158
>  __release_sock+0x1ef/0x380 net/core/sock.c:3180
>  release_sock+0x6b/0x270 net/core/sock.c:3735
>  sctp_sendmsg+0x3a2b/0x49f0 net/sctp/socket.c:2036
>  inet_sendmsg+0x26c/0x2a0 net/ipv4/af_inet.c:853
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg+0x278/0x3d0 net/socket.c:742
>  sock_sendmsg+0x170/0x280 net/socket.c:765
>  splice_to_socket+0x10e6/0x1a60 fs/splice.c:886
>  do_splice_from fs/splice.c:938 [inline]
>  do_splice+0x1fd2/0x30d0 fs/splice.c:1351
>  __do_splice fs/splice.c:1433 [inline]
>  __do_sys_splice fs/splice.c:1636 [inline]
>  __se_sys_splice+0x549/0x8c0 fs/splice.c:1618
>  __x64_sys_splice+0x114/0x1a0 fs/splice.c:1618
>  x64_sys_call+0x3140/0x3e30
> arch/x86/include/generated/asm/syscalls_64.h:276
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was stored to memory at:
>  sctp_inq_pop+0x150b/0x1aa0 net/sctp/inqueue.c:209
>  sctp_assoc_bh_rcv+0x1a0/0xbc0 net/sctp/associola.c:980
>  sctp_inq_push+0x2a6/0x350 net/sctp/inqueue.c:88
>  sctp_backlog_rcv+0x3c7/0xda0 net/sctp/input.c:331
>  sk_backlog_rcv+0x142/0x420 include/net/sock.h:1158
>  __release_sock+0x1ef/0x380 net/core/sock.c:3180
>  release_sock+0x6b/0x270 net/core/sock.c:3735
>  sctp_sendmsg+0x3a2b/0x49f0 net/sctp/socket.c:2036
>  inet_sendmsg+0x26c/0x2a0 net/ipv4/af_inet.c:853
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg+0x278/0x3d0 net/socket.c:742
>  sock_sendmsg+0x170/0x280 net/socket.c:765
>  splice_to_socket+0x10e6/0x1a60 fs/splice.c:886
>  do_splice_from fs/splice.c:938 [inline]
>  do_splice+0x1fd2/0x30d0 fs/splice.c:1351
>  __do_splice fs/splice.c:1433 [inline]
>  __do_sys_splice fs/splice.c:1636 [inline]
>  __se_sys_splice+0x549/0x8c0 fs/splice.c:1618
>  __x64_sys_splice+0x114/0x1a0 fs/splice.c:1618
>  x64_sys_call+0x3140/0x3e30
> arch/x86/include/generated/asm/syscalls_64.h:276
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:4969 [inline]
>  slab_alloc_node mm/slub.c:5272 [inline]
>  kmem_cache_alloc_node_noprof+0x989/0x16b0 mm/slub.c:5324
>  kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:579
>  __alloc_skb+0x347/0x7d0 net/core/skbuff.c:670
>  alloc_skb include/linux/skbuff.h:1383 [inline]
>  sctp_packet_transmit+0x44b/0x46d0 net/sctp/output.c:598
>  sctp_outq_flush_transports net/sctp/outqueue.c:1173 [inline]
>  sctp_outq_flush+0x1c7d/0x67c0 net/sctp/outqueue.c:1221
>  sctp_outq_uncork+0x9e/0xc0 net/sctp/outqueue.c:764
>  sctp_cmd_interpreter net/sctp/sm_sideeffect.c:-1 [inline]
>  sctp_side_effects net/sctp/sm_sideeffect.c:1204 [inline]
>  sctp_do_sm+0x8c8e/0x9720 net/sctp/sm_sideeffect.c:1175
>  sctp_primitive_SEND+0xd7/0x110 net/sctp/primitive.c:163
>  sctp_sendmsg_to_asoc+0x1db8/0x2250 net/sctp/socket.c:1873
>  sctp_sendmsg+0x3910/0x49f0 net/sctp/socket.c:2031
>  inet_sendmsg+0x26c/0x2a0 net/ipv4/af_inet.c:853
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg+0x278/0x3d0 net/socket.c:742
>  sock_sendmsg+0x170/0x280 net/socket.c:765
>  splice_to_socket+0x10e6/0x1a60 fs/splice.c:886
>  do_splice_from fs/splice.c:938 [inline]
>  do_splice+0x1fd2/0x30d0 fs/splice.c:1351
>  __do_splice fs/splice.c:1433 [inline]
>  __do_sys_splice fs/splice.c:1636 [inline]
>  __se_sys_splice+0x549/0x8c0 fs/splice.c:1618
>  __x64_sys_splice+0x114/0x1a0 fs/splice.c:1618
>  x64_sys_call+0x3140/0x3e30
> arch/x86/include/generated/asm/syscalls_64.h:276
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> CPU: 1 UID: 0 PID: 6609 Comm: syz.0.18 Not tainted syzkaller #0
> PREEMPT(none)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 10/02/2025
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
>
> Tested on:
>
> commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D145e2d4258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbbd3e7f3c2e28=
265
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3Dd101e12bccd4095460e7
> compiler:       Debian clang version 20.1.8
> (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.=
1.8
> patch:
> https://syzkaller.appspot.com/x/patch.diff?x=3D165fd734580000
>
>

