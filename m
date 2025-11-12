Return-Path: <linux-kernel+bounces-898223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D55C549F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 85F1F3407E1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938652E1726;
	Wed, 12 Nov 2025 21:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="X7uT0URi"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEC32D73A8;
	Wed, 12 Nov 2025 21:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762983248; cv=none; b=CeBB0Rf6v639p/eY3Sn1HJHP6Bs/g67NvEezoeDLbf8ekt1dOTnC0kO2tLykPjEtpPejL0rlKWHnjgO7KofUVd+MnUEmgwebBTbIkp2dA+eLX5fwSn8CNsXrJ73pB8CtUGgwIAY07plvHYrmHRqqMH/JsvTyieo+/PpTeyx2wxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762983248; c=relaxed/simple;
	bh=+99mi3GXqGSdilKN5M7zMYOleRr3BiyHhhEzp+cSvWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvSEjQwLO80UrsG3O2nQoNTvRXt82Ijj+cv741kCDRY4hLAzWxl9/eBMPI/1/Ryg8nlcH5TELkWbpIUUdXroz9xp4BiWRgZnoVj7AZ3YblznXi6mVpqwta9xU2+8++F4PZ7FCa0ykjKDf5WEsWMrPfcqGeCUpzU7zdWe84c0E1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=X7uT0URi; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Ijl2d5txxx1muG7LOy+sOf2K0f9ZIGcMU1J5ip5lOhg=; b=X7uT0URitTKZFJr1kumOjmk6eQ
	ClK5aHNgEMNkJljPp3g5keM78actOLbUFP57etFiiy+kWf8HULuXIqXCbT4hQHj0vp5EgR5qCBqA4
	H59Wnbl8t9wccQxXU9tlD5+Oy4+fur1+4udmhevjUdUYCxolGmQ6T+rZHVkEpWnVtY6gAn7fGf+M1
	zZbxlTY+4QAokn1/rMIlXRDSBV17AhYkweyrmz9JD+fKOCUVuxxALOJXQ5LKkz1Nh9CGr/KgkYdI3
	h7ggGLlPnWcoKxk6VwVPogUGULuqqBy4FdonjWq0t1meZ8SRAiVZGVNbbQEgxn6CnNAXwoL5/57y4
	/AQUj9tQ==;
Received: from i53875b63.versanet.de ([83.135.91.99] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vJITK-0003p1-29; Wed, 12 Nov 2025 22:33:46 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Jonas Karlman <jonas@kwiboo.se>, Andrew Lunn <andrew@lunn.ch>
Cc: "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "ukleinek@debian.org" <ukleinek@debian.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>
Subject:
 Re: [PATCH 2/6] arm64: dts: rockchip: Fix the 1Ghz ethernet on Qnap TS433
Date: Wed, 12 Nov 2025 22:33:44 +0100
Message-ID: <3380318.aeNJFYEL58@diego>
In-Reply-To: <e4d3127b-c879-4931-9ea0-de7449bc508c@lunn.ch>
References:
 <20250925092923.2184187-1-heiko@sntech.de>
 <da752790-da17-4d26-b9b2-8240b38b3276@kwiboo.se>
 <e4d3127b-c879-4931-9ea0-de7449bc508c@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 25. September 2025, 19:11:29 Mitteleurop=C3=A4ische Normalze=
it schrieb Andrew Lunn:
> On Thu, Sep 25, 2025 at 06:58:06PM +0200, Jonas Karlman wrote:
> > Hi Heiko,
> >=20
> > On 9/25/2025 11:29 AM, Heiko Stuebner wrote:
> > > While I want to remember that the dwmac on the TS433 was working at s=
ome
> > > point, it seems I had my network always connected to the 2.5G nic aft=
er
> > > that "point". And testing now revealed that the gmac does not actually
> > > manages to transfer data.
> > >=20
> > > Currently the gmac is set to rgmii-id with no rx-/tx-delay values set
> > > which makes the driver use default values. Setting the delays to 0
> > > also does not provide a working interface.
> > >=20
> > > The vendor kernel is running with phy-mode set to rgmii and delays of
> > >     tx_delay =3D 0x3c, rx_delay =3D 0x2f
> > >=20
> > > As Andrew points out often, those delay values "are magic" and rgmii-=
id
> > > should definitly be used "with small values" for delays, if really ne=
eded.
> > >=20
> > > The Rockchip vendor-kernel actually contains additional code in the d=
wmac
> > > driver to use the loopback function of a phy to find a window of usab=
le
> > > delay values. Code can be found for example on [0] and the process is
> > > described in a document called "Rockchip GMAC RGMII Delayline Guide"
> > > which has made its way onto the internet in a lot of places [1].
> > >=20
> > > So I used this process, with the interface set to rgmii-id to get val=
ues
> > > for this mode, which are in face lower than the ones for rgmii with
> > >     tx_delay =3D 0x21, rx_delay =3D 0x15
> > > and results in a working interface on the dwmac.
> > >=20
> > > [0] https://github.com/armbian/linux-rockchip/blob/rk-6.1-rkr6.1/driv=
ers/net/ethernet/stmicro/stmmac/dwmac-rk-tool.c
> > > [1] https://gitlab.com/firefly-linux/docs/-/blob/rk356x/firefly/Commo=
n/GMAC/Rockchip_Developer_Guide_Linux_GMAC_RGMII_Delayline_EN.pdf
> > >=20
> > > Cc: Andrew Lunn <andrew@lunn.ch>
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > >  arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arc=
h/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
> > > index 5656554ca284..e8af92a011d6 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
> > > @@ -257,6 +257,8 @@ &gmac0_tx_bus2
> > >  		     &gmac0_rx_bus2
> > >  		     &gmac0_rgmii_clk
> > >  		     &gmac0_rgmii_bus>;
> > > +	rx_delay =3D <0x15>;
> > > +	tx_delay =3D <0x21>;
> >=20
> > I do not understand why defining rx/tx_delay would change anything.
>=20
> I was also wondering why these two properties are added but no change
> to phy-mode.
>=20
> >=20
> > Setting these should currently not have any effect on the driver code
> > when phy-mode=3Drgmii-id is used, see below (next-20250924, dwmac-rk.c):
> >=20
> >=20
> > 	switch (bsp_priv->phy_iface) {
> > 	case PHY_INTERFACE_MODE_RGMII:
> > 		dev_info(dev, "init for RGMII\n");
> > 		bsp_priv->ops->set_to_rgmii(bsp_priv, bsp_priv->tx_delay,
> > 					    bsp_priv->rx_delay);
> > 		break;
> > 	case PHY_INTERFACE_MODE_RGMII_ID:
> > 		dev_info(dev, "init for RGMII_ID\n");
> > 		bsp_priv->ops->set_to_rgmii(bsp_priv, 0, 0);
> > 		break;
>=20
> And this explains it, thanks.
>=20
> > I have played around with a few patches that changes this and apply the
> > rx/tx_delay for rgmii-id modes (both Linux and U-Boot), see top of [2]
> > for Linux patches. Will try to get them on ML in a few days.
>=20
> We should not really be expanding the use of rx_delay and
> tx_delay. The standardized properties {tx|rx}-internal-delay-ps should
> be used.

as Jonas wrote the delays do nothing for rgmii-id. So the whole thing
must have been me doing something wonky, because on re-testing
everything, it is as expected - no delays necessary and ethernet just
works.

So I'll drop this patch altogether and adapt the TS233 one.

Heiko

Heiko



