Return-Path: <linux-kernel+bounces-833039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC5DBA1111
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA1E3A6CF1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268A9218ACC;
	Thu, 25 Sep 2025 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VWN9sZeP"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54CF433AD
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826002; cv=none; b=XKezT+RbbXQ47bjHJCo0wW37hq2V0pLWNAwGF8mIMKovzyNpGVZaWwdTI1WEymTfzLOrX+TiH9VFZdi+qSTUDy6ws/ItCN9APYM3bh54z/qBbMYjt7EYMmuxNqCTqyrpAel/FGdtNSfAWTRJ8E82TSlkDbajEsRBxS6zMlmQ8IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826002; c=relaxed/simple;
	bh=lfgcz3m4LxsJc7fu9Gh6cquree6UlWdW+wi7FdecF+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8adXLvOIhQAPUdNSGX81/QfdyAdcnIz6Sh+3h7IsK9+NIgjMzmBpbhkfOrsP4nbiAxfqfg8UPeMKIiAXX27yWR+d/AVhOxt+7ApUUjEQ0sdMiYGFOWF9BE4ROCRraUgFSneNtbqjvvWOF0orcT8jczbrRscEm0elymmRj80o7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VWN9sZeP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27a6c3f482dso11278595ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758826000; x=1759430800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLdUuxsUyFeLw5VmYATasRsILS+Z5g1sPWduMjqAJtQ=;
        b=VWN9sZePBfN8PboPgWPiYarkSaQayMFmyL4dwSRNIbNagtH0EkrrbtlQHgrePovVAE
         njAMWChJ5eh2jR25v9pMJkaW+hB8zhRMWNRxf2/QW5aHTjayVyrcI2NL0eZ+Tmp5B0sq
         DBC9YZV5sfFeNFtN4pUj3C4CZO+3A8CxftmQFglqCMrENpNZOpDHgGK6Ay3JLXiY2rfW
         YpL9CnssC6D1ukSvVTNmyt/BnNyL/plYCUhuFP19vx8HpiSHSMOORIHCF8gF+QSb/4in
         5v3GPqIrd3/bdZG/b0/M8vTVk4Mkw3rNRPX59eZ6FLmqANaAjSR8iNSNVQxztCCWwQy2
         aMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758826000; x=1759430800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLdUuxsUyFeLw5VmYATasRsILS+Z5g1sPWduMjqAJtQ=;
        b=fSf/YB5D+b/Tk8Z9un8EiebxZAGv3cA11gIWI1lujYveJS7DaLkhZXHKNi04N17SRW
         3ACj/PRKstcyRjgnQLSpsP5RiBWdQQv2DHUjpLsulyDIXQpcgSR2JLftTjBdc7ZtGXfP
         Ppjg/kB7NlSHrezxb3Xq8n/e/euR8nDci/TL7+bSyYaKTYv9FblTdrirAFZWph8H9y9l
         70Qu9EAK5GQyNjyMqf2+mrvg8fb6pFIqOYRk1XpoZbLecULQhZXjE+88oMXe2mg0jsDG
         DCJGgPxQKmnEGjp6mKQPY/4XjStFEkxzzJZyBHn6U7f1ek2CblD/HLNYrj28hEw8vPn7
         W5rg==
X-Forwarded-Encrypted: i=1; AJvYcCVvVOeey7q1ZK562C0ikCsHpj3i9Nf0xflMrA9rhIEeJg9IC3ne1EvA7RbS9hUp2Fhqf8QFr/KRr8RRKuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxet3/VZPVyDZ/AxhP0ijK1ITQ1cuG/suo3nFIkGh9RI0ghKVZs
	ktGEFdwmreTctf+3PSmXbvfeQGInAZIOzuKm7nXLVtPyTAluNg8Dxz/wzrRZwKBZIww1b3MSyO2
	qiwVoRxQVo/BZ3HPv8+tVT35v+XDV6ClqGAN0ZtN8
X-Gm-Gg: ASbGnctQc5tdUTmF7Wb6kBgBCpBEbTGaH7wQ6QDHSkiLj4YXWyrRJsefrLJ6hHlESU/
	R7BYwEKtpa0G5CvLCUTI5GMeFebWQRh8ZcXs/ERF1gbMnci8IqdABsAOXC0GKRRGDwoRXVKqCtK
	T5l0Ttbz+2lMAsuq0XEAPnIi5bGorgo8shHw5XosU/1xAvOtNqL5F099R2yhMhQ/OaDKYGkLKV8
	w80sBy9N7/8SldOO0u9efjROy/emGHG9Rn4jVn1G7wRFhK0PgVuw3SKqg==
