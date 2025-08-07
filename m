Return-Path: <linux-kernel+bounces-758760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AEEB1D390
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD7137B39B0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5B723CF12;
	Thu,  7 Aug 2025 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcliJxuP"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4A71799F;
	Thu,  7 Aug 2025 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552575; cv=none; b=K6geY2QuVX5W66CaZD0UN8rlUixXp1FOS37wj7nZ9wAH8DcjGtgA7oRQzUFNrlseJPpG/aA9b/Fzmamcvc2RCFG1jGlZQA3mGAryTkWYMi01Aep+ve/ICIZMe//niFifAfZO1ElzOdzY8vfPCaVm4K2/OBAwa965Ml2BJTVS7nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552575; c=relaxed/simple;
	bh=HQgZxozEInQGtZeitnlKUz/X/aogQK/xmKgDuDLRE/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5giZ8j6ZEGZGocOtLn4xezWsBj5sDz1FioiBlHc0dSt/5ZYa+SzybF+sQxcrI0kPS9/+QgtbzEaN4C+24TR4xqyCiyvxZbMHbQi1/YXGBZJKzbF7dc3DKEjomBUBacEtVXxI4PU30ub8cpraM6Sr9n4tcriAmb66Gb+KacmOYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcliJxuP; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e40212e6ceso3544945ab.0;
        Thu, 07 Aug 2025 00:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754552573; x=1755157373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Yib2PCEaqNp1Pj8TAlHvoEegTED9u37QcVhIiDH6gc=;
        b=VcliJxuPYSL+V8cJ0evUZPrVLG2ES4pwHy52eBgXZDCedQwEMxOXfA+fNhYgZLLXNB
         CqflKv8FFvVDSfxxdhaz+tIdw2/dxrYrIgSipBmY3e/uCwTxQNOl9Exguv3VtciBrSQq
         5YF60s9Wtasng92aMtQSxr4tyTaeX2BmPB6/rfIqUYpVWI+kJXN28Ob9QfS5mBVOV9kR
         pkGRQUlNeOIFwhkMI3KHbed7lrMjkG1w8yI7F53ln5CzOrtPUKwWI0CbElGDYmIjG8ga
         ZFU9h48k7SitUyCJDI4dvQ4ylNwOo4HvCL1shHRza/6WFE+AgvjK/KIOyJPbWaCmuz1L
         NYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754552573; x=1755157373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Yib2PCEaqNp1Pj8TAlHvoEegTED9u37QcVhIiDH6gc=;
        b=jYM81sGSESKm1u4Cb2DF/vTRSXlQtVr6P9/rrUMRbQLzmEUyaJACzR4s4Ds48UfHpR
         3hKYe9i7XxbxucRciOurKZmPYy5vxHvmaXh6UUjNBDsYbDpPSqtH6qt+Zgbs792hxi4n
         Wgx0oFpaHOSA78NHfsBiqYGYGQNcycBK9uf1D88U8wNgxY6IvCVKTFRHNP+SBo454Jag
         QUwYV0x/33Z3gI+VgMA53VMijEHppAlTLIxzxrOZPHzyaBzv+e96+E2izLB9m06R41Hn
         l/YGGS4tuAww/+QqCQXjYGG+U0SRgmlkeJ0Mw/hmuyCvkeu2nWfPzxB3SrPQyXwV8txI
         OA/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYAciwq0MlhP0AHXk4gsrXYqGhvXwq3jo9mgspARWZ+lonRS15oPhokRy92Xj/ggSMMsVlhIc7SwT1@vger.kernel.org, AJvYcCWTGUQInPK+l1iMsk3vH1Dwf3N2+f8s9Z1fWiU8vrdgxTm3LyjIvFJQ3z58+a3mCTT3SE4r6HbbLFWvFTo=@vger.kernel.org, AJvYcCXFvffIQA7Jw4VfWLkWnG+C7AFux6jIYlHc8hfTMM9SyRDxQ4wkSc1mD1un2YlujTrzUqkg4TGy5I9h1njL@vger.kernel.org
