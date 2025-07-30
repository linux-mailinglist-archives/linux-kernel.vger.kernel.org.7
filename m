Return-Path: <linux-kernel+bounces-750556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD3AB15DF2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6D4B7AEB3D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5243C28150A;
	Wed, 30 Jul 2025 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHW9vQPC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBE027A11E;
	Wed, 30 Jul 2025 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753870669; cv=none; b=bbRaHvolZDf57mywDYjuYG9lAQf5AwijMw6tV5ecXZu644NAtyCVA1V0dDrntP03QGimJ9DkhLafN07t6LmxFgR1Laxlz1FjSCPmAv3DvUPHX0g2GYqsZlxYkMR4XkeIx/YtzIg972Z2Xh95F8WrzccTGz7eMTOOoDZHZ9Fk9+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753870669; c=relaxed/simple;
	bh=Tg8r+XpwvnhBpj5g+umHzYZAE3tecrn4qKxVcmRqeKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tpdy7fUM8RmUbCcKQJBa2YM1dhtvhTkWg4n49XE65LmPxwR6VcuPDmmlsoiKrPE75xqwF4/FhwNtE5+OYZkluzscF0RhVoZ11jCBF3sBgZp5Dw5Q/FpYBUKacDXgbUalRSJg9xaZnmM16dvGxxWAhNSDBKU5QZcooSZY6VwwsVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHW9vQPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33E1C4CEE7;
	Wed, 30 Jul 2025 10:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753870669;
	bh=Tg8r+XpwvnhBpj5g+umHzYZAE3tecrn4qKxVcmRqeKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JHW9vQPCjcs/PYKbTp+bMCyR60z5J1NRPoMBdfTxGXadkctrHl7EweYlnRhjIrTHK
	 tN9EHp4o+aLpsMrLDfYxP8wmAMFfRBSmXreKFJ4efw7RdhIzeVYvLPvHUpUTEehiRU
	 XaaiYA7RAmbKDm8Lbd+dowjX71Nj8V0fmcweE5B0784mTbMefE3u12U7yTI75QSk7r
	 OAVWQchVyQ0bFWF31EJVm4gZrY6iIsPvGXIQsTvEZ0pjv0Nv8eYqw8S1KdY7wWkqta
	 X48gi4ZVqO+sXaXuzv3z8zC0miVPwSmoN0qfmPs6T5RO0LORtLJvmcWWmjOccffbj3
	 QvCTxnuTX2f2A==
Date: Wed, 30 Jul 2025 11:17:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, andriy.shevchenko@linux.intel.com,
	alsa-devel@alsa-project.org, shenghao-ding@ti.com,
	13916275206@139.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ASoC: tas2781: Normalize the volume kcontrol name
Message-ID: <e36cd0bf-fe0f-4edc-841c-83f688a5e75f@sirena.org.uk>
References: <20250730053236.57643-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lS82ug0n8tvwRv6Z"
Content-Disposition: inline
In-Reply-To: <20250730053236.57643-1-baojun.xu@ti.com>
X-Cookie: Linux is obsolete


--lS82ug0n8tvwRv6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 30, 2025 at 01:32:36PM +0800, Baojun Xu wrote:
> As more devices become supported, add "tas2781" as a suffix before the
> TLV name, correct the DVC step, and normalize the volume kcontrol name.

I'll apply this but this really should be several different commits, the
variable renaming and the user visible renaming should at least be
separate commits.

--lS82ug0n8tvwRv6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiJ8UgACgkQJNaLcl1U
h9DZ3Af/WfnwgG+83a5MNc/itrYacIQMYNcsXQyp298uC/8hf5CgYMje+RmrS8Qu
RTTSiDfIebAt5IiI7b4VcFJN3V2Y+DwannQscjEK5BPMzNDXEeij6bhhPDlMhsh7
bd1L+WbIC+WldzmUKwt52hlzGjZtumXq/B221aH49Vkvy58DILIs8724d9mm4x6x
lZkDaMVU03zFpNstsmFreYu7a9AD/DkB9X2E7ALx8mR4pzKr3Ww/uX6RurS0sY64
2rpGbFf6mvqPp5ojgzNxHSi2ewAVHoaUQ3QyHRKGmMccX4G8kvcUt7dAaXwP8OK8
M3T5M0B8GXxThY4pZvOWV4C2X3j9Sg==
=a3aI
-----END PGP SIGNATURE-----

--lS82ug0n8tvwRv6Z--

