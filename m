Return-Path: <linux-kernel+bounces-816797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B67B5786E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1023B326E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EC82FDC54;
	Mon, 15 Sep 2025 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdjCM7PT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F902FD1CB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935730; cv=none; b=mbkOWMidLxplvbdhKX7t1YnPicgOrFilNDtVvCsM55LDugTZSYFtFaDdQTeupmmXVrcaznUqe7zyAMUcq4Ek5N6UNUAAq+8gH4KPHnEFVlXi08k7sW46gptN9dACoKa0KKRmTrTjS4jP5Mrusgn2cKcESRf3YvR0HUsgg5tcJlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935730; c=relaxed/simple;
	bh=ORv2//TEudHYm4PwsOQ0EaMG/K/TEzLwzZfTz+OY748=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rcz/j8aOEEaY0o0xaCkf1QmkL29vjOMEe4o9Rz9L9uLyoK23xaKbP1m8uoYfszAtQRDev7/NB3t89ALN16dUQvdnlSgi12HDUccQjYXZBdgDyMF6cBrJ1SkYawHRWH0F+QWaPLC+CDnDWdS3M1Jm1+4AMnH2EC4fx9mWSugZXOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdjCM7PT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A30EC4CEF7;
	Mon, 15 Sep 2025 11:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757935729;
	bh=ORv2//TEudHYm4PwsOQ0EaMG/K/TEzLwzZfTz+OY748=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MdjCM7PTr/F2Dej+nvLLNfoEcJYfgIU/KvfEvM6/kJ/wKr7DvgeNHO4TB/hGh6Eac
	 lPJf0gB2TEBNZI4Uwn2TpQBNwnszRVL+LXGu1iLFycXTKzIiQ8Nag50quwzyISSfN2
	 ZOgLscrOKhYfCALLknKK1MDk4O+4YfvcUCPS7fnqUhFCZpZoheI+0AlyYk5kqxqvad
	 Q+j4pGSZJh1YVku9SJctvalQsZ0MGXvjX/NqIF6LwPQfw8aHuEd6gxPSw7Cykm68kT
	 yFkjmsNFaVFICLBiXpxpk9vPLgbZ9zy8Oolt0hArzpmWVqPUis2O+YVJcb93DVVTVq
	 wjmlwNLbCmuOQ==
Date: Mon, 15 Sep 2025 13:28:46 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Devarsh Thakkar <devarsht@ti.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/29] drm/bridge: Implement atomic_print_state
Message-ID: <20250915-intrepid-quaint-bullfrog-bb68b8@penduick>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-6-14ad5315da3f@kernel.org>
 <056b0335-f104-4b67-9882-6beaecd21c76@suse.de>
 <20250902202212.GU13448@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="qak6uh7m5kswzx5p"
Content-Disposition: inline
In-Reply-To: <20250902202212.GU13448@pendragon.ideasonboard.com>


--qak6uh7m5kswzx5p
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 06/29] drm/bridge: Implement atomic_print_state
MIME-Version: 1.0

On Tue, Sep 02, 2025 at 10:22:12PM +0200, Laurent Pinchart wrote:
> > > +	struct drm_bridge *bridge =3D drm_priv_to_bridge(s->obj);
> > > +
> > > +	drm_printf(p, "bridge: %s", drm_get_connector_type_name(bridge->typ=
e));
>=20
> It would be nice to identify the bridge more precisely, but bridges have
> no object ID :-/ The raw pointer may not be very useful. I wonder if we
> should give an object ID to drm_private_obj instances, even if we don't
> expose them to userspace. That's not a topic for this series of course.

I agree, and would have liked to have something a bit more descriptive
indeed. But bridges have neither a name or an ID, so I couldn't come up
with anything better :/

> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks!
Maxime

--qak6uh7m5kswzx5p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaMf4bgAKCRAnX84Zoj2+
dpWWAX9+L9Pc2d++TXw4d76ib/BA9jnjklIlpvFzQhdWo/Iqy5ipGgej51nC2EQ5
4H/MHkgBgNPLHxflrW/rYvxe1BmuVHxZFKWB8o7t37zIxDPgW9vW4WKAHD9Eb1yD
Uc5w5MjYkA==
=gSDA
-----END PGP SIGNATURE-----

--qak6uh7m5kswzx5p--

