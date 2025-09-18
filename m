Return-Path: <linux-kernel+bounces-823104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A45EB85892
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D927D1B24541
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA2130C10C;
	Thu, 18 Sep 2025 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxuJHyBh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1177B1A0711;
	Thu, 18 Sep 2025 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208553; cv=none; b=p+X+LxNhuwor5PpyzbdmodvJnINIBY6d8byJztnCkdxVFMVQjBilS/gPOFg6khoIkpFU79CBn8JyG37H2Qk0lMtHS5U3dNAag6B2WgK/S34isoeDNpeNJ9TdJM0yhsrnVB5IfcGaQmBktYVXaMs42FZpKYsSZGHta8nft8DfETY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208553; c=relaxed/simple;
	bh=r5o+CxqA/412fJ3eG2K654Tnc4D5Ezd5ce7Iv9F6Ko0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrwKr9kAlP6D2VoG3dbQU9eniQp9+C1bV8sLKHazdBUrlV04nbcVJlik6nhw1wFwvqNJx2BYUHoYEcRtU7ljDtJTzD5aRK7+qT2QV1dftc8KELmznZAiHZ5teoOBNwvu7WdJWyPxFiCW5INgOjPFN4JaTXX/FOBpLSPooVP7PaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxuJHyBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0847CC4CEE7;
	Thu, 18 Sep 2025 15:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758208552;
	bh=r5o+CxqA/412fJ3eG2K654Tnc4D5Ezd5ce7Iv9F6Ko0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OxuJHyBhTOSdSdOyE3sNTRJKEkqCOLu3lc+WuNawPNbB1YNa8AUdfN6c0xuRTbn+6
	 z9vDG5mY/1RuI2XwdFpGaaFqvLRldDZoQ63XANTSEkxK4FD2U/sccEEWcX4LA1FeP8
	 mH/jLnVeQvNE6Y4Iu2nsJS2CuijVsYQMUruRoZhXbAa5tXJ17D4E9qR2ZK4Uz9fdGn
	 4sFSJiwBR+i9Ux/fSHZrKhbfyd6eFfbc9LIwixhZnIxzpINPydzoTlCcaSjO6aMAxI
	 Vf/Ldmyda6bwpe4ShtCAoKtmnE1R5KJ4K6rnN5iaWB0J81KP8zLm02bpbfa9ameAAW
	 getsmNBOO3ANg==
Date: Thu, 18 Sep 2025 16:15:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: p.zabel@pengutronix.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
	lars.povlsen@microchip.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	luka.perkov@sartura.hr, benjamin.ryzman@canonical.com
Subject: Re: [PATCH 1/2] dt-bindings: reset: microchip: Add LAN969x support
Message-ID: <20250918-truce-muster-d9a1818e7367@spud>
References: <20250917111323.60781-1-robert.marko@sartura.hr>
 <20250917-paparazzi-hermit-3a4aa686add3@spud>
 <CA+HBbNHS9TMd5u_Mysv21=nsqjeEb44oHFj06kS_hxkXZWutnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k2146MXiFzmmP5e7"
Content-Disposition: inline
In-Reply-To: <CA+HBbNHS9TMd5u_Mysv21=nsqjeEb44oHFj06kS_hxkXZWutnw@mail.gmail.com>


--k2146MXiFzmmP5e7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 01:45:32PM +0200, Robert Marko wrote:
> On Wed, Sep 17, 2025 at 7:38=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Wed, Sep 17, 2025 at 01:12:35PM +0200, Robert Marko wrote:
> > > LAN969x also uses the Microchip reset driver, so document its compati=
ble.
> > >
> > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > > ---
> > >  Documentation/devicetree/bindings/reset/microchip,rst.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.ya=
ml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> > > index f2da0693b05a..4d4dd47f830e 100644
> > > --- a/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> > > +++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> > > @@ -23,6 +23,7 @@ properties:
> > >      enum:
> > >        - microchip,sparx5-switch-reset
> > >        - microchip,lan966x-switch-reset
> > > +      - microchip,lan969x-switch-reset
> >
> > Driver patch makes a fallback compatible seem usable.
>=20
> Hi Conor,
> Will respin to simply use the fallback compatible, that will avoid
> adding more compatibles to the driver
> for no reason.
>=20
> But, can I ask what do you think about the
> microchip,lan969x-switch-reset compatible?
> Is lan969x fine or should I just make it lan9691 or like cause the
> whole series uses the same
> reset setup?

I'd rather the 1, I thought that the x was part of the name for some
reason.

--k2146MXiFzmmP5e7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMwiIwAKCRB4tDGHoIJi
0g5zAQCnIRGhz+Srw14h0GSHIp6EAXNyzBx+jtrDNbBFA2EzOgEAyf4TNCUklcQO
3ZAB4lss+pXY/yNX2Taf7hhBxiEs2wY=
=XzuA
-----END PGP SIGNATURE-----

--k2146MXiFzmmP5e7--

