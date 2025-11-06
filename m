Return-Path: <linux-kernel+bounces-888869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2859BC3C202
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19D218900AC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E387320CC2;
	Thu,  6 Nov 2025 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h1DmG993"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2A330CD86
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443651; cv=none; b=ceVebzBnjDt4btGiRYTczNVnCDSR4laYzlGTl13Dpf5jGcGNJKfeG+LEYtm4Sx7FzWW2Q0JSTwb/74WKdWRkYIo5v71xNdHcD/wKHq2UuATUSwMCjHjATrCWSPGKJeRSa2qQynSGypbbp1dbFX5cV5RPf9dVeqcxsHzKZk77xUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443651; c=relaxed/simple;
	bh=nB8ihh8drVNc7jO6z5A16olh0Vuvr2Vz6ehNqJSTkdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onV6Gm+zTNc4LceUdyg4zZ0t9DN++KqymVW16gnxHBLfGTljATlflmm7weSTBqkjG3ZVieln9GcaQRx0tI23cmKhrs7RwGgKqeN34E2DiIeWFDEV/7ZIgn98cAFexkNr3vGE4uifS0qlCdo+R3TdIBCc9qDUP9oTDbcrwrm+UOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h1DmG993; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 074A0C0FA8E;
	Thu,  6 Nov 2025 15:40:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EC1C26068C;
	Thu,  6 Nov 2025 15:40:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 203D9102F2297;
	Thu,  6 Nov 2025 16:40:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762443646; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zTpK1778ZPo0Zk1DH+IDXFuxbwb9kJMouXvCPWR5ZLc=;
	b=h1DmG9933broA7Ryh6sUIlcQfMGsC5AMkucLe4vzFliajP4VR/8eA9dyR/oom0t9NmufoD
	dNINLKVE6EUvqV9xhYonVQu1bVQOEzoJJTlMRkE3wzG+izuoyet4ZLMGwf3Tlp5eLxKCjx
	L6GZ9gD+cw6L8y4wT+2Dgb1JPaRBMmK/ZUtgHF0AExEpWjifZeoJWdapiumboBuAc21sMT
	ULK9ZojkEAlGaHjGC+FcSAibdLw2ldvaVi+6OyAiT4XE04H2LEZRYHrcUfu3nbaibslc68
	eYztXvvDRhQai4ue1InuYjN4V1VtwMBbglRdUO0JpvAmycmtveHPKBuLytCW3Q==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jan Dabros <jsd@semihalf.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Dmitry Guzman <dmitry.guzman@mobileye.com>, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject:
 Re: [PATCH v2 5/5] i2c: designware: Support of controller with
 IC_EMPTYFIFO_HOLD_MASTER disabled
Date: Thu, 06 Nov 2025 16:40:40 +0100
Message-ID: <2047821.56niFO833r@benoit.monin>
In-Reply-To: <20251103104330.GG2912318@black.igk.intel.com>
References:
 <20251031-i2c-dw-v2-0-90416874fcc0@bootlin.com>
 <20251031-i2c-dw-v2-5-90416874fcc0@bootlin.com>
 <20251103104330.GG2912318@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

Hi Mika,

On Monday, 3 November 2025 at 11:43:30 CET, Mika Westerberg wrote:
> On Fri, Oct 31, 2025 at 03:35:43PM +0100, Beno=C3=AEt Monin wrote:
[...]
> > +/*
> > + * Return true if the message needs an explicit RESTART before being s=
ent.
> > + * Without an explicit RESTART, two consecutive messages in the same d=
irection
> > + * will be merged into a single transfer.
> > + * The adapter always emits a RESTART when the direction changes.
> > + */
> > +static inline bool i2c_dw_msg_need_restart(struct i2c_msg msgs[], int =
idx)
>=20
> This can take const parameters.
>=20
Agreed.

> > +{
>=20
> Please move the dev->flags & NO_EMPTYFIFO_HOLD_MASTER here too.
>=20
Agreed.

> > +	/* No need for a RESTART on the first message */
> > +	if (idx =3D=3D 0)
> > +		return false;
>=20
> That's
>=20
> 	if (!idx)=20
>=20
Ack.

> But why not pass the actual message instead of the index?
>=20
Because we need the direction of the previous message and if we are checking
the first message. Passing the array of messages and the index of the
message to check give us the info we need to perform the check.

> > +
> > +	return (msgs[idx - 1].flags & I2C_M_RD) =3D=3D (msgs[idx].flags & I2C=
_M_RD);
>=20
> You don't need the outer parens.
>=20
> > +}
> > +
> >  static int
> >  i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> >  {
> > @@ -918,6 +958,17 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_m=
sg msgs[], int num)
> >  				goto done;
> >  			}
> > =20
> > +			/*
> > +			 * Make sure we don't need explicit RESTART for
> > +			 * controllers that cannot emit them.
> > +			 */
> > +			if (dev->flags & NO_EMPTYFIFO_HOLD_MASTER &&
> > +			    i2c_dw_msg_need_restart(msg, cnt - 1)) {
> > +				dev_err(dev->dev, "cannot emit RESTART\n");
> > +				ret =3D -EINVAL;
> > +				goto done;
> > +			}
> > +
> >  			if ((msg[cnt - 1].flags & I2C_M_STOP) ||
> >  			    (msg + cnt =3D=3D msgs + num))
> >  				break;
> > diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/=
busses/i2c-designware-platdrv.c
> > index d7d764f7554d..4aad3dc51fbc 100644
> > --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> > +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> > @@ -346,6 +346,7 @@ static void dw_i2c_plat_remove(struct platform_devi=
ce *pdev)
> > =20
> >  static const struct of_device_id dw_i2c_of_match[] =3D {
> >  	{ .compatible =3D "baikal,bt1-sys-i2c", .data =3D (void *)MODEL_BAIKA=
L_BT1 },
> > +	{ .compatible =3D "mobileye,eyeq6lplus-i2c", .data =3D (void *)NO_EMP=
TYFIFO_HOLD_MASTER },
> >  	{ .compatible =3D "mscc,ocelot-i2c", .data =3D (void *)MODEL_MSCC_OCE=
LOT },
> >  	{ .compatible =3D "snps,designware-i2c" },
> >  	{}
> >=20
>=20


Best regards,
=2D-=20
Beno=C3=AEt Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com




