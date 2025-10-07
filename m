Return-Path: <linux-kernel+bounces-844228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBB1BC1579
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16103A915F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6020F2DC76B;
	Tue,  7 Oct 2025 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yawt6EI7"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69168BEC
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839502; cv=none; b=HQWbIJVVa6Mqot9l1eX3H2JWLB80rg5DAN7SA8qjR1zO5oBz5PoqcuExaD2wHxL6gPPrkRpk87Cvey5CXF0vvVSz6L2uxW9ko0dNG+Or97mIctxgan0AS31lJVej51rE6dFVWz/x6gWHesVUO3AmIlu/lI9OsRiXdZKscYxd4Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839502; c=relaxed/simple;
	bh=n3qyq0zCQXdCJBfAOtal5ddQoKK5Fru7T6oFj+YyMjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0WBehXbkw1geiA7+Z0u1C95DyZ4zY8OwdhrS8FVShpNjyei/HbnXpw9A1LEwbYadNBZjz6I6ciXhQXWKSDmAjov5ekM7/mw+SBnoGsWqzpV4PNA7/KHLDqc0i9kJn8KI2ixNxWUUd0HhLhHV3ePqIt7LjdP8902OuvrhHSAUFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yawt6EI7; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id ED2444E40E54;
	Tue,  7 Oct 2025 12:18:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B864D606C8;
	Tue,  7 Oct 2025 12:18:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AF910102F213D;
	Tue,  7 Oct 2025 14:18:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759839496; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TWocNGon5hEUXixtp5914OcPbBE/+5Oe6rZXGYf+mHg=;
	b=yawt6EI7axVYIptbZ0lA3c3Nn/mfNcgBPoI/rKK81PPLdN4JTY9QOcRklSl+NxIxvC6YzP
	EFCXRUSmGbddKhVBHZFwF7Wmzg4nY8hkogYcjNRr+h+d2Fsu3TWFC8pMYDG7DlcbmCxVvv
	6m46+wNMWIVs08OUstxB4w1DFUp8vQSNar8cmh/5HrC1z2i/UWZWckymzNwYIFHVwRc92j
	uq3nWEOD0RKAsZHgSU6nYDqQjkW93gsNpgNCt/9saXCUjbzsHZxqB4hWUww0e8TZlw08Gs
	cfAw172XEOxgg8n3x1o2pFxPUJ6RGMyY3YFHkbFcZSRUEBFlRGSP1zLUk+nvMw==
Date: Tue, 7 Oct 2025 14:18:04 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Thomas Wismer <thomas@wismer.xyz>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Thomas Wismer <thomas.wismer@scs.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] net: pse-pd: tps23881: Add support for TPS23881B
Message-ID: <20251007141804.691d5660@kmaincent-XPS-13-7390>
In-Reply-To: <20251006232318.214b69b7@pavilion>
References: <20251004180351.118779-2-thomas@wismer.xyz>
	<20251004180351.118779-6-thomas@wismer.xyz>
	<20251006150505.643217e8@kmaincent-XPS-13-7390>
	<20251006232318.214b69b7@pavilion>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 6 Oct 2025 23:23:18 +0200
Thomas Wismer <thomas@wismer.xyz> wrote:

> Am Mon, 6 Oct 2025 15:05:05 +0200
> schrieb Kory Maincent <kory.maincent@bootlin.com>:
>=20
> > On Sat,  4 Oct 2025 20:03:51 +0200
> > Thomas Wismer <thomas@wismer.xyz> wrote:
> >  =20
> > > From: Thomas Wismer <thomas.wismer@scs.ch>
> > >=20
> > > The TPS23881B device requires different firmware, but has a more
> > > recent ROM firmware. Since no updated firmware has been released
> > > yet, the firmware loading step must be skipped. The device runs
> > > from its ROM firmware.
> > >=20
> > > Signed-off-by: Thomas Wismer <thomas.wismer@scs.ch>
> > > ---
> > >  drivers/net/pse-pd/tps23881.c | 65
> > > +++++++++++++++++++++++++++-------- 1 file changed, 51
> > > insertions(+), 14 deletions(-)
> > >=20
> > > diff --git a/drivers/net/pse-pd/tps23881.c
> > > b/drivers/net/pse-pd/tps23881.c index b724b222ab44..f45c08759082
> > > 100644 --- a/drivers/net/pse-pd/tps23881.c
> > > +++ b/drivers/net/pse-pd/tps23881.c
> > > @@ -55,8 +55,6 @@
> > >  #define TPS23881_REG_TPON	BIT(0)
> > >  #define TPS23881_REG_FWREV	0x41
> > >  #define TPS23881_REG_DEVID	0x43
> > > -#define TPS23881_REG_DEVID_MASK	0xF0
> > > -#define TPS23881_DEVICE_ID	0x02
> > >  #define TPS23881_REG_CHAN1_CLASS	0x4c
> > >  #define TPS23881_REG_SRAM_CTRL	0x60
> > >  #define TPS23881_REG_SRAM_DATA	0x61
> > > @@ -1012,8 +1010,28 @@ static const struct pse_controller_ops
> > > tps23881_ops =3D { .pi_get_pw_req =3D tps23881_pi_get_pw_req,
> > >  };
> > > =20
> > > -static const char fw_parity_name[] =3D
> > > "ti/tps23881/tps23881-parity-14.bin"; -static const char
> > > fw_sram_name[] =3D "ti/tps23881/tps23881-sram-14.bin"; +struct
> > > tps23881_info {
> > > +	u8 dev_id;	/* device ID and silicon revision */
> > > +	const char *fw_parity_name;	/* parity code firmware
> > > file name */
> > > +	const char *fw_sram_name;	/* SRAM code firmware
> > > file name */ +};
> > > +
> > > +enum tps23881_model {
> > > +	TPS23881,
> > > +	TPS23881B,
> > > +};
> > > +
> > > +static const struct tps23881_info tps23881_info[] =3D {
> > > +	[TPS23881] =3D {
> > > +		.dev_id =3D 0x22,
> > > +		.fw_parity_name =3D
> > > "ti/tps23881/tps23881-parity-14.bin",
> > > +		.fw_sram_name =3D "ti/tps23881/tps23881-sram-14.bin",
> > > +	},
> > > +	[TPS23881B] =3D {
> > > +		.dev_id =3D 0x24,
> > > +		/* skip SRAM load, ROM firmware already IEEE802.3bt
> > > compliant */
> > > +	},   =20
> >=20
> > You are breaking Kyle's patch:
> > https://patchwork.kernel.org/project/netdevbpf/patch/20240731154152.402=
0668-1-kyle.swenson@est.tech/
> >=20
> > You should check only the device id and not the silicon id. =20
>=20
> On the TPS23881, the register "DEVICE ID" reads as 0x22 (Device ID number
> DID =3D 0010b, silicon revision number SR =3D 0010b). On the TPS23881B, 0=
x24
> (DID =3D 0010b, SR =3D 0100b) is returned. Both devices report the same
> device ID number DID and can only be distinguished by their silicon
> revision number SR.
>=20
> Unfortunately, Kyle's assumption that the driver should work fine with
> any silicon revision proved to be wrong. The TPS23881 firmware is not
> compatible with the TPS23881B and must not be attempted to be loaded. As
> of today, the TPS23881B must be operated using the ROM firmware.

Indeed you are right, I misread the datasheet, on my head I thought it was =
the
device ID which changes between the TPS23881 and the TPS23881B.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

