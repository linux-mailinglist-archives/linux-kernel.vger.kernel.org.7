Return-Path: <linux-kernel+bounces-831888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6DBB9DD02
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78224173E3C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265752E9EA7;
	Thu, 25 Sep 2025 07:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HhcXa2Ll"
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D3F2E8E13
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758784064; cv=none; b=WPQ0ZgGVqgbpn4ZWPuTSkvAkZg9mD1TXMAiZG0XUOTBgM5Me796GFQ59TBaFmJye69OdVauTGNERYcNZJq0pHGhGrMORV9InV9jtX0FlPRFNg1AmWE0+XURMkVEQo0gGSWgJUNlAXmFuxvc3twBgSHUJF5LYsHBTSG5aSuFKPZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758784064; c=relaxed/simple;
	bh=Kbtcfq5fyQYZlcBGejdCLI77Fe0u0uCO6YU/9uf+Ivc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIjQxA2Iqhi3Ci659ZEl96EantNZrJ9IVAtweF+1BcPDaD0oAAxHoJZkSHK3fEZcRTzRtssKLlNawF+xCyYJNtxk0gWNtnAuJbA3VD1CDXl5XFuPkRCwA/zXV06cRgqllLPnd8ihmcJixxGo2U/4BEh0Kpr7Y3g37S/ebYGqoT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HhcXa2Ll; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6360f986fb0so271868d50.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758784060; x=1759388860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUjZGyLU19RcwCrMKmops0qcnCk7VMqAFUtNT7ECI+o=;
        b=HhcXa2Llbllu2zSzOIePncoq/o3/fSCOmte8S/uY2RTPk9/RiDjsDw5dA1oGMUyaXH
         58TiEd1SSNJBW7CRK0aSNMSkGVKYRSUllIT9445IOMQwCuKY9P0VGcfB6EZ2NIksiXys
         KleXm4z57GW2OETykDwMQPO/DT7I+JWRfOlzqFn5S9/HWVB/ZCnX8kfkSNm8WW572ADV
         CgysOXPXba1Sb2rIXjopLd5TRfLY3Vfw/QfCvAJesb86CluiCntQezJhQmG/K8x5PVtb
         mS6/Mq33gZVgq9ntrUZQZuZH8exIQz+sp7nPl2unqwGbhmA/0z5t11wFrzA1vQvtL3pJ
         pHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758784060; x=1759388860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUjZGyLU19RcwCrMKmops0qcnCk7VMqAFUtNT7ECI+o=;
        b=nM0GrHLkJ8Wdhq8fDFCXX0phXDdV8Ed+tRbnq8ArjffoM7M++/sTZt5cJz6JhLZWee
         8CAxfquUb2UHjbtI3GczapZei58zc+HMR2HdkX/HuHAhEkzN2hzroUWd/QI+qOjhhR/g
         FVbH1fDYmywvkkgt3Ey0AKTuTU4RLRTFstRoCjcGAa22HFo6vwG5v1Ef52+PCvDyW5T8
         muv2VkjWyN6/5Dkwd+Jm7P8shpYEXiic5khVl/GHx874uuY4zNpsVtvcjp6aiPPBkukr
         EpEK8DRKhG3JfBJam/cyWoYenVcEYV6klIMg6NGKTXGu5ApLd1lKL9adISaOSUOveTXl
         nL6w==
X-Forwarded-Encrypted: i=1; AJvYcCUHpLNFUKzxZB66VmHXa8A0FpjDzBwKVccSSkbvEAG2JxynLCgm06X1zrK2RHeYWk5qmEch9Yx/nMydsjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxscrpGBl7EQl63gATBxchz+i+AW6amkS3CGsBmAvAf78qeYxE+
	gTcK2b5ooCQpkwHFF9mUD3pICSLxx9xjA3pJHt4PXcBhVThmv0BgE6GOfGv5bWCBORMHg2kuM5Q
	8H4fyGAa/L05UNGk4i9w8k2c4fCGwY4/NLZaVM3y8Vw==