X-Google-Smtp-Source: AGHT+IFHjpr/efSIGkSFc5aOwJwEJU/g3ib8aCrwbTfnR8LYDmx3PXaFp3wa4hoCDt63NVnjWqyIsHdEpL7XBgbkxZg=
X-Received: by 2002:a17:902:d490:b0:277:71e6:b04d with SMTP id
 d9443c01a7336-27ed4a29e5dmr46669715ad.3.1758825999931; Thu, 25 Sep 2025
 11:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922121818.654011-1-wangliang74@huawei.com> <CANn89iLOyFnwD+monMHCmTgfZEAPWmhrZu-=8mvtMGyM9FG49g@mail.gmail.com>
In-Reply-To: <CANn89iLOyFnwD+monMHCmTgfZEAPWmhrZu-=8mvtMGyM9FG49g@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 25 Sep 2025 11:46:28 -0700
X-Gm-Features: AS18NWCbS5gc66qTtEBpXFcEyjAbYBGY7oQ_xwB_xqs7eGxR4FmmvHj2dUmJMhQ
Message-ID: <CAAVpQUBxoWW_4U2an4CZNoSi95OduUhArezHnzKgpV3oOYs5Jg@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: fix general protection fault in __smc_diag_dump
To: Wang Liang <wangliang74@huawei.com>
Cc: Eric Dumazet <edumazet@google.com>, alibuda@linux.alibaba.com, 
	dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com, 
	mjambigi@linux.ibm.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	yuehaibing@huawei.com, zhangchangzhong@huawei.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Eric for CCing me.

On Thu, Sep 25, 2025 at 7:32=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Sep 22, 2025 at 4:57=E2=80=AFAM Wang Liang <wangliang74@huawei.co=
m> wrote:
> >
> > The syzbot report a crash:
> >
> >   Oops: general protection fault, probably for non-canonical address 0x=
fbd5a5d5a0000003: 0000 [#1] SMP KASAN NOPTI
> >   KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xdead4e=
ad0000001f]
> >   CPU: 1 UID: 0 PID: 6949 Comm: syz.0.335 Not tainted syzkaller #0 PREE=
MPT(full)
> >   Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 08/18/2025
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
> > in inet_init_csk_locks(), because the struct smc_sock does not have str=
uct
> > inet_connection_sock as the first member.
> >
> > Previous commit 60ada4fe644e ("smc: Fix various oops due to inet_sock t=
ype
> > confusion.") add inet_sock as the first member of smc_sock. For protoco=
l
> > with INET_PROTOSW_ICSK, use inet_connection_sock instead of inet_sock i=
s
> > more appropriate.

Why is INET_PROTOSW_ICSK necessary in the first place ?

I don't see a clear reason because smc_clcsock_accept() allocates
a new sock by smc_sock_alloc() and does not use inet_accept().

Or is there any other path where smc_sock is cast to
inet_connection_sock ?


> >
> > Reported-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Df775be4458668f7d220e
> > Tested-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
> > Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> > Signed-off-by: Wang Liang <wangliang74@huawei.com>
> > ---
> >  net/smc/smc.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/smc/smc.h b/net/smc/smc.h
> > index 2c9084963739..1b20f0c927d3 100644
> > --- a/net/smc/smc.h
> > +++ b/net/smc/smc.h
> > @@ -285,7 +285,7 @@ struct smc_connection {
> >  struct smc_sock {                              /* smc sock container *=
/
> >         union {
> >                 struct sock             sk;
> > -               struct inet_sock        icsk_inet;
> > +               struct inet_connection_sock     inet_conn;
> >         };
> >         struct socket           *clcsock;       /* internal tcp socket =
*/
> >         void                    (*clcsk_state_change)(struct sock *sk);
> > --
> > 2.34.1
> >
>
> Kuniyuki, can you please review, I think you had a related fix recently.
>
> Thanks.
>
> commit 60ada4fe644edaa6c2da97364184b0425e8aeaf5
> Author: Kuniyuki Iwashima <kuniyu@google.com>
> Date:   Fri Jul 11 06:07:52 2025 +0000
>
>     smc: Fix various oops due to inet_sock type confusion.

