Return-Path: <linux-kernel+bounces-759879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C199B1E3DB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD4587A76BF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E5424A05B;
	Fri,  8 Aug 2025 07:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQkGOM3d"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB9A22FF39;
	Fri,  8 Aug 2025 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754639553; cv=none; b=CHzRVQMyXQ7yMbnFqltqA+qays1gxCPacazR8iOvia4JEb+o8+sknlQPocTIjMQZf/A4pnv5zcDETvpUe0z8FnR9eQTE7UPovO3e2KIW4sVzEt4/Z2GWUBW0VRaNoSPU9is4HJuv6Ckqn2vSa2cpp8mnkLYGyvdr9/ScNKnjNuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754639553; c=relaxed/simple;
	bh=+UKpKBJXPbL3wnkWcfRXfziVRWnH0zd+2+ceqpMBI/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muIrEWYMapaHXX60xZSIhZjTjJ2nzX4B9kcjmvWEDuEuf1/oG4ROUdTd0mKAISzZ1bPZ1z1y7WvkzGxCriOxQfMTNwx4ORWZHB42UDUgNjCYnpEmy7Tp2UsfhCSb0Sa4g5tBzcTxNKQUZ0s+DoXR+bRrw1UuBjuLkwuAgwJdzU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQkGOM3d; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3e535f13562so2628085ab.0;
        Fri, 08 Aug 2025 00:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754639551; x=1755244351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMJPXbaBPXENRr4gR3xPaKVUyoNmc5Q3jFGAdG8Wanc=;
        b=jQkGOM3duQ7QEhyEboiY6BmxVKZPlCc5aOV6HYb6ZtihsilfCXEluquBNDrlMEYNEW
         PJSl9KMlqnHJh5qibvqDWSyd6eRTlplqMFe7xCRsA2H0exI5yHZBDAap5Kdbwk6iLLbz
         BYIkgwuyef8XvghJsUJqknkb2W88R+Kl61Pi4ioZaNCMxEZBTjjfudOZRGwgfyki/tVU
         9labNX2ptQIp3bU8DO0yGyAaX99GbY6d2u7vlg0gWwd85n0Ijr6DCaRA5ItfAx7qzXDC
         MAvxw9QdzokR/FWadt4miWMm/JijrOQnxZHOWONQHWOe27ay/3ByoRJBc1+mWyc+Xql8
         l/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754639551; x=1755244351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMJPXbaBPXENRr4gR3xPaKVUyoNmc5Q3jFGAdG8Wanc=;
        b=vwkfLiLEBIH1wbgEbUKB0VdE1cnSSt3TeGVVPCp7YlQqrvYq8/SZlMq/0zf7UP4NUq
         EQonZB04wIXY2LvV0cEYPAtX2skcwmYtg7vOTfIkxZszqOzLexk3bbuO2I3BK9jOtT8Y
         FIDOkMUlzKi2FdE02YdDPp1DDrlnN+szdMlME92N8u8IrYNVXD+OrqEBngx485gc/Nxg
         UTl2DFwBYs96uzp8TooH/E5YOCzg62YIoGV96HW/7OMhAGsQ7FckIyZe1s5dBWjEo3pr
         /xDHO0jgAWvsaJEpja9XPKNUPdhWtEb8w7VdUoQg/hXAVrvf/lmhqP8OnQiZE20UTh0D
         mQOw==
X-Forwarded-Encrypted: i=1; AJvYcCUBHfesXbkmFsticX/ohKJi42CEqb9UWIQE6AddPJ1EJyfIk5frblayjGwroMGTpOACc57tteVK/0jjKYY2@vger.kernel.org, AJvYcCVMaj3i/i7CELegqXknTXJd4xySpS4xzuAQ66e/9+kS10CeJkzLcjY7XxfLb/YH8K+hPiXXQzJGGOtfjr0=@vger.kernel.org, AJvYcCXgP8N/58rhtKPqxM30awD7DBhSdDfPeFnMq9SS6YhZv0dh3yr56SckP/eAuXJElJpiS/MbYrbNEuES@vger.kernel.org
X-Gm-Message-State: AOJu0YyVpD/6Mek7uXTku+4rxDaKCXNbhDWyAu3LQyf2dZENf4HN5idF
	/mLi3kveQaVeiWXZqs+uj3uM/NfcDfLCpHhfvw9b4GJbKHptSpboZXfs5EPk8rViNoaFWaB6l/6
	ykmyH85/P08tOASHm2fKCNS+8oCfS/AE=
