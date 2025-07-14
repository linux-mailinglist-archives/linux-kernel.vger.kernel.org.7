Return-Path: <linux-kernel+bounces-729526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C592B037E0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922C41897EB0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92FA233739;
	Mon, 14 Jul 2025 07:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="GFWtZe1Y"
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67966233714
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752477913; cv=none; b=PnIpUyoy7x9hwk6CIfeUjnxxTqvPLR6yIZ6XW9J/FHz77fqyZyD1Es+XKveAw8K2s5VqmbojBg1FtdFLiaHIyldoDSwFwxY34lG3yGtzGi4nd+vCD00OVPBcRAy/LGP4uqoqXTf1qWBHPUZ3TOf9f2AC3NXcLRX+safrP2jC9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752477913; c=relaxed/simple;
	bh=VS57y2OBSSO+rWrswC7/K7piqJT6Hks2jXVIQBEasUs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnF0PVfNClWEWIXhuC5b3Z2niBtYYZ46gGHZEATgAYvAtLoBwePbp3XZRRSeFSiSe2L9iVDgNT8wdBe0K5e7TzJQzRQGqwK37sY3vzcZmrgWYczF9xWwIBeeydbKMZ5/V423FHwcYwhKyJBfhT29qzYVJRiaBTGqi1be2fccKeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=GFWtZe1Y; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752477904; x=1752737104;
	bh=u3s5VDyk7wpkXLKq6wDm6MTLrrItnjf/ovCUks1WDNk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GFWtZe1YYJ+e1TFUWPxdpteAT4A60+pQb62P0KVaE9bqy07mpiuvv/GAmWzbLcCo2
	 X4bzTmXdg5R42HXvU5ztPXbNrnyT7e1rFpSWQkz700SizfKDg1tCtM10/NM50OusDv
	 05I4emoq8hEbuL6tTm60awkhAmgXZrVpWC8KeEjDSeQOheWKfh/VpcnmtIHR6aqRKf
	 MuQM/mBEVO8vGEp4I8GRYTHz+bPl3KdIv8vvG7K2gtZk/OG3UaqhC20i6tgRFSUaVk
	 fyC2YJt4XBMYi2/tLDXd1RdkS1bh4i1X3Il/+PdtaZTdMzW4gxutu3fu9ovKY2aKpj
	 teCLp8rJfEScQ==
Date: Mon, 14 Jul 2025 07:24:57 +0000
To: Jonathan Cameron <jic23@kernel.org>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] iio: imu: inv_icm42600: Simplify pm_runtime setup
Message-ID: <ie3zr2mvuss2f7prksw6nuc3wonig5ju6y6hqq46upvkhovwpa@vtfc3tqwz3d5>
In-Reply-To: <20250713152810.4483c786@jic23-huawei>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com> <20250709-icm42pmreg-v1-4-3d0e793c99b2@geanix.com> <20250713152810.4483c786@jic23-huawei>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 6e0d97c038b625d3e8068a776533457afa012dd9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 03:28:10PM +0100, Jonathan Cameron wrote:
> On Wed, 09 Jul 2025 14:35:12 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:
>=20
> > Remove unnecessary pm_runtime_get_noresume() and pm_runtime_put()
> > calls during probe. These are not required when the device is marked
> > active via pm_runtime_set_active() before enabling pm_runtime with
> > pm_runtime_enable().
> >
> > Also remove the redundant pm_runtime_put_sync() call from the cleanup
> > path, since the core is not incrementing the usage count beforehand.
> >
> > This simplifies the PM setup and avoids manipulating the usage counter
> > unnecessarily.
>=20
> Could we switch directly to using devm_pm_runtime_enable() for this drive=
r?
>=20
> At first glance looks like this code is missing the disable of autosuspen=
d
> that should be there (which devm_pm_runtime_enable() will also handle).
>=20

I have tried to use devm_pm_runtime_enable() but on rmmod it warns
"unbalanced disables for regulator"

If I remove this:
-=09ret =3D devm_add_action_or_reset(dev, inv_icm42600_disable_vddio_reg, s=
t);
-=09if (ret)
-=09=09return ret;

Everything seems okay again. I have checked with printk's that
inv_icm42600_disable_vddio_reg() is called twice with
devm_pm_runtime_enable() used.
Does it make sense?

/Sean

>=20
> >
> > Fixes: 31c24c1e93c3 ("iio: imu: inv_icm42600: add core of new inv_icm42=
600 driver")
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> >  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_core.c
> > index 55a29b1e2b11355598b0ede7af22857aed3ae134..1072bea11c73d09a9a0e6ea=
9d4a5c7a72248dca7 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> > @@ -708,7 +708,6 @@ static void inv_icm42600_disable_pm(void *_data)
> >  {
> >  =09struct device *dev =3D _data;
> >
> > -=09pm_runtime_put_sync(dev);
> >  =09pm_runtime_disable(dev);
> >  }
> >
> > @@ -806,11 +805,10 @@ int inv_icm42600_core_probe(struct regmap *regmap=
, int chip,
> >  =09ret =3D pm_runtime_set_active(dev);
> >  =09if (ret)
> >  =09=09return ret;
> > -=09pm_runtime_get_noresume(dev);
> > +
> >  =09pm_runtime_enable(dev);
> >  =09pm_runtime_set_autosuspend_delay(dev, INV_ICM42600_SUSPEND_DELAY_MS=
);
> >  =09pm_runtime_use_autosuspend(dev);
> > -=09pm_runtime_put(dev);
> >
> >  =09return devm_add_action_or_reset(dev, inv_icm42600_disable_pm, dev);
> >  }
> >
>=20


