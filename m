Return-Path: <linux-kernel+bounces-828987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E67EB95FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6483219C37DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6719327A0A;
	Tue, 23 Sep 2025 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVDI0s9V"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A17326D4C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758633428; cv=none; b=goJxgWizX95z+9Y1GyB54pXAanzq8SbKtHSomAo/+4wKvyfqqKzeNTNcttQNQBTq2OlomNY8h1eNbCyK808K4mReD3c3gR0ZWb/44yoQcwEUmVfbNh9nAhB1F/dprQqS0ONQy9CDTLpve0P7/SLJ6SBpXo2epbZSquEhSC9xwPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758633428; c=relaxed/simple;
	bh=vLNOpzetH/Y5LAPNxv2ClxExpatuyCXuu8pR0a+rhFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1/b0+rbaUJwgcWoj26Eqs3DUb04xi6DMj6usriJYX+VYNVuH0eij6MO+GG7I9izCGlr2rJIxIvNkarebVFtiTzwOfnBPDb0Bh+UKKfcumzZjpzxPnMT/W0cNwCSX92tBnSZ8dRYzOiPU5ldxYo3xeSATmTqvzYkwFlAmuyD2GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVDI0s9V; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-746d7c469a8so4655163a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758633425; x=1759238225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2WPlGw6ip7PYA/9tuI3OZb0vgkUfUYvz/dn9O4WHM8=;
        b=MVDI0s9VR5W1ZBAo7u3H8+IS/P7Kl3XF1zwWEicTJV2eh80Q7iu51/7MTyTTVSvbX9
         oMgHvhNDAXAj/Ym+5RbNdlO5tujFzjykhUn8RQQzJ4i5lHGI/PDhMRtPY6/tR0/1m3Ps
         gnL8hpyufO/X6PO+PMxOBHd0CLktRtll+nu9sbSw2K8dnSoLzWTYhlw4hnFkZvWtqJ1p
         mmHGaDNCQ+ZZdSWMpH0U45/JvXGtzuA174ESfDd4LGCqmXiXCfcwwrw9Ya7+KsaWbGdZ
         SXRYCSKA2zLX9DN0RIsEGU8Q0otJTx5grO6kob4ldboENmpAjk5jw369l0GELidn28So
         WkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758633425; x=1759238225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2WPlGw6ip7PYA/9tuI3OZb0vgkUfUYvz/dn9O4WHM8=;
        b=S1eRgogBoq1bRWXnUxCDB4EqnH7h7o66B6U6QZyEaQnMP0pFUMSsfppwrdbSUQCXJe
         sCoD5X5o365fgIUB3yiKHs5jHhugmCmNEEGNLUk9eXFJD7k/H1HNB6F44IyInkbgzJHw
         cczLpJAG3W2zT2Y2SiKnzySKaAbC5plbHonlJMIvDPq3a5HKRQWIZAgfcr9NfkySDnmn
         5d0FaN0nh67K0wRt1POhNiXFM0J9fez31c96pAOO3UMOv8aGuW4cyyPO5haUrIn0hJH8
         tcRsNrud5B/qv5BvTTa2ZZgCbb0Dsu1NPjnJcAhFeSgBauAS0TwFm3vva+8mUHg7Xwri
         PIAw==
X-Forwarded-Encrypted: i=1; AJvYcCWNT0AIDU9niSE1qMiuAItxR9ylbMcJKwMKZ8ygLFzwwK5KYOFkpnHqas0NVEuoFzJ06iWwqj/s/B3NeFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJjkql3F6HaOX4ftE1C9wkmJQBnSnKPnkbSIepsbAWfPbnX9gx
	b0b0POpYZQWu8VeB4pz908tMdHxNkMLKYB46i0BNixob83A9bE4ElH7Hscg5oXtOElJIZhLeyIZ
	2kZXV9NNKHJgAylbD5ITDA87pVAdh/6A=
X-Gm-Gg: ASbGnct2BDphjT9qRJHK+sqLTAuT28AApnVJ47xSl+9OnAlUULLoBc4Tu2c0TfJRyDj
	SbyfkiKpNsOE91w5fnyAUv0xV53wadIimHHmgaTaZYCDL8Mp+CJifVqmuG2yh8bx8Rs/XN+hbH7
	4S3bXJbwSFSqa/RDmjt2QicFKN5cYdMQSXpCaCkHgDRhvZiklxeJiK3Mc8Jf72wfscwQRPEwK84
	xixNLD4IwKeDNyNlDA=