X-Gm-Gg: ASbGncspDCwU0Qj9AB0YVbJe3g7SVhnPDXnrcaeofVQPtaUKkMarIqrqcQrpLZ/eFZn
	fYnPOHpoLAS6HIe11X4NWAr+Sw6WhegsDQXTyNTUoyrCkh+K4UhVWMYx1YJeMzIf+U8m2/qoxfs
	kvYpIqUVNJcp70orqOCnD9GPmKxRizyEKtK9Ynh1ywqOLBQbFuMoY+wV4v0MJ68yJh5EVPlz73h
	6pgfnE=
X-Google-Smtp-Source: AGHT+IGSx/MWmNs4iG0YtuQTuuEGzoU+a805glrA7aVFmRpsmJJas6zm7UrtMxrzUkLnNImJh4LmO7qWL0oTSAGoO2Q=
X-Received: by 2002:a05:6e02:2143:b0:3e5:2aa3:e023 with SMTP id
 e9e14a558f8ab-3e5331a73famr38564065ab.18.1754639550620; Fri, 08 Aug 2025
 00:52:30 -0700 (PDT)
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
 <481c4a38-e638-49ea-88d4-765e581afca7@nxp.com> <CAA+D8AMmQo=TgaJTubLL6xRp0NV3GpeE0JKwhBjmhZjtBnBQjA@mail.gmail.com>
 <0ee5fcbc-a553-4385-b930-b1a40693add5@nxp.com>
In-Reply-To: <0ee5fcbc-a553-4385-b930-b1a40693add5@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 8 Aug 2025 15:52:16 +0800
X-Gm-Features: Ac12FXxZ7K99EU2WpMLSx8j0NsgdbwVE7AL7D4sJwRKCaSEutjkABFPrHX5i5vQ
Message-ID: <CAA+D8AO1GKF+615A8G5G6-LhfBguYOTTsPyh9i4PSf8eHC8VPg@mail.gmail.com>
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

