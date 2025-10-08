Return-Path: <linux-kernel+bounces-845397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8F2BC4B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF993AC6A1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BED2F7AD0;
	Wed,  8 Oct 2025 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkXk/7cf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B002F5466;
	Wed,  8 Oct 2025 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759925564; cv=none; b=unM2l6acARhZnUkg8rrNhKYA1wc1GOMySfYjqio+sjBkjNfVyN0u97XkYaRyWLhJpM4wcVCI2kNyA7GbSB6AuntrF4YSC6j5Pem76EN+nF2CKam6bvj8yNw4tUCNjmrBUA9PTibS4OB3tjaj2r6jRxVWnibmQ0D/htLvykz7ito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759925564; c=relaxed/simple;
	bh=P776G5RIf8rZEm+tBGp92HoAA7mM0W256cFy+mpgJpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cORqWmZx9MtLf/SGkDWRuawXSaDmXhjIIn+aB4Zogswa6EgLnL2d5oYRQZZ+tZLvBprQWeo+plvg8/EQLhKwAGbb3jNOMFEUEaoyx2e1fN5wwVtnUct5vocTLxYuHvZoAjaDvzpdt0mHeBmaWzrJM9HqeqYu4J3xdDPQnLgwLuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkXk/7cf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A050BC4CEF4;
	Wed,  8 Oct 2025 12:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759925564;
	bh=P776G5RIf8rZEm+tBGp92HoAA7mM0W256cFy+mpgJpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gkXk/7cfAF55106Cbv+uBKbQrS2LnSXIMHCtaYtibMOnev1xMu2sTHrNLmFIowU4Q
	 ycecrvSCZGGO1kIPtw1m+vGrqiGCB8Y2f1kRXk2jdwdhn6hb+o1UaHA0Y9RNpotr7M
	 rVs8398Jrf8KXuvguN89T1c8MSUpKMputcPFMBZkZ1T+ObXPIwiH6JTzVccKtvu9e9
	 PFET+zZLoUd1+zSjv5vWJZnTMxUSycJ+gqZ8Lb0SlS1fg835r6hHKmvG0J+qKW7kmz
	 1+uj/DqAeAFT5F6CVaxoAuQ1WcVLIHoxVSoV3oo6JQEBiyMusrY2oMtg33j4iZXSv9
	 7uDOwuGgmMF/w==
Date: Wed, 8 Oct 2025 13:12:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Sune Brian <briansune@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: wm8978: add missing BCLK divider setup
Message-ID: <e78c9cc0-4a1f-4a22-9cba-a8213a7b9301@sirena.org.uk>
References: <20251007145028.1845-1-briansune@gmail.com>
 <aOUv69rMkyYFiHae@opensource.cirrus.com>
 <CAN7C2SDUiuMfPs_X5r0RDC56313aJsfhfx0-juhZRKGTb1OKuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9T+PVFhwwULYeJEK"
Content-Disposition: inline
In-Reply-To: <CAN7C2SDUiuMfPs_X5r0RDC56313aJsfhfx0-juhZRKGTb1OKuA@mail.gmail.com>
X-Cookie: 10.0 times 0.1 is hardly ever 1.0.


--9T+PVFhwwULYeJEK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 11:55:29PM +0800, Sune Brian wrote:
> Charles Keepax <ckeepax@opensource.cirrus.com> =E6=96=BC 2025=E5=B9=B410=
=E6=9C=887=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8811:21=E5=AF=AB=E9=
=81=93=EF=BC=9A

> > Apologies but just realised there is still one small problem here.
> > You want to match the closest BCLK that is over your target rate,
> > if the BCLK is too slow the system won't work. As your bclk_divs
> > array is sorted I think you can do something like:

> Not too understand what is the issue.
> The idea is setting the initial value to max any diff that is smaller
> will update bclkdiv index,
> If the maximum LUT 32 still not met then it is what it is.
> mclk / 32 is the bclk, unless you want an error message.

Consider the case where the BCLK needed is 100 and SYSCLK is 198.
Dividing by 1 will result in an absolute difference of 98 and a BCLK of
198 while dividing by 2 will result in an absolute difference 1 and a
BCLK of 99 which is lower than the required BCLK.

--9T+PVFhwwULYeJEK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjmVTYACgkQJNaLcl1U
h9AhvAf+IGuJtD2MC9Gjd2FouVdpCVLgt15SeM6Hu7Lopjfef+iA4Zn42SENRtEE
984YbzIzdLQ84s/04rb2nQAy9GHY7HhHHLzE4dYN4rl1kspGuYytUoe2hSL988oH
FruVamIUpuKi5bycXPmnHJwokVWLk1JhScNgfCbFBCafVgHhs/dBn4wpMVB20src
TCgn0+92RdIybWwIxh5oLs6J7tDaqq0nvWjJjOYXvnPh9IX/aQtnNoRGi4qBOpYX
BldrbuKq0N0FMMgC6wW/rAXTUy3C3zy+CubWKRAoBuUZUhK+zK66R8/TCU41Jdzw
S+YvWAzr82dU0Lc0jh0K9UCOEcB+yQ==
=ZYBN
-----END PGP SIGNATURE-----

--9T+PVFhwwULYeJEK--

