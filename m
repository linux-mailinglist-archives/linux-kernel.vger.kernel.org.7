Return-Path: <linux-kernel+bounces-824243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB35B887C7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F93C1C83F66
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24022F5302;
	Fri, 19 Sep 2025 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF7ybM3K"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B342D8393
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272190; cv=none; b=RxaBv2+qTUjQYvkqmKBcT8nO6jEmLX0okxrcncNYg2jjazDt3n1ID8/POS26/AYiYaZuXVrXJi5bXJn7xU8nKt5y8OTVmjq9f0bCfKEuFYFGL/M9R+J/kGY1y2jGskp+KI2LgRQx3LZbcyAwfHmh9XQrpnFkNCiRPIgEfUHQicw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272190; c=relaxed/simple;
	bh=z/6qpk03KVjxeDfqIiXD/LZFo4d650cslx/EbSCIBj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGb71euKwfmhqZAnb6vb/BYLIiGptu8XyQO/W3+Q1DxZL6tZiHyN22yZbbDtxTasngBNpn+thXY9qcvlForgBEjQc93cWTMK+a3ebr1bSIR6fqzq7jWmDk/031DfLUvcJO8ybsPqgeGWeTSMgNntQ35ZJMn0uAZsfuvJ1tk893I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF7ybM3K; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so177836f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758272186; x=1758876986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3SjolQB/965DSj8U4lOYkQfWCLlEcwDrVdjMZu0fvY=;
        b=kF7ybM3K43hlC3ZdJoiUip+d/N01Pmw/BteJEx5HN6GR4N6LqQr0Zc4jmcG/Z10l4E
         xbuluHaUH4tRBFklCmdRmUWglsz4DnCUMHtM9ZtNCD+SDMJy2DMnqqHK4P2YAHvWMUPk
         Qywk3r2TKbdXh271Y0HsvxBfrUq6JiC5IZckXcuvA3xSdNjlh1khQAakSRiLyn2/tTIM
         Za5QiR3cbzHi3rvcdTG+jzFoDn7lTIGr/JglSakUPd7HvuyQI4i2PROP1sTDlxKeBYiG
         kh++Q+ce7+qn08Uhjwd0oHuCTxKb97TM+LMMVSMC1FJYSqT8xSeQLIE00BZJ8bvqdYTd
         GnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758272186; x=1758876986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3SjolQB/965DSj8U4lOYkQfWCLlEcwDrVdjMZu0fvY=;
        b=mgH7/GbBN2CpWnG/F11lqh/sASwMZrT5EYscyRrOYaoRCsqLlWNb2qFkG4HeoIofJ0
         4iuAQo8VP/OgePJbd5DdzUuyTXD2e/woZikmqWlvnWbrnSLmp53mADBzPcCjYRo5Qkm6
         RbC02cI69uRSmMBc1KLTurYqKwn+a4IynhaOhA7MDugpSFH5PBh/0Dt48i6jHbNUOHnE
         pyAG6jcjWauL69tgp4OOkW7QNXIwnedoLTTAukV3h9M+MeS1MJ96RCgP89grFKCwe28Q
         UouUYw3icB2s5Rre9L+nxS5ymQOYZrM9CgxpfP0ZfowF6O/h+SrccUExzU1Wvzt1WNH8
         5GZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7eiq+5+JvD3VqZQ5xq7yGVb3hxLpD8aUjVTXz5ogfElrEB4hGMfgiD6fVkJLE6M9ofhA7c4N4AhVIAm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9oGwpgaIe61deNzfB6/oVuSnznklbtzZLhRUp8J2+Vh/5btmc
	zLSeyNNxlTmYudjZO1fLxBK3iZOU6rlQjvhoDxTm//FQElx+mL/0k1QiRP9NBAvyi2Whp8cnOuX
	cDLNsAsjFOZ5ujmmqvenRAaskrWJDJlk=
X-Gm-Gg: ASbGnctO2ICPCa8Su6VSk6uh88KK4j1We1BEiH22vva0AyJnv/OcrNbP+LSYvb7IMnH
	Fqm/I3TyxpUBfDseqGTs8kKI63QSBCLf0PnUV8YuA/L7h5De4fRW1Ciwq3rxQDoCgp5BNFkiAMm
	S8JLK8DsyziJEDtSlth4fw3nETUxOVc4jNOK8NXhRnvDBlic3bzTR4X33YgFm0MZ3aWwtH7hBL2
	URy3Nhn
