Return-Path: <linux-kernel+bounces-816819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F3AB57898
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A801B1888A37
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5182FE592;
	Mon, 15 Sep 2025 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0snSTnI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443BB2FC015
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936252; cv=none; b=S2cU4g0qRdCdCu4MdlwatvEW0h+iiI3jJ4pQuRs0xHJ3ZbzcZGqoPgBBYbbXv0oB9GpGpBbVfmKRWofepKz+7Q1LBurMnEaqYoWApHUKWiIE2/PVL2u8dTYyZthMTiwqIsYSVreYMO98p/n41DDmZOnPijBsnio+LHx65CJVcbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936252; c=relaxed/simple;
	bh=pTLgLrWjvJcI34WEgogI5pmVGE1Q2782+yLOnrPimjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbzYrzuVu5zjsdya0xn+4rTN6Kgg6VH66kmOaRbnZ/se9p+0pp4oUQvlENXctrcDZp9CrfXnBCwJL85cAptF/RhaRRyjEApHs9Jub34vlk2m1Pa4Ax9wiNLWYksFxMIOr3k7W+PFyRHSYbzXJbUMbU/A+YatrSP7vIA8AcEqg74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0snSTnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B54C4CEF1;
	Mon, 15 Sep 2025 11:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757936251;
	bh=pTLgLrWjvJcI34WEgogI5pmVGE1Q2782+yLOnrPimjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R0snSTnILeSLhn46HJ2y2eQj0k1bRnyhA1W0oj5xji+Ou/ci3A0F7SjmUtDuLFdIW
	 77yb8qpz5p03ARqJzYuv9nRjUHCE6i0KkpubanHHEliniagxirOAJONZxe+IlhLEqF
	 1Af8EipwRsHcQPhMAQg5Z96sFFluWWXjbKg/vth8wRYLM/ZBqMobFOAX79khBTGHfu
	 6JJ1VmZfVk+ErOjyGvRzpntVyXofYE9U5cf6aZrfe2M02D2kDRw3XgwnxwQaC9NfGP
	 E0ZzRvo4nHVjwdTz3xzfZaULH4R6IRHEEnEXSfXS3MQ7W7AtaFCCVHDNBQo7s9HyiP
	 NH+I0GFQ2gZyg==
Date: Mon, 15 Sep 2025 13:37:28 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Devarsh Thakkar <devarsht@ti.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/29] drm/modeset: Create atomic_reset hook
Message-ID: <20250915-radical-vagabond-jaguar-b45157@penduick>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-9-14ad5315da3f@kernel.org>
 <20250902210445.GX13448@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="pfit7i5w3kasuvbx"
Content-Disposition: inline
In-Reply-To: <20250902210445.GX13448@pendragon.ideasonboard.com>


--pfit7i5w3kasuvbx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 09/29] drm/modeset: Create atomic_reset hook
MIME-Version: 1.0

On Tue, Sep 02, 2025 at 11:04:45PM +0200, Laurent Pinchart wrote:
> On Tue, Sep 02, 2025 at 10:32:37AM +0200, Maxime Ripard wrote:
> > Since we're about to integrate some infrastructure to implement hardware
> > state readout, we need a way to differentiate between drivers wanting to
> > start from a pristine state, with the classic reset sequence, and
> > drivers that want to pickup their initial state from reading out the
> > hardware state.
> >=20
> > To do so we can create an optional reset hook in
> > drm_mode_config_helper_funcs that will default to the classic reset
> > implementation, and can be setup to a helper we will provide in a later
> > patch to read the hardware state.
>=20
> I'm a bit puzzled by this. Isn't the whole point of the existing reset
> operations to allow drivers to read out the hardware state if they wish
> ? Why do we need something new ?

I'm creating a callback for drivers to select whether they want the
current reset behaviour (ie, start from a pristine, default state) or
implement readout through a set of helpers.

What's puzzling you?

--pfit7i5w3kasuvbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJQEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaMf6eAAKCRAnX84Zoj2+
doi/AXi7tycst9EqlH6loakkYlWwONQc8IvQ3qxh9G6ZzE0XZ+AV3Qr7t5hFK9Yi
8nmrcwGAiJDAmS1g3/DYYDz11gaokXqbL3adEyP+aXZhldbavVAfmcoKyUzY6n2w
QLM61AOT
=NGUq
-----END PGP SIGNATURE-----

--pfit7i5w3kasuvbx--

