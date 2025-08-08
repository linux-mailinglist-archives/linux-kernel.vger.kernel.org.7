Return-Path: <linux-kernel+bounces-759784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B6AB1E278
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C5C188EF42
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 06:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C19D217648;
	Fri,  8 Aug 2025 06:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Blsx2CPr"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2522C14884C;
	Fri,  8 Aug 2025 06:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754635542; cv=none; b=hCwrQlKROZgFUCaOf1X7J7OI7Gn3EXbDMFYtGrKFnG9q6SUhkF+fJI8kfsBAg4H3E6Z12WuItQ6noJan7jN30lVKm5bjFK1EgM9cVcu4+4yrLocpKTI4cjh9HEvwI0VA8Stv2HGCXOjyTdM4T740Nysr9au6i1jcNwDTAsUnY1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754635542; c=relaxed/simple;
	bh=fkDvAtV8BZIVDCieQAMgEDbm9mU+jLGHu3DvNvO2ZKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7M0qRY0djcuuYI8GwGTBGsTlfzMXd0c/TEAu+bjiDeUWVpEq0tMmQRDBu4NoVRo0xRAdhf/zDA0Ot3pxMbss5lcNEedXytmqsxvRExxIAO6IwpfwQVvxjU4asR9sl89T1ZZkZJlhI6Hrhv72sEWsSc9wBfg/gG9sE5ERpzUE+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Blsx2CPr; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3e40d006105so11346145ab.3;
        Thu, 07 Aug 2025 23:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754635540; x=1755240340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfJ96l0L79uC3QqMW/tKUozVfcbzbbqgdHMrzI/pgq0=;
        b=Blsx2CPrPLKZlHtNoKCKJ11fUpk2tqFTc4G5PMcDVeCwE/S7iUyChvaZtgetP7MVUJ
         YwYDRulSIjPOivN5cbBIozHXHy/9sFEEWu7wq3Q4rDH9OGPIV8rPTAH13Rzp0J1O21IS
         4ZmUtZFFE+9ETg1McKi0m72Ycb7chgIZnoY0YOF0ayZ9IxyTfnDWannaG0c4UGcjEGcL
         bAXiOHajupwVKPXEXFMhLm29q+t5MfdYM5GngKQ5I2ugNjqkJr3zWVN2hTP4H8XvLsmD
         69jEI+FYQBlqpKp2iEtGMBCJ4BnA6SS2QxEZqkslZ6kGYqFOIsnDytKzVJR/HMxEhWOI
         1xIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754635540; x=1755240340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfJ96l0L79uC3QqMW/tKUozVfcbzbbqgdHMrzI/pgq0=;
        b=fOveYp8mH3Uv0UfYg08ZGb5x71wD5OgOmFmmiCK/UAKI6A89AjG0vZQphNy5Qg2Twx
         KlJOUgyxZVtNx2D7rzQB+Y/FMkC6JzRlGC3sYDCxuBde42/M67u5jX93uT/RzkrcSR1S
         yN/nqrFXOR6Tkqy6SJ8cXTwrFOZyiNvgMxc/V20qLws/jC2AvrU6QzFlDEVhkyUBVMEt
         0sI3B5pPrAaHlcC6pUsFs1O2dCNeZCsaXm4WPVmFLaR1+qXnwaaeMhfwcIRxAO11/+uc
         0Hret7Z9886wpEaqHMjpn0mNivFfSQmGYT6wcAiKuF3aG0sAeP5MxOglCY0iXtVlbnSI
         d1tw==
X-Forwarded-Encrypted: i=1; AJvYcCV1D8NplORfBm+//YbeazeujZOCu5IWEqeqOBjl1mOvdi/Zv1cvUTRvrh6J3iMrSY/FF/Zrew/XA6xU2w6G@vger.kernel.org, AJvYcCV3t99jg1nH7tudZYReyyBK+KlrZD+Bhp9CeHL8VOpj1C9Cj8G7dsfnmcT4zzsL9QXpvD+WDOev36Sqq78=@vger.kernel.org, AJvYcCWVXmLdldexfsMBgQrpHkm7qBKgcPxq9WvbkJMdDoxL3sPJS64TZTXilz/wMY78Xz1a4B0TGp1HQL/O@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8s5yjFhiBTLAC04HW7XG2Pzlte8kOlUy7w2F0ZowCl2AQTp+j
	HYTB2MDBQMX76aG3iRCtG+W5FE1Ls/YzrGwE5PAo5liLuD7Dr8GX+gMH6hdGLFDhEwN6qTbabzx
	POOEHOuIfZIvgTPBTun+BP11jZ2+ZX0g=
