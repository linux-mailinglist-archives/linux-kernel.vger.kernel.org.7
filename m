Return-Path: <linux-kernel+bounces-857317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3151BE6805
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 303513565EC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE2230E0F4;
	Fri, 17 Oct 2025 05:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YVYPJ5xJ"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B230B1C84BC
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760680487; cv=none; b=FNgJWybRXtO+4/3Bs6nWcxQhZsGQbjJXp0FawRd/eiUPq16vHX0+RWi7Xdv4kOCmDhT5qhRuwChiADCDmxCHxy7g5rJ03V0r+daseYaHexIJ1IksDql4k6RLwLpSySqLIXgf8/KC4mZokSYoAo2hEunypM+G0Y+YYfFfvaAttQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760680487; c=relaxed/simple;
	bh=AzoQ4i/srN8FpTZFrJJz4zAfUAY4stVL58foSLnf8aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmfDNLp+/ztzHIT86urXTV42A6rrM0vjtgfMJDtT3SYrjNzux59agkWmkZpH4pnwLGfHzm/rwaXADU97ikqVlFe6wOgoCCVpX1Iy5jzJwp5HWI278j28hoZ21RaZmDvgk2gvwiBZaWhKcGbSAKM4RsTZXQ5GKQaYKekONtUo9yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YVYPJ5xJ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7836853a0d6so18428487b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760680484; x=1761285284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26UkdI1wBp0Xi61UmFjaGlIQEnXQ+0LgrUBcqpJYfDU=;
        b=YVYPJ5xJz5DjfRTUt3IakV/uIpcmUTe7xVV7l7vG5DOcHtbm9OySV/oHs/DWg4HOIM
         J3CH+kYYKmNG1EcZyUXb7r8vB8PzwWfRXIeoXmj5htH/5EOTTUDhwLRfV3NOAWjW1CVS
         N/1jFj64F7cZLt7FElmAj18gb5dDqhi3Jz7x0+a6Ja09KRIi8L9nUjN1UUwWbrGYBwKz
         YRigM97U3KHj4NJp9jlFV8YS/5QiqVXIPY26mabJyHemtxZK5DLJ+auAhHmKaxqxv7Ht
         4qR0U4HOgJ8ojOqfHEb/6itYvVfF1DAIWNtY0dQqHB+jOwV1gP86JcvRsUQHyqk0FZbE
         VrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760680484; x=1761285284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26UkdI1wBp0Xi61UmFjaGlIQEnXQ+0LgrUBcqpJYfDU=;
        b=KAU3GT2LqosqHdMu6/n63UZ/MqouAKgIzaxzLWtJwVUTxz796BfYQgVGTI9jVZDh1u
         GtdL3Id+zAYGp32cYNBqCpBlEahfYlYGD7Tg4eZmhKyEXdA2VQu/GtPGUfPxnXEHsSd5
         XuYGl/idStUlNVwvMc7DRGDJ3JiI91SBaaI2EDYy2Xtf8T/WMh1SgvUUqnAtI6ZeDoFJ
         bO2qrbLnKEebcxpZXRbDPi12qmXQ/IFpJEBGNsbA708Z7xs4FEZ2cJHxY5crdkS8We0h
         F9rDKys7DlE/4oTzNFnBsL7dHb7eSNeQduHXkd/Ry21dG/z0kJzRuijqtCFqNIhhLC8O
         CZPw==
X-Forwarded-Encrypted: i=1; AJvYcCWz3ONBBxOnT+wyLcL39jkPIKSAcUN6xkmNt5zGj1THNM7+eMivpX0x/xoaXFTDw6tm9BwkCDit0m+c+B0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ7XP6x9Qa0DLiH5lBCNLWYBRYeI3curNi5Jcm29GY7EocNzzI
	/+troovhiZx9/hu97AlMWMLl6VD8pAzy3S3iGJZU9VTuSf6kxkMthrBAhQhCib8eIxeBpPzZODx
	ahV1SuHbMVLBfalvUH79cr1VM9sqiOFaQmNr5IoYI
X-Gm-Gg: ASbGnctpNzFCpcvM45k4GXFaJMNEJsfwxsOloHGLaEXTf29nyqqjjglHjr6OSOW3hAA
	ttNAAes0E8Qk8CIEmwV5rueouN+u6TwBlDnLeyxD5WhIbK+jipXdYy4BiJRBnxxf9vxEk5JGk98
	caYet3PiezTf2ZwvHIR9FDAsvX7+Bw+4tePEfBUs4Ml1EhUyeCvWQ6YUKD54rr/0l6uvWDO8PMI
	ul0P/ksUDwBDlqbYo5hypXSTqG/nbujP6w580oolbc9Nv8tTOvZ7fOvefY=
