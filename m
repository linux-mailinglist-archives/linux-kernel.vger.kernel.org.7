Return-Path: <linux-kernel+bounces-804454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C149B47728
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 22:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4D616E910
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 20:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3612877FE;
	Sat,  6 Sep 2025 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="CMcAQhBB"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A0E1DDE9;
	Sat,  6 Sep 2025 20:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757191378; cv=pass; b=aLmUOj7z/RpXv7q270LSiXfFiVoIzxE63muzQ5wSxwnQOnNtJZC1JVs3xs+D9i6R6h103R0TvJG9N75NI2CCvuDaOuV0ux79JACO4aXba6NOV/CY/ulfuy0ncYKvdAGgQWMI3jg8d5MnjhWWkRq2nAzubIWmByAwl7Hgr+SQDYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757191378; c=relaxed/simple;
	bh=X6t1E2D0/6KHu5iBbeTZ1Y7NMderIv12Kx55z/B5+5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+x+4TDeiynMHAwig4vCUTikTUjOGzKbck2gDYQ0Ztowe6wWVBrOj1MTXbqQu52yjQ8YS3xtVVUCucniCwzoy3O/CD2Xdz/OL5YhBcub72GMU6R8S79KooWF/K7XJFUmkJdG3cAav0IEwa/uXGA/SCh30esWAlbbWtTJ4xFz3N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=CMcAQhBB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757191350; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Zbd9iwG6mTUDZ3DTU84xNdmxTThRitQtbxALstaaBg9oV93fT7Wbj35qSpvN3g7f3jTbx23pXoVbQcM3VEzvEFD2EFHcj44DIH+DcIx2dzSkoHv2hbKKii3nLntmSZAsN+fT8sSpIG/FAW4K2LQe67t1EwTnL8IOuTt1S7BV5IE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757191350; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+oFXcBgyosrk9K4YUWT5K05A3DKE5mpt+Bn52MygQGQ=; 
	b=PIHCe1+nkF/XtzXqI4f8NjMdux9t/OE7taqDrSHGTaM6Ho2SUfVwUxIcoUzkkAiEMM+E1ETW1hg6XCeAVzInM8UpEBiF6NHtw/5NnEKSm5/CN3kIWJ/EG12a8OHA8ym/8R5eywXQvoNnH92Ndhc1MjAK1DInTMh4xyNrhrQWhXE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757191350;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=+oFXcBgyosrk9K4YUWT5K05A3DKE5mpt+Bn52MygQGQ=;
	b=CMcAQhBBoIxelRD/KecsQSv16a7q+RMB6cKDuICGl2QAYHiuboWYrY8tL6Xb6Zo0
	CLMSevOne9pVsdB/wg4M0a0wlDwl5ElyMYXG4FCJ/bKU6lOKFrvmMn+7DwW0n6X8NGo
	t9m6DzaOMf5fOtG3/BxNlDGPKh5uIHv5EmF4niF4=
Received: by mx.zohomail.com with SMTPS id 1757191347397764.5469931961694;
	Sat, 6 Sep 2025 13:42:27 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 3B96E180B18; Sat, 06 Sep 2025 22:42:22 +0200 (CEST)
Date: Sat, 6 Sep 2025 22:42:22 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Frank Wang <frank.wang@rock-chips.com>, 
	Zhang Yubing <yubing.zhang@rock-chips.com>, Andy Yan <andyshrk@163.com>, 
	Maud Spierings <maud_spierings@hotmail.com>, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] dt-bindings: phy: rockchip-usbdp: add improved
 ports scheme
Message-ID: <jzooq6qg3y7nee2nz6lujustdf4z7vtn6t2slikw43dann5sbk@2telraae26tl>
References: <20250904-rock5b-dp-alt-mode-v1-0-23df726b31ce@collabora.com>
 <20250904-rock5b-dp-alt-mode-v1-1-23df726b31ce@collabora.com>
 <aLyKhngeksG2SKdq@umbar.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bmdy2izrmfeuuc2r"
Content-Disposition: inline
In-Reply-To: <aLyKhngeksG2SKdq@umbar.lan>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/257.176.7
X-ZohoMailClient: External


--bmdy2izrmfeuuc2r
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 1/2] dt-bindings: phy: rockchip-usbdp: add improved
 ports scheme
MIME-Version: 1.0

Hi,

