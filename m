Return-Path: <linux-kernel+bounces-757226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60083B1BF6F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C38F181C0B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0105C1E5B7E;
	Wed,  6 Aug 2025 03:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpsYm8HJ"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D343043146;
	Wed,  6 Aug 2025 03:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754452219; cv=none; b=Z59p5cKA5++JnxBPSKR+gvAJ+/HpFPje/UJAfzIfXwWTDQzs392LjqdqD1sXNbp3LCnip2l5mEuBMjq2RjJKAtJgN3sIgDC+zWMMMiLe6KF1GCkdeY/YHi+JHMbBst1nLvHd3Xox2GzbTmI2HcH7yJ7/37L50/DsVor58Nm/BLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754452219; c=relaxed/simple;
	bh=IN1Z8ZB1c3j1p8i9mF0p0zzTFXrm+j8K2pzZvSmArqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXFSJZFtKcedI3FePxZVvGQUNAyzj9CShFqmkiBhGVcgjJ8/yck74XCdHm1Y8MMJ1IkszcFnzEadMyRCzZezpxO/shyFI5lIQTqFA4s8d2DJ7Qgn/35IRwEd3UxL7vdZET4eiwMOo3hjk0aYroV0eRHjSqFVl69aYhrXad+kyqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpsYm8HJ; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-880f82dfc7fso307600739f.2;
        Tue, 05 Aug 2025 20:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754452217; x=1755057017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3i5QRO+5MfhCKu77ANJ3jBdCFtUPuCB3IIfNSEzuAM=;
        b=QpsYm8HJT0mSZ7/eoUljRHMrdL9Igg+lixL/q5CJaCbjgjwaEwlNDq4I/l3vLwHpxw
         R2AkV8UYDMkIMXxEdy3lLtNVuwOnbU1B0OysVzXJzBgfCelwUDjJVIMgeve576vErhe5
         vaLcDzhilo6jV6xLlQjs/nFkww8lZMaVkQo29wxcOZO8g3BxhyW7KPpq/+2KmeNLe6/5
         X/GWDTWoBwzVAIKYZ+sxpU/ux2naEQAqj+uJw2LmmV1SaEtYQehU8DEfsjzFxlKwKXbM
         YFWn7ja8VKoEXBpIrI4TxIIgulxHiFBdWvzc6MWJxR3geWSlg5pq5CBw3D2cDJ8ybL7g
         pYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754452217; x=1755057017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3i5QRO+5MfhCKu77ANJ3jBdCFtUPuCB3IIfNSEzuAM=;
        b=qmBhyYoVkhOCtZKWVNZXvwYfIBwZ/ZPr1PclUYrEiAv4hW+8UrV/grfn1ZRSKbIV8I
         18HV1Dd8E3i0Kr5l+Wnzo3NHQb1CQmx35zVRns3s/Ds0CsUflHLkSwds0jgUKoCfWV8/
         PfqPH9Dp2AS3EZdHQ3q/08pMM2AeCbgZuIIASCTFusLShaCo4QSIzPgIbocT1ZcoV1rC
         jaurzM75pkjhd7Gz7j1SVgoSa8pabhOB3gduK5094xaZejTlg8n7cLvBUW0DvNBLxWjw
         794krjec8O09aF2hiWVUko/tAJG16DJ3f6iV22sHBRUOW2HBnLWKkqExWZ3TJmGWMFXe
         vKxw==
X-Forwarded-Encrypted: i=1; AJvYcCUTsOpS/5eT6714T8GiCZxyqSGAeTSU74f0lgyyFnC14FK8kwwzRaWnP+uTrz9R4QxiI1viOYNeYTs2NSwL@vger.kernel.org, AJvYcCUenfN3zfZuCLR8057cDXCClfy75r9ac5YfO1yLgnyhfdTze3Vq0B7qMgDL36KmBW+utjywJLOhAf+w@vger.kernel.org, AJvYcCWg1M9tbNM6s0h1lnCch7yGy5qI3LSvVfUXoO2vfkBruqqIr/jeyEWmvvTulXUhQD1QhCLAtQXwjhU0aeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXnCmVsffT/y81hgvY/g3JYDMPHZJ/zuUlEXuOkxjX1DYknt1W
	N8tfkFPwGOdNHBrG+GNoQLntRc0XCYLbLS4z+g5T/KI+G9RR7gKIGzvMPZCUM7AsAgjYrwy8E2Q
	9+nrsq+dkKGJEjrDObFk/Gbr1ey/P5zM=
