Return-Path: <linux-kernel+bounces-834039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 124D0BA3A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC96620AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1BA2EC0BC;
	Fri, 26 Sep 2025 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUMRQNQI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B57F2D6E5C;
	Fri, 26 Sep 2025 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758890450; cv=none; b=mCHvNusOKoHKCb2JWar4M5m+BDehqb6rrYmLZ6PSqlI8fmOx7ZOgFnsYFYVWfA6i1HulcFwq8Sjet5Q7XXUjle7/PFCoWLEWS4EnAN7Qv5T7vYSD+W0fbVDnDg4nw1L70SjNU8TfmFgjo58uNWSY51sLGePpeOmUwV3OEusOyhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758890450; c=relaxed/simple;
	bh=HzjbS5RDKUB+2C5nPrcsTl3Z+/Q6+IrlhjUdjbo/YX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZR3G6XnzzHurOA1F6MN7Se6Tpr7H//FDm6kV2zCYbhXRA3HTANXl2VugrBIB5NiXrZNHJ4HxWuzQ14QXQhxlZ+sNIYcMLTfl72aAiSJo5/Aq2yDIMprXz6fo8ZML7lXOU9wJVn/m644+Htz7zZGR40T2IOOgAWgld0opaTspjRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUMRQNQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36C4C4CEF7;
	Fri, 26 Sep 2025 12:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758890449;
	bh=HzjbS5RDKUB+2C5nPrcsTl3Z+/Q6+IrlhjUdjbo/YX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jUMRQNQIq/vl9gLe9paUJIvYeiVsmWcmhR3TkfV1GMqJgrX59EQu+WQi8RS+ZG1Ux
	 DtZ8tH4hvuOkn0+nLqPfij1TZOIYRqvQdOZMIBd3nJNnaVY0mHXH244pHHWFSwo1QM
	 lqWSXwM+zvxiJTC2aUXgJPgEufG9co7Dzne8xMpW0NsGnni/d5vBo8J+3Azw9kkizT
	 hc9n4gp6GMOol4jHECyrbf4HGYEYOnnLkzV//nZ2AHgC2MCPbmIsaJShTKnw40m6Pv
	 53lb7w75Gm17WHhODg0G/R6dVzT7P/IO6CTFK/9dN6MuUS1FgwQ2QTt3ICqYpceXSe
	 pat3CXh33O2Vg==
Date: Fri, 26 Sep 2025 13:40:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, andriy.shevchenko@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, shenghao-ding@ti.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, k-yi@ti.com,
	henry.lo@ti.com, robinchen@ti.com, jesse-ji@ti.com,
	will-wang@ti.com, jim.shil@goertek.com, toastcheng@google.com,
	chinkaiting@google.com
Subject: Re: [PATCH v2 2/2] ASoC: tas2781: Add tas5828 support
Message-ID: <e7cc9383-3a83-4c94-ba30-30e0117489b1@sirena.org.uk>
References: <20250926043339.8419-1-baojun.xu@ti.com>
 <20250926043339.8419-2-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Gspcy/cvBUDr0LgI"
Content-Disposition: inline
In-Reply-To: <20250926043339.8419-2-baojun.xu@ti.com>
X-Cookie: Your canceled check is your receipt.


--Gspcy/cvBUDr0LgI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 26, 2025 at 12:33:39PM +0800, Baojun Xu wrote:
> Update ti,tas2781.yaml for adding TAS5828.

Reviewed-by: Mark Brown <broonie@kernel.org>

--Gspcy/cvBUDr0LgI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjWicoACgkQJNaLcl1U
h9BjEAf8CB6jA+6G6TBClRdHJ/Vo7FGkEm9xXkdeTiz2yJtFZIchyE9upnm9XviW
tpqpapiueZX35ZJ30roKiQCDpyuGuL6OussCGFOJxQgjV63vig8EGdeari8UXktS
RyflfGgQ+tktQTfddkI0j4AHE1FBqxcmX0mBgZaeta1KvOcuFdeXMjzyailJHNhC
ztqlLcnaMTDik+kcFBMpS5d00hUMEm1m09e2qrs+LpT8Cx/5sFzmDra1fl6LpXnc
y37Jd5KRbO67cb3BjUPLbCZaBnyyvRxiaNRFV+yjOLpecnRbb9d1WEhreKDVWZhr
RKLkHTrpB7XVGvuACfnbuQpe/X67EA==
=VJb8
-----END PGP SIGNATURE-----

--Gspcy/cvBUDr0LgI--

