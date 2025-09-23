Return-Path: <linux-kernel+bounces-828700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB98BB953BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB1B16C540
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1829D31DD87;
	Tue, 23 Sep 2025 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxXUer5x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729DA31812F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619434; cv=none; b=IaiWl0Ejim1WfBfae6lCZvK3QaAItRFe0YSTwet5dqYy5BQ3h+mVggV33ZoOVSi1fC5bJq++WHRSbhw3P9hFBMbuWZFQc2zvmbkzG62abxGZJf1THo8belbfjK30hHmlYL50ZyVWzpHXJ/wW94ttpFBjG8xeqBM9rBMPFL/z2UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619434; c=relaxed/simple;
	bh=VJmFWq9phPo+OVJfPMu+zb2qA1SYK8IdgbMyO1gb6b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWve67lP6DdHOJeh9ENO5wB1JhGlC7nPPYDHu82HZrepTf/+g+Xj9KWuUVLxUk7oQ8frj/XhHo+41cBk7e3LwhAD59zVanKZHHWj5HmcimjFTosQlm+U9LZKB4H+20YGDGDhvzIbk2E8SddCdd3FXgT9JHWTgUGL/pegF7rQHYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxXUer5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CA3C4CEF5;
	Tue, 23 Sep 2025 09:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758619434;
	bh=VJmFWq9phPo+OVJfPMu+zb2qA1SYK8IdgbMyO1gb6b4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dxXUer5xnZw8HKJmwrpeDs2Sl2gTiE/JmNHA+w0ihsiGIv5L8mH/Gi+QKmWyNOuHq
	 miPL8FfNEbzntfXjgrpJMUSY+SyXbKzL0pivr7FNMKrf9a0AxmVLcFwVjppa6+SpLm
	 mbYZrynE3ysh6Vq0kM0D4EPGEbYlnTq4y5USbLbozopBMaS3+TkcdavGU0xs6vNbtp
	 I+kTvX0Y94gJKm45RXrfA6sWw/Pjb7BLkBZT73HsyhuIsfzsbtByUS1csubA1gwkz1
	 nHs5AsGv0Wd+Zw1LX5a0+IOpdfrb01oRBIoxH6EH7bzO3uzDXq539NQHkaeBWk//Vs
	 Y3zlc/uvhH8Tg==
Date: Tue, 23 Sep 2025 11:23:51 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jyri Sarha <jyri.sarha@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/29] drm/atomic_helper: Skip over NULL private_obj
 pointers
Message-ID: <20250923-incredible-bouncy-partridge-f4b208@penduick>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-4-14ad5315da3f@kernel.org>
 <adba0c39-228b-4311-83d1-09aa71ddb911@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="bvuotqy6zbwcwfga"
Content-Disposition: inline
In-Reply-To: <adba0c39-228b-4311-83d1-09aa71ddb911@suse.de>


--bvuotqy6zbwcwfga
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 04/29] drm/atomic_helper: Skip over NULL private_obj
 pointers
MIME-Version: 1.0

On Tue, Sep 02, 2025 at 03:13:30PM +0200, Thomas Zimmermann wrote:
> Am 02.09.25 um 10:32 schrieb Maxime Ripard:
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
>=20
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>=20
> However, can this happen? Private state objects without state data?

Yeah, sorry, I forgot to add a commit log to that one. I'll add one.

Maxime

--bvuotqy6zbwcwfga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaNJnJgAKCRAnX84Zoj2+
dtgAAX48fNhqN35P+Pk+AlwSx/j1bCXSm2lBkpSYbAOjl6vJsFyAk/j40le10cKS
BeBU6wEBgI5sZB9wGXs14MZvMM8RhsWTvOv9cO5ISu8JH57cGQp+kCCiqqy4WxiK
63iSsNszTg==
=mYZ0
-----END PGP SIGNATURE-----

--bvuotqy6zbwcwfga--

