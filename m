Return-Path: <linux-kernel+bounces-805461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68375B488D6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96E2189150A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1AA2FCC19;
	Mon,  8 Sep 2025 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0SaDEU85"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3E12FC012
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324440; cv=none; b=d10TB1fJzlA+HS4X/1dS19wiW3lhBSpAmAr7LFnPg2kEAZ1dQ1qlok5/D6M7ChqJs9Xnm4ICluTTu5AhkjVhzUtkng1yoLk4IRXygdlmLtnZg5F3iGCFEWVWFXf97tbJxU60FdIJPGecR2cIkdObh5DAX9ikkYoHNd8LuusFaRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324440; c=relaxed/simple;
	bh=t+aVCYfXA+p0hAUl+r/idM6sMNdxYBy4dFyRlU1jIEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgNk6Yi5r2igGMcOQvXA6mJBemVfTLrgsTAE0iy3UjuPTH0XOgqRC7yXs/l0zMj3NNNki5ezgGZVuIvyAraOaP53uhuosQKzbL3OVYrX9uSMC56abLjnd+v3w6prNIW48PBrenztnwDQuI1t+DBlppVlOhxIufdP4R60oPEOf94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0SaDEU85; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b38d4de6d9so23594361cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757324437; x=1757929237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erhcBr1kcJ+JmJqrcMGs+dfvelpre/iMdOwMlOMIkIk=;
        b=0SaDEU85s4q88aFrdyk2G7gKEwzF9948jYYxxgyIKKE9GSlPhNWeup05qYWMMektm1
         BXo+OQ8XUBPGfCIGNSyLyWbVMrIwDoODXrxxYciGJb96L7dtnrdrZ8iDOfNgu/qfK49x
         KC7tM7pJkO2sHy1N9iKI80DsneDHLFcfrTc7blgncLWXMwgSgSEeZvdgTdm9nFT7WysX
         ur8nxcDKp7PH/lBzaxF/hXyZ5N0ItYxLfmILqVlecB0qwYlbU9OLccMogDJk4uSK8X0b
         yQrCjApPLOgFkZuegLSbBKq+QZwwccFUG+dyZdtlV+b3LBFkWdJYnCL1YxbpLWGy8LXa
         4b0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757324437; x=1757929237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erhcBr1kcJ+JmJqrcMGs+dfvelpre/iMdOwMlOMIkIk=;
        b=FCSRRMWD0XsEtXBTfvrGYTlPatPnTDvWD5m0GjwRxHFSAsPZ4ijML+BKqXVfZrV7wS
         +PP8QJ34Ytz8kGP8uZmlrUEAkayEYa4cXn3SAMKaPS+zKC9AmJdKwvkMQYZ/nQW4kQRd
         hzxYAlEncaVzRuLWaSNFs4Bj8Xf9QHCJh1SDnCYz/XFL8hoWL/BLm6T7NoUc6MGClwX0
         1S1Tx0oF+nsfdGV7CPjO2f7Xud+OIkXCPquw9o+HvytKzwbAw0Ie2+Ye8WoholkOPicN
         4I/RaB5M4GnmcFTklvN5vLdtl93YG7UXpN6Bz4B6VEMBv+qudu2txXM5fBLWsu6v92RP
         b8EA==
X-Forwarded-Encrypted: i=1; AJvYcCUUHU5xjl6NbPcNFW4TlQnLh2d22C8chw1MIcVdocWTl6GPjGqV9Ayiyz1bTm06c1TT35j4K+O6xdP4nco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0lo5/ycSyNo5aYoO4sHoTq1PgFX+g3EuWNeotLhwgNgt6AGPN
	RAp5gJCG9a41S18VDH4Uc889ruIImQ4HqB6JDjAebr81htrIwPx5JTzKIl10MrxflKKApUMIRN0
	kaylJIJCNor+JyGRWDHfpUDXedtkUotnl3IOuOH+G
X-Gm-Gg: ASbGncv5+u0OR8wzngnVk9mdX/PX9iEzpcIiyfTpLlkMkSfchvehATVIldtAdZWsUtJ
	hIrSa0f3hFlmler92OQMdgv1VWss0wXfA/XZYNIn7WmzsVxoU+50pZ+jBC7j8gpZhnVJxhd/Evc
	2cMs1hPF8L0zYa5u2qFuKfvGnL5b+bDXbh/Ej7Seqs0JhwKiQd12hjU0LuMOJ/LVCzvU+7o1Kbs
	FM/T4cmhVTp5XvArl8BMIpH
