Return-Path: <linux-kernel+bounces-797090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7454AB40BA7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0F41B639F3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E148341AC3;
	Tue,  2 Sep 2025 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrJcHnY2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB8934165E;
	Tue,  2 Sep 2025 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832850; cv=none; b=NDgtOnoMSosynPyADH359u2hnJ71PKCfgSpEPAcHToK5btW4ThzzR/R3OnfpWFIiVpSNhij+VRD/bk8ax2ArROxWH86h073h4F5z/kWmBhlMiU151ap4UamMZNkAxAhxARoMZqpHxPbEwcxAjWaIm2fjR4DgE/7O+xTJMzKyTfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832850; c=relaxed/simple;
	bh=IYDkzilxbSRyvx9Io0tT0IQnawm6gQq1M15aM43RTy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmB0QjY0EdD/OQDGuwMNmBQAvO0hHEEUGyG1OlVqieepEdm+j5uTNo384nDqMeGyQrxwGHB+2gydwO1Gxp7nmY/X5dNgVTZ9P9pH08lOPTi5B+/IWmlgcWw4FGQQVZ84Qxq1AfzPEntgy+Xj2xy5NrlxV9BFiU3MvaDdKmiuNbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrJcHnY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30155C4CEED;
	Tue,  2 Sep 2025 17:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756832850;
	bh=IYDkzilxbSRyvx9Io0tT0IQnawm6gQq1M15aM43RTy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QrJcHnY2/wjwWY+uPJoel9dpLf4kO7HdRU6XfNCfelnVc14HkpJBicDAYW3ppNTJA
	 zDtST6cdUj/fpUtCh1fdfTBW6oTh+xS3J6pr5Y4TlOuIuwTQn5likfZAlWe/x5gPZu
	 dgIz5ucR3jdTarirjfImBycxGgX25tWjBXNetCXkbAR8RxmHDzC0q0uCAPK8WoE4+M
	 tuEG8LKwJNUsqoR+l/XjRIzziPicjVv0D8Z3Fa/lPjyOeLABlHA8p2jd79ULtQ8tnE
	 lPYzPJWO25WBnAn/VqyYrfzYh0xj7tumOMcunOQdGWGSO4bfNc/MW8ruyl7SAfD9eY
	 C8oiFXpa8hRcA==
Date: Tue, 2 Sep 2025 19:07:25 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Andy Yan <andyshrk@163.com>, 
	heiko@sntech.de, hjc@rock-chips.com, naoki@radxa.com, stephen@radxa.com, 
	cristian.ciocaltea@collabora.com, neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com, 
	yubing.zhang@rock-chips.com, krzk+dt@kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, robh@kernel.org, 
	sebastian.reichel@collabora.com, Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v7 00/10] Add support for RK3588 DisplayPort Controller
Message-ID: <3ygqnj4idey7u4m7ltlv7pnfhkkvcepmpfdijdszctaeopq3ky@qteg33comjl3>
References: <20250822063959.692098-1-andyshrk@163.com>
 <bochli5u37mhc6eup7h2oz3yeignofbbj4k5nrvm2k7zf6f4ov@t2sje4gmveqa>
 <d040da3e-501f-45d8-bcbb-95fa77e94a59@suse.de>
 <20250828-tangible-wakeful-coati-ec27d1@houat>
 <n3scvjsx2aec2ijnr5wwevkmhtegkts5nb43yti7dkjujqaezq@shbcy7ftibzo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="kkc2r2aygpzd7tty"
Content-Disposition: inline
In-Reply-To: <n3scvjsx2aec2ijnr5wwevkmhtegkts5nb43yti7dkjujqaezq@shbcy7ftibzo>


--kkc2r2aygpzd7tty
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 00/10] Add support for RK3588 DisplayPort Controller
MIME-Version: 1.0

