Return-Path: <linux-kernel+bounces-895672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90229C4E9E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5A9189F10E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325C33054D7;
	Tue, 11 Nov 2025 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZ9h97pB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C9A31077A;
	Tue, 11 Nov 2025 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872692; cv=none; b=aVm1yCkWa6nYMeyHWogfZgL/NfzfEKEX1fkO8K+IfpLA98FvC+TAEw/Uys3GpdXNSAyAQXBPTlIMmUcuNNFRFV8JZ2rBzuR4IKE7yQKegnicfLHdiWBQaDJP6OQbxFtn9F6DcWB1b0UZ1tfTgXhhf9CC/T4sJBZs7JcglXxiHrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872692; c=relaxed/simple;
	bh=wq3D/UP2DwAZYD7ydHRVTCVqJ0y6XdZO4cbSwhxOh8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akZcVn2OXxu88pqSnYvW8fA9gsZVW+zreYhXnOHd7LEmyxOMF6cm7fzg833wGRIjc+s0+Sf5vy4wV5dPbb+IWZiwq3Prdkd78AaEO7FY1gmxJe2eu9rTqcNm1SzqoZZm8Ibp0zaCWAKFC30lBDlNOG1wcAZ9Z+f9CEYZI8BrPRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZ9h97pB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9B5C116D0;
	Tue, 11 Nov 2025 14:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762872692;
	bh=wq3D/UP2DwAZYD7ydHRVTCVqJ0y6XdZO4cbSwhxOh8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pZ9h97pBy236J/JadiVE9rqfQgnit4dHVC94ZG/+pjvfKsWzJRO3zr1I1/ThDUq5J
	 xJwejyXIRJQhhy3BrSpWVmIpLFZY9UblrqeALKo1NhukOij3NM6kGF1iX76UMEvEQq
	 nHQg5AZdbnuskG48iyd20n53oWQSojriFs1QmBgHGkRuUhVvNwNgc1s3qkX4/9TSjX
	 h39MMWen6rVaKxjMTk6bqO+18IIq28t59uG4m39I1IKfHWhwCQer88qKgdOF0jHtHj
	 AOOHU21vbskpjHlMSnPu+iKBoE3qTZY0cgXUX2OUcp+5Q6OWPyE9QKbZiTIPeUup9X
	 ghuzaOhZKcmWw==
Date: Tue, 11 Nov 2025 14:51:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH 2/2] ASoC: cs35l56: Allow restoring factory calibration
 through ALSA control
Message-ID: <aRNNcLhOlr01drG4@finisterre.sirena.org.uk>
References: <20251111130850.513969-1-rf@opensource.cirrus.com>
 <20251111130850.513969-3-rf@opensource.cirrus.com>
 <aRM_a09S-_avzLUR@finisterre.sirena.org.uk>
 <40da8e34-f020-46ad-b3c7-ae48832b5563@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GNsiqIsL0Z0ic2Sr"
Content-Disposition: inline
In-Reply-To: <40da8e34-f020-46ad-b3c7-ae48832b5563@opensource.cirrus.com>
X-Cookie: You dialed 5483.


--GNsiqIsL0Z0ic2Sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 11, 2025 at 01:59:28PM +0000, Richard Fitzgerald wrote:
> On 11/11/2025 1:51 pm, Mark Brown wrote:

> > Not a big deal (don't bother with a new version) but N is the default
> > default.

> Well, at least it self-documents that we _want_ N to be the default.
> But if that's considered bad grammar I don't mind if it's removed.

Yes, I can see why you did it.  I don't super care either way, but I
suspect someone will come along and clean it up.

--GNsiqIsL0Z0ic2Sr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkTTWwACgkQJNaLcl1U
h9CgGQf+IaLM3vmGQN1D6bne7dT2Y4P0yeZj421fa7dkfbbzolaroShxh1uXWnbv
Twt+48c8DSGjC3WldmzCT5xHiOEoenZbCCt8+vIHC1E6vUYX2c6hqLaGRlqcYOyv
gABK1KMHw9/eg1naLsjXTu4NxSvzO75a3b/MTy+gfNIgpSa+TYpceBOkssDpkmOt
wfdymDbzPoDjLob3uPqFhRfNDiMa2rPMoW6v/jVplDgDB5oyu3RfVQ/JzURDFqMV
zcsnnZXNlYqQw2ttCt1G44vwCn3NQCFrX+QRlcvBiiYdJQajO9Y8JxBCOCUuDvLn
MNpyAWLYmEsk5jPmLoYx53f33bWRIg==
=w58f
-----END PGP SIGNATURE-----

--GNsiqIsL0Z0ic2Sr--