X-Gm-Message-State: AOJu0YwrSmiOU6JqWScXWaKOc1hSOcN5smOZ0F/39Ijt1zaJ6Wfxle+j
	sbv18fm/12UMAYcFFDdhpiBFzx/tiihY7+iJQhKnaaxDG7L4+87mEmxURyMopjXPpr+pCmgnu5Y
	l7npeYBV4gAgdGRJMhVW7aCfBatzvm0U=
X-Gm-Gg: ASbGncvuL1Ztr1D2cBcVB7XmJf/DRcmyerJETVTj59rejNgV6uGVl8AiZZcOCnuZpR9
	CaquBa0isPOqUREtmtUfGGLlbzCMkbYVF0G8dLhbCYyYVWpuxP0aqBBNcmt2EivmwMwJx8otpvR
	jDjQhcgfd09wD9O2Y5Sg4Nuq8by2dETrNHGka70nA85mNH9CDU2X7pb1t3Z6cYZi9N+VQjwcB3I
	4FeiGs=
X-Google-Smtp-Source: AGHT+IHdqQFtfjRtDehIGRFADkvBaA4NvCzKMcHYFjCPCJ2UEYMmg8NkMVh8psgCR7M3BrtP7IfXADIqspKMXA8NOUE=
X-Received: by 2002:a05:6e02:3f08:b0:3e3:f1e9:635f with SMTP id
 e9e14a558f8ab-3e51b8985cdmr117142635ab.8.1754552572965; Thu, 07 Aug 2025
 00:42:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804104722.601440-1-shengjiu.wang@nxp.com>
 <2380862.ElGaqSPkdT@steina-w> <CAA+D8AMqBqfRuR7oGLwH4CUrAdY4q1XGmnPXGQYUGndY0eS=yw@mail.gmail.com>
 <3006103.e9J7NaK4W3@steina-w>
In-Reply-To: <3006103.e9J7NaK4W3@steina-w>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 7 Aug 2025 15:42:40 +0800
X-Gm-Features: Ac12FXyRnD4EHNKIjcnFtD3LudiK7-g39dWsOJVNfZbpF_BspGvpp8foyFbcxgc
Message-ID: <CAA+D8ANb_9GQTGCV0c5y517aSbQNnAu4wYvDhc4QPd+RqOhjbQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] drm/bridge: imx: add driver for HDMI TX Parallel
 Audio Interface