X-Gm-Gg: ASbGncsj9xsImMeI6AMJzqkp4khCYnBXpwZKoseCJEJGQjdJ8jdvL0bYPl9uN6rFP4S
	PzralHGKxPP9dUn6O0uQVjKiO9VOI9DlwCevr5MXGqedADgegoX8DhGOwp0mQS/bo04CGxU1rLT
	l1InPNSjHMy1cvcsyJV451ussFG2pXRU/0BqF0vr8it9SXajoYrUrAmoZCUKVIo7Fy2VJUC+lqK
	YtSYznhE1aPpbksccs=
X-Google-Smtp-Source: AGHT+IE/1OBpeA99Fiz9qQHctTOBOmzg3ShTn+n3h2sPgqDM5viSZqLLP6KS9wKGApYeUgzJ2QakSD5Xgh2kbf5v4G8=
X-Received: by 2002:a05:690e:15d3:b0:633:bbf3:6f47 with SMTP id
 956f58d0204a3-6361a70dfe7mr1067697d50.6.1758784060255; Thu, 25 Sep 2025
 00:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-dsi-dual-panel-upstream-v3-0-6927284f1098@linaro.org>
 <20250924-dsi-dual-panel-upstream-v3-1-6927284f1098@linaro.org> <5b75dckankcx55gbm734a23rvqxdbprlus3nkvqfry7lz5ksjf@jjmfsbiwqny6>
In-Reply-To: <5b75dckankcx55gbm734a23rvqxdbprlus3nkvqfry7lz5ksjf@jjmfsbiwqny6>
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 25 Sep 2025 15:07:28 +0800
X-Gm-Features: AS18NWCK3VUPymi0j56jgt9f35ZcIhzOf9s-0_IEyrE9TQ0T232i-Rva5B1N9-o
Message-ID: <CABymUCNZmxzRaVVLU=U9QPupK0KpW_C1eqa8t_ijL6B5EdgnAw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/msm/dsi: support DSC configurations with
 slice_per_pkt > 1
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2025=E5=B9=B4=
9=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 03:10=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Sep 24, 2025 at 11:08:10PM +0800, Jun Nie wrote:
> > Some panels support multiple slice to be sent in a single DSC packet. A=
nd
>
> s/support/require/
>
> If the panel supports something, then we can omit that and send 1 slice
> as we currently do. If the panel requires multiple slices, it's
> mandatory.
>
> > this feature is a must for specific panels, such as JDI LPM026M648C. Ad=
d a
>
> A panel driver which executes this API is appreciated. Otherwise in a
> few months / years somebody will submit a patch 'field foo is not used
> by the kernel drivers, drop it'.