On Sat, Sep 06, 2025 at 10:24:54PM +0300, Dmitry Baryshkov wrote:
> On Thu, Sep 04, 2025 at 08:26:02PM +0200, Sebastian Reichel wrote:
> > Currently the Rockchip USBDP PHY as a very simply port scheme: It just
> > offers a single port, which is supposed to point towards the connector.
> > Usually with 2 endpoints, one for the USB-C superspeed port and one for
> > the USB-C SBU port.
> >=20
> > This scheme is not good enough to properly handle DP AltMode, so add
> > a new scheme, which has separate ports for everything. This has been
> > modelled after the Qualcomm QMP USB4-USB3-DP PHY controller binding
> > with a slight difference that there is an additional port for the
> > USB-C SBU port as the Rockchip USB-DP PHY also contains the mux.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  .../bindings/phy/phy-rockchip-usbdp.yaml           | 23 ++++++++++++++=
++++++++
> >  1 file changed, 23 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.y=
aml b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> > index 8b7059d5b1826fdec5170cf78d6e27f2bd6766bb..f728acf057e4046a4d254ee=
687af3451f17bcd01 100644
> > --- a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> > +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> > @@ -114,6 +114,29 @@ properties:
> >        A port node to link the PHY to a TypeC controller for the purpos=
e of
> >        handling orientation switching.
> > =20
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description:
> > +          Output endpoint of the PHY for USB (or DP when configured in=
to 4 lane
> > +          mode), which should point to the superspeed port of a USB co=
nnector.
>=20
> What abourt USB+DP mode, where each one gets 2 lanes?

Right, I guess we would need one port more and have one port for
lane 0 + 1 and one port for 1 + 2. For USB-C both ports are
connected to the USB-C superspeed port. For DP 4-lane mode the
same is done for the input port of the connector. Last but not
least for 2 lanes USB + 2 lanes DP, one port can be connected
to the USB connector and one port can be connected to the DP
connector.

> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Incoming endpoint from the USB controller
> > +
> > +      port@2:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Incoming endpoint from the DisplayPort controller
> > +
> > +      port@3:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description:
> > +          Output endpoint of the PHY for DP, which should either point=
 to the
> > +          SBU port of a USB-C connector or a DisplayPort connector inp=
ut port.
>=20
> I would suggest describing this port as 'DisplayPort AUX signals to be
> connected to the SBU port of a USB-C connector (maybe through the
> additinal mux, switch or retimer)'. It should not be confused with the
> actual DisplayPort signals (as those go through the port@0).
>=20
> In the Qualcomm world we currently do not describe this link from the
> PHY to the gpio-mux or retimer, but I think we will have to do that
> soon.

It does looks like no upstream platform does a proper description of
USB-C setups :(

Thanks for having a look,

-- Sebastian

--bmdy2izrmfeuuc2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmi8nKMACgkQ2O7X88g7
+ppvtBAAkju2QlVThUn/QreP/COXvVvECT9h6rv0jRB3ZdKfg79oPBzrQVuyCAxq
f7M/ZeJcfD2ioqbs67rVJWB7Q5DRJxvoKjPqCoIW5Gc6yxxKdZ3OAe8b3u94Go48
gBKVWjaeQtRspHln9v+ZEo5TFTl2QsKecOBh4cavkk6ZudydZfnm2vDD2FsFZU6Z
PGFCm1XlDvuz09EVc9OqiLKQAgN7vyMctOelIC/euP5+7rITHP2Oc/toqjTZetCu
hqdTs2Of5NxYF7kIlMxM0GKTQ9d2KEw0IrS2zq0fyNcxlIaRUzj72didiBONiVH7
2JzMpqcua6OV2hpUWggNDpcV+OF3a/aHy2byoaN3KP2w4jXOIDNmpURjiOZy/juv
iyWM0bJa/aows83PdjrRjyIg0/RnLPtqaknp9jYiVUIRN2lhJ+QSaLyY/azjLLhe
av3RngWLeY2CNYZXRLGI52F/oKn1yScd+fw7oR+yUIEMEwOFgFom6w23BWFTcqIe
V2M/FWe62ZzgMXrxt5ue7KH54WtuvQyHcdu7sMVZCbMAz+XIaskVWvGUhkVWi0/u
3Hmw7n4GUEQQbJMn84IG2lXeHmAtkV9d7lmTTycQdCytwXRQRxrWMY16W0XLGBjM
NTp/t4Ae4vNfEvSBXsaXlrT1VpSQYUHr3IqTpENU20LxnhDYEQ4=
=gYv+
-----END PGP SIGNATURE-----

--bmdy2izrmfeuuc2r--

