Return-Path: <linux-kernel+bounces-810798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AA7B51F87
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5C05E2448
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF2033769B;
	Wed, 10 Sep 2025 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCJWeY4z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2E3334702;
	Wed, 10 Sep 2025 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526956; cv=none; b=rZG5MB3YhdJfbKI3+h+jgi0PHAZKAs1t+G1PTuT/dKRtkb3itCq4WHxA125dSXit3Pk4j4uOw36aLFl0GDixgmbAfwlcEx2DKJPuu3bPCJh2oCN3qZxeiQC4p+q57G9YH+TOguY1NzmKlpbAXSB7bxLpzrsL7HTjNWFrHqkr4j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526956; c=relaxed/simple;
	bh=JVRXb5XrUwUv0N4CpWuSYojhTxosrZTNOjVAr0HhqxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kp4B01D16KksqIvO6b4uaZCGd4zIoBYV7HLjcDa44jxS1VK+hK2jpgFWnu963KZ2wUhpvvVVtE4kaG1mFP5N9VYa3U23s+iszIjc48kFv52KgNqN9usI7lW6+4hoISacNR8BKfd8LRo64i4Z6h652R7HqiRF38ngcyPNEJ/2au8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCJWeY4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8772C4CEEB;
	Wed, 10 Sep 2025 17:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757526956;
	bh=JVRXb5XrUwUv0N4CpWuSYojhTxosrZTNOjVAr0HhqxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fCJWeY4zVR3ckpzLM9+4lFrn0f6wbjhI1YwZLJUpF77KUb7fQ8d6V47nHN/A+qwsK
	 CUt2qDd9i8Kq2mgSs3wlmMSTjWCZjfUHRMqTO1/acJ/LWS7IwEIMlaECtuNZUDOp/o
	 6yFDoJLhM7AS6W1AVK32Y0RO1SNCvntp+TY/wHgeTmod75UTl66jezZdZ1Jt7lWIbw
	 DRnUWRSOX2ogJHIJv7J7qG82hii/YDaqSH8Uf2b/09FzM42Q8V3Ic/NsiZueZ7akUZ
	 1wkIofTXZVSJkqlOn3N9XRjp6s2mDWdn6JEpbwb7AGyGoVAleOCUEO6v1s6lBBtk9E
	 nZcVDkUUD+NtQ==
Date: Wed, 10 Sep 2025 18:55:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Cc: conor.dooley@microchip.com, daire.mcnamara@microchip.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, robh@kernel.org,
	krzk+dt@kernel.org, aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Icicle Kit with prod device and Discovery Kit
 support
Message-ID: <20250910-visa-fanfare-ec0bfa5c588c@spud>
References: <20250908115732.31092-1-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wmJi2N4SPCruLI6A"
Content-Disposition: inline
In-Reply-To: <20250908115732.31092-1-valentina.fernandezalanis@microchip.com>


--wmJi2N4SPCruLI6A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 08, 2025 at 12:57:26PM +0100, Valentina Fernandez wrote:
> Hi all,
>=20
> With the introduction of the Icicle Kit with the production device
> (MPFS250T) to the market, it's necessary to distinguish it from the
> engineering sample (-es) variant. This is because engineering samples
> cannot write to flash from the MSS, as noted in the PolarFire SoC
> FPGA ES errata.
>=20
> This series adds a common board DTSI for the Icicle Kit, containing
> hardware shared by both the engineering sample and production
> versions, as well as a DTS for each Icicle Kit variant.
>=20
> The last two patches add support for the PolarFire SoC Discovery Kit
> board.
>=20
> Changes since v2:
>  - rename ccc clock to clock-cccref to match fixed clock binding
>=20
> Changes since v1:
>  - fix order of properties in mailbox nodes
>  - drop redundant status property from ddrc_cache nodes
>  - fix lowercase hex in reserved memory regions

I've replaced v1 with this version in my tree.

--wmJi2N4SPCruLI6A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMG7pwAKCRB4tDGHoIJi
0n+KAP0df8X1MKkS1jU9l8y6r6wOiHtADWf19177Ot3ZLlxOhAD/Xq9lijPzz1iX
/KZKqkiYmVREk41nVDYhFiocw79apws=
=GbN8
-----END PGP SIGNATURE-----

--wmJi2N4SPCruLI6A--

