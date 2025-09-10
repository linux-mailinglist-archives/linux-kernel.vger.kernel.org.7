Return-Path: <linux-kernel+bounces-809865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77D0B512FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC0D07AD8CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF5F314A8C;
	Wed, 10 Sep 2025 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rrQ8eJRB"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626C63148D1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497421; cv=none; b=mQh13lH1MF9gHZ6bggiMQm12WX9JI7xSFvM3IMvxRVI9oEo7xfF4boqEWh4+5nnF3unKm4wzvK1fbkJQOs/7apsXxSjqzLLRq978zRE+ukM92exd66ywJbw0ORwTC2h4Tv3l4Q2UeYtqkD7aWUu8YgmuXldltWW5HBNEESIiHsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497421; c=relaxed/simple;
	bh=ycCd22T4m/F1uyniOWuiwZbkpIKC/S7twGq3wTOIiho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WfdmJ4RVNzhOWn/FS/0ADUFXByvrVbEb6Rg2xKxy0aE4Li21kQDykhec156zs6aYUcyHw4qlzOZ3zVU3WDxw2q+RuJPH+u3Y5Db1rHRqpZyv0pLOD4Nh7Xa3s5lr3WbP1vPhora2mbkBsca47Y4qn1KWW1lzKS2q1Zkc1D180fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rrQ8eJRB; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C9B7DC8F1C3;
	Wed, 10 Sep 2025 09:43:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 80832606D4;
	Wed, 10 Sep 2025 09:43:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C3EC2102F2888;
	Wed, 10 Sep 2025 11:43:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757497416; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2S/DldGiyms7PYoDD6rDyYTN86fmzaucXIEEpvB0vHQ=;
	b=rrQ8eJRBp8qxEvDt/71iTHLE1NFWOSSJdJKGCNGiAcBZcihhbEA9rGsqW8T/xk/k9Rm6ql
	FtHRE4d1rAzeSY2XVI13jrWb3iZOeVWxd5+c5tXrL0KYdPJQZNZYAA4X1JGmAJ/x+9u2HU
	+7F1DKkYicid6ejufBE/c3/pFHuaWgX9XI3x2hrkWEfGaE29G4MKRAFq0vzn4rpotgzjWy
	mpFu7WGx322/8GqBZ4tD3pTZPtrGO+vsOeVOt9M0HWm4p1k2tB1L5+e5KC1p3FQdmu1Cl7
	aC2rKJM/105Hvb/WtbJhNhXK03sJl85XGui4103fZJCzxraQQebAQRz8Wpz8yg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: richard@nod.at,  vigneshr@ti.com,  robh@kernel.org,  krzk+dt@kernel.org,
  conor+dt@kernel.org,  tudor.ambarus@linaro.org,
  mmkurbanov@salutedevices.com,  Takahiro.Kuwano@infineon.com,
  pratyush@kernel.org,  linux-mtd@lists.infradead.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  alvinzhou@mxic.com.tw,  Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH v2 3/3] mtd: spi-nand: macronix: Add randomizer support
In-Reply-To: <CAAyq3SamY9vjQubd0BjpLb7J_W6JfKyyd987y+UioMV7UQ=94Q@mail.gmail.com>
	(Cheng Ming Lin's message of "Wed, 10 Sep 2025 17:26:13 +0800")
References: <20250910030301.1368372-1-linchengming884@gmail.com>
	<20250910030301.1368372-4-linchengming884@gmail.com>
	<87qzwed62q.fsf@bootlin.com>
	<CAAyq3SamY9vjQubd0BjpLb7J_W6JfKyyd987y+UioMV7UQ=94Q@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Wed, 10 Sep 2025 11:43:14 +0200
Message-ID: <87ldmmd4nh.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 10/09/2025 at 17:26:13 +08, Cheng Ming Lin <linchengming884@gmail.com> w=
rote:

> Hi Miquel,
>
> Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2025=E5=B9=B49=E6=9C=
=8810=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:12=E5=AF=AB=E9=81=93=
=EF=BC=9A
>>
>>
>> > +static int macronix_set_randomizer(struct spinand_device *spinand)
>> > +{
>> > +     struct spi_mem_op exec_op =3D SPINAND_PROG_EXEC_1S_1S_0_OP(0);
>> > +     struct nand_device *nand =3D spinand_to_nand(spinand);
>> > +     struct device_node *dn =3D nanddev_get_of_node(nand);
>> > +     int randopt, ret;
>> > +     u8 cfg, status;
>> > +
>> > +     ret =3D spinand_read_reg_op(spinand, MACRONIX_FEATURE_ADDR_RANDO=
MIZER, &cfg);
>> > +     if (ret)
>> > +             return ret;
>> > +     if (cfg)
>> > +             return 0;
>> > +
>> > +     cfg =3D MACRONIX_CFG_ENPGM | MACRONIX_CFG_RANDEN;
>> > +     randopt =3D of_property_read_bool(dn, "mxic,randopt");
>>
>> Isn't that a leftover?
>
> The property "mxic,randopt" corresponds to bit2 of the configuration
> register 0x10. Its purpose is to control whether the randomizer also
> covers the initial portion of the spare area.

Do we need a DT property for that?

In any case, it must be declared in the bindings (which I do not think
it is?).

> Since the randomizer feature is only documented in Macronix datasheets,
> it is not clear whether the "randopt" bit is used by all vendors. For
> this reason, the handling is placed inside macronix.c.

Didn't we discuss in the past of a volatile version for SPI NAND
devices? I thought we could use a volatile approach instead.

Thanks,
Miqu=C3=A8l

