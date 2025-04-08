Return-Path: <linux-kernel+bounces-592871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CF4A7F24F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 03:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6615A3AAEAE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 01:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17AD24886F;
	Tue,  8 Apr 2025 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZNCPSG22"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8C220B21F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744076427; cv=none; b=iyp0VfIc7dL6dbyF7WcKopDpADeWKUJ4ssfX91RTDr3PSsexEmRYDWpQxr1l+0v0vvJ9XnM6nj+iozAEAdnawnfpZ4GpMi9QRxsddHGRYGqNnfqkZ5LJJrBZz4UdGoibGdTuJ5YBfH/AtaAiq4LyQyQxE3wAO5ECNbNL3bkai5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744076427; c=relaxed/simple;
	bh=HgrmWXIBNbmdElp1wf1UHlcrxPduAJniYElZ7U6cAAk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+keCY7NzXnHKiXk4Y9UoaEvPFOiK/+UldJlvd2XlZZE8E+nLkXEUTc3IeSQ1CZaWKQoZ+ucrhTK80ZkR8Y7oz1CvxOLy61cBTnv/T+4YLUw7VmvlASQwjm7Yfy9+ehkjq+zKCVxvNb+PxFuoXMRxrMq/UKqcqhCyebCmcsg1Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZNCPSG22; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744076426; x=1775612426;
  h=date:message-id:from:to:cc:subject:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HgrmWXIBNbmdElp1wf1UHlcrxPduAJniYElZ7U6cAAk=;
  b=ZNCPSG22xyXGD55CxgebVgCVZp4uv43XePNEo/85v861WQDKtLdd010L
   eIptxjE5XHUCxjo1ldznGfvgcftsta360vK+46BWm2rZvTk6jMCBT23Bi
   7iz9o9nC7FbYDl96sfQ+QYSuWd+T4k1/a9y40LJSFkjIIpUYpC7mrE5H9
   gvVueIdF9iRWtRSKp4SU2J0mnX91/klZniqpxu/mCypSp4ESqUvrroZ5/
   gfwhfEtBCdwz5RXxBhlXXQQkxGl1G/zQsdtUgF5o2a0LSSux8Xb3BolYX
   t0DYJvBuFhiFYofqYr8ja24RwEIzUjwycMHmQeFcpgE21osOSy5l1m7Bf
   A==;
X-CSE-ConnectionGUID: HcWZpI8rTdaK8jt2LTeF3Q==
X-CSE-MsgGUID: 1Y9VkD8XSn69VO+PVx85aQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49284622"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="49284622"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 18:40:25 -0700
X-CSE-ConnectionGUID: XbE4urcSTwyZGrxlHESIRQ==
X-CSE-MsgGUID: njGT9niPTtqA5Jxi5D2hvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="127873567"
Received: from ksmithe-mobl1.amr.corp.intel.com (HELO adixit-MOBL3.intel.com) ([10.125.211.148])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 18:40:24 -0700
Date: Mon, 07 Apr 2025 18:40:24 -0700
Message-ID: <87a58re8hj.wl-ashutosh.dixit@intel.com>
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
In-Reply-To: <87bjt7eca8.wl-ashutosh.dixit@intel.com>
References: <20250401-b4-drm-panel-mass-driver-convert-v1-0-cdd7615e1f93@redhat.com>
	<20250401-b4-drm-panel-mass-driver-convert-v1-4-cdd7615e1f93@redhat.com>
	<Z_P0A9lxWD0aAdjp@ideak-desk.fi.intel.com>
	<85a58rsgjj.wl-ashutosh.dixit@intel.com>
	<87bjt7eca8.wl-ashutosh.dixit@intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?ISO-8859-4?Q?Goj=F2?=) APEL-LB/10.8 EasyPG/1.0.0
 Emacs/29.4 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: quoted-printable

