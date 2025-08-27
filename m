Return-Path: <linux-kernel+bounces-788040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F79B37F04
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2145D7A3D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FBE3451A2;
	Wed, 27 Aug 2025 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gd2/ZX2C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF49276027
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287681; cv=none; b=eQDwZCuxfbdKzD9c/jVkpQoArisADVZU8vkJo+uZW2qs/UYEw0xViznRenL0BghjPk8DImNwD2U5kNZzi0dmU9EO4d4quSB8nHlXQgX6QbwgJyllj+TNOzYo4Lf6f/hUzpFpCBhQ0RYCrIsR/if2a6Y/dlE523EeJCESiTX03QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287681; c=relaxed/simple;
	bh=yuR1aJSWhQS6UmvddUMXmIqnrXnogfXYY9F7Th1Zexk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fh5S/vVJAcX9lCqS86rN2vGUOfivRCohDulMuJ1AK+NET+FBWSRy7yQjW1lophf07zFHHNAEAp21AwBIHJgE/muYBD9YqSbTqr449wyp8qlrWhfXauEBiBA9QKkkJT/8yM4GT8qpLdUu3AQuMiq6T1jIZeuhvdUJdp/bVQwWdmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gd2/ZX2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15627C4CEEB;
	Wed, 27 Aug 2025 09:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756287679;
	bh=yuR1aJSWhQS6UmvddUMXmIqnrXnogfXYY9F7Th1Zexk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gd2/ZX2CLj+17s7jHJzxtIGI5tO2a2x6eL++PgQvjIkM+Bj8HZNYVSdxpnHphDpk/
	 q8hibjTs6IIabThSjiccLWjU8n+kS+j1IMh7qNbiSubJkKGuV1wOQhMkSnNrfRdD1h
	 h96rfAs4RBojqhBOU/RzdW4OqwF/4Dn0LFcZOnqQmgxpxLfN/UNffNBLLDWy6/Izlh
	 guHQA9VAf+1I7O4BwPtJsHpCy119IFfI5SwfYMeaTeKpHulZnzHtHQhDd5wtWzjUXd
	 Te45yHMmWusBOToQ1vtKqrFEUQ+PU0eUWva0J0smM2sHumGZ5Ar3uAv1PBtT2ZBkfb
	 glT0ElKlPvq3g==
Date: Wed, 27 Aug 2025 11:41:17 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: Marius Vlad <marius.vlad@collabora.com>, alexander.deucher@amd.com, 
	christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, harry.wentland@amd.com, 
	sunpeng.li@amd.com, siqueira@igalia.com, maarten.lankhorst@linux.intel.com, 
	tzimmermann@suse.de, contact@rafaelrc.com, lijo.lazar@amd.com, jesse.zhang@amd.com, 
	tim.huang@amd.com, dark_sylinc@yahoo.com.ar, mario.limonciello@amd.com, 
	alex.hung@amd.com, aurabindo.pillai@amd.com, sunil.khatri@amd.com, 
	chiahsuan.chung@amd.com, mwen@igalia.com, Roman.Li@amd.com, Wayne.Lin@amd.com, 
	dominik.kaszewski@amd.com, alvin.lee2@amd.com, Aric.Cyr@amd.com, Austin.Zheng@amd.com, 
	Sung.Lee@amd.com, PeiChen.Huang@amd.com, dillon.varone@amd.com, 
	Richard.Chiang@amd.com, ryanseto@amd.com, linux@treblig.org, haoping.liu@amd.com, 
	Relja.Vojvodic@amd.com, Yihan.Zhu@amd.com, Samson.Tam@amd.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/2] Add "pixel_encoding" to switch between RGB & YUV
 color modes
Message-ID: <20250827-imperial-mongrel-of-dignity-712fab@houat>
References: <TY4PR01MB14432B688209B2AA416A95228983EA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <aK1hPoCmLziaPPOd@xpredator>
 <TY4PR01MB1443219A9870877AF120FE63B9839A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="aiiszozkcroddann"
Content-Disposition: inline
In-Reply-To: <TY4PR01MB1443219A9870877AF120FE63B9839A@TY4PR01MB14432.jpnprd01.prod.outlook.com>


--aiiszozkcroddann
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/2] Add "pixel_encoding" to switch between RGB & YUV
 color modes
MIME-Version: 1.0

Hi,

On Wed, Aug 27, 2025 at 12:26:56AM +0800, Shengyu Qu wrote:
> Thanks for reply.I have some questions:
>=20
> 1.Can you send patch with only i915/amdgpu first? It's a long-needed feat=
ure
> to deal with some monitors/TVs with broken EDID.

If it's to workaround broken monitors, then it's really not something we
should be doing using a property.

Most likely, those monitors don't support YUV* output and will just need
to be forced to RGB, so it's not something that the user (or the
compositor, really) has to care about.

And it would be broken with every driver, not just i915 and amdgpu.

We already have some quirks infrastructure in place, the only thing we
need to do is create an EDID_QUIRK_NO_$FORMAT, clear
drm_display_info->color_formats based on it, and you're done. No uapi to
agree upon, support, test, and it works with every driver.

Maxime

--aiiszozkcroddann
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaK7SvAAKCRAnX84Zoj2+
dpDoAXwOHTj6PMlsOZTg4eHmXw/kZcuNP/1Ixisifoy2XRmUQjs3rClHV68f9a17
R61xJRYBgPB8xi8teNCoS+ypqv1XJXhTvTDVyrGoZXbr4AOHUGGKoXRM0Zv+SUMl
4EpLGDZkJA==
=0l9g
-----END PGP SIGNATURE-----

--aiiszozkcroddann--

