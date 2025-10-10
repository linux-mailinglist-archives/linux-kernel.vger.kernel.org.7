Return-Path: <linux-kernel+bounces-848732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF16ABCE72D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C78407D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD17302148;
	Fri, 10 Oct 2025 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Sf6HS2NB"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2822EFD90;
	Fri, 10 Oct 2025 20:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760126884; cv=pass; b=I2wrgk1l+3RfWKpR3sjMN7l5+RM/ej7BDgOskzmLejttJpEeW6n8Xai4IGj0dS1RqyCWgoxpkxaqE3GeNmGy4quobS7+3NzdZ1NGsdDdW7JPVrZMWPNtSyOzmom2RqwNl73LOTD70m/QGxwiQlOJ4gV6aidehyEBpaWi3pcbORI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760126884; c=relaxed/simple;
	bh=df+NHXoVzp6wAu4DdS1ujOHkGrPCGok+YiBTBJ3rAlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3OI+4kfBSMt13yRRu9SmEVc6cQ2WyGcK5T1FNke2A73waxh0QqyTbMxB7PYl1ITEshiEEuMctgsFqqaOBfpsY51N1DsrpHvnnsWtEbySbO+b+g3cZ5hvf0mUXTNrezi+esMBzI7s+kaA22BbzqsPGNlhSKxeODQxnVLRedKb4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Sf6HS2NB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760126800; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SpABhvblEL9SdXRaLVtJzpg/g+mDC82aoNkraQ7Z+Y8LQsyZrQAYPV6LVqzhRAQxzSuQU9XkLjTrSWn5usoMp92v+6tPwUK4i+4lFNsHuz5FTw5ZbBkZLOZAQpKNZ86FuI9IT6x9ymu01IDrfTTNTWSQJU7Zs6nvdCCjJmqZhnw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760126800; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bDSQ9VvVld/VLomgjuC14NZl74tMino0lN1j5l3p66M=; 
	b=KrhKsxCzb19qNPbEgxGzv1cUlRuxv4jPP6fUkcy96k3U/H1ty/c77w9O4D7jB/P4zairottDMEXlAtWZtjlPZq9ptDPSB5s6ESJhuEgxpBUCw5sowTWF7AQcKdobyqcc9toow11qHViZIf9iiVbO61YsiUmHFBe0Ume0MxfsB08=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760126800;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=bDSQ9VvVld/VLomgjuC14NZl74tMino0lN1j5l3p66M=;
	b=Sf6HS2NBxwKoKc+RN5h7N7IJ5YqNKtmEoDvDMRNmynmx/q0MB5bPx1Yp68OhFTQo
	UBlkzKzanMpTy+uGvHucs47paIfrqKbwEgrV56wi7ok4IeHZDWT15Y06bF/DD4xy9uO
	Mr5KpHB2pGGqJ4SC12w3EcUAdmir6ClP3UecLRWg=
Received: by mx.zohomail.com with SMTPS id 1760126798226932.2245475821575;
	Fri, 10 Oct 2025 13:06:38 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Dong Aisheng <aisheng.dong@nxp.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Yassine Oudjana <y.oudjana@protonmail.com>,
 Laura Nao <laura.nao@collabora.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, kernel@collabora.com,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject:
 Re: [PATCH v2 4/5] clk: mediatek: Refactor pllfh registration to pass device
Date: Fri, 10 Oct 2025 22:06:31 +0200
Message-ID: <13720474.O9o76ZdvQC@workhorse>
In-Reply-To:
 <CAGXv+5Hpndq09cbudofSvkNE6w+tHb85VCqDb3P920S8vwonHQ@mail.gmail.com>
References:
 <20251008-mtk-pll-rpm-v2-0-170ed0698560@collabora.com>
 <20251008-mtk-pll-rpm-v2-4-170ed0698560@collabora.com>
 <CAGXv+5Hpndq09cbudofSvkNE6w+tHb85VCqDb3P920S8vwonHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, 9 October 2025 09:33:22 Central European Summer Time Chen-Yu T=