X-Google-Smtp-Source: AGHT+IHsN8XKGFc1pmq1dLy5gZIAu/2/L7IYb6L12Ta0DohYp6BNuhOBNV89pr4e5xJtcC1TCmMzZcpB8Bt4srH6t4M=
X-Received: by 2002:a05:690e:168b:b0:63e:1113:bde2 with SMTP id
 956f58d0204a3-63e1113c469mr2815324d50.20.1760680483191; Thu, 16 Oct 2025
 22:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017024827.3137512-1-wangliang74@huawei.com> <20251017055106.3603987-1-kuniyu@google.com>
In-Reply-To: <20251017055106.3603987-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 Oct 2025 22:54:31 -0700
X-Gm-Features: AS18NWCfR7jSXBSalgtHDaSKYVywq8UEZkUHYIuFi4bvybirdzcP5DjBZY6mcTU
Message-ID: <CANn89iKXU71cZYefVSQDa-1rc0oGs0vjFUkL=oPyG93c-ezP1A@mail.gmail.com>
Subject: Re: [PATCH net v2] net/smc: fix general protection fault in __smc_diag_dump
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: wangliang74@huawei.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	dust.li@linux.alibaba.com, guwen@linux.alibaba.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, mjambigi@linux.ibm.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sidraya@linux.ibm.com, tonylu@linux.alibaba.com, 
	wenjia@linux.ibm.com, yuehaibing@huawei.com, zhangchangzhong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 10:51=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> From: Wang Liang <wangliang74@huawei.com>
> Date: Fri, 17 Oct 2025 10:48:27 +0800
> > The syzbot report a crash:
> >
> >   Oops: general protection fault, probably for non-canonical address 0x=
fbd5a5d5a0000003: 0000 [#1] SMP KASAN NOPTI
> >   KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xdead4e=
ad0000001f]
> >   CPU: 1 UID: 0 PID: 6949 Comm: syz.0.335 Not tainted syzkaller #0 PREE=
MPT(full)
> >   Hardware name: Google Compute Engine/Google Compute Engine, BIOS Goog=
le 08/18/2025
> >   RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
> >   RIP: 0010:__smc_diag_dump.constprop.0+0x3ca/0x2550 net/smc/smc_diag.c=
:89
> >   Call Trace:
> >    <TASK>
> >    smc_diag_dump_proto+0x26d/0x420 net/smc/smc_diag.c:217
> >    smc_diag_dump+0x27/0x90 net/smc/smc_diag.c:234
> >    netlink_dump+0x539/0xd30 net/netlink/af_netlink.c:2327
> >    __netlink_dump_start+0x6d6/0x990 net/netlink/af_netlink.c:2442
> >    netlink_dump_start include/linux/netlink.h:341 [inline]
> >    smc_diag_handler_dump+0x1f9/0x240 net/smc/smc_diag.c:251
> >    __sock_diag_cmd net/core/sock_diag.c:249 [inline]
> >    sock_diag_rcv_msg+0x438/0x790 net/core/sock_diag.c:285
> >    netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
> >    netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
> >    netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1346
> >    netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
> >    sock_sendmsg_nosec net/socket.c:714 [inline]
> >    __sock_sendmsg net/socket.c:729 [inline]
> >    ____sys_sendmsg+0xa95/0xc70 net/socket.c:2614
> >    ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
> >    __sys_sendmsg+0x16d/0x220 net/socket.c:2700
> >    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >    do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
> >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >    </TASK>
> >
> > The process like this:
> >
> >                (CPU1)              |             (CPU2)
> >   ---------------------------------|-------------------------------
> >   inet_create()                    |
> >     // init clcsock to NULL        |
> >     sk =3D sk_alloc()                |
> >                                    |
> >     // unexpectedly change clcsock |
> >     inet_init_csk_locks()          |
> >                                    |
> >     // add sk to hash table        |
> >     smc_inet_init_sock()           |
> >       smc_sk_init()                |
> >         smc_hash_sk()              |
> >                                    | // traverse the hash table
> >                                    | smc_diag_dump_proto
> >                                    |   __smc_diag_dump()
> >                                    |     // visit wrong clcsock
> >                                    |     smc_diag_msg_common_fill()
> >     // alloc clcsock               |
> >     smc_create_clcsk               |
> >       sock_create_kern             |
> >
> > With CONFIG_DEBUG_LOCK_ALLOC=3Dy, the smc->clcsock is unexpectedly chan=
ged
> > in inet_init_csk_locks(). The INET_PROTOSW_ICSK flag is no need by smc,
> > just remove it.
> >
> > After removing the INET_PROTOSW_ICSK flag, this patch alse revert
> > commit 6fd27ea183c2 ("net/smc: fix lacks of icsk_syn_mss with IPPROTO_S=
MC")
> > to avoid casting smc_sock to inet_connection_sock.
> >
> > Reported-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Df775be4458668f7d220e
> > Tested-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
>
> nit: looks like this diff is not tested by syzbot, you may
> want to send diff to syzbot.
>
>
> > Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> > Signed-off-by: Wang Liang <wangliang74@huawei.com>
>
> Change itself looks good.
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Agreed

Reviewed-by: Eric Dumazet <edumazet@google.com>

