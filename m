Return-Path: <linux-kernel+bounces-811775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 794C3B52DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00321C24B22
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC422EAB70;
	Thu, 11 Sep 2025 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+TuKd/P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421E92E8DFF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757584232; cv=none; b=AAo+2THu5JdyzE+Mswzi2d8d1CjGFfnM9+mKE4NeiuSRO1591FLeUcmBateoigqFiCK37lSLcJBpnnuhPmF61+U2cvDX0+f5lhhjrD8dSTfjmrcIk7K0hu7SGjeaLKQs3Q4WBLM8r/dAQSdUyRtnDwynBqqv4rutzDib4jEsoSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757584232; c=relaxed/simple;
	bh=pE2AURsoCMkJTm1mo4lJL7qjrrJQ0/YmWX+SwCL5yw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBeblr+ctDo6n/GezU/vyaRfK+C+jdx9mmkd7U/oSUZz9cmd6OKHYjbdCL5j4JgiYHK+GVw/+okFVZOxGEhJzbhEnfPp6Z/8gm3FpcWAYxbbULnOdncBCPgYroTSQRX2gjpHDt0VhvrVZ6CMWK8NwLbjM/wbt8QsaGl9qRSXTTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+TuKd/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A10C4CEF0;
	Thu, 11 Sep 2025 09:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757584231;
	bh=pE2AURsoCMkJTm1mo4lJL7qjrrJQ0/YmWX+SwCL5yw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+TuKd/PMZh9aE4lEy42hRVmlu5OM/5HD2vW1Hw8oMLhPuBINeJxUp9cuelnQcIj7
	 uTFPQHYDVcYhMvfgtzRTfr1mAsH+i/b2nl7VfDYOZOMd1NEY2ywcKyEh/YwUJt+gxP
	 cDzIM4qACVbgz067zS8aYhYQu+Kz868eSGDFjgglP1H7rt+s0ZJdr5aPdGUiS7nFbN
	 Af3GuOe0RjtE8nYTo2JdP1ohuzT1DNZ1nFIADJyHpkTArfHiiWJxR69WTZLitBZ/6z
	 jrWt63k8UIFbQaYlaGgAOyoXBkMZflHF7Rc1dC6+GRNU50ch7st3cbUMdTRX59sMOR
	 069Cq4N2yk5QQ==
Date: Thu, 11 Sep 2025 11:50:29 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Miguel Gazquez <miguel.gazquez@bootlin.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Phong LE <ple@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, kory.maincent@bootlin.com, 
	romain.gantois@bootlin.com, praneeth@ti.com, Aradhya Bhatia <a-bhatia1@ti.com>
Subject: Re: [PATCH] drm/bridge: ite-it66121: Add drm_connector support
Message-ID: <20250911-innocent-daffodil-macaque-797f13@houat>
References: <20250909-it66121-fix-v1-1-bc79ca83df17@bootlin.com>
 <do5zciwcanpiciy52zj3nn6igmwlgmbcfdwbibv2ijxm2fif5s@ib6jhzi5h2jo>
 <6164422a-6265-4726-8da5-68bb8eafb9e6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="jzouzmmvozrp6xum"
Content-Disposition: inline
In-Reply-To: <6164422a-6265-4726-8da5-68bb8eafb9e6@bootlin.com>


--jzouzmmvozrp6xum
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/bridge: ite-it66121: Add drm_connector support
MIME-Version: 1.0

On Thu, Sep 11, 2025 at 10:51:06AM +0200, Miguel Gazquez wrote:
>=20
>=20
> Le 10/09/2025 =E0 04:28, Dmitry Baryshkov a =E9crit=A0:
> > On Tue, Sep 09, 2025 at 06:16:43PM +0200, Miguel Gazquez wrote:
> > > From: Aradhya Bhatia <a-bhatia1@ti.com>
> > >=20
> > > Add support for DRM connector and make the driver support the older
> > > format of attaching connectors onto the encoder->bridge->connector
> > > chain.
> > > This makes the driver compatible with display controller that only
> > > supports the old format.
> > >=20
> > > [Miguel Gazquez: Rebased + made driver work with or without
> > > DRM_BRIDGE_ATTACH_NO_CONNECTOR]
> >=20
> > What is the use case for not using DRM_BRIDGE_ATTACH_NO_CONNECTOR?
>=20
> Some display controller drivers (like the tilcdc) call drm_bridge_attach
> without DRM_BRIDGE_ATTACH_NO_CONNECTOR, so the bridge must support both w=
ith
> and without DRM_BRIDGE_ATTACH_NO_CONNECTOR to be compatible with all disp=
lay
> controllers.

I'd rather convert tilcdc to use DRM_BRIDGE_ATTACH_NO_CONNECTOR then.

Maxime

--jzouzmmvozrp6xum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaMKbYQAKCRAnX84Zoj2+
dgJSAYDdU+th+2A0F5q6ZC2ooIL5tuW/KSkDnDvtGQFsorRAhoAZKfsPOUWeNRAJ
BYvVimEBf26l9rXHppvS+ufirPVemWVrWyLWv+CKfBIRlyFXVx8oq75VNyn21Thi
4ZkctmwVYw==
=CR9i
-----END PGP SIGNATURE-----

--jzouzmmvozrp6xum--

