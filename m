Return-Path: <linux-kernel+bounces-723567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FAAAFE88E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8BB3BD075
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0BC2D59E7;
	Wed,  9 Jul 2025 12:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3kbgsMS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D4921FF46
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062754; cv=none; b=ZZUueWwCr298R1moE/3B+24skb3Ce91zBVXaXRPbh4s7i3J9l550q2e91B+2iIPQn4PvOJuVxXgDwQp/8HndKmWgtEiTXBDoAHR5q4YK2tU7UpkR6cA1OUniDfmh+hdDLCipJ4NB9qWUnsqCJQARvfUIG34oSqiXb1gFHDVrrZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062754; c=relaxed/simple;
	bh=T7qObQuPEJsl5l8Yj/V7hI/MQcgv9lfyzuotfuZmIqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdpr9+OU3HkavvS7cStKtOC2hIZ9yAKEwCQwHZIFfctrz/OAJbya7a8httOAXnjj12h/EvEQDrBD+gYQPP5hkA4iJzmgx9Yxayrs+QOhmkeojRFYP7kfXRrDU88whdLArzDKbz3GSANA61yYrN+H2CWSc7PyWiezxAQ1GXGBXgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3kbgsMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E757FC4CEEF;
	Wed,  9 Jul 2025 12:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752062754;
	bh=T7qObQuPEJsl5l8Yj/V7hI/MQcgv9lfyzuotfuZmIqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c3kbgsMSSo2DxnNwIF7FseJWV0hgyE5sX6V7e4PcOG+t0Yx/QfczmTKcIlP2RyhF9
	 YwUaf+z2P4iJgzrRSNk4l31OY5m9e0B/NLX0kPuEMmDpRO0m2hl8OOLpwnYLijceZR
	 GFkUBaC7cmwgbtyAJWWQpk5dntJ1XynZRJ6QxTXqUtjaQuJxHkGF9vvVCVh1Ed6Ruo
	 vSzWDj8YLSB0ZF+Lo1Q0pBLSb5wTj4/ggurSN9k2Vw2h3rnyMgyoM7v4si4NUIMgRE
	 EjNtgy5LjJhic5ShbqHNAgK4dzWs9dblcPtVO6N9nDKcmYSdKLeUSteSt0/ve/r9w6
	 Ghyh4Vm12PLTA==
Date: Wed, 9 Jul 2025 14:05:51 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Alain Volmat <alain.volmat@foss.st.com>, 
	Raphael Gallais-Pou <rgallaispou@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Hui Pu <Hui.Pu@gehealthcare.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm: fix missing conversions of bridge drivers to
 devm_drm_bridge_alloc()
Message-ID: <20250709-rebel-jackdaw-of-promise-8bf5d3@houat>
References: <20250708-drm-bridge-convert-to-alloc-api-leftovers-v1-0-6285de8c3759@bootlin.com>
 <175205374260.60140.13824257782987722025.b4-ty@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="kp4biqemxmreifr2"
Content-Disposition: inline
In-Reply-To: <175205374260.60140.13824257782987722025.b4-ty@bootlin.com>


--kp4biqemxmreifr2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] drm: fix missing conversions of bridge drivers to
 devm_drm_bridge_alloc()
MIME-Version: 1.0

On Wed, Jul 09, 2025 at 11:35:42AM +0200, Luca Ceresoli wrote:
>=20
> On Tue, 08 Jul 2025 17:24:41 +0200, Luca Ceresoli wrote:
> > Most DRM bridge drivers have been converted to devm_drm_bridge_alloc() =
by
> > [0], but a few drivers were missed. One got converted by [1], this seri=
es
> > converts all the (known) remaining ones.
> >=20
> > Thanks Marek for having found and reported them!
> >=20
> > [0] https://lore.kernel.org/all/20250528-drm-bridge-convert-to-alloc-ap=
i-v4-1-f04e698c9a77@bootlin.com/
> > [1] https://lore.kernel.org/all/20250627165652.580798-1-m.szyprowski@sa=
msung.com/
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [1/2] drm/sti: hdmi: convert to devm_drm_bridge_alloc() API
>       commit: ac4531424d907f3983e919a7bda2b90ea0cede4f
> [2/2] drm/sti: hda: convert to devm_drm_bridge_alloc() API
>       commit: 602d565d3c10dfb2dfd397f65078cb603a26a513

You sent the patches yesterday, it would have been nice to wait a few
days for the maintainers to answer.

Maxime

--kp4biqemxmreifr2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaG5bGwAKCRAnX84Zoj2+
dnohAX0YTQyc6crA05DCz21tpQ5/ndHLMsrKUAGyy5Djj6BJTUx/G3fJ2FmK+ujn
Zf08S4sBf13eFT/CFRaPF8quhtUAt7fI/h0Mu5BayMVkR3SDJHUxBZs8G1gxTvPQ
lfoQ+4XkOg==
=vdh/
-----END PGP SIGNATURE-----

--kp4biqemxmreifr2--

