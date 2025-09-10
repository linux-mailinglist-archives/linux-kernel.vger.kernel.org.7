Return-Path: <linux-kernel+bounces-810429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D17D3B51AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30537A016EC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E72E2517B9;
	Wed, 10 Sep 2025 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WohuC0LW"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABBD2222C0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515543; cv=none; b=O9KjGBrsGE6DZywbhF+zqDV3v23GXl8KkqV7Leh2779xAsq9xv6pwRCdvqwK1/LL+fUHMeRY68Rwap0AUGobwpwrFbue36O0aF7oDVDwtPdcMmrpM4QgCXfBr8RxfP0JeT5H2T53H3qP9Kx7GEGbTV2pOnXgRyz2T8zSIv1Kp2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515543; c=relaxed/simple;
	bh=kjdiZvN67xepLNCpV7oSJp/V0e7Qf4qknQ87RT8O3vg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mEy70R58M6HtO+MvVkg0nrhqjY/RyqmzXUt1SqdQ0a5VK26E77SPuRfY2UmOfAi0Up8xvlJfa3LPh+7Pu7yAG0LVEkk5e47zalyYscawc7lVQpfsqunrDnu4JlMYAkxyLCAjyusAaYhrhkQX0m1yARBcCtV/PH9Pxc6Yszw8IIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WohuC0LW; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9F9671A0D5A;
	Wed, 10 Sep 2025 14:45:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 86590606D4;
	Wed, 10 Sep 2025 14:45:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9AB50102F2884;
	Wed, 10 Sep 2025 16:45:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757515537; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yot0d5/bHGrsIZR1cYh+Nq5eBvh863Ov45/WQoG5A+I=;
	b=WohuC0LWq+fsvqCaFfYbPMIUZjdkl4ni6kJn+6pymnaxBeI8a3Wm3fdE5xcBwBgCKrDc4g
	q4m9BGEFQVGBQ2ODCBNgJ9YfJvpNgigl2B3BEazFHA9brmWrq9mV1lDf16pN/WTrAM1oR2
	LbvcT3fGgoYGEW0864QEFu/LMR8/Yx1qCB+oFZveftQRSmBfHF+VbrrP0Sm3xp/nOEudO7
	FrdQQ8tyf6eoWwTQryCx1Wkl2y9U0UoTMIRmBr2EQKK0GZ80hjoMyODQipkiJbwx8FWSlS
	LgbWm9zDdRZc9hPncaxqCwAWLb5lCnlAA0RCyOkCkoz88WAsWpE14XnR0g7luQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Jakub \"Kuba\" Czapiga" <czapiga@google.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,  Konrad
 Adamczyk <konrada@google.com>,  Adeel Arshad <adeel.arshad@intel.com>,
  Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] mtd: spi-nor: core: Check read CR support
In-Reply-To: <CABkukdpRxHFg9FbaV1GnS5UG3-ZxdxPbjKYdUpdmvOcLs5phKA@mail.gmail.com>
	(Jakub Czapiga's message of "Wed, 10 Sep 2025 16:30:43 +0200")
References: <20250910103355.629421-1-czapiga@google.com>
	<87frcucy3p.fsf@bootlin.com>
	<CABkukdpRxHFg9FbaV1GnS5UG3-ZxdxPbjKYdUpdmvOcLs5phKA@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Wed, 10 Sep 2025 16:45:28 +0200
Message-ID: <87a532cqnr.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 10/09/2025 at 16:30:43 +02, "Jakub \"Kuba\" Czapiga" <czapiga@google.com=
> wrote:

> Hi Miqu=C3=A8l,
>
> On Wed, Sep 10, 2025 at 2:05=E2=80=AFPM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
>>
>> Hi Jakub,
>>
>> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> > index ac4b960101cc..79deee3a50d3 100644
>> > --- a/drivers/mtd/spi-nor/core.c
>> > +++ b/drivers/mtd/spi-nor/core.c
>> > @@ -2608,6 +2608,10 @@ static int spi_nor_setup(struct spi_nor *nor,
>> >               }
>> >       }
>> >
>> > +     /* Some SPI controllers might not support CR read opcode. */
>> > +     if (spi_nor_read_cr(nor, nor->bouncebuf) =3D=3D -EOPNOTSUPP)
>>
>> There is a spi_nor_spimem_check_op() helper which might be better suited
>> for this purpose?
>
> spi_nor_spimem_check_op() works only for spi-mem devices. spi_nor_read_cr=
()
> handles both spi-mem and spi-nor controller. Using spi_nor_spimem_check_o=
p()
> would require adding a variation of spi_nor_read_cr() that would use
> spi_nor_spimem_check_op() for spi-mem and spi_nor_controller_ops_read_reg=
()
> for spi-nor controller.
> Another way would be to do this check only for the spi-mem as spi-nor
> controllers seem to be deprecated in favour of spi-mem.

I'll let that choice to SPI NOR maintainers but we've collectively asked
to switch in favor of the spi memory API for quite some time, I would
not care too much about compatibility with the two remaining controllers
that have not yet been converted.

But here is a proper illustration why spi-mem rocks and why SPI NOR
controllers, besides making no sense (because we also have SPI NANDs
now) have a flacky API as of today's standards.

Thanks,
Miqu=C3=A8l

