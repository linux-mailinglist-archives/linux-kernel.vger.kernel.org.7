Return-Path: <linux-kernel+bounces-749122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C916B14A65
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329FC160E8F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3532857EC;
	Tue, 29 Jul 2025 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5soMQEd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C01283121
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778899; cv=none; b=fz/RCjTQL9dG/KP1pcfk/JYqiqZmxuKu+Ry2aoja3jehZgPxDTRtRLIAGPvr7SNldVQtRCpPU0fnpNn9CVVdvzeRLMjRHe+4g4AN34LsLe7Aa3XhagCMhPUZj+sSRYtQBKiBcQ1D0iizNRVB5HVygklyG9j824TWx4zUYzbHiew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778899; c=relaxed/simple;
	bh=v/kpOVMVL0VbZRPfgljdXv2bn6Gc6hW9fXhN63RQtSM=;
	h=Content-Type:Date:Message-Id:From:To:Subject:Cc:References:
	 In-Reply-To; b=eO3U2YEjldcFoISVbrjDHRvRvm+LwcNt+mAK+1hjRQlKHhUgHo73ps05T3KWhgUFn98I1P12se16yRPzlsYbRVpIS3BAF6k6yIO0g3DBSgKruuOJ1z/HxKf+bTEBXT4FgZShcGRad0jHHwUZN9cPbfQfa0T145bOVtPQ6+wzMso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5soMQEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018BAC4CEF5;
	Tue, 29 Jul 2025 08:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753778899;
	bh=v/kpOVMVL0VbZRPfgljdXv2bn6Gc6hW9fXhN63RQtSM=;
	h=Date:From:To:Subject:Cc:References:In-Reply-To:From;
	b=d5soMQEduk1cxpl222qHqtta+r7E8SYfc1QU9usEcnPhZv35AaX5pimLRT/GG6PIp
	 9EPwXZpv2KqcCiA5fzMv7IvXkQqm9TweGZfhoW5M6HTczBg6Z4cfvnicSePwgrCIN9
	 JwshVQemLNK+vm6arLlSrXhdK4iP3gYVb7NFMTQeutIDaBTvBm5+KsO+OPzl/XExVU
	 x7pU5wzI4+FGTfP37itq8zTKCIUNSsZvMhh1tGKdyJ7abgy/FwU2dh/SuKGCD+wOyy
	 Dx0Z0Oy5sabvs3pbZGO27Etqsb90h0lVRxaxeoFqHhdM1PeJRSsUI/BmiIPilc1GPW
	 Eu5TizYdJuURA==
Content-Type: multipart/signed;
 boundary=20717ec1f244d1b8495b8ac4321eba2428d3341753c744a573ed0c316169;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 29 Jul 2025 10:48:15 +0200
Message-Id: <DBOEQE01XFID.21SA81RTH4OOX@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Marek Vasut" <marek.vasut@mailbox.org>
Subject: Re: [PATCH v2] mtd: spi-nor: winbond: Add support for W77Q51NW
Cc: <linux-mtd@lists.infradead.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Pratyush Yadav" <pratyush@kernel.org>,
 "Richard Weinberger" <richard@nod.at>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Vignesh Raghavendra" <vigneshr@ti.com>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.16.0
References: <20250721202257.83936-1-marek.vasut+renesas@mailbox.org>
 <9eabfe619554cbdd493086dcffef8f44@kernel.org>
 <62383ff7-0a14-4f15-818b-f5e5c56332c5@mailbox.org>
 <DBJ86H8MDFNX.2Y6T55E0NH63R@kernel.org>
 <0d0cd3cb-61e5-4ec6-958b-ec48b82429bf@mailbox.org>
 <DBNH88949QTH.3I3MSOA019UJL@kernel.org>
 <d592e97a-fad2-4269-b854-d3e82d985035@mailbox.org>
In-Reply-To: <d592e97a-fad2-4269-b854-d3e82d985035@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--20717ec1f244d1b8495b8ac4321eba2428d3341753c744a573ed0c316169
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jul 29, 2025 at 5:51 AM CEST, Marek Vasut wrote:
> On 7/28/25 8:32 AM, Michael Walle wrote:
> >>>> I have limited supply of these devices, so OTP is untested. The flas=
h
> >>>> does have OTP registers, that's why the .otp entry is there. Why sho=
uld
> >>>> I remove it if the OTP registers are in the chip ?
> >>>
> >>> We only add tested features. I'm just the messenger here :o. Anyway,
> >>> OTP is not really one-time-programmable here, you can write and
> >>> erase it again as long as you don't lock it, if that was your
> >>> concern.
> >>
> >> So how do I test the OTP without locking it ?
> >=20
> > flash_otp_{write,info,dump,erase}, just don't use flash_otp_lock.
>
> Thanks. flash_otp_dump -u /dev/mtd0 returns zeroes, so I suspect the OTP=
=20
> is not working. The chip does work even without this entry and the=20
> content /sys/kernel/debug/spi-nor/spi0.0/capabilities and=20
> /sys/kernel/debug/spi-nor/spi0.0/params did not change, so I think the=20
> best way forward is to drop this patch, until I can figure out the OTP=20
> on this chip ?

Probably. Good to know that the flash is working for you.

-michael

--20717ec1f244d1b8495b8ac4321eba2428d3341753c744a573ed0c316169
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaIiKzxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jb/QGAhc+gsKxCknmtQPaaJ/FTrerEZic21gys
8Tbc7+kOt1qxnZgCX56A6Nxab3UmzitDAYDN4qFM0IG70A1EM4VIcSz+wKAf0Kgd
AfAUJKmvZPgzv5xKMIaK572Gb6FYTnlPYn8=
=0Gkt
-----END PGP SIGNATURE-----

--20717ec1f244d1b8495b8ac4321eba2428d3341753c744a573ed0c316169--

