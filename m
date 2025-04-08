Return-Path: <linux-kernel+bounces-592972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B99A7F368
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 06:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA7A7A4D1C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 04:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3DE1FECB4;
	Tue,  8 Apr 2025 04:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PnpnYQWx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2461717548
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 04:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744084876; cv=none; b=OMVSHOk/7cQ/b5b75ZLDBpcrCqvAU2TxihZ/1JM4QD1UAc7/1E8B8VrFKaPh+7lZlduXnMuaD7+QdSTCbnREFW4MY34MdktDTCRng8qjRzlBtIa8+W+d4nMWs/wdr26l7+Evqbl5+X7Tijrw4XzzZGHrMjg7QZ70OYyMqGFctuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744084876; c=relaxed/simple;
	bh=zoB0xc59/a0nfeKjU5CSFK4d1gniYV0+H5Cqm60IMjY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VoYUMp4piEr+qDwAxYeG5nE7pOUnuePEOi/mIjFrr3oWmY9HTt75RuxWNEOzCBEBnAmDdd9lCUqyhfDSX0iN7M3n9Ovu+GPMTd1Q45J1srfWCwy46y0t+v5RzPhysraN6a0zTpBZZxS6WQTjMEcPbBD0yomem4UPfPSuqPMHHdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PnpnYQWx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744084875; x=1775620875;
  h=date:message-id:from:to:cc:subject:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zoB0xc59/a0nfeKjU5CSFK4d1gniYV0+H5Cqm60IMjY=;
  b=PnpnYQWxJLDdMq/SeeLMVEQ0HDuTyR54daqvXvDtlUJMUmqMcz1RR4gX
   riT28ZqZTDCMSQsFaeM6xVZa+VuJVKKOGN1jcIL/H0RA03dJjtxvFapse
   IspzidX3ducTW+BqA5AIhmhL84qn3erpib+MaLOyHtYO34uu6fXtKSmpC
   95sl971wxOQz0IbfZbopuCTszWhqhY/88tKFbPmM+h0CgA5ljXe5VsG9H
   OakyszaIT1qK696537N1h4vGX0Yb/Uc8iAK1368udTKj66AQ4dn7/qUyk
   hZj2kcp8NxKU1a93QpirdMb7xir4rM8BxG4GUL7uSFiurih5FQ1Jzcs+E
   g==;
X-CSE-ConnectionGUID: Bmzs8XZgTGypO4KHb0wGGw==
X-CSE-MsgGUID: ugHM4R1CRGmEOX5Wjl4/4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56136978"
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="56136978"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 21:01:14 -0700
X-CSE-ConnectionGUID: T24HncF1T8qZsH4N+aI50A==
X-CSE-MsgGUID: cCEHoE/6TQ+7I3t5lxD9Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="128135392"
Received: from orsosgc001.jf.intel.com (HELO orsosgc001.intel.com) ([10.165.21.142])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 21:01:14 -0700
Date: Mon, 07 Apr 2025 21:01:13 -0700
Message-ID: <854iyzs3na.wl-ashutosh.dixit@intel.com>
From: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: <imre.deak@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	"Jessica Zhang" <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Linus Walleij <linus.walleij@linaro.org>,
	Joel Selvaraj <jo@jsfamily.in>,
	Douglas Anderson <dianders@chromium.org>,
	<dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/10] panel/auo-a030jtn01: Use refcounted allocation in place of devm_kzalloc()
