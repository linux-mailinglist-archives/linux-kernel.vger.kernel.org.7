Return-Path: <linux-kernel+bounces-858259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9ACBE96C1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772951886924
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B122D3370E1;
	Fri, 17 Oct 2025 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGQAyAD5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9E42F12B7;
	Fri, 17 Oct 2025 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713290; cv=none; b=LCMJByXKXgK7ZawVJ/bOMDuZfwpEHmBsfCMdbVE3YPECpPcELfWDndRpK6TMGgxj8IS/rL7ApFxUAA7otFWazQFY2gVbr/skh0XvNYUBLU/lToPf1TO0N8D2nCIMDxcsazac4jLwi8JPQwcO7QQzVbMAHdFfauoZZfsQev5/NKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713290; c=relaxed/simple;
	bh=0Xg9t71CwxVpyuX6lVim4C/doJqHcjQzUz15fOWrHCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxFtREirjn/3gOcIpzLcD10ZLRQQF8/A4LwzZgzCopmYpZtXWXCqOjzF+LfbKk51ftZxxcey7oWrvgXSGXWMNMubeVNJabFwlq01kWvSHvTQb53UfYHtxhnBhzWRWrO6CPQA7YRbcuvZY0TsESTu0PsUB1q8ZrDuwcvCNxP6m6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGQAyAD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61D9C4CEFE;
	Fri, 17 Oct 2025 15:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760713289;
	bh=0Xg9t71CwxVpyuX6lVim4C/doJqHcjQzUz15fOWrHCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NGQAyAD5XnDqRI6Ckxc+dhnxUzuNz0e6HNJ0SffixS8dOxCuj5gLBR+3Q73rH0ffk
	 3Me/PsOUnRp91VrGUhwYkxWcu3lWJpOmo8o8Ahur3kqxMve6V1bRXpp0zWatVxlO4z
	 fmRbxQbi1mEZR2X7B7z72P9B9SFJB9XwacgBz5qKOcIdlPYJhKDoDOdSlL6Bnx6oXt
	 XXX3O4ckbF6zRWvWu/dDFtonZrYVho3RCFNTjRMCyA4//Vn+o7MmBT70LYXVjWgUfZ
	 d7Tws9NgJ3ZcP5hvsHA1wB3lzjOPxxPrbQ9KyG1qMxQEkn13YDec3iOHtMnpcGakTf
	 kYeMixJOEOO2Q==
Date: Fri, 17 Oct 2025 16:01:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Herve Codina <herve.codina@bootlin.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Axel Lin <axel.lin@ingics.com>,
	Brian Austin <brian.austin@cirrus.com>, linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/3] ASoC: cs4271: Fix cs4271 I2C and SPI drivers
 automatic module loading
Message-ID: <5f2aeb66-97d6-41b7-8c80-87674c1b14d8@sirena.org.uk>
References: <20251016130340.1442090-1-herve.codina@bootlin.com>
 <20251016130340.1442090-2-herve.codina@bootlin.com>
 <60fbaaef249e6f5af602fe4087eab31cd70905de.camel@gmail.com>
 <20251017083232.31e53478@bootlin.com>
 <d6bd466a5d11b016183db0ac3c25185fad3036fc.camel@gmail.com>
 <4b851d47bf1d03988a27671ae21208cdeed76837.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UlIr9HwaN/pX+F86"
Content-Disposition: inline
In-Reply-To: <4b851d47bf1d03988a27671ae21208cdeed76837.camel@gmail.com>
X-Cookie: Androphobia:


--UlIr9HwaN/pX+F86
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 04:41:53PM +0200, Alexander Sverdlin wrote:

> indeed, that's what I've got for a fake I2C device:

> # cat /sys/bus/i2c/devices/0-0010/uevent=20
> OF_NAME=3Dcs4271
> OF_FULLNAME=3D/soc/i2c@4000000/cs4271@10
> OF_COMPATIBLE_0=3Dcirrus,cs4271
> OF_COMPATIBLE_N=3D1
> MODALIAS=3Dof:Ncs4271T(null)Ccirrus,cs4271

> to me it looks like a bug somewhere in I2C core...

IIRC this has been round the loop a few times and whatever you do
something breaks.

--UlIr9HwaN/pX+F86
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjyWkEACgkQJNaLcl1U
h9CvJQf/VMlgfy4CRVJIs0LqYHy82K2tDxhzq3IvVq/Okcn6MddfFUlGQ9pd0gl1
9gRJkdFRga+i+g5u3sJAwzyhWV556mkyGRr3zFxHvtz4Hx2hp7cJbL22S0cHIL8v
3d8028kB5q9PCPPsXdLBgj1z70Wy8bn5jhak2EJaoeXQxnrxjnQW+tL1Xs6MUpWg
EywZIkSK+68PMI7MhIFdx3lhuqkG3rH6XF9kIhmC0pSJwCCXjCU+1qVRUM83cpnM
LUQKrUY67679OPjxfnbKPkUIrDncIg7VItz/ud0L9JIxHeYiqnedoDHm916+XD4h
ccIiQcymMIlgG0qx+34MbcSQqrpjcg==
=dAdR
-----END PGP SIGNATURE-----

--UlIr9HwaN/pX+F86--

