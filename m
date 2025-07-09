Return-Path: <linux-kernel+bounces-723113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E19AFE316
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3EF43BCCFC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32637283153;
	Wed,  9 Jul 2025 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoP987Dk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFDE280CD0;
	Wed,  9 Jul 2025 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050803; cv=none; b=aZc4gYE52dDIgovP6FpObUq+slFM3OtzeDjpg6MiZD5017rJ2VGOy/CUMUosiFqwR2LoZ3wUoQDcLEbOHASG+mLZ1PB3BVgIv0Lg63XKbIpnp+2+SD+D+DVNPzyniLWvMo/cpdWgWy9x9zzmuNYD6dLzLYO7IwRHykOZBch2+G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050803; c=relaxed/simple;
	bh=uQxOYRvhs1dO9YSJnNB7tHiB35UHAz6K7hOo9VmXY+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCotWXlMREBpeoUXUf5hoj2C3zPJN7ZIcmVjw+DVQYwes2UGaPhtQZi/frVY45drTbmLA2nV8+R+RVNJtKWlg7UDKlF5f7tQEls54C4JHyEpykGoAI9PdaCD3Uml85ReNJd7Wx1eH/tAgLmA+as+KQef7vSJrEOcxGNBNVtnvWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoP987Dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97906C4CEF0;
	Wed,  9 Jul 2025 08:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752050803;
	bh=uQxOYRvhs1dO9YSJnNB7tHiB35UHAz6K7hOo9VmXY+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AoP987DkYwFOKbEqSX8RyTKu8GJlh5CiIxRpF6Xo3fdNBZ8oluAKLufGQEXBJnc12
	 kTui6Na/YflqX+Wz3zCy5ix+G8CVRq/x57MxP2Ta+dK6u+IiQ8aLxEjojHOPTf/hOG
	 H7vaWKdknaaqGTvzb7QlUTS20chEVqKr9k0jJmMT1DocofDWwtbb9PJka75IOWtSi7
	 538DV8dOkTa6CaB8/EnEtsYY+NRCHVndVilOLu9PkqbmYcpyZexH7zUFjVPQ7En5dF
	 9xParte1oEOiLqWDHYyR2R4U6VbBWGW7l7gW2Pstw+fE89J0n8hjUtT2uLVp8zS54C
	 oHrf8nDhLcZeA==
Date: Wed, 9 Jul 2025 09:46:39 +0100
From: Mark Brown <broonie@kernel.org>
To: ew.kim@samsung.com
Cc: s.nawrocki@samsung.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: samsung: Implement abox generic structure
Message-ID: <aG4sb7UcqvHz_Z5r@finisterre.sirena.org.uk>
References: <CGME20250709002150epcas2p467416bdbc16754726599a0cacb1feecc@epcas2p4.samsung.com>
 <20250709001002.378246-1-ew.kim@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DxAKD3zsp1okH161"
Content-Disposition: inline
In-Reply-To: <20250709001002.378246-1-ew.kim@samsung.com>
X-Cookie: Do not cut switchbacks.


--DxAKD3zsp1okH161
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2025 at 09:10:02AM +0900, ew.kim@samsung.com wrote:
> From: ew kim <ew.kim@samsung.com>
>=20
> Implemet basic abox generic drivers.
> This driver is a management driver for the generic drivers used in
> Automotive Abox, connecting them to SOC drivers.
> It supports various Exynos Automotive SOCs.

I can't really tell what the driver is supposed to do from this - what
is abox?  Looking at the code I'm not really much clearer, to a large
extent because it doesn't seem to integrate with the subsystem (or other
kernel subsystems) at all.  It looks like this might be intended to
control a DSP offload system, but it's not 100% clear, and it seems like
there's an ioctl() interface which it looks like it's exposing internal
abstractions to userspace.  This needs to be some combination of much
more clearly explained and better integrated with the existing kernel
subsystems, right now I can't really review it effectively because it's
hard for me to tell what the code is trying to do.

I've got a few very supreficial comments below but really there's a
structural problem that needs to be addressed first.

> +++ b/sound/soc/samsung/auto_abox/generic/abox_generic.c
> @@ -0,0 +1,568 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 Samsung Electronics Co., Ltd.
> + *        http://www.samsung.com/

It's now 2025...

Please also make the entire comment a C++ one so things look more
intentional.

> +//#define DEBUG

Just delete this, it can be added if needed.

> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/delay.h>
> +#include <linux/suspend.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/pcm_params.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/sched/clock.h>
> +#include <linux/ktime.h>
> +#include <linux/iommu.h>
> +#include <linux/clk-provider.h>
> +#include <linux/kmod.h>
> +#include <linux/umh.h>
> +#include <linux/string.h>

Do you really need all these headers?

> +static struct abox_generic_data *g_abox_generic_data;

This isn't really the kernel style - neither the g_ naming, nor the
concept of having a global for a driver.

> +/**
> + * @cnotice
> + * @prdcode
> + * @Sub_SW_Component{abox_generic}
> + * @ALM_Link {work item url}
> + * @purpose "get value from virtual address"
> + * @logic "return global abox_generic_data"
> + * \image html
> + * @params
> + * @param{in, -, -, -}
> + * @endparam
> + * @retval {-, struct *abox_generic_data, !NULL, NULL}
> + */

This is not the style for kernel comments, and doesn't seem to make
terribly much sense.

--DxAKD3zsp1okH161
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhuLGwACgkQJNaLcl1U
h9D+wQgAg6ZiLWn6Tov6pqpgGSvOVCG4bO1wv+lii8kju0nn5wslEp0AFE4uumGf
j2XuTXW1grfaywB4hCwouLmd/7kkB6AyrQlrftw9I50TrN3AViIU/hvYQwXMI5wf
v+T8Hz90rmxvWHi7A2OkMK4jBAJtUxyBayxx3o9vnV55bb0yYQKSaoZUYwTWIx5a
mFlgnzsS6ZdNG3FFp6AOEDOmypiJBZSpVTS37VifxCEa2bO/qCsgboXMC/8Jwz0U
1Um1xoTMu1gJarD6+b012HGTvLp5eV7srl9LNwROFxXmhRG1p+IJAbFybBHJaNxs
ILL9EhWyeBZt5EaOzlUpLVgFOtxJBA==
=1drM
-----END PGP SIGNATURE-----

--DxAKD3zsp1okH161--

