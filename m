Return-Path: <linux-kernel+bounces-759286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71114B1DB8C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CD018C44D2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC982701D9;
	Thu,  7 Aug 2025 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOEoXXJw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F290926FA6A;
	Thu,  7 Aug 2025 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754583598; cv=none; b=G4oB1zi+f5bEMwvJt1YimtjMabJM3/5E8GitDTOgFM9b45ZYf9wf6NlPlVk7Jk+Db6IPjAPSYzAIeYcjAtvLQ8x59QW2lKgkwhvJgawsNkKBFuc80URPJRgckmSWxDhCLHAPgMqEd8bOn1O4qOhsM0CYJi4S6gqyR2UCEENqyW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754583598; c=relaxed/simple;
	bh=71l1WbPfSqzMfZQuYilf4vVUCeTfgFXR+IWoTWtgAZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7tl7dV/TM+SOaAHLOKmoyc44Ng2NTc3OgO4ttr3LFC5pUGzAu9cRKWeLl5wQxp8FfV8qpODtR6dP/dAOu8WVtPfH6AJnIU+EZerqKuogCfRwpGxytfqYEufyN3n5ZxbkW//Otdxby7R5hE4M/K0FgtynaDZbREGZbl4sY40MUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOEoXXJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B145C4CEF6;
	Thu,  7 Aug 2025 16:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754583597;
	bh=71l1WbPfSqzMfZQuYilf4vVUCeTfgFXR+IWoTWtgAZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iOEoXXJwEzKxABOK2piOyFyGcOGYq8gYy7PKw6jSnPdq0qXY4eONlgysv6P+NDBAq
	 UbXqbOeioVzmwsCyw0FUhLcOtciG47kW0QS7GkC5LE7Wgx/VqL6GzxzpQvhnCJx+Wx
	 eKA1vFqOH46fkH6dXM2B4hE1DmclhSXeVOsQYyC1NxgA+HFVyvu5/+V1Iu5+R7X7Sr
	 rsiR8Tc26KmY0AoKwR/Jf5jCzIp7AbJ+pVPU+qqc1pJayJvgWGc+JsgFvaD1nSv2Fq
	 HWH8q7StUg/0WBQYSIwSJJGhQDPrDcT3tDEZj7r799mvuGHfF19KgLMrc27shTqzks
	 HXWz0m8QZSWCA==
Date: Thu, 7 Aug 2025 17:19:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>,
	Inochi Amaoto <inochiama@outlook.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jinmei Wei <weijinmei@linux.spacemit.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: spacemit: introduce i2s pre-clock
Message-ID: <20250807-untrained-anthology-bcf760fe73cb@spud>
References: <20250807-k1-clk-i2s-generation-v1-0-7dc25eb4e4d3@linux.spacemit.com>
 <20250807-k1-clk-i2s-generation-v1-1-7dc25eb4e4d3@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MGb6O0jv4+1CWhb1"
Content-Disposition: inline
In-Reply-To: <20250807-k1-clk-i2s-generation-v1-1-7dc25eb4e4d3@linux.spacemit.com>


--MGb6O0jv4+1CWhb1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07, 2025 at 09:30:10AM +0800, Troy Mitchell wrote:
> Previously, the K1 clock driver did not include the parent clocks of
> the I2S sysclk.
>=20
> This patch adds their definitions to allow proper registration
> in the driver and usage in the device tree.
>=20
> Fixes: 1b72c59db0add ("clk: spacemit: Add clock support for SpacemiT K1 S=
oC")

I'm not sure that a fixes tag is suitable here, seems to be some new
feature/development. The driver change seems to talk about how modelling
as a fixed-clock is incorrect, but this change mentions none of that.
Without whatever context that provides, it's hard to see how this can be
justified as a fix rather than a new feature being added.

> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>  include/dt-bindings/clock/spacemit,k1-syscon.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/include/dt-bindings/clock/spacemit,k1-syscon.h b/include/dt-=
bindings/clock/spacemit,k1-syscon.h
> index 2714c3fe66cd5b49e12c8b20689f5b01da36b774..524268246fedd3f1238320f35=
244baf32354fbd2 100644
> --- a/include/dt-bindings/clock/spacemit,k1-syscon.h
> +++ b/include/dt-bindings/clock/spacemit,k1-syscon.h
> @@ -77,6 +77,9 @@
>  #define CLK_I2S_BCLK		30
>  #define CLK_APB			31
>  #define CLK_WDT_BUS		32
> +#define CLK_I2S_153P6		33
> +#define CLK_I2S_153P6_BASE	34
> +#define CLK_I2S_SYSCLK_SRC	35
> =20
>  /* MPMU resets */
>  #define RESET_WDT		0
>=20
> --=20
> 2.50.1
>=20
>=20

--MGb6O0jv4+1CWhb1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJTSJwAKCRB4tDGHoIJi
0lrAAPwLeTxg0DmEWOZuiKramMswKD+FBk48f8HQ5cra59xk+wEA+uDoxchmMLyD
O74kiFlXHVfpag4BaRKO/wVQczwXmAQ=
=y1/8
-----END PGP SIGNATURE-----

--MGb6O0jv4+1CWhb1--

