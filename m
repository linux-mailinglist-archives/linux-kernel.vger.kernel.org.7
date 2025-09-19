Return-Path: <linux-kernel+bounces-825120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EF2B8B071
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887D01CC4EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98696264624;
	Fri, 19 Sep 2025 19:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="M8o8jMjC"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287201DA3D;
	Fri, 19 Sep 2025 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758308553; cv=pass; b=phSUuUWiORz0bTBA8Q7wukmtlKlByFv2jaswUJyXqSxBxscf4XMP/V9wSZwdXYybul0QCioCOeNYNANjKJLYPVTngD7yWKP0MX8dD/YLz7IkkDS53uHPphFiMIghLG5dH7u0l6fUwyAVbilsG44UqWgdWGC1Is3knz8gCNU5MOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758308553; c=relaxed/simple;
	bh=FGj22nJOTalMX7RRowLpIQi8bM6LSIKiVYEI7I+BVOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnfijtEdIsT6gQg95YWcLcsVpxuyIegi2Mke49C7rcPcEM/ZD/RD85w5B91dGln7sMZNvK5wPknSRahyPdS/hzH25VR/XYBzxHfvH0vD4Rv3EyHweXqgYY9PJdwUoY4hJQ5i7pVP5jV4vbFnhGaDRQv5ZYjUPUeTtk1jXwoUMB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=M8o8jMjC; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758308534; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cH26IUmfARHZ5DlOjLqJkt4BcKgTyMaw8aBcfi+wYGKunFM3yTMF4ZoSXy4tXORYws2aFWrJGTas51jLJrcEW7UX4gP1WKTynnTpUFJMopcqdrxcVQ4yoXgP2HFLxCqFoSRUDjQq/lrG3mq+z3jJIdMedjpjuip/G/IxYJz3WGU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758308534; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=srXz9Z4cJj2t72vaKDBPc8Jra6K2uLJkmaxWaZoZKCo=; 
	b=AlIectYeirCZSjvdAEuhH9MPsbcqsC0iGW32eA2BlNvcVVw553j/0pEA8bHrHSoPF7qw21EIHz4v3ixnI+5xW/aUll4zUh5AZ9t3l+S4Ckc9DHw1UdaszLpjmPz6JW85UpFC9m6CQiz1iZi/r5as8s9457bf4ZI6bcvo/TjFuhs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758308534;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=srXz9Z4cJj2t72vaKDBPc8Jra6K2uLJkmaxWaZoZKCo=;
	b=M8o8jMjCP5E/dushTSx4+AKMYmJ9cIaieQrGOZL/HiRUDSaIaoNwj98LIaaIcJ9G
	9tO5HU9FOEaB/8MdbnOVcW0ZjVmB1gb++8Np/meByyS/gKct1DBVmHx6GRU+qldJluV
	KPTOLE57YGY9C4/DN2g+DC4kn5ADWroyQgbEL91E=
Received: by mx.zohomail.com with SMTPS id 1758308533233746.4562667171067;
	Fri, 19 Sep 2025 12:02:13 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Chen-Yu Tsai <wenst@chromium.org>, linux-mediatek@lists.infradead.org,
 Jassi Brar <jassisinghbrar@gmail.com>
Cc: Jjian Zhou <jjian.zhou@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v5 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
Date: Fri, 19 Sep 2025 21:02:08 +0200
Message-ID: <5789241.GXAFRqVoOG@workhorse>
In-Reply-To:
 <CABb+yY3N2=01yKJon25_6_vmihj09H=T9pLwzdGPrqY5h=hRFQ@mail.gmail.com>
References:
 <20250822021217.1598-1-jjian.zhou@mediatek.com>
 <CAGXv+5F-L2+4PGixx7OG2+vp2yXc_2885yMzqWtkQDwhxVAPxw@mail.gmail.com>
 <CABb+yY3N2=01yKJon25_6_vmihj09H=T9pLwzdGPrqY5h=hRFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, 19 September 2025 18:32:12 Central European Summer Time Jassi Br=
ar wrote:
> On Fri, Sep 19, 2025 at 3:31=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org>=
 wrote:
> >
> > On Fri, Sep 19, 2025 at 7:50=E2=80=AFAM Jassi Brar <jassisinghbrar@gmai=
l.com> wrote:
> > >
> > > On Thu, Aug 21, 2025 at 9:12=E2=80=AFPM Jjian Zhou <jjian.zhou@mediat=
ek.com> wrote:
> > >
> > > .....
> > >
> > > > +#include <linux/module.h>
> > > > +#include <linux/of.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/slab.h>
> > > > +
> > > > +struct mtk_vcp_mbox_priv {
> > > Maybe 'mtk_vcp_mbox' is a more appropriate name ?
> > >
> > > > +       void __iomem *base;
> > > > +       struct device *dev;
> > > > +       struct mbox_controller mbox;
> > > > +       const struct mtk_vcp_mbox_cfg *cfg;
> > > > +       struct mtk_ipi_info ipi_recv;
> > >
> > > Maybe also have "struct mbox_chan chan[1]; " so that you don't have to
> > > allocate one during the probe.
> >
> > > Also if you have  "struct mbox_controller mbox;" as the first member,
> > > you could simply typecast that to get this structure.
> > > Something like "struct mpfs_mbox" in mailbox-mpfs.c
> >
> > I read somewhere that this way of subclassing is not recommended.
> > Instead the base class should explicitly not be the first member.
> > And then container_of() should be used.
> >
> > I don't remember where I read this though. But I think the explicit
> > container_of() is easier for understanding the intent.
> >
> And how does container_of() work ? :)
> typcasting the first member to its parent is the simplest form of contain=
er_of.
>=20
> -j
>=20
>=20

Which is why it's completely equivalent and since code is supposed
to communicate meaning to humans, container_of should be used.

"In this case if nobody ever reorders members you can avoid a
preprocessor macro that will get optimised away" is pointless
nitpicking. It's a strictly worse way to do the same thing.

Why bikeshed the use of container_of of all things?




