Return-Path: <linux-kernel+bounces-749443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C62FB14E77
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA644E4CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776201F956;
	Tue, 29 Jul 2025 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="llxmNNOk"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D03597C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753796234; cv=none; b=Giy9vnKV+QU4Mul3PCIH1KMzoN0IhFPvKDlCKjZQLb1Q4hwJA5i/0Ya28VIoUxzCcAkWbkM9Tt/swVu4CzwPy/mM7zMuGm8B7z+xi7lSPjVoYz/9XUrc9HJnMC/tAlNYes7+gT5b+tLvJ26gcdhxhG87MEwQRRLtn2wZ18DJ2Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753796234; c=relaxed/simple;
	bh=sfcSdiYGwUTwkGmmHcHk2dk/3fcVKPIU8HYXGnIthNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKRFyVnhgfpkNyAHcjRnlhGsuF0Pw197X3eRNwbZjWopzqzBwSN7nHE+lQsMI8bM/zrtTmwJlyx1EfhMV9+/rxiiQVyzKLviV+iBwoRKtAz/VrxVOp6LqkuFam072XWRBJxcLOH9lcqFv47gYLS/pecgEVDo7HE6VweDi1/kAkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=llxmNNOk; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ab6e66ea68so64124841cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753796231; x=1754401031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaBlyvkEiQfePUzidGqODFVZvQVFMwMEePnf1F1gAEQ=;
        b=llxmNNOktbIwTQRa2b3Zbm2M2FIrb+4z/jTwFeQvTb9EglPuBw9biJAYcF9S/PsJsD
         IUETe7khKZkrZqtF4qtBFOqCZlYwcMogeHS7Vq84L/IjFftNpmYqp/Rlwo4u+b1aGFrI
         wNqglDpv5VSZqyng83tDRl0qaX/0pCmmCFl3DGsgfb8z4FFc0GyAZaAHHxbFcWPsGlqG
         j5PWLuBOHAsRaOWrpRkz6FjK/eeKBTTB9ECJE1WONsEAs7MXEE4ZKmd4SlQOjgH9olar
         w27uCAkL4HYduoylQFfdvZ+X/tlrskLIIYsBjjzaLzLsneFxcIdQfR6AvA7e38WfQdM0
         j6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753796231; x=1754401031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaBlyvkEiQfePUzidGqODFVZvQVFMwMEePnf1F1gAEQ=;
        b=VEdp6Jok3C0tNsm2/UwFPO5vlif83IcKt0VuHXHuaYyZNqhBeHYaREV/iQdLUg98gI
         fEI8S0/VUe4WfsgnlVR9rkrbvMpeynZ8l5sASDSU1C8jKwipE/hGdZyGsvpdNS57iCTL
         BgXF9LXhkgOG3tsXDOHCCrpJfENeBpCI5NjUUY025wmqwnqhUngml+OipkJyutVi2Opf
         c5MNnqtBjexxrAQOEA08+OCe0zL8fHdxaQdbtI5jsSB5X31O76jSsEvvGgXzD80dURXP
         PTF3uUUf7kgYohJnRgy607ubr95TlDG8N6FBOAgHGLU6yeFSQzzOvCxNM80Fp+cvzrZR
         iobg==
X-Forwarded-Encrypted: i=1; AJvYcCX2u0sWk55LLLvBOcqdne/GNyMNWNYNWA4oeLSLcUtjD6pXsTpRjjyNLv5TTbFd1RvAZ9xL4TfoYDYoLN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1vBNyE+Y+z4AzojA5Mv0uAOYkzGABnG9FaEO2XEU1JzXl46sa
	r9rTW4vKlvd6HkNS/bsxbxxJsO6D56ZGQSACG+0EB4AM+m9UdtGcXElPYF6DOr/mlCOLlDb0AdM
	yN0QBP3+2gkXz6sIKr0ITBTQyH2dQIQl6J1oRUVZF
X-Gm-Gg: ASbGncvXaPCOUB31RLD2T3BexIxNQkw/LT8fvfuwtwp6zp3cNtldGdAxQurU7ohs2hl
	p6Q6jD9piRQS43ji9nIvjwSH8gc2bFdGn6XXjaND32hfDdd8Qc+uw2XwAfc2NVMiaFrMcuTDYhH
	A9oIn7E2V9IfCTg+OxjeLy5aeKww7coTrbGSmJ4VHRgYmyRgQLCLLE+GoWuZH0HgLl2RiscEqxI
	NBRIQ==
