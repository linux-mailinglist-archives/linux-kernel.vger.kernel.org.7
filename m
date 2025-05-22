Return-Path: <linux-kernel+bounces-659441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 376DEAC1058
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 17:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689601892181
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 15:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B73299A9A;
	Thu, 22 May 2025 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ps30CyU8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3735628A402;
	Thu, 22 May 2025 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929213; cv=none; b=qHz4waSshiKid7RprA0sl/L9kDFdzIMtTfc5ucTxbKoJCqnazlCkldGlc4yBhKnwZF5DtbypdXH0e9jtO8Klq8Q+65ZfQr6H5XYmk3HwZIzhwOGcwRq41iUiiB6GyRc6C1B2tyZsgERxerlh0PxfKRJIuwHT/JZ20uqG7zvRMEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929213; c=relaxed/simple;
	bh=sER6TUaJO5zCcIJR06Jkz1EP6QGdFEs+tdDFZCI1zxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTfgthVnBCfg8UKku6bNP7J1gD6qoOvAa5xJ9HxUHNr3KarBoehrfjJjmsgWRvNKM4rFpJxtkoXuF5El+9jSNoIV3w/65cl+IH72c/OK1iUXlI7iKhXd8zlAQv9Ed72jxrk734tkJxicN1QDoq4xZcSXbwAOo4U/ulrN5n4TeCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ps30CyU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55017C4CEF1;
	Thu, 22 May 2025 15:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747929211;
	bh=sER6TUaJO5zCcIJR06Jkz1EP6QGdFEs+tdDFZCI1zxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ps30CyU8dki7pBTSKkw76kLUvEJKyQFEic6MewttYzE+CvgWe/ax+9nq5P3f2QUJP
	 zf+cvPoPHdTdzqJp3o6GP0aEdCTR87minC7VZb1eAVW5zhBsEdJQd5kNKGx4zmKIc7
	 sEmc1bReq9hH3nziRpkR84ezFrag397mdYRklpeOMGSj4oV671U3ixUnrM4P3FgXZv
	 xSqQ8Sd3Ucb0REymlrCPo7VKNcmmzULs3D3i2wDjdmdSQ7Y/h3dUvIFa+rkNtDbu7K
	 1D23kkjZm3M2n23tIrgBmCL4Rt7ZunjQpuPwILGgHU8FP/NOZoNeCF83G0U7wUTX9+
	 E+6XK1sOq1J3g==
Date: Thu, 22 May 2025 17:53:29 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Anusha Srivatsa <asrivats@redhat.com>, Paul Kocialkowski <paulk@sys-base.io>, 
	Dmitry Baryshkov <lumag@kernel.org>, =?utf-8?B?SGVydsOp?= Codina <herve.codina@bootlin.com>, 
	Hui Pu <Hui.Pu@gehealthcare.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] drm/tests: bridge: add a KUnit test for
 devm_drm_bridge_alloc()
Message-ID: <20250522-fierce-carp-of-competition-1c0ecd@houat>
References: <20250409-drm-bridge-alloc-doc-test-v7-0-a3ca4b97597f@bootlin.com>
 <20250409-drm-bridge-alloc-doc-test-v7-2-a3ca4b97597f@bootlin.com>
 <20250414-misty-hungry-woodlouse-dbbd64@houat>
 <20250415132214.19b1a4ff@booty>
 <gqe4ov7w54qe7mmfn2ud63g2ema2wh3qvyfvcaycvnh5mts3it@ef7qxryo2ccy>
 <20250516173828.7f1aa70c@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="5dunwaxeeh5jyh5b"
Content-Disposition: inline
In-Reply-To: <20250516173828.7f1aa70c@booty>


--5dunwaxeeh5jyh5b
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 2/2] drm/tests: bridge: add a KUnit test for
 devm_drm_bridge_alloc()
MIME-Version: 1.0

On Fri, May 16, 2025 at 05:38:28PM +0200, Luca Ceresoli wrote:
> > > Another way would be adding an optional .destroy a callback in struct
> > > drm_bridge_funcs that is called in __drm_bridge_free(), and only the
> > > kunit test code implements it. Maybe looks cleaner, but it would be
> > > invasive on code that all bridges use. We had discussed a different
> > > idea of .destroy callback in the past, for different reasons, and it
> > > was not solving the problem we had in that case. So kunit would be the
> > > only user for the foreseeable future. =20
> >=20
> > Sorry, we've had many conversations about all that work so I can't
> > recall (or find) what your objections or concerns (or mine, maybe?) were
> > about thing topic. It looks totally reasonable to me, and consistent
> > with all the other DRM entities.
>=20
> That was a long story and I also don't remember all the details,
> however here's a summary of what I can recollect:
>=20
>  1. initially I proposed a .destroy called in *drm_bridge_free(), i.e.
>     upon the last put [1]
>      * it was used to ask the bridge driver to kfree() the driver struct
>        that embeds the drm_bridge; that was not a good design, putting
>        deallocation duties on each driver's shoulders
>      * it was made unnecessary by devm_drm_bridge_alloc(), which moved
>        the entire kfree into __drm_bridge_free() itself, based on the=20
>        .container pointer
>  2. we re-discussed it as a way to handle the panel_bridge, but in that
>     case it would have been called by drm_bridge_remove() IIRC [2]
>      * you said it was not a good solution (and I agree) and that a much
>        wider rework would be needed for panels, eventually including the
>        panel_bridge
>      * then Anusha sent the patches to start the panel rework

Thanks for the summary. I still agree with our discussions, however...

> So now we are discussing adding .destroy again, and in
> __drm_bridge_free(), as it was at step 1, but for a different reason.
>=20
> [1] https://lore.kernel.org/all/20241231-hotplug-drm-bridge-v5-3-173065a1=
ece1@bootlin.com/
> [2] https://oftc.catirclogs.org/dri-devel/2025-02-14#
>=20
> > I'm also not entirely sure how invasive it would be? Add that callback,
> > check if it's set and if it is, call it from __drm_bridge_free(), and
> > you're pretty much done, right?
>=20
> No much added code indeed. My concern is about the fact that the
> callback would be used only by kunit test and not "real code". It is
> possibly worth doing anyway, so I wrote something for v8 and we'll see
> how it looks.

=2E.. It's still useful. With KMS drivers, you usually get two different
lifetimes: the hardware device and the DRM device. The DRM device will
outlive the hardware device. Thus, the driver instance will still be
live even after the device is gone away, and still need to somewhat
interact with the framework, even if in degraded mode.

All the resources tied to the device (memory mapping, clocks,
interrupts, etc.) are handled by devm. We don't have to take care of
them in destroy, they are long gone before we reach that point.

However, the bridge might still need to allocate memory, create objects,
 to interact with the framework. Things like a private object, or a
 scratch buffer, or... whatever.

But anything that the driver needs to implement what the framework
expects basically. *Those* are what need to be cleaned up in destroy.

Maxime

--5dunwaxeeh5jyh5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaC9IeAAKCRAnX84Zoj2+
dogNAYCBWTPdxU7ITy8hdIEHBDmtiUmctJ46NQeWBfdzue2ao3tTwn7pHC34aPQK
H257clIBf02ghWwpXc0wZ0WMKVGH9aW0+J8MV0GiUEaZPrTGH5ibbNZcKC6XQX+P
3j9T4rfn1A==
=GinJ
-----END PGP SIGNATURE-----

--5dunwaxeeh5jyh5b--

