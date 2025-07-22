Return-Path: <linux-kernel+bounces-741642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E889B0E723
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 01:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9253156589A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFDE289809;
	Tue, 22 Jul 2025 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hkgaunPK"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A53F242925
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753226570; cv=none; b=jBMkukg473Kok1DDgiolK6aY55NOPXNTPi9lnKUzMRlGTRzoj5vKgAzQo8DWdyhl8Tj3tHDy+Q7RXRTDz/SifqKANhSR+Pm+SJewUNEIM3YAoJJwDgUflgML9akU+tXLDuV9mOgeotNQzG4+NZyYcNov+UPi9w+KsRIPGCIBYsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753226570; c=relaxed/simple;
	bh=x8byBPpEXxWatkvCWs7x97Jr9xkqRXLni8IvMAfRSEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ePDRTQYXLGHaqfTajjZVqkVgEI2i3+QSVOK4xxItx18c+D6cn9xS4d75M65Vxrn7OhvVMp73Toodyh6fEuiLbgo2cylpKXS12OfsPDg59f+ZQlVFSYuGgkfGrGMvhnxONSQJ+dfJBpN2ojH1X2xVjbEBBh9UmGVqcZoQ0lA93R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=hkgaunPK; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1753226401;
	bh=I6+4AojL6apT7pBl3Dr61QWpp9cicoMY/IflLlo6moE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hkgaunPKJMQq2e81bD74L0ZesWHNIWj3oIX6Bv4f/kbTzCQoDCg7Vm7fYB6QAzCQb
	 9vtweeaccFrirKsdWEkwzuShzOCWmFgFDKS9osEDVzxaMPoUTRDXmHfiBAdOKGlM6j
	 i6oh4uukm7fR+PqWH8yEAGEpOYnxDoYyIn7fsXrhtD/oLz71BrZJg1pAdBViY8eceA
	 ZNP3wy84/LCW9Fpl8j3hnWZFnyopFy+6tzJpb7f2vYxh7JGFgPt9PBji/xSg14LgZp
	 0woJAJnrEG6RdW6I3LdX5R28sD14DB9Fk3nhaC0McfAMUhXDDg8C5f0xXxDdzdAB5f
	 olPixOFMQT3aw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4bmtXJ358rz4x7F;
	Wed, 23 Jul 2025 09:20:00 +1000 (AEST)
Date: Wed, 23 Jul 2025 09:22:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch:powerpc:tools This file was missing shebang line,
 so added it
Message-ID: <20250723092243.7056fda4@canb.auug.org.au>
In-Reply-To: <20250722220043.14862-1-unixbhaskar@gmail.com>
References: <20250722220043.14862-1-unixbhaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jF+OHy2nqh20Km65bZTZda+";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/jF+OHy2nqh20Km65bZTZda+
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Bhaskar,

On Wed, 23 Jul 2025 03:29:36 +0530 Bhaskar Chowdhury <unixbhaskar@gmail.com=
> wrote:
>
> This file was missing the shebang line, so added it.
>=20
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  arch/powerpc/tools/head_check.sh | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/powerpc/tools/head_check.sh b/arch/powerpc/tools/head_c=
heck.sh
> index 689907cda996..a9cd06958921 100644
> --- a/arch/powerpc/tools/head_check.sh
> +++ b/arch/powerpc/tools/head_check.sh
> @@ -1,3 +1,4 @@
> +#!/bin/sh
>  # Copyright =C2=A9 2016 IBM Corporation
>=20
>  # This program is free software; you can redistribute it and/or

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

I used "shellcheck -s sh" to double check that it is in fact a bourne
shell script and it is invoked with $(CONFIG_SHELL), so it had better
be :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/jF+OHy2nqh20Km65bZTZda+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmiAHUMACgkQAVBC80lX
0GxLhQgAoWwpJ+cqayclBRh58CAfTt4q8zaZwKDB6vTZTUPvoqVa/OOLw4a7wJHs
2T3rRx1Muq7gz5qjLFf7aaiQirIUMLk1mYCWiQ1QsVFWJ+8Nmy0zonEPP0m1Z7dN
22E7BQGke1R4C5r0rmEi5hoCUWLAitQrN2CFQglvx1IQs3DP+2lexirD0pdfBjdF
ttza1JCotNaWHjM0m6jByGlmc6dmUFjIttr8JULzYgO475QDvj/IjQm/nIRWJx5g
MWRhCk+Waz4fyT75dlQaDX8P3BfVLJldjtcu6HljwA5eSsMYYG7WKpi7mrqx+OaG
fSvKyKRhDfuRiP1KpflprETAcrkMtg==
=w66r
-----END PGP SIGNATURE-----

--Sig_/jF+OHy2nqh20Km65bZTZda+--

