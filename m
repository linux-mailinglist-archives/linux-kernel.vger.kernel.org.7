Return-Path: <linux-kernel+bounces-816918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 051E0B57AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74578207B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D541302758;
	Mon, 15 Sep 2025 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2A8ggRK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994072EB5C6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938994; cv=none; b=gd0Qn5ht8hrPzxcHmE7w96Rgs9PAf0hbMw3jOiELrg3ZA0DUyIt63L6vX6AnXf19LH8YkXx2L/27B+q3xDWdEn8t3HnoLosaZsDc0+SLxKIlAPQfnjE9YaGv8mSvj6ifN6Q2+xc66ytOFxthydbZAezApuzbuMG+dJlqWlflEFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938994; c=relaxed/simple;
	bh=jqrd4F599wjFXBZcervzvKqSubNiAnp6nziRzF5MIgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbUCbDPXwp3CkTjQy11hwHddeAjGklAv3YNJrsjGCXCnQr2UN5Di8ftk1fIFvd51rx/nqrgQVSwty3J8WLXpz875s/lKL+JNpvu8LuBTu+prjqd7TimdxTVmmiQoB4U3eA+WddQbCRSroVPhjCW8b5w/Zfo2QvSvBFEmLBDvZqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2A8ggRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9807AC4CEFE;
	Mon, 15 Sep 2025 12:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757938994;
	bh=jqrd4F599wjFXBZcervzvKqSubNiAnp6nziRzF5MIgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q2A8ggRKLe4+CGM6ls1+YnDLmMf3S3FeOvzvwaXILV7GBs19ayC1J2KNodesVbrZr
	 RRFWxxV+ceu0v/9+solFHC5Ir3zUchD8es8RMp13kuqLq5Pe7MEl13o0TS3vDP5Luy
	 V4fuVuWH8lLfE3638aH25Coxnp/hRoKdUoz2DuSV4Uu0LufswZuQi3Qh4TrfBo8cT3
	 Js7oUapD2BY4Gp15uir0qZS0cYSrdpBGklnjrb51Zix5DDLbY36aesO4aauywu/Rh8
	 zUnOGan9pzV7T/TyeIiCMcRoHjWPYMtdcIhEPqD0FzQlHibSSDrd7GLueJJkf99wgN
	 XMwbnyw88TKyw==
Date: Mon, 15 Sep 2025 14:23:11 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Hui Pu <Hui.Pu@gehealthcare.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v8 0/3] drm/bridge: debugfs: show refcount and list
 removed bridges
Message-ID: <20250915-tunneling-guillemot-of-potency-b0f675@penduick>
References: <20250912-drm-bridge-debugfs-removed-v8-0-5c33d87ccb55@bootlin.com>
 <20250915-celadon-dalmatian-of-defense-ca56fb@penduick>
 <20250915123010.18fd21f9@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="vgsm6me4entxblgb"
Content-Disposition: inline
In-Reply-To: <20250915123010.18fd21f9@booty>


--vgsm6me4entxblgb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 0/3] drm/bridge: debugfs: show refcount and list
 removed bridges
MIME-Version: 1.0

On Mon, Sep 15, 2025 at 12:30:10PM +0200, Luca Ceresoli wrote:
> Hi Maxime,
>=20
> On Mon, 15 Sep 2025 10:13:16 +0200
> Maxime Ripard <mripard@kernel.org> wrote:
>=20
> > Once the minor issue I've reported is fixed,
> > Reviewed-by: Maxime Ripard <mripard@kernel.org>
>=20
> Ok, thanks!
>=20
> v9 sent.
>=20
> Note that this series depends on [0] which is waiting for discussion to
> continue, so any feedback on drm_for_each_bridge_in_chain_scoped()
> would be very welcome to unlock both this and other series from being
> applied/sent.

Thanks for the reminder, I've reviewed it

Maxime

--vgsm6me4entxblgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaMgFLgAKCRAnX84Zoj2+
du4LAYDWJyAHlvGAIrTCz5X7RUON9sfarDjS08ZiABWMrdF9gxFKh3vhhoXbUxyt
HYuj2WQBgP+IYJShJVOgSdw758fb5iL9M7SIFj2SHRqP9Jsiyb8lBs1mVcExAw00
nsLCXZRvlQ==
=grnC
-----END PGP SIGNATURE-----

--vgsm6me4entxblgb--

