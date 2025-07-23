Return-Path: <linux-kernel+bounces-742025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D802B0EC10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F30189A403
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE5227605A;
	Wed, 23 Jul 2025 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2ehYKRb"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EAE272810;
	Wed, 23 Jul 2025 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256193; cv=none; b=l2gKldnkvfJqgUB0QRvwSkREvpsQUU9u1icBsKhQrYNZQ9U3ASouK2pmf/YB693AW0gDeL8hYLZhbmYv78zOjZ8dojHKa4F9rvrhWpdoUOlWf6WyotPQnNFqJYckr0SwP8vM2MV8KJky2ICeOna4HrnroDYmH8pwKGFySTeDdtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256193; c=relaxed/simple;
	bh=RL6vumOpJ1aLwcqq18JDpGv67GUN+WLHItc/6rupk8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sw9EVu6hwy5pZ5qjCLIFw6/TDbNp8uIahGwlwHahpPv1b3eJiKYKoze147I5WWFQ8kxFgDtMmSBkXpSzI2ykKwQ5ncfCdQyOt8SXvrQJ8xiKU0bz4DlRnOowMjOEVp1+XVwB7n5yiDn/d6M6ddcVMNoNs1J4cDiDyCZwsYGE9D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2ehYKRb; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e2c683524fso4457095ab.0;
        Wed, 23 Jul 2025 00:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753256191; x=1753860991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/S3cclAsN9hIgRcEo1wMY4GsJTg8hhVdaN6QhaC45E=;
        b=e2ehYKRbmT2eoMzMo7t0LyxS2ToyTio2khJkwUw7aZ5XwXiwxtAhDylHXfNHn6/tMD
         fhk0KUpBmQDfE5jOvyIgf7/zIL1Lz6GjuSbrgawGKZNVB302w0Beex35uHE9z8yCJRsN
         24cZ47sTWEzSKjpOBjlf2jns3kvO6Hh2xEZSm3++6X5ZGsoDP1QUy8hDqEqBfnYdM+wI
         OGS2WEo2YmuKS0/BlFc8d/nEL7ylAmbQY3+YQ90BRYkgDr/qQkYjzunD9a3puf0j1lQa
         BLqSaYF6Ix8gaFHRCrvUfViuH8JZ1co5U0yaM65pjKpocJa2yJrJFB/LKmBXDbDE5QH/
         ZLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753256191; x=1753860991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/S3cclAsN9hIgRcEo1wMY4GsJTg8hhVdaN6QhaC45E=;
        b=OmctEgB/n6j3DUvzfeRYmGYYBeJbxgl9Zz6WIpOjlt+BPw+CiCFXzNKpuBTz29YU+1
         T4Q7qkgIBUlU9C867JGGWJIUjRbTiFjwaASO9n58EnBfujAN5gs4vUhIAWQ7jlc6OFey
         6suQ7UrgsaUl8b5gHd0wD6l3TcYcQI6Fsir0HiUjnqDTsiBTTIpbQPumu/2eaMesclQm
         Ovgsan8446cKeOOXWk9dYE4LrFic02iSU9arczBg2t9I+9joqhvgvFuXL6LQQz6Odrn+
         mLbuYWvfLYMJ4ju7HqtX56hVlEtvpPRSpL/OeQgR8X/WKJqMESAZHBRCD825cdzi8+b1
         K81g==
X-Forwarded-Encrypted: i=1; AJvYcCXPfkVylqekOcXTliriEPBm/mF+2lOxWXQ/b0zRoyTdgQzpXNRYLWiFrQyi+S/Yhmu04odbrY/fzUz41sAt@vger.kernel.org, AJvYcCXvOy2BCSiY7Bp//Lp7tALB6qGQ9LAZZn9OoPdqJjHXWP1sKskpXYGqsl7BZi8Fx/St0WY8kBMUb5qx@vger.kernel.org
X-Gm-Message-State: AOJu0YzNNd9DvFfKmy1Z9QuWAW2eCAmzskepRCLl19FnVy6wCzgniN0Z
	5ODbRWdp7fkQ9B6eFLGHSpaxvy1LSUILIelRsIYFrhG1QKifJID7VH7TGoLMqbHSmqAdruicuub
	+evRXO1Qc7Hfls9qijLLsWGv6LxD7iwQ=
X-Gm-Gg: ASbGncsjD6oO65QiS4OrCS1NSlcMKQIceGmESnVLQXxXc1OoPlQxZ9cMsrq02TLoKfz
	WCC5oPjxsG6AJGwwyAde1dVw9AwhJIeLK4pJzF0T08j4/t5lFkV+Txb7nqe4rPbnRoomAjr1/59
	iSmbpZDp8bELgX1gZ3voZfHjP5eskWYrksywoNygdos5GsWOmWkBsCR4rMJaxKM8/NfSZCTTrS8
	/Uyv2U=
X-Google-Smtp-Source: AGHT+IHYow0XlvdEpZbbLeYgBBO2y4gBFRlSOQ97MzENf9ZWPixLLuVk3gzT14yo44EQSarqRYKCLdWkxl7mB1g6H/s=
X-Received: by 2002:a05:6e02:1a22:b0:3e2:c5de:5ff with SMTP id
 e9e14a558f8ab-3e33eabdbadmr33868505ab.3.1753256191292; Wed, 23 Jul 2025
 00:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718101150.3681002-1-shengjiu.wang@nxp.com>
 <20250718101150.3681002-2-shengjiu.wang@nxp.com> <4731eb9b-9a29-4065-8dac-06f558e78e02@nxp.com>
In-Reply-To: <4731eb9b-9a29-4065-8dac-06f558e78e02@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 23 Jul 2025 15:36:17 +0800
X-Gm-Features: Ac12FXwK3jsd_JjUkeN-4HVNavY2uEVLQxHw3AgCqwKwIWwQEHZUSbjiR65_C0c
Message-ID: <CAA+D8AOkOV0850yH+96deZ-haFSsNCw=hE+G7m+svSJBsz3c6Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/bridge: dw-hdmi: Add function to get plat_data
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
	p.zabel@pengutronix.de, devicetree@vger.kernel.org, l.stach@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 3:38=E2=80=AFPM Liu Ying <victor.liu@nxp.com> wrote=
:
>
> Hi Shengjiu,
>
> On 07/18/2025, Shengjiu Wang wrote:
> > The enable_audio() and disable_audio() callback pointers are in
> > plat_data structure, and the audio device driver needs to get plat_data
> > for assign these pointers. So add a function to export plat_data
>
> {enable,disable}_audio pointers are directly assigned to plat_data in pat=
ch 2,
> instead of using dw_hdmi_to_plat_data().  dw_hdmi_to_plat_data() is only
> used in patch 2 to get hdmi_pai pointer through pdata->priv_audio.
>
> const struct dw_hdmi_plat_data *pdata =3D dw_hdmi_to_plat_data(dw_hdmi);
> struct imx8mp_hdmi_pai *hdmi_pai =3D (struct imx8mp_hdmi_pai *)pdata->pri=
v_audio;
>

will update this commit message.

> > structure.
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
>
> Nit: Add a blank line as it was here.

will add blank line

best regards
Shengjiu Wang
>
> >  #endif /* __IMX_HDMI_H__ */
>
> --
> Regards,
> Liu Ying

