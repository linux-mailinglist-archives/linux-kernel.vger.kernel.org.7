Return-Path: <linux-kernel+bounces-779054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4B3B2EE7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F355E009F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2F92E7196;
	Thu, 21 Aug 2025 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOs7W9fM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132662E266E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758702; cv=none; b=anixuf+on1EZ00HjACdjppgshHobiyuA8ihGPaMc6UTG2/1bmGJbu3wCADvEhcXCrWpD/ICzwlgV4nk2lQg0rtxYkx0YPJ5OiEuicOv3JaGetkwa0J0+xAqQdeIXpGGu/vBTI5j0D4rhxWcFqKMWVAFRehLrb8H0hiixIjGWo9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758702; c=relaxed/simple;
	bh=limPWQWRS82UE9S5O0lLb4msGufN3y2kIqx6S5HAEJI=;
	h=Content-Type:Date:Message-Id:Subject:From:To:References:
	 In-Reply-To; b=UW4JPnK1DqtIK76EMdgWm1fcTEAdaSHvT+fL62Bu0aT9Ak9e14y146MWfpPwQdScDjrAqrfjIlM+WzZ7r2pnX5c4IdYfMglI4AtVjMAe16aXM9RT336Odilmz/wtAazZUHadJpB6GhcmcBZS7Gu72WNrm6V2h+wlDQpdnmRR2gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOs7W9fM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AF1C4CEED;
	Thu, 21 Aug 2025 06:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755758701;
	bh=limPWQWRS82UE9S5O0lLb4msGufN3y2kIqx6S5HAEJI=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=lOs7W9fMzeq5uO555itwKY1W9TAJ6BjkCZwElhJmcO13hAHQPGaouIkIrnyKHFqrJ
	 l8C3PJfb9HS0ENGch9FIozeWQMITmjq2R4tBBr3hOsYwsK2Z0H+eHeSInsjiB0EYED
	 N5V+9Nv1evyBMKoqW/InMxHTSDRRja3qbSSTNP8gYfqP8Qauc2aEiE4pKvaOqWsIyk
	 hniJdJkyRqrsAVYmFqheqUNpWr0y51PGRJizdq56UUMT+dONGAw+yj3CakduZ9iMvn
	 8l8xSDIAT4/hd21bB7i+J4meKPdmidxv16LRXPrRZjRqvWGOrrSoZIm0TV22FahCy5
	 lIRGmyXjtrF6w==
Content-Type: multipart/signed;
 boundary=030571e0ecaeb27a9a0dae0023b5712f16fb971faa06dab3bc8b8719f87f;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 21 Aug 2025 08:44:57 +0200
Message-Id: <DC7WIIFZQ448.3RW1U45I41129@kernel.org>
Subject: Re: [PATCH v3 1/1] mtd: spi-nor: core: Prevent oops during driver
 removal with active read or write operations
From: "Michael Walle" <mwalle@kernel.org>
To: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "open list:SPI NOR SUBSYSTEM"
 <linux-mtd@lists.infradead.org>, "open list"
 <linux-kernel@vger.kernel.org>, "Gerlach, Matthew"
 <matthew.gerlach@altera.com>
X-Mailer: aerc 0.16.0
References: <cover.1753839339.git.khairul.anuar.romli@altera.com>
 <566fc1168db723672ab0bc6482ec7b72b4b8fe2b.1753839339.git.khairul.anuar.romli@altera.com> <DBP7P3RWX17B.14Q27IBS3T3FL@kernel.org> <MN2PR03MB49271E2D022D305BC149BA4FC624A@MN2PR03MB4927.namprd03.prod.outlook.com> <DBP84FIUUQO7.369TFNTJFELMW@kernel.org> <MN2PR03MB4927D29E06586CCE7D0547FEC632A@MN2PR03MB4927.namprd03.prod.outlook.com>
In-Reply-To: <
 <MN2PR03MB4927D29E06586CCE7D0547FEC632A@MN2PR03MB4927.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--030571e0ecaeb27a9a0dae0023b5712f16fb971faa06dab3bc8b8719f87f
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu Aug 21, 2025 at 2:32 AM CEST, Khairul Anuar Romli wrote:
> Sorry for taking very long time to reply. Could you advise me what
> kind of analysis do you want me to provide?

Please don't top-post, see [1]. An explanation what is going wrong
and why (and no, a backtrace is not an explanation). Why is
dev->driver->owner NULL? Shouldn't it be guarded by a lock or
something? And esp. why is owner NULL in put_device().

-michael

>
> > -----Original Message-----
> > From: Michael Walle <mwalle@kernel.org>
> > Sent: Wednesday, 30 July, 2025 3:50 PM
> > To: Romli, Khairul Anuar <khairul.anuar.romli@altera.com>; Tudor Ambaru=
s
> > <tudor.ambarus@linaro.org>; Pratyush Yadav <pratyush@kernel.org>; Mique=
l
> > Raynal <miquel.raynal@bootlin.com>; Richard Weinberger <richard@nod.at>=
;
> > Vignesh Raghavendra <vigneshr@ti.com>; open list:SPI NOR SUBSYSTEM
> > <linux-mtd@lists.infradead.org>; open list <linux-kernel@vger.kernel.or=
g>;
> > Gerlach, Matthew <matthew.gerlach@altera.com>
> > Subject: Re: [PATCH v3 1/1] mtd: spi-nor: core: Prevent oops during dri=
ver
> > removal with active read or write operations
> >=20
> > Hi,
> >=20
> > > > On Wed Jul 30, 2025 at 3:39 AM CEST, Khairul Anuar Romli wrote:
> > > > > From: kromli <khairul.anuar.romli@altera.com>
> > > > >
> > > > > Ensure that the pointer passed to module_put() in
> > > > > spi_nor_put_device() is not NULL before use. This change adds a
> > > > > guard clause to return early, preventing the kernel crash below
> > > > > when the cadence-qspi driver is removed during a dd operation:
> > > >
> > > > As already asked in v2. This needs a (more detailed) description
> > > > what is going on and what is going wrong.
> > > >
> > > > -michael
> > >
> > > Hi,
> > >
> > > We just run the following test we observe the crash.
> > >
> > > time dd if=3D/dev/mtd1 of=3Dout.img bs=3D1MB count=3D1000 & echo spi0=
.0 >
> > > /sys/bus/spi/drivers/spi-nor/unbind
> > > echo spi0.0 > /sys/bus/spi/drivers/spi-nor/bind
> > >
> > > From the observation, the dd is not entirely terminated when the unbi=
nd
> > took place.
> > > Maybe there is other changes require to ensure the dd operation gets
> > > terminated when driver unbind/remove.
> >=20
> > I'd expect an analysis what's going wrong in the kernel to judge the co=
rrectness
> > of the patch.
> >=20
> > Thanks,
> > -michael

[1] https://subspace.kernel.org/etiquette.html

--030571e0ecaeb27a9a0dae0023b5712f16fb971faa06dab3bc8b8719f87f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaKbAaRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/i0AAF/TEoMr4W7YmQFJcoQEnP9+hkbiBM7Kuxq
1sC33x9rbxIUAhJKM2ekjOz/a8Zy27IhAYD6QoVjyIYBKQGMvI1YkekQaZnXJHXw
CphM5+Of64+HjUY2giF6c7dHSGOi74d4KKE=
=0u7V
-----END PGP SIGNATURE-----

--030571e0ecaeb27a9a0dae0023b5712f16fb971faa06dab3bc8b8719f87f--

