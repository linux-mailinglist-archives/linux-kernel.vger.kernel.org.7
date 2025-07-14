Return-Path: <linux-kernel+bounces-729543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169C7B03834
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F60C17A6C8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042662367C9;
	Mon, 14 Jul 2025 07:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVyrqr8T"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC641236437;
	Mon, 14 Jul 2025 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752478966; cv=none; b=WQYMBpyUmZxXfLn5G71OaRgkhaND0l2cOzLqaEG5qS/ThlVoluDk/fB47D0F3LV8qZxatK8pN3wzjRmW4HMCbZsUPaNC/pOa765bxArn45jWlYgvxVpd5x+/rYsLbV89nNquoZIlxcw1v9TEL2Q0Jm76d/8liFnj1rnTEgTpIyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752478966; c=relaxed/simple;
	bh=eWia2UkPrvUokMnRey4zXv1uHG9foT9q3rzmVi/o7eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yn7xkiZFO4IujNRrgNLjDv41QL5FO+FSHL0RZ3obOxkRUGKIRLFApbwrisrnSI/4VeGiVmGxebxCASPBkPARb8ZQSOCRnuRv/UY2/RSb6yhqIDsTj7ia8euA6M95gFo/FLRlyk1MwwU5XbDZ8vMFl8jZNF92dz1qQhSsMhcmZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVyrqr8T; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45619d70c72so4018975e9.0;
        Mon, 14 Jul 2025 00:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752478962; x=1753083762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnPDzK8frCWGXvDsaAvTU40Ec/UUh2JEKTo0kvGnCWY=;
        b=IVyrqr8TKXykw15qYEyKiMJwhyTUG1Fb97UeNq9Ql8ewCjViV50KBN8J+fDtdfKY81
         4svULBb1wJc2mVzppnWHTVcTPSFpBghVW0+P2FVW4FaVtT9JTsiY/r3SwKr2Fe+uPOxw
         7y6hend1PXuNo5l7h3pXgZopMQ4IL/BjW3oO/nkJhsvH66vAApFoomP2IRyd1lSgcoFH
         TNjGjs8a8mhtaQmG0YJoscHoVvAwDM1UJ3vruuLlbiTdUvs84OmTJBomTci43StTN9BO
         DFXgp0OcYgKcPO1r7BGNVdSPAehjTZmrRHPVJR1N6sMSUxOJTRBo8JI5ED5GPJ/+WUnu
         s38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752478962; x=1753083762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnPDzK8frCWGXvDsaAvTU40Ec/UUh2JEKTo0kvGnCWY=;
        b=lvS8fkjez52QlRstmm0SJG2bX100cBsJIRzVTP6MePCF9S2WZkpTh0uIaebBvwXeow
         eUB9byMzEVX8J4GyVezbSM/FCbVza7kUYjQ8fIhOWNJpc/O/neGRxTaLCYA2L7GtVh58
         wu+BdzZM7qZhf0i9U3DvB6YP2o+iUzEN/krHUkYgMRajLhsr/fzUrGwjKifX/ZJ7Y0kU
         H1ukuM1YByMt2pXwgv4smYXFkrblOda/KbCrPIq+J1tVbvzOPDWmuB1XKGUcmjTPPAc9
         ukQXbLugBNK3MfXwWf+1DnRvLfruiEJvoGqgt1nYQUGZqeT18oRO3te2YNNXFbUXLMZ9
         1Big==
X-Forwarded-Encrypted: i=1; AJvYcCVBdbotBMPvzX8h5VzFOVaPcmMETl6buzUhwb4i8N5Ry7lQ9rk3I53lOx2EJ2p6DbjB58ShR1/28ywp5phD@vger.kernel.org, AJvYcCXYqe4BiL2GNvxXL906evecjUZABCv552xD1y1D5O9TCeyvtmFggfcbRd+EeUXSjm9UqIFWWQ+FfzDJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwVx1NvslZrllpyWCpGvF0pRnaaRowUILMmL9FqEKJrvYuBrhRr
	5VGxqMvRJASg2k07LC9pOE2qJiNpuRhz6Pvf0I52+kRGqH1/7MotFHXUH5Ky4GN+J6OQfiXodrt
	lHXgvxcvSMcGnUxiyFW7/MLsUFaxqB4I=
