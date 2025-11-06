Return-Path: <linux-kernel+bounces-888988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B85C3C6E9
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E1B3B9AF5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60733570D0;
	Thu,  6 Nov 2025 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jH7Gu7G6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E746A34CFBC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445969; cv=none; b=cPcmPEsZHwz55bjAgX413gj6fNMqO2NtX/xDx91lmAjn8LuhkfgIdgKPl6KGHRFmb4fiQ5G2xHTjmAgkCcT+pKueU0CfMtceyjV/Kywul0rkC+sUz5JHnyxdP+FLHTJ6xPirnZioxXIsBKJl4xBLdWp5pEFDzr+D0NkMhezyGas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445969; c=relaxed/simple;
	bh=gYEqW7pTjmnipJi5Wy4m3ru4H5R578dICFIJMQfiHvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z54C7YN8BAXvpKCnBrRUSyzIzfAczmJ987e7xcf5ytqkLyjJwa1CdN42sosJyEo0FILG1PBg+U0gFahlCXiQn+e/IGlARTyP5BDH77WjjycPqblMzkJBHmvYExGW7mb4CvInGm2mTZgxcC5XD8ZH6+CgKnzwD8DMsBIddvS75hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jH7Gu7G6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E994DC116C6;
	Thu,  6 Nov 2025 16:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762445968;
	bh=gYEqW7pTjmnipJi5Wy4m3ru4H5R578dICFIJMQfiHvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jH7Gu7G6EGNodkceKgA2+Z2PEYCdQ7YslEv7MyzElCwS1PB1oDz8vP0CvLy+Ll7tQ
	 kej53UyfleI6hjBGg3Yxr1fIBJ7B8cmzY3+4kBbQlPqpxT3bqRCtzW4vl3ruAaDVRQ
	 u/RJiajdxO7CVyDR89UVpdgf9TxOAiDBlM/Oh7eYz1aC9Uwl41FzGu7nq2zuPGyEcV
	 VRtRaxCC2Jc/QXASpoGyscEm1jUTuwVBxczqoyzIYUOatTr2pENBzuoAa/7shu4gMY
	 6yIqPorGBKVaTailUucZlpP9dkUlzhNvZ6o5ZNT8h4JIjkDfn5z0u3GyLJYMHCN8Sv
	 PbkgUEXN1B5rA==
Date: Thu, 6 Nov 2025 16:19:25 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com, Ryan Houdek <houdek.ryan@fex-emu.org>,
	Billy Laws <blaws05@gmail.com>
Subject: Re: [RFC PATCH 1/1] arch: arm64: Implement unaligned atomic emulation
Message-ID: <aQzKjZci6kgMTziA@finisterre.sirena.org.uk>
Mail-Followup-To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com, Ryan Houdek <houdek.ryan@fex-emu.org>,
	Billy Laws <blaws05@gmail.com>
References: <20251106160735.2638485-1-andrealmeid@igalia.com>
 <20251106160735.2638485-2-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XqQkjShh4NKVWX0c"
Content-Disposition: inline
In-Reply-To: <20251106160735.2638485-2-andrealmeid@igalia.com>
X-Cookie: If in doubt, mumble.


--XqQkjShh4NKVWX0c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2025 at 01:07:35PM -0300, Andr=E9 Almeida wrote:

> +int set_unalign_atomic_ctl(unsigned int val)
> +{
> +	unsigned long valid_mask =3D PR_ARM64_UNALIGN_ATOMIC_EMULATE;
> +	if (val & ~valid_mask)
> +		return -EINVAL;
> +
> +	/*
> +	 * TODO: check if this is running in a ARM v8.1 or greater.
> +	 * Refuse otherwise.
> +	 */

The code should check for the specific feature you're relying on, not
the architecture level which isn't really a technically discoverable
thing, something like:

	if (!cpus_have_final_cap(ARM64_HAS_LDAPR))
		return -EINVAL;

--XqQkjShh4NKVWX0c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkMyokACgkQJNaLcl1U
h9BOhQf/VD+f+HyEnpIFksKgxLXU7d72NXlh1nSX4/yjfknSUrpBvaGlazKdJYEw
dzb4RIidHwSFc/5c0sQrNFj9TcvNAhsXtyl1XVBOhq5ciFalSQmH7U/inmfEdkqn
38OEgXR4iSDxuNntfTNbYNbwp8DGa6IYtTyyP7ijWr6//XeWcbv7MWWgtdDMhJvC
l+iTemYM671y/sCj1iOEUuuzXNGzdf4jpxZ5bQ2Zy/N7lAWeih6exHnbAo1LKTpM
MyZ2XjydJKneLttxX02ksw1xE0Wa2cxciSCZLiNMLhbIfuiAlguYRcF9vLmEn3tV
idJcKvq2oJTUs7Q7ehXcaSQ2TZwTRw==
=5Z1A
-----END PGP SIGNATURE-----

--XqQkjShh4NKVWX0c--

