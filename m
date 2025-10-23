Return-Path: <linux-kernel+bounces-867913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73252C03E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F183A948C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED10B2DE6F7;
	Fri, 24 Oct 2025 00:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eVspxam6"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63BB9463
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761264004; cv=none; b=MMyf6Z7sDoIpHxIiwUTxnvSyLWLwIPlRJj+sWHabrJERAfDe3MwA9LrKVehYLb4l0SJYZFa60AM4VnlPr47dhC9pGeuuGZjzvRjqDvbdtWoLS0h83oQcZEHrNpeJBm2mDk5qIcsfK4raqGvPy6QBtWavhcdzl8zTKcwHwJ1YaUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761264004; c=relaxed/simple;
	bh=UOh8mB8WDXLQ8rCuslROXcbfJ/mekEfswqxcR6u+UwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3hCREw4L6iWlFcbrmAhIXfhoEi+eScmtciFNgMfWA25/HyCE8JWfuhkI0ggL7Ul5nfCav2WzwcBdQURVd11LUzNL1TxRvbw0nf7GdIKzOh2uFZWCC4Y0+U0K0h/C480MmClkBMQgiUOeqWbFAMafP/UlbOaA3F6tOtC8RVcXNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eVspxam6; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso1073456a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761264002; x=1761868802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eow8eqv1EBEny+9tfsqhZP33Bgy/MHM97diG02bQQhY=;
        b=eVspxam6lk7jYYjGLtWIjL41j7BRCSdow2K8ruxzg33fdNIigWmZQbFECZcLCusxsN
         y6i3Rt3vas0J8F4uQ1/7/JsJZ7kf/6DgXhTpbufWvuUtqcx6eDuJrFe67nMZQIot9Vf/
         BMPCPMUbBAaX08HlRDcM0d+PrrPUK8kG6wHLaOHg1d2ve6OMPRp//PUIfb8/fH17H3eU
         zxMsDeX80XRAIKPF1aiLcMtrvHNFg3Fq8Q2Xt+Bj5T1Z5cV+Xvfc9O8+6nu3J/Deb9o0
         lxENLmqFZfiDxnPBUq7TmFhs0o2z7LuKHrW2dGL34ceJ86unpv9q9eNZdnwecD+AUS2G
         s1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761264002; x=1761868802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eow8eqv1EBEny+9tfsqhZP33Bgy/MHM97diG02bQQhY=;
        b=Jbd3it65XMSPAkmrYtXHVsNlsi51DRfrBoqQQBitrCBP9ns7yHGkX0YWi7dfaFSFFF
         EWe95k9qFTD8YHdT5V74Ni+I2+oWGbLcF1U5CmT8SR0iTVhYDd64moFSH/Su3xJwo2GT
         M7qXV+qFgbHypq/zJ9STPNXSzwsBp9nku/Z2sxQiO9ROrLCRSceQjQ07CrNirOlgBGC9
         p8+Io4pjJPSoKk4jhGcQYB3s7VxdODV0d4zzmKRRhicHxpWhBLy24/fjtcjhkFsT+QWB
         VRByAXtT+4m8FR7UkMmz/aekCCPZiYO2ear2Ldq7fbcDY1RJpvBOtXM1o20pzB0xV9CP
         XRuA==
X-Forwarded-Encrypted: i=1; AJvYcCWdXfHJAk52iJxJdYlhfuW6H5CKEIoHIfMxAqZ3c1Ba3CDYkxNOIIM4GHDMSSpazgqzVwFFEInixF9xKOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlCygS+Yk11mqVhrkVQhyd77vjl4IRCcJj5RZvmkrdO4kD4TL9
	VQQRprEgNzR25xVcDQMSTc2LV8fAjEoKk0JTk9SqFS8SCG9jCmFXg6hTGePwbvSESgSTiOzdCyX
	Bljp9Ehl26ffdkIdDIsL0s4kmc4QcjsvrDXLVo/Ob
X-Gm-Gg: ASbGncuy3pcfKWuU5BIH9b3afIkf52psnj8Bz1ua2X1+pn1ibnn/eIs/wAZZi2q+dPA
	rzHEdENR13q2rJQpeC6U0RiRPThSfsups4aRM65ZybrA3URui5+rkfGn2Ofz03iqdD0s7xoVgqP
	0oxhF2GCqcEj0tGBo+yc5VCFH7VnLGjzkmW6xJToNQj5t4M5XtdRwh1wyyI9Hgpb9hXcQ+5KI0Z
	Vugfx+dvL/szz80pq/oWzGZRgJ29zt+7yDA0VfqdlNXkttZ4dauGmtO0+/ufFXPVapsDEPUqhZJ
	wBrtB7NciAEr96MRljqcRueBPQ==
X-Google-Smtp-Source: AGHT+IHt8gMR9y0AAWhI9DUtNmYkubBOMelIqJN+hItbFXCKxi4sY3xTIBup4sCgLG9e8qQ0WSy3WyloG8BWF6LwyLQ=
X-Received: by 2002:a17:902:dacd:b0:269:936c:88da with SMTP id
 d9443c01a7336-290cc2f852amr338930225ad.41.1761264001680; Thu, 23 Oct 2025
 17:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023191807.74006-2-stefan.wiehler@nokia.com> <20251023235259.4179388-1-kuniyu@google.com>
