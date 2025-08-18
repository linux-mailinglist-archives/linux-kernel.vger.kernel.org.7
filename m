Return-Path: <linux-kernel+bounces-772945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD259B299A6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6AC1B20562
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A563274B45;
	Mon, 18 Aug 2025 06:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="p+rKxhwG"
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9465A274B3B;
	Mon, 18 Aug 2025 06:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755498528; cv=none; b=IFFMI0yCv9VC38GHF5zYELS14SWsZieFefEA3r103rl3b74ZB1Y1gqsVp4CDjmdt44lA4wloOhkrTUArQrrRCaPwMpgJtL7Bpd7RcY0fwgeFGS/5aSGx9vOFXFEaO8htd4l0GmSRMWwjTIHX5tyM4q13W9FPcBRMik/SGWN2TXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755498528; c=relaxed/simple;
	bh=s1t8KesLnR6mEX6Kpzb8LmcMJ5yEJW41JxTvV7m3akk=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=ICpsoCoybIihG3UUxQuWdOsarDr5X1dbayMweb+V1rbjPTjbHGCgW+3z3Wgu+NmWrAXcyA0KSLzVCbv6AjPyusp+I+MC3hA3+lIAevnyfTPdMUXjkpO8/q1Umg2XOoQWf8cMsHOREQaIXiqRKP2dk+MV2a7bqc70ZdNMC2W/Zqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=p+rKxhwG; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 1E0CD6BE;
	Mon, 18 Aug 2025 08:22:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1755498140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
	 references:references; bh=JCjWLxeGh14tYNyqo6lDpE4x/0mQUZVTmte1urJQThE=;
	b=p+rKxhwGZJYlLmW4DZ7GiEN4L5JFE7h4OR3Tqrd17Jt3xKodm/U6YwzA/k56I68MrG6eMO
	llul/6DKQtE+nrFFMfgiqe1mIQnulPRYyMWqDrQSuM0ug6CEzMtHCTfEidO5LvI/5dWQTi
	HlLbCix3FcL67bQG1bJwjZi0JIUbG3+MA0XlGISt4tGUJ0ePOnoCRjgLtCo0+syP7wqpCV
	MIGgYswBCiVy0JnEFduUF+2+0wBF3z2STZdc56ym9Toc+lxV43jWOxs3bz8p81haW8rUaF
	FOjx/gYE3GNsgURe+Np6hAgir7g/gEXNmwLpvjGXM1OgkliOQPNftgTA+XliQg==
Content-Type: multipart/signed;
 boundary=5020df314e58c7e913c14c73516544fda37893398f5f3a17a4119856c99b;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 18 Aug 2025 08:22:18 +0200
Message-Id: <DC5C5JA237HD.1ACBQVG1LYQ7Z@walle.cc>
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j784s4-j742s2: enable the
 bxs-4-64
Cc: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <d-gole@ti.com>, <afd@ti.com>,
 <bb@ti.com>, <linux-arm-kernel@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <detheridge@ti.com>, <matt.coster@imgtec.com>
From: "Michael Walle" <michael@walle.cc>
To: "Nishanth Menon" <nm@ti.com>, "Randolph Sapp" <rs@ti.com>
X-Mailer: aerc 0.16.0
References: <20250808232522.1296240-1-rs@ti.com>
 <20250808232522.1296240-3-rs@ti.com>
 <20250813151819.5rthljjrpryfwezz@skinning>
 <DC1HU458W3QA.YLONSMYKK0C4@ti.com>
 <20250813181300.xfpsu23arx7xy4fy@anointer>
In-Reply-To: <20250813181300.xfpsu23arx7xy4fy@anointer>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--5020df314e58c7e913c14c73516544fda37893398f5f3a17a4119856c99b
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed Aug 13, 2025 at 8:13 PM CEST, Nishanth Menon wrote:
> On 12:58-20250813, Randolph Sapp wrote:
> > On Wed Aug 13, 2025 at 10:18 AM CDT, Nishanth Menon wrote:
> > > On 18:25-20250808, rs@ti.com wrote:
> > >> From: Randolph Sapp <rs@ti.com>
> > >>=20
> > >> Add the relevant device tree node for Imagination's BXS-4-64 GPU.
> > >>=20
> > >> These devices uses a similar MSMC configuration to the J721S2. As su=
ch,
> > >> they also require the use of the dma-coherent attribute.
> > >>=20
> > >> Signed-off-by: Randolph Sapp <rs@ti.com>
> > >> ---
> > >>  .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi  | 14 +++++++++++=
+++
> > >>  1 file changed, 14 insertions(+)
> > >>=20
> > >> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dts=
i b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> > >> index 7c5b0c69897d..a44ca34dda62 100644
> > >> --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> > >> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> > >> @@ -2691,4 +2691,18 @@ bist_main14: bist@33c0000 {
> > >>  		bootph-pre-ram;
> > >>  		ti,sci-dev-id =3D <234>;
> > >>  	};
> > >> +
> > >> +	gpu: gpu@4e20000000 {
> > >> +		compatible =3D "ti,j721s2-gpu", "img,img-bxs-4-64", "img,img-rogu=
e";
> > >
> > > Following  https://lore.kernel.org/linux-arm-kernel/DBE4UO2RGAYX.17V1=
DAF8MQYJM@kernel.org/
> > > Is it worth having ti,j784s4-gpu here? Are there any SoC specific qui=
rks
> > > that driver will need to handle?
> >=20
> > No SoC specific quirks, aside from those already being tracked through =
the
> > dma-coherent attribute. If we actually want to register SoC specific
> > compatibility entries as advised by the kernel docs, just let me know. =
I've seen
> > this opinion toggle a few times.
> >=20
>
> Please provide bootlogs on linux-next with just this series applied.
> IMHO, based on what I see at the moment on GPU, it might be a good idea
> to have SoC specific compatibility entries.

IMHO, that's *always* a good idea, even if the IP is the very same
as the integration might be different.

Apart from that, we now have two series which partly overlap.
Should I repost mine, as that's more than just the DT entry? (Which
doesn't work as is, I'd guess.)

-michael

--5020df314e58c7e913c14c73516544fda37893398f5f3a17a4119856c99b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaKLGmhEcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+CG0AYDttjNUvi7U4uugJWozE7wr/9v404fRPKae
MHBLFgHa9SuLDPG1DHz98nE+zofqZKMBf0rHJGLROCsCEODHOqtV1n+1QTQ4lnEK
bMC8pQbKbtPYITEh7sb88sgeL3ZvU0pG7A==
=D13I
-----END PGP SIGNATURE-----

--5020df314e58c7e913c14c73516544fda37893398f5f3a17a4119856c99b--