On Mon, 07 Apr 2025 17:18:23 -0700, Dixit, Ashutosh wrote:
>
> On Mon, 07 Apr 2025 16:22:40 -0700, Dixit, Ashutosh wrote:
> >
> > On Mon, 07 Apr 2025 08:49:23 -0700, Imre Deak wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Apr 01, 2025 at 12:03:47PM -0400, Anusha Srivatsa wrote:
> > > > Move to using the new API devm_drm_panel_alloc() to allocate the
> > > > panel.
> > > >
> > > > Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> > > > ---
> > > >  drivers/gpu/drm/panel/panel-auo-a030jtn01.c | 10 ++++------
> > > >  1 file changed, 4 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/panel/panel-auo-a030jtn01.c b/drivers/=
gpu/drm/panel/panel-auo-a030jtn01.c
> > > > index 77604d6a4e72c915c40575be0e47810c90b4ed71..83529b1c2bac2e29f41=
efaf4028950214b056a95 100644
> > > > --- a/drivers/gpu/drm/panel/panel-auo-a030jtn01.c
> > > > +++ b/drivers/gpu/drm/panel/panel-auo-a030jtn01.c
> > > > @@ -200,9 +200,10 @@ static int a030jtn01_probe(struct spi_device *=
spi)
> > > >
> > > >	spi->mode |=3D SPI_MODE_3 | SPI_3WIRE;
> > > >
> > > > -	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > > -	if (!priv)
> > > > -		return -ENOMEM;
> > > > +	panel =3D devm_drm_panel_alloc(dev, struct a030jtn01, panel,
> > > > +				     &a030jtn01_funcs, DRM_MODE_CONNECTOR_DPI);
> > >
> > > This doesn't compile and (yet) it's pushed already to drm-tip. AFAIU
> > > it's supposed to be
> > >	priv =3D devm_drm_panel_alloc(...);
> >
> > Yes:
> >
> > drivers/gpu/drm/panel/panel-auo-a030jtn01.c: In function =A1a030jtn01_p=
robe=A2:
> > drivers/gpu/drm/panel/panel-auo-a030jtn01.c:203:9: error: =A1panel=A2 u=
ndeclared (first use in this function)
> >   203 |         panel =3D devm_drm_panel_alloc(dev, struct a030jtn01, p=
anel,
> >       |         ^~~~~
> > drivers/gpu/drm/panel/panel-auo-a030jtn01.c:203:9: note: each undeclare=
d identifier is reported only once for each function it appears in
> >
> > Please turn on the config options for particular module if you are maki=
ng
> > changes to that module.
>
> Though probably, you can argue, that the pre-merge CI build should already
> be doing this. A sort of allmodconfig for the DRM subsystem, so that these
> kinds of issues don't get missed.

More compile errors:

I'm still getting some allmodconfig errors:

../drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c: In function 'boe_t=
h101mb31ig002_dsi_probe':
../drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c:352:9: error: 'pane=
l' undeclared (first use in this function)
  352 |         panel =3D devm_drm_panel_alloc(dev, struct panel_desc, pane=
l,
      |         ^~~~~
../drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c:352:9: note: each u=
ndeclared identifier is reported only once for each function it appears in
In file included from ../drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a=
.c:18:
../drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c:352:38: error: 'dev=
' undeclared (first use in this function); did you mean 'cdev'?
  352 |         panel =3D devm_drm_panel_alloc(dev, struct panel_desc, pane=
l,
      |                                      ^~~
../include/drm/drm_panel.h:305:41: note: in definition of macro 'devm_drm_p=
anel_alloc'
  305 |         ((type *)__devm_drm_panel_alloc(dev, sizeof(type), \
      |                                         ^~~
In file included from ../include/uapi/linux/posix_types.h:5,
                 from ../include/uapi/linux/types.h:14,
                 from ../include/linux/types.h:6,
                 from ../include/linux/math.h:5,
                 from ../include/linux/delay.h:12,
                 from ../drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a=
.c:8:
../include/linux/stddef.h:16:33: error: 'struct panel_desc' has no member n=
amed 'panel'
   16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
      |                                 ^~~~~~~~~~~~~~~~~~
../include/drm/drm_panel.h:306:41: note: in expansion of macro 'offsetof'
  306 |                                         offsetof(type, member), fun=
cs, \
      |                                         ^~~~~~~~
../drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c:352:17: note: in ex=
pansion of macro 'devm_drm_panel_alloc'
  352 |         panel =3D devm_drm_panel_alloc(dev, struct panel_desc, pane=
l,
      |                 ^~~~~~~~~~~~~~~~~~~~




>
>
> >
> > >
> > > > +	if (IS_ERR(panel))
> > > > +		return PTR_ERR(panel);
> > > >
> > > >	priv->spi =3D spi;
> > > >	spi_set_drvdata(spi, priv);
> > > > @@ -223,9 +224,6 @@ static int a030jtn01_probe(struct spi_device *s=
pi)
> > > >	if (IS_ERR(priv->reset_gpio))
> > > >		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio), "Failed to ge=
t reset GPIO");
> > > >
> > > > -	drm_panel_init(&priv->panel, dev, &a030jtn01_funcs,
> > > > -		       DRM_MODE_CONNECTOR_DPI);
> > > > -
> > > >	err =3D drm_panel_of_backlight(&priv->panel);
> > > >	if (err)
> > > >		return err;
> > > >
> > > > --
> > > > 2.48.1
> > > >