In-Reply-To: <20251023235259.4179388-1-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 23 Oct 2025 16:59:50 -0700
X-Gm-Features: AS18NWDifk6nqX9O27RNH6NC3zP3eWAfwyeoUCzRu6n-no5YRE_By_riVCpdm4c
Message-ID: <CAAVpQUBxfpYHaSxS8o8SAecT27YtrNhcVY9O=rSYFr3GshF0_Q@mail.gmail.com>
Subject: Re: [PATCH net] sctp: Hold RCU read lock while iterating over address list
To: stefan.wiehler@nokia.com
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 4:53=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> From: Stefan Wiehler <stefan.wiehler@nokia.com>
> Date: Thu, 23 Oct 2025 21:18:08 +0200
> > With CONFIG_PROVE_RCU_LIST=3Dy and by executing
> >
> >   $ netcat -l --sctp &
> >   $ netcat --sctp localhost &
> >   $ ss --sctp
> >
> > one can trigger the following Lockdep-RCU splat(s):
> >
> >   WARNING: suspicious RCU usage
> >   6.18.0-rc1-00093-g7f864458e9a6 #5 Not tainted
> >   -----------------------------
> >   net/sctp/diag.c:76 RCU-list traversed in non-reader section!!
> >
> >   other info that might help us debug this:
> >
> >   rcu_scheduler_active =3D 2, debug_locks =3D 1
> >   2 locks held by ss/215:
> >    #0: ffff9c740828bec0 (nlk_cb_mutex-SOCK_DIAG){+.+.}-{4:4}, at: __net=
link_dump_start+0x84/0x2b0
> >    #1: ffff9c7401d72cd0 (sk_lock-AF_INET6){+.+.}-{0:0}, at: sctp_sock_d=
ump+0x38/0x200
> >
> >   stack backtrace:
> >   CPU: 0 UID: 0 PID: 215 Comm: ss Not tainted 6.18.0-rc1-00093-g7f86445=
8e9a6 #5 PREEMPT(voluntary)
> >   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.=
3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> >   Call Trace:
> >    <TASK>
> >    dump_stack_lvl+0x5d/0x90
> >    lockdep_rcu_suspicious.cold+0x4e/0xa3
> >    inet_sctp_diag_fill.isra.0+0x4b1/0x5d0
> >    sctp_sock_dump+0x131/0x200
> >    sctp_transport_traverse_process+0x170/0x1b0
> >    ? __pfx_sctp_sock_filter+0x10/0x10
> >    ? __pfx_sctp_sock_dump+0x10/0x10
> >    sctp_diag_dump+0x103/0x140
> >    __inet_diag_dump+0x70/0xb0
> >    netlink_dump+0x148/0x490
> >    __netlink_dump_start+0x1f3/0x2b0
> >    inet_diag_handler_cmd+0xcd/0x100
> >    ? __pfx_inet_diag_dump_start+0x10/0x10
> >    ? __pfx_inet_diag_dump+0x10/0x10
> >    ? __pfx_inet_diag_dump_done+0x10/0x10
> >    sock_diag_rcv_msg+0x18e/0x320
> >    ? __pfx_sock_diag_rcv_msg+0x10/0x10
> >    netlink_rcv_skb+0x4d/0x100
> >    netlink_unicast+0x1d7/0x2b0
> >    netlink_sendmsg+0x203/0x450
> >    ____sys_sendmsg+0x30c/0x340
> >    ___sys_sendmsg+0x94/0xf0
> >    __sys_sendmsg+0x83/0xf0
> >    do_syscall_64+0xbb/0x390
> >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >    ...
> >    </TASK>
> >
> > Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
> > Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> > ---
> > It might be sufficient to add a check for one of the already held locks=
,
> > but I lack the domain knowledge to be sure about that...
> > ---
> >  net/sctp/diag.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> > index 996c2018f0e6..1a8761f87bf1 100644
> > --- a/net/sctp/diag.c
> > +++ b/net/sctp/diag.c
> > @@ -73,19 +73,23 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_=
buff *skb,
> >       struct nlattr *attr;
> >       void *info =3D NULL;
> >
> > +     rcu_read_lock();
> >       list_for_each_entry_rcu(laddr, address_list, list)
> >               addrcnt++;
> > +     rcu_read_unlock();
> >
> >       attr =3D nla_reserve(skb, INET_DIAG_LOCALS, addrlen * addrcnt);
> >       if (!attr)
> >               return -EMSGSIZE;
> >
> >       info =3D nla_data(attr);
> > +     rcu_read_lock();
> >       list_for_each_entry_rcu(laddr, address_list, list) {
> >               memcpy(info, &laddr->a, sizeof(laddr->a));
> >               memset(info + sizeof(laddr->a), 0, addrlen - sizeof(laddr=
->a));
> >               info +=3D addrlen;
>
> looks like TOCTOU issue exists here, we should check
> the boundary like this:
>
>                 if (!--addrcnt)
>                         break;
>
> Otherwise KASAN would complain about an out-of-bound write.

Or if lock_sock() is enough, we should use the plain
list_for_each_entry(), or list_for_each_entry_rcu() with
lockdep_sock_is_held() as the 4th arg.

