Return-Path: <linux-kernel+bounces-704197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E0EAE9AAB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 12:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0642A189AC06
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 10:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB61F217716;
	Thu, 26 Jun 2025 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vo6l5QvC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5902D4C8F
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932262; cv=none; b=t+umBCPp/mkmAp9OnhFBEK1Edoh4e5x7qdPHqWqnP5O0cB56cbqw1uMY5DEa2fzbSNBJJO6LdCRs7n3z/8/xyjmRXN/un2qf+Po5j0sPLvwkHCOlaOwmihU2sAiG1QKMfBEJY6CWihJDGunvzxHc+9zMEdeh8cKlDbBW1qbLJuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932262; c=relaxed/simple;
	bh=zCP8+haUsgajLpG9GHi1Yt0aYIxCMRg7RaznIp2uslE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSU6Xh8CMAyBTVXIiukTq+HyDiYvKhPWJiH2DklUGujHCcXQLGeLJFkLoBb1MfamzizNmHsRYWBf0PItfWS9I4xhZN7hafEXa/4g+YPc29B71u2AWdKku9hHEm0j+rKuYdEUefh7QTOSP35CGkXzaF2m8y2/+4A+2kBpUmpMfmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vo6l5QvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825B1C4CEEE;
	Thu, 26 Jun 2025 10:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750932261;
	bh=zCP8+haUsgajLpG9GHi1Yt0aYIxCMRg7RaznIp2uslE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vo6l5QvCYeKcxOrxHm6UJ9KbXPj6pGnXW9J14/CRHr6D9ZCLK7RQDyv3QvVL/eiW1
	 rzfs1SzEXCA+0UGTr1XByoc+lqB6l65XcEwu4xpIBXWpX/q8RLBtUZUKSIbJGEAbBf
	 0bOYp2yk22KrVdZV0sO/2GNyg7c0dEa6iuZgUnHyYgJy9v0hxEvrQYFiLv7kJv4Lb/
	 kEVCTP/GLTWt+iG0GSeS57snL9ZlciCVA3fUDiFMbRAhFJIGgsQNGHs/t+Vj8iQtt9
	 nGHPEst6K8JsLTumIfJJkadybyN+DCt3bAdeVuVpwDTwd1f3rTteqUM6JC37n7vzQv
	 hctZ8T2fl6RNg==
Date: Thu, 26 Jun 2025 12:04:19 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Anusha Srivatsa <asrivats@redhat.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] drm/panel: panel-simple: Fix panel-dpi probe error
Message-ID: <20250626-radiant-corgi-of-prowess-9a3aab@houat>
References: <20250625-drm-panel-simple-fixes-v1-0-c428494a86b8@kernel.org>
 <aF0SBNGmTpgtBTC3@gaggiata.pivistrello.it>
 <aF0UUBQFAu9GUde0@gaggiata.pivistrello.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="vi6tlw5lpgixe2df"
Content-Disposition: inline
In-Reply-To: <aF0UUBQFAu9GUde0@gaggiata.pivistrello.it>


--vi6tlw5lpgixe2df
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/5] drm/panel: panel-simple: Fix panel-dpi probe error
MIME-Version: 1.0

On Thu, Jun 26, 2025 at 11:35:12AM +0200, Francesco Dolcini wrote:
> On Thu, Jun 26, 2025 at 11:25:24AM +0200, Francesco Dolcini wrote:
> > On Wed, Jun 25, 2025 at 08:48:37AM +0200, Maxime Ripard wrote:
> > > Here's a series fixing (hopefully) the panel-simple regression for
> > > panels with a panel-dpi compatible.
> > >=20
> > > It's only build tested, so if you could give that series a try
> > > Francesco, I'd really appreciate it.
> >=20
> > It does not build for me, applied on top of commit ee88bddf7f2f ("Merge=
 tag
> > 'bpf-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf")
> >=20
> >   SYNC    include/config/auto.conf.cmd
> >   CALL    scripts/checksyscalls.sh
> >   CC      drivers/gpu/drm/drm_of.o
> >   CC [M]  drivers/gpu/drm/panel/panel-simple.o
> >   AR      drivers/gpu/drm/built-in.a
> >   AR      drivers/gpu/built-in.a
> >   AR      drivers/built-in.a
> >   AR      built-in.a
> >   AR      vmlinux.a
> >   LD      vmlinux.o
> >   OBJCOPY modules.builtin.modinfo
> >   GEN     modules.builtin
> >   GEN     .vmlinux.objs
> >   MODPOST Module.symvers
> > ERROR: modpost: "mipi_dsi_bus_type" [drivers/gpu/drm/panel/panel-simple=
=2Eko] undefined!
> > make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> > make[1]: *** [/home/francesco/Toradex/sources/linux/Makefile:1953: modp=
ost] Error 2
> > make: *** [Makefile:248: __sub-make] Error 2
> > [Exit 2]
> >=20
>=20
> The issue is that I do not have CONFIG_DRM_MIPI_DSI. Adding it the build
> finishes, and it also fixes the issue.

Thanks! I've been able to reproduce, and I'll send a new version in a
couple of minutes.

Maxime

--vi6tlw5lpgixe2df
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaF0bIgAKCRAnX84Zoj2+
dpw3AX4xiV4PYsblJakhkPwTl6lZXGBYC4lK87wDW/K/GFjL6o8I+r1OMlgCCmcv
/jrkVMsBf1Y/BsQi5a1l2X2Yvyyw5xDT/OKiEN5nrxr+ZbQePQY4dhevisKhEGJr
hwY1inXvvQ==
=HzPm
-----END PGP SIGNATURE-----

--vi6tlw5lpgixe2df--