X-Gm-Gg: ASbGncuM0M3IPV1SYxYeKzcUnMKqWsuoDIId2yyOs8mcltwcRVjaajTenPzk5c4CLoG
	t/u9Nxj1J86zHJlft32REjnrO87JTclNCfFeheFO3lQnOqnFcMm9Lc9dZ2vkY+oK9n1/ou+VMJg
	qHyLJG8USOb6sED/xBVWvwd4+OYREGu9afJ5xaEMT1dBNq0dSKx3W5+fYwS4HDuF/873wQno1M4
	Gk14ME=
X-Google-Smtp-Source: AGHT+IGltElZVlwhxw9uDPM97pmJeDSJgwVBwjLX4g172vFNLkOj72zAp9AwhEXJbpTGZUTj/wZcUv/NAwx9DgBOto4=
X-Received: by 2002:a05:6e02:1a07:b0:3e3:a49a:917b with SMTP id
 e9e14a558f8ab-3e53306e84fmr37599135ab.2.1754635540083; Thu, 07 Aug 2025
 23:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804104722.601440-1-shengjiu.wang@nxp.com>
 <20250804104722.601440-6-shengjiu.wang@nxp.com> <fa455148-a071-4433-8c9c-26add3872604@nxp.com>
 <CAA+D8AN4n0H6M_0EqX4z_37ViSCyThKbmtMgqPmipintJ8Wtwg@mail.gmail.com>
 <ba02693b-8ad2-4297-ab89-5b39d5c4315f@nxp.com> <CAA+D8AN3VzFx1g=8wyxJROw96xS2-qoVs3X4vUfFnJtUCqFj_w@mail.gmail.com>
 <481c4a38-e638-49ea-88d4-765e581afca7@nxp.com>
In-Reply-To: <481c4a38-e638-49ea-88d4-765e581afca7@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 8 Aug 2025 14:45:26 +0800
X-Gm-Features: Ac12FXwPBbMoH09jFjYWwfKVloaD-hbqz3Zq3uo6wZJ3wJC3FWnXebP2M-e4hG8
Message-ID: <CAA+D8AMmQo=TgaJTubLL6xRp0NV3GpeE0JKwhBjmhZjtBnBQjA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] drm/bridge: imx: add driver for HDMI TX Parallel
 Audio Interface