X-Google-Smtp-Source: AGHT+IFSRgoyAcfBMBdxJ3/Mg94CU1V7AfyoCIGOSWF2v2XWjSF8VBHtPZaoUW2eW5N/CrVldqiF9YYHWb26kL7t4bw=
X-Received: by 2002:a05:6000:310f:b0:3ee:152e:676e with SMTP id
 ffacd0b85a97d-3ee7b9dcd9emr1716992f8f.11.1758272185363; Fri, 19 Sep 2025
 01:56:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906135345.241229-1-clamor95@gmail.com> <20250906135345.241229-10-clamor95@gmail.com>
 <4792993.1IzOArtZ34@senjougahara> <CAPVz0n2BpSeZkoT1YV9q5bkOCkjSvOwAXNVGgM4wPUqV3jyxgg@mail.gmail.com>
In-Reply-To: <CAPVz0n2BpSeZkoT1YV9q5bkOCkjSvOwAXNVGgM4wPUqV3jyxgg@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 19 Sep 2025 11:56:14 +0300
X-Gm-Features: AS18NWBH4VHm807-uapHCiTJGO5ngwX3Ep54IEurA9hHeb7dua-mj3pRKJUHO0c
Message-ID: <CAPVz0n1XBAXj=x0jJNbKURUY3NJEyS3dFONsFeXaUzbx9W0y_g@mail.gmail.com>
Subject: Re: [PATCH v2 09/23] gpu: host1x: convert MIPI to use operations
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Thierry Reding <treding@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prashant Gaikwad <pgaikwad@nvidia.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Osipenko <digetx@gmail.com>, 
	=?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
	Charan Pedumuru <charan.pedumuru@gmail.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 19 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 10:58 Svya=
toslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D0=BF=D1=82, 19 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 09:47 Mi=
kko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Saturday, September 6, 2025 10:53=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > This commit converts the existing MIPI code to use operations, which =
is a
> > > necessary step for the Tegra20/Tegra30 SoCs. Additionally, it creates=
 a
> > > dedicated header file, tegra-mipi-cal.h, to contain the MIPI calibrat=
ion
> > > functions, improving code organization and readability.
> >
> > I'd write out "operation function pointers", at least the first time. J=
ust "operations" isn't clear to me.
> >
> > Please write the commit message in imperative mood (like you've done in=
 other patches).
