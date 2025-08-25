Return-Path: <linux-kernel+bounces-785119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492BFB34634
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CAB87A8961
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1002FF64E;
	Mon, 25 Aug 2025 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG3hxLOq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DD02FE060;
	Mon, 25 Aug 2025 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136722; cv=none; b=gXN7IsaiCl8ebUSCJO2hIBIzDCbego/HP9C7lDg+aZF9RuQ2PX4onb3zaccZR1jR0sVb5+UEGQa+If867dRPU7unYbcuGcRz/iHbayiFjXUTMutRLS05rgbJn3LQTYvso1UH3r0t/ND50WQa99T/eut9sXWnABy/hplD6uNdmCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136722; c=relaxed/simple;
	bh=i/vvLe+lwO7yVG+WXgvoPxHrxkfOl5zcez2+b+QQQnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIKWy2Sj0cqpogQJIUgL2wPqIdbR2bfF1WBGPyilcsOW3oSlhpTUynRofDYBrbGeCpdImz6w7FGey8DO3NjPgjRFOu/3L5ul6mOBPIJCwlOe3h6LBEniYFZ2fgA4wIFDCfmR31rw0TnNPxhLslbDU5ew00juI0nRQpGBdUqF0tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG3hxLOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC61C4CEED;
	Mon, 25 Aug 2025 15:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756136722;
	bh=i/vvLe+lwO7yVG+WXgvoPxHrxkfOl5zcez2+b+QQQnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nG3hxLOqqLkOcrDBRg63JgemQULN1Iy22cTf3NkLBHwoO31uQ1O6ujij6oXSqimJE
	 +sQBZ/D2IZYGT/IZmpb1Rj0uG5AFbU2pXjrbAMJkjbNFwE170jI+jwXW4kKlL5eH1h
	 WdXuwrEkd9YIMH9L9lCeQQYZIqNp04zbX7X4GCQMNUBSKssoUFWuc08ZfceXpaqwtE
	 rG6fyxNL/3okBkLH3dE3WpiidmjAuG+M2Bj+pdmvPJ9V+H8yzb5KzQM/KxbOOdkMUJ
	 G9Lk941E8ayXe+Z4QbmlgQaYnzOvmIT1zKdypA7s6eVsmB6o9zKMPwhLxv3TwsA7Eb
	 qYmtNhBUJo1ZQ==
Date: Mon, 25 Aug 2025 16:45:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ASoC: amd: acp: Remove (explicitly) unused header
Message-ID: <aKyFDaYnXrC5sMiA@finisterre.sirena.org.uk>
References: <20250331070943.3986387-1-andriy.shevchenko@linux.intel.com>
 <aKxraexKHD8T8zk6@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ub3yC1cUlYaBfLnJ"
Content-Disposition: inline
In-Reply-To: <aKxraexKHD8T8zk6@smile.fi.intel.com>
X-Cookie: Filmed before a live audience.


--ub3yC1cUlYaBfLnJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 04:55:53PM +0300, Andy Shevchenko wrote:
> On Mon, Mar 31, 2025 at 10:09:43AM +0300, Andy Shevchenko wrote:
> > The fwnode.h is not supposed to be used by the drivers as it
> > has the definitions for the core parts for different device
> > property provider implementations. Drop it.
> >=20
> > Note, that fwnode API for drivers is provided in property.h
> > which is included here.
>=20
> Any news here?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--ub3yC1cUlYaBfLnJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmishQwACgkQJNaLcl1U
h9BbEwf8DtHTUSrHrG9f66R5YQn6jSjVOfXBjLlbvgUzr+DJnTYmxkCO9MsqRrAu
Wzkvakv77Du8gyiq1fuDYAd0x/rmyJ/8JMUIsr/Nhg4YbnC6PArgSX9nXXyW8I/W
Y3SWgBq+sigBP9ONx+ixxRzaStniClF1Xe282TFyDJ5Go071lH2vz2tfVEebh3HZ
PrJV2VZhDEeNzxpfDmhKUsXl2SrSbP+WR5BF8D/ssabNxiii03Y9aCBgWcUVUsQW
Y5i6SWxk2tXbX/9fjJOF3Tp9H5m2pryAEGk7oCt2AqeBojWy0XmgwpwSTMU4Ik7V
rNQJDwIMfDIfo4I4sJp4rI5beOIR3A==
=nRRm
-----END PGP SIGNATURE-----

--ub3yC1cUlYaBfLnJ--