To: Alexander Stein <alexander.stein@ew.tq-group.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 2:48=E2=80=AFPM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi,
>
> Am Mittwoch, 6. August 2025, 05:49:13 CEST schrieb Shengjiu Wang:
> > On Tue, Aug 5, 2025 at 3:09=E2=80=AFPM Alexander Stein
> > <alexander.stein@ew.tq-group.com> wrote:
> > [snip]
> > > > +static int imx8mp_dw_hdmi_bind(struct device *dev)
> > > > +{
> > > > +     struct dw_hdmi_plat_data *plat_data;
> > > > +     struct imx8mp_hdmi *hdmi;
> > > > +     int ret;
> > > > +
> > > > +     hdmi =3D dev_get_drvdata(dev);
> > > > +     plat_data =3D &hdmi->plat_data;
> > > > +
> > > > +     ret =3D component_bind_all(dev, plat_data);
> > >
> > > Do you really need plat_data variable?
> >
> > yes,  it is used in imx8mp_hdmi_pai_bind()
>
> Sorry for not being clear. I'm not talking about struct dw_hdmi_plat_data=
, but
> the local variable plat_data. You can use
>
> ret =3D component_bind_all(dev, &hdmi->plat_data);
>
> directly.

Ok,  will update the code.

>
> >
> > >
> > > > +     if (ret)
> > > > +             return dev_err_probe(dev, ret, "component_bind_all fa=
iled!\n");
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static void imx8mp_dw_hdmi_unbind(struct device *dev)
> > > > +{
> > > > +     struct dw_hdmi_plat_data *plat_data;
> > > > +     struct imx8mp_hdmi *hdmi;
> > > > +
> > > > +     hdmi =3D dev_get_drvdata(dev);
> > > > +     plat_data =3D &hdmi->plat_data;
> > > > +
> > > > +     component_unbind_all(dev, plat_data);
> > >
> > > Do you really need plat_data variable?
> >
> > yes,  it is used by imx8mp_hdmi_pai_unbind()
>
> Same as above. Call
>
> component_unbind_all(dev, &hdmi->plat_data)
>
> directly. Also consider assigning struct imx8mp_hdmi *hdmi =3D dev_get_dr=
vdata(dev);
> directly.

Ok,  will update the code. Thanks.

Best regards
Shengjiu Wang
>
> Best regards,
> Alexander
>
> >
> > >
> > > > +}
> > > > +
> > > > +static const struct component_master_ops imx8mp_dw_hdmi_ops =3D {
> > > > +     .bind   =3D imx8mp_dw_hdmi_bind,
> > > > +     .unbind =3D imx8mp_dw_hdmi_unbind,
> > > > +};
> > > > +
> > > >  static int imx8mp_dw_hdmi_probe(struct platform_device *pdev)
> > > >  {
> > > >       struct device *dev =3D &pdev->dev;
> > > >       struct dw_hdmi_plat_data *plat_data;
> > > > +     struct component_match *match;
> > >
> > > Set match =3D NULL for drm_of_component_match_add (and subcalls) to a=
llocate memory.
> >
> > Ok.
> >
> > best regards
> > Shengjiu wang.
> > >
> > > Best regards
> > > Alexander
> > >
> > > > +     struct device_node *remote;
> > > >       struct imx8mp_hdmi *hdmi;
> > > > +     int ret;
> > > >
> > > >       hdmi =3D devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
> > > >       if (!hdmi)
> > > > @@ -108,6 +145,22 @@ static int imx8mp_dw_hdmi_probe(struct platfor=
m_device *pdev)
> > > >
> > > >       platform_set_drvdata(pdev, hdmi);
> > > >
> > > > +     /* port@2 is for hdmi_pai device */
> > > > +     remote =3D of_graph_get_remote_node(pdev->dev.of_node, 2, 0);
> > > > +     if (remote && of_device_is_available(remote)) {
> > > > +             drm_of_component_match_add(dev, &match, component_com=
pare_of, remote);
> > > > +
> > > > +             of_node_put(remote);
> > > > +
> > > > +             ret =3D component_master_add_with_match(dev, &imx8mp_=
dw_hdmi_ops, match);
> > > > +             if (ret)
> > > > +                     dev_warn(dev, "Unable to register aggregate d=
river\n");
> > > > +             /*
> > > > +              * This audio function is optional for avoid blocking=
 display.
> > > > +              * So just print warning message and no error is retu=
rned.
> > > > +              */
> > > > +     }
> > > > +
> > > >       return 0;
> > > >  }
> > > >
> > > > @@ -115,6 +168,8 @@ static void imx8mp_dw_hdmi_remove(struct platfo=
rm_device *pdev)
> > > >  {
> > > >       struct imx8mp_hdmi *hdmi =3D platform_get_drvdata(pdev);
> > > >
> > > > +     component_master_del(&pdev->dev, &imx8mp_dw_hdmi_ops);
> > > > +
> > > >       dw_hdmi_remove(hdmi->dw_hdmi);
> > > >  }
> > > >
> > > > diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_h=
dmi.h
> > > > index 095cdd9b7424..336f062e1f9d 100644
> > > > --- a/include/drm/bridge/dw_hdmi.h
> > > > +++ b/include/drm/bridge/dw_hdmi.h
> > > > @@ -143,6 +143,12 @@ struct dw_hdmi_plat_data {
> > > >                                          const struct drm_display_i=
nfo *info,
> > > >                                          const struct drm_display_m=
ode *mode);
> > > >
> > > > +     /*
> > > > +      * priv_audio is specially used for additional audio device t=
o get
> > > > +      * driver data through this dw_hdmi_plat_data.
> > > > +      */
> > > > +     void *priv_audio;
> > > > +
> > > >       /* Platform-specific audio enable/disable (optional) */
> > > >       void (*enable_audio)(struct dw_hdmi *hdmi, int channel,
> > > >                            int width, int rate, int non_pcm, int ie=
c958);
> > > >
> > >
> > >
> > > --
> > > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld=
, Germany
> > > Amtsgericht M=C3=BCnchen, HRB 105018
> > > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stef=
an Schneider
> > > http://www.tq-group.com/
> > >
> > >
> >
>
>
> --
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> http://www.tq-group.com/
>
>

