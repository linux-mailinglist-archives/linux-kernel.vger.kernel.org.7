Return-Path: <linux-kernel+bounces-787916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4163AB37DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F306C364D7F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438473314A6;
	Wed, 27 Aug 2025 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z3qV2foP"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5AB2E7F3E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282907; cv=none; b=cQwei69cwOn0AdX6rue1ZM1KSuO7pjAecaWthmDSl/8ZL4Z80Allb30slKo5U/Ze5+dLHsjA7cUEQMNRXKSwp5Y75Wmiy5RAk94QgFQFK9ng2SienatmexOHbQ8zr/uLexcWTV4jtAkqHjFy9/XzCNPifc201W53Tw8XNGQqa6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282907; c=relaxed/simple;
	bh=WZHpGVr2TD21PlMAaaLGZ90NJ6CiC6Z/m3WJo2syfpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOsdzBcn34/knxAC0TFHiTeXTrHjW0lHuf4g1MAtMAYvWcso3rAGE1sWrvyy+ZALntcXV+34c68iCfM+SJijjkIrMaUeQ95z1aQagRHslX0ICGUTgRxHjcdMLq5y16le7VhR8bzN39LKFlyFrgBjMPY1nWmt7013o1eMVKQYr0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z3qV2foP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756282903;
	bh=WZHpGVr2TD21PlMAaaLGZ90NJ6CiC6Z/m3WJo2syfpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z3qV2foPU9ABhtzNYCvPpa8QHbEf4tNhjHBE5jt+u+U0D98BxRelAvCh8FebtSeBA
	 EWUWDrph1AAkD8x6etOAjwIBAsMjU2WhC3StNe1FdjcA5kCj3a645q7kLRDxA+mbES
	 fD3h0UqzdJ95itZI/FJZ00PxDeEGK7J4nw3R+ktf86A5AYboLzotHp1z6AbYMKtS3U
	 S781f4IxOWOWapKV1O24ndUSJQBRdvssUzXD/K4BmW/pyiY4zKwf5MhFnIWxlaQC5A
	 JaQKUYsE2Ps6JMM6JksCPG5kXdMp7UIKZSXidqWtDsN0u5jKZGuFEzh2NKX4olh1l0
	 a+MPRbfaf+NZw==
Received: from xpredator (unknown [IPv6:2a02:2f08:eb0b:c00:e88e:21ff:fe65:be18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mvlad)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7C87C17E03B0;
	Wed, 27 Aug 2025 10:21:42 +0200 (CEST)
Date: Wed, 27 Aug 2025 11:21:41 +0300
From: Marius Vlad <marius.vlad@collabora.com>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
	simona@ffwll.ch, harry.wentland@amd.com, sunpeng.li@amd.com,
	siqueira@igalia.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, contact@rafaelrc.com,
	lijo.lazar@amd.com, jesse.zhang@amd.com, tim.huang@amd.com,
	dark_sylinc@yahoo.com.ar, mario.limonciello@amd.com,
	alex.hung@amd.com, aurabindo.pillai@amd.com, sunil.khatri@amd.com,
	chiahsuan.chung@amd.com, mwen@igalia.com, Roman.Li@amd.com,
	Wayne.Lin@amd.com, dominik.kaszewski@amd.com, alvin.lee2@amd.com,
	Aric.Cyr@amd.com, Austin.Zheng@amd.com, Sung.Lee@amd.com,
	PeiChen.Huang@amd.com, dillon.varone@amd.com,
	Richard.Chiang@amd.com, ryanseto@amd.com, linux@treblig.org,
	haoping.liu@amd.com, Relja.Vojvodic@amd.com, Yihan.Zhu@amd.com,
	Samson.Tam@amd.com, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/2] Add "pixel_encoding" to switch between RGB & YUV
 color modes
Message-ID: <aK7AFbD7LWw_SiJh@xpredator>
References: <TY4PR01MB14432B688209B2AA416A95228983EA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <aK1hPoCmLziaPPOd@xpredator>
 <TY4PR01MB1443219A9870877AF120FE63B9839A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GIq2x+ztVGH05eKR"
Content-Disposition: inline
In-Reply-To: <TY4PR01MB1443219A9870877AF120FE63B9839A@TY4PR01MB14432.jpnprd01.prod.outlook.com>


--GIq2x+ztVGH05eKR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,
On Wed, Aug 27, 2025 at 12:26:56AM +0800, Shengyu Qu wrote:
> Hi Marius,
>=20
> Thanks for reply.I have some questions:
>=20
> 1.Can you send patch with only i915/amdgpu first? It's a long-needed feat=
ure
> to deal with some monitors/TVs with broken EDID.
I plan on doing that soon, but I don't have a date. I'm in between
holidays atm. Note that I just picked these changes from Andri a few
weeks ago.
>=20
> 2.Is there any method to get the list of supported pixel format by current
> driver? Also maybe we need to take display port's maximum speed rate/targ=
et
> refresh rate/resolution into account.
Drivers should figure out that what pixel color formats it supports and
use the drm helpers (being added with the patchset) to advertise the
available pixel color formats.  For i915/amdgpu, for the time being, I
plan on just OR'ing the known ones working into a list.