X-Gm-Gg: ASbGncsYiDVa0P+xTwPHOFKF2ZmqEQ3N5kk52ebdMYs00E2mHAkrh/cAphIRTsRe6M/
	uly6aGUELa1f2PAcziYg6XnhodXhalY3Y6DIV5GcUr2EyiJbM7fJqIkh1L+BZQTCJIPeIeAwprf
	wcApKI1WxE/z3fW5U+WG/OUeU3grYfqt+SF4b2Wmsyquhv3mtdUQDnNaPVoddLB+FmvZhv8zkg4
	xJC6Ijf
X-Google-Smtp-Source: AGHT+IFr0JlmGJXJxmVbsVGP2sW3eyDOtlQyo45r1avQDzNNuQqbP2hfS28kpM1RpIlHRMDFFRpr+FLqRF465QdeYmA=
X-Received: by 2002:a05:600c:1c1c:b0:454:b93d:f232 with SMTP id
 5b1f17b1804b1-454db88159amr145203735e9.2.1752478961980; Mon, 14 Jul 2025
 00:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526114353.12081-1-clamor95@gmail.com> <20250526114353.12081-3-clamor95@gmail.com>
 <20250619-nondescript-holistic-ostrich-6d1efc@houat> <CAPVz0n2rG+VJ5dwHmSxtzD5JtRy7p=g-gygKGUoSaECQCEkFfQ@mail.gmail.com>
 <20250619-slim-bright-warthog-77f8ed@houat> <CAPVz0n2eDciXnLOo_cEh8Hjy=hY1NW0DNRs8K5Y7d0Ey5JGbNQ@mail.gmail.com>
 <20250619-wondrous-illegal-marten-a365a7@houat>