OK, will add a panel driver in next version.
>
> > dsc_slice_per_pkt member into struct mipi_dsi_device and support the
> > feature in msm mdss driver.
> >
> > Co-developed-by: Jonathan Marek <jonathan@marek.ca>
> > Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >  drivers/gpu/drm/msm/dsi/dsi_host.c | 25 ++++++++++---------------
> >  include/drm/drm_mipi_dsi.h         |  2 ++
> >  2 files changed, 12 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/d=
si/dsi_host.c
> > index f297e3de8c3dc4e1326e70c78c046b5a19568cef..de51cb02f267205320c5a94=
fc4188413e05907e6 100644
> > --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> > +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> > @@ -157,6 +157,7 @@ struct msm_dsi_host {
> >
> >       struct drm_display_mode *mode;
> >       struct drm_dsc_config *dsc;
> > +     unsigned int dsc_slice_per_pkt;
> >
> >       /* connected device info */
> >       unsigned int channel;
> > @@ -849,17 +850,10 @@ static void dsi_update_dsc_timing(struct msm_dsi_=
host *msm_host, bool is_cmd_mod
> >       slice_per_intf =3D dsc->slice_count;
> >
> >       total_bytes_per_intf =3D dsc->slice_chunk_size * slice_per_intf;
> > -     bytes_per_pkt =3D dsc->slice_chunk_size; /* * slice_per_pkt; */
> > +     bytes_per_pkt =3D dsc->slice_chunk_size * msm_host->dsc_slice_per=
_pkt;
> >
> >       eol_byte_num =3D total_bytes_per_intf % 3;
> > -
> > -     /*
> > -      * Typically, pkt_per_line =3D slice_per_intf * slice_per_pkt.
> > -      *
> > -      * Since the current driver only supports slice_per_pkt =3D 1,
> > -      * pkt_per_line will be equal to slice per intf for now.
> > -      */
> > -     pkt_per_line =3D slice_per_intf;
> > +     pkt_per_line =3D slice_per_intf / msm_host->dsc_slice_per_pkt;
> >
> >       if (is_cmd_mode) /* packet data type */
> >               reg =3D DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_DATATYP=
E(MIPI_DSI_DCS_LONG_WRITE);
> > @@ -1008,12 +1002,8 @@ static void dsi_timing_setup(struct msm_dsi_host=
 *msm_host, bool is_bonded_dsi)
> >               else
> >                       /*
> >                        * When DSC is enabled, WC =3D slice_chunk_size *=
 slice_per_pkt + 1.
> > -                      * Currently, the driver only supports default va=
lue of slice_per_pkt =3D 1
> > -                      *
> > -                      * TODO: Expand mipi_dsi_device struct to hold sl=
ice_per_pkt info
> > -                      *       and adjust DSC math to account for slice=
_per_pkt.
> >                        */
> > -                     wc =3D msm_host->dsc->slice_chunk_size + 1;
> > +                     wc =3D msm_host->dsc->slice_chunk_size * msm_host=
->dsc_slice_per_pkt + 1;
> >
> >               dsi_write(msm_host, REG_DSI_CMD_MDP_STREAM0_CTRL,
> >                       DSI_CMD_MDP_STREAM0_CTRL_WORD_COUNT(wc) |
> > @@ -1623,8 +1613,13 @@ static int dsi_host_attach(struct mipi_dsi_host =
*host,
> >       msm_host->lanes =3D dsi->lanes;
> >       msm_host->format =3D dsi->format;
> >       msm_host->mode_flags =3D dsi->mode_flags;
> > -     if (dsi->dsc)
> > +     if (dsi->dsc) {
> >               msm_host->dsc =3D dsi->dsc;
> > +             msm_host->dsc_slice_per_pkt =3D dsi->dsc_slice_per_pkt;
> > +             /* for backwards compatibility, assume 1 if not set */
> > +             if (!msm_host->dsc_slice_per_pkt)
> > +                     msm_host->dsc_slice_per_pkt =3D 1;
>
> msm_host->dsc_slice_per_pkt =3D dsi->dsc_slice_per_pkt ?: 1;
>
> Yes, I think it's more ideomatic.

Will add the change.
>
> > +     }
> >
> >       ret =3D dsi_dev_attach(msm_host->pdev);
> >       if (ret)
> > diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> > index 6d2c08e8110151a97620389197f1ef79c058329d..5a85ba01f402a3866b70828=
391bb417bb8dd5956 100644
> > --- a/include/drm/drm_mipi_dsi.h
> > +++ b/include/drm/drm_mipi_dsi.h
> > @@ -182,6 +182,7 @@ struct mipi_dsi_device_info {
> >   * be set to the real limits of the hardware, zero is only accepted fo=
r
> >   * legacy drivers
> >   * @dsc: panel/bridge DSC pps payload to be sent
> > + * @dsc_slice_per_pkt: number of DSC slices to be sent as in a single =
packet
>
> s/as //

Will do.
>
> >   */
> >  struct mipi_dsi_device {
> >       struct mipi_dsi_host *host;
> > @@ -196,6 +197,7 @@ struct mipi_dsi_device {
> >       unsigned long hs_rate;
> >       unsigned long lp_rate;
> >       struct drm_dsc_config *dsc;
> > +     unsigned int dsc_slice_per_pkt;
>
> Why is it a part of the DSI device config? What if a device specifies
> dsc_slice_per_pkt, but not DSC config? What are the legit boundaries for
> this field?

You are right. drm_dsc_config is better place to add the info. Thus only
panels that support DSC can convey the info to host.
>
> >  };
> >
> >  /**
> >
> > --
> > 2.34.1
> >
>
> --
> With best wishes
> Dmitry

