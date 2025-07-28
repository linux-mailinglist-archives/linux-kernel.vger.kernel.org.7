Return-Path: <linux-kernel+bounces-747628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE22B13615
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D4F3AB640
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368C22222C0;
	Mon, 28 Jul 2025 08:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9QZpS4i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9174E28DD0
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753690241; cv=none; b=WvFSof6WDxqg7kYb3dEJHKMlvN+apu5yrlyqcEVSd24b331q+wjl+armXzQqB5Joe9Tj0Vi0d/+ZKi+5hlCzxDcLbGNOK4acKPk48ZFn4U4/C9xp7+l/vprtzC+2fk3m5ZJSDODhXDRYK8iu+hyMuhy+Oc30YSJMsTChGy6OdtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753690241; c=relaxed/simple;
	bh=J2e+GLmMnOhCVKeoQ/p5+Rn7SWm0zUljYsTljYx8HDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIK9DI89N3Aw5J/4E+q2MKQiG/wsCkllOryh+4FGHcZoF6p1GMeIuR1Pn7gq2FfMvhAo+052XFqNgTk2NO4Vdc42GvlLQNb4Kkpr77EHRG5zg8xJmFTy4zjdUnL1Wfuk/cm/E6dkYdI9nSR5iyHjBH9RU9936qnnqojd3UirgRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9QZpS4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B7FC4CEE7;
	Mon, 28 Jul 2025 08:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753690241;
	bh=J2e+GLmMnOhCVKeoQ/p5+Rn7SWm0zUljYsTljYx8HDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E9QZpS4iCDTg0P+RhQHM0ShEggR/T915d8YaAoGajPdrg5aHnm8DLFeDnYuFITZGH
	 i2IWyH+NIGviDfj175OAg+v6RSuAo9wEmvFxuOhcSb1gqUFg2C1gFvlgjfzYADeSdg
	 Oqhcn4tpNZeHphi5FDApufj2WEXcekUkVGktfuk7XDXFI3CbB/0gZ7UZ3sWzZTN5vK
	 qoLEZhKwieNicqBVeY/HGwVc33ITwYNIxBbmPKkJdZibDvnazytVMNWkQeT4J/w3BS
	 WMz0WO9vQpvHHe/BhXV1I6xu4P5+mAdxoW1cP+hcfhagZXgmdydy0uiLtfMcg9LE/Y
	 Q0o+3/wU+IvYw==
Date: Mon, 28 Jul 2025 10:10:38 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Inki Dae <inki.dae@samsung.com>, 
	Jagan Teki <jagan@amarulasolutions.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Hui Pu <Hui.Pu@gehealthcare.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samsung-dsim: move drm_bridge_add() call to probe
Message-ID: <20250728-diligent-brainy-hyena-109dde@houat>
References: <20250725-drm-bridge-samsung-dsim-add-in-probe-v1-1-b23d29c23fbd@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="hhxl6bbucpmtrmqw"
Content-Disposition: inline
In-Reply-To: <20250725-drm-bridge-samsung-dsim-add-in-probe-v1-1-b23d29c23fbd@bootlin.com>


--hhxl6bbucpmtrmqw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] samsung-dsim: move drm_bridge_add() call to probe
MIME-Version: 1.0

Hi,

On Fri, Jul 25, 2025 at 05:28:03PM +0200, Luca Ceresoli wrote:
> This bridge driver calls drm_bridge_add() in the DSI host .attach callback
> instead of in the probe function. This looks strange, even though
> apparently not a problem for currently supported use cases.
>=20
> However it is a problem for supporting hotplug of DRM bridges, which is in
> the works [0][1][2]. The problematic case is when this DSI host is always
> present while its DSI device is hot-pluggable. In such case with the
> current code the DRM card will not be populated until after the DSI device
> attaches to the host, and which could happen a very long time after
> booting, or even not happen at all.
>=20
> Supporting hotplug in the latest public draft is based on an ugly
> workaround in the hotplug-bridge driver code. This is visible in the
> hotplug_bridge_dsi_attach implementation and documentation in [3] (but
> keeping in mind that workaround is complicated as it is also circumventing
> another problem: updating the DSI host format when the DSI device gets
> connected).
>=20
> As a preliminary step to supporting hotplug in a proper way, and also make
> this driver cleaner, move drm_bridge_add() at probe time, so that the
> bridge is available during boot.
>=20
> However simply moving drm_bridge_add() prevents populating the whole card
> when the hot-pluggable addon is not present at boot, for another
> reason. The reason is:
>=20
>  * now the encoder driver finds this bridge instead of getting
>    -EPROBE_DEFER as before
>  * but it cannot attach it because the bridge attach function in turn tri=
es
>    to attach to the following bridge, which has not yet been hot-plugged
>=20
> This needs to be fixed in the bridge attach function by simply returning
> -EPROBE_DEFER ifs the following bridge (i.e. the DSI device) is not yet
> present.
>=20
> [0] https://lpc.events/event/18/contributions/1750/
> [1] https://lore.kernel.org/lkml/20240924174254.711c7138@booty/
> [2] https://lore.kernel.org/lkml/20250723-drm-bridge-alloc-getput-for_eac=
h_bridge-v1-0-be8f4ae006e9@bootlin.com/
> [3] https://lore.kernel.org/lkml/20240917-hotplug-drm-bridge-v4-4-bc4dfee=
61be6@bootlin.com/
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

There's many things lacking from that commit log to evaluate whether
it's a good solution or not:

- What is the typical sequence of probe / attach on your board?

- Why moving the call to drm_bridge_attach helps?

- What is the next bridge in your case? Did you try with a device
  controlled through DCS, or with a bridge connected through I2C/SPI
  that would typically have a lifetime disconnected from the DSI host.

- If you think it's a pattern that is generic enough, we must document
  it. If you don't, we must find something else.

- Why returning EPROBE_DEFER from the attach callback helps? Also, this
  is an undocumented behaviour, so if it does, we must document that
  it's acceptable.

Without that, unfortunately, we can't really review that patch.

Maxime

--hhxl6bbucpmtrmqw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaIcweQAKCRAnX84Zoj2+
diFrAX0dOWwVJpvrdGrihZ9k9sjqDwnxQlT9ParohkOH/+omSlX7TeDpDUnCGIXJ
98XetfABf1lgG99jkFFG2UoKMqzFM3Any2hggvq6YPevVkdf8kvI/N2GVns0Hs/7
Tj81Ojl/YA==
=gmx9
-----END PGP SIGNATURE-----

--hhxl6bbucpmtrmqw--