In-Reply-To: <20250619-wondrous-illegal-marten-a365a7@houat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 14 Jul 2025 10:42:30 +0300
X-Gm-Features: Ac12FXw1K6UziSJrLMhM3EPvhkSFrT3F-DKT9ZN9SexkJ4X21fdIRvjSA7AOG5s
Message-ID: <CAPVz0n3ooaYOoT8ONyUmE3w0T4714vVMsuEg6UbohehptdD=ew@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] drm: bridge: Add support for Solomon SSD2825
 RGB/DSI bridge
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 19 =D1=87=D0=B5=D1=80=D0=B2. 2025=E2=80=AF=D1=80. =D0=BE 16:1=
3 Maxime Ripard <mripard@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Jun 19, 2025 at 03:16:34PM +0300, Svyatoslav Ryhel wrote:
> > =D1=87=D1=82, 19 =D1=87=D0=B5=D1=80=D0=B2. 2025=E2=80=AF=D1=80. =D0=BE =
15:05 Maxime Ripard <mripard@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Thu, Jun 19, 2025 at 01:17:12PM +0300, Svyatoslav Ryhel wrote:
> > > > =D1=87=D1=82, 19 =D1=87=D0=B5=D1=80=D0=B2. 2025=E2=80=AF=D1=80. =D0=
=BE 12:41 Maxime Ripard <mripard@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > > > On Mon, May 26, 2025 at 02:43:53PM +0300, Svyatoslav Ryhel wrote:
> > > > > > +static ssize_t ssd2825_dsi_host_transfer(struct mipi_dsi_host =
*host,
> > > > > > +                                      const struct mipi_dsi_ms=
g *msg)
> > > > > > +{
> > > > > > +     struct ssd2825_priv *priv =3D dsi_host_to_ssd2825(host);
> > > > > > +     struct mipi_dsi_device *dsi_dev =3D priv->output.dev;
> > > > > > +     u8 buf =3D *(u8 *)msg->tx_buf;
> > > > > > +     u16 config;
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     if (!priv->enabled) {
> > > > > > +             dev_err(priv->dev, "Bridge is not enabled\n");
> > > > > > +             return -ENODEV;
> > > > > > +     }
> > > > >
> > > > > Transfers can and should happen even when the bridge is disabled.=
 The
> > > > > hardware might not permit that, but you'll need to elaborate in t=
he
> > > > > comment about why.
> > > >
> > > > This ensures that hw was configured properly in pre_enable and sinc=
e
> > > > pre_enable is void it will not return any errors if it fails.
> > >
> > > There's no relationship between the bridge pre_enable and enable hook=
s,
> > > and the MIPI-DSI host transfer one. It's perfectly valid to call
> > > transfer if the bridge is detached or disabled.
> >
> > That is twisted logic, but ok, fine, I don't care.
>
> It's not twisted. It's perfectly valid for a panel to read its revision
> at probe time, before it registers, for example.
>
> It would happen before the panel is enabled, and before the bridge is
> enabled.
>
> > > > > > +     if (msg->rx_len) {
> > > > > > +             dev_warn(priv->dev, "MIPI rx is not supported\n")=
;
> > > > > > +             return -EOPNOTSUPP;
> > > > > > +     }
> > > > > > +
> > > > > > +     guard(mutex)(&priv->mlock);
> > > > > > +
> > > > > > +     ret =3D ssd2825_read_reg(priv, SSD2825_CONFIGURATION_REG,=
 &config);
> > > > > > +     if (ret)
> > > > > > +             return ret;
> > > > > > +
> > > > > > +     switch (msg->type) {
> > > > > > +     case MIPI_DSI_DCS_SHORT_WRITE:
> > > > > > +     case MIPI_DSI_DCS_SHORT_WRITE_PARAM:
> > > > > > +     case MIPI_DSI_DCS_LONG_WRITE:
> > > > > > +             config |=3D SSD2825_CONF_REG_DCS;
> > > > > > +             break;
> > > > > > +     case MIPI_DSI_GENERIC_SHORT_WRITE_0_PARAM:
> > > > > > +     case MIPI_DSI_GENERIC_SHORT_WRITE_1_PARAM:
> > > > > > +     case MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM:
> > > > > > +     case MIPI_DSI_GENERIC_LONG_WRITE:
> > > > > > +             config &=3D ~SSD2825_CONF_REG_DCS;
> > > > > > +             break;
> > > > > > +     case MIPI_DSI_DCS_READ:
> > > > > > +     case MIPI_DSI_GENERIC_READ_REQUEST_0_PARAM:
> > > > > > +     case MIPI_DSI_GENERIC_READ_REQUEST_1_PARAM:
> > > > > > +     case MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM:
> > > > > > +     default:
> > > > > > +             return 0;
> > > > > > +     }
> > > > > > +
> > > > > > +     ret =3D ssd2825_write_reg(priv, SSD2825_CONFIGURATION_REG=
, config);
> > > > > > +     if (ret)
> > > > > > +             return ret;
> > > > > > +
> > > > > > +     ret =3D ssd2825_write_reg(priv, SSD2825_VC_CTRL_REG, 0x00=
00);
> > > > > > +     if (ret)
> > > > > > +             return ret;
> > > > > > +
> > > > > > +     ret =3D ssd2825_write_dsi(priv, msg->tx_buf, msg->tx_len)=
;
> > > > > > +     if (ret)
> > > > > > +             return ret;
> > > > > > +
> > > > > > +     if (buf =3D=3D MIPI_DCS_SET_DISPLAY_ON) {
> > > > > > +             /*
> > > > > > +              * NOTE! This is here since it cannot be called i=
n bridge enable because
> > > > > > +              * bridge pre enable and bridge enable have no ga=
p in between.
> > > > > > +              *
> > > > > > +              * Existing framework bridge-panel seq is:
> > > > > > +              *      panel_prepare > bridge_pre_enable > bridg=
e_enable > panel_enable
> > > > > > +              *
> > > > > > +              * Using prepare_prev_first was tested, but it sw=
itches seq like this:
> > > > > > +              *      bridge_pre_enable > panel_prepare > bridg=
e_enable > panel_enable
> > > > > > +              *
> > > > > > +              * This will not work since panel hw MUST be prep=
ared before bridge is
> > > > > > +              * configured. Correct seq should be:
> > > > > > +              *      panel_prepare > bridge_pre_enable > panel=
_enable > bridge_enable
> > > > >
> > > > > Where is that requirement coming from?
> > > >
> > > > This is how my device's (LG P895) bridge-panel combo works. Panel h=
w
> > > > must be enabled before bridge, then bridge hw, then panel can send
> > > > init sequence and then bridge must complete configuration.
> > >
> > > Do you have a documentation for that DSI device?
> > >
> >
> > No
> >
> > > DSI devices typically come with requirement of the power states of th=
e
> > > lanes, that's what you want to discuss here. How we can model that in
> > > software is a discussion we need to have once we've identified what t=
he
> > > hardware needs exactly.
> > >
> > > > > panel prepare is documented as:
> > > > >
> > > > >   The .prepare() function is typically called before the display =
controller
> > > > >   starts to transmit video data.
> > > > >
> > > > >
> > > > > And video data transmission for bridges only happen at bridge_ena=
ble
> > > > > time.
> > > > >
> > > > > So, from an API PoV, all the sequences above are correct.
> > > >
> > > > There is no way ATM for this bridge to complete configuration, ther=
e
> > > > either should be a way to swap panel_enable and bridge_enable or th=
ere
> > > > should be added an additional operation like bridge_post_enable or
> > > > smth like that for cases like here when bridge has to complete
> > > > configuration after panel init seq is sent.
> > > >
> > > > > > +              * Last two functions should be swapped related t=
o existing framework.
> > > > > > +              * I am not aware about method which allows that.
> > > > > > +              *
> > > > > > +              * Once there will be such method/flag, code belo=
w should be moved into
> > > > > > +              * bridge_enable since it is basically a bridge c=
onfiguration completing
> > > > > > +              * after initial panel DSI sequence is completed.
> > > > > > +              */
> > > > >
> > > > > If there's anything to fix, we should do it before introducing th=
at
> > > > > driver.
> > > >
> > > > I just want to have a bridge my device uses to be supported by
> > > > mainline linux. I have no intention to touch any part of DRM framew=
ork
> > > > and cause instabilities, maintainers rage and hate.
> > >
> > > And I just want all drivers to behave consistently.
> > >
> >
> > Ye, sure.
> >
> > > > > > +static void ssd2825_bridge_atomic_pre_enable(struct drm_bridge=
 *bridge,
> > > > > > +                                          struct drm_atomic_st=
ate *state)
> > > > > > +{
> > > > > > +     struct ssd2825_priv *priv =3D bridge_to_ssd2825(bridge);
> > > > > > +     struct mipi_dsi_device *dsi_dev =3D priv->output.dev;
> > > > > > +     const struct drm_crtc_state *crtc_state;
> > > > > > +     const struct drm_display_mode *mode;
> > > > > > +     struct drm_connector *connector;
> > > > > > +     struct drm_crtc *crtc;
> > > > > > +     u32 input_bus_flags =3D bridge->timings->input_bus_flags;
> > > > > > +     u16 flags =3D 0, config;
> > > > > > +     u8 pixel_format;
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     if (priv->enabled)
> > > > > > +             return;
> > > > >
> > > > > What is this guarding against?
> > > >
> > > > blocks repeating ssd2825_bridge_atomic_pre_enable calls
> > >
> > > Which happens in which situation?
> > >
> > > > > > +     /* Power Sequence */
> > > > > > +     ret =3D clk_prepare_enable(priv->tx_clk);
> > > > > > +     if (ret)
> > > > > > +             dev_err(priv->dev, "error enabling tx_clk (%d)\n"=
, ret);
> > > > > > +
> > > > > > +     ret =3D regulator_bulk_enable(ARRAY_SIZE(ssd2825_supplies=
), priv->supplies);
> > > > > > +     if (ret)
> > > > > > +             dev_err(priv->dev, "error enabling regulators (%d=
)\n", ret);
> > > > > > +
> > > > > > +     usleep_range(1000, 2000);
> > > > > > +
> > > > > > +     ssd2825_hw_reset(priv);
> > > > > > +
> > > > > > +     /* Perform SW reset */
> > > > > > +     ssd2825_write_reg(priv, SSD2825_OPERATION_CTRL_REG, 0x010=
0);
> > > > > > +
> > > > > > +     /* Set pixel format */
> > > > > > +     switch (dsi_dev->format) {
> > > > > > +     case MIPI_DSI_FMT_RGB565:
> > > > > > +             pixel_format =3D 0x00;
> > > > > > +             break;
> > > > > > +     case MIPI_DSI_FMT_RGB666_PACKED:
> > > > > > +             pixel_format =3D 0x01;
> > > > > > +             break;
> > > > > > +     case MIPI_DSI_FMT_RGB666:
> > > > > > +             pixel_format =3D 0x02;
> > > > > > +             break;
> > > > > > +     case MIPI_DSI_FMT_RGB888:
> > > > > > +     default:
> > > > > > +             pixel_format =3D 0x03;
> > > > > > +             break;
> > > > > > +     }
> > > > > > +
> > > > > > +     connector =3D drm_atomic_get_new_connector_for_encoder(st=
ate, bridge->encoder);
> > > > > > +     crtc =3D drm_atomic_get_new_connector_state(state, connec=
tor)->crtc;
> > > > > > +     crtc_state =3D drm_atomic_get_new_crtc_state(state, crtc)=
;
> > > > > > +     mode =3D &crtc_state->adjusted_mode;
> > > > > > +
> > > > > > +     /* Set panel timings */
> > > > > > +     ssd2825_write_reg(priv, SSD2825_RGB_INTERFACE_CTRL_REG_1,
> > > > > > +                       ((mode->vtotal - mode->vsync_end) << 8)=
 |
> > > > > > +                       (mode->htotal - mode->hsync_end));
> > > > > > +     ssd2825_write_reg(priv, SSD2825_RGB_INTERFACE_CTRL_REG_2,
> > > > > > +                       ((mode->vtotal - mode->vsync_start) << =
8) |
> > > > > > +                       (mode->htotal - mode->hsync_start));
> > > > > > +     ssd2825_write_reg(priv, SSD2825_RGB_INTERFACE_CTRL_REG_3,
> > > > > > +                       ((mode->vsync_start - mode->vdisplay) <=
< 8) |
> > > > > > +                       (mode->hsync_start - mode->hdisplay));
> > > > > > +     ssd2825_write_reg(priv, SSD2825_RGB_INTERFACE_CTRL_REG_4,=
 mode->hdisplay);
> > > > > > +     ssd2825_write_reg(priv, SSD2825_RGB_INTERFACE_CTRL_REG_5,=
 mode->vdisplay);
> > > > > > +
> > > > > > +     if (mode->flags & DRM_MODE_FLAG_PHSYNC)
> > > > > > +             flags |=3D SSD2825_HSYNC_HIGH;
> > > > > > +
> > > > > > +     if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> > > > > > +             flags |=3D SSD2825_VSYNC_HIGH;
> > > > > > +
> > > > > > +     if (dsi_dev->mode_flags & MIPI_DSI_MODE_VIDEO)
> > > > > > +             flags |=3D SSD2825_NON_BURST_EV;
> > > > > > +
> > > > > > +     if (input_bus_flags & DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE=
)
> > > > > > +             flags |=3D SSD2825_PCKL_HIGH;
> > > > > > +
> > > > > > +     ssd2825_write_reg(priv, SSD2825_RGB_INTERFACE_CTRL_REG_6,=
 flags | pixel_format);
> > > > > > +     ssd2825_write_reg(priv, SSD2825_LANE_CONFIGURATION_REG, d=
si_dev->lanes - 1);
> > > > > > +     ssd2825_write_reg(priv, SSD2825_TEST_REG, 0x0004);
> > > > > > +
> > > > > > +     /* Call PLL configuration */
> > > > > > +     ssd2825_setup_pll(priv, mode);
> > > > > > +
> > > > > > +     usleep_range(10000, 11000);
> > > > > > +
> > > > > > +     config =3D SSD2825_CONF_REG_HS | SSD2825_CONF_REG_CKE | S=
SD2825_CONF_REG_DCS |
> > > > > > +              SSD2825_CONF_REG_ECD | SSD2825_CONF_REG_EOT;
> > > > > > +
> > > > > > +     if (dsi_dev->mode_flags & MIPI_DSI_MODE_LPM)
> > > > > > +             config &=3D ~SSD2825_CONF_REG_HS;
> > > > > > +
> > > > > > +     if (dsi_dev->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET)
> > > > > > +             config &=3D ~SSD2825_CONF_REG_EOT;
> > > > > > +
> > > > > > +     /* Initial DSI configuration register set */
> > > > > > +     ssd2825_write_reg(priv, SSD2825_CONFIGURATION_REG, config=
);
> > > > > > +     ssd2825_write_reg(priv, SSD2825_VC_CTRL_REG, 0);
> > > > > > +
> > > > > > +     priv->enabled =3D true;
> > > > > > +}
> > > > > > +
> > > > > > +static void ssd2825_bridge_atomic_enable(struct drm_bridge *br=
idge,
> > > > > > +                                      struct drm_atomic_state =
*state)
> > > > > > +{
> > > > > > +     /* placeholder */
> > > > > > +}
> > > > >
> > > > > That doesn't work with any bridge or panel that doesn't require a=
ny DCS
> > > > > command to power up, unfortunately.
> > > >
> > > > Yes that is a flaw unfortunately, if you have suggestions of fixing
> > > > this just tell me.
> > >
> > > Untangle pre_enable and enable from transfer, and in enable actually
> > > enable the bridge, and it will work just fine.
> > >
> >
> > No it will not, I have tried and panel fails cause panel hw is init in
> > pre-enable and init sequence is sent in enable, which is expected
> > logic. Yet bridge cannot complete configuration because panel enable
> > function is called AFTER bridge enable.
>
> Then I guess we're at a dead-end now, aren't we?
>

I tried to address issues that you have pointed to here in v7 version
of this patch set.
https://lore.kernel.org/lkml/20250623081504.58622-3-clamor95@gmail.com/

> Maxime

