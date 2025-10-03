Return-Path: <linux-kernel+bounces-841754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A4ABB8250
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 22:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2443719C7162
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 20:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98316253B73;
	Fri,  3 Oct 2025 20:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4enKN8j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AED3987D;
	Fri,  3 Oct 2025 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759524641; cv=none; b=csVrXm+1DgRxoYBDCPpdSv+ml8xFUte5KEk3Mq0QZPeoO4dNQel1iafy/cYMGCQNH0/8XVGJ4LlsHr+Vq0/BVz1AKGLYQPouaxOmbaUZ7Yovrx9iWLNogJaIvHH0K5LeE3q9l0NacfYEX77kOjlDAw/zzKAp9NSOoCLwY34Qgf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759524641; c=relaxed/simple;
	bh=1p94Kd/jPrr2ZswfHfsej8PaEZcEH+oj56Meu5Y2CAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDNCPQJO/rFzJDBvIn8eFPJjC/eVlDLxk3E1024spgD+AO1czNQu4vwj7n3lTIrcbcnuj1TIdnLzPOno6hewg0uV3fPSWFSBNnZHmL6ARTRx+B0+yio64pWuXFvvsJTdVRc0rW3hdCeTlGJFzSNb9N7+fjYnQn98i/H8SBm/dDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4enKN8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E7FC4CEF5;
	Fri,  3 Oct 2025 20:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759524640;
	bh=1p94Kd/jPrr2ZswfHfsej8PaEZcEH+oj56Meu5Y2CAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4enKN8j2eK1CuI01fDM+arTXjdajKM5HCHwySG5f+hXMd/308SPC3ZKY+m6hNJIn
	 rj1I1cP1ma/1XbdRYYoKhtL3/WAFyYK9PlKxHPvi8YXtKR3g4C8pO96B6ICtkj/3j4
	 fZVMVsb1JIlKqs9WL2yWndnGpXEJc4Ch+t7KHUiWtyPtfiLKw+3ydxhQWqaNADC4sp
	 Sri0fUxt0pBeYaMDyKbnTI25jupqutIRZAlLpvrL1JMfl2BG7ITjoava+9x+YDL/q8
	 DohfD3vWnSDAiwoa8sfKlZVsB4MAoZ+CiR4ArHYivxgxrMcuDRW+GYUMf/sOgrVKWz
	 ilHIilMvIjqkQ==
Date: Fri, 3 Oct 2025 21:50:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Jammy Huang <jammy_huang@aspeedtech.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: aspeed: Add VIDEO reset
 definition
Message-ID: <20251003-winking-surround-d047d3c90fd3@spud>
References: <20251003015845.2715538-1-jammy_huang@aspeedtech.com>
 <20251003015845.2715538-2-jammy_huang@aspeedtech.com>
 <20251003-paralyze-herald-f9ef464d43e2@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GbO01kysT0Oxu35+"
Content-Disposition: inline
In-Reply-To: <20251003-paralyze-herald-f9ef464d43e2@spud>


--GbO01kysT0Oxu35+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 09:49:00PM +0100, Conor Dooley wrote:
> On Fri, Oct 03, 2025 at 09:58:44AM +0800, Jammy Huang wrote:
> > ASPEED clock controller provides a couple of resets. Add the define of
> > video to allow referring to it.
> >=20
> > Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> > ---
> >  v2 changes:
> >   - Update index of ASPEED_RESET_VIDEO
>=20
> Ah, so here is the next version. I don't see how this can be correct if
> 21 was correct before. Was 21 wrong?

Given the driver has mappings, I guess this is actually correct.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

> > ---
> >  include/dt-bindings/clock/aspeed-clock.h | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bind=
ings/clock/aspeed-clock.h
> > index 06d568382c77..671e5a476eae 100644
> > --- a/include/dt-bindings/clock/aspeed-clock.h
> > +++ b/include/dt-bindings/clock/aspeed-clock.h
> > @@ -53,5 +53,6 @@
> >  #define ASPEED_RESET_AHB		8
> >  #define ASPEED_RESET_CRT1		9
> >  #define ASPEED_RESET_HACE		10
> > +#define ASPEED_RESET_VIDEO		11
> > =20
> >  #endif
> > --=20
> > 2.25.1
> >=20



--GbO01kysT0Oxu35+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOA3HAAKCRB4tDGHoIJi
0vYZAQCmKLwDhm+cuPWduwkWTnpOANP4HjnQu7jEQpxmnAp8vQEA8Hg6Ok19zE03
5dhdXT+b7zt9X10JDsEcH5iw3pm2rgU=
=lZUw
-----END PGP SIGNATURE-----

--GbO01kysT0Oxu35+--

