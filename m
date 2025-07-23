Return-Path: <linux-kernel+bounces-741972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45298B0EB85
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2E73AD729
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4195227280E;
	Wed, 23 Jul 2025 07:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="fKq/Tibm"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B759312FF6F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753254840; cv=none; b=smWId3WuchM1M71uvKj5Kvp43/nAQep3R3RNA851Trgr45eo6Orhqk+4Ctunoh3lLe8e5fvXTtdXO3H0lR7TAxgoTx3eJw3VKXryrvzXMOi38XQFY0ccVAjKtDLvXJLAUKfEUTsV6af2IJRPaacP7ODMVvlcOGQfDNFBhbx2TFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753254840; c=relaxed/simple;
	bh=+8q4JhuQggFc6/wdINGA2yroVkYiUrINzCn+5swm5xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhs13wtSyV6mckeZLo1RKI/fHvicESlxbIvOG2EYo+ul8QOpswdzfcX9xhdcQAdB5ts52DqwZk4DydwJ7rafZaimY9ZUBGrq2ooeQdR5lwlMcaB3H5yxselODU80OnEr3RgqEWx6MD5Al8tnQtfdTWpWyk56QDuMQG3IaQ1A0s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=fKq/Tibm; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=+8q4
	JhuQggFc6/wdINGA2yroVkYiUrINzCn+5swm5xw=; b=fKq/TibmhZP750VjHCHl
	vpiKWeWR+VXw3FgENQLws52aJzSWhtYq6buiTtIv/W/YreLgm6x6LIs3xNk+BhyY
	eQ6PdCwU0biYDVxLG5djtd//JFriYvM2voLqVRn+0kX8++myEeWdaqr8qCVol3hE
	tuXyV5IV7/vSzjVXXmDSaMysSY0Xl8OjyFkg1Gv11oyEiWg2Ga/qK+QphpPurATK
	8N0azfImjWRIFv2ND0p8pjKF3elUYWaF4avbaPgz0ilVrgnp8x2TYuPX8Xs6wdQ6
	04HyXCHBoxRnGRvjCN2rqc+i6lF0fUBiNqFhPYyTVv2IfTHyUHy0n2LW+8FBaYNa
	YQ==
Received: (qmail 1607344 invoked from network); 23 Jul 2025 09:13:56 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Jul 2025 09:13:56 +0200
X-UD-Smtp-Session: l3s3148p1@+fK7c5M6qN4ujnvr
Date: Wed, 23 Jul 2025 09:13:56 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Magnus Damm <damm@opensource.se>
Cc: linux-renesas-soc@vger.kernel.org, geert+renesas@glider.be,
	linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: renesas: rza1: Check pin state before
 configuring
Message-ID: <aICLtLfJy_oc-J1g@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Magnus Damm <damm@opensource.se>, linux-renesas-soc@vger.kernel.org,
	geert+renesas@glider.be, linux-gpio@vger.kernel.org,
	linus.walleij@linaro.org, linux-kernel@vger.kernel.org
References: <175233393885.19419.10468322450742766513.sendpatchset@Bjoern-Magnuss-MacBook-Pro.local>
 <aICI6M61N9_PH35L@ninjato>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="16vsQgAcQM5JwYGa"
Content-Disposition: inline
In-Reply-To: <aICI6M61N9_PH35L@ninjato>


--16vsQgAcQM5JwYGa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Bummer, I overlooked a local modification which prevented the pinmux
settings from being applied :(

So, it still doesn't boot for me. Is it my old U-Boot? I have

"U-Boot 2013.01-rc3 (Sep 09 2013 - 14:57:28)"

Sorry for the noise!


--16vsQgAcQM5JwYGa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmiAi7QACgkQFA3kzBSg
Kba9bg//e5/GxpVub3fmZGmzU9UWG2KIIRIuXCeQHtDwT8kIo4Xtqpew9bHId9Xj
Clhm6xbd3JD8vUXbfP2zD8vH0qMwJy16LSLO5H94thOg+C5KJVjgXg3pm8YNgNxl
k0kJHWl52+IY1rCMkt19CZ62+rYZJlEjIpKWXwiC0Hy8o1E+HWK2uIwrtQPDz0Uq
EfKn3t7GqoF50o+gOMd3LK4SKdFb2NLFWgJrK76lXKsHgsAJU16ca6iq0lhCQvLq
AZC0tyOmm9iyfHEo8FF3cByrgAOVoQqIyWneG7qNH5jEFejWPPo2rCOijtYnj05B
r8SdIyHd4Q3ka+eTuoswDUewuLp7aMBrqXHwy+JqIVruxNtcnqpnRRIGj3K/mXhv
bwRZu7n6Wn4ppRUcCmLEbe1XTLcLblR8I3atBLKA2eEK/5rHrnbexP+mR4FafhLL
iFGVz6qw0yY883OOG13BFutCUHrEIBhZ657W/upUHKcyud/bpqitgXFfFVJ5I/Pe
kN20TYnFPXWOzbn6RHhS9B4gvhyiZOup9tZUGLtE/7N3XPpzYiWJkIlwTiiFfCkT
IgLTOTXwksnba57AMW8ctsgnCrVVSywbq8znJslu2cJf0bHkM/1ySnfdvb/BURiS
pPldlgD7DxBz2iKWsbA3FGYOpYRMj5cpCuraO3VNOfMwqLHUhs4=
=n/aV
-----END PGP SIGNATURE-----

--16vsQgAcQM5JwYGa--

