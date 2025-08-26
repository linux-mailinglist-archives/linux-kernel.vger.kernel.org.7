Return-Path: <linux-kernel+bounces-786144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9071B35599
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE96E1B65879
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D672D3A85;
	Tue, 26 Aug 2025 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aYnLgFZO"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B802727FB10
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756193092; cv=none; b=c3nz4TLDqIPNOveETyWO4y53XBVIoISoeEXd0weGxI2blugDGd17ruVBwtRWHaH4V8WtpkNiKP+wz/lYUB73Dl1Yld8/yKstaZ59dODxTIjqYbKNR95kJp9ds4n7NxS18GS4BPeJo3vcuxj3DT6WVYc7sTiPECQltGZXCLFqII4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756193092; c=relaxed/simple;
	bh=fWEaE7rby5BwiPQYp9tM0XRd30FJRyFX8vJJQY21Y+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxWDG6DZSQOmDfvTZVCHL0TNM7SIGlMX57IKmUG8x3Nem1kg7COYY91V48M0tltclJkO9sajKG7doQRnlOFY+OZkP+Bo6X51nqy/zU/WwkZtHmGSEBMBiG+YhMasLEwK3XV3D1Z9Nr4jgeLFcXfUSy088eDAoSR0imYPBR8dM0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aYnLgFZO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756193088;
	bh=fWEaE7rby5BwiPQYp9tM0XRd30FJRyFX8vJJQY21Y+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aYnLgFZORbFNNctI8Q3e3ZZhulvu+PmnLPh9O8U+0EGX1wwK/x8OCqEJAc4krcxb0
	 nDVVUSnd+wk+EbUo/MqPkVfykHX+FqydXhz3afU+kWwAyrZxmGG92JAWhLuYtm4w3k
	 5jsZp15YOK++txRDk6K45WBgKC3rCR4D56f9UsE606MQXziJS6eoijzYkYkmhmZqDE
	 maotq807ZkxWK3LJpyeYCie3lWxMwvJSo6LLLspfe+jf85T4AYSoOHZVY+OvcW3tC6
	 iHQdkI1TuHBGxS8MaO3wz3QfrlBrIVmnCYxFZxAczpoRG+xKHiyT7ZdTC7Ht3F3tNC
	 vms79OQfK2mHA==
Received: from xpredator (unknown [IPv6:2a02:2f08:eb0b:c00:e88e:21ff:fe65:be18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mvlad)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A5DBC17E011A;
	Tue, 26 Aug 2025 09:24:47 +0200 (CEST)
Date: Tue, 26 Aug 2025 10:24:46 +0300
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
Message-ID: <aK1hPoCmLziaPPOd@xpredator>
References: <TY4PR01MB14432B688209B2AA416A95228983EA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P4ii5dE9RQd4AYRH"
Content-Disposition: inline
In-Reply-To: <TY4PR01MB14432B688209B2AA416A95228983EA@TY4PR01MB14432.jpnprd01.prod.outlook.com>


--P4ii5dE9RQd4AYRH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Prior work towards this is/was: https://lore.kernel.org/dri-devel/202401151=
60554.720247-1-andri@yngvason.is/

I have slightly modified version of that, but still working on
getting another driver (besides amd/i915) working with it.

On Tue, Aug 26, 2025 at 02:39:59AM +0800, Shengyu Qu wrote:
> Usage:
>  - X11: xrandr --output <output name> --set "pixel encoding" <encoding>
>  - Wayland: proptest -M amdgpu -D <card path> <connector ID> connector
>    <pixel encoding ID> <encoding (ID)>
>  - Kernel Param: amdgpu.pixel_encoding=3D<encoding>
>    or amdgpu.pixel_encoding=3D<monitor>:<encoding>,<monitor>:<encoding>
>=20
> Supported encodings are: "auto" (0) (Default and original behavior), "rgb"
> (1), "ycbcr444" (2), "ycbcr422" (4), and "ycbcr420" (8).
>=20
> This patch series allow users to switch between pixel encodings, which is
> specially important when auto gets it wrong (probably because of monitor's
> manufacturer mistake) and needs user intervention.
>=20
> Changes since v1:
>  - Some cleanup and rebase
>  - Added YUV422 support
>=20
> Full discussion:
> https://gitlab.freedesktop.org/drm/amd/-/issues/476#note_2628536
>=20
> Original patch by Yassine Imounachen, current version is modified based on
> this patch(was rebased by Rafael Carvalho):
> https://lists.freedesktop.org/archives/amd-gfx/2024-October/116195.html
>=20
> Shengyu Qu (2):
>   drm/connector: Add "pixel_encoding" to switch between RGB & YUV color
>     output modes
>   drm/amdgpu: Add "pixel_encoding" DRM connector property support for
>     amdgpu
>=20
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  36 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.h   |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |   2 +
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 273 +++++++++++++++++-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |   8 +
>  drivers/gpu/drm/amd/display/dc/dc_stream.h    |   2 +
>  drivers/gpu/drm/drm_modes.c                   |  32 ++
>  include/drm/drm_connector.h                   |   7 +
>  9 files changed, 353 insertions(+), 11 deletions(-)
>=20
> --=20
> 2.43.0
>=20

--P4ii5dE9RQd4AYRH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEcDKHej6x6uPk3J379jQS5glH1u8FAmitYTsACgkQ9jQS5glH
1u9CLQ//bBIdGbBmI2faqdm8hqyzUUpMMJwHK4kAuv0XE4QId5db+cbUocPYM9nY
gJPntOSb6/tPD7MyNV/xsR2ezD5tISQBjgwTYKXhf34Y+E+pAqKyyUfjwJ8Z26X1
qt1ewRDjBtT9DPWFwEr0OHCqxreGWXGU5bMelO2GMyXR+IPT51cIkFOvHXDI91YK
oj3qi4dJEutYeCRCPT0SAcqwD3WUIXexV0FZzp0bqcAxxDQXcu5J1hx0f0HVAU8T
NIJ1dDM/f4kqbRZSciU7IRc58EHCyBT1Xd+UquW6hSOPjncK2BDk3Guj3u5ElTUR
obWFF1j+ieG89bUXI7wa3/BIYrxdw7vqWj7zp0FnYDn6zIFeOTNEVR/igGx/MMde
PSDhe/52Hwpf00MG0vjE1rja6EHOBW7aUgDhfi4gyAAbiWYW4kJ7b8xKonPv32HP
RHy1AUq+3mlPX3vjeP4uUftlGUMKJ9lGqIjAunh5SYJ76DLbr5ugGUJnkSOiZHl7
PAXwEFG/MRjdIIJwdfbn9C1xZSGfwfg0tW/UxGjtUfrrGVPYFNu4WKslQ1ZeusYy
vYlfiYDMqE63Cs0V2RwyaqsF+xGcywDNafSVp5OtAhiUpxzmFEBhk4QcVlEENgUb
Du+5qNXmt638fYp80wgdw4mhl4FRe2EArB1QHGij2YkUVTyHtT4=
=zfJn
-----END PGP SIGNATURE-----

--P4ii5dE9RQd4AYRH--

