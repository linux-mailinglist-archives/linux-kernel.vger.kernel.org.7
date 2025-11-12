Return-Path: <linux-kernel+bounces-897947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C345CC53FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94C414F9875
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8BE352941;
	Wed, 12 Nov 2025 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxgUJKuc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548E2351FCA;
	Wed, 12 Nov 2025 18:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762972328; cv=none; b=SBaO93H255RBnVSaVmci2njaYj3BS21R2TO8uQmK6LWmdkArHJHV8uDNMGDPL6HxcH+6cAPNEhGO/m0ycl2iHD8DOPHi+PoILoUX2A1Ybr+sQX9zyuKMDx9MoirSYPhHbYY2PmcmPlB/5XKodOAWQEe0wDP/RCjqwB9AzId+oug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762972328; c=relaxed/simple;
	bh=rhYHIaDeRlqkfmPOJcKkkL6MWk98Yo8FHzQg9ppxXiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTW4RMW4jeczgBKvbya7FYhp3cwha8zSroG7aW/gR8WXPOXGs/5r9Fukn9E5UQwHB2fol+Y8a6f/XIKSdD1GcSsdF0aaPDdueFgFp/YWySQ8NauzFCNWx6k3+SdCNz/73Ka8aq69B5GOvgGtgLoP0x5jmR/Pt/+NW/YR0GPsD0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxgUJKuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA60C4CEF1;
	Wed, 12 Nov 2025 18:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762972325;
	bh=rhYHIaDeRlqkfmPOJcKkkL6MWk98Yo8FHzQg9ppxXiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XxgUJKucqwpnqFajquRl8Zd0vK+MfyA65TGjwcjY+tJlFdF3RFAk7NAAGp9567X+3
	 2f+we+WKmh3O3LlAxx3dlAGlzeCnLftFkwyfkCoQt24ZAqfn1wV5N+8xevaCWM/Qi0
	 rgNRzafPx7FZzdTOuUuy9S8b/lSz8bLksBHzXHtZvBfCJ7zXVc6Nij5fcJZn5UYEus
	 bEDdHhVu0rnWAZmXJQ/TEYxdV2YS2hlyq8lZdqZuWWDB9WCDQhk6GmY5eBfovjQKzf
	 d/MTO7p1tHRDeqwOtltFxZJ0pGz+JagVC5SVl07WrvlCyBy5iOFoI5i93P/64hli+I
	 NXOkZYD5QQoJA==
Date: Wed, 12 Nov 2025 18:32:01 +0000
From: Conor Dooley <conor@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, vkoul@kernel.org,
	kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: phy: lan966x: Add optional
 microchip,sx-tx/rx-inverted
Message-ID: <20251112-junkman-buckle-31fcfcbfa3c5@spud>
References: <20251110110536.2596490-1-horatiu.vultur@microchip.com>
 <20251110110536.2596490-3-horatiu.vultur@microchip.com>
 <20251110-unwound-award-a11d69b9da4f@spud>
 <20251111095831.lp4kvdfcahtwgrqc@DEN-DL-M31836.microchip.com>
 <58b0d712-48a4-4490-a63f-404716844557@kernel.org>
 <20251111-ploy-dispersal-164ae403df4d@spud>
 <20251112080235.c5iinfnketsunefy@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5ULl6H7+uUD9DWU7"
Content-Disposition: inline
In-Reply-To: <20251112080235.c5iinfnketsunefy@DEN-DL-M31836.microchip.com>


--5ULl6H7+uUD9DWU7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 09:02:35AM +0100, Horatiu Vultur wrote:
> The 11/11/2025 17:39, Conor Dooley wrote:
> > On Tue, Nov 11, 2025 at 11:06:02AM +0100, Krzysztof Kozlowski wrote:
> > > On 11/11/2025 10:58, Horatiu Vultur wrote:
> > > > The 11/10/2025 18:43, Conor Dooley wrote:
> > > >=20
> > > > Hi Conor,
> > > >=20
> > > >> On Mon, Nov 10, 2025 at 12:05:36PM +0100, Horatiu Vultur wrote:
> > > >>> This allows to invert the N and P signals of the RX and TX Serdes
> > > >>> signals. This option allows the board designer to trace their sig=
nals
> > > >>> easier on the boards.
> > > >>
> > > >> Why can't this just be done in software, debugfs or something like=
 that?
> > > >> Maybe it's just your description is poor, but sounds like the inte=
ntion
> > > >> here is to just switch things around for debug purposes.
> > > >=20
> > > > I don't think it should be done through debugfs. As this describes =
the
> > > > board layout and I don't think someone will want to change it at
> > > > runtime to see how things behave. So maybe the description is poor.
> > >=20
> > > You said it is purely for hardware designer to trace signals, so sorr=
y,
> > > but that's not DTs purpose.
> >=20
> > If it is not purely some sort of debug helper, then please explain
> > better in your commit message.
>=20
> Yes, I will do so because I don't see how this is a debug helper
> functionality. I see it as changing the polarity of some pins and there

The word "trace" here might be problematic? Maybe you meant something
like "lay out", but all of the use of the word tracing in electronics
that I have ever seen refers to troubleshooting - be that physically
following signals to see if there's degradation or things like the
trace framework in linux.

> are few examples in the devicetree bindings where pins change the
> polarity. Why I see it as changing the polarity is because the
> N(negative) will become P(positive) and the P(positive) will become the
> N(negative), so we just invert the signals.

--5ULl6H7+uUD9DWU7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRTSoQAKCRB4tDGHoIJi
0imiAQCuvPVj5pCt0I4n4uPayM4eKjorWxB+tswfVsc6jE04EwEAusBqIYkcPuvM
u0XmSCHD6wSTz43Y5uWyQdojJ+Pqswg=
=t3BV
-----END PGP SIGNATURE-----

--5ULl6H7+uUD9DWU7--

