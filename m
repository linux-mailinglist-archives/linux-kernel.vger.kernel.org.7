Return-Path: <linux-kernel+bounces-858142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D68F5BE91BA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4761A64825
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C56E36998D;
	Fri, 17 Oct 2025 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1OZaAO9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7CE32D0FA;
	Fri, 17 Oct 2025 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710303; cv=none; b=kvCVZXn9Zc+ZHHk90uqCdn4bPgo6yzc7QVZXTjjOeKY8htCdY08Nn7ZYS58lWIKx85uMEYx2pV9475A1e7DiQnlHxnkGfrJFgX777rJhvx4d9rGZT8UBnZtXN++bk9XvRwErhctxmrSRnnAKPXxxUId3mAq6o1GYEUni28u3Nx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710303; c=relaxed/simple;
	bh=xERAN/e5Cm/8/5cXZP+oMVP58AS5r9et6b6usC7SpgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ao1C+4YbIDi86Cf2Y5kZjbJr3WVQmxcEbr4C6+psYksO0K7SP6U8CnY+4ZBFr+GqRlvFif5mypCLhTve6+brapqq1vxcwHqXFx7LR8leOZI0OaLD+Hm9cTiU2L95EPUG+2HUpclfxZmOkwRPwAJP9jUy1QtNyXGv0R65U8PZmdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1OZaAO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FE3C4CEE7;
	Fri, 17 Oct 2025 14:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760710303;
	bh=xERAN/e5Cm/8/5cXZP+oMVP58AS5r9et6b6usC7SpgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W1OZaAO9NXxFEECaksL8+KZKzkBZuLtbPmjnjH3KZZySzoci57ZaD644SqBnT+BVC
	 2x8jP5ji/HapEsnyQuuisogdT6ONVmVOZkTBIUqzTDiqSLHreJqfJjCILN48G7MPmX
	 C3E1F5/7LH3P7s4tKRhKpLqY+sNMXJ0T4oJa6VxofJtvDUEYVk6r1FddNwoShQY6Ow
	 UJX/yZrZK28Rqv0dFThVQ+wN4SlF9TNVZ6Wq5ADuZLEBbOOfnfu6IaxXbx3g4mr1W+
	 CmSxhh/b3cABZmAkkcPfqlFnGAb2LAq0QLL1g6tip+mMXGd7G0PuurpilNgXgIgaC2
	 DNLaVAgwj14+w==
Date: Fri, 17 Oct 2025 15:11:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com, Vijendar.Mukunda@amd.com
Subject: Re: [PATCH 0/2] ASoC: amd: ps: Propagate the PCI subsystem Vendor
 and Device IDs
Message-ID: <f1a59057-a054-4d22-8207-b13db3821bfd@sirena.org.uk>
References: <20251016150649.320277-1-simont@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZxO3SKlPFBf4OkSj"
Content-Disposition: inline
In-Reply-To: <20251016150649.320277-1-simont@opensource.cirrus.com>
X-Cookie: Androphobia:


--ZxO3SKlPFBf4OkSj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2025 at 03:06:47PM +0000, Simon Trimmer wrote:
> This chain of two patches propagates the PCI subsystem Vendor and Device
> IDs so that they can be used by component drivers to differentiate
> firmware loads.

They're called patch serieses.

--ZxO3SKlPFBf4OkSj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjyTpoACgkQJNaLcl1U
h9DOsQf+KIiIEoehFpJ8acfW4fqqjFzS3MChglr6jTdoCAAGOZFVIde/M2YWHb1a
JgGq7373cTy1RWRjnrgkzARghbUXjO/TaanEw/3pjmOhBllPh5Zv6aohPBp5S2xL
WqZwYx2Jxa0aaRfswL8F5Xa3ZCyY/COudDghDw6QNyIF/vKcWKzkaEblH/7vj1kH
coOC5d5vaxCLbNz4FWy/vIr6V7aomFFtTqtgVVfOxSXOG1GhZCY4wZrbecPxnQ7M
SIDUp5r/VYGwrsc5ieAs3X/aKfkVMnVcf2nciGkSAtUQ0FcHdPIqyTHmRfNU29fb
6w/2oNh0JXgHZtpPp163VOBeGBml/g==
=u0Wu
-----END PGP SIGNATURE-----

--ZxO3SKlPFBf4OkSj--

