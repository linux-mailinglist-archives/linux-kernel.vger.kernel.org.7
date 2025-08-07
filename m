Return-Path: <linux-kernel+bounces-758688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BAAB1D2A5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDF5B7A5AAB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 06:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63864221DBA;
	Thu,  7 Aug 2025 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="JfxBtduO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="mrGZMwTt"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A222288CB;
	Thu,  7 Aug 2025 06:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754549347; cv=none; b=W1l1cWjD5eeMAFAcNhoUclQc9G7/fEjkl5ef3q5wntA3YxsgSO28WPL/8Qu8DMbxu8RBVkLlFppYCZ7eVMg2ye3pIHHifc10X5sHLl7U2wM94z76s2BNNCPS1zuHZnhGTzN8S2webFl5PQT/xCtXlwhGgLafRcBl1/i8jqhESUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754549347; c=relaxed/simple;
	bh=jlhYYqseoKELITQ5ATLhE0ZFe5RLa7WX/i7FJKV2WnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6S2+XiXE8CaeTdA5lt9FU7CncCoqUWr0umxovQSzg0mzdsK3R6sHn5Edp6RmoFNDllup4QvOfnw3BI7YJ5KOaXBIZYUs9Yh6kXNfG/jOEiUU2m3TYqigwGcxSu5nuNjEL1a2fxMrQTvZlEKGFZ1kJrC3eltpLiyBfzXfOChlPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=JfxBtduO; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=mrGZMwTt reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1754549344; x=1786085344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Sx8JUyM3/4H7bRCB9wNV/IluDw2UIz1vKgHRy/QEVw=;
  b=JfxBtduOBSqtaWoAq/X7VUlwQv4/XoOpcro5wWujYfUQqO/pSM00MBPx
   iOaxcPuY76/eOpTPwAM0/ZSJ4eU25uiusHnLNxpXebGVYBA7DRfakfBAl
   cxWUk/K8G+8igr7NrrzOn06t0zkauOTStXlVJi69qF1Ph3g9zmPNkK+1L
   pSE92AEgbO1jhabA36+/RY1G8cedMCMbf76mybX1hP/vBRBhUA8yUgjcQ
   AU0DfXHcTykk+2YihXnCQYe+LvILcOLmA18YOXr+gRYaZa6ADnp53M3f3
   zh5VGVX5Bz57fjUO4jtvYGpe5ZPWVOl5Wf2esCNbOBL25z++vIydSqrt/
   g==;
X-CSE-ConnectionGUID: I2PmyxDYScSuTRFw+H5RPw==
X-CSE-MsgGUID: XDJruS2UTWOZejcJYgaFyQ==
X-IronPort-AV: E=Sophos;i="6.17,271,1747692000"; 
   d="scan'208";a="45628058"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Aug 2025 08:48:51 +0200
X-CheckPoint: {68944C53-3-299FBAB0-EF52EDE7}
X-MAIL-CPID: 9B87D54F7B707BEEAED780E1C71972C8_5
X-Control-Analysis: str=0001.0A002116.68944C87.0028,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 509341613DA;
	Thu,  7 Aug 2025 08:48:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1754549326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Sx8JUyM3/4H7bRCB9wNV/IluDw2UIz1vKgHRy/QEVw=;
	b=mrGZMwTtVtjo5kHwbg35IQX/P5TNnTWBQcIxNa9iUC7uSo7rTQLbuzsOAR0XdkbAgHVYVL
	jhBCsFQ9GwQKTzxzFPGU93q2evcLKB7X2GV5sLvGVSMBpjyhMaVcnVV/rYGDshvdUVR1aY
	2Yr7vXdhMvML4A8B1d0fq+SM2JIoHoGGPg5LifurXToqn06YRqsdSb21SAOEInEIwqMk0B
	FooH5azD929SoI3ZX6geUNC3FRIAAorL18g5SBmBcTIs88LaVBmxpepG81KTLhjPbZWHHe
	v6eTmkjeBRyGiFoqWRFob27/ZWAQLxM6SzAIhAMo6/mr1j/iTjRKpAZKOAuMnA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org,
 cristian.ciocaltea@collabora.com, luca.ceresoli@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 victor.liu@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org,
 l.stach@pengutronix.de, perex@perex.cz, tiwai@suse.com,
 linux-sound@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
Subject:
 Re: [PATCH v3 5/6] drm/bridge: imx: add driver for HDMI TX Parallel Audio
 Interface
Date: Thu, 07 Aug 2025 08:48:35 +0200
Message-ID: <3006103.e9J7NaK4W3@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To:
 <CAA+D8AMqBqfRuR7oGLwH4CUrAdY4q1XGmnPXGQYUGndY0eS=yw@mail.gmail.com>
References:
 <20250804104722.601440-1-shengjiu.wang@nxp.com> <2380862.ElGaqSPkdT@steina-w>
 <CAA+D8AMqBqfRuR7oGLwH4CUrAdY4q1XGmnPXGQYUGndY0eS=yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Mittwoch, 6. August 2025, 05:49:13 CEST schrieb Shengjiu Wang:
> On Tue, Aug 5, 2025 at 3:09=E2=80=AFPM Alexander Stein
> <alexander.stein@ew.tq-group.com> wrote:
> [snip]
> > > +static int imx8mp_dw_hdmi_bind(struct device *dev)
> > > +{
> > > +     struct dw_hdmi_plat_data *plat_data;
> > > +     struct imx8mp_hdmi *hdmi;
> > > +     int ret;
> > > +
> > > +     hdmi =3D dev_get_drvdata(dev);
> > > +     plat_data =3D &hdmi->plat_data;
> > > +
> > > +     ret =3D component_bind_all(dev, plat_data);
> >
> > Do you really need plat_data variable?
>=20
> yes,  it is used in imx8mp_hdmi_pai_bind()

Sorry for not being clear. I'm not talking about struct dw_hdmi_plat_data, =
but
the local variable plat_data. You can use

ret =3D component_bind_all(dev, &hdmi->plat_data);

directly.

>=20
> >
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret, "component_bind_all fail=
ed!\n");
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void imx8mp_dw_hdmi_unbind(struct device *dev)
> > > +{
> > > +     struct dw_hdmi_plat_data *plat_data;
> > > +     struct imx8mp_hdmi *hdmi;
> > > +
> > > +     hdmi =3D dev_get_drvdata(dev);
> > > +     plat_data =3D &hdmi->plat_data;
> > > +
> > > +     component_unbind_all(dev, plat_data);
> >
> > Do you really need plat_data variable?
>=20
> yes,  it is used by imx8mp_hdmi_pai_unbind()

Same as above. Call

component_unbind_all(dev, &hdmi->plat_data)

directly. Also consider assigning struct imx8mp_hdmi *hdmi =3D dev_get_drvd=
ata(dev);
directly.

Best regards,
Alexander

>=20
> >
> > > +}
> > > +
> > > +static const struct component_master_ops imx8mp_dw_hdmi_ops =3D {
> > > +     .bind   =3D imx8mp_dw_hdmi_bind,
> > > +     .unbind =3D imx8mp_dw_hdmi_unbind,
> > > +};
> > > +
> > >  static int imx8mp_dw_hdmi_probe(struct platform_device *pdev)
> > >  {
> > >       struct device *dev =3D &pdev->dev;
> > >       struct dw_hdmi_plat_data *plat_data;
> > > +     struct component_match *match;
> >
> > Set match =3D NULL for drm_of_component_match_add (and subcalls) to all=
ocate memory.
>=20
> Ok.
>=20
> best regards
> Shengjiu wang.
> >
> > Best regards
> > Alexander
> >
> > > +     struct device_node *remote;
> > >       struct imx8mp_hdmi *hdmi;
> > > +     int ret;
> > >
> > >       hdmi =3D devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
> > >       if (!hdmi)
> > > @@ -108,6 +145,22 @@ static int imx8mp_dw_hdmi_probe(struct platform_=
device *pdev)
> > >
> > >       platform_set_drvdata(pdev, hdmi);
> > >
> > > +     /* port@2 is for hdmi_pai device */
> > > +     remote =3D of_graph_get_remote_node(pdev->dev.of_node, 2, 0);
> > > +     if (remote && of_device_is_available(remote)) {
> > > +             drm_of_component_match_add(dev, &match, component_compa=
re_of, remote);
> > > +
> > > +             of_node_put(remote);
> > > +
> > > +             ret =3D component_master_add_with_match(dev, &imx8mp_dw=
_hdmi_ops, match);
> > > +             if (ret)
> > > +                     dev_warn(dev, "Unable to register aggregate dri=
ver\n");
> > > +             /*
> > > +              * This audio function is optional for avoid blocking d=
isplay.
> > > +              * So just print warning message and no error is return=
ed.
> > > +              */
> > > +     }
> > > +
> > >       return 0;
> > >  }
> > >
> > > @@ -115,6 +168,8 @@ static void imx8mp_dw_hdmi_remove(struct platform=
_device *pdev)
> > >  {
> > >       struct imx8mp_hdmi *hdmi =3D platform_get_drvdata(pdev);
> > >
> > > +     component_master_del(&pdev->dev, &imx8mp_dw_hdmi_ops);
> > > +
> > >       dw_hdmi_remove(hdmi->dw_hdmi);
> > >  }
> > >
> > > diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdm=
i.h
> > > index 095cdd9b7424..336f062e1f9d 100644
> > > --- a/include/drm/bridge/dw_hdmi.h
> > > +++ b/include/drm/bridge/dw_hdmi.h
> > > @@ -143,6 +143,12 @@ struct dw_hdmi_plat_data {
> > >                                          const struct drm_display_inf=
o *info,
> > >                                          const struct drm_display_mod=
e *mode);
> > >
> > > +     /*
> > > +      * priv_audio is specially used for additional audio device to =
get
> > > +      * driver data through this dw_hdmi_plat_data.
> > > +      */
> > > +     void *priv_audio;
> > > +
> > >       /* Platform-specific audio enable/disable (optional) */
> > >       void (*enable_audio)(struct dw_hdmi *hdmi, int channel,
> > >                            int width, int rate, int non_pcm, int iec9=
58);
> > >
> >
> >
> > --
> > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, =
Germany
> > Amtsgericht M=C3=BCnchen, HRB 105018
> > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan=
 Schneider
> > http://www.tq-group.com/
> >
> >
>=20


=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/



