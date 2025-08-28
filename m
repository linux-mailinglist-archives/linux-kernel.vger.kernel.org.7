Return-Path: <linux-kernel+bounces-789481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D28BB39624
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00A93650B7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3572D73A7;
	Thu, 28 Aug 2025 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMnagQH3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320D6849C;
	Thu, 28 Aug 2025 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756368333; cv=none; b=mnukpXu/YT7Vzbuoda0DrUNtC9eHaJHzM/B3RbW8j/NmDurHp4aTTv4GwHBTsRGKd8KkODe00dJZZb37AgCtIzpdbzjBtESZqjxmgoLODnz3T1WHHA8I0rkP2a20Imfk7HQD+TD40oW3Bgcaiy1LQeBOFUU7wT+hvC97Kl6KC5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756368333; c=relaxed/simple;
	bh=Szqu3ISPHcSpDClnU/NQVEOhbXjcDa2CwfQfHM2oTVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8Zb6dzDh24W9tMOp09sWMCtj+ox7TIaVPGyyfMm+YEprsy66VXhyOzQ30awEtqtXSVxL2CULsPFexXZXcYmLkOd955kNHRMY3syR2A8vEuQYbpDLsP7WyQA0du9oqLavyLCGNEBtylgdpqvSlbKlWwuE/JNto78Q8N9kapHv3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMnagQH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37569C4CEEB;
	Thu, 28 Aug 2025 08:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756368331;
	bh=Szqu3ISPHcSpDClnU/NQVEOhbXjcDa2CwfQfHM2oTVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gMnagQH3MSE3OCmKYpRsd8lUsxpc8Ung8Xj9N13IShaXG1JpVQ17BGz/vZbJ8ayia
	 JATXdShQIFwJtWM16pujBqztN/HTAHa1eI1ruO392vGQ5bcnBpM/XVuQPAhLb+epfg
	 l+vq7JbmIEiI0o7x/Jv6L4M7n+VVeNbukGTI3/GpD9kQYUwecJAhxnypY82JF2OpgN
	 OpDKH2Xbm6L24Rh++PCS5s0FIDKVW188ch6qzc0yfxjVB+EvXvlGjVysaI9/dnMl9w
	 EBrj1g+TwpS5VfAtcAXeVX4ofcMrlcOTM6deJOEiGJCGib96kXayOKOspPBjlGlk7s
	 hAB3OigOpxutA==
Date: Thu, 28 Aug 2025 10:05:28 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Andy Yan <andyshrk@163.com>, heiko@sntech.de, hjc@rock-chips.com, naoki@radxa.com, 
	stephen@radxa.com, cristian.ciocaltea@collabora.com, neil.armstrong@linaro.org, 
	Laurent.pinchart@ideasonboard.com, yubing.zhang@rock-chips.com, krzk+dt@kernel.org, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	robh@kernel.org, sebastian.reichel@collabora.com, 
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v7 00/10] Add support for RK3588 DisplayPort Controller
Message-ID: <20250828-tangible-wakeful-coati-ec27d1@houat>
References: <20250822063959.692098-1-andyshrk@163.com>
 <bochli5u37mhc6eup7h2oz3yeignofbbj4k5nrvm2k7zf6f4ov@t2sje4gmveqa>
 <d040da3e-501f-45d8-bcbb-95fa77e94a59@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ymx6junihpockhkm"
Content-Disposition: inline
In-Reply-To: <d040da3e-501f-45d8-bcbb-95fa77e94a59@suse.de>


--ymx6junihpockhkm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 00/10] Add support for RK3588 DisplayPort Controller
MIME-Version: 1.0

On Thu, Aug 28, 2025 at 09:50:34AM +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 28.08.25 um 00:24 schrieb Dmitry Baryshkov:
> > On Fri, Aug 22, 2025 at 02:39:44PM +0800, Andy Yan wrote:
> > > From: Andy Yan <andy.yan@rock-chips.com>
> > >=20
> > >=20
> > > There are two DW DPTX based DisplayPort Controller on rk3588 which
> > > are compliant with the DisplayPort Specification Version 1.4 with
> > > the following features:
> > >=20
> > > * DisplayPort 1.4a
> > > * Main Link: 1/2/4 lanes
> > > * Main Link Support 1.62Gbps, 2.7Gbps, 5.4Gbps and 8.1Gbps
> > > * AUX channel 1Mbps
> > > * Single Stream Transport(SST)
> > > * Multistream Transport (MST)
> > > * Type-C support (alternate mode)
> > > * HDCP 2.2, HDCP 1.3
> > > * Supports up to 8/10 bits per color component
> > > * Supports RBG, YCbCr4:4:4, YCbCr4:2:2, YCbCr4:2:0
> > > * Pixel clock up to 594MHz
> > > * I2S, SPDIF audio interface
> > >=20
> > > The current version of this patch series only supports basic display =
outputs.
> > > I conducted tests with DP0 in 1080p and 4K@60 YCbCr4:2:0 modes; the A=
LT/Type-C
> > > mode was tested on Rock 5B, DP1 was tested on Rock 5 ITX by Stephen a=
nd Piotr.
> > > HDCP and audio features remain unimplemented.
> > > For RK3588, it's only support SST, while in the upcoming RK3576, it c=
an support
> > > MST output.
> > >=20
> > [skipped changelog]
> >=20
> > > Andy Yan (10):
> > >    dt-bindings: display: rockchip: Add schema for RK3588 DPTX Control=
ler
> > >    drm/bridge: synopsys: Add DW DPTX Controller support library
> > >    drm/rockchip: Add RK3588 DPTX output support
> > >    MAINTAINERS: Add entry for DW DPTX Controller bridge
> > I tried pushing patches 1-4, but got the following error:
> >=20
> > dim: ERROR: 5a68dcf5837a ("MAINTAINERS: Add entry for DW DPTX Controlle=
r bridge"): Mandatory Maintainer Acked-by missing., aborting
> >=20
> > I'm not sure how to handle MAINTAINERS changes (or whether it's fine for
> > me or not), so I will probably push patches 1-3 in a few days, if nobody
> > beats me (or unless somebody points out a correct process for
> > MAINTAINERS changes).
>=20
> That warning has been added recently to make sure that patches do not get=
 in
> without sufficient review. It's overly pedantic, though.

It's not "overly pedantic", it follows the contribution rules. I'd argue
that, if anything, we've been overly tolerant with that kind of
practices.

We do have a bug with handling MAINTAINERS changes at the moment. But
everything else shouldn't be ignored: either patch MAINTAINERS to
reflect the actual contribution path, or get the maintainers Ack.

> If you're confident that you have R-bs from enough relevant people,
> push the patches with 'dim -f' to ignore the warning.

And let's not just advise that either.

Maxime

--ymx6junihpockhkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaLANyAAKCRAnX84Zoj2+
dvcTAX9rZO7QwXxbtcVqDnn23mh2i9KEU6GCe3pKfMrxhyxr/xeu+2p/6ozBtwvy
dnuUOUwBgO9N54kfuFqmTdfZIBhi2RTQ4iuHn4jAnfkBH1wkyB6OhyEze6gnXwEZ
eUsIzifPzw==
=bTVf
-----END PGP SIGNATURE-----

--ymx6junihpockhkm--

