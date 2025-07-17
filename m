Return-Path: <linux-kernel+bounces-735729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C60B0931F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00145A3D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EA52904;
	Thu, 17 Jul 2025 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sde9pVkv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B115D1DF968;
	Thu, 17 Jul 2025 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773045; cv=none; b=INQEISTHUBh2LDN8ZYfpYP7tm44eB9WjzG5OiUVb8UuyW8p0b/LCb5zsq/NC0O6oelS5j+j3+Z2CGPDtm8fVnO+ZqIyStW5n4ddWwSVXAKAGkXfLz1gHFmPiqtdoolehn0SsyfflArMlA7WA2fAugfrTrt35fOBlD3LXZmJbu/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773045; c=relaxed/simple;
	bh=JH7VSFk/zK+FQ9CRe5bDUMbGMnh0P9SvywzJv9eWuQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqT+gQIR7zbXvqGsAbone9cNrw7OEqDFmGlU5kZca2EawhEDcnJMkxPlNqHhoaiKyLcjiz2DRjgqyPU/EI8BMKbj+Mst8ZdO1iWafzbfSEB96RPK1CUzF7jhW1M3lL7+uXRD5R7wnAhr7r3m+ESnYLOZA0j/QuTg+eL5rP47f4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sde9pVkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF616C4CEE3;
	Thu, 17 Jul 2025 17:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752773045;
	bh=JH7VSFk/zK+FQ9CRe5bDUMbGMnh0P9SvywzJv9eWuQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sde9pVkvxPodunTdA5DIJh3VknjZw7jKpSaAUcVcCMeyKCTWYX01W/0ZSwmDUcGR7
	 VM8+USj5T+EuNh3ObNgME/jVErTbCIkZ9ufsN0ABlk6sXhhjoiVCoZHFtN1nsdnAhm
	 ImoEakWy4hHg9vAfRYM4O6MB2KmpzYq3JvoKN6YSiixl0SLNjncBfwmhH3lUBYEjV/
	 u1+BW/EacLw95IrpD2AmOHK1ZEqg/qaPTCM7d3HyhbttwvzBIHiieyyAX4CT2Dg/Y5
	 W/+rhlGV9ZDe3ZYt4sg4nw82K6Vdcj5JUFuM8xDYCgxPQEXpGosSfRoFhYHIWFY0PA
	 f7IUpJiiYL+7A==
Date: Thu, 17 Jul 2025 18:24:00 +0100
From: Conor Dooley <conor@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: starfive: jh7110-milkv-mars sort properties
Message-ID: <20250717-recapture-frostbite-80d22fa325bf@spud>
References: <20250716061940.180231-1-e@freeshell.de>
 <CAJM55Z_77aygReSPJyZMtfZWk_UPYTzYLH5E5uEw6K=GSu0LNQ@mail.gmail.com>
 <20250716-strategy-evasive-57b400af9366@spud>
 <c3d8693e-f7f5-4072-bdce-2bb0778c77c3@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KKorxj2ps5Qyg8DE"
Content-Disposition: inline
In-Reply-To: <c3d8693e-f7f5-4072-bdce-2bb0778c77c3@freeshell.de>


--KKorxj2ps5Qyg8DE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 12:06:57AM -0700, E Shattow wrote:
>=20
>=20
> On 7/16/25 08:28, Conor Dooley wrote:
> > On Wed, Jul 16, 2025 at 02:17:34AM -0700, Emil Renner Berthing wrote:
> >> E Shattow wrote:
> >>> Improve style with node property order sort of common properties befo=
re
> >>> vendor prefixes
> >>>
> >>> Signed-off-by: E Shattow <e@freeshell.de>
> >>
> >> Thanks!
> >>
> >> Acked-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> >=20
> > I'm going to pick this up, but it may be very late for 6.17.
>=20
> Yes. The other questionable sort style in this dts I was looking at are
> whether we want "compatible" before "model" in the root '/' node?  And

I think usually model comes first, yeah. Whether that's worth doing
something about, I'll leave up to you.

> then why we have this common pattern of 'pinmux' (or pinctrl*)
> prioritized firstly in the natural sort order, also pinctrl-names before
> pinctrl-N is a common pattern that seems an arbitrary reversal of
> natural sort order?

Usually "foo" is followed by "foo-names", but pinctrl does appear to be
a bit different since everything has a -something suffix. Skimming, it
looks like there are actually more instances where pinctrl-names appears
before pinctrl-N.

--KKorxj2ps5Qyg8DE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaHkxsAAKCRB4tDGHoIJi
0u/iAP9jwxr4ZffYF8ASjcQj8Jk2UVLg2Psjh9pxqVhd2DEAhgEAmt8l09YsKsMe
nQWKkN3C+dhb2aPlJaM9ndgQv0SCQgw=
=vtGl
-----END PGP SIGNATURE-----

--KKorxj2ps5Qyg8DE--

