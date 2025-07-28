Return-Path: <linux-kernel+bounces-748369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BCDB1404E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6DA17DE46
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286F3274B53;
	Mon, 28 Jul 2025 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJ9SZP32"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007C22749E7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753720212; cv=none; b=Qy2SfkTny/m2Wg4ezf3Z3VLeXx8i4D0zvQXY/CHG2+sIGrKge4pw/xauawcK/pdgLgVAEWYuxcJlYb1tfgQXX/T0MoyqilcoFMI6FD9WLqJNlKl6K/65nLVlZ2tfZTw2rliuhVE8ThAKaKwC3nbBt1dIr9rDEgtYDQi3M55JDas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753720212; c=relaxed/simple;
	bh=gxu376Wxo9Y80Esr75RMD2IOGKqRMPhPnvj/gxqJYDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCx8SbroSIbHD/S7IwhZDA2HZGfM4srhYPlmsUUtqKXfoq8hzLR+7hhhgYW09V5EBAhDx9HzIa1wjYOARdTiw6CzlOm2LFMz7o9ucXR92Q+ZWbfOHT02K5Zyav7hFByaFMsUUbjJnnp5ARIx1z85GB/Euo5+SJCQeb4rph0u5M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hJ9SZP32; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b3bdab4bf19so3935568a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753720210; x=1754325010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AA96Pn3IqJIuTrEVGzxm5x2ZwPalkRlNNPo73obM1w=;
        b=hJ9SZP32edUXtOodyb84Ad+o+iwJMoEB7uha3K7gpbTea/heG4y1JH6aCDHFyz8F49
         7puP/c/8xC/Hx4EPVgkgwDeL3Z7fa9fFTdPTfuiV+iJZK4uGKxCq78WXikoQL5D8FTpi
         l37Ymtlcs4u1UhLH14WYI+HixGAoSUc1T8QUye5pRsdasJLRYSKL1jIc8QicWtGgIlFN
         hURwNiFxu8CNQNCw958L4woSGtLRLkxo7l+3vLuY9WZY24I4bB9EbWjg9xzByixX6ffZ
         FQYJUmUIVXJQ1Dkb0Fk5iPWti8VGCVF6Rz7S7hUqSb36by9k8hy7nT4iqDp6v9d67vAz
         oLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753720210; x=1754325010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AA96Pn3IqJIuTrEVGzxm5x2ZwPalkRlNNPo73obM1w=;
        b=i5GhQZhNV42jxUWDDs+YG9wO/NA2PZTNJksknNZN9P6m+BXRxjRbqkTvypMaK1ehur
         NWoMKeRQD8OdnnPJ3qhe+rb8jJbhgR/7URUb1T3ydzH+riCyYzvNmRqCSTt9nx+1gE7K
         mGktbiYWotBQOaFHNgQiWMMTXS0OdYkWSS/jsQgd6IyVQe7HCLF5cbef2N1kicO10ss5
         sGPN/8DpWGDLV3pHFNu5n+m+E9HAxsykpeQCjJ3JSFt2zVMiZWGCpYgM+Eca6N+z4LeK
         QZEHBy9hi4uptMc3HdHdUvTvdMmJXMJdKBNFnv6djUowPvK6Eytld64Bk36ABclICFxK
         PKLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0lntyBLgSxtWzv5+Wyqu763fz8UIGgAQBgAJHpJglRxNPHNC3ejISNq15JgmQPMfetr13MwUdSd5qHcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFT7LPnChkUCjgqEUNRWR+deag4zMonciW32Y6mZqK08J3vVce
	TS82WChxWzDuApVEehi5jm2+0IXG5U5Pu7NXh8biupObGbK02aLI3yAZ5Tz5rgTRLjzTkRhLCkp
	MEVmBZeu/+hs2GNB0nHyvAUQIjPVFC4VOF3C6eJeu
X-Gm-Gg: ASbGncsrhKPViKxBq+Qp8pQyAIy8nxd5CHmrUnioum/Tde6tJ12Bv0GN8iM5uWRcPmY
	7bxsyoChTR7ol2l/FrfQenwx4wI/3n/UjGdDO3SgFMz2ptSL5m7+FmRuTqVWM2HmGj1Q7BrQEu8
	g4zEfYnMFPeabUJvcRZskqoQ6rwSsiBENqGdlsGtbpllBSOEP198AgcggLAQvnCgMaZBTqXwbO2
	Q9mOUoWDs+f6BtUD6ABLSaEbuRyV/mE84JdnNo=
X-Google-Smtp-Source: AGHT+IEkJwssPX4tHVGEszb8AGnANM8DWuZOTbj3U0xaqvuDMSsFTzXqcnKCF9fxVrrWEUaACWfrmUWlKIIaT8VJUC0=
X-Received: by 2002:a17:90b:4a88:b0:312:e6f1:c05d with SMTP id
 98e67ed59e1d1-31e77a18701mr18134069a91.2.1753720209760; Mon, 28 Jul 2025
 09:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728080727.255138-1-pchelkin@ispras.ru>