X-Google-Smtp-Source: AGHT+IH1qcux165XgeTJOKRdM2g9mlniLhsoO7eTSJyAbSGCi4jHXwjx9GOnwgxGTG5T20bMMEWW7o7k2xMBN/Lj20k=
X-Received: by 2002:ac8:7dd1:0:b0:4b3:96a:fda8 with SMTP id
 d75a77b69052e-4b5f834cff6mr66658841cf.17.1757324437178; Mon, 08 Sep 2025
 02:40:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68bb4160.050a0220.192772.0198.GAE@google.com> <CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQs_kZoBA@mail.gmail.com>
 <CANn89iJaY+MJPUJgtowZOPwHaf8ToNVxEyFN9U+Csw9+eB7YHg@mail.gmail.com>
 <c035df1c-abaf-9173-032f-3dd91b296101@huaweicloud.com> <CANn89iKVbTKxgO=_47TU21b6GakhnRuBk2upGviCK0Y1Q2Ar2Q@mail.gmail.com>
 <51adf9cb-619e-9646-36f0-1362828e801e@huaweicloud.com>
In-Reply-To: <51adf9cb-619e-9646-36f0-1362828e801e@huaweicloud.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Sep 2025 02:40:25 -0700
X-Gm-Features: Ac12FXwc26OpvX9zU43reFsjsweUwJNkA8yDt2oGLAvJhUo4PxXaORks-CcUgHI
Message-ID: <CANn89iLhNzYUdtuaz9+ZHvwpbsK6gGfbCWmoic+ACQBVJafBXA@mail.gmail.com>
Subject: Re: [syzbot] [net?] possible deadlock in inet_shutdown
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: syzbot <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, davem@davemloft.net, 
	dsahern@kernel.org, horms@kernel.org, kuba@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.lei@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, thomas.hellstrom@linux.intel.com, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 2:34=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> Hi,
>
> =E5=9C=A8 2025/09/08 17:07, Eric Dumazet =E5=86=99=E9=81=93:
> > On Mon, Sep 8, 2025 at 1:52=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com=
> wrote:
> >>
> >> Hi,
> >>
> >> =E5=9C=A8 2025/09/06 17:16, Eric Dumazet =E5=86=99=E9=81=93:
> >>> On Fri, Sep 5, 2025 at 1:03=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> >>>>
> >>>> On Fri, Sep 5, 2025 at 1:00=E2=80=AFPM syzbot
> >>>> <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com> wrote:
> >>>
> >>> Note to NBD maintainers : I held about  20 syzbot reports all pointin=
g
> >>> to NBD accepting various sockets, I  can release them if needed, if y=
ou prefer
> >>> to triage them.
> >>>
> >> I'm not NBD maintainer, just trying to understand the deadlock first.
> >>
> >> Is this deadlock only possible for some sepecific socket types? Take
> >> a look at the report here:
> >>
> >> Usually issue IO will require the order:
> >>
> >> q_usage_counter -> cmd lock -> tx lock -> sk lock
> >>
> >
> > I have not seen the deadlock being reported with normal TCP sockets.
> >
> > NBD sets sk->sk_allocation to  GFP_NOIO | __GFP_MEMALLOC;
> > from __sock_xmit(), and TCP seems to respect this.
> > .
> >
>
> What aboud iscsi and nvme-tcp? and probably other drivers, where
> sk_allocation is GFP_ATOMIC, do they have similar problem?
>

AFAIK after this fix, iscsi was fine.

commit f4f82c52a0ead5ab363d207d06f81b967d09ffb8
Author: Eric Dumazet <edumazet@google.com>
Date:   Fri Sep 15 17:11:11 2023 +0000

    scsi: iscsi_tcp: restrict to TCP sockets

    Nothing prevents iscsi_sw_tcp_conn_bind() to receive file descriptor
    pointing to non TCP socket (af_unix for example).

    Return -EINVAL if this is attempted, instead of crashing the kernel.

    Fixes: 7ba247138907 ("[SCSI] open-iscsi/linux-iscsi-5 Initiator:
Initiator code")
    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Cc: Lee Duncan <lduncan@suse.com>
    Cc: Chris Leech <cleech@redhat.com>
    Cc: Mike Christie <michael.christie@oracle.com>
    Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
    Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
    Cc: open-iscsi@googlegroups.com
    Cc: linux-scsi@vger.kernel.org
    Reviewed-by: Mike Christie <michael.christie@oracle.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

