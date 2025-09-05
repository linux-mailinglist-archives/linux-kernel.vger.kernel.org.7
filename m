Return-Path: <linux-kernel+bounces-802645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A75B45518
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D8E16D83C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3AF31062C;
	Fri,  5 Sep 2025 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjzmTBtw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED4C2E371D;
	Fri,  5 Sep 2025 10:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757068893; cv=none; b=Zm0UvQRqVm00OKupaYQ1mukZge/RZMMXCYEkMwzHRSghnSnmdRS1YpWqIP64QiM4qcFLCbHuY/J8eNW6rjCzz2qL1fnRtUbfudgJw6335ag1ybJ3Ne0hSgsVdVY8zWnBJsu6bZJhKZlGSRizUP2y/CnVrIDq8krbOVlw4CWzS4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757068893; c=relaxed/simple;
	bh=0YT3gSVmaRAfERZsP5juwTay+cdaKDtqbsQUs+7eD3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WD8dv44YiPWEzAQoxwz7OlJ3mxsKChnH+xw8j/tGuZHdaexxX5iRcTh2F5wjQlyU3Sh4GTm5Lw1l/A1Iutny5mC47HbZJJASlzXUCz9BBLJdq0OwC0NqBQasbsTq3QRMjzj1trh3B5seBICHEmzBxDgUBG3yjvLwALz/6FwOQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjzmTBtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BABFC4CEFE;
	Fri,  5 Sep 2025 10:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757068893;
	bh=0YT3gSVmaRAfERZsP5juwTay+cdaKDtqbsQUs+7eD3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjzmTBtwHMLhywCZLnQFDomzZH7m1TsQMv1EkpTVegEsDO/Dr+j+V+AAoGzxyhbFQ
	 Zq4TaV709BfJux6xejkxhabNoARA64dJeK1SivofU/vwK8EzB98+KPNLd2uuBTzBsT
	 6UQ8PgjtmZcKB9opyRYmcwF0m/+A/S9X6sSV7tLEWyhMbVMd+8pHd+byw5G/1oiPA+
	 eDTpDXwlIFB+SlewvXlPXeN+1tpTR6cc83qwvHwbiiAgql1vOrQ/4b6cwXgKCENmJ2
	 Ntn47s86EbF876fkk2M0/m/2ymR2MBAZ9A31kJUw5+B5gqq+THnl8dcLoh//zmbjbi
	 Gxd6DD2zf7XCg==
Date: Fri, 5 Sep 2025 11:41:24 +0100
From: Mark Brown <broonie@kernel.org>
To: "Xu, Baojun" <baojun.xu@ti.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"Ding, Shenghao" <shenghao-ding@ti.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"Yi, Ken" <k-yi@ti.com>, "Lo, Henry" <henry.lo@ti.com>,
	"Chen, Robin" <robinchen@ti.com>, "Ji, Jesse" <jesse-ji@ti.com>,
	"Wang, Will" <will-wang@ti.com>,
	"jim.shil@goertek.com" <jim.shil@goertek.com>,
	"toastcheng@google.com" <toastcheng@google.com>,
	"chinkaiting@google.com" <chinkaiting@google.com>
Subject: Re: [EXTERNAL] Re: [PATCH v4 1/2] ASoC: tas2781: Add tas2118,
 tas2x20, tas5825 support
Message-ID: <b70314db-357f-4c39-a9b4-088d8ebed2b0@sirena.org.uk>
References: <20250830061459.24371-1-baojun.xu@ti.com>
 <993d7fe7-5206-45a9-acb6-0d610a3a2136@sirena.org.uk>
 <12aa63e694c94213aeb6b48959d02b45@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W/8Zc+tPZVZu2YRi"
Content-Disposition: inline
In-Reply-To: <12aa63e694c94213aeb6b48959d02b45@ti.com>
X-Cookie: He who laughs, lasts.


--W/8Zc+tPZVZu2YRi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 05, 2025 at 04:15:45AM +0000, Xu, Baojun wrote:

> > This doesn't apply against current code, please check and resend.

> Hi, do you mean I need a re-patch for the newest (next/linux-next.git) code?
> Or need to create patches on tree broonie/linux.git?

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-6.18

--W/8Zc+tPZVZu2YRi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi6vlQACgkQJNaLcl1U
h9DyYgf+JzOcCB2e4kN0lqPPMtGy3W9chZ/RtSZ7X58/3sxxM8IFEG4/LZR9KOlK
I4tkBJu1o5TcaojTKjg7wJiw44Es1g5I5ZzgObWS1rjngU5k3aW9eH3x5dGTwhOC
XozX6auMJbj8HjxzxIeDo0azbnyMGpUGNDDhMGa91uzxMcyHwyOzLr8p9DqHn+zp
cL0NlkMQVQzfluQa3HN7xkEXwj2xqw1CRmZN4HmI6petXnNHh5DuGeEgrkErrZRf
lFYXKinXgmw8485n9K2g54si/TKeS+d55xfNihEaHufwSu6aWY1/AhP/7Z4eE6Hm
mM+7Uw+83YmCbmYsaxEW7tlKxO6G0g==
=1xzx
-----END PGP SIGNATURE-----

--W/8Zc+tPZVZu2YRi--

