Return-Path: <linux-kernel+bounces-733850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B62DB079CB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02EC165AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B70287245;
	Wed, 16 Jul 2025 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YY0GfXzV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE5E2E36EE;
	Wed, 16 Jul 2025 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679689; cv=none; b=r8BgoPw+y6xoR/mewKQzOgkthEzRzgv9BDt8LA0tRRgazeiFsSNU0Uzw4zLbPRIYyCnL/gGN0IC7rV0M3/6Q1XzbeeCcqfDwWQFSlQhOpuegv+epvsNaBuWrozXRVmIYw9w33Vf0PB8NABjjMr1FZ+Ot/NxWgyGLqeLohjnvsLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679689; c=relaxed/simple;
	bh=PLaFyrTZSgPQxnnq5A6CsW2wAd/VIdnrpt20+r3fAqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpO6TxDa/7i1dmuOA6ex17FvMjttrUMQIvb/xPUJQJkLaOPMmS2eyZDVekMEMvFbjfxOhuRsr2Mbtt6qGwSnu15HcflJ7TKP1ikD/YX9hddd8XyQm3xSFZ7TCGR7nYyb4bPtXrtJB1g0o3C7pp3Ouv8GGnJH+jZMPg8nkWqmzQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YY0GfXzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82A7C4CEE7;
	Wed, 16 Jul 2025 15:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752679689;
	bh=PLaFyrTZSgPQxnnq5A6CsW2wAd/VIdnrpt20+r3fAqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YY0GfXzVmoPInSKmyKY/Dem+gyeSPVk1nZbMmjfs+Gbv9kC+svGl8eg1H7yt9hW14
	 9WKr+U2TdMkCUq/XdSpXNy/f2l/ccVo1XAaERlXa3walgi2ymbSthHZN/I9Ba21vp8
	 REuJles6/tMu05ytWKYkyYJolPvn9pSogMuTl3BxZKLdnrq/gPDIZxFteuBribazZl
	 dO3WZISNcig0RO4eEYvmP8D35jItJpXegGkIoPfL36uCQqUxGSzgvYgZG8ogER8l6p
	 FJ9dB9v+tmSVzSdNuvwfd5xImb+alBlHBrWYrekY2+WXhGQ16mCLjCLoIGmCUtCBVP
	 Rfe86LtYJI9qQ==
Date: Wed, 16 Jul 2025 16:28:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: E Shattow <e@freeshell.de>, Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: starfive: jh7110-milkv-mars sort properties
Message-ID: <20250716-strategy-evasive-57b400af9366@spud>
References: <20250716061940.180231-1-e@freeshell.de>
 <CAJM55Z_77aygReSPJyZMtfZWk_UPYTzYLH5E5uEw6K=GSu0LNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QY1VDzpXbH2iHrik"
Content-Disposition: inline
In-Reply-To: <CAJM55Z_77aygReSPJyZMtfZWk_UPYTzYLH5E5uEw6K=GSu0LNQ@mail.gmail.com>


--QY1VDzpXbH2iHrik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 02:17:34AM -0700, Emil Renner Berthing wrote:
> E Shattow wrote:
> > Improve style with node property order sort of common properties before
> > vendor prefixes
> >
> > Signed-off-by: E Shattow <e@freeshell.de>
>=20
> Thanks!
>=20
> Acked-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

I'm going to pick this up, but it may be very late for 6.17.

--QY1VDzpXbH2iHrik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaHfFBAAKCRB4tDGHoIJi
0tbhAP49A33ooW0x1UZXm/4k6+tATPIUCFgFOI0V3816kY6f2QEA20//CID/p17f
FFRatvbs4sk7aWNyYzP3AzOCETAfYQY=
=T7Vt
-----END PGP SIGNATURE-----

--QY1VDzpXbH2iHrik--

