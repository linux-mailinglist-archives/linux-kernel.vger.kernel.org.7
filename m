Return-Path: <linux-kernel+bounces-795829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A4CB3F86E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B823F48447C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CC32E8DE8;
	Tue,  2 Sep 2025 08:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPj/femy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5326E6F4;
	Tue,  2 Sep 2025 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801920; cv=none; b=Y1Pr+gPOcRnf2xWK15WM8hIa28CAY8+gShctot5jc5TM0tPpHEkkMJX6V4yabdgzp15JMVsQUKeMAagKSvnGNvmznTN+OGzVchqcApJKiiKduk7ANojFnZulryRXLzMbRju1K6/1YMxi+HKiP+Qc0y0WXZpV3u0fdpV9IdpgF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801920; c=relaxed/simple;
	bh=BwvrsUILXXQB7764p4DzmtJB/r81NX9Scwk2zl5D/7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpp5d3jwlNfgvVeVNxWlIbYw0Rb0/VEXKlunZw6OuC3e9w5PUdWsYjnrdsbMZldn97Q/funiyn/OJF9rS+efxpyxhrbI11UpUMzVB/a6BQTijif8D1WU0KHGbdWzIc1IcdcpPsk+kaIifIdAFt6DyxwVDVwwYkg0662R+UPCBhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPj/femy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A782DC4CEED;
	Tue,  2 Sep 2025 08:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756801920;
	bh=BwvrsUILXXQB7764p4DzmtJB/r81NX9Scwk2zl5D/7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cPj/femy7sIQIdSlmj2vBKdGlpv5IexFe9S1iVHOlzAYUJJvx7KAHlpPAV9z0QjnH
	 3Ga/ZNM4lW0cZ3jC5Gxf979DQ5eDD5OiyRGEy987huKdVx3st/ohCMmryizb3+quyh
	 ATovauMRiCZJ3fd10qAtj49h3Wv02O4CEHeGBGqV6QujsYhib4L+7YslB6IF4mYKHX
	 gs9WVMG+Y50TZyfnLaSFyVrQ5J4xM61bvtWcSc0bFpb/6AIe8Jw97Ao3Qvi291i2ky
	 LBhsBN3cgF7a0EZdbWT56lg/CiQ0wZ7MsfjnR/BuKqKBDsEA7hbpl5oD8GVv7Ss4Sg
	 WlbRKNnmcgmhw==
Date: Tue, 2 Sep 2025 09:31:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Valentina.FernandezAlanis@microchip.com, Conor.Dooley@microchip.com,
	Daire.McNamara@microchip.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, robh@kernel.org, krzk+dt@kernel.org,
	aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v1 5/5] riscv: dts: microchip: add a device tree for
 Discovery Kit
Message-ID: <20250902-affair-scrambler-2771df16372e@spud>
References: <20250825161952.3902672-1-valentina.fernandezalanis@microchip.com>
 <20250825161952.3902672-6-valentina.fernandezalanis@microchip.com>
 <2b1eb8fd-2a64-4745-ad93-abc53d240b69@kernel.org>
 <bb5b0d71-41b1-48a0-82fc-bdb362cc3db1@microchip.com>
 <0d90eeb4-e6ac-459c-a6b1-26368f102e0e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sBKmyEoEsZN8MIqu"
Content-Disposition: inline
In-Reply-To: <0d90eeb4-e6ac-459c-a6b1-26368f102e0e@kernel.org>


--sBKmyEoEsZN8MIqu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2025 at 08:22:02AM +0200, Krzysztof Kozlowski wrote:

> >>> +     refclk_ccc: cccrefclk {
> >>
> >> Please use name for all fixed clocks which matches current format
> >> recommendation: 'clock-<freq>' (see also the pattern in the binding for
> >> any other options).
> >>
> >> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/Documentation/devicetree/bindings/clock/fixed-clock.yaml
> > The fabric dtsi describes elements configured by the FPGA bitstream.=20
> > This node is named as such because the Clock Conditioner Circuit CCC's=
=20
> > reference clock source is set by the FPGA bitstream, while its frequenc=
y=20
> > is determined by an on-board oscillator.
> >=20
> > Hope this clarifies the rationale behind the node name.
> No, because there is no style naming clocks like this. Neither proper
> suffix, nor prefix. Use standard naming.

So you want all fixed frequency clocks to be named "clk-foo" when
"clk-<freq>" is not suitable? Fine if you do, but I didn't realise that
it was required and haven't been keeping an eye out for it.

--sBKmyEoEsZN8MIqu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLarewAKCRB4tDGHoIJi
0t4LAP92WccRzBcu/OA343s5xK/k5BKq3m3GuOrSMLTqipOI/wD/UEFyYz9GTEOx
AKa0iN/M4nMy/nu7o/1nvvh0ixfi7gY=
=2RWY
-----END PGP SIGNATURE-----

--sBKmyEoEsZN8MIqu--