User-space will use this information together with the one it is getting
=66rom EDID to perform a intersection between them.=20

"auto" will be the preferred driver choice from those advertised pixel
formats, but most likely (fallback) to RGB as all panels support that.

If EDID is broken it depends on user-space if it presents all the
advertised color formats from the driver. There isn't a way to discern
between panels that do not support YUV formats and panels that do support=
=20
YUV formats but they don't expose that in the EDID.
>=20
> Best regards,
> Shengyu
>=20
> =E5=9C=A8 2025/8/26 15:24, Marius Vlad =E5=86=99=E9=81=93:
> > Hi,
> >=20
> > Prior work towards this is/was: https://lore.kernel.org/dri-devel/20240=
115160554.720247-1-andri@yngvason.is/
> >=20
> > I have slightly modified version of that, but still working on
> > getting another driver (besides amd/i915) working with it.
> >=20
> > On Tue, Aug 26, 2025 at 02:39:59AM +0800, Shengyu Qu wrote:
> > > Usage:
> > >   - X11: xrandr --output <output name> --set "pixel encoding" <encodi=
ng>
> > >   - Wayland: proptest -M amdgpu -D <card path> <connector ID> connect=
or
> > >     <pixel encoding ID> <encoding (ID)>
> > >   - Kernel Param: amdgpu.pixel_encoding=3D<encoding>
> > >     or amdgpu.pixel_encoding=3D<monitor>:<encoding>,<monitor>:<encodi=
ng>
> > >=20
> > > Supported encodings are: "auto" (0) (Default and original behavior), =
"rgb"
> > > (1), "ycbcr444" (2), "ycbcr422" (4), and "ycbcr420" (8).
> > >=20
> > > This patch series allow users to switch between pixel encodings, whic=
h is
> > > specially important when auto gets it wrong (probably because of moni=
tor's
> > > manufacturer mistake) and needs user intervention.
> > >=20
> > > Changes since v1:
> > >   - Some cleanup and rebase
> > >   - Added YUV422 support
> > >=20
> > > Full discussion:
> > > https://gitlab.freedesktop.org/drm/amd/-/issues/476#note_2628536
> > >=20
> > > Original patch by Yassine Imounachen, current version is modified bas=
ed on
> > > this patch(was rebased by Rafael Carvalho):
> > > https://lists.freedesktop.org/archives/amd-gfx/2024-October/116195.ht=
ml
> > >=20
> > > Shengyu Qu (2):
> > >    drm/connector: Add "pixel_encoding" to switch between RGB & YUV co=
lor
> > >      output modes
> > >    drm/amdgpu: Add "pixel_encoding" DRM connector property support for
> > >      amdgpu
> > >=20
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  36 +++
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_display.h   |   3 +
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |   2 +
> > >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 273 +++++++++++++++=
++-
> > >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
> > >   drivers/gpu/drm/amd/display/dc/core/dc.c      |   8 +
> > >   drivers/gpu/drm/amd/display/dc/dc_stream.h    |   2 +
> > >   drivers/gpu/drm/drm_modes.c                   |  32 ++
> > >   include/drm/drm_connector.h                   |   7 +
> > >   9 files changed, 353 insertions(+), 11 deletions(-)
> > >=20
> > > --=20
> > > 2.43.0
> > >=20
>=20






--GIq2x+ztVGH05eKR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEcDKHej6x6uPk3J379jQS5glH1u8FAmiuwBIACgkQ9jQS5glH
1u9xxRAAzfO2XL7lFIC/vN5TVn9487uwqWuawDkUlGbt+KWHIDg4rM5Zz7GB9kKh
Bx2uNGZ5srwdbsu+o7tmt9iFZrFXxMRcNrnUn0mhLSpuTuKpqUm3Ey888jcFdOrC
dDexbq3wfxCO/ZpsOtEywzz/JPC75cXyswdK4oB/l5jOG8USrk8uYjNYosJoQYTI
rE3bq1EHpnB04QKSUXTeb92xM4hqedz4PCNh8rk0CVtH7HKtmeiBJ3rbvJQNwBe/
3s46s4BKGvAFS36JJ4MiJAAG/6mWMIqoLPvu4mdNjqKil054DCSY4TYNw0o1Ng/w
OzugGhXoRlK9vRy9fJfwAnpPXzkVejkoGmtjksE+E+vrJ4zKC9ldxQ6KnTjrRMQU
noHNtMrJJOYVYa95R+zAsnlqEodT9+SfENdnKRw82cktw892uugiXvRJ7v3UVaPA
0I45+cLownLNU+pGQ7UcBW5eIwUz7Ox2ttasNSuU0h0kpjQguDo1IvajZNNejJV5
Y0AQ0ysMSDWzP9jMOzpv07jMRPzkYZ4b0hJBU1NZlKIDOabbS6mPYAPmkp1gBqHv
XxL6DBASMFFIwt0kl1XNz/QM+j9fIEi6qP3V5XMu+Em13/J1EvQui18dGLXnPIGF
bT2IfWFuIt2g8Hcdqpvty5VX60tSSnbkYDqbbS0ju6+vATflzTc=
=lV0s
-----END PGP SIGNATURE-----

--GIq2x+ztVGH05eKR--

