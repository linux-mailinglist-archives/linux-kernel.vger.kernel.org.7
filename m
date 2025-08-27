Return-Path: <linux-kernel+bounces-788176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809E5B380BD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B690C16B95A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A25834DCE3;
	Wed, 27 Aug 2025 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJC70Usa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A0D342C92
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756293683; cv=none; b=Afusp9bKnK2WAT69R7ywVVBixKWXiepxu1MicsrrtcTpsTbHIbgBOg8YklRbA9gArdVuqDJwYGxjDqJwgJDY959f/D271DCACSF+M6sGy95xg8GkKaToUriTaT64+zZVIsKIkvI+UNNoFlERR8GHOjdAaeLGiQEUh4hJjw6F1Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756293683; c=relaxed/simple;
	bh=dI7cWzfS/291OsvZ5V1she40+eGFmZ3jW+/Cg11WRzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOmxveCwADoW6B5R7jqH8gsGfeyi6czjyODR/6sSLBQu2r9mQ8QvkrFbQL7e/IZ3cQJoMrPKRVTkRl5IT+t3IprzjAuf/hrTyRhZZTkEe8nZoEs/+xVDfOr5/VKfGckp2xah20uGyOzt4MrvG8ErPG822IjJgpG7wDMQqLNs3q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJC70Usa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0964DC4CEEB;
	Wed, 27 Aug 2025 11:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756293681;
	bh=dI7cWzfS/291OsvZ5V1she40+eGFmZ3jW+/Cg11WRzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cJC70Usa0leF1QY3kRLZEQxKcF196KNMy75izW4aF056588POf7hw8ooRR/BYccUU
	 hU9/eXR/CV6+o9Z+vo5GnQZGlzUNvdatk4wTBdV6pDkwstzlB58X8zixd3rnd3uTJb
	 7/DEwiq1/ZAueEQmIxSn/h6XGxOwhtanTNeto5o5/ZZ4nMR08APakzzUMgj0eQGEQ4
	 OeJZkILfGtaz9mjvduDRlbaBL1NbRQ+NQLM/reY4aULl+yZO8Z99mbyNHZXjruf8wu
	 21/tEqa7FP32zo66HWj9TO+BHinfCNKDEWOX2BuyUirMHlYwfGHZIXg1vEWDmy6F95
	 WMOemtxOFxohQ==
Date: Wed, 27 Aug 2025 13:21:19 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Daniel Stone <daniel@fooishbar.org>
Cc: Shengyu Qu <wiagn233@outlook.com>, 
	Marius Vlad <marius.vlad@collabora.com>, alexander.deucher@amd.com, christian.koenig@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, harry.wentland@amd.com, sunpeng.li@amd.com, 
	siqueira@igalia.com, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	contact@rafaelrc.com, lijo.lazar@amd.com, jesse.zhang@amd.com, tim.huang@amd.com, 
	dark_sylinc@yahoo.com.ar, mario.limonciello@amd.com, alex.hung@amd.com, 
	aurabindo.pillai@amd.com, sunil.khatri@amd.com, chiahsuan.chung@amd.com, mwen@igalia.com, 
	Roman.Li@amd.com, Wayne.Lin@amd.com, dominik.kaszewski@amd.com, alvin.lee2@amd.com, 
	Aric.Cyr@amd.com, Austin.Zheng@amd.com, Sung.Lee@amd.com, PeiChen.Huang@amd.com, 
	dillon.varone@amd.com, Richard.Chiang@amd.com, ryanseto@amd.com, linux@treblig.org, 
	haoping.liu@amd.com, Relja.Vojvodic@amd.com, Yihan.Zhu@amd.com, Samson.Tam@amd.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/2] Add "pixel_encoding" to switch between RGB & YUV
 color modes
Message-ID: <20250827-enchanted-merciful-badger-d51816@houat>
References: <TY4PR01MB14432B688209B2AA416A95228983EA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <aK1hPoCmLziaPPOd@xpredator>
 <TY4PR01MB1443219A9870877AF120FE63B9839A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <20250827-imperial-mongrel-of-dignity-712fab@houat>
 <CAPj87rPhK+E2FP62fnNxFySDOkqqKxo_oa94i7DR3_6a1j1o1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="refg77jsxnoyylwx"
Content-Disposition: inline
In-Reply-To: <CAPj87rPhK+E2FP62fnNxFySDOkqqKxo_oa94i7DR3_6a1j1o1A@mail.gmail.com>


--refg77jsxnoyylwx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/2] Add "pixel_encoding" to switch between RGB & YUV
 color modes
MIME-Version: 1.0

On Wed, Aug 27, 2025 at 11:39:25AM +0100, Daniel Stone wrote:
> Hey,
>=20
> On Wed, 27 Aug 2025 at 10:41, Maxime Ripard <mripard@kernel.org> wrote:
> > On Wed, Aug 27, 2025 at 12:26:56AM +0800, Shengyu Qu wrote:
> > > 1.Can you send patch with only i915/amdgpu first? It's a long-needed =
feature
> > > to deal with some monitors/TVs with broken EDID.
> >
> > If it's to workaround broken monitors, then it's really not something we
> > should be doing using a property.
> >
> > Most likely, those monitors don't support YUV* output and will just need
> > to be forced to RGB, so it's not something that the user (or the
> > compositor, really) has to care about.
> >
> > And it would be broken with every driver, not just i915 and amdgpu.
> >
> > We already have some quirks infrastructure in place, the only thing we
> > need to do is create an EDID_QUIRK_NO_$FORMAT, clear
> > drm_display_info->color_formats based on it, and you're done. No uapi to
> > agree upon, support, test, and it works with every driver.
>=20
> There are other reasons to have uAPI though ...
>=20
> One is because you really care about the colour properties, and you'd
> rather have better fidelity than anything else, even if it means some
> modes are unusable.
>=20
> Another is for situations which static quirks can't handle. If you
> want to keep headroom on the link (either to free up bandwidth for
> other uses), or you accidentally bought a super-long cable so have a
> flaky link, you might well want to force it to use lower fidelity so
> you can negotiate a lower link rate.
>=20
> I'm all for just dtrt automatically, but there are definitely reasons
> to expose it to userspace regardless.

Oh, yeah, definitely.

But bringing the big guns and the requirements we have for those to
address the point initially discussed by the gitlab issues seems like
biting off more than they can chew.

Even more so since whatever uapi we come up with would still depend on
the EDIDs, and they would still be broken for these monitors.

Maxime

--refg77jsxnoyylwx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaK7qKwAKCRAnX84Zoj2+
dh1AAX4wnbnflKisabavSbNpeVGKoV3UrpsXVW9imDQtcjm7YudXmfvfYqpuzSkp
94Pjwm0BfjRoTmFEeZpDWZ9/v0k4QqGl4uv3hYL5xuMnYs8wyX2fRrswvdyR3/nS
ZfHMj/I12w==
=HUUG
-----END PGP SIGNATURE-----

--refg77jsxnoyylwx--

