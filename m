Return-Path: <linux-kernel+bounces-802141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C01B44E07
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9B03B78F5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF912BEC3F;
	Fri,  5 Sep 2025 06:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzORECBE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C12AD2F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 06:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757054316; cv=none; b=NIg5jN3qxPPRSWMuDdCOSn8OVOnQE72FBy0Qn4/XUAyUkRYT4vGIMco2Ij/05ZIME1Ip42D4x3cjpZIKuKsqfEIArRwWvQONhjsOJK6Hu6JiVkPZKozl8AGsuclHRfXf9hOF5/uyo9LByL8A/QcuIhWTxXt3NP70ODZV8UVjnsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757054316; c=relaxed/simple;
	bh=0IsjYiYAtaxouY+NEobqkqNnP9H/ZrrfLIh33vkFciU=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=aCBezgufk7yJpy1HBCqn/ho8wFZMJoh1PuwqO0vPg3rVOnApAflwuoqo41F2IaBDh47xbh9lwl4ElK62MPNMuv5Du11CiiWorS1bnzWe+lhkZBS2qWW4qClCJcGsjwmSNDFNa9zjJh31/GbWsmG+yGs+FJGeiHCV7k/sYahvBY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzORECBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09BEC4CEF1;
	Fri,  5 Sep 2025 06:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757054316;
	bh=0IsjYiYAtaxouY+NEobqkqNnP9H/ZrrfLIh33vkFciU=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=AzORECBEaREbPXiYMUtLaT11IOceXkylnfkxM1DujHXYcaDckzRIUTr2eSA8k5nk1
	 OcOfKVjK9bJFwRhCgHti0yUd3Vf/JwPH0ebuDBgXyFTq/mHqN9QYDQlp5mPkBuQnkO
	 wDfFlVEp7721esBnlB6mSyT9EWaQ7Jl3b8tmNqfU9jNd/TNpM69EMP4P37Bo+4FJmG
	 vrYhBr3ss1yBZHQ8z0S6uPNQ9O4F3XxqWSZUY+qOg8ezxwUQe1xuvukjFY+ZeGksMP
	 JskOPfDzm4433ixSKyB9qa5URr3kNMPHKmyTFtTHaGKMUHKOjLKRKYauT2Yb7R+ooA
	 HhlLqwnxU4l3A==
Content-Type: multipart/signed;
 boundary=26b60d16fe0109792e3c3118d7bbd57fa70d7d5aad82d0306e1529f6916b;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 05 Sep 2025 08:38:31 +0200
Message-Id: <DCKNRRN0Q2I7.WFT5U4QKA9XS@kernel.org>
Subject: Re: [PATCH] mfd: tps6594: Explicitly include bitfield.h
Cc: <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Nathan Chancellor" <nathan@kernel.org>, "Lee Jones" <lee@kernel.org>,
 "Job Sava" <jsava@criticallink.com>
X-Mailer: aerc 0.16.0
References: <20250904-mfd-tps6594-core-fix-bitfield-h-v1-1-5d0f00cfe58f@kernel.org>
In-Reply-To: <20250904-mfd-tps6594-core-fix-bitfield-h-v1-1-5d0f00cfe58f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--26b60d16fe0109792e3c3118d7bbd57fa70d7d5aad82d0306e1529f6916b
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Nathan,

On Fri Sep 5, 2025 at 3:26 AM CEST, Nathan Chancellor wrote:
> After a recent change that started using FIELD_GET() in tps6594-core.c,
> there is an error when bitfield.h is not implicitly included, such as
> when building allmodconfig for ARCH=3Dhexagon:

Thanks! I was already in a discussion with Lee about how to handle
that.

>   drivers/mfd/tps6594-core.c:767:7: error: call to undeclared function 'F=
IELD_GET'; ISO C99 and later do not support implicit function declarations =
[-Wimplicit-function-declaration]
>     767 |                 if (FIELD_GET(TPS65224_MASK_EN_PB_VSENSE_CONFIG=
, pwr_on) =3D=3D TPS65224_EN_SEL_PB ||
>         |                     ^
>
> Explicitly include bitfield.h to resolve the errors.
>
> Fixes: d766ca01c208 ("mfd: tps6594: Add power button functionality")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

In any case:
Reviewed-by: Michael Walle <mwalle@kernel.org>

Also,
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509032356.LGa5hygM-lkp@int=
el.com/

> ---
> It looks like this should go into ib-mfd-input-6.18.

Yeah probably. Lee, is that possible?

-michael

--26b60d16fe0109792e3c3118d7bbd57fa70d7d5aad82d0306e1529f6916b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaLqFaBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gJ5QF/Yh36rQMKcE0fjVQsNSxUTJaTojOsHJkU
x5iyC6nNOB3/j7RU98LCpiziytzJ8JhmAYDKMeHqJZ54aMWuXjAZTrFYT5LRaKhr
lHh+3UbHOhcM2n2FdIPMzMiIWEEejiutyeo=
=i23U
-----END PGP SIGNATURE-----

--26b60d16fe0109792e3c3118d7bbd57fa70d7d5aad82d0306e1529f6916b--

