Return-Path: <linux-kernel+bounces-888813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD76C3BFC0
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89225621D59
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DDD8248B;
	Thu,  6 Nov 2025 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NszMuadl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EF130101B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441724; cv=none; b=iMwrn37ZjPbXGH0lYh0iy1LBNmj8JD5WcRag+q4KqE4O02IeQqffLggk2ZdLkcFiXkX2zFYIcttkVbzlZTYW4UrZ5hsHdrc6/15tSh+C7mrmUMImD5IGGYpk5ja3rDfp4Di3XJOFHRXbz8abECoQRpvt1ypYWgy9tfGOi7Q5UuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441724; c=relaxed/simple;
	bh=rNAf3KxIFx4HCZ9jSGewhPICZXrRrFkkjUtvj8RezTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUWggi1jY2Jr1/Vm0UNYnNf54QP6SOZkay09DJQp7N8MtYhHjiM6rni6wDfwrUsXQjupbSme7ivuoEaYxKUlRMMRWEExa5GDnu+rRl4DipEo1zyWefFmnC2ASxXmyt8RaW19s4+6Sjy28jbnj7bcoIFOBzvJZcKKh7E6FvPfpDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NszMuadl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F5DC4CEFB;
	Thu,  6 Nov 2025 15:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762441723;
	bh=rNAf3KxIFx4HCZ9jSGewhPICZXrRrFkkjUtvj8RezTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NszMuadl/ZZy2+zvi189zAvT2zXscp//Tvr3RZmiqo21rG/wZb1+bzPUshLId6UkO
	 +3WXYbITD8p61t+9fEfJp07g/OUk2WzsM2ulblYugH4Prqgu74KnUq+CFXl2eD57tc
	 2n6c0gCtaY9SLEdnAssKG//ubanrl2GRznN9QgMPW0cxJEh7+PRlTxdliK6eWRUQs3
	 7jzHxSQGib5eTfKQuXI3lFkCyoL6TJ+A+szs9hZDDj6F6OTc9wYHtTRJqBvtOEtNY+
	 cEq7iYevr66ToAABu9CWEjb7LjK7URmGE2XUZ7OATJDPgigm0IXfSfRjzH0owie4YT
	 gRdfffFWX1qzw==
Date: Thu, 6 Nov 2025 15:08:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] regmap: sdw-mbq: Reorder regmap_mbq_context struct for
 better packing
Message-ID: <aQy5-DYrGLPCTxnG@finisterre.sirena.org.uk>
References: <20251106145402.1077903-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f11U51Y5d4R4IR95"
Content-Disposition: inline
In-Reply-To: <20251106145402.1077903-1-ckeepax@opensource.cirrus.com>
X-Cookie: If in doubt, mumble.


--f11U51Y5d4R4IR95
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 06, 2025 at 02:54:02PM +0000, Charles Keepax wrote:

> Reduce the packing by reordering the regmap_mbq_context structure.

Surely increase/improve the packing?  Usually I'd expect a patch like
this to quote some data showing the improvement (eg, pahole output or
structure size).

--f11U51Y5d4R4IR95
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkMufcACgkQJNaLcl1U
h9C7Twf/Q7yI53UXZmHcssExZJXj58XG44JOQloLQ6SrJD8nGqnuzXrfm2MGOvZk
T1zGwSLf0bpmE1q21/g6j1fWAoggQbchkpfIRheCq3Xbk4uz7Hqk2y8g2/V1XYQc
wrAOOjrDuYLiX4QwspNXI8I9N2BmtBwL9zF/pYgokalR8hR7iY0YW+O7YJJxtYkJ
ykqujXczfbu9mhx5F8xj4WfdowgT5zCosXfjg9GUFjKct1OPI5m9+8NYz/bWKTXt
yQLIh7pnKHropIpvWPlTSVDQuVbcHmbr+a9cH5b3rQVirDYsRg1qwwINXRnbLXJX
qc5PaDWt7Mq0JiktL1PjvDngrw4sSw==
=wrxh
-----END PGP SIGNATURE-----

--f11U51Y5d4R4IR95--

