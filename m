Return-Path: <linux-kernel+bounces-894016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D20C49154
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E9E188C792
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59293370FE;
	Mon, 10 Nov 2025 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/JiLWNH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B9918C008;
	Mon, 10 Nov 2025 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762803367; cv=none; b=mYC7g8XRbZDG5ybP0Bj60Sj+X+OMQHOhgbKvNCvFiN0vggs7+/PXr6EIYSgRH0VlUxKc5l1ej+rEtA2ykvwBqaijwALPF5hmhFsWPW1WifuJcwiX9FM0X4CIXSc/63FowXY6Vdj3cTExV9vIlyDAIugj9DnlRc30rwZzJnLKVU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762803367; c=relaxed/simple;
	bh=jpF83hZl4+ePN40ExsHilbddxNFc1Cve8pvPWp8/Bmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SK17/0ZwLjgiIjaFM0dVk66zZsLOjpxjaAjQycJBxj67t5VREW+ZAhs+QLQQsOMGxK3osTttxj3mUkKFeI/ABE47rYy5QvmcneCG2h579qjBUzo1ZiBEFF9fKgcs3EMLRgt3YzNWgdzIgxdcU/7IHO1hh3FGKQUBYhR7/FnQXlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/JiLWNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACD7C2BCB4;
	Mon, 10 Nov 2025 19:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762803366;
	bh=jpF83hZl4+ePN40ExsHilbddxNFc1Cve8pvPWp8/Bmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r/JiLWNHjEYRmruV9LdKTJJTd45+gaNqMVxx3rKwEocvH5raBmPhaOaSVmu3LB1qB
	 v0a/a1UV73eEVavjBqelijRtLfPFA7zKLv5pcjNmrBX6zODp941N/MZ9YvQE2P7+Ta
	 23tHNDBX6X+G+I1EZMllpz83zr6Mj/te6SLxVm8+Eq9mSpu4z8sygEjiBDcf+ZBRNT
	 nmcZDBXr7Q/x9Tn8j8zhBnrVMkPBuhyS5p81Tj270JsMuhgtxrYD8fPwYXHH0bQmlJ
	 LPzeEDTvL4PZR5+MfOyG851q9+zXYhus/EQScPYQGY2xw+9LabgDNqmWOGy5TkWuXL
	 fmQFkqDEx/eVA==
Date: Mon, 10 Nov 2025 19:35:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Hal Feng <hal.feng@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Andy Yan <andyshrk@163.com>, Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC 00/13] drm: starfive: jh7110: Enable display subsystem
Message-ID: <20251110-clang-baking-b8b27730356e@spud>
References: <CGME20251108010451eucas1p1c7bf340dbd2b1b7cbfb53d6debce7a2e@eucas1p1.samsung.com>
 <20251108-jh7110-clean-send-v1-0-06bf43bb76b1@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cv1rMoP+ljYav3Y/"
Content-Disposition: inline
In-Reply-To: <20251108-jh7110-clean-send-v1-0-06bf43bb76b1@samsung.com>


--cv1rMoP+ljYav3Y/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 08, 2025 at 02:04:34AM +0100, Michal Wilczynski wrote:
> This series enables the display subsystem on the StarFive JH7110 SoC.
> This hardware has a complex set of dependencies that this series aims to
> solve.
>=20
> I believe this is a PHY tuning issue that can be fixed in the new
> phy-jh7110-inno-hdmi.c driver without changing the overall architecture.
> I plan to continue debugging these modes and will submit follow up fixes
> as needed.
>=20
> The core architectural plumbing is sound and ready for review.
>=20
> Notes:
> - The JH7110 does not have a centralized MAINTAINERS entry like the
>   TH1520, and driver maintainership seems fragmented. I have therefore
>   added a MAINTAINERS entry for the display subsystem and am willing to
>   help with its maintenance.

Yeah, bunch of different folks wrote the drivers, so lots of entries.
Pretty much all as you've done here, authors are responsible for the
individual components and Emil is the platform maintainer but
responsible for most drivers.

Do you need any feedback dt wise on the RFC, or is it too likely that
we'll both waste our breath if the DRM folks don't approve of your
approach for the rest of this series?

--cv1rMoP+ljYav3Y/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRI+nQAKCRB4tDGHoIJi
0mgxAP9S65gNYTUGl4G/hjuQeRD2OPtB7jDPJa2U+Nb1h9guXgD/ZYh57W7dimb0
HC9nSRLUedngvCWxlTKXCDULpQjSKg8=
=vQrF
-----END PGP SIGNATURE-----

--cv1rMoP+ljYav3Y/--

