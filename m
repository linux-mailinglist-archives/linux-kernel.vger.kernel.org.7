Return-Path: <linux-kernel+bounces-615254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E13EEA97ACD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 01:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47F63BDE6C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 23:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED782D0293;
	Tue, 22 Apr 2025 23:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vSTPJmDW"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF881F1513
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 23:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745362857; cv=none; b=iZV4EgSPU/rSEtvFLVJcRB4t+DX0ahYD/YTCq/op5AESyZ+CQp72n3s1hu897fT/yiurS1I+o2BtyEqiXqdOvVdpwIQ9ehjla207IOY6lU2K9f209ydbcgmvAQK5yRcH8FR0Zb8tWK7kRNKpZF4qRHFzGF3ec7fXUDojxjxElvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745362857; c=relaxed/simple;
	bh=vA0x1LF+TTujtzA/a9qIyOuUZvc6uTpZ8L2xS4rCm/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cwf0tqmh07u3m37G0SXs1tRvDGIlgjGBSu7ci0HqLUv+xGDGqOxqcKb+qqQvNRWup6p0FatSs8FYuJuk+3LtH0YxJ8Ikst95wrCpoT0Q7sx4lsuBR0nWF9TnhtnQumEmixI0xHbZbEvaZEQyMdZsebqTzy4mJtqZtlQm7EOkFx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vSTPJmDW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2240aad70f2so102465ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 16:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745362854; x=1745967654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0wkS+mYcttDoYH2cbzpbLqiayCSdu0EeV0O89OnxB4=;
        b=vSTPJmDW/0RBiNQ+pXo+/ZFUu9NXOW/mYR/LTeXX0PDtkS2kzlnEhrDftAorprnLh9
         B/ocgO6V4ijHaBDVDYg9jL9VOb/JTTXw0+6S+4tY7MtwRoZ5UvWVUsbIXQaus6pT7WIM
         w9JyPlBFdKdDqkaPdhGNJyHXBD3R1sPHkcrer5Y+IzcoOu9zjO12veodho3lesqRnqS/
         ZAStMrBVqSDj4W5etdANq85mg8kvu8N2Yyfeq9+o7t2dSSKpzsDi4P2t4oGQC/1IFwHS
         Bak+lxuGPw4pkmdTAXPNdW6jRVAwnpbPvESvT2YSRlvhPL7TLc7E1y0fQt/+j6nPSPYZ
         Y8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745362854; x=1745967654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0wkS+mYcttDoYH2cbzpbLqiayCSdu0EeV0O89OnxB4=;
        b=WsxuWtpU5Lxd9M7ni4WUAnz+6JxqGvo95gA7tfCAK8QXR9IkTlL+zsmKtj33d8dNXV
         9guJcBXJPdxToeM/+iWru7x2qzDWnVi/UcuEQA7X/VucwUqzjaPWYM6OjUxGDtRpSJoH
         xtgv+Vyxgw6virtLRgmM+fZeFqSQnQsrQEM5O5twvYdWSgYPLwA8EUSF5ntUKED71704
         2d4BSxUEbIJYYaoQN3m1AaeN+ko8QGfuK/UPv8KvVJSZDeN/HzXoamVPTHf/ixexVH4N
         jQrmGSHZ/vxi8ofq1aOWAsQNUyB/rk0b43CPgTXALOUNHtZ0qocXm22QXS/l56g/SrSC
         EYAw==
X-Forwarded-Encrypted: i=1; AJvYcCWbd2d1105IpQBb2/WGqjFpDvwxOOfa0mKEASgOk26bEsFbqgqIgQAr+UuhwvmeUQcRzSb3Owrx5d7lkaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS8X6nayUZ3NTfO7tuMRe3bVXeE2lYNs/nIrsudo/Ic6Qa9vaq
	VhZ5D/c459x6ZK9wXPVBBRVZ7Dp5F1+VYVm1xZP+AMDcZ8ob701NzpH3pl4zt8JmfGLITimkgVQ
	zKaEB/fxMshBPDaduEGJfVQ2Mm/QvQriM+4nA
