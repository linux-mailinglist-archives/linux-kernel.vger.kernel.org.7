Return-Path: <linux-kernel+bounces-833714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 571B2BA2D1E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762171BC835E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F518286D77;
	Fri, 26 Sep 2025 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="NbbZrcYi"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BECA1A295
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758872234; cv=none; b=UDNo0mHH4BESxn5lCiZUOUiUxKXNOTKco8qSKqhro+h+sopKX6PlPER9fpcFNCPJUnxzsE78KHtSAxfxycGbzQNihCPwuqwO4FsumJ2t1h8vQo9hjZslnniNanc+svQwxWcXYq0RGfYrbqzTLDSL6uAU1G4VpwMgHFpGFC1YQ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758872234; c=relaxed/simple;
	bh=1O9L1w64gtbf0sPlP7XoMB0YhhkHyegVq6GrmPzs+yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYx//jCs4IhdGXxmHz1eVcgVZbavuzKq+6cbdfY7LfPxNyK1eG8SwkunoYJtxBAJ03ImAowEMDWpni9tGsk3K4cs0aj7Ujh/uslFQFsughdVsHjayL9LBG9b9i5NH16z2zQSuWWCiBjW/HHVbv0fnrDD2N3bYdcBDaqXypfD4go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=NbbZrcYi; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=n5CV
	INh4v+8kzQGq0oKqeatNBdkUW6NVF/QWpeaYxLw=; b=NbbZrcYivVB0o/tdJb+b
	v+A66B9uTunkDr7NuibuGxoyb7CjLhrJTnSQ82E9Fr+DWhh7+mNUCwptetgJ4ynB
	YoPfhixahXF7W84cF4XnFcxslk6Kjy3c4I86WPWX4W240rnuDrH5JjHPnFhEFnQd
	ehGa8qvAQA2Ma07RiHgSB4PJotDUuFo9cjKePvEePmDQCA8o3LL6liygYxC2pajW
	8rcJDEQcD3m42GDq37DA9mLl1GZZIYyoifB5Mw//GQ6Snf96s3D4rWGt/bo4vEip
	HH8bspoc2ulnOeYZJ3i9e17rasjNANnClI4BRt92D4NnxQTAJOmMitpNrY78eZy+
	xw==
Received: (qmail 2167172 invoked from network); 26 Sep 2025 09:37:08 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Sep 2025 09:37:08 +0200
X-UD-Smtp-Session: l3s3148p1@Xu1kWq8/YJIgAwDPXwQHAL/S9V79e5yL
Date: Fri, 26 Sep 2025 09:37:08 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	Kohei Ito <ito.kohei@socionext.com>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] i2c: designware: Fix clock issue when PM is
 disabled
Message-ID: <aNZCpHemo8-KYnWp@shikoro>
References: <20250724042211.2160339-1-hayashi.kunihiko@socionext.com>
 <20250724042211.2160339-2-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9nDKytcGlb+/D812"
Content-Disposition: inline
In-Reply-To: <20250724042211.2160339-2-hayashi.kunihiko@socionext.com>


--9nDKytcGlb+/D812
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 01:22:10PM +0900, Kunihiko Hayashi wrote:
> When removing the driver, enable the clocks once by calling
> pm_runtime_get_sync(), and call pm_runtime_put_sync() to disable
> the clocks.
>=20
> If CONFIG_PM=3Dy, clocks for this controller are disabled when it's in
> the idle state. So the clocks are properly disabled when the driver
> exits.
>=20
> Othewise, the clocks are always enabled and the PM functions have
> no effect. Therefore, the driver exits without disabling the clocks.
>=20
>     # cat /sys/kernel/debug/clk/clk-pclk/clk_enable_count
>     18
>     # echo 1214a000.i2c > /sys/bus/platform/drivers/i2c_designware/bind
>     # cat /sys/kernel/debug/clk/clk-pclk/clk_enable_count
>     20
>     # echo 1214a000.i2c > /sys/bus/platform/drivers/i2c_designware/unbind
>     # cat /sys/kernel/debug/clk/clk-pclk/clk_enable_count
>     20
>=20
> To ensure that the clocks can be disabled correctly even without
> CONFIG_PM=3Dy, should add the following fixes:
>=20
> - Replace with pm_runtime_put_noidle(), which only decrements the runtime
>   PM usage count.
> - Call i2c_dw_prepare_clk(false) to explicitly disable the clocks.
>=20
> Fixes: 7272194ed391f ("i2c-designware: add minimal support for runtime PM=
")
> Co-developed-by: Kohei Ito <ito.kohei@socionext.com>
> Signed-off-by: Kohei Ito <ito.kohei@socionext.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-next with the commit message from Andi, thanks!


--9nDKytcGlb+/D812
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmjWQp8ACgkQFA3kzBSg
KbYVAg/7BWz/rwEkVn1cCWxj/HRClHyoz5ksLIMAVO8hDHahTEJXvnJru4O1Udup
dpCBBJyxA/qAav+488BjsQjY718XuIoF920HMfFPNf5yGZl2X/8hdnoi2H5bE4S0
W+3v/5LDPqXdknQhS7gqCMsdGBw8MUvmjlQliBbxOKctMsyoWhLHWCUA1zLbk1Mp
yQZO9ln7zSUWm9KXTzI3+oSZFkokjMnU78ODH2xdaFlwSQ4vs3favxxeptnMb5zC
+9UiRvW3P9TT8yRT6pi3zNok+ZLzGIkRIJiPuBV/SI6PUk7zaK/q30xpyfbDzbKO
Yntu4DLnju1moK0eKEXZs442/yi146YmQ5DKcS2GO0v63492rpG3teYmJYgdNGKe
byJ26ltA2uH/u0USguVLns/03my5GOOqVX0C2dxyTfdXhQnaDm722Dixn81rQthW
qwLgafi1D/MwL5r+o/7C4k9vYCNc49Xqr6MhEcSj4OF8BOKaK60m6/szVHihQJky
+illqckbfokW/CCBkS47+F/T6oXGSbX5527NAanRAnU368WpFRL30bcfW92PJLBV
Sk+fBjp1+M5+oMOL7U1KWPwWD1XtftzqSPfns0+Hl/LRxeUOQ0iKDKKRHxvtSVPy
Ukf7X/mlgXsiLCBDI+k+h+s6pjXjaOHlWIqB5Ww4k2gdfZA2ds8=
=Xsci
-----END PGP SIGNATURE-----

--9nDKytcGlb+/D812--