sai wrote:
> On Thu, Oct 9, 2025 at 12:06=E2=80=AFAM Nicolas Frattaroli
> <nicolas.frattaroli@collabora.com> wrote:
> >
> > After refactoring all of PLL to pass the device, it's now fairly easy to
> > refactor pllfh and its users, as pllfh registration wraps PLL
> > registration.
> >
> > Do this refactor and move all of the pllfh users to pass the device as
> > well.
> >
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  drivers/clk/mediatek/clk-mt6795-apmixedsys.c |  2 +-
> >  drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 14 +++++++-------
> >  drivers/clk/mediatek/clk-mt8186-apmixedsys.c |  2 +-
> >  drivers/clk/mediatek/clk-mt8192-apmixedsys.c |  2 +-
> >  drivers/clk/mediatek/clk-mt8195-apmixedsys.c |  2 +-
> >  drivers/clk/mediatek/clk-pllfh.c             | 13 ++++++++-----
> >  drivers/clk/mediatek/clk-pllfh.h             |  2 +-
> >  7 files changed, 20 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c b/drivers/clk=
/mediatek/clk-mt6795-apmixedsys.c
> > index 91665d7f125efde4941cc4de881c5b503a935529..123d5d7fea8554676364dc5=
6f5c023e43325d516 100644
> > --- a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
> > +++ b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
> > @@ -152,7 +152,7 @@ static int clk_mt6795_apmixed_probe(struct platform=
_device *pdev)
> >                 return -ENOMEM;
> >
> >         fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
> > -       ret =3D mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
> > +       ret =3D mtk_clk_register_pllfhs(dev, plls, ARRAY_SIZE(plls),
> >                                       pllfhs, ARRAY_SIZE(pllfhs), clk_d=
ata);
> >         if (ret)
> >                 goto free_clk_data;
> > diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk=
/mediatek/clk-mt8173-apmixedsys.c
> > index 95385bb67d5511eda3a851f81986e67eaf81e5fb..d7d416172ab35bc027ae67c=
163c1dc20dee857b6 100644
> > --- a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
> > +++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
> > @@ -140,13 +140,13 @@ MODULE_DEVICE_TABLE(of, of_match_clk_mt8173_apmix=
ed);
> >  static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
> >  {
> >         const u8 *fhctl_node =3D "mediatek,mt8173-fhctl";
> > -       struct device_node *node =3D pdev->dev.of_node;
> >         struct clk_hw_onecell_data *clk_data;
> > +       struct device *dev =3D &pdev->dev;
> >         void __iomem *base;
> >         struct clk_hw *hw;
> >         int r;
> >
> > -       base =3D of_iomap(node, 0);
> > +       base =3D of_iomap(dev->of_node, 0);
> >         if (!base)
> >                 return -ENOMEM;
> >
> > @@ -157,25 +157,25 @@ static int clk_mt8173_apmixed_probe(struct platfo=
rm_device *pdev)
> >         }
> >
> >         fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
> > -       r =3D mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
> > -                                   pllfhs, ARRAY_SIZE(pllfhs), clk_dat=
a);
> > +       r =3D mtk_clk_register_pllfhs(dev, plls, ARRAY_SIZE(plls), pllf=
hs,
> > +                                   ARRAY_SIZE(pllfhs), clk_data);
> >         if (r)
> >                 goto free_clk_data;
> >
> >         hw =3D mtk_clk_register_ref2usb_tx("ref2usb_tx", "clk26m", base=
 + REGOFF_REF2USB);
