Return-Path: <linux-kernel+bounces-738645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B6AB0BB65
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8DD1769F0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D76B205AA1;
	Mon, 21 Jul 2025 03:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Et/2JNUq"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7EA139B;
	Mon, 21 Jul 2025 03:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753068545; cv=none; b=JNH0KDQch+KhIKxk7OH8yfVrgC4yuwtVLlSGiiCZIuP9bvGxpWMBak9XX6DisUzvnMOihQw20D2zoRTz4xER4rmnmD3es1QqNSn3lE5DTmlZx3gVoL2xHnzToO/zJttnmUCea4hrU+dte0958WhpnO2AG2WKqPcNUix5O66EgJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753068545; c=relaxed/simple;
	bh=qUq5NHdmOFA7O5PdwwBHJAGMUWRewhr25IuO53b3q9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QX93WNm/Rq6SWuec41g4t5O6hhUqxCnw+Yv5JttmWk78SSkLKRdORTJu3TGH2FnqHQt+SGs+QZM3Y+4tp7+7IAY9XgwiYQKGqMIvgU5XjU38p/JSQfwJxonUsEWLh4q3v046oB+8okHmF07E5/h6Sv4SJUSu+mVkF9jPPluIeME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Et/2JNUq; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3e292dcc066so30439525ab.1;
        Sun, 20 Jul 2025 20:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753068543; x=1753673343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtsiXR0EQZlATD8N1ReRV9zk/lQTOXFRW0wcbXVZLic=;
        b=Et/2JNUqKHzlHISzX5hj68WoLobfVEnSttAvCopOtdw5PfJwBJOF7jR4tHn6MXIXgh
         OHs2LtfnmU7QGreTOtQirAgAgVJlBZ0dFxUAzjTVVBPG6j/rhCPt/0V41uoaGa+xJLCf
         qGb6XyYItV8dg9GdIde+8MHODAo9nPL8dqbzxj7bWsK619L4cm+5AFSubNScjSpCUMcG
         FzWRJymZuTFwI3OM1YNgwjhHqXEYg47u/Jw9faGNbLVsJU47frhGvPIPL8m+xvev+WYk
         UPF2cCJsYH6zUs7UEWgj44S4Ll7lKCc0mZXloNgZGz8DCpo+/ajalIOY8kQ98vE/oNt0
         jyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753068543; x=1753673343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtsiXR0EQZlATD8N1ReRV9zk/lQTOXFRW0wcbXVZLic=;
        b=I7YFp0ETSKxNmX4MJQi2YUfRFivbRnGLcqdgja5VD9rxvHCgOBVJxLypcktMHoIt/N
         YedfKKD7xDxcVh2nn+QkRBwcwn/IQ6ecH327RBwdgIyqFuN4NXliwgZ81Nb0diG0l5p2
         qYa5XYGE8kO3/ux/M0w3envnCH7eBDGsMSWZhc/9w+EcB+MA+cf9QWruXz1vXSN/oytj
         AF3I4KAJj2CpqcTqv5d1UrNoto05ocy4Fzz28w8Dn/jjGDH8HZpPSb/hqn6l5+FeUN/4
         9Stm+qIZpN+AvLUogwWKW0X8j5jMbITRlzz8jGDT5jtDw/AxMDfwxeo9aMcs0KauyzrW
         BhqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3lYu5oO4Eb1m0kS29w/RkbjD6WcmnnZSXFt2ZYFKIkGWDS0BAn4dACHc7PPors2iCdXE5OTptGGaTkpU8@vger.kernel.org, AJvYcCWJjbMYhLJdV0jX4mA6TdFj45trkiSH2MUAD8wxB0G4AamjEaGG8Mz2D52zPiG3RtoGuKzMojna7wfn@vger.kernel.org
X-Gm-Message-State: AOJu0YxjAbC+MRlI8qGX1dnMIKDZ8ZK/+MLCp26mE6CpfQeCye1xSc5J
	LqEBgEfY+PR97ITzYC2GMybeGEkGfScFvMk70RfvcBmBbqhb9xaNs1/jbdKkCsXhz+ixiUyMkaH
	iR4yCmQy3ZTSzZ239yq+gAgWP1LS5Zio=
X-Gm-Gg: ASbGncv8cWyrhi8yrooN6qhIFpezM+KMqDslXU7EHvbhfzG0PhBef8FAOnFDFmjEiSU
	rNd9+CuNx3dG3j2n1aoQ6Wu5DFaeSI6vMl5xutY7yp+intsoqLmmFV+EXwQF8Xm3KMumwdkGbRX
	oFvDifyquU2x4WWL1xZYtEBq2LbHVEofA3VPFonE6JQqfBlVBMvNwDKaJSeafpEW6WMda86wodw
	ZXapZ1j6ekXvUYSdg==
