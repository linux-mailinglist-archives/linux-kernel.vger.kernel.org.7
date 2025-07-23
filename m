Return-Path: <linux-kernel+bounces-742335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0E9B0F01B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9F7964EEC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3DD2BDC15;
	Wed, 23 Jul 2025 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wb7gA+dL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B416928137C;
	Wed, 23 Jul 2025 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267221; cv=none; b=tvsUuU3RDnaD+UTgKsvqUg0/OFVcXNQ0+wZU03Bvig1fQol5KCPTKla2lGaWiTkHM669fqmLtWNoNzzALGpWa/1x4E/TkzGOS+oTIHKOJ2nf0BuG2pgpSCtKM20Msa+xbxd7oAg33h2xUO8w9R2Pag3FiUo+BVkjS4VPHPMrHn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267221; c=relaxed/simple;
	bh=Kr9pqZNtJgRq0KuJQB/cKSB7DHn2xeP5OuSwdjWmQ5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbCQUdYR4eChUvkReyNFp/xnD8EJkR+IwEni2PjJHV+5/HImqgIpCvlm41VwMvuD8Y1GtHJR0gx6axJ5l8rfWRMAEbq1L4O2t8QyqYKODCGzohLTCSvUeBCHhyYD1ASQa5z9vyAFqvefOQv2ayn1NnewOxam1haVz7k8WkH77fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wb7gA+dL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E282C4CEE7;
	Wed, 23 Jul 2025 10:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753267221;
	bh=Kr9pqZNtJgRq0KuJQB/cKSB7DHn2xeP5OuSwdjWmQ5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wb7gA+dLTG19+kAQhtI7r0ZURbl/JDkasqowAE3a/Wh248Nnlc1k7aU/ksS9RYamq
	 knUFyuAwhsxKRsAI/GG5CibNsysPDlNp0afPwO/aCFq6sRgp0+shNphfUqcwHJi0DH
	 3zs7KxJtS+1uKRBASoEE7QKPSkc2D6lJ6IXybMF9LHGU4aZuB6JczBwnpWZJ7EHg1O
	 gg+A1yYh9daxiGnJOFjBpZhC0l0n5Om15FAGdxEoDiUhzgyiLNnxFBFRJbttHttbMN
	 duLDp6XGWO6RXQ3QgR66ZfIwhP5gpt2SItcGGEYZ4XA0smDpSHIKYfufmwryt8Qtgx
	 UZgjbM2LQ2PaA==
Date: Wed, 23 Jul 2025 11:40:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Douglas Anderson <dianders@chromium.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Raag Jadav <raag.jadav@intel.com>, dri-devel@lists.freedesktop.org,
	linux-sound@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v2 2/3] ASoC: hdac_hdmi: Use dev_info on invalid ELD
 version
Message-ID: <b209b185-8caa-41d4-8f8d-95aefec1d785@sirena.org.uk>
References: <20250722195437.1347865-1-detlev.casanova@collabora.com>
 <20250722195437.1347865-3-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eFKBin1ilgiNfb0m"
Content-Disposition: inline
In-Reply-To: <20250722195437.1347865-3-detlev.casanova@collabora.com>
X-Cookie: List was current at time of printing.


--eFKBin1ilgiNfb0m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 03:54:36PM -0400, Detlev Casanova wrote:
> When disconnected, the ELD data cannot be read by the display driver, so
> it just sets the data to 0.

Please don't put patches for different subsystems into the same series
if there's no dependencies, it just makes dependencies less obvious and
creates hassle merging things.

> That makes the ELD parsing code read an ELD version of 0, which is
> invalid. In hdac_hdmi, that is logged with dev_err(), but should be
> logged with dev_info() instead as it is done in sound/core/pcm_drm_eld.c
>=20
> This avoids printing multiple messages like:
>=20
>     HDMI: Unknown ELD version 0
>=20
> in the kernel log when userspace tries to open the sound device.

It doesn't, it just lowers the severity of the logs that are printed.
If the goal is to lower the number of messages printed you need to use
a ratelimited print.

--eFKBin1ilgiNfb0m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiAvAwACgkQJNaLcl1U
h9DLlAf/UR+hhxSi+4m+Jov1EipVWvw6PObyiKC9GcgVW5a8/3sx58QxgNNL8n3q
VL8fD2dSxmbCICrI92GRYs2EXXQI6MFk2n5HgxDCWK+GzqcgfmkxTEKaXRezAgdD
Z74CEyQKMytwHrZg0hSN4uIy62KUm6gLu7A+GI2rOOJ3Xd8IgaDyVt1WoRfdj8nO
StiMnf3kaa9LgC5Ql9J0cqdhKI0xA6FfdcrU6qO2Ki6/644qZDzgrnVaVMjP4lpp
kT6s8rVgT7gMIlsnUk8U2l4Q8q/fEUibVe2groGTUmiYOZU4MUznrXVPF+fuYi5G
JttLPr13R3i/120Tj1aSwcBpmslvjw==
=8mPT
-----END PGP SIGNATURE-----

--eFKBin1ilgiNfb0m--

