Return-Path: <linux-kernel+bounces-730566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFABB04659
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705B64A6CCF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BE6265298;
	Mon, 14 Jul 2025 17:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8NMRuzX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC451FCFFC;
	Mon, 14 Jul 2025 17:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752513653; cv=none; b=pAFjZUCWATzmY6E3urFa7gX/Kifg7IXJ1XG3X8eAN5koxJyFhbNHdMVz2H6vwbWuooxFou4oFJ2xyq8KfoCX5MhKgV9kvHJQNiDgmAPugbDt+ixahP6zd1v1pf0LHl0SQs8tOtmxkb6xvtEBqJwZbdxZYzmKJr5Gga//iA+ZkJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752513653; c=relaxed/simple;
	bh=SmQEwI74BvGwb3v3v3ZnH/mympHyqcTHlv6J6Bxs6NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udBQ+VUFnvneEUq6HKO+z8EawvnMBZSou8x22JT8PRmw1hlJxJQdkA9DH8Pb+/Aia8yd/2a6Ix+l3D8QTZtexgD+HyAWGlwCAqjb/ApUELk96TMAPmydQS1wQOYssoiecsRVLYeYGfPjP5leF5k+Y5auQD87M/IZdOwgZR+HFKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8NMRuzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9B8C4CEED;
	Mon, 14 Jul 2025 17:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752513653;
	bh=SmQEwI74BvGwb3v3v3ZnH/mympHyqcTHlv6J6Bxs6NY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D8NMRuzXVl/8t4BDCl0qu0LsLt3sRfxlrf3V9DDTwoLUVWeqNMQyKQeAiygOsHSml
	 hCqKYgEYNT9nPqcOI1IBtpSpOa/WofQnxxFskxRLOVS0tg4ePJlRkkjdfDRi3C0dDY
	 18FLcZffWdV/uwsw7oM6B5FTxJRBoiXTUDVBfF3srFW7VWgs46aMDnqtI/P+NEVVVu
	 8f4py31YBaCdoT7kR4C3pifVlbP4JYnB+1UZsyPzwrsWbtjBJJSqROByAOzFyH3IwC
	 Vol6vCufNKuto/TnN4iN3wOE6eKKsLT14NUcijIZvNPWllBuvxYiT1xoxC/sD/Onxh
	 eJzdxiTqqSusg==
Date: Mon, 14 Jul 2025 18:20:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] docs: dt: writing-schema: Document preferred
 order of properties
Message-ID: <20250714-ipad-karate-9f8672c4983c@spud>
References: <20250713-dt-bindings-docs-v2-0-672c898054ae@linaro.org>
 <20250713-dt-bindings-docs-v2-4-672c898054ae@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xpMTEs3gkQZjH4FX"
Content-Disposition: inline
In-Reply-To: <20250713-dt-bindings-docs-v2-4-672c898054ae@linaro.org>


--xpMTEs3gkQZjH4FX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 02:46:39PM +0200, Krzysztof Kozlowski wrote:
> Document established Devicetree bindings maintainers review practice:
> using DTS coding style property order in both 'properties' and
> 'required' secions.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--xpMTEs3gkQZjH4FX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaHU8cQAKCRB4tDGHoIJi
0kN9AQCVhJs4joUI9fwDCGV0G1ZqTA5KXlIEvSXQ0yPOIJDVywD/VMsXH1w71rUP
kvC5hEe0H2th7siViMYe3eHohmKutQU=
=9Uw2
-----END PGP SIGNATURE-----

--xpMTEs3gkQZjH4FX--