> >         if (IS_ERR(hw)) {
> >                 r =3D PTR_ERR(hw);
> > -               dev_err(&pdev->dev, "Failed to register ref2usb_tx: %d\=
n", r);
> > +               dev_err(dev, "Failed to register ref2usb_tx: %d\n", r);
> >                 goto unregister_plls;
> >         }
> >         clk_data->hws[CLK_APMIXED_REF2USB_TX] =3D hw;
> >
> > -       hw =3D devm_clk_hw_register_divider(&pdev->dev, "hdmi_ref", "tv=
dpll_594m", 0,
> > +       hw =3D devm_clk_hw_register_divider(dev, "hdmi_ref", "tvdpll_59=
4m", 0,
> >                                           base + REGOFF_HDMI_REF, 16, 3,
> >                                           CLK_DIVIDER_POWER_OF_TWO, NUL=
L);
> >         clk_data->hws[CLK_APMIXED_HDMI_REF] =3D hw;
> >
> > -       r =3D of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_d=
ata);
> > +       r =3D of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_ge=
t, clk_data);
> >         if (r)
> >                 goto unregister_ref2usb;
> >
> > diff --git a/drivers/clk/mediatek/clk-mt8186-apmixedsys.c b/drivers/clk=
/mediatek/clk-mt8186-apmixedsys.c
> > index 4b2b16578232d986f78deed4778c5fab7f460184..d35dd2632e43ab535b32b8b=
99f8d75de02d56fe2 100644
> > --- a/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
> > +++ b/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
> > @@ -151,7 +151,7 @@ static int clk_mt8186_apmixed_probe(struct platform=
_device *pdev)
> >
> >         fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
> >
> > -       r =3D mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
> > +       r =3D mtk_clk_register_pllfhs(&pdev->dev, plls, ARRAY_SIZE(plls=
),
> >                                     pllfhs, ARRAY_SIZE(pllfhs), clk_dat=
a);
> >         if (r)
> >                 goto free_apmixed_data;
> > diff --git a/drivers/clk/mediatek/clk-mt8192-apmixedsys.c b/drivers/clk=
/mediatek/clk-mt8192-apmixedsys.c
> > index 0b66a27e4d5ac68f09dc6a4197fd84ef82342df9..b0563a285bd666d492a7fa9=
40733aad1ab1a0bae 100644
> > --- a/drivers/clk/mediatek/clk-mt8192-apmixedsys.c
> > +++ b/drivers/clk/mediatek/clk-mt8192-apmixedsys.c
> > @@ -162,7 +162,7 @@ static int clk_mt8192_apmixed_probe(struct platform=
_device *pdev)
> >
> >         fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
> >
> > -       r =3D mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
> > +       r =3D mtk_clk_register_pllfhs(&pdev->dev, plls, ARRAY_SIZE(plls=
),
> >                                     pllfhs, ARRAY_SIZE(pllfhs), clk_dat=
a);
> >         if (r)
> >                 goto free_clk_data;
> > diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk=
/mediatek/clk-mt8195-apmixedsys.c
> > index 282a3137dc89419a6d0b574fd549cee941687900..44917ab034c56f01ef02d19=
57f17eb0655438d75 100644
> > --- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
> > +++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
> > @@ -181,7 +181,7 @@ static int clk_mt8195_apmixed_probe(struct platform=
_device *pdev)
> >
> >         fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
> >
> > -       r =3D mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
> > +       r =3D mtk_clk_register_pllfhs(&pdev->dev, plls, ARRAY_SIZE(plls=
),
> >                                     pllfhs, ARRAY_SIZE(pllfhs), clk_dat=
a);
> >         if (r)
> >                 goto free_apmixed_data;
> > diff --git a/drivers/clk/mediatek/clk-pllfh.c b/drivers/clk/mediatek/cl=
k-pllfh.c
> > index 62bfe4a480f14a0a742fb094aff0e6d1a79fe0c3..8ad11023d91127e88900bc6=
bcabbaeafb1e00664 100644
> > --- a/drivers/clk/mediatek/clk-pllfh.c
> > +++ b/drivers/clk/mediatek/clk-pllfh.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/clkdev.h>
> >  #include <linux/delay.h>
> > +#include <linux/device.h>
>=20
> This shouldn't be needed, as you aren't using any of the APIs.
>=20
> A forward declaration of |struct device| in the header should suffice.
> It should be added anyway, since the header defines data structures that
> have a |struct device *| field.
>=20
>=20
> ChenYu
>=20


  drivers/clk/mediatek/clk-pllfh.c:208:21: error: incomplete definition of =
type 'struct device'
    208 |         base =3D of_iomap(dev->of_node, 0);
        |                         ~~~^

Alas, it is needed, otherwise we can't get the of_node. dev_of_node
is also defined in device.h, so it works out to the same difference.

Kind regards,
Nicolas Frattaroli



