Return-Path: <linux-kernel+bounces-752160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542A3B17200
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703A5585A58
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E662C08C1;
	Thu, 31 Jul 2025 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5NuxDTc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25324A94A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968406; cv=none; b=X0nKPMtLzeeExHR2FKSQHjjHSmNwzXPJEQ6qtVL7omlLuPbb590gtcl65bIUWzhEVdHj0F2xYCxETDGwyc67DZjHB02O7wlQ/qt5pvG6NjFD3hqRG/27c/YluHtOoXR+xieXb90BVobbchwfq8R7mgnsXcqOR/nv+I+0ghePnh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968406; c=relaxed/simple;
	bh=lCLyuq53vp4e9L0JS6snSzvaxB/qbfCtw9F8FZNhjCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3ODP3qT47V7Je1bYiVRBQ7FyqXtomp2jhoMkMPcL0K3Qdkv5eVFvO4cXLUZ9VuK+5On6DENaWK42OH2ZSPqS5tZtySojQXTiM9BkmCaCjfVtM0C43LQ40YMsYAM2MGgOfopRHz8lNiRVTuFKeYE9c0Cz3cC5jgtYtdiBmfix3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5NuxDTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B9DC4CEEF;
	Thu, 31 Jul 2025 13:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753968405;
	bh=lCLyuq53vp4e9L0JS6snSzvaxB/qbfCtw9F8FZNhjCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p5NuxDTcXtwhVbrPCDjI9v84xzkZE1D4MgiqhNUUPu/gRixKgIWZ8nST23lDwSq8o
	 NJfzQkkpEdU3WbxcjV8YHQhWXMM9deH23bMcomOQ2H1/DmZBurj+h1cU6NHA4WOPNp
	 hJObCrnm3foM2HWZTF6WRJAdowTq2g4N+R8d6fVcpDjbdB5CL4a3d53MfQJDVrgOTt
	 6pHWiOkUyuKbd/MgNwm86u2zNUwKrnXpulzKa4grmf3LPESruiJ0s99GOkKBhOp5no
	 +4xkPmIPkkkOqjsg8ujFPrteCybIDGn4c3WB+3cKfpFYeqhDkxjGcWrITdG6RZnbPm
	 /UrMSq8zPJr2Q==
Date: Thu, 31 Jul 2025 15:26:42 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Jyri Sarha <jyri.sarha@iki.fi>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] drm/tidss: dispc: Convert to FIELD_* API
Message-ID: <20250731-powerful-termite-of-inspiration-13f36d@houat>
References: <20250730-drm-tidss-field-api-v1-0-a71ae8dd2782@kernel.org>
 <15f0b568-3d59-4f0c-b390-4e3d3623136a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="livjto5renz64lpa"
Content-Disposition: inline
In-Reply-To: <15f0b568-3d59-4f0c-b390-4e3d3623136a@bootlin.com>


--livjto5renz64lpa
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/14] drm/tidss: dispc: Convert to FIELD_* API
MIME-Version: 1.0

Hi Louis,

On Thu, Jul 31, 2025 at 03:04:49PM +0200, Louis Chauvet wrote:
> Le 30/07/2025 =E0 10:57, Maxime Ripard a =E9crit=A0:
> > Hi,
> >=20
> > The tidss driver rolls its own API equivalent to the FIELD_* API already
> > provided the kernel.
> >=20
> > Since it's an ad-hoc implementation, it also is less convenient and
> > doesn't provide some useful features like being able to share the field
> > definitions that will come handy in the future.
> >=20
> > Thus, this series converts the driver to that API and drops its own
> > version.
>
> I just saw your series after sending mine [2]. I checked, there is only o=
ne
> minor conflict that can be easly fixed.
>=20
> But when applied on drm-misc/drm-misc-next, your series raises:
>=20
> In file included from <command-line>:
> drivers/gpu/drm/tidss/tidss_dispc.c: In function 'FLD_MOD':
> ././include/linux/compiler_types.h:568:45: error: call to
> '__compiletime_assert_589' declared with attribute error: FIELD_PREP: mask
> is not constant
>   568 |         _compiletime_assert(condition, msg, __compiletime_assert_,
> __COUNTER__)
>       |                                             ^
> ././include/linux/compiler_types.h:549:25: note: in definition of macro
> '__compiletime_assert'
>   549 |                         prefix ## suffix();         \
>       |                         ^~~~~~
> ././include/linux/compiler_types.h:568:9: note: in expansion of macro
> '_compiletime_assert'
>   568 |         _compiletime_assert(condition, msg, __compiletime_assert_,
> __COUNTER__)
>       |         ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro
> 'compiletime_assert'
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), m=
sg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> ./include/linux/bitfield.h:65:17: note: in expansion of macro
> 'BUILD_BUG_ON_MSG'
>    65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),
> \
>       |                 ^~~~~~~~~~~~~~~~
> ./include/linux/bitfield.h:115:17: note: in expansion of macro
> '__BF_FIELD_CHECK'
>   115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: =
");
> \
>       |                 ^~~~~~~~~~~~~~~~
> drivers/gpu/drm/tidss/tidss_dispc.c:599:33: note: in expansion of macro
> 'FIELD_PREP'
>   599 |         return (orig & ~mask) | FIELD_PREP(mask, val);
>       |                                 ^~~~~~~~~~
>=20
>=20
> This seems to be a limitation of FIELD_PREP [1].
> I think the only way to avoid this issue is to use macros and not functio=
ns.
>=20
> [1]:https://elixir.bootlin.com/linux/v6.16/source/include/linux/bitfield.=
h#L65-L66
> [2]:https://lore.kernel.org/all/20250730-fix-edge-handling-v1-0-1bdfb3fe7=
922@bootlin.com/

Weird, it compiles without warning for me here. Which compiler do you use?

Thanks!
Maxime

--livjto5renz64lpa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaItvEgAKCRAnX84Zoj2+
doX8AYCMBVPvxu8o9TOyCn7lBbNCgS3knFU+dNmItt8BbDwrf771Slu0wBc/AS26
rS5kbMgBgLJs0oaq3MszcBvisk3p+uCLxfQLOTUpTXrXdigK3eR7LEZz6ewrk7Gn
ZafbXk/c4g==
=Oj/Q
-----END PGP SIGNATURE-----

--livjto5renz64lpa--