In-Reply-To: <87a58re8hj.wl-ashutosh.dixit@intel.com>
References: <20250401-b4-drm-panel-mass-driver-convert-v1-0-cdd7615e1f93@redhat.com>
	<20250401-b4-drm-panel-mass-driver-convert-v1-4-cdd7615e1f93@redhat.com>
	<Z_P0A9lxWD0aAdjp@ideak-desk.fi.intel.com>
	<85a58rsgjj.wl-ashutosh.dixit@intel.com>
	<87bjt7eca8.wl-ashutosh.dixit@intel.com>
	<87a58re8hj.wl-ashutosh.dixit@intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?ISO-8859-4?Q?Goj=F2?=) APEL-LB/10.8 EasyPG/1.0.0
 Emacs/29.4 (x86_64-redhat-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: quoted-printable

On Mon, 07 Apr 2025 18:40:24 -0700, Dixit, Ashutosh wrote:
>
> On Mon, 07 Apr 2025 17:18:23 -0700, Dixit, Ashutosh wrote:
> >
> > On Mon, 07 Apr 2025 16:22:40 -0700, Dixit, Ashutosh wrote:
> > >
> > > On Mon, 07 Apr 2025 08:49:23 -0700, Imre Deak wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Tue, Apr 01, 2025 at 12:03:47PM -0400, Anusha Srivatsa wrote:
> > > > > Move to using the new API devm_drm_panel_alloc() to allocate the
> > > > > panel.
> > > > >
> > > > > Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> > > > > ---
> > > > >  drivers/gpu/drm/panel/panel-auo-a030jtn01.c | 10 ++++------
> > > > >  1 file changed, 4 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/panel/panel-auo-a030jtn01.c b/driver=
s/gpu/drm/panel/panel-auo-a030jtn01.c
> > > > > index 77604d6a4e72c915c40575be0e47810c90b4ed71..83529b1c2bac2e29f=
41efaf4028950214b056a95 100644
> > > > > --- a/drivers/gpu/drm/panel/panel-auo-a030jtn01.c
> > > > > +++ b/drivers/gpu/drm/panel/panel-auo-a030jtn01.c
> > > > > @@ -200,9 +200,10 @@ static int a030jtn01_probe(struct spi_device=
 *spi)
> > > > >
> > > > >	spi->mode |=3D SPI_MODE_3 | SPI_3WIRE;
> > > > >
> > > > > -	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > > > -	if (!priv)
> > > > > -		return -ENOMEM;
> > > > > +	panel =3D devm_drm_panel_alloc(dev, struct a030jtn01, panel,
> > > > > +				     &a030jtn01_funcs, DRM_MODE_CONNECTOR_DPI);
> > > >
> > > > This doesn't compile and (yet) it's pushed already to drm-tip. AFAIU
> > > > it's supposed to be
> > > >	priv =3D devm_drm_panel_alloc(...);
> > >
> > > Yes:
> > >
> > > drivers/gpu/drm/panel/panel-auo-a030jtn01.c: In function =A1a030jtn01=
_probe=A2:
> > > drivers/gpu/drm/panel/panel-auo-a030jtn01.c:203:9: error: =A1panel=A2=
 undeclared (first use in this function)
> > >   203 |         panel =3D devm_drm_panel_alloc(dev, struct a030jtn01,=
 panel,
> > >       |         ^~~~~
> > > drivers/gpu/drm/panel/panel-auo-a030jtn01.c:203:9: note: each undecla=
red identifier is reported only once for each function it appears in
> > >
> > > Please turn on the config options for particular module if you are ma=
king
> > > changes to that module.
> >
> > Though probably, you can argue, that the pre-merge CI build should alre=
ady
> > be doing this. A sort of allmodconfig for the DRM subsystem, so that th=
ese
> > kinds of issues don't get missed.
>
> More compile errors:
>
> I'm still getting some allmodconfig errors:
>
> ../drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c: In function 'boe=
_th101mb31ig002_dsi_probe':
> ../drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c:352:9: error: 'pa=
nel' undeclared (first use in this function)
>   352 |         panel =3D devm_drm_panel_alloc(dev, struct panel_desc, pa=
nel,
>       |         ^~~~~
> ../drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c:352:9: note: each=
 undeclared identifier is reported only once for each function it appears in
> In file included from ../drivers/gpu/drm/panel/panel-boe-th101mb31ig002-2=
8a.c:18:
> ../drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c:352:38: error: 'd=
ev' undeclared (first use in this function); did you mean 'cdev'?
>   352 |         panel =3D devm_drm_panel_alloc(dev, struct panel_desc, pa=
nel,
>       |                                      ^~~
> ../include/drm/drm_panel.h:305:41: note: in definition of macro 'devm_drm=
_panel_alloc'
>   305 |         ((type *)__devm_drm_panel_alloc(dev, sizeof(type), \
>       |                                         ^~~
> In file included from ../include/uapi/linux/posix_types.h:5,
>                  from ../include/uapi/linux/types.h:14,
>                  from ../include/linux/types.h:6,
>                  from ../include/linux/math.h:5,
>                  from ../include/linux/delay.h:12,
>                  from ../drivers/gpu/drm/panel/panel-boe-th101mb31ig002-2=
8a.c:8:
> ../include/linux/stddef.h:16:33: error: 'struct panel_desc' has no member=
 named 'panel'
>    16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
>       |                                 ^~~~~~~~~~~~~~~~~~
> ../include/drm/drm_panel.h:306:41: note: in expansion of macro 'offsetof'
>   306 |                                         offsetof(type, member), f=
uncs, \
>       |                                         ^~~~~~~~
> ../drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c:352:17: note: in =
expansion of macro 'devm_drm_panel_alloc'
>   352 |         panel =3D devm_drm_panel_alloc(dev, struct panel_desc, pa=
nel,
>       |                 ^~~~~~~~~~~~~~~~~~~~
>

In case it is not clear, to reproduce and fix these, do:

	make -j$(nproc) allmodconfig


>
>
>
> >
> >
> > >
> > > >
> > > > > +	if (IS_ERR(panel))
> > > > > +		return PTR_ERR(panel);
> > > > >
> > > > >	priv->spi =3D spi;
> > > > >	spi_set_drvdata(spi, priv);
> > > > > @@ -223,9 +224,6 @@ static int a030jtn01_probe(struct spi_device =
*spi)
> > > > >	if (IS_ERR(priv->reset_gpio))
> > > > >		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio), "Failed to =
get reset GPIO");
> > > > >
> > > > > -	drm_panel_init(&priv->panel, dev, &a030jtn01_funcs,
> > > > > -		       DRM_MODE_CONNECTOR_DPI);
> > > > > -
> > > > >	err =3D drm_panel_of_backlight(&priv->panel);
> > > > >	if (err)
> > > > >		return err;
> > > > >
> > > > > --
> > > > > 2.48.1
> > > > >