On Fri, Aug 8, 2025 at 3:49=E2=80=AFPM Liu Ying <victor.liu@nxp.com> wrote:
>
> On 08/08/2025, Shengjiu Wang wrote:
> > On Fri, Aug 8, 2025 at 2:32=E2=80=AFPM Liu Ying <victor.liu@nxp.com> wr=
ote:
> >>
> >> On 08/07/2025, Shengjiu Wang wrote:
> >>> On Wed, Aug 6, 2025 at 2:52=E2=80=AFPM Liu Ying <victor.liu@nxp.com> =
wrote:
> >>>>
> >>>> On 08/06/2025, Shengjiu Wang wrote:
> >>>>> On Tue, Aug 5, 2025 at 4:55=E2=80=AFPM Liu Ying <victor.liu@nxp.com=
> wrote:
> >>>>>>
> >>>>>> On 08/04/2025, Shengjiu Wang wrote:
> >>>>
> >>>> [...]
> >>>>
> >>>>>>> +static int imx8mp_hdmi_pai_bind(struct device *dev, struct devic=
e *master, void *data)
> >>>>>>> +{
> >>>>>>> +     struct dw_hdmi_plat_data *plat_data =3D (struct dw_hdmi_pla=
t_data *)data;
> >>>>>>> +     struct imx8mp_hdmi_pai *hdmi_pai;
> >>>>>>> +
> >>>>>>> +     hdmi_pai =3D dev_get_drvdata(dev);
> >>>>>>> +
> >>>>>>> +     plat_data->enable_audio =3D imx8mp_hdmi_pai_enable;
> >>>>>>> +     plat_data->disable_audio =3D imx8mp_hdmi_pai_disable;
> >>>>>>> +     plat_data->priv_audio =3D hdmi_pai;
> >>>>>>> +
> >>>>>>> +     return 0;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static void imx8mp_hdmi_pai_unbind(struct device *dev, struct de=
vice *master, void *data)
> >>>>>>> +{
> >>>>>>> +     struct dw_hdmi_plat_data *plat_data =3D (struct dw_hdmi_pla=
t_data *)data;
> >>>>>>> +
> >>>>>>> +     plat_data->enable_audio =3D NULL;
> >>>>>>> +     plat_data->disable_audio =3D NULL;
> >>>>>>> +     plat_data->priv_audio =3D NULL;
> >>>>>>
> >>>>>> Do you really need to set these ptrs to NULL?
> >>>>>
> >>>>> yes.  below code in dw-hdmi.c use the pdata->enable_audio as condit=
ion.
> >>>>
> >>>> Note that this is all about tearing down components.
> >>>> If this is done properly as the below snippet of pseudo-code, then
> >>>> hdmi->{enable,disable}_audio() and pdata->{enable,disable}_audio() w=
on't be
> >>>> called after audio device is removed by dw_hdmi_remove().  So, it's =
unnecessary
> >>>> to set these pointers to NULL here.
> >>>>
> >>>> imx8mp_dw_hdmi_unbind()
> >>>> {
> >>>>    dw_hdmi_remove(); // platform_device_unregister(hdmi->audio);
> >>>>    component_unbind_all(); //imx8mp_hdmi_pai_unbind()
> >>>> }
> >>>>
> >>>> BTW, I suggest the below snippet[1] to bind components.
> >>>>
> >>>> imx8mp_dw_hdmi_bind()
> >>>> {
> >>>>    component_bind_all(); // imx8mp_hdmi_pai_bind()
> >>>>                          //   set pdata->{enable,disable}_audio
> >>>>    dw_hdmi_probe(); // hdmi->audio =3D platform_device_register_full=
(&pdevinfo);
> >>>> }
> >>>
> >>> Looks like we should use dw_hdmi_bind() here to make unbind -> bind w=
ork.
> >>
> >> I don't get your idea here.
> >>
> >> What are you trying to make work?
> >> Why dw_hdmi_probe() can't be used?
> >> How does dw_hdmi_bind() help here?
> >
> > bind() is ok.  but unbind(),  then bind() there is an issue.
> >
> >>
> >>> But can't get the encoder pointer.  the encoder pointer is from lcdif=
_drv.c,
> >>> the probe sequence of lcdif, pvi, dw_hdmi should be dw_hdmi first, th=
en pvi,
> >>> then lcdif, because current implementation in lcdif and pvi driver.
> >>
> >> We use deferral probe to make sure the probe sequence is
> >> DW_HDMI -> PVI -> LCDIF.
> >>
> >> LCDIF driver would call devm_drm_of_get_bridge() to get the next bridg=
e PVI
> >> and it defers probe if devm_drm_of_get_bridge() returns ERR_PTR(-EPROB=
E_DEFER).
> >> Same to PVI driver, it would call of_drm_find_bridge() to get the next=
 bridge
> >> DW_HDMI and defers probe if needed.
> >
> > right, probe is no problem,  but after probe,  if unbind pai, hdmi_tx,
> >  then bind
> > them again,  there is a problem,  because no one call the
> > drm_bridge_attach() again.
>
> In my mind, this is a common issue as DRM bridges are not properly detach=
ed
> and attached again.
> For now, only drm_encoder_cleanup() calls drm_bridge_detach().
>
> Anyway, this issue is not introduced by this patch series, i.e. it's alre=
ady
> there.

Ok,  thanks for clarification.

best regards
shengjiu Wang
>
> >
> >>
> >>>
> >>> Should the lcdif and pvi driver be modified to use component helper?
> >>
> >> Why should they use component helper?
> >>
> >> BTW, I've tried testing the snippets suggested by me on i.MX8MP EVK an=
d
> >> the components bind successfully:
> >
> > right, probe is no problem. but if try to unbind() then bind, there is =
issue.
>
> I don't think the DRM bridge detach/attach issue would be addressed by
> using component helper.
>
> >
> > best regards
> > shengjiu Wang
> >>
> >> cat /sys/kernel/debug/device_component/32fd8000.hdmi
> >> aggregate_device name                                            statu=
s
> >> ----------------------------------------------------------------------=
-
> >> 32fd8000.hdmi                                                     boun=
d
> >>
> >> device name                                                      statu=
s
> >> ----------------------------------------------------------------------=
-
> >> 32fc4800.audio-bridge                                             boun=
d
> >>
> >>> This seems out of the scope of this patch set.
> >>>
> >>> Best regards
> >>> Shengjiu Wang
> >>
> >> [...]
> >>
> >> --
> >> Regards,
> >> Liu Ying
>
>
> --
> Regards,
> Liu Ying

