Return-Path: <linux-kernel+bounces-827263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4F4B914EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35F116487A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD90530AADA;
	Mon, 22 Sep 2025 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="PyjI5q/M"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB5930AACB;
	Mon, 22 Sep 2025 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546640; cv=pass; b=M/i69T9Jy9uf5jVKM9ezRaVQX8D66SBjawURBSM0vWGM+tlEcqQi+BQG0zPEYVB/JQKDhzw7VIgbi4CXOiXmaRkihyZpj4+amJRWnr+w6DlOytTeAIdqcHFmFnU0jEmxrK5RS0UcWfbGVs9vDK7/YR9AnBV/4LVCGjhbEEdoVBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546640; c=relaxed/simple;
	bh=//yfs7CZR6mj+VX03SfgIJ1WHLmNxfSQ4EnPJSfbpT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfPo153D1HGj0Ar8/TkowIDcX7IsosdBO5YnC3SVtIxGUF3TnHMOO+rNn/1+7bz5YKt0syeh4DZuRgqDhVTBBHN4a+p4dHBjAmSHbV29TSNb3mfjxNlaWkvQ68vq3H7luOOGlBNxR2kZ1yWYfMnEp+SwWdlZS2F2JxqTRcVzVzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=PyjI5q/M; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758546626; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LvrqHWBhrF/YJolT/DD+kCk+6/r3fLveOufwCo5/PU0J1Kp9OzWNO8UqzMId+yXKP8/q+M0a6yPFXkkRqFAUmbTFgp+OX+ZMs2AXTKuebWEwoOmpKHOXI6AT1DiBZTr1t4i5h/AC54pQBVN07KuVAbftvZcBEA4siuuGhq08RzQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758546626; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Kn150si6R35actdtONn846LazO4pqKgYJ4TtgIXnRzo=; 
	b=kkGKSrMvIhdjki/asDlA1izrtZPael5VZlCYxS3jLtS84N9ub6r4qIqRHoeAUg1sE/orVmw+vldZYWQFnambdPMlJSPpxmqsLfHh+ZvjPIu78scfrx5NMaamv4DRf/GPzPwK7eylolelYH2Hi5OXRFgMiG4Y8uLy8jEqROMaLXY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758546626;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=Kn150si6R35actdtONn846LazO4pqKgYJ4TtgIXnRzo=;
	b=PyjI5q/MF4VrsT7U6GDclIWy2TAyGGYq67BUikk1yt0Hr8M3jKj2CpKcsNJ8esO4
	r5LfN3WrvnJ92NrJiHst2FVeRa+StG8hD7IGlHSQwmGSAphEW+Z5fKOelFVH0HbwDZz
	G684j1eh8KRJJlfr1cp96CVZRnT/C6bPBQkWVg5E=
Received: by mx.zohomail.com with SMTPS id 1758546623493843.2136614730568;
	Mon, 22 Sep 2025 06:10:23 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
 Jjian Zhou =?UTF-8?B?KOWRqOW7uik=?= <Jjian.Zhou@mediatek.com>
Cc: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "wenst@chromium.org" <wenst@chromium.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
Date: Mon, 22 Sep 2025 15:10:18 +0200
Message-ID: <13850137.uLZWGnKmhe@workhorse>
In-Reply-To: <a9dd348fd7df95ebd5ad9cc58d57b588a18ccc9d.camel@mediatek.com>
References:
 <20250822021217.1598-1-jjian.zhou@mediatek.com>
 <CABb+yY2Ay+KqviJvOQC8X8kfzJN6-fQT04A+TCJAkLnWx+XwZg@mail.gmail.com>
 <a9dd348fd7df95ebd5ad9cc58d57b588a18ccc9d.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, 22 September 2025 09:17:27 Central European Summer Time Jjian Zh=
ou (=E5=91=A8=E5=BB=BA) wrote:
> On Sat, 2025-09-20 at 23:02 -0500, Jassi Brar wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >=20
> >=20
> > On Fri, Sep 19, 2025 at 2:02=E2=80=AFPM Nicolas Frattaroli
> > <nicolas.frattaroli@collabora.com> wrote:
> > >=20
> > > On Friday, 19 September 2025 18:32:12 Central European Summer Time
> > > Jassi Brar wrote:
> > > > On Fri, Sep 19, 2025 at 3:31=E2=80=AFAM Chen-Yu Tsai <wenst@chromiu=
m.org>
> > > > wrote:
> > > > >=20
> > > > > On Fri, Sep 19, 2025 at 7:50=E2=80=AFAM Jassi Brar <
> > > > > jassisinghbrar@gmail.com> wrote:
> > > > > >=20
> > > > > > On Thu, Aug 21, 2025 at 9:12=E2=80=AFPM Jjian Zhou <
> > > > > > jjian.zhou@mediatek.com> wrote:
> > > > > >=20
> > > > > > .....
> > > > > >=20
> > > > > > > +#include <linux/module.h>
> > > > > > > +#include <linux/of.h>
> > > > > > > +#include <linux/platform_device.h>
> > > > > > > +#include <linux/slab.h>
> > > > > > > +
> > > > > > > +struct mtk_vcp_mbox_priv {
> > > > > >=20
> > > > > > Maybe 'mtk_vcp_mbox' is a more appropriate name ?
> > > > > >=20
> > > > > > > +       void __iomem *base;
> > > > > > > +       struct device *dev;
> > > > > > > +       struct mbox_controller mbox;
> > > > > > > +       const struct mtk_vcp_mbox_cfg *cfg;
> > > > > > > +       struct mtk_ipi_info ipi_recv;
> > > > > >=20
> > > > > > Maybe also have "struct mbox_chan chan[1]; " so that you
> > > > > > don't have to
> > > > > > allocate one during the probe.
> > > > > > Also if you have  "struct mbox_controller mbox;" as the first
> > > > > > member,
> > > > > > you could simply typecast that to get this structure.
> > > > > > Something like "struct mpfs_mbox" in mailbox-mpfs.c
> > > > >=20
> > > > > I read somewhere that this way of subclassing is not
> > > > > recommended.
> > > > > Instead the base class should explicitly not be the first
> > > > > member.
> > > > > And then container_of() should be used.
> > > > >=20
> > > > > I don't remember where I read this though. But I think the
> > > > > explicit
> > > > > container_of() is easier for understanding the intent.
> > > > >=20
> > > >=20
> > > > And how does container_of() work ? :)
> > > > typcasting the first member to its parent is the simplest form of
> > > > container_of.
> > > >=20
> > > > -j
> > > >=20
> > > >=20
> > >=20
> > > Which is why it's completely equivalent and since code is supposed
> > > to communicate meaning to humans, container_of should be used.
> > >=20
> >=20
> > Nobody is suggesting typecasting cfg, dev or anything else.
> > Typecasting between mailbox controllers is fine and arguably easier
> > on
> > the eyes than using a container_of.
> >=20
> > -j
>=20
> OK. How about:
> struct mtk_vcp_mbox *priv =3D (struct mtk_vcp_mbox *)chan-
> >con_priv;
>=20
> Thanks.
>=20

An explicit cast would be worse, as at that point you're telling
C to completely ignore any semblance of a type system it has.




