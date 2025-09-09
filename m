Return-Path: <linux-kernel+bounces-807517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5211EB4A570
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E104E03CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A54C2566D3;
	Tue,  9 Sep 2025 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7Am5K2s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCF72566D2;
	Tue,  9 Sep 2025 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406953; cv=none; b=tmMK7tO41mskeC/QGcWJ/jSgHO/PCTGKkZy8igPUDR9OhfPr/e1Qtf+nWqvqf6k/utLydbJnCGRCtJlt8Nc1+sZVTBZFRYH1CaLT6vJbt9Gu9O5NwSPEQk9sJSehkEu4uK+59AtIVRPLCknV81QTeX0E3ZAsrIK9V340NIwNSsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406953; c=relaxed/simple;
	bh=wz0UHmZkyV0Vbp6rUO0Hwq4qZc9k9fz9jblD2E/udtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PipKKUmDndgAn97zF4grxKcE1+KjU+7r9UVzMIwbnpPGnV/XqyLZ6o0vTpvU6iu2IvGOuiSDurQCTsxVjMDUnSFcpE2UhdIG2/YKHxRRmaXWg1WgXNGZzo2Q7Y3YN6aX8ymKiV8lfnHdYn7/VmYTL2zIAzBVQ5ev0j5Z6BaBzw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7Am5K2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12690C4CEF4;
	Tue,  9 Sep 2025 08:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757406951;
	bh=wz0UHmZkyV0Vbp6rUO0Hwq4qZc9k9fz9jblD2E/udtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n7Am5K2sWCsKvH3sK7JjAxAmM4Ho9ll9VGlBR2qNYGfpc5LuQVZr9sBlkE474DL0h
	 KyQLjavEICKkr49s4AN1SlvCjY8U5KHRXIK29F5qfP8azaStVhx18V17iOgnFSOada
	 ukfefVuMlGq+RkU+jIo39oGutPwZaPT7sbxT/ksUSdOtHZ9znMpt6XLC9X+UL1y+QT
	 K81sGcgRv8zW4yneISzMgN35vca0omHxiOHIAIlVhUzcL1j/DLALAzR4xSEdLsJiT9
	 7DFdIUKlxpcyBmX//FRxxXCERIbufdsR6lCFiXG5osH8nF5ta+TDWI4mFSJMETvMK1
	 orjQR/S1vaVYA==
Date: Tue, 9 Sep 2025 09:35:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	conor.dooley@microchip.com, daire.mcnamara@microchip.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, robh@kernel.org,
	krzk+dt@kernel.org, aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/6] dt-bindings: riscv: microchip: document icicle
 kit with production device
Message-ID: <20250909-division-fetch-01bf5027f6d9@spud>
References: <20250908115732.31092-1-valentina.fernandezalanis@microchip.com>
 <20250908115732.31092-3-valentina.fernandezalanis@microchip.com>
 <20250909-accurate-wisteria-spider-222341@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xnYwVAd+w3ZrbIcG"
Content-Disposition: inline
In-Reply-To: <20250909-accurate-wisteria-spider-222341@kuoka>


--xnYwVAd+w3ZrbIcG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 08:53:05AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Sep 08, 2025 at 12:57:28PM +0100, Valentina Fernandez wrote:
> > With the introduction of the Icicle Kit using the production MPFS250T
> > device, it's necessary to distinguish it from the engineering sample
> > (-es) variant. Engineering samples cannot write to flash from the MSS,
> > as noted in the PolarFire SoC FPGA ES errata.
> >=20
> > Add specific compatibles for the Icicle Kit with Production device
> > (MPFS250T) and Icicle Kit with Engineering Sample (MPFS250T_ES).
> >=20
> > The icicle kit reference designs in the v2025.07 release include the
> > Mi-V IHC IP v2, used to send/receive data between clusters when
> > using Asymmetric Multiprocessing (AMP) mode.
> >=20
> > In reference design releases prior to v2025.07, the MI-V IHC subsystem
> > was included as a proof of concept in the design prior to becoming an
> > IP available in the Libero catalog.
> >=20
> > Among other improvements, the new Mi-V IHC IP v2 includes some
> > changes to the register map. For this reason, make use of a new
> > reference design compatible to denote that v2025.07 reference design
> > releases are not backwards compatible.
> >=20
> > Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip=
=2Ecom>
> > ---
> >  Documentation/devicetree/bindings/riscv/microchip.yaml | 8 ++++++++
> >  1 file changed, 8 insertions(+)
>=20
> Why are you sending patches which are already applied? For two weeks?

That's probably my bad, I dropped the series when you had complaints
about the version that I applied and forgot to mention it.

--xnYwVAd+w3ZrbIcG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaL/m4gAKCRB4tDGHoIJi
0mR3AP97FGlnUbQYSGCOJbP/F4fIUOtaxL8XQBiJqV80n/g4pgD9EJ0WkjjcrSzE
QXVSt2O+TY+hK9UkHkQof+bWrew1/gg=
=5rHi
-----END PGP SIGNATURE-----

--xnYwVAd+w3ZrbIcG--

