Return-Path: <linux-kernel+bounces-874599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 931D5C16A8B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06B364F05DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF5C213E9F;
	Tue, 28 Oct 2025 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHQwPYXm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC411713;
	Tue, 28 Oct 2025 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761680769; cv=none; b=CUDBc4LSvR4mMSnH8E//xcvPP9AmDcQuONICmdyVLAergFXnY7Rx0cDVvAuW7MqHJ7+oQ9ge0MllJTIG3Juw2mvcCLuj5YjaCW4NJvjwN8XgkgHtFclxp2puEK28BHEgOIIVN2SksohkbzU5kVATnKGKiRTJoGg+1KifIGcfJSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761680769; c=relaxed/simple;
	bh=w3VcIMFNncYev6xyyHdkUM5LCBO6snPWm/1dFj2oeDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etJV4jLmt4TNzjoQIumskQSM+MU5DS4iRH59rmpQUfGXmdzryQtpGQiEn4pmQrLr5bCDiy15w0+ft4ePcS7tslFkzh/zH0RlVeCoGKFkQorfBMEC0Bd/815+Yo5uITWBefu4pV2EC39L35s0E7N+fohZEmQQ3YOoE3wtuSj/lSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHQwPYXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77482C4CEE7;
	Tue, 28 Oct 2025 19:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761680768;
	bh=w3VcIMFNncYev6xyyHdkUM5LCBO6snPWm/1dFj2oeDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GHQwPYXmFh/OqSYeZ9teA5Cb8sxABO+O8gpxByZTt2tr8hEVS7m4Kx7nRp3O0dpR2
	 Wf5h41rCJpWbeni650Xz72zX0gfMhAFipd/8DlXFwhk1L+HWu1+15i+rLieZkj8cqp
	 f1zkHB3tL8lZ25qC7Tew3nGK0HceXRQJpmo47FWO3p40DBi3i8tPcQfMezW7rNyg2N
	 qnaHWVldSVRtOON2ncmO1upjl5nq+PagisYIQ7Lf1Ui7impHNFgqCSsj40HrCjkh0/
	 M8zZSgcF6fSHyvnCfyRYeIbTN3Hq4dBzATbHMd1Cd5J5Fxr/3bc9SMmPHMFIu6xDRm
	 6nGik2Ue5rHjQ==
Date: Tue, 28 Oct 2025 19:46:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add NineTripod
Message-ID: <20251028-semicolon-audacity-dd5bdd418207@spud>
References: <20251028-haste-amusing-78c28e834b5b@spud>
 <CALj3r0jQ-Y3wt=iyykrFVWDXyA+2feCtYy+budYzqOaVY6WqnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="niplE5DXJ5xnJ+ih"
Content-Disposition: inline
In-Reply-To: <CALj3r0jQ-Y3wt=iyykrFVWDXyA+2feCtYy+budYzqOaVY6WqnQ@mail.gmail.com>


--niplE5DXJ5xnJ+ih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 12:38:10PM -0700, Coia Prant wrote:
> At first, it was to avoid problems with the beginning of numbers.

What problems does starting with a number produce?

> Given that it is already used by downstream projects, we have retained
> this to ensure that users can seamlessly migrate to the mainline
> version.

What's the actual impact of changing it from "nine" to "9" for
downstream users? This is a board vendor, probably nothing is even
interacting with the board-level compatible at all programmatically?

Please don't top post.

> Thanks.
>=20
> 2025-10-28 19:35 (GMT+00:00), Conor Dooley <conor@kernel.org> said:
> > On Sun, Oct 26, 2025 at 10:36:44PM +0800, Coia Prant wrote:
> > Add NineTripod to the vendor prefixes.
> >
> > Signed-off-by: Coia Prant
> > ---
> > Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> > 1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index f1d188200..37687737e 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -1124,6 +1124,8 @@ patternProperties:
> > description: National Instruments
> > "^nicera,.*":
> > description: Nippon Ceramic Co., Ltd.
> > +  "^ninetripod,.*":
> > Why ninetripod instead of 9tripod? That's what the company uses and in
> > the marketing fluff for the boards.
> > +    description: Shenzhen 9Tripod Innovation and Development CO., LTD.
> > "^nintendo,.*":
> > description: Nintendo
> > "^nlt,.*":
> > --
> > 2.47.3
> >

--niplE5DXJ5xnJ+ih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQEdfAAKCRB4tDGHoIJi
0t0JAPwMQxn3n3NWEpsiImdiPhus3HKlzVvj5qA2XdW1fRX9ZAEAv2NYiwS8iLK3
cRoKFl4agYz9hNMDop3M98ItwQtM7wE=
=VZvn
-----END PGP SIGNATURE-----

--niplE5DXJ5xnJ+ih--