X-Google-Smtp-Source: AGHT+IEmBCAjpjcUlPp5an3KgbfGQYD4Vu16CcC4U1MeBKdshz7hQy3QLAw3BRoxZMc/zGe32ELcmpu/0mlinSkJUrA=
X-Received: by 2002:ac8:58cf:0:b0:4ab:5941:a919 with SMTP id
 d75a77b69052e-4ae8f0b4744mr217927011cf.40.1753796230132; Tue, 29 Jul 2025
 06:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729061034.3400624-1-vineeth.karumanchi@amd.com>
 <CANn89iLhSq4cq4sddOKuKkKsHGVCO7ocMiQ-16VVDyHjCixwgQ@mail.gmail.com> <4ede2cb4-76de-411d-99e4-70a29f97edca@amd.com>
In-Reply-To: <4ede2cb4-76de-411d-99e4-70a29f97edca@amd.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 29 Jul 2025 06:36:58 -0700
X-Gm-Features: Ac12FXxozvaQNQQejWHfklYBeLwt6tBZlWJoCbDxOiPv_Ih2vhhcG2CZdwTlU3U
Message-ID: <CANn89i+FkSb-SNxUu_s9RzjM1qKG4uv5KZau2hhFDEPYXo-=Nw@mail.gmail.com>
Subject: Re: [RFC PATCH net] net: taprio: Validate offload support using
 NETIF_F_HW_TC in hw_features
To: "Karumanchi, Vineeth" <vineeth@amd.com>
Cc: vineeth.karumanchi@amd.com, git@amd.com, vinicius.gomes@intel.com, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 3:41=E2=80=AFAM Karumanchi, Vineeth <vineeth@amd.co=
m> wrote:
>
> Hi Eric,
>
> On 7/29/2025 12:15 PM, Eric Dumazet wrote:
> > On Mon, Jul 28, 2025 at 11:10=E2=80=AFPM Vineeth Karumanchi
> > <vineeth.karumanchi@amd.com> wrote:
> >>
> >> The current taprio offload validation relies solely on the presence of
> >> .ndo_setup_tc, which is insufficient. Some IP versions of a driver exp=
ose
> >> .ndo_setup_tc but lack actual hardware offload support for taprio.
> >>
> >> To address this, add a check for NETIF_F_HW_TC in netdev->hw_features.
> >> This ensures that taprio offload is only enabled on devices that
> >> explicitly advertise hardware traffic control capabilities.
> >>
> >> Note: Some drivers already set NETIF_F_HW_TC alongside .ndo_setup_tc.
> >> Follow-up patches will be submitted to update remaining drivers if thi=
s
> >> approach is accepted.
> >
> > Hi Vineeth
> >
> > Could you give more details ? "Some IP versions of a driver" and "Some
> > drivers" are rather vague.
>
> At present, I=E2=80=99m only familiar with the GEM IP, which supports TSN=
 Qbv in
> its later versions. The GEM implementations found in Zynq and ZynqMP
> devices do not support TSN Qbv, whereas the updated versions integrated
> into Versal devices do offer TSN Qbv support.

Is this an out-of-tree driver ? I do not find macb_taprio_setup_replace()

I think most drivers should return -EOPNOTSUPP in this case.

