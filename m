Return-Path: <linux-kernel+bounces-747537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99776B134EA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDFD1897F78
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB5E21ADC5;
	Mon, 28 Jul 2025 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1siwN/A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD9B8821
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753684382; cv=none; b=njoeghUVelpt90J0tdn7i7q+zIxqeoWqAcdnTjKfxiQ+8xQTGC7JQSlElYG9jhuo6NjmTKroWeYlPmW/6ANRT9ZW546AlitQgLeXC9LcGeMqH4dTq/8BS7Uzof04qRAfViCatWXdcDPxALE4FqWrD/3UIqeDP6QJuZUhisYr1JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753684382; c=relaxed/simple;
	bh=K4Bmq3xPhvDgkAu6fzp61axct5xS8LWojEAY59LKeG4=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=fIkOt60h3g08EqLNTKhqioDjdbhEAJgYSwojkRYL6W8SKlt0iqxZFBFEC8sqAF+5wcpRhUewrC8jwq8BJVUGLMHG2X18oxPSgKlWSOnZQB6ULXqKCmteDlYCy334KddkQ5YAOBL2EdOD3o3Y1AGr2sN668sh9elOuVdJqnBiy54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1siwN/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280D8C4CEE7;
	Mon, 28 Jul 2025 06:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753684381;
	bh=K4Bmq3xPhvDgkAu6fzp61axct5xS8LWojEAY59LKeG4=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=Z1siwN/AY6Adk9JPdKCM6hHqt5adql2vPlwoTFb1AcdJ1rJDBPyHLC0xE8nQQZZQ1
	 d35kk86QuTWnD/l15jp+wVr9l1a8pfgLto/62ATH81iHCI1PNG8fvnX0EgNEwQJnAG
	 eWBc1WmQFFZUXRiLhunxHabIeQxlrvywV6nYfJaYJ5ebJAXzQVfjMnwWVWizRcvEo0
	 9g2l8fM1ZiydYeglqsB+zDLMuO4c1PbFPgnof3FTn57I0VlEEqZa30YQPF3yR72dpo
	 Olf6BV1j8e0hPHp/QQa9vW3VIQ2qKclyT0D2iKaREDcgB4H9awsHPmNEVJDgDt3jTp
	 Kzl+eXzFVM4iA==
Content-Type: multipart/signed;
 boundary=fd11ad08ce12bebac6607f5852f9e8f7f714528d81476904b87071075ca2;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 28 Jul 2025 08:32:55 +0200
Message-Id: <DBNH88949QTH.3I3MSOA019UJL@kernel.org>
Subject: Re: [PATCH v2] mtd: spi-nor: winbond: Add support for W77Q51NW
Cc: <linux-mtd@lists.infradead.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Pratyush Yadav" <pratyush@kernel.org>,
 "Richard Weinberger" <richard@nod.at>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Vignesh Raghavendra" <vigneshr@ti.com>,
 <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Marek Vasut" <marek.vasut@mailbox.org>, "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>
X-Mailer: aerc 0.16.0
References: <20250721202257.83936-1-marek.vasut+renesas@mailbox.org>
 <9eabfe619554cbdd493086dcffef8f44@kernel.org>
 <62383ff7-0a14-4f15-818b-f5e5c56332c5@mailbox.org>
 <DBJ86H8MDFNX.2Y6T55E0NH63R@kernel.org>
 <0d0cd3cb-61e5-4ec6-958b-ec48b82429bf@mailbox.org>
In-Reply-To: <0d0cd3cb-61e5-4ec6-958b-ec48b82429bf@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--fd11ad08ce12bebac6607f5852f9e8f7f714528d81476904b87071075ca2
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

> >> I have limited supply of these devices, so OTP is untested. The flash
> >> does have OTP registers, that's why the .otp entry is there. Why shoul=
d
> >> I remove it if the OTP registers are in the chip ?
> >=20
> > We only add tested features. I'm just the messenger here :o. Anyway,
> > OTP is not really one-time-programmable here, you can write and
> > erase it again as long as you don't lock it, if that was your
> > concern.
>
> So how do I test the OTP without locking it ?

flash_otp_{write,info,dump,erase}, just don't use flash_otp_lock.

-michael

--fd11ad08ce12bebac6607f5852f9e8f7f714528d81476904b87071075ca2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaIcZmBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hQxAF7BpIRkqGDrx1GJOllCbP0wy0qHAg4813O
BSVBM2IYsc7XmtQOoaq0U9HQDzg7Bgs2AYC96Pa5Dd8DCmx/hCkAsMfCYBimSgXd
hxZSGH6ASOrVFnqD11SXHpUw6WHtAsPQMzo=
=va+2
-----END PGP SIGNATURE-----

--fd11ad08ce12bebac6607f5852f9e8f7f714528d81476904b87071075ca2--

