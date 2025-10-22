Return-Path: <linux-kernel+bounces-864867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BA7BFBBB8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D77C94E7152
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C3533F8C8;
	Wed, 22 Oct 2025 11:53:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C043A33EB0A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133984; cv=none; b=BmQ0/PT6MJdrGtXsxrz9tC6GdgER+8+KDq3bNIm44KrPtL7X5xVcIX+vRT+Faq188pUq6+pISGDqSard6lyk9i93DDuqJ2Slbm05DUjcvgHNoBKDdGnfN39ddjKcd6C/1QVVjdSz2vlbzZq5z2VsEfKZVP1W74DnY/ni5FEWAAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133984; c=relaxed/simple;
	bh=xITn8FgPNzTngTKdZsYQy1UkUjtiW64ALWolI/P+5HI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HovpChKidEhClqZ2fzbz9OX8iW4kZ3PpPmpnpI/30CnMFDHaP83AMD+x7u20G+rytO30+lOIeD5rFFk3yO/kX4MqQWq9E55AirAt2y1IHn4T40mWQvgAinRTJundUOQv+AoPuiJo7Vy/mZN5CrYY7KUp+VWy6XlWslHs6Ln3m8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430d789ee5aso47346495ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761133982; x=1761738782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2uS3XrNGTpKV2VbD+d8nSHpOKfghfR+E94LknWDOsQ=;
        b=PEkMw2ox7YMyxRndmMn+8298WbL3o/NRn2In45uU5B9kZQcLmR3dkjyFKrH5dLFoUy
         IiFCvDJXapHq5vIy9AKtxHH394v9LDOkxkYYEmf2EWvmpy5ntaEw434B2OSrkEPDAUAI
         1aSUV2lZKzcG+mfy2p43OTF4/bXcAv1h+5JWrynPb0rjs0vyO0X7dBKpGTr9l/w0euPa
         RJSHG/64tJMLieHyiP6R/SdZiH91iIPySNAPzhh4WOWFWoHtdZ5CH1BUtpCUPc2bqTrt
         FtiE2FKhc5Vz+2pArJziPZL5EvaCZaHAlDbRabawcUH7Rn8cim3nySgAVBiGl+DT0f4y
         boPA==
X-Gm-Message-State: AOJu0YxZzv3TgjqSWes7oK55YFmHRWq5YBgHiAiM6+KTkX2xd4zyAyY9
	ryBf3SZYhfZkaA+Tl2R86rJ4oEZXG4QkqgX7QWzCFnNLlenzqLpmFBVsHF1JGu4C4w5pp3bmHvF
	oLkanIgWj62Hsxo0W/yGvw18Z4iBg1RJNpdn6ZdJClaFsAVSUuR83ZMNsYqY=
X-Google-Smtp-Source: AGHT+IETae1A1mSFKNPbMUVS49YYlh0XAFFI3I6G6oxTEtjr/+naJYUywAYIVGzwR2Ql0fzSxDB5MZGguI/Bxt9nl/Ttm39gyqeE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2307:b0:42f:a60a:8538 with SMTP id
 e9e14a558f8ab-430c52b5afemr251762865ab.16.1761133981973; Wed, 22 Oct 2025
 04:53:01 -0700 (PDT)
Date: Wed, 22 Oct 2025 04:53:01 -0700
In-Reply-To: <CAMz+-CMyk977BbuBbKSu1tQOB+4=g0srcqb-EoEfKXE7exAH3w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8c59d.050a0220.346f24.0043.GAE@google.com>
Subject: Re: [syzbot] [sctp?] KMSAN: uninit-value in sctp_inq_pop (3)
From: syzbot <syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	vnranganath.20@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in sctp_inq_pop

