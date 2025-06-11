Return-Path: <linux-kernel+bounces-682012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB783AD5A76
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 17:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970E11882199
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 15:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFA8170A37;
	Wed, 11 Jun 2025 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcDwzFZd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE4C1A5BA4;
	Wed, 11 Jun 2025 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655273; cv=none; b=GOmRfhr8iglfrn/r4t+jJ7eZbeWC3oZlNpBnK0gxI6V0MKfPEMUjPeECOAFLLSlyW6OEfXQCkClM9D16naxAWBVEcEa1RDzrS/bbpqVSZCqsEFy5bkDhH32iAKhoSIuUU6bByCpfk6bENwVL/mXFODNLBJIK/iWsgtuZwspFCW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655273; c=relaxed/simple;
	bh=DKHEZr32zYDl99R0N+Wj4UUft/P2f5v9PTCILH9uK90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNcRdcGY5N+cZcvl0/OUErAR3OArV6IijLZyF1C8JDdVPNojpKGe4zoQV21RpSnqkOdI8tcnP43QUT07pMiZGAqgp8wZrPr8njVLwmgnsI+XdbFHJx8kFtX2UGqcu27edOsAiKnZh/ro92AHBL8dSSG6nil4J9duorQ/JWsQt4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcDwzFZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19287C4CEE3;
	Wed, 11 Jun 2025 15:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749655273;
	bh=DKHEZr32zYDl99R0N+Wj4UUft/P2f5v9PTCILH9uK90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NcDwzFZdWXwz9IooI7nmf21LRpBX/cPOAZNQVwMRD9Gxm1hp+C2IKKz4htVXQaFLe
	 5wpKAVVRazh2OLhNPg/DKTduO+4r7wFCD7UJaHG205159w6JHKx/uk+pc3N4ryRm1E
	 TiKBh64WADr2Zmu/X+IsHnLHp5nfhNBDrwfiaFJQEiPOkOqfN7eiKb1+BSDML306/P
	 E2eE6+0xgO3L502sRvF4DbbkYelb6sqifK2Po0r278zsjzkcZGb+6AM+CdxB2gxQ1Z
	 BXOGLGeWUxyspwwtp2JHex2TsZq9Kt/hFBbAgJZ9ZUDWz82ueTukJuoYMusgSuQrmt
	 FgJHTQw+tnKQw==
Date: Wed, 11 Jun 2025 16:21:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: catalin.marinas@arm.com, pcc@google.com, will@kernel.org,
	anshuman.khandual@arm.com, joey.gouly@arm.com,
	yury.khrustalev@arm.com, maz@kernel.org, oliver.upton@linux.dev,
	frederic@kernel.org, akpm@linux-foundation.org, surenb@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 6/9] kselftest/arm64/mte: add address tag related
 macro and function
Message-ID: <8e4aec59-88b1-4246-86e7-c438a141f215@sirena.org.uk>
References: <20250611135818.31070-1-yeoreum.yun@arm.com>
 <20250611135818.31070-7-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2N7Eqyu4U9441N1y"
Content-Disposition: inline
In-Reply-To: <20250611135818.31070-7-yeoreum.yun@arm.com>
X-Cookie: No skis take rocks like rental skis!


--2N7Eqyu4U9441N1y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 11, 2025 at 02:58:15PM +0100, Yeoreum Yun wrote:
> Add address tag related macro and function to test MTE_FAR feature.

Reviewed-by: Mark Brown <broonie@kernel.org>

--2N7Eqyu4U9441N1y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhJnuEACgkQJNaLcl1U
h9AJZwf+Jmz0qS5BNCoNsu5FojFhbVbD85Z9kyXCCOohJef2tuyya4XJgIe/VkUi
a78ffvoXTOa1enVTB8PIKDEgKH+5WgWMQaHmRUElXH5oWTf0WNxpixppEIVAVH0W
LZXRS3XA6rVKgIOiermPXoKA9db35TnbQUBvLgK1uyqig+ffKiYHj5GxCfoAPKyK
k/AS0TSBlawcDTolSWxGXf4FTJWd7M4S/Lgrq6NdRlIB+E825j7SL9pmYiOUTjCW
yqbXiUUGZfSdsOctX4hrkxapUi7TIMJ8PjjUOuVs2kbKUCCqKAde8BjYJ6N5VGVr
uCrIMTzbCvmLjvHVaEFRaDM+BeKCNA==
=DQq1
-----END PGP SIGNATURE-----

--2N7Eqyu4U9441N1y--

