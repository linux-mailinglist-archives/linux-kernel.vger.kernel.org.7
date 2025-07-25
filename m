Return-Path: <linux-kernel+bounces-745286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06854B117F5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF641CC369B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 05:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6157242D6B;
	Fri, 25 Jul 2025 05:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="e1L/4KHB"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8141F4617;
	Fri, 25 Jul 2025 05:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753421072; cv=pass; b=O0N67Px2S5aJlzw0QVZCVDAav4V9qnwpucMxceHLsMtddExeNR76CesFFyX8li4T8cO5OCzm3iQ36NL1P4SyZKCAd2H+3GYvAAP8Cg9CbDLXfXqGctKuF6MPn9QUk74TjrhGZOhyOHYxJrGSI46qySfcvEanHKvYOPtAAbAxkl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753421072; c=relaxed/simple;
	bh=0jdwYP7NMMSOkijcTdLfUVo2J0IdU8dpKxQcsJLtvco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQz7pTqgU35G4oj8F906MFYZry3iZcAAOdUC1IgEBsm30Mefq5BBkJJpO31uhEMI4cUC0SlM1l1/ZwaHb9sR447rLuC7VbgysuvWvzM2uCCKKyFqkm0h5prZG0tQzLyaPRIGNSWF2y1rrauI6OXrODdDfJKrnRuRPgNYUPKBVGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=e1L/4KHB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753421048; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NsjT7+WyV/RRNWTCvMJ8Qpu2MdfXsJDsFfmjL2wTNSEI1mCDkSyjB0IT4a8jKa6n5z3VJ6VZa1705fql5CkKJsS0OPP5FJ5AbXkUlmuyjuJ6BfGQZR/xz+RvILylpiINR1RT9rzLf5iHI6h8audGDpe1CNTyJPmpfG1eXLunIxQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753421048; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=y4ldkYpDBhe6MUIxmYmjLmmqHNKj9PN8JQgOOK2ZTr4=; 
	b=NCuYY47R5Mz5/snraIWehHM+mW3mCkPDjC4nSyxWwmbYl9izIkm5bFj73PH28VKENXbe16r+z4RpOW1PRF0oxy/++ysxC5+xKVYzm0CPBIJiSAWRBsk6Ol98AhdXUqhksbiOjdipj+chedHKBKYTxV1HeSk6XCHiDSkWSm3O8HM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753421048;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=y4ldkYpDBhe6MUIxmYmjLmmqHNKj9PN8JQgOOK2ZTr4=;
	b=e1L/4KHBQPvUM5BedDKyxbfKjxEZGHnyyCPgf5MMX4m1R71qRhOPgWKzSATlVJHV
	/nJP05RXDTW5rMq4feV4ZXR8vXBouEQuvidaNPphnqO+fAWxQ9jGkJDBSISmRgysc3L
	PR7UrRahCBwx5iSiZKO4WUgMzveXbP/sWiHo1yJs=
Received: by mx.zohomail.com with SMTPS id 1753421046615566.1010844319203;
	Thu, 24 Jul 2025 22:24:06 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id CE23A180761; Fri, 25 Jul 2025 07:24:01 +0200 (CEST)
Date: Fri, 25 Jul 2025 07:24:01 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] arm64: dts: rockchip: use MAC TX delay for ROCK 4D
Message-ID: <mqoyjn7mnq6tmt6n6oev4wa3herjaxlupml2fmcampwiajvj4a@r5zs4d3jdm5p>
References: <20250724-rk3576-rock4d-phy-timings-v1-1-1cdce2b4aca4@kernel.org>
 <f22243f5-759a-4ff2-8d14-6edb49d87c52@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lntxnw2zm2xvrrvo"
Content-Disposition: inline
In-Reply-To: <f22243f5-759a-4ff2-8d14-6edb49d87c52@lunn.ch>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/253.413.66
X-ZohoMailClient: External


--lntxnw2zm2xvrrvo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] arm64: dts: rockchip: use MAC TX delay for ROCK 4D
MIME-Version: 1.0

Hi,

