Return-Path: <linux-kernel+bounces-738642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ABFB0BB5F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73558189775B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA6C1FE44B;
	Mon, 21 Jul 2025 03:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5SrH0Ri"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4289F4F1;
	Mon, 21 Jul 2025 03:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753068281; cv=none; b=NbgOSkgXSdvUqoAvFgcQFP6dWc14rV5b1BOgCWjxLGRe8PNiAw7sFDrZjwZqtCiBbvzVvQQ4ULO/1WMYABegxJo0hVpXlJq5nq32hJruNbLxTZbzgD2jxdA+HFBdOJI5W7aUCO6rQ4/j0SABlsYsdFEPh/eUj4KKf+e1MZGXLHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753068281; c=relaxed/simple;
	bh=gjPYILYDcX1biCFjP256A//l513CzG7FlCFqg8jOtCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZuQjxsGc+kS0xv67E120SIcfc9z5QjJo0fjDnjfB3UjL8wIhWvU6r2a/Uhy/4P1Z5w6PIQqU6V2w/aerA0fBOliRHyCcsX42TdZMZ1vIGl2VNS/nQXLcxArOrgE9b5mAfh3WNYmb0iPfMJil2VYyid9wsMyXJTOu0YCJfXPx4XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5SrH0Ri; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-87c09672708so91741139f.3;
        Sun, 20 Jul 2025 20:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753068279; x=1753673079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwI2hpcy3lcVV+QnTniw+hVEeGQWL5HMOKObyfZtgEM=;
        b=g5SrH0RiaCj7xvWo2bhzDzM3LAfLyBJyIG+mRSP4Tx3DY+2V2zKTnMZxhd3r790BJ4
         I8eNvQFEPZhpLbQJoMwwj0hdgpb3txz3JYSgvqeYuHPfvj7iAqqHARyuD9OsHozT/KkJ
         mZ5sB75dLtDV4UDzzQ13Q/XgoHNDiejFs1fJ8FHiKAzJQeRUDODsmqvT02tk3VuHi7sr
         yB7Y7BuaJKnq91soRo7q9JSqMWi2k4B0f/FuuArG3YTie84mgStuHYmDb91+3/0/L0hH
         /wI55vB1Q5V6y8VDcsj0P4jPpxeg8POjW2LzT7yMqbB3eR61mEN5B7BvnBGoBem+D5HF
         KQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753068279; x=1753673079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwI2hpcy3lcVV+QnTniw+hVEeGQWL5HMOKObyfZtgEM=;
        b=Z9k5EAZ/tfqp3JTshBU69Nd7h/wVjn1CElfWYRWrRgSNvOCryupKN/1xpkcBJ7WlZa
         cG4yomgt/WuTCBTZ356KPtO/mdlaYeyjUc+2+q4Qs6H9WMrialVaDTIpLnl5tUQPJzak
         drAS1y+wynWPa+k2L02GevSgC2DqVRlgFiqOg3B3yfC0Rug4hIfSpPl7y71595nYCmZ4
         PCYR+fh2V4/HgJK0OaeN14D29GfEhoH+9nj2so32m+/ifow7d/t0dA30NGy67JdT8Gyc
         7vtLO9+yY+Yy1jKj6/EJazpyeaE3Md/872M9EXVjHffPigbT1yo6PggLXRWyTae6NYeb
         CwBw==
X-Forwarded-Encrypted: i=1; AJvYcCVW4meHuAyR2jgF2bxkzJ/Qw1ayvw5c4C38HvA1HyYmpayRNTXT4iqpn4DvLqVzMfUxbBZcHZWClWm3PWtg@vger.kernel.org, AJvYcCWZkon0435R7CTqqpm3dmPQGiWlNg7UOo6nePLEmVrhzWpadKOT1mBgilGk0mMWbrLOrlDWaJ72F9tb@vger.kernel.org
X-Gm-Message-State: AOJu0YwvKmXJgUJWZyEFiETiu7K2IEmXemCvdt3HX3nGIudAaDasJTvB
	G0/6Z/TO4jYiQx1G28R/vR3e/HVb9p5etCN15Oz9EC1hNMk89dddw1FautDuGh+JywHmFz85Sfj
	oty1tXsw9+U1QzuHsuAh9ick0FznViRs=
