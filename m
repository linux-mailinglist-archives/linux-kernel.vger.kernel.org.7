Return-Path: <linux-kernel+bounces-750319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EF4B159FE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F8218A790B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD1E25291C;
	Wed, 30 Jul 2025 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvA8XYOV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2612AD04
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861812; cv=none; b=Uoz4I9XDy0CB1SfSBMxBTpny/Z0BXJ1+F6eL+aEuy8LU8vcB4FWkkJeM76zF68GeULDX1nWUfm1q4TGiKbaHhNFIXxMsJf7nzsquNX4JXmrCti2nsX/GpuxiTuVdnlNJGQJu9ofA41PMGpacAzd0McjNEnvxynw517oNDOsIMs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861812; c=relaxed/simple;
	bh=llkTTSSb1pWC5NKP4Fk4+twpg7noYOtrZveBau2sYNQ=;
	h=Content-Type:Date:Message-Id:From:To:Subject:References:
	 In-Reply-To; b=Qttt7ZiQrF40fkHlidVtIS47ZdsSg4gxWK5tdeoeJSW6uCs4wQHCd7BTzAXyxvwKnUE/R2G5V4g9wzgE9KVO+jyhIKHK+QQqQwluFpX9nSPuwaSKtmC6NMHRjUD5zxPN9JZasxQ2bWDewdq/aXoWaHqMQWtfBLvyQjean4VI2c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvA8XYOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550ECC4CEE7;
	Wed, 30 Jul 2025 07:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753861811;
	bh=llkTTSSb1pWC5NKP4Fk4+twpg7noYOtrZveBau2sYNQ=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=uvA8XYOVgvraogn6iuTtQ+6zAdxA5lbpselzkNOxtvuqbDK5/afAKiLJ2bGpI8gqH
	 EpNoTInmr89AYqeQN8bxneifsB4W/9uv+AmW89COXBwNL7QInejhkX++VclD82l5Vi
	 BYqzKKnm9j1L/1Sgjh/OHoaBdPlbtPRQ9gIlODi5k60SJaXmwTxpzj1sJ4pdsb9w63
	 kQ5GHxgkmjJtEMAO01x1v1tVrAelnW7HcwR1O/uvHXarYbO/QXIia0sKccMGY9CIGn
	 2dc/EQIYDyUXkWxFHUkBh4O8zPjrvup5SZsAKpZMIL9csbCF0wWGsP9pOc4cs+RGcb
	 yTzOi+DIrDSpg==
Content-Type: multipart/signed;
 boundary=99fb83cfe9f1b040616eee98db2a26457cc9abe94febc53acebc3946379d;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 30 Jul 2025 09:50:07 +0200
Message-Id: <DBP84FIUUQO7.369TFNTJFELMW@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "open list:SPI NOR SUBSYSTEM"
 <linux-mtd@lists.infradead.org>, "open list"
 <linux-kernel@vger.kernel.org>, "Gerlach, Matthew"
 <matthew.gerlach@altera.com>
Subject: Re: [PATCH v3 1/1] mtd: spi-nor: core: Prevent oops during driver
 removal with active read or write operations
X-Mailer: aerc 0.16.0
References: <cover.1753839339.git.khairul.anuar.romli@altera.com>
 <566fc1168db723672ab0bc6482ec7b72b4b8fe2b.1753839339.git.khairul.anuar.romli@altera.com> <DBP7P3RWX17B.14Q27IBS3T3FL@kernel.org> <MN2PR03MB49271E2D022D305BC149BA4FC624A@MN2PR03MB4927.namprd03.prod.outlook.com>
In-Reply-To: <
 <MN2PR03MB49271E2D022D305BC149BA4FC624A@MN2PR03MB4927.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--99fb83cfe9f1b040616eee98db2a26457cc9abe94febc53acebc3946379d
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> > On Wed Jul 30, 2025 at 3:39 AM CEST, Khairul Anuar Romli wrote:
> > > From: kromli <khairul.anuar.romli@altera.com>
> > >
> > > Ensure that the pointer passed to module_put() in spi_nor_put_device(=
)
> > > is not NULL before use. This change adds a guard clause to return
> > > early, preventing the kernel crash below when the cadence-qspi driver
> > > is removed during a dd operation:
> >=20
> > As already asked in v2. This needs a (more detailed) description what i=
s going
> > on and what is going wrong.
> >=20
> > -michael
>
> Hi,
>
> We just run the following test we observe the crash.=20
>
> time dd if=3D/dev/mtd1 of=3Dout.img bs=3D1MB count=3D1000 &
> echo spi0.0 > /sys/bus/spi/drivers/spi-nor/unbind
> echo spi0.0 > /sys/bus/spi/drivers/spi-nor/bind
>
> From the observation, the dd is not entirely terminated when the unbind t=
ook place.
> Maybe there is other changes require to ensure the dd operation gets term=
inated=20
> when driver unbind/remove.

I'd expect an analysis what's going wrong in the kernel to judge the
correctness of the patch.

Thanks,
-michael

--99fb83cfe9f1b040616eee98db2a26457cc9abe94febc53acebc3946379d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaInOsBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hjHwF5ARhAj8UFrx75UjliawDdPaSRz+IQCzNC
dDPlqt4bsUdb7YgPK+Z2tyqlyrgKntO3AYDNBrB3RaFAs1UEjL+oTF8aE6oTwySK
VEOM+Gy0gAwWaJXKTfc9ODW3mqg+epBJ8xM=
=3sUL
-----END PGP SIGNATURE-----

--99fb83cfe9f1b040616eee98db2a26457cc9abe94febc53acebc3946379d--