> >
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/gpu/drm/tegra/dsi.c             |   1 +
> > >  drivers/gpu/host1x/mipi.c               |  40 +++------
> > >  drivers/staging/media/tegra-video/csi.c |   1 +
> > >  include/linux/host1x.h                  |  10 ---
> > >  include/linux/tegra-mipi-cal.h          | 111 ++++++++++++++++++++++=
++
> > >  5 files changed, 126 insertions(+), 37 deletions(-)
> > >  create mode 100644 include/linux/tegra-mipi-cal.h
> > >
> > > diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.=
c
> > > index 64f12a85a9dd..278bf2c85524 100644
> > > --- a/drivers/gpu/drm/tegra/dsi.c
> > > +++ b/drivers/gpu/drm/tegra/dsi.c
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/pm_runtime.h>
> > >  #include <linux/regulator/consumer.h>
> > >  #include <linux/reset.h>
> > > +#include <linux/tegra-mipi-cal.h>
> > >
> > >  #include <video/mipi_display.h>
> > >
> > > diff --git a/drivers/gpu/host1x/mipi.c b/drivers/gpu/host1x/mipi.c
> > > index e51b43dd15a3..2fa339a428f3 100644
> > > --- a/drivers/gpu/host1x/mipi.c
> > > +++ b/drivers/gpu/host1x/mipi.c
> > > @@ -27,6 +27,7 @@
> > >  #include <linux/of_platform.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/tegra-mipi-cal.h>
> > >
> > >  #include "dev.h"
> > >
> > > @@ -116,23 +117,6 @@ struct tegra_mipi_soc {
> > >       u8 hsclkpuos;
> > >  };
> > >
> > > -struct tegra_mipi {
> > > -     const struct tegra_mipi_soc *soc;
> > > -     struct device *dev;
> > > -     void __iomem *regs;
> > > -     struct mutex lock;
> > > -     struct clk *clk;
> > > -
> > > -     unsigned long usage_count;
> > > -};
> > > -
> > > -struct tegra_mipi_device {
> > > -     struct platform_device *pdev;
> > > -     struct tegra_mipi *mipi;
> > > -     struct device *device;
> > > -     unsigned long pads;
> > > -};
> > > -
> > >  static inline u32 tegra_mipi_readl(struct tegra_mipi *mipi,
> > >                                  unsigned long offset)
> > >  {
> > > @@ -261,7 +245,7 @@ void tegra_mipi_free(struct tegra_mipi_device *de=
vice)
> > >  }
> > >  EXPORT_SYMBOL(tegra_mipi_free);
> > >
> > > -int tegra_mipi_enable(struct tegra_mipi_device *dev)
> > > +static int tegra114_mipi_enable(struct tegra_mipi_device *dev)
> > >  {
> > >       int err =3D 0;
> > >
> > > @@ -273,11 +257,9 @@ int tegra_mipi_enable(struct tegra_mipi_device *=
dev)
> > >       mutex_unlock(&dev->mipi->lock);
> > >
> > >       return err;
> > > -
> > >  }
> > > -EXPORT_SYMBOL(tegra_mipi_enable);
> > >
> > > -int tegra_mipi_disable(struct tegra_mipi_device *dev)
> > > +static int tegra114_mipi_disable(struct tegra_mipi_device *dev)
> > >  {
> > >       int err =3D 0;
> > >
> > > @@ -289,11 +271,9 @@ int tegra_mipi_disable(struct tegra_mipi_device =
*dev)
> > >       mutex_unlock(&dev->mipi->lock);
> > >
> > >       return err;
> > > -
> > >  }
> > > -EXPORT_SYMBOL(tegra_mipi_disable);
> > >
> > > -int tegra_mipi_finish_calibration(struct tegra_mipi_device *device)
> > > +static int tegra114_mipi_finish_calibration(struct tegra_mipi_device=
 *device)