X-Gm-Gg: ASbGnctS8jF4+2RSfAN0GhIDzH4UOxi9WBd6JtJmMq/cU8cmhlcVVWjMGff3UtlhWTm
	qprRVTx6L7tNml7Ijw3XY3cJAgCtVc1UdaDsVf5fjkCT0KdzJflUdBLeJFf9h0gwkGuH6ILB8uA
	PsovtF8YBs/g4RUqwtRtK8UxhzoxpRKfOb8bOFlhj8oeSDE+YgBXWLp5t0YsLpt+kKj+aKFLRSs
	3vDFfQ=
X-Google-Smtp-Source: AGHT+IEc4eCE70WDmGsnRlEEKfMnJZ+xtO+dDhCQVQfDpz+1aJdPRzDCoXXMD8/WnfPbQf13oi/XE9aCmcR1NPGUpLY=
X-Received: by 2002:a05:6e02:2582:b0:3df:2f47:dc21 with SMTP id
 e9e14a558f8ab-3e282f5547amr213949295ab.22.1753068278812; Sun, 20 Jul 2025
 20:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718101150.3681002-1-shengjiu.wang@nxp.com>
 <20250718101150.3681002-2-shengjiu.wang@nxp.com> <aHpzElP09pEOi4id@lizhi-Precision-Tower-5810>
In-Reply-To: <aHpzElP09pEOi4id@lizhi-Precision-Tower-5810>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 21 Jul 2025 11:24:23 +0800
X-Gm-Features: Ac12FXy5bUMTlHGaq7PpDN0ZSeNbIlr9FhbAx0Aren2E8HjpPRhVBNLuNDI2CRQ
Message-ID: <CAA+D8AOQ9v_qCHecfL1brXUJgpA3UjdDq-O3J9udQzp2xm3J9w@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/bridge: dw-hdmi: Add function to get plat_data
To: Frank Li <Frank.li@nxp.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org, 
	cristian.ciocaltea@collabora.com, luca.ceresoli@bootlin.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	victor.liu@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, 
	l.stach@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 12:15=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, Jul 18, 2025 at 06:11:47PM +0800, Shengjiu Wang wrote:
> > The enable_audio() and disable_audio() callback pointers are in
> > plat_data structure, and the audio device driver needs to get plat_data
> > for assign these pointers. So add a function to export plat_data
> > structure.
>
> drm/bridge: dw-hdmi: Add API dw_hdmi_to_plat_data() to get plat_data
>
> Add API dw_hdmi_to_plat_data() to fetch plat_data because audo device
> driver needs it to enabe(disable)_audio().

Thanks for comments.  will update it to the next version.

best regards
Shengjiu Wang
>
> Frank
>
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 ++++++
> >  include/drm/bridge/dw_hdmi.h              | 1 +
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/dr=
m/bridge/synopsys/dw-hdmi.c
> > index 76c6570e2a85..3dfa42178f6c 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -198,6 +198,12 @@ struct dw_hdmi {
> >       enum drm_connector_status last_connector_result;
> >  };
> >
> > +const struct dw_hdmi_plat_data *dw_hdmi_to_plat_data(struct dw_hdmi *h=
dmi)
> > +{
> > +     return hdmi->plat_data;
> > +}
> > +EXPORT_SYMBOL_GPL(dw_hdmi_to_plat_data);
> > +
> >  #define HDMI_IH_PHY_STAT0_RX_SENSE \
> >       (HDMI_IH_PHY_STAT0_RX_SENSE0 | HDMI_IH_PHY_STAT0_RX_SENSE1 | \
> >        HDMI_IH_PHY_STAT0_RX_SENSE2 | HDMI_IH_PHY_STAT0_RX_SENSE3)
> > diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.=
h
> > index 6a46baa0737c..a56a3519a22a 100644
> > --- a/include/drm/bridge/dw_hdmi.h
> > +++ b/include/drm/bridge/dw_hdmi.h
> > @@ -208,4 +208,5 @@ void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, vo=
id *data);
> >
> >  bool dw_hdmi_bus_fmt_is_420(struct dw_hdmi *hdmi);
> >
> > +const struct dw_hdmi_plat_data *dw_hdmi_to_plat_data(struct dw_hdmi *h=
dmi);
> >  #endif /* __IMX_HDMI_H__ */
> > --
> > 2.34.1
> >

