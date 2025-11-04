Return-Path: <linux-kernel+bounces-885233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1E9C32502
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9D73AA6D4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E29533971D;
	Tue,  4 Nov 2025 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaetDQwr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BFB338587;
	Tue,  4 Nov 2025 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276996; cv=none; b=jkGKTc0aX+92D3Wc4J9NrlSn41TdMmIHJ0I7gaLzlx3SvNVFhYxIOuzWBNYARAfCiWrT3AgwVFC5uSmrH86U0mCBw+TIFvC3k2f9nGGPBcXV3zAwlpNBLFJbslxr5Vna4MYoJup9cXF1f0g6U0TXHsYRhSq48IlZaIPQDeNymIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276996; c=relaxed/simple;
	bh=E5LlO3nuIGMGzEZzuymHEqptWv1aueAZNyEcApu+pa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJb9ihIzbRlD78M8MXVCPHjFNP2AQDDWm4nw2VlhZQSKEXrAme2FwRowRExzJGZN2uCmoGPJC1eddcKahPj9V/RHPDJCKoYDbueNoultolY3Gq+VZNAiMjqMU1MLzvvrTjKk+iEMiiJV+0Zpaew4Brexhp5n6Kp9viKTEmRZ6rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaetDQwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99B8C4CEF7;
	Tue,  4 Nov 2025 17:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762276996;
	bh=E5LlO3nuIGMGzEZzuymHEqptWv1aueAZNyEcApu+pa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HaetDQwrl/7Fkot0PU9d+nSTeVzFdfuXVDZmdtpJpJVeBaaA0klVmA1eENrt1+e+5
	 TvhgjKUbjrZtovhEDg0p/Am7ivqIXvS57RaliFTnO9C2HOAGLORQ+0s4yJ1549qzi5
	 gnwahsmhyujkKSeMLxE7Jq6+mB8ZvHH3Eqy2gdJKkij38H6iV88jCabEwF+N90TP+d
	 nkBwS/85Hd9v0+6QjTt5T3ckOMj14HwnAD/nWS9HVhCHfN326C9iagieA4W0sQaU1i
	 OHNav7/x0N7m+JDB2QKDKumsi6pntWjK6Fai4t3GiS1oW6jXuTiAMboyPolY1CBmjo
	 4EbUobAL5zV1w==
Date: Tue, 4 Nov 2025 17:23:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: linux@roeck-us.net, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: hwmon: Add AST2700 compatible
Message-ID: <20251104-grumbling-document-6483add9415e@spud>
References: <20251104055112.2679087-1-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EAVUn09jG7fwpxUy"
Content-Disposition: inline
In-Reply-To: <20251104055112.2679087-1-billy_tsai@aspeedtech.com>


--EAVUn09jG7fwpxUy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 01:51:11PM +0800, Billy Tsai wrote:
> Adds support for the AST2700 PWM/Tach controller by extending the
> compatible string enumeration in the device tree binding.
>=20
> The AST2700 PWM/Tach hardware is compatible with the existing binding
> schema and requires no additional properties or modifications beyond
> the new compatible string.

With this commit message, I expected there to be a fallback compatible.
Why isn't one used?

>=20
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.y=
aml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> index 9e5ed901ae54..d6ff4182085e 100644
> --- a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> @@ -20,6 +20,7 @@ properties:
>    compatible:
>      enum:
>        - aspeed,ast2600-pwm-tach
> +      - aspeed,ast2700-pwm-tach
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.25.1
>=20

--EAVUn09jG7fwpxUy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQo2fwAKCRB4tDGHoIJi
0sYTAQDbftqnYaV1ZmhlGS+OCOMPY79jqcr4MOlskykoteVUhgD6AqEmQ/T3y0h7
Z5h+xKS/iDZ9j7HhE/bIphciTJDIMgQ=
=uT06
-----END PGP SIGNATURE-----

--EAVUn09jG7fwpxUy--

