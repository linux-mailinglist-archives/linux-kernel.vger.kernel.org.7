Return-Path: <linux-kernel+bounces-895928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F1CC4F497
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D20B3A568C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0113835A142;
	Tue, 11 Nov 2025 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3X81y3t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6643AA1BB;
	Tue, 11 Nov 2025 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882781; cv=none; b=Qk8Et+tFJ2VA72xfL+2JOHKzckTG+ID0lyWQdyUjOwqCRm2WSGI5datbDxizakYs87WNEz2Ne1EOXp5r7btfsls+Jtk+oSKMo1+idZ7Dwksv2AGfB/Yfo0+1o9SyrD9wPeCzjrZqBiKP2QEFtY/SUywEq+lmpphLLBoXW2gk8Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882781; c=relaxed/simple;
	bh=sseQu7nEnCDYeW52KYqIspyMDbjPaOYXv8zmuvR97Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6Q13ptUtU4AasJY6oHXlHPJYqQtJhrMESSuw94ddfCRDbhQWvh7wUdab1c2e9gyii0c/1iomBGuDN2BztWHxwhT20s+dsV8dUE6Q7Ewm3ocPNe3LulLvuxE8RXXIfGYDhr81/wrjexxn4UzewCeTqF72Mx34uXqQX/o6HukygU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3X81y3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBED7C4AF09;
	Tue, 11 Nov 2025 17:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762882781;
	bh=sseQu7nEnCDYeW52KYqIspyMDbjPaOYXv8zmuvR97Oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j3X81y3t3PaO98JTZFp4iznbfvlF++ownPmqswSJk4zRn457qMOpFJbmDRUtIL6NK
	 2kFMgd/vm2S+qwDNe2cw3xN1ysTcAy2YewYBcvh5llUJyFAHEBeXVpi4n5uU54jzLG
	 2hs6rb8Wpfhdv4uWIUh5A8QCKFYbYM+JsJVuikzTa2B67xzkAj+BW2AE6tk/NhoLiE
	 MGgzDf9FdNGo2zizIl0T9345ljSVQbx3j+ubtSsk5jnvtoS/Yyds//K6c1ohU+mWts
	 xq2LhorxwXt13x8u+sDQqQyezmEuBNWKrb2d/Lzc2yw6x6La5vghfyLxvhGFgpUqSj
	 ldXqeobgZaslQ==
Date: Tue, 11 Nov 2025 17:39:36 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>, vkoul@kernel.org,
	kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: phy: lan966x: Add optional
 microchip,sx-tx/rx-inverted
Message-ID: <20251111-ploy-dispersal-164ae403df4d@spud>
References: <20251110110536.2596490-1-horatiu.vultur@microchip.com>
 <20251110110536.2596490-3-horatiu.vultur@microchip.com>
 <20251110-unwound-award-a11d69b9da4f@spud>
 <20251111095831.lp4kvdfcahtwgrqc@DEN-DL-M31836.microchip.com>
 <58b0d712-48a4-4490-a63f-404716844557@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5voBWClPfG+Dchvf"
Content-Disposition: inline
In-Reply-To: <58b0d712-48a4-4490-a63f-404716844557@kernel.org>


--5voBWClPfG+Dchvf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 11:06:02AM +0100, Krzysztof Kozlowski wrote:
> On 11/11/2025 10:58, Horatiu Vultur wrote:
> > The 11/10/2025 18:43, Conor Dooley wrote:
> >=20
> > Hi Conor,
> >=20
> >> On Mon, Nov 10, 2025 at 12:05:36PM +0100, Horatiu Vultur wrote:
> >>> This allows to invert the N and P signals of the RX and TX Serdes
> >>> signals. This option allows the board designer to trace their signals
> >>> easier on the boards.
> >>
> >> Why can't this just be done in software, debugfs or something like tha=
t?
> >> Maybe it's just your description is poor, but sounds like the intention
> >> here is to just switch things around for debug purposes.
> >=20
> > I don't think it should be done through debugfs. As this describes the
> > board layout and I don't think someone will want to change it at
> > runtime to see how things behave. So maybe the description is poor.
>=20
> You said it is purely for hardware designer to trace signals, so sorry,
> but that's not DTs purpose.

If it is not purely some sort of debug helper, then please explain
better in your commit message.
pw-bot: changes-requested

--5voBWClPfG+Dchvf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRN02AAKCRB4tDGHoIJi
0rtuAP4stxlbERYZwunofMFT0CVT0k9d3WxbTURjHCnGuuIivAEAgt0wZFJVzyEE
m31MhjAt4FgLLZa2KMXLuaQ/YLV9nA0=
=HEIc
-----END PGP SIGNATURE-----

--5voBWClPfG+Dchvf--