> > >  {
> > >       struct tegra_mipi *mipi =3D device->mipi;
> > >       void __iomem *status_reg =3D mipi->regs + (MIPI_CAL_STATUS << 2=
);
> > > @@ -309,9 +289,8 @@ int tegra_mipi_finish_calibration(struct tegra_mi=
pi_device *device)
> > >
> > >       return err;
> > >  }
> > > -EXPORT_SYMBOL(tegra_mipi_finish_calibration);
> > >
> > > -int tegra_mipi_start_calibration(struct tegra_mipi_device *device)
> > > +static int tegra114_mipi_start_calibration(struct tegra_mipi_device =
*device)
> > >  {
> > >       const struct tegra_mipi_soc *soc =3D device->mipi->soc;
> > >       unsigned int i;
> > > @@ -384,7 +363,13 @@ int tegra_mipi_start_calibration(struct tegra_mi=
pi_device *device)
> > >
> > >       return 0;
> > >  }
> > > -EXPORT_SYMBOL(tegra_mipi_start_calibration);
> > > +
> > > +static const struct tegra_mipi_ops tegra114_mipi_ops =3D {
> > > +     .tegra_mipi_enable =3D tegra114_mipi_enable,
> > > +     .tegra_mipi_disable =3D tegra114_mipi_disable,
> > > +     .tegra_mipi_start_calibration =3D tegra114_mipi_start_calibrati=
on,
> > > +     .tegra_mipi_finish_calibration =3D tegra114_mipi_finish_calibra=
tion,
> > > +};
> > >
> > >  static const struct tegra_mipi_pad tegra114_mipi_pads[] =3D {
> > >       { .data =3D MIPI_CAL_CONFIG_CSIA },
> > > @@ -512,6 +497,7 @@ static int tegra_mipi_probe(struct platform_devic=
e *pdev)
> > >
> > >       mipi->soc =3D match->data;
> > >       mipi->dev =3D &pdev->dev;
> > > +     mipi->ops =3D &tegra114_mipi_ops;
> > >
> > >       mipi->regs =3D devm_platform_get_and_ioremap_resource(pdev, 0, =
NULL);
> > >       if (IS_ERR(mipi->regs))
> > > diff --git a/drivers/staging/media/tegra-video/csi.c b/drivers/stagin=
g/media/tegra-video/csi.c
> > > index 74c92db1032f..9e3bd6109781 100644
> > > --- a/drivers/staging/media/tegra-video/csi.c
> > > +++ b/drivers/staging/media/tegra-video/csi.c
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/of_graph.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/pm_runtime.h>
> > > +#include <linux/tegra-mipi-cal.h>
> > >
> > >  #include <media/v4l2-fwnode.h>
> > >
> > > diff --git a/include/linux/host1x.h b/include/linux/host1x.h
> > > index 9fa9c30a34e6..b1c6514859d3 100644
> > > --- a/include/linux/host1x.h
> > > +++ b/include/linux/host1x.h
> > > @@ -453,16 +453,6 @@ void host1x_client_unregister(struct host1x_clie=
nt *client);
> > >  int host1x_client_suspend(struct host1x_client *client);
> > >  int host1x_client_resume(struct host1x_client *client);
> > >
> > > -struct tegra_mipi_device;
> > > -
> > > -struct tegra_mipi_device *tegra_mipi_request(struct device *device,
> > > -                                          struct device_node *np);
> > > -void tegra_mipi_free(struct tegra_mipi_device *device);
> > > -int tegra_mipi_enable(struct tegra_mipi_device *device);
> > > -int tegra_mipi_disable(struct tegra_mipi_device *device);
> > > -int tegra_mipi_start_calibration(struct tegra_mipi_device *device);
> > > -int tegra_mipi_finish_calibration(struct tegra_mipi_device *device);
> > > -
> > >  /* host1x memory contexts */
> > >
> > >  struct host1x_memory_context {
> > > diff --git a/include/linux/tegra-mipi-cal.h b/include/linux/tegra-mip=
i-cal.h
> > > new file mode 100644
> > > index 000000000000..2bfdbfd3cb77
> > > --- /dev/null
> > > +++ b/include/linux/tegra-mipi-cal.h
> > > @@ -0,0 +1,111 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +#ifndef __TEGRA_MIPI_CAL_H_
> > > +#define __TEGRA_MIPI_CAL_H_
> > > +
> > > +struct tegra_mipi {
> > > +     const struct tegra_mipi_soc *soc;
> > > +     const struct tegra_mipi_ops *ops;
> > > +     struct device *dev;
> > > +     void __iomem *regs;
> > > +     struct mutex lock;
> > > +     struct clk *clk;
> > > +
> > > +     unsigned long usage_count;
> > > +};
> > > +
> > > +struct tegra_mipi_device {
> > > +     struct platform_device *pdev;
> > > +     struct tegra_mipi *mipi;
> > > +     struct device *device;
> > > +     unsigned long pads;
> > > +};
> >
> > We should avoid putting implementation details / chip-specific things i=
n the public header. Here's a sketch of what I'm thinking about:
> >
> > --- tegra-mipi-cal.h:
> >
> > struct tegra_mipi_device;
> >
> > struct tegra_mipi_ops {
> >         // ...
> > };
> >
> > int tegra_mipi_add_provider(struct device_node *np, struct tegra_mipi_o=
ps *ops);
> >
> > int tegra_mipi_enable(...);
> > // ...
> >
> > --- host1x/mipi.c:
> >
> > // move tegra114-mipi specific stuff to a new file, e.g. host1x/tegra11=
4-mipi.c
> >
> > struct tegra_mipi_device {
> >         struct tegra_mipi_ops *ops;
> >         struct platform_device *pdev;
> > };
> >
> > /* only need to support one provider */
> > static struct {
> >         struct device_node *np;
> >         struct tegra_mipi_ops *ops;
> > } provider;
> >
> > int tegra_mipi_add_provider(struct device_node *np, struct tegra_mipi_o=
ps *ops)
> > {
> >         if (provider.np)
> >                 return -EBUSY;
> >
> >         provider.np =3D np;
> >         provider.ops =3D ops;
> >
> >         return 0;
> > }
> >
> > struct tegra_mipi_device *tegra_mipi_request(struct *device, struct dev=
ice_node *np)
> > {
> >         struct device_node *phandle_np =3D /* ... */;
> >         struct platform_device *pdev;
> >         struct tegra_mipi_device *mipidev;
> >
> >         if (provider.np !=3D phandle_np)
> >                 return -ENODEV;
> >
> >         pdev =3D /* ... */;
> >
> >         mipidev =3D kzalloc(...);
> >         mipidev->ops =3D provider.ops;
> >         mipidev->pdev =3D pdev;
> >         mipidev->cells =3D phandle_cells;
> >
> >         return mipidev;
> > }
> >
> > int tegra_mipi_enable(struct tegra_mipi_device *device)
> > {
> >         return device->ops->enable(platform_get_drvdata(device->pdev), =
device->cells);
> > }
> >
> > > +
> > > +/**
> > > + * Operations for Tegra MIPI calibration device
> > > + */
> > > +struct tegra_mipi_ops {
> > > +     /**
> > > +      * @tegra_mipi_enable:
> > > +      *
> > > +      * Enable MIPI calibration device
> > > +      */
> > > +     int (*tegra_mipi_enable)(struct tegra_mipi_device *device);
> >
> > The tegra_mipi_ prefix should be dropped for the field names.
> >
> > > +
> > > +     /**
> > > +      * @tegra_mipi_disable:
> > > +      *
> > > +      * Disable MIPI calibration device
> > > +      */
> > > +     int (*tegra_mipi_disable)(struct tegra_mipi_device *device);
> > > +
> > > +     /**
> > > +      * @tegra_mipi_start_calibration:
> > > +      *
> > > +      * Start MIPI calibration
> > > +      */
> > > +     int (*tegra_mipi_start_calibration)(struct tegra_mipi_device *d=
evice);
> > > +
> > > +     /**
> > > +      * @tegra_mipi_finish_calibration:
> > > +      *
> > > +      * Finish MIPI calibration
> > > +      */
> > > +     int (*tegra_mipi_finish_calibration)(struct tegra_mipi_device *=
device);
> > > +};
> > > +
> > > +struct tegra_mipi_device *tegra_mipi_request(struct device *device,
> > > +                                          struct device_node *np);
> > > +
> > > +void tegra_mipi_free(struct tegra_mipi_device *device);
> > > +
> > > +static inline int tegra_mipi_enable(struct tegra_mipi_device *device=
)
> > > +{
> > > +     /* Tegra114+ has a dedicated MIPI calibration block */
> > > +     if (device->mipi) {
> > > +             if (!device->mipi->ops->tegra_mipi_enable)
> > > +                     return 0;
> > > +
> > > +             return device->mipi->ops->tegra_mipi_enable(device);
> > > +     }
> > > +
> > > +     return -ENOSYS;
> > > +}
> > > +
> > > +static inline int tegra_mipi_disable(struct tegra_mipi_device *devic=
e)
> > > +{
> > > +     if (device->mipi) {
> > > +             if (!device->mipi->ops->tegra_mipi_disable)
> > > +                     return 0;
> > > +
> > > +             return device->mipi->ops->tegra_mipi_disable(device);
> > > +     }
> > > +
> > > +     return -ENOSYS;
> > > +}
> > > +
> > > +static inline int tegra_mipi_start_calibration(struct tegra_mipi_dev=
ice *device)
> > > +{
> > > +     if (device->mipi) {
> > > +             if (!device->mipi->ops->tegra_mipi_start_calibration)
> > > +                     return 0;
> > > +
> > > +             return device->mipi->ops->tegra_mipi_start_calibration(=
device);
> > > +     }
> > > +
> > > +     return -ENOSYS;
> > > +}
> > > +
> > > +static inline int tegra_mipi_finish_calibration(struct tegra_mipi_de=
vice *device)
> > > +{
> > > +     if (device->mipi) {
> > > +             if (!device->mipi->ops->tegra_mipi_finish_calibration)
> > > +                     return 0;
> > > +
> > > +             return device->mipi->ops->tegra_mipi_finish_calibration=
(device);
> > > +     }
> > > +
> > > +     return -ENOSYS;
> > > +}
> > > +
> > > +#endif /* __TEGRA_MIPI_CAL_H_ */
> > >
> >
>
> All this is good, but how to include into this CSI? Adding support for
> CSI is why I am even touching this at the first place.

Nevermind, I have figured it all out.

