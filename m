Return-Path: <linux-kernel+bounces-732958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADC8B06E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EE64A4918
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCEC28850E;
	Wed, 16 Jul 2025 06:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5U+yqJq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184AF946C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752648367; cv=none; b=KPwrinYcFO0E23qgIS8s4Zd1URjdTEM+xT5e0udXMZb6jWbmmIHQ3gqH2DuS1F5MkY+4ZrmN/TLuVjqYioUKk7ipjE/NSwJK262glWkNgHmtZhrKelvBsYSWR9/exlxPOlRZ2kcv4icoRRF02gxNKt3MXwjpgnAF0ZYbQLz1jGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752648367; c=relaxed/simple;
	bh=iKfK3+PzlLbOhq0cMRSj3biqoDLG7uZW/NNlE7tRa1U=;
	h=Content-Type:Date:Message-Id:Subject:From:To:References:
	 In-Reply-To; b=rM5JN2rcFHrvdVGgFRaHY0uK45jJc/1dZLuLsT4rmGOOJoDYsImIZFIIm2JKR4omViBnZ92IWkg54Jj2ixunExnu7XP3wn4jI5h/liaD6D7JsCmsqRe6Mh1vdDbJfBwxTkb6mrnmw7QU4QTB9a3uI7YNfvLIUiH5upJ5lDL2C5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5U+yqJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387F0C4CEF0;
	Wed, 16 Jul 2025 06:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752648366;
	bh=iKfK3+PzlLbOhq0cMRSj3biqoDLG7uZW/NNlE7tRa1U=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=B5U+yqJqWMjd0vIsc7sqEMn6ojST79WbIkA2mK0xPRQomhJ68mkFXQERMkVWGcNnu
	 KTDKGUXDEBYu9MmCJwDF7QLQ1gO9yfpLx+j5/SQbau4ynzDiDmILXNLI8v7Lw9VRCv
	 aTc+XLBGx6pELMNOPv3/1uZLQggDrGscJYWcnnvG4RG+5ynb4lwhheW6Jnp3TymY6T
	 V1dd3ZTQqkSjTVl6cjmiTvWtuqt9CZo3E3yvlkjpCT6Led5vEVgr1O5VpW9wCPYd1z
	 YKhXsnj4/d3abhlmInM96QdGxgDnZF/+r5AnoAkzW/Ekz7jb/YwbTZqDFwV2FD3qVJ
	 aTW/luntXY9PA==
Content-Type: multipart/signed;
 boundary=aacedfba284be24d50cf86206b89b6cc0845da34b5ffa309b922fc4abfd4;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 16 Jul 2025 08:46:02 +0200
Message-Id: <DBD9ZQ7GV4YY.PLA885RZGBDV@kernel.org>
Subject: Re: [PATCH 1/1] mtd: spi-nor: core: Prevent oops during driver
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
References: <cover.1752024352.git.khairul.anuar.romli@altera.com>
 <e439e6b85e650a91607a1d02d5d432d096363315.1752024352.git.khairul.anuar.romli@altera.com> <DB7LJZF3AZQJ.2I5EWYORV6K33@kernel.org> <BY5PR03MB5299D68304D916F466837E6BC657A@BY5PR03MB5299.namprd03.prod.outlook.com>
In-Reply-To: <
 <BY5PR03MB5299D68304D916F466837E6BC657A@BY5PR03MB5299.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--aacedfba284be24d50cf86206b89b6cc0845da34b5ffa309b922fc4abfd4
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue Jul 15, 2025 at 9:53 AM CEST, Khairul Anuar Romli wrote:
> > > -     module_put(dev->driver->owner);
> > > +     if (dev && dev->driver && dev->driver->owner)
> > > +             module_put(dev->driver->owner);
> >=20
> > Why is dev->driver or dev->driver->owner NULL in the first place?
>
> When we remove/unbind the the spi node during busy, we will hit
> with dev->driver and dev->driver->owner NULL derefence.

Yes, but my question was why is this the case? I.e. why is
dev or dev->driver NULL?

-michael

--aacedfba284be24d50cf86206b89b6cc0845da34b5ffa309b922fc4abfd4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaHdKqhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jVTgF/UO2wa/lmVXWwv43pSVeadon8S3D55ftB
YDydFXlZvIlZ75h8RM350isKsxQoGuW7AYD1/m3cXykykltW6jeYuPIUAgRi70sH
FgzIbNteXSan9k1Lnds1T0algwwgjVymV9k=
=bbTo
-----END PGP SIGNATURE-----

--aacedfba284be24d50cf86206b89b6cc0845da34b5ffa309b922fc4abfd4--

