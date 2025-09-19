Return-Path: <linux-kernel+bounces-824114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E995EB88274
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B9874E1D80
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569E12C21D8;
	Fri, 19 Sep 2025 07:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="1Q9K6Mmj"
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF15C1DB122;
	Fri, 19 Sep 2025 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758266988; cv=none; b=hK/IPWGw/sXDkbpn3ZC5BmL6oDe+4axMCc1HFldKpwRfuTk7JnAwYuNPecnvr2J4y6QJAkgt1yflsIvOl42VU5lK/IT7nluVt/HIibeMY71muve+XkO0TkUxBKObA4Nuwhk+coZUVbipL8j/Bhs9/gsHZtQ9N93dCGixNyKgudM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758266988; c=relaxed/simple;
	bh=ULo+s/2ODXQFh/JQvlxtb4DFX6XMnuyriiEG79m9GJM=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=U9ekbb4GkIMe84cYolGq7DFAqVnuPGsK68qVmeBgEmlMX1+6/3kmJXxCI6AlQ6QZoFSVM4kl54eO2r3ffFjPQPfw5V7emeVSgzcon+avwVoflVCtjSsfNF3yGvHKZ6hC8If3aR5xn4Z8XfrT/p++Shzzd0/hhyanhjVZQZHF9Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=1Q9K6Mmj; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 589C62C3;
	Fri, 19 Sep 2025 09:29:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1758266984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
	 references:references; bh=ULo+s/2ODXQFh/JQvlxtb4DFX6XMnuyriiEG79m9GJM=;
	b=1Q9K6MmjLYc1p1dVzCDV4PHncM13bZWTFhk4daeNOWiPoXjjhd9ESBhalgFcxuEInIY6jC
	9eMChdRfikcN9Dov8RMurKm+GInrpv2tc9dDNVFX7oAPP1O+JhM29nlnqhNjTIe5mDEMI+
	l0Xx7v8TaU8/PKN8ifMpRAQ5QwOqk0h2xzRTcjmnIZKynFShuVr+x6YIf1yt9DcaPVdxKu
	ek9GWZDMEBBf6Y9cUou4dvGkcggtqs3/IGuWhqULNzjfrcuk/rkBY2tEfATz7VS1D6x2FU
	rHv8bt1W36WznlTp06ksR5jMwxx0bHYqvSESRi67PtMBjgEuVj4ar06+2n5RuA==
Content-Type: multipart/signed;
 boundary=607f87c26e3858208822f511b1a3d85f1caa719f1409f1ec0c9a12bd8be4;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 19 Sep 2025 09:29:41 +0200
Message-Id: <DCWLMKKUEALZ.CX4XNGWG80B8@walle.cc>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Shawn Guo"
 <shawnguo@kernel.org>, "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>, "Fabio Estevam"
 <festevam@gmail.com>, "Peng Fan" <peng.fan@nxp.com>, "Frank Li"
 <frank.li@nxp.com>, "Marco Felsch" <m.felsch@pengutronix.de>, "Han Xu"
 <han.xu@nxp.com>, <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <michael@walle.cc>
To: "Peng Fan" <peng.fan@oss.nxp.com>, "Haibo Chen" <haibo.chen@nxp.com>
Subject: Re: [PATCH v2 3/4] arm64: dts: imx8mm-evk: limit the max frequency
 of spi nor chip
X-Mailer: aerc 0.16.0
References: <20250917-flexspi-dts-v2-0-7e2a95e3cf4d@nxp.com>
 <20250917-flexspi-dts-v2-3-7e2a95e3cf4d@nxp.com>
 <20250918090151.GB23028@nxa18884-linux.ap.freescale.net>
In-Reply-To: <20250918090151.GB23028@nxa18884-linux.ap.freescale.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--607f87c26e3858208822f511b1a3d85f1caa719f1409f1ec0c9a12bd8be4
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu Sep 18, 2025 at 11:01 AM CEST, Peng Fan wrote:
> On Wed, Sep 17, 2025 at 04:42:29PM +0800, Haibo Chen wrote:
> >The spi nor on imx8mm evk board works under SDR mode, and
> >driver use FlexSPIn_MCR0[RXCLKSRC] =3D 0x0 for SDR mode.
> >According to the datasheet, there is IO limitation on this chip,
> >the max frequency of such case is 66MHz, so add the limitation
> >here to align with datasheet.
> >
> >Refer to 3.9.10 FlexSPI timing parameters on page 59.
> >https://www.nxp.com/docs/en/data-sheet/IMX8MMIEC.pdf
>
> The SoC SDR mode max supports 66MHz, 133MHz. DDR mode max supports 33MHz =
and
> 66MHz. Saying the driver now only use RXCLKSRC 0 to restrict the
> device tree to 66MHz is not that correct.
>
> The SoC max frequency could be coded in driver per my understanding.

Yes that is correct. The spi-max-frequency property is for the
device, not the capabilities of the controller. I.e. the flash chip
on the board.

> For the QSPI-NOR chip, the spi-max-frequency should represent the NOR chi=
p
> frequency. But that chip supports SDR/DDR, so a new property
> spi-ddr-max-frequency, if we take spi-max-frequency as the max NOR
> CHIP SDR mode frequency?

Which chip is it? I'm not sure that this is required because the
supported modes might be in the SFDP data and we just support the
8d8d8d mode backed by the JEDEC standard.

-michael

> So if spi-max-frequency is the maximum NOR chip SDR frequency, the driver
> should also be update dthat DDR mode is not supported as of now.
>
> Just my thoughts.
>
> Regards
> Peng.


--607f87c26e3858208822f511b1a3d85f1caa719f1409f1ec0c9a12bd8be4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaM0GZhEcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+KPsAYDD0piVNNV1rVcmBba2vIiBIGQxNaJUhr2q
lYJGIGcAQlr/mGzZGwhSKi3yd0EIsf0BfjT4Yw6BoYAIc+6qpYnJ19d0UyQMSjTj
1WEXBgDHozBpOEaD/ghy6y614JlE15ewtQ==
=Zu8u
-----END PGP SIGNATURE-----

--607f87c26e3858208822f511b1a3d85f1caa719f1409f1ec0c9a12bd8be4--