>
> >
> > Also what happens without your patch ? Freeze / crash, or nothing at al=
l ?
> >
>
> Crash!
>
> root $# tc qdisc replace dev end0 parent root handle 100 taprio num_tc 2
> map 0 1 queues 1@0 1@1 base-time 500 sched-entry S 0x1 100000
> sched-entry S 0x2 50000 flags 2 cycle-time 250000
>
> [   31.667952] Internal error: synchronous external abort:
> 0000000096000210 [#1]  SMP
> [   31.675529] Modules linked in:
> [   31.678576] CPU: 0 UID: 0 PID: 660 Comm: tc Not tainted
> 6.16.0-rc6-01628-g2933e636b919-dirty #14 NONE
> [   31.687870] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
> [   31.692819] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS
> BTYPE=3D--)
> [   31.699771] pc : hw_readl_native+0x8/0x10
> [   31.703782] lr : macb_taprio_setup_replace+0x2b0/0x508
> [   31.708912] sp : ffff80008223b4f0
> [   31.712211] x29: ffff80008223b570 x28: 0000000000000040 x27:
> 000000003b9aca00
> [   31.719346] x26: 0000000000000000 x25: ffff00080b5b7048 x24:
> 00000000000003e8
> [   31.726473] x23: 0000000000000003 x22: ffff00080b5b49c0 x21:
> ffff000808727c80
> [   31.733600] x20: ffff000800150208 x19: 0000000000000000 x18:
> 020c49ba5e353f7d
> [   31.740727] x17: 0000000000000002 x16: 00000000000249f0 x15:
> 0044b82fa09b5a53
> [   31.747854] x14: 00000000ee6b27ff x13: 000000003e7fe4a7 x12:
> ffff000808727c90
> [   31.754981] x11: 0000000000000002 x10: 0000000000024be4 x9 :
> 0000000000000000
> [   31.762108] x8 : 0000000000000002 x7 : 00000000000061a8 x6 :
> 000000000000186a
> [   31.769235] x5 : 0000000000000000 x4 : 0000000000018894 x3 :
> 0000000000000000
> [   31.776362] x2 : ffff800080928d78 x1 : ffff80008190d880 x0 :
> ffff80008190d000
> [   31.783490] Call trace:
> [   31.785921]  hw_readl_native+0x8/0x10 (P)
> [   31.789922]  macb_setup_tc+0x13c/0x190
> [   31.793663]  taprio_change+0x768/0xb90
> [   31.797405]  taprio_init+0x1d0/0x280
> [   31.800973]  qdisc_create+0x114/0x40c
> [   31.804627]  tc_modify_qdisc+0x4c8/0x804
> [   31.808542]  rtnetlink_rcv_msg+0x284/0x374
> [   31.812631]  netlink_rcv_skb+0x60/0x130
> [   31.816459]  rtnetlink_rcv+0x18/0x24
> [   31.820027]  netlink_unicast+0x1e8/0x304
> [   31.823942]  netlink_sendmsg+0x168/0x3a4
> [   31.827857]  ____sys_sendmsg+0x220/0x268
> [   31.831772]  ___sys_sendmsg+0xb0/0x108
> [   31.835514]  __sys_sendmsg+0x9c/0x100
> [   31.839168]  __arm64_sys_sendmsg+0x24/0x30
> [   31.843257]  invoke_syscall+0x48/0x10c
> [   31.846999]  el0_svc_common.constprop.0+0xc0/0xe0
> [   31.851695]  do_el0_svc+0x1c/0x28
> [   31.855003]  el0_svc+0x34/0x104
> [   31.858136]  el0t_64_sync_handler+0x10c/0x138
> [   31.862485]  el0t_64_sync+0x198/0x19c
> [   31.866144] Code: 88dffc00 88dffc00 f9400000 8b21c001 (b9400020)
> [   31.872227] ---[ end trace 0000000000000000 ]---
> [   31.876836] note: tc[660] exited with irqs disabled
> Segmentation fault
>
>
> >>
> >> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> >
> > Patches targeting net branch should include a Fixes: tag.
> >
> > Thanks
> >
> >> ---
> >>   net/sched/sch_taprio.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> >> index 2b14c81a87e5..a797995bdc8d 100644
> >> --- a/net/sched/sch_taprio.c
> >> +++ b/net/sched/sch_taprio.c
> >> @@ -1506,7 +1506,7 @@ static int taprio_enable_offload(struct net_devi=
ce *dev,
> >>          struct tc_taprio_caps caps;
> >>          int tc, err =3D 0;
> >>
> >> -       if (!ops->ndo_setup_tc) {
> >> +       if (!ops->ndo_setup_tc || !(dev->hw_features & NETIF_F_HW_TC))=
 {
> >>                  NL_SET_ERR_MSG(extack,
> >>                                 "Device does not support taprio offloa=
d");
> >>                  return -EOPNOTSUPP;
> >> --
> >> 2.34.1
> >>
>
> --
> =F0=9F=99=8F vineeth
>