X-Google-Smtp-Source: AGHT+IETEm9xXMr77IDr6KJZdmuLlNFoj+aCrz2mROuJITSXc/2fmarCRzlGXALoW/ZTbwduUUZbV41vvElTnzhtcLQ=
X-Received: by 2002:a05:6e02:1fec:b0:3df:347f:ff3e with SMTP id
 e9e14a558f8ab-3e282d9c846mr214673475ab.7.1753068542942; Sun, 20 Jul 2025
 20:29:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718101150.3681002-1-shengjiu.wang@nxp.com>
 <20250718101150.3681002-5-shengjiu.wang@nxp.com> <aHp2jxNRPfYGUiUY@lizhi-Precision-Tower-5810>
In-Reply-To: <aHp2jxNRPfYGUiUY@lizhi-Precision-Tower-5810>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 21 Jul 2025 11:28:47 +0800
X-Gm-Features: Ac12FXxlzAFWQkaGaWWuP5cmwncPGBSTwpvgKOefFzCXa9uYxNYrdhmd2LNtgq8
Message-ID: <CAA+D8AO4+YRrsFUU3kDB_YU5WbA8Dm=+0v_NOvZ2jqg4vPjRKg@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: imx8mp: Add hdmi parallel audio interface node
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

On Sat, Jul 19, 2025 at 12:30=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, Jul 18, 2025 at 06:11:50PM +0800, Shengjiu Wang wrote:
> > The HDMI TX Parallel Audio Interface (HTX_PAI) is a digital module that
> > acts as the bridge between the Audio Subsystem to the HDMI TX Controlle=
r.
>
> Remove " a digital module that acts as the" is more straightforward.
>
> >
> > Correct the register map of hdmi_pvi, which is overlapped with the
> > hdmi_pai device.
>
> Shrink register map size of hdmi_pvi to avoid overlapped hdmi_pai device.

Ok, will update them in next version.
>
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp-evk.dts |  4 +++
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi    | 26 +++++++++++++++++++-
> >  2 files changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/=
boot/dts/freescale/imx8mp-evk.dts
> > index c0cc5611048e..cc9351a5bd65 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > @@ -442,6 +442,10 @@ &flexcan2 {
> >       status =3D "disabled";/* can2 pin conflict with pdm */
> >  };
> >
> > +&hdmi_pai {
> > +     status =3D "okay";
> > +};
> > +
> >  &hdmi_pvi {
> >       status =3D "okay";
> >  };
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boo=
t/dts/freescale/imx8mp.dtsi
> > index bb24dba7338e..6e5a41f46309 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -2063,7 +2063,7 @@ irqsteer_hdmi: interrupt-controller@32fc2000 {
> >
> >                       hdmi_pvi: display-bridge@32fc4000 {
> >                               compatible =3D "fsl,imx8mp-hdmi-pvi";
> > -                             reg =3D <0x32fc4000 0x1000>;
> > +                             reg =3D <0x32fc4000 0x800>;
> >                               interrupt-parent =3D <&irqsteer_hdmi>;
> >                               interrupts =3D <12>;
> >                               power-domains =3D <&hdmi_blk_ctrl IMX8MP_=
HDMIBLK_PD_PVI>;
> > @@ -2089,6 +2089,22 @@ pvi_to_hdmi_tx: endpoint {
> >                               };
> >                       };
> >
> > +                     hdmi_pai: hdmi@32fc4800 {
>
> commit message it is bridge device, maybe audio-bridge is good node name

Ok, will use audio-bridge.

best regards
Shengjiu Wang
>
> Frank
> > +                             compatible =3D "fsl,imx8mp-hdmi-pai";
> > +                             reg =3D <0x32fc4800 0x800>;
> > +                             interrupt-parent =3D <&irqsteer_hdmi>;
> > +                             interrupts =3D <14>;
> > +                             power-domains =3D <&hdmi_blk_ctrl IMX8MP_=
HDMIBLK_PD_PAI>;
> > +                             status =3D "disabled";
> > +
> > +                             port {
> > +
> > +                                     pai_to_hdmi_tx: endpoint {
> > +                                             remote-endpoint =3D <&hdm=
i_tx_from_pai>;
> > +                                     };
> > +                             };
> > +                     };
> > +
> >                       lcdif3: display-controller@32fc6000 {
> >                               compatible =3D "fsl,imx8mp-lcdif";
> >                               reg =3D <0x32fc6000 0x1000>;
> > @@ -2140,6 +2156,14 @@ port@1 {
> >                                               reg =3D <1>;
> >                                               /* Point endpoint to the =
HDMI connector */
> >                                       };
> > +
> > +                                     port@2 {
> > +                                             reg =3D <2>;
> > +
> > +                                             hdmi_tx_from_pai: endpoin=
t {
> > +                                                     remote-endpoint =
=3D <&pai_to_hdmi_tx>;
> > +                                             };
> > +                                     };
> >                               };
> >                       };
> >
> > --
> > 2.34.1
> >

