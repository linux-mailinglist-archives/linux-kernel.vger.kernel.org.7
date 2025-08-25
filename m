Return-Path: <linux-kernel+bounces-785493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0BBB34B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5C337A2D94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E8F286898;
	Mon, 25 Aug 2025 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYIfHfaq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000841DE8BB;
	Mon, 25 Aug 2025 20:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152806; cv=none; b=JJfKEzviMtA1wNJtG813yE7oxoZpqiyfPyPNjuC0mv50CFfxyJsXo1fxzm3+uN2bhBiI+yrrR9uzKX2SqtWvNW+n+WBAPR0MEmi25ZgyiSg6XOQN+x36FQJvMfE+DkLm55gEeex5815gMcCueeFl5DVE0sWPnStZJGAn43vL/Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152806; c=relaxed/simple;
	bh=jCo0z7yvg7e703GOOJQAWe1gwyYswiH7Jz7cBH73tK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4suslRCm6lBkJ6APEkaIL+9l2fZ3vOG8Lq5PHYtQDx07Gog0bNOyrYgH4fPU1cCVv7wg5jjtLODSB7gFoFFiwg0ra4oQhNb4qKcCpYLLlrEPlLTJ0/8VVxEZaAHu4Ycln4uxZuNteYsnXBlZB6xlvOL6UB3J2+vO2IrQfKnllc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYIfHfaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5541EC4CEED;
	Mon, 25 Aug 2025 20:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756152805;
	bh=jCo0z7yvg7e703GOOJQAWe1gwyYswiH7Jz7cBH73tK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oYIfHfaqlCOYIR5ds9lklFCouXY/JhGqHelYR7R3kkavp0Xa6qIOIKqlRn2ildPNN
	 FEAVgGzsGgmIIVdWcgiEQC14UrqHj1AG7GKIDyWwFUoxzVe3RD46+D1N9Jk6+uYsXl
	 NVSd5jhQBPeBJLcINs4vPhZYFSYpVgKeebcqBO5Xs0SGk4vcS57XXuxo9OsUHNseaK
	 jeMaZbyafHqSOXofVaXCuRDUpC5g+6LxuHVrji/JG/m/xteTtk2UWriWu44eoe1UBv
	 xaBe5q2K/aymRLb965MNjXW8k+dAwkSARul14A3wE/gYj1mDdI8NhmX0xvzUKC6Umk
	 00JRC8nGU1gFQ==
Date: Mon, 25 Aug 2025 21:13:20 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ASoC: amd: acp: Remove (explicitly) unused header
Message-ID: <aKzD4EBSYb_RcWMO@finisterre.sirena.org.uk>
References: <20250331070943.3986387-1-andriy.shevchenko@linux.intel.com>
 <aKxraexKHD8T8zk6@smile.fi.intel.com>
 <aKyFDaYnXrC5sMiA@finisterre.sirena.org.uk>
 <aKyI4L-wMeL-TOV5@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pQHJ1daTIcaqBAsG"
Content-Disposition: inline
In-Reply-To: <aKyI4L-wMeL-TOV5@smile.fi.intel.com>
X-Cookie: Filmed before a live audience.


--pQHJ1daTIcaqBAsG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 25, 2025 at 07:01:36PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 25, 2025 at 04:45:17PM +0100, Mark Brown wrote:

> > all) which is often the problem and since they can't be reviewed
> > directly if something has gone wrong you'll have to resend the patches
> > anyway, so sending again is generally a better approach though there are
> > some other maintainers who like them - if in doubt look at how patches
> > for the subsystem are normally handled.

> I truly believe the 5 month is reasonable time for review, no?

You're missing the part about how you should resend instead.

--pQHJ1daTIcaqBAsG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmisw90ACgkQJNaLcl1U
h9C/Uwf+PLIPWCVKaGNH6oQ3T1D7uUvBzN7kzE08VZk82XIxor9oHQqXEDqYndOW
D5ue2vk8on50sAmaKhD8E/z3s7nPgZglQ+Ma+YcuxQz2G5v+RYtEiS86C/4yg1nN
ivoauIFk8oYhUezflEjnM/HTo+UpsWQ9lIj8xzHH1UuHAWIqrXBMioMdu3RMBVX+
Y/+3CnyUGuIEc1lG50nWOTbXzYLWvw2IyzgoPqdESYUlIKM+5x49guZt4PRg4cVt
URqVXaomTvI50YLQvS59InHeiQY6iYUPx3gQ5V/RQTbxKu7xrIp6y1HFuXxnaBvS
ri7CojUdJ9Jv8qkx8yKr6B1hbIzVBw==
=hovd
-----END PGP SIGNATURE-----

--pQHJ1daTIcaqBAsG--

