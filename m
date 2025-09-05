Return-Path: <linux-kernel+bounces-802678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF0AB45566
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187171BC24A9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3EB30FF28;
	Fri,  5 Sep 2025 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdOwWr10"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE3E30F925;
	Fri,  5 Sep 2025 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069692; cv=none; b=YdJ38+TTntsEJvIKZpPvchSiJZOIE8B7rOVMLtKZgolWvQwVuTNqB/4diPw6G5R9BFiYPfKR7DPPlnhZH2aAKJWw6BWH/NvwE2fXBtLP9M6EkQI94v8SyPmCddVCWLvXX2JjO4am4YBS68I6O4uYnKDYOkFA0dYXPwmtlo8MeAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069692; c=relaxed/simple;
	bh=vzB1ifxUaWoDO39iCrU3dnvqig2LeV4lwCS84Edjywk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsPkKqhHLeK214RxNitsDS1vmC/6Ed+iWJaatNuoCHi+quYnlPKhHfj/O/UhFVI1oc3PLSBsbY2fX9OjQfAgiMMvQmjEln8kbHBWP7ZieKOZ2g41FOqd9eTHWOUsDGB+t44fLXkuauZ8FahAG9uJlnR/Q24VWP3j2y9Kbmxbju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdOwWr10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6486C4CEF1;
	Fri,  5 Sep 2025 10:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757069692;
	bh=vzB1ifxUaWoDO39iCrU3dnvqig2LeV4lwCS84Edjywk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VdOwWr108XQBjlgzHfKa4MrLZvVjmLA0NXBBV3MsceYZUAPEC7PxjtPE1oDjrG1dx
	 W1Bs5n45j/T/vEKlU5NVRJlw/1Q1cjnk9jqZ5UD1oaWcwJlu8V/GT/jl2Xc3+3UhFc
	 cGRoHZMSvb+JzTLP/WReLSnSA0Q0DOfZqNI6KrTRL5J7W8x7bo6Gc+TC2bd47jPPXz
	 vOseblBmV4AhCkiSZ7SRrGqEqvTjB3lCHyHzWOpyHh1owyA95nwY/tv9LBJErhIf/g
	 UaangJe3nG9hdwIGErRVzQllaIerc4fMw6Tu7byGThZfKFcCRbl0nN1G6tZkUSo076
	 TWtJYWYZQiIcA==
Date: Fri, 5 Sep 2025 11:54:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 2/2] ASoC: replace use of system_wq with system_percpu_wq
Message-ID: <54446af3-9ca5-4932-a3fd-e44185751dda@sirena.org.uk>
References: <20250905091016.109428-1-marco.crivellari@suse.com>
 <20250905091016.109428-3-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UXwcJmoyPHTNgDRr"
Content-Disposition: inline
In-Reply-To: <20250905091016.109428-3-marco.crivellari@suse.com>
X-Cookie: He who laughs, lasts.


--UXwcJmoyPHTNgDRr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 05, 2025 at 11:10:16AM +0200, Marco Crivellari wrote:

> +++ b/sound/soc/codecs/aw88081.c
> @@ -779,7 +779,7 @@ static void aw88081_start(struct aw88081 *aw88081, bool sync_start)
>  	if (sync_start == AW88081_SYNC_START)
>  		aw88081_start_pa(aw88081);
>  	else
> -		queue_delayed_work(system_wq,
> +		queue_delayed_work(system_percpu_wq,
>  			&aw88081->start_work,
>  			AW88081_START_WORK_DELAY_MS);
>  }

I can't tell why you're putting all these onto the percpu workqeue, I
would be astonished if any of the users cared.

--UXwcJmoyPHTNgDRr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi6wXYACgkQJNaLcl1U
h9BRPAf9EvLzOB1dlvmwngk6RBkO8A8q2dXdqH3EeoPJ69yhW0ohvsrG7bgI/U9t
hGE2azQ2gn0Y+t99tOOA2CXGgymTWE47InNnY/6ZRMrYsMOHl3wyuJ4Tj2a4Xy1Z
jOPhe2/Ym24YBmvcrhf6vX3spn/mhnFVYip3lsE6iHtnLFBt3wpTzwrpZ+vAi/+/
//xbm0rkWHzIpbgtRsVk7FL18ePWkduXLqKEUr2b32VkWeeH4iLOWWWfziGkh3yt
nU+DkTgqm5TOScbWZCfqRjhSUp7LQBJx8qbUSXKW+ShAbQcI9pGwu+D3mxAz2f/M
VPwGNXR8eJrO8+dd6wmGIqqe9q9wcw==
=Eq0T
-----END PGP SIGNATURE-----

--UXwcJmoyPHTNgDRr--

