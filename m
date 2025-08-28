Return-Path: <linux-kernel+bounces-789671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB5BB398E5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CAB77AA7E8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873AA26D4FC;
	Thu, 28 Aug 2025 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lQI+mVaC"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335525BF1B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374964; cv=none; b=Pd74xVbBCk9IBenJ0VezthQCZoV9VJO5bVvtywuNKFcJgud3uNF+Y+PNS5cZLawcIrcCBlPgM3Vmq5KJ1YBQcPr3pjyHuqGn3t9/cP4PO0t4wH+5/yia5mo5cX+RWSjmIsweJoDm69oALWyocWtTkvsBWOuWUCF624BEYOXf0Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374964; c=relaxed/simple;
	bh=JMByh91j0k7diDDEyRQ9YG+6I+S1GjYg411+BzH56y8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XHMKJycUbdSFqEbezX9wnbvPMh5F255cp6dAthMvR/yNaStMtM4TggDn744ioUSPQfqVRiW1+ihPhcl2VTt7sySZWGPuwrvHi1EuRinyibzJRIJ7WS9IP97gdEaQcMCnwamMzUIwvlt4d6jM32CEbqiFnpJzAJjk70pHeRH/byQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lQI+mVaC; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 27903C653FE;
	Thu, 28 Aug 2025 09:55:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8353660303;
	Thu, 28 Aug 2025 09:55:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B003F1C22A4EA;
	Thu, 28 Aug 2025 11:55:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756374957; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=t/e+r53Kr2WVs5clJikEqXBawtBTIiBYKx7C79TTHH8=;
	b=lQI+mVaCcrkIvJaKFn1eL0V9AIDlsM1H2Dy4A6KE/J4kybwAFzvlf7u6Xvg/J9XaTpRAVk
	r+4Map0/+BNU/uOi7lRKwfka7erZgdsJUNUe8rz0Wjy2b77ZQIEG5GX/C6irzFH3yCQRT1
	FDsVeLut9a151FghsKWn9YPEJK5qOexsPDEBRExhpKvBnMTXwfkPoMCvoP3EDFcF5ylUtC
	7WqjdcyeXnUFd3r8Wm11UFKF25GHaPvPhXchI2BR/zKXTFpl2xmTJq22QS2Nf7ByvoueMG
	+ECrx+3Qzn6hGBLSI3AgsBf+VzNsArHKinb6Thnkd663uYoOtO+Ix8ptWc+SMA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christian Eggers <ceggers@arri.de>
Cc: Richard Weinberger <richard@nod.at>,  <linux-mtd@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: mtd: rawnand: Inconsistent parameter page on Foresee FSNS8A002G ?
In-Reply-To: <4990592.OV4Wx5bFTl@n9w6sw14> (Christian Eggers's message of
	"Thu, 28 Aug 2025 07:24:48 +0200")
References: <3542795.LZWGnKmheA@n9w6sw14> <87tt1whe19.fsf@bootlin.com>
	<4990592.OV4Wx5bFTl@n9w6sw14>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Thu, 28 Aug 2025 11:55:46 +0200
Message-ID: <87o6rz6a8t.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Christian,

On 28/08/2025 at 07:24:48 +02, Christian Eggers <ceggers@arri.de> wrote:

> Hi Miquel,
>
> On Sunday, 24 August 2025, 18:37:06 CEST, Miquel Raynal wrote:
>> Hi Christian,
>>=20
>
> _______________________________________________________ =E2=80=8B=E2=80=
=8B=E2=80=8B=E2=80=8B=20=20=20
> Christian   Eggers=20=20=20=20=20
> Software Engineer=20=20=20=20=20
> =E2=80=8B=20=20=20=20=20
> ARRI=20=20=20=20=20
> Arnold & Richter Cine Technik GmbH & Co. Betriebs KG=20=20=20=20=20=20
> Arriweg 17 ,  83071   Stephanskirchen=20=20=20=20=20
> www.arri.com=20=20=20=20=20=20
> * +49 8036 3009-3118=20=20=20=20=20=20
>=20=20=20=20=20=20=20=20
>=20=20=20=20=20=20=20=20
> * CEggers@arri.de=20=20=20=20=20=20
> =E2=80=8B=20=20=20
> ALEXA 35 XTREME=20=20
>=20=20=20
> Arnold & Richter Cine Technik GmbH & Co. Betriebs KG=20=20=20
> Sitz: M=C3=BCnchen =E2=80=91 Registergericht: Amtsgericht M=C3=BCnchen =
=E2=80=91 Handelsregisternummer: HRA 57918=20=20=20
> Pers=C3=B6nlich haftender Gesellschafter: Arnold & Richter Cine Technik G=
mbH=20=20=20
> Sitz: M=C3=BCnchen =E2=80=91 Registergericht: Amtsgericht M=C3=BCnchen =
=E2=80=91 Handelsregisternummer: HRB 54477=20=20=20
> Gesch=C3=A4ftsf=C3=BChrer: David Bermbach, Wolfgang B=C3=B6rsig, Christia=
n Richter=20=20=20
> =E2=80=8B=20=20=20
> *
> *
> ALEXA 35 XTREME
>> On 18/08/2025 at 19:02:49 +02, Christian Eggers <ceggers@arri.de> wrote:
>>=20
>> > I try to use a Foresee FSNS8A002G SLC flash chip on an i.MX6 GPMI cont=
roller:
>> >
>> > https://www.lcsc.com/datasheet/C5126835.pdf
>> >
>> > The kernel output looks promising, but one line looks suspicious:
>> >
>> > ...
>> > nand: device found, Manufacturer ID: 0xcd, Chip ID: 0xda
>> > nand: Foresee FSNS8A002G
>> > nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
>> > nand: SDR timing mode 4 not acknowledged by the NAND chip
>> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> > Bad block table found at page 131008, version 0x01
>> > Bad block table found at page 130944, version 0x01
>> > 3 fixed-partitions partitions found on MTD device gpmi-nand
>> > ...
>> >
>> > According to the documentation of "Read Parameter Page", byte 129-130,=
=20
>> > SDR modes 0 to 5 should be supported (page 19 on the data sheet).
>> > But the documentation of the GET_FEATURE/SET_FEATURE operation misses
>> > the "Timing mode" register (data sheet, page 24).
>> >
>> > I saw that there is a quirk for some Macronix chips which also seem
>> > not to support getting/setting the timing mode (but declaring them
>> > in the parameter page).
>>=20
>> Unfortunately, it happens that sometimes flash vendor mess up parameter
>> pages, so either the flash supports mode 5 and it is lying to you (you
>> can test it and add a quirk) or the flash does not because this batch
>> could not stand a faster rate (?).
>
> What does "lying" in this context mean? The message=20
> "nand: SDR timing mode 4 not acknowledged by the NAND chip"
> implies to me, that the flash device doesn't respond to the mode setting
> command. I see 2 possible reasons:
> 1. The mode setting command is not supported (at least it isn't mentioned
> in the data sheet).

Setting a mode requires:
- set_features, to change the value
- get_features, to verify the value has been changed

Normally device which support the former support the latter, but
sometimes they do not. Just get rid of the check manually and make a
test, if that works, the chip is working just fine and you must flag it
as unable to perform a get_features(timings).

See:
https://elixir.bootlin.com/linux/v6.16.3/source/drivers/mtd/nand/raw/nand_m=
acronix.c#L186
(you would only need the get_features() part of this quirk).

> 2. The selected mode is too fast for the flash/PCB, so the response from
> the flash is not correct received by the CPU.

I don't believe so.

>
> Would it make sense, trying to reapply the current mode (0) first in order
> to confirm that the flash supports the mode setting opcode at all?

Commenting out the check and using the chip at this speed sounds more
relevant IMO.

Thanks,
Miqu=C3=A8l

