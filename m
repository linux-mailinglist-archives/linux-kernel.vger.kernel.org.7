Return-Path: <linux-kernel+bounces-885089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCE6C31F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8E23BA555
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434F2287503;
	Tue,  4 Nov 2025 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H31+LvlP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA3221C16E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272121; cv=none; b=qqiThfO/x/bVCZZxR4kacKAmuj8Lt0saWvEWGvO6wgm+knmvzzwSCB04tP+hKAjfZDal9yAp4/qK9A6vFAK+5H7/EFRcOjcXHHtqyzKJ7zSJDzv9oSigJpInfOT7qVQB0tg+U1pRvzVAu66LMHIMlxXU2Ou9P0ENUIAK1YcPZt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272121; c=relaxed/simple;
	bh=DN7XeznWU969ZGeVJdlOhDIuhhEQUqEJe6iuZEPx3/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RufeIQ5+Ix2c+vQd/WK3DV29+Oi8db5IccqTYjGSkchdy0WfcRRAXam8XQDQ421rhnduaL+MrrOcq676SrKVX/w4li1PHY4fwDcPzG8AR878XJZh3ht0HB/XAiaK3fFOUv+Gvxx0sDd2PXjANh48Ot8oQDQtlInjdA/zhnPT0Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H31+LvlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD22C4CEF7;
	Tue,  4 Nov 2025 16:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762272120;
	bh=DN7XeznWU969ZGeVJdlOhDIuhhEQUqEJe6iuZEPx3/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H31+LvlPExkUnMD93ATgVEX6v348Nr1vy5e4V+TtSlks21+mTv3+2UVGDVg/gj9wg
	 7KtHaEMZG6K6e0rLfoK66yDPkqEPFPQda5LqPjFZ2efXUJ7LmWHn2zKSf46/VBZVER
	 uUhZn5NPulnCv9J+lJ/xzEZPHsCtsVqLMy4ux8zoB7VzvThB+RcjxPZkyUSPUCDDq/
	 GstPj209iGI/7rkA2iHTDR9M7H27B5Hi9YlZQPxYDVW+ZSLz8hvX6+yVLACYgY/3p7
	 8id7yPecdmx3wPx5BGNKelXHuZakOd6scBwMU1G0vcsVmmihM5Zao9WDIBMdMxFJyf
	 VZpGvtZ7N7bFg==
Date: Tue, 4 Nov 2025 16:01:57 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: regulator branch mess
Message-ID: <aQojdTvP94aYVW4l@finisterre.sirena.org.uk>
References: <aQoZ22aT27wHBpbI@smile.fi.intel.com>
 <aQocq1eRjOOjiRdY@finisterre.sirena.org.uk>
 <aQogTFANK1fMtloW@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LLUNuNT4vb5Ln+id"
Content-Disposition: inline
In-Reply-To: <aQogTFANK1fMtloW@smile.fi.intel.com>
X-Cookie: If in doubt, mumble.


--LLUNuNT4vb5Ln+id
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2025 at 05:48:28PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 04, 2025 at 03:32:59PM +0000, Mark Brown wrote:

> > which doesn't doesn't correspond to "thousands" of lines.  I really
> > can't tell what on earth you are talking about here.

> I look at it via GitWeb [1] and that's what I see:

You are not describing a concrete problem here.

--LLUNuNT4vb5Ln+id
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkKI3QACgkQJNaLcl1U
h9CMVwf/av4fkuadXwLLE2+VAtZbMcPvy3Z0ilrvCYwrVP98rgXKp/iTy8QpIC9x
b6pXcTVzJwXewivJNaFJRPbHGu0wWvAPXmt0xmNIGZED+9uOJN2GdLQRl6mP3pNF
IijrseKCszV8G5JGT57TNSyO+OKF1wAEaWftBM9di088W/PVcFj8uLTPqnoVsfor
mWms0eBIw4Kc3P0k4nxndZMHMPahBX2ZpefL3Pqa6mhJDz7HJvVB1cCmK1OQ17ux
PvmwcisEGrj1TxCIX5rpoaVNx4dL3To8l2wIxORoUHMa55guB8FjPMiNx4XbJUi9
zMXIVUT2Zh2LEr8AUa2+bNY4X7Igkg==
=0LSW
-----END PGP SIGNATURE-----

--LLUNuNT4vb5Ln+id--