On Thu, Aug 28, 2025 at 03:56:21PM +0300, Dmitry Baryshkov wrote:
> On Thu, Aug 28, 2025 at 10:05:28AM +0200, Maxime Ripard wrote:
> > On Thu, Aug 28, 2025 at 09:50:34AM +0200, Thomas Zimmermann wrote:
> > > Hi
> > >=20
> > > Am 28.08.25 um 00:24 schrieb Dmitry Baryshkov:
> > > > On Fri, Aug 22, 2025 at 02:39:44PM +0800, Andy Yan wrote:
> > > > > From: Andy Yan <andy.yan@rock-chips.com>
> > > > >=20
> > > > >=20
> > > > > There are two DW DPTX based DisplayPort Controller on rk3588 which
> > > > > are compliant with the DisplayPort Specification Version 1.4 with
> > > > > the following features:
> > > > >=20
> > > > > * DisplayPort 1.4a
> > > > > * Main Link: 1/2/4 lanes
> > > > > * Main Link Support 1.62Gbps, 2.7Gbps, 5.4Gbps and 8.1Gbps
> > > > > * AUX channel 1Mbps
> > > > > * Single Stream Transport(SST)
> > > > > * Multistream Transport (MST)
> > > > > * Type-C support (alternate mode)
> > > > > * HDCP 2.2, HDCP 1.3
> > > > > * Supports up to 8/10 bits per color component
> > > > > * Supports RBG, YCbCr4:4:4, YCbCr4:2:2, YCbCr4:2:0
> > > > > * Pixel clock up to 594MHz
> > > > > * I2S, SPDIF audio interface
> > > > >=20
> > > > > The current version of this patch series only supports basic disp=
lay outputs.
> > > > > I conducted tests with DP0 in 1080p and 4K@60 YCbCr4:2:0 modes; t=
he ALT/Type-C
> > > > > mode was tested on Rock 5B, DP1 was tested on Rock 5 ITX by Steph=
en and Piotr.
> > > > > HDCP and audio features remain unimplemented.
> > > > > For RK3588, it's only support SST, while in the upcoming RK3576, =
it can support
> > > > > MST output.
> > > > >=20
> > > > [skipped changelog]
> > > >=20
> > > > > Andy Yan (10):
> > > > >    dt-bindings: display: rockchip: Add schema for RK3588 DPTX Con=
troller
> > > > >    drm/bridge: synopsys: Add DW DPTX Controller support library
> > > > >    drm/rockchip: Add RK3588 DPTX output support
> > > > >    MAINTAINERS: Add entry for DW DPTX Controller bridge
> > > > I tried pushing patches 1-4, but got the following error:
> > > >=20
> > > > dim: ERROR: 5a68dcf5837a ("MAINTAINERS: Add entry for DW DPTX Contr=
oller bridge"): Mandatory Maintainer Acked-by missing., aborting
> > > >=20
> > > > I'm not sure how to handle MAINTAINERS changes (or whether it's fin=
e for
> > > > me or not), so I will probably push patches 1-3 in a few days, if n=
obody
> > > > beats me (or unless somebody points out a correct process for
> > > > MAINTAINERS changes).
> > >=20
> > > That warning has been added recently to make sure that patches do not=
 get in
> > > without sufficient review. It's overly pedantic, though.
> >=20
> > It's not "overly pedantic", it follows the contribution rules. I'd argue
> > that, if anything, we've been overly tolerant with that kind of
> > practices.
> >=20
> > We do have a bug with handling MAINTAINERS changes at the moment. But
> > everything else shouldn't be ignored: either patch MAINTAINERS to
> > reflect the actual contribution path, or get the maintainers Ack.
>=20
> For me that points out that MAINTAINERS changes should be integrated
> into the corresponding driver patch rather than being a separate patch.

Not really. It's really just a bug in dim, there's no hidden intent :)

Maxime

--kkc2r2aygpzd7tty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaLckTAAKCRAnX84Zoj2+
dvUNAYCXA+YfH43/lvB6Cay1XQoaT6hY+j/3vvS/vks7PUidYe3u20HeFQ6TDCMt
fDk7xbsBfAg4iZlxbGaBsHx/isVkX0/hsjK1EZiqd0QFjc1leQ3iDtnQ7qFLJv9m
BMMAuZ+5Zg==
=yuqj
-----END PGP SIGNATURE-----

--kkc2r2aygpzd7tty--

