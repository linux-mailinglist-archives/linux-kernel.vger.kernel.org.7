Return-Path: <linux-kernel+bounces-794961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D042B3EAFA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D39027A50BF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834382D592E;
	Mon,  1 Sep 2025 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OW8rqc5k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3AF32F74E;
	Mon,  1 Sep 2025 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740921; cv=none; b=A4uAgYLqfc3II7vSQ+DT7OYQcbgMJCrVe2vtEDB6uDbt7eTGqdY3cyy0pgCVxuJv4+u6zd40UjgF30GwUOyVZx+DaVc515RWNcHnBQLIoDMkdy7koxCyBl4FMYYryoiNAFacHM0BhBC1Cb9VMmIYy/R6H33kpSVaIpY3YKLfZxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740921; c=relaxed/simple;
	bh=+CogIW7N/kGFGPHIRY3AgeAaREaVS0NUPIvxlKDMBms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prcFtawDlhMkhb9NtqD7y8NU2/mC/vydgDmwMBLJZuMWwHWCuUVBxdqlmsMrwh+u+ns/K2EpZXYPLCVsP0fPDtUbn8kBS8ZvmlhX1KjEionM0tJl6CuFzAKBuF2nWjsh+z1SN1ngn5aG1RnKPirNYNFogzwJ0EQHBNrr4wSAsI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OW8rqc5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833F9C4CEF0;
	Mon,  1 Sep 2025 15:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756740919;
	bh=+CogIW7N/kGFGPHIRY3AgeAaREaVS0NUPIvxlKDMBms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OW8rqc5k6ae1VO35gF/zJNWvCDAYFe5S62nKZq8qKMe6DHx+oRGXDqKK+2rija4y5
	 z9Rj1bAsI1g9KoFFcjoBHED89KTO31N+TrUfAzRnwAGajlwWjl7kCpyCOrpxzVRShS
	 aMIRzGM1F2FvCWw8GNjQOl13GIk9EjPawWuJ9cK/Cn17KAat7Fwl4LiWhuNrqNW3ZR
	 5EXQsmK6NJmOYJOeoJyKurTC8z6aYxs5mC9FmFcYwUQsByNZ3qO+c0/OwxyL+dzOyk
	 NGXCAD/uxaN+PDHDg9rDZgCE7Azai2gxKof7tuH07NUrSSgH7Uwy52urPEOI1Lkt8U
	 xN3qrou1uViJQ==
Date: Mon, 1 Sep 2025 16:35:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: linux-sound@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Frank.Li@nxp.com, robh@kernel.org,
	laurentiu.mihalcea@nxp.com, dan.carpenter@linaro.org,
	waqar.hameed@axis.com, festevam@gmail.com, kernel@pengutronix.de,
	lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com
Subject: Re: [PATCH] ASoC: SOF: imx: Fix devm_ioremap_resource check
Message-ID: <a36b4c70-2ed0-4292-afca-7ecfe0207260@sirena.org.uk>
References: <20250901151513.286454-1-daniel.baluta@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qrFBNcE+OVCzYW36"
Content-Disposition: inline
In-Reply-To: <20250901151513.286454-1-daniel.baluta@nxp.com>
X-Cookie: Auction:


--qrFBNcE+OVCzYW36
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 01, 2025 at 06:15:13PM +0300, Daniel Baluta wrote:
> devm_ioremap_resource does not return NULL on error
> but an error pointer so we need to use IS_ERR to check
> the return code.

>  		sdev->bar[blk_type] = devm_ioremap_resource(sdev->dev, res);
> -		if (!sdev->bar[blk_type])
> +		if (IS_ERR(sdev->bar[blk_type]))
>  			return dev_err_probe(sdev->dev,
>  					     -ENOMEM,
>  					     "failed to ioremap %s region\n",

If it's returning an error code we should feed that into dev_err_probe()
rather than hard coding to -ENOMEM.

--qrFBNcE+OVCzYW36
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi1vTAACgkQJNaLcl1U
h9C0KQgAgW+y0EOT+Ls10dstZ5k6n0b9ak84jHbCy+yNu2eyaJF/2DmH9aytU8wZ
Ga17ta/qMV+DswgW0/W7kwCYtHVpvCGIgBGrU6cm4sUGGt5nb9mgtxuqXZ5zXQ1f
JoQJpHpgyg+hb7KjGe98hh2m2WhX1gt4UHzt2jMWWwoHpPNILtm6NgomT2iCntR7
RA2iQC8SgoCO/ScdXDeJzWmF5Kd9B+jpYk38lW+w7sCfUEaRCaFA+SHsmb5hu8eb
wWs3vg9i9bpuhyClvauwsbd4u4PVPRh1z+GcVonOH/UtWe39CCN9VioykTCOwbva
NtBge9of+5p71lUkhFAmBjYZFkg9cA==
=kkcA
-----END PGP SIGNATURE-----

--qrFBNcE+OVCzYW36--