To: Liu Ying <victor.liu@nxp.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org, 
	cristian.ciocaltea@collabora.com, luca.ceresoli@bootlin.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, devicetree@vger.kernel.org, l.stach@pengutronix.de, 
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 2:32=E2=80=AFPM Liu Ying <victor.liu@nxp.com> wrote:
>
> On 08/07/2025, Shengjiu Wang wrote:
> > On Wed, Aug 6, 2025 at 2:52=E2=80=AFPM Liu Ying <victor.liu@nxp.com> wr=
ote:
> >>
> >> On 08/06/2025, Shengjiu Wang wrote:
> >>> On Tue, Aug 5, 2025 at 4:55=E2=80=AFPM Liu Ying <victor.liu@nxp.com> =
wrote:
> >>>>
> >>>> On 08/04/2025, Shengjiu Wang wrote:
> >>
> >> [...]
> >>
> >>>>> +static int imx8mp_hdmi_pai_bind(struct device *dev, struct device =
*master, void *data)
> >>>>> +{
> >>>>> +     struct dw_hdmi_plat_data *plat_data =3D (struct dw_hdmi_plat_=
data *)data;
> >>>>> +     struct imx8mp_hdmi_pai *hdmi_pai;
> >>>>> +
> >>>>> +     hdmi_pai =3D dev_get_drvdata(dev);
> >>>>> +
> >>>>> +     plat_data->enable_audio =3D imx8mp_hdmi_pai_enable;
> >>>>> +     plat_data->disable_audio =3D imx8mp_hdmi_pai_disable;
> >>>>> +     plat_data->priv_audio =3D hdmi_pai;
> >>>>> +
> >>>>> +     return 0;
> >>>>> +}
> >>>>> +
> >>>>> +static void imx8mp_hdmi_pai_unbind(struct device *dev, struct devi=
ce *master, void *data)
> >>>>> +{
> >>>>> +     struct dw_hdmi_plat_data *plat_data =3D (struct dw_hdmi_plat_=
data *)data;
> >>>>> +
> >>>>> +     plat_data->enable_audio =3D NULL;
> >>>>> +     plat_data->disable_audio =3D NULL;
> >>>>> +     plat_data->priv_audio =3D NULL;
> >>>>
> >>>> Do you really need to set these ptrs to NULL?
> >>>
> >>> yes.  below code in dw-hdmi.c use the pdata->enable_audio as conditio=
n.
> >>
> >> Note that this is all about tearing down components.
> >> If this is done properly as the below snippet of pseudo-code, then
> >> hdmi->{enable,disable}_audio() and pdata->{enable,disable}_audio() won=
't be
> >> called after audio device is removed by dw_hdmi_remove().  So, it's un=
necessary
> >> to set these pointers to NULL here.
> >>
> >> imx8mp_dw_hdmi_unbind()
> >> {
> >>    dw_hdmi_remove(); // platform_device_unregister(hdmi->audio);
> >>    component_unbind_all(); //imx8mp_hdmi_pai_unbind()
> >> }
> >>
> >> BTW, I suggest the below snippet[1] to bind components.
> >>
> >> imx8mp_dw_hdmi_bind()
> >> {
> >>    component_bind_all(); // imx8mp_hdmi_pai_bind()
> >>                          //   set pdata->{enable,disable}_audio
> >>    dw_hdmi_probe(); // hdmi->audio =3D platform_device_register_full(&=
pdevinfo);
> >> }
> >
> > Looks like we should use dw_hdmi_bind() here to make unbind -> bind wor=
k.
>
> I don't get your idea here.
>
> What are you trying to make work?
> Why dw_hdmi_probe() can't be used?
> How does dw_hdmi_bind() help here?

bind() is ok.  but unbind(),  then bind() there is an issue.

>
> > But can't get the encoder pointer.  the encoder pointer is from lcdif_d=
rv.c,
> > the probe sequence of lcdif, pvi, dw_hdmi should be dw_hdmi first, then=
 pvi,
> > then lcdif, because current implementation in lcdif and pvi driver.
>
> We use deferral probe to make sure the probe sequence is
> DW_HDMI -> PVI -> LCDIF.
>
> LCDIF driver would call devm_drm_of_get_bridge() to get the next bridge P=
VI
> and it defers probe if devm_drm_of_get_bridge() returns ERR_PTR(-EPROBE_D=
EFER).
> Same to PVI driver, it would call of_drm_find_bridge() to get the next br=
idge
> DW_HDMI and defers probe if needed.

right, probe is no problem,  but after probe,  if unbind pai, hdmi_tx,
 then bind
them again,  there is a problem,  because no one call the
drm_bridge_attach() again.

>
> >
> > Should the lcdif and pvi driver be modified to use component helper?
>
> Why should they use component helper?
>
> BTW, I've tried testing the snippets suggested by me on i.MX8MP EVK and
> the components bind successfully:

right, probe is no problem. but if try to unbind() then bind, there is issu=
e.

best regards
shengjiu Wang
>
> cat /sys/kernel/debug/device_component/32fd8000.hdmi
> aggregate_device name                                            status
> -----------------------------------------------------------------------
> 32fd8000.hdmi                                                     bound
>
> device name                                                      status
> -----------------------------------------------------------------------
> 32fc4800.audio-bridge                                             bound
>
> > This seems out of the scope of this patch set.
> >
> > Best regards
> > Shengjiu Wang
>
> [...]
>
> --
> Regards,
> Liu Ying