On Thu, Jul 24, 2025 at 05:51:16PM +0200, Andrew Lunn wrote:
> >  &gmac0 {
> >  	clock_in_out =3D "output";
> >  	phy-handle =3D <&rgmii_phy0>;
> > -	phy-mode =3D "rgmii-id";
> > +	phy-mode =3D "rgmii-rxid";
> >  	pinctrl-names =3D "default";
> >  	pinctrl-0 =3D <&eth0m0_miim
> >  		     &eth0m0_tx_bus2
> > @@ -246,6 +246,8 @@ &eth0m0_rgmii_clk
> >  		     &eth0m0_rgmii_bus
> >  		     &ethm0_clk0_25m_out>;
> >  	status =3D "okay";
> > +	tx_delay =3D <0x20>;
> > +	rx_delay =3D <0x00>;
>=20
> What does 0x20 mean? Is it less than 2ns, or greater than 2ns?

Unfortunately I don't know. This part is not documented in the TRM I
have access to. Also my scope is not good enough for measuring
delays in the pico-second range. Previous measurements for RK3588
(RK3576 uses most of its IP and probably shared most of its quirks)
suggested, that mapping this to the standard properties may not
easily be possible:

https://lore.kernel.org/all/bb3486c6-93df-4453-acc6-deba3c8f7f0e@lunn.ch/

> Have you tried "rgmii-id" and small values for tx_delay? If the
> hardware needs 2.1ns, for example, the MAC could add 0.1ns and the PHY
> adds the default 2ns. That would allow you to conform to the DT
> binding.

The MAC code (drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c) looks
like this, so "rgmii-id" results in no MAC delays being applied:

	case PHY_INTERFACE_MODE_RGMII:
		bsp_priv->ops->set_to_rgmii(bsp_priv, bsp_priv->tx_delay,
					    bsp_priv->rx_delay);
		break;
	case PHY_INTERFACE_MODE_RGMII_ID:
		bsp_priv->ops->set_to_rgmii(bsp_priv, 0, 0);
		break;
	case PHY_INTERFACE_MODE_RGMII_RXID:
		bsp_priv->ops->set_to_rgmii(bsp_priv, bsp_priv->tx_delay, 0);
		break;
	case PHY_INTERFACE_MODE_RGMII_TXID:
		bsp_priv->ops->set_to_rgmii(bsp_priv, 0, bsp_priv->rx_delay);
		break;
    ...

Also the default values (if properties are missing in DT) are
rx_delay=3D0x10 and tx_delay=3D0x30, so changing this logic risks
breaking some boards :(

> What PHY is this? Have you looked it you can control the delays the
> PHY adds? If you actually need a delay of 1.9ns, maybe the PHY can be
> configured to do this? That would also allow you to conform to the DT
> binding.

The Rock 4D uses a RTL8211F. As far as I can see that just offers
one delay control knob.

Greetings,

-- Sebastian

--lntxnw2zm2xvrrvo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmiDFOkACgkQ2O7X88g7
+pocqRAAmG8r6935rknghxbjS85/wcBLgwi1SELzeDaLTBoAT+ib7M19APbWAXm1
GOmjHBN09+TXbygKfHNoch5ot3dcMOBkhWaody16bZHFf9ViNkYwSIccs4BeVNEO
l6EONSCdAjDt1LRB3AFPR9fG3bcaXvzpcLq9rHaBZ5keaEESGQpw5ACAcoJFGVYh
gvwWya6PHgMol5zGWIkn7IYucKPTKWPmsp4NfyznEhe11UGW43uok9CisTN1SD0t
JmWpg7WL4xhJ9Pno+gG+Bw70p5ZXZAeS+37dSj5HtL0+jn4KG53KEx2pNon9Bwcy
C+I/IxAfL5xm8T4oxOO7eHCg/+GoMPSBqtsb0dEI7iwzMgA0Nxo1bFHvV337U9ma
6CNa2abaZWRtp6qEEP1PP4bfFV5fSxK5bP5q/6OYYGa4vASAKUhfTxiJt41G0hXv
1SrkEl36Ln/XponneBBiBT7LzGFE72UdHiKhD5O4wqWkRJm/vPRg0J93J89zqeu7
B4MvRFXyUe8Roid2T+WFL2/+OZeWpmiGiwtPrNjbs7EKLRUb1jnUvsxUo+pMSp3q
BCmQeUGNxYpI1i4JYD3CzHjHbbgSYT26C4nkgowTCSmY3O1Db2k0PqHl7xCmKVw7
RCGSAhGauMbV28A50kgORuQXD/UiUqdl4QU6K5aA6EWFxuGWYSg=
=XuMz
-----END PGP SIGNATURE-----

--lntxnw2zm2xvrrvo--