X-Gm-Gg: ASbGncvjQ/hfrSFFKHk7OQyAgm4J5Vef4ZUzQRKGBC6wYgOAp4vyRo5YXj9c+o9DPuK
	AiRtzstPXV1fnBrxFetWxOzhpS5A7P3kRiR3fUu9lYZtYd8aIn1VT4gnrtOASc9V9LmgBv6fFCl
	k0fxy2JCT8d4spUweV3eri9lR1DOFKazFwZgFWpYyWuIA2eAfazRfp1JULpbnEtMA=
X-Google-Smtp-Source: AGHT+IFcA8eNct2OIuHlbOvxzm3T6NVzaOSOXt3ivEIqSJ8wke0kgYVfmjCEtUHN4nE+IsPWRgGhH+7fhESmeCiNRMo=
X-Received: by 2002:a17:902:ef07:b0:215:86bf:7e46 with SMTP id
 d9443c01a7336-22da4ebcff9mr256305ad.7.1745362853731; Tue, 22 Apr 2025
 16:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417231540.2780723-1-almasrymina@google.com>
 <20250417231540.2780723-8-almasrymina@google.com> <CAEAWyHckGSYEMDqVDT0u7pFCpO9fmXpEDb7-YV87pu+R+ytxOw@mail.gmail.com>
 <CAHS8izNZXmG0bi15DpmX2EcococF2swM83Urk19aQBvz=z3nUQ@mail.gmail.com>
In-Reply-To: <CAHS8izNZXmG0bi15DpmX2EcococF2swM83Urk19aQBvz=z3nUQ@mail.gmail.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Tue, 22 Apr 2025 16:00:42 -0700
X-Gm-Features: ATxdqUGxkrayoAGMPm_qgEhKu-sQHz14vjXf4E7ZJdbEqvqiDvu9MHtNVHd91NA
Message-ID: <CAEAWyHf7Qzi8CDBeRMB5nMvvNawrFrUCh52k4JevbSHX1Y=zcw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 7/9] gve: add netmem TX support to GVE DQO-RDA mode
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 2:30=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Tue, Apr 22, 2025 at 10:43=E2=80=AFAM Harshitha Ramamurthy
> <hramamurthy@google.com> wrote:
> >
> > On Thu, Apr 17, 2025 at 4:15=E2=80=AFPM Mina Almasry <almasrymina@googl=
e.com> wrote:
> > >
> > > Use netmem_dma_*() helpers in gve_tx_dqo.c DQO-RDA paths to
> > > enable netmem TX support in that mode.
> > >
> > > Declare support for netmem TX in GVE DQO-RDA mode.
> > >
> > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > >
> > > ---
> > >
> > > v4:
> > > - New patch
> > > ---
> > >  drivers/net/ethernet/google/gve/gve_main.c   | 4 ++++
> > >  drivers/net/ethernet/google/gve/gve_tx_dqo.c | 8 +++++---
> > >  2 files changed, 9 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net=
/ethernet/google/gve/gve_main.c
> > > index 8aaac9101377..430314225d4d 100644
> > > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > > @@ -2665,6 +2665,10 @@ static int gve_probe(struct pci_dev *pdev, con=
st struct pci_device_id *ent)
> > >
> > >         dev_info(&pdev->dev, "GVE version %s\n", gve_version_str);
> > >         dev_info(&pdev->dev, "GVE queue format %d\n", (int)priv->queu=
e_format);
> > > +
> > > +       if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
> > > +               dev->netmem_tx =3D true;
> > > +
> >
> > a nit: but it would fit in better and be more uniform if this is set
> > earlier in the function where other features are set for the
> > net_device.
> >
>
> Thanks for taking a look. I actually thought about that while trying
> to implement this, but AFAIU (correct if wrong), gve_is_gqi and
> gve_is_qpl need priv to be initialized, so this feature set must be
> performed after gve_init_priv in this function. I suppose this feature
> checking maybe can be put before register_netdev. Do you prefer that?

Ah yes, you are right. Thanks for checking. That would be preferable.
Another option is to move it inside gve_init_priv() after the mode has
been set. Either is okay.

Thanks,
Harshitha
>
>
> --
> Thanks,
> Mina

