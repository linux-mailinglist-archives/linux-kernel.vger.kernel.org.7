Return-Path: <linux-kernel+bounces-897862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2614C53D4E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6CE3B77A7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809B2348440;
	Wed, 12 Nov 2025 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6Erlm8T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D574823BCEE;
	Wed, 12 Nov 2025 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970128; cv=none; b=SdDFKJWpc5erHFfWjfVgo1yN6LYfRfi5cQV29LNi8fihvydsp9eflfDb9d1bZAhVKbetL0cNVKEUU4Q5q1LuHrMBP8zmkVrBNYgsSGJOYred156rdLYcdFoijcuvuRheaiDrzK0EKxdIjQfwFhzE4xV6FWfUNwm37cBvNwn3H6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970128; c=relaxed/simple;
	bh=21umBLpssM92VlQUxQ09MNek5erWIzlhpVWYHH6nKlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaOvQoXtghoivL3eXetbsoDOpQad6NP5K9qA2ZgmCtrXDdsEQQm+kxc1M7qIUh8UV4ZfDlrERjW84ka12D3yGLWRGWS+OvKMsUHHwpDeDR4hglcAEjLzpoiOqkSNdX9MNKgRLd/ACrihiye8T5VWwbSSuhNFgra+hRgIMvpc1vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6Erlm8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D01C4CEF7;
	Wed, 12 Nov 2025 17:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762970128;
	bh=21umBLpssM92VlQUxQ09MNek5erWIzlhpVWYHH6nKlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M6Erlm8TQ2kUzOp9MAeMJ58fr5DkoHxLaw5T+Sep6UmF7gLf6WsKRTaGoqdUQciK+
	 wfKi3cBp+6RB2Q2seTWK2ddarHjBbqgn7yIld00M0dCJXoDuF9jpHGOsMaY9scUw4s
	 x9xFrCaY1t3+xzukonxJdqogATHGdZQP/2F7zBiYtvhaMsWLS+Ttm/HCosgcCsKa8p
	 oDWJyEp9SZ+ezUbS/bZSnzfw4xrAF7DmbI5lbVMKonts6SwWSVtWf7mO2gaxnQhBzz
	 8a/ASnOMFqVB3sx1/p33WWOBPe3gT3WLj23a+XCmFV0zGXnAi9xMRt1CeyvTL6egmn
	 4ULotUMI5m7jA==
Date: Wed, 12 Nov 2025 17:55:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: atom: Replace deprecated strcpy in
 sst_slot_enum_info
Message-ID: <e76e2b58-ae33-423a-98f4-052cf006c7c2@sirena.org.uk>
References: <20251111224706.87508-2-thorsten.blum@linux.dev>
 <49fc19ea-4401-4f33-ad4d-5419acf6139a@intel.com>
 <90195EA0-41FE-414F-BCA5-1D0E64612A87@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A3YqIXUxcJeRIZiV"
Content-Disposition: inline
In-Reply-To: <90195EA0-41FE-414F-BCA5-1D0E64612A87@linux.dev>
X-Cookie: "The Computer made me do it."


--A3YqIXUxcJeRIZiV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 12, 2025 at 06:23:02PM +0100, Thorsten Blum wrote:

> Takashi or Mark, do you want to combine the two patches yourself and
> update the title or should I submit a v2?

Please resend.

--A3YqIXUxcJeRIZiV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkUygoACgkQJNaLcl1U
h9BMlwf8CeZ5VODsFk2XjJa6T5TsHBjc6fonu3tJA7xR8uw0NYYhenOIKh+EZcIv
R0XNYpoAiU6fFZ7RxYWf9iiZky8tvVWZdG9kTm7NWpEaCAd0wWFpbSC9usc4RBvF
kPAdcIDnFSLgN+PqFfyK9n/AQ8eDNKO+MQSOU5nL5nZfGptawb4Xhk/vHu2GPq3T
PxNN5T6mkYy7cNYV2+U3sMCpLm0UQSnTaTviEOixp0MQxO8+kcwN1VFa1xTG65Gy
5SyBHGOJR2XNzx0zLDoQ91x1hLbjmA/n/j6JFh2ITf/7PXI8V1l7376++H6xnYiQ
vzRX+FY10RYgXMcJvnEfjcBQn5soDA==
=h2WM
-----END PGP SIGNATURE-----

--A3YqIXUxcJeRIZiV--