=====================================================
BUG: KMSAN: uninit-value in sctp_inq_pop+0x159c/0x1aa0 net/sctp/inqueue.c:213
 sctp_inq_pop+0x159c/0x1aa0 net/sctp/inqueue.c:213
 sctp_assoc_bh_rcv+0x1a0/0xbc0 net/sctp/associola.c:980
 sctp_inq_push+0x2a6/0x350 net/sctp/inqueue.c:88
 sctp_backlog_rcv+0x3c7/0xda0 net/sctp/input.c:331
 sk_backlog_rcv+0x142/0x420 include/net/sock.h:1158
 __release_sock+0x1ef/0x380 net/core/sock.c:3180
 release_sock+0x6b/0x270 net/core/sock.c:3735
 sctp_sendmsg+0x3a2b/0x49f0 net/sctp/socket.c:2036
 inet_sendmsg+0x26c/0x2a0 net/ipv4/af_inet.c:853
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x278/0x3d0 net/socket.c:742
 sock_sendmsg+0x170/0x280 net/socket.c:765
 splice_to_socket+0x10e6/0x1a60 fs/splice.c:886
 do_splice_from fs/splice.c:938 [inline]
 do_splice+0x1fd2/0x30d0 fs/splice.c:1351
 __do_splice fs/splice.c:1433 [inline]
 __do_sys_splice fs/splice.c:1636 [inline]
 __se_sys_splice+0x549/0x8c0 fs/splice.c:1618
 __x64_sys_splice+0x114/0x1a0 fs/splice.c:1618
 x64_sys_call+0x3140/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:276
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 sctp_inq_pop+0x150b/0x1aa0 net/sctp/inqueue.c:209
 sctp_assoc_bh_rcv+0x1a0/0xbc0 net/sctp/associola.c:980
 sctp_inq_push+0x2a6/0x350 net/sctp/inqueue.c:88
 sctp_backlog_rcv+0x3c7/0xda0 net/sctp/input.c:331
 sk_backlog_rcv+0x142/0x420 include/net/sock.h:1158
 __release_sock+0x1ef/0x380 net/core/sock.c:3180
 release_sock+0x6b/0x270 net/core/sock.c:3735
 sctp_sendmsg+0x3a2b/0x49f0 net/sctp/socket.c:2036
 inet_sendmsg+0x26c/0x2a0 net/ipv4/af_inet.c:853
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x278/0x3d0 net/socket.c:742
 sock_sendmsg+0x170/0x280 net/socket.c:765
 splice_to_socket+0x10e6/0x1a60 fs/splice.c:886
 do_splice_from fs/splice.c:938 [inline]
 do_splice+0x1fd2/0x30d0 fs/splice.c:1351
 __do_splice fs/splice.c:1433 [inline]
 __do_sys_splice fs/splice.c:1636 [inline]
 __se_sys_splice+0x549/0x8c0 fs/splice.c:1618
 __x64_sys_splice+0x114/0x1a0 fs/splice.c:1618
 x64_sys_call+0x3140/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:276
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4969 [inline]
 slab_alloc_node mm/slub.c:5272 [inline]
 kmem_cache_alloc_node_noprof+0x989/0x16b0 mm/slub.c:5324
 kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:579
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:670
 alloc_skb include/linux/skbuff.h:1383 [inline]
 sctp_packet_transmit+0x44b/0x46d0 net/sctp/output.c:598
 sctp_outq_flush_transports net/sctp/outqueue.c:1173 [inline]
 sctp_outq_flush+0x1c7d/0x67c0 net/sctp/outqueue.c:1221
 sctp_outq_uncork+0x9e/0xc0 net/sctp/outqueue.c:764
 sctp_cmd_interpreter net/sctp/sm_sideeffect.c:-1 [inline]
 sctp_side_effects net/sctp/sm_sideeffect.c:1204 [inline]
 sctp_do_sm+0x8c8e/0x9720 net/sctp/sm_sideeffect.c:1175
 sctp_primitive_SEND+0xd7/0x110 net/sctp/primitive.c:163
 sctp_sendmsg_to_asoc+0x1db8/0x2250 net/sctp/socket.c:1873
 sctp_sendmsg+0x3910/0x49f0 net/sctp/socket.c:2031
 inet_sendmsg+0x26c/0x2a0 net/ipv4/af_inet.c:853
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x278/0x3d0 net/socket.c:742
 sock_sendmsg+0x170/0x280 net/socket.c:765
 splice_to_socket+0x10e6/0x1a60 fs/splice.c:886
 do_splice_from fs/splice.c:938 [inline]
 do_splice+0x1fd2/0x30d0 fs/splice.c:1351
 __do_splice fs/splice.c:1433 [inline]
 __do_sys_splice fs/splice.c:1636 [inline]
 __se_sys_splice+0x549/0x8c0 fs/splice.c:1618
 __x64_sys_splice+0x114/0x1a0 fs/splice.c:1618
 x64_sys_call+0x3140/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:276
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 6609 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
=====================================================


Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145e2d42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbd3e7f3c2e28265
dashboard link: https://syzkaller.appspot.com/bug?extid=d101e12bccd4095460e7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=165fd734580000