In-Reply-To: <20250728080727.255138-1-pchelkin@ispras.ru>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 28 Jul 2025 09:29:58 -0700
X-Gm-Features: Ac12FXyaE83SFy377tIzRlcvS6Sm_sgAJSkqWb-qnNMJgp-9TyQ9im1WytdeRLM
Message-ID: <CAAVpQUA8cN3-+sK4eUPknHHkepyTjb_vDWJA6PPXkz8=+Q7UoA@mail.gmail.com>
Subject: Re: [PATCH net] netlink: avoid infinite retry looping in netlink_unicast()
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 1:07=E2=80=AFAM Fedor Pchelkin <pchelkin@ispras.ru>=
 wrote:
>
> netlink_attachskb() checks for the socket's read memory allocation
> constraints. Firstly, it has:
>
>   rmem < READ_ONCE(sk->sk_rcvbuf)
>
> to check if the just increased rmem value fits into the socket's receive
> buffer. If not, it proceeds and tries to wait for the memory under:
>
>   rmem + skb->truesize > READ_ONCE(sk->sk_rcvbuf)
>
> The checks don't cover the case when skb->truesize + sk->sk_rmem_alloc is
> equal to sk->sk_rcvbuf. Thus the function neither successfully accepts
> these conditions, nor manages to reschedule the task - and is called in
> retry loop for indefinite time which is caught as:
>
>   rcu: INFO: rcu_sched self-detected stall on CPU
>   rcu:     0-....: (25999 ticks this GP) idle=3Def2/1/0x4000000000000000 =
softirq=3D262269/262269 fqs=3D6212
>   (t=3D26000 jiffies g=3D230833 q=3D259957)
>   NMI backtrace for cpu 0
>   CPU: 0 PID: 22 Comm: kauditd Not tainted 5.10.240 #68
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-4.fc=
42 04/01/2014
>   Call Trace:
>   <IRQ>
>   dump_stack lib/dump_stack.c:120
>   nmi_cpu_backtrace.cold lib/nmi_backtrace.c:105
>   nmi_trigger_cpumask_backtrace lib/nmi_backtrace.c:62
>   rcu_dump_cpu_stacks kernel/rcu/tree_stall.h:335
>   rcu_sched_clock_irq.cold kernel/rcu/tree.c:2590
>   update_process_times kernel/time/timer.c:1953
>   tick_sched_handle kernel/time/tick-sched.c:227
>   tick_sched_timer kernel/time/tick-sched.c:1399
>   __hrtimer_run_queues kernel/time/hrtimer.c:1652
>   hrtimer_interrupt kernel/time/hrtimer.c:1717
>   __sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1113
>   asm_call_irq_on_stack arch/x86/entry/entry_64.S:808
>   </IRQ>
>
>   netlink_attachskb net/netlink/af_netlink.c:1234
>   netlink_unicast net/netlink/af_netlink.c:1349
>   kauditd_send_queue kernel/audit.c:776
>   kauditd_thread kernel/audit.c:897
>   kthread kernel/kthread.c:328
>   ret_from_fork arch/x86/entry/entry_64.S:304
>
> Restore the original behavior of the check which commit in Fixes
> accidentally missed when restructuring the code.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Fixes: ae8f160e7eb2 ("netlink: Fix wraparounds of sk->sk_rmem_alloc.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>
> Similar rmem and sk->sk_rcvbuf comparing pattern in
> netlink_broadcast_deliver() accepts these values being equal, while
> the netlink_dump() case does not - but it goes all the way down to
> f9c2288837ba ("netlink: implement memory mapped recvmsg()") and looks
> like an irrelevant issue without any real consequences. Though might be
> cleaned up if needed.

This should be fixed in a separate patch.  It's weird that one path
accepts a value =3D=3D SO_RCVBUF but the other path doesn't.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!

>
> Updated sk->sk_rmem_alloc vs sk->sk_rcvbuf checks throughout the kernel
> diverse in treating the corner case of them being equal.
>
>  net/netlink/af_netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 6332a0e06596..0fc3f045fb65 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -1218,7 +1218,7 @@ int netlink_attachskb(struct sock *sk, struct sk_bu=
ff *skb,
>         nlk =3D nlk_sk(sk);
>         rmem =3D atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
>
> -       if ((rmem =3D=3D skb->truesize || rmem < READ_ONCE(sk->sk_rcvbuf)=
) &&
> +       if ((rmem =3D=3D skb->truesize || rmem <=3D READ_ONCE(sk->sk_rcvb=
uf)) &&
>             !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
>                 netlink_skb_set_owner_r(skb, sk);
>                 return 0;
> --
> 2.50.1
>