X-Gm-Gg: ASbGncsMUiNo4crTtT/TJ14lzYp0eS176QZ7Lsm1vz/FMaMR59ybhrEytMPsfineBpM
	c1hK7UNpruTvCws9MCRH16+8L5WblINjPJxO0uepwmGf98OxXfkNzvBvzPbc2CvjcuurprOWSa5
	HlWKmZdhfPLpwe81a4NgJ2B9R+EUzmuBG+XAYyt1AKG6wOY+Y4Emf1odDR1YB8SkpWOxw+yoleX
	SKbd24=
X-Google-Smtp-Source: AGHT+IFCQESUgdKuGOqs444QSzygbhrbLJwY9iG/XD2Q5CtWib3hxKckGgR3Hyw/Y4VQLjfx/NuyfuaWMxWrok5dFkc=
X-Received: by 2002:a05:6602:2b07:b0:881:7e3a:4a37 with SMTP id
 ca18e2360f4ac-8819f065f0bmr265326839f.6.1754452216814; Tue, 05 Aug 2025
 20:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804104722.601440-1-shengjiu.wang@nxp.com>
 <20250804104722.601440-7-shengjiu.wang@nxp.com> <1932645.tdWV9SEqCh@steina-w>
In-Reply-To: <1932645.tdWV9SEqCh@steina-w>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 6 Aug 2025 11:49:57 +0800
X-Gm-Features: Ac12FXyh9zIEFgIR4jwpAfqlHLcCdIoWysUI9X5TL5LXhlIGHinLI0hUpNeMIog
Message-ID: <CAA+D8AM7hEcyVaZF7MHN-jY_NOS+cdhrXGdTXeQ48-WV=bnLMA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] arm64: dts: imx8mp: Add hdmi parallel audio
 interface node
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

On Tue, Aug 5, 2025 at 3:10=E2=80=AFPM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Am Montag, 4. August 2025, 12:47:22 CEST schrieb Shengjiu Wang:
> > The HDMI TX Parallel Audio Interface (HTX_PAI) is a bridge between the
> > Audio Subsystem to the HDMI TX Controller.
> >
> > Shrink register map size of hdmi_pvi to avoid overlapped hdmi_pai devic=
e.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp-evk.dts |  4 +++
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi    | 28 +++++++++++++++++++-
>
> Please separate commits for SoC and board files. Thanks

Ok.

Best regards
Shengjiu Wang
>
> Best regards,
> Alexander
>
> >  2 files changed, 31 insertions(+), 1 deletion(-)
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
> > index 841d155685ee..00d8474bd1b1 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -2066,7 +2066,7 @@ irqsteer_hdmi: interrupt-controller@32fc2000 {
> >
> >                       hdmi_pvi: display-bridge@32fc4000 {
> >                               compatible =3D "fsl,imx8mp-hdmi-pvi";
> > -                             reg =3D <0x32fc4000 0x1000>;
> > +                             reg =3D <0x32fc4000 0x800>;
> >                               interrupt-parent =3D <&irqsteer_hdmi>;
> >                               interrupts =3D <12>;
> >                               power-domains =3D <&hdmi_blk_ctrl IMX8MP_=
HDMIBLK_PD_PVI>;
> > @@ -2092,6 +2092,24 @@ pvi_to_hdmi_tx: endpoint {
> >                               };
> >                       };
> >
> > +                     hdmi_pai: audio-bridge@32fc4800 {
> > +                             compatible =3D "fsl,imx8mp-hdmi-pai";
> > +                             reg =3D <0x32fc4800 0x800>;
> > +                             interrupt-parent =3D <&irqsteer_hdmi>;
> > +                             interrupts =3D <14>;
> > +                             clocks =3D <&clk IMX8MP_CLK_HDMI_APB>;
> > +                             clock-names =3D "apb";
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
> > @@ -2143,6 +2161,14 @@ port@1 {
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

