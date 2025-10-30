Return-Path: <linux-kernel+bounces-878097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 310C7C1FC7F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C461188A8B2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9262A2E6CC8;
	Thu, 30 Oct 2025 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8Z7VAgI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91E02E1F00;
	Thu, 30 Oct 2025 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823023; cv=none; b=n+6hDa31tds2PelMdW6ZfjRWjdP/Pq5WAcz9a3I+wPSCrMItkPxFQbRJwY2QthT/S9jb9zuB0ysv9pN1eGZBh2SbYak1N/f8F+4x8zLYOF97UcRk2Jym0E7qiNn7h2knKDBwVXcRolVCVydorgQx16rSqBIFp2qNlnGiVzGcrdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823023; c=relaxed/simple;
	bh=CQpwsK0Gg10VqOkHpIQYysafYs3znykd+Dtf+nXSee0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q35pyJWdw8wgH0248Vuccal1H986XKN9u667AJeV1GVBEAYfqvB99MkT9iRf86EYUlodn5pJdrKcqcSr/4KmJh2/fuP/wABOU9CqDUhTwVXpMEwHu7/cczkKIoKKRYS7JQpZ8+1GOib5ygnsN2Bvl4YkTKpS/wo4mvW71nrSoEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8Z7VAgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF87C4CEF1;
	Thu, 30 Oct 2025 11:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761823022;
	bh=CQpwsK0Gg10VqOkHpIQYysafYs3znykd+Dtf+nXSee0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V8Z7VAgIL3Sui1kjByAEhaW1T5cYtf25/AH9kRnv3q03yRn/qptcKDO+ay4oC5ehy
	 NtbCUQygfGzbKk/yGKA3HPO9HfweNPpesSEPNc5JlXU815KfZWXRanvlIZqE9YfHJW
	 Mg23o6yaU2W/0RkvKOZ4NuzGbQisq94fi8f9mvG7faC61I/rJX56o1jKpdPM3Ul6Cr
	 7BDZwEeWl5O4beV4L/5vXx7jap03etcxJv55I0wXOu0AScAsUNdVZqDJkBd1WF5k/1
	 N4OrD+RLPnEOBP7gMwFRqvxb84DU49L7dSYWAF8fzCGZBXazkMWfFVDKyksc0I8Bcs
	 aSmXBLIJc6xCw==
Date: Thu, 30 Oct 2025 11:16:57 +0000
From: Mark Brown <broonie@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: linux-sound@vger.kernel.org, vkoul@kernel.org, tiwai@suse.de,
	vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev, bard.liao@intel.com
Subject: Re: [PATCH RESEND 5/7] ASoC: SOF: Intel: export
 hda_sdw_bpt_get_buf_size_aligment
Message-ID: <fa2758bc-7149-43db-8dd9-610d97d86137@sirena.org.uk>
References: <20251030070253.1216871-1-yung-chuan.liao@linux.intel.com>
 <20251030070253.1216871-6-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hCGrZR2bUoubowM1"
Content-Disposition: inline
In-Reply-To: <20251030070253.1216871-6-yung-chuan.liao@linux.intel.com>
X-Cookie: Is there life before breakfast?


--hCGrZR2bUoubowM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 30, 2025 at 03:02:51PM +0800, Bard Liao wrote:

> +unsigned int hda_sdw_bpt_get_buf_size_alignment(unsigned int dma_bandwidth)
> +{
> +	unsigned int num_channels = DIV_ROUND_UP(dma_bandwidth, BPT_FREQUENCY * 32);
> +	unsigned int data_block = num_channels * 4;
> +	unsigned int alignment = lcm(data_block, FIFO_ALIGNMENT);
> +
> +	return alignment;
> +}
> +EXPORT_SYMBOL_NS(hda_sdw_bpt_get_buf_size_alignment, "SND_SOC_SOF_INTEL_HDA_SDW_BPT");

The rest of ASoC is _GPL?

--hCGrZR2bUoubowM1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkDSSkACgkQJNaLcl1U
h9CVYAf+OWbcD3NFaTpOjewAgFbDH4pKbuSk5IU6j01Zdaxc35H3BztAK0wQAhWy
pADLDfwRbOr7wO4DMCs1vbk0k7LF8YQqXxZ5zsguKeY0OLNr03tuwVCPbnNSHq+N
n/G9gqVpC9LUkfX1umAyEGbwtUlbSDjViObm64cDt7Rnx9A4SXlxbx8mq2PjhbTj
yQ9RovkQTHlUGIQ3+ktrPojpfvwddv6FnBRNqXFuFnay06qXke/teG4+M6rQdb4f
2P2D/MMCfvimnZIwWA5Di+g25YHv/cpFRvs3XKvKxzZGtrYQvxzsNUKylaBBjRuf
0hT/oxBbcolzMBHQ6pEviBpFYZvopA==
=p2Vk
-----END PGP SIGNATURE-----

--hCGrZR2bUoubowM1--