X-Google-Smtp-Source: AGHT+IG8OdD4UhyFmVnw+1B4Hou6a7FTFOoQAxaWAXHib0ERshZVgibiY61D/fwCONr+Awn82RcI18YLm8tvlRhZT7k=
X-Received: by 2002:a05:6808:3194:b0:43d:2dc4:9d16 with SMTP id
 5614622812f47-43f2d355ee6mr1166642b6e.9.1758633425437; Tue, 23 Sep 2025
 06:17:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822021217.1598-1-jjian.zhou@mediatek.com>
 <CAGXv+5F-L2+4PGixx7OG2+vp2yXc_2885yMzqWtkQDwhxVAPxw@mail.gmail.com>
 <CABb+yY3N2=01yKJon25_6_vmihj09H=T9pLwzdGPrqY5h=hRFQ@mail.gmail.com>
 <5789241.GXAFRqVoOG@workhorse> <CABb+yY2Ay+KqviJvOQC8X8kfzJN6-fQT04A+TCJAkLnWx+XwZg@mail.gmail.com>
 <a9dd348fd7df95ebd5ad9cc58d57b588a18ccc9d.camel@mediatek.com>
In-Reply-To: <a9dd348fd7df95ebd5ad9cc58d57b588a18ccc9d.camel@mediatek.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Tue, 23 Sep 2025 08:16:53 -0500
X-Gm-Features: AS18NWCOZv9Pv2u_322Xt4q4LUafUyRkH0j9o_POX7ZdoLtYf5wU82ru76Msenc
Message-ID: <CABb+yY2bYh70A=n9+XBBqthjngZP2D8ebFje-F9TN7K0c+fmMA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
To: =?UTF-8?B?SmppYW4gWmhvdSAo5ZGo5bu6KQ==?= <Jjian.Zhou@mediatek.com>
Cc: "nicolas.frattaroli@collabora.com" <nicolas.frattaroli@collabora.com>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "wenst@chromium.org" <wenst@chromium.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
	"robh@kernel.org" <robh@kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 2:17=E2=80=AFAM Jjian Zhou (=E5=91=A8=E5=BB=BA) <Jj=
ian.Zhou@mediatek.com> wrote:
>

> > > > > >
> > > > > > > +       void __iomem *base;
> > > > > > > +       struct device *dev;
> > > > > > > +       struct mbox_controller mbox;
> > > > > > > +       const struct mtk_vcp_mbox_cfg *cfg;
> > > > > > > +       struct mtk_ipi_info ipi_recv;
> > > > > >
> > > > > > Maybe also have "struct mbox_chan chan[1]; " so that you
> > > > > > don't have to
> > > > > > allocate one during the probe.
> > > > > > Also if you have  "struct mbox_controller mbox;" as the first
> > > > > > member,
> > > > > > you could simply typecast that to get this structure.
> > > > > > Something like "struct mpfs_mbox" in mailbox-mpfs.c
> > > > >
> > > > > I read somewhere that this way of subclassing is not
> > > > > recommended.
> > > > > Instead the base class should explicitly not be the first
> > > > > member.
> > > > > And then container_of() should be used.
> > > > >
> > > > > I don't remember where I read this though. But I think the
> > > > > explicit
> > > > > container_of() is easier for understanding the intent.
> > > > >
> > > >
> > > > And how does container_of() work ? :)
> > > > typcasting the first member to its parent is the simplest form of
> > > > container_of.
> > > >
> > > > -j
> > > >
> > > >
> > >
> > > Which is why it's completely equivalent and since code is supposed
> > > to communicate meaning to humans, container_of should be used.
> > >
> >
> > Nobody is suggesting typecasting cfg, dev or anything else.
> > Typecasting between mailbox controllers is fine and arguably easier
> > on
> > the eyes than using a container_of.
> >
> > -j
>
> OK. How about:
> struct mtk_vcp_mbox *priv =3D (struct mtk_vcp_mbox *)chan->con_priv;
>
You don't need to typecast a void *. So simply do
    struct mtk_vcp_mbox *priv =3D chan->con_priv;

