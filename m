Return-Path: <linux-kernel+bounces-736480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDCBB09D65
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8A687BBD9B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE6A220F2B;
	Fri, 18 Jul 2025 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WH9xs0tc"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811C521C19A;
	Fri, 18 Jul 2025 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826005; cv=none; b=WW924Ey2GvPKY8u1HSPGK/YmeJNsffG+57q2HByVrPnSoctnsvrlzlkoJ2lgWu8zjxuFBetxYHvmdrW+TMEXoQH/pORDihzUAUAGMUqtwjRtVXdEZ5Sw2V2+v/eg6Ha8cfw1zR4CVJCR8mObDOSgmFGNobS7NyWaRc6drq/UN3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826005; c=relaxed/simple;
	bh=vHKy9Eu5YOu8HwZrm54A0VoUJII7CXBIo0gGClqXxxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXDO4oYgl3Wuci/+/8DPAf/OO31/5RWeF3fcSnarydEb0avc7LlAM1GuTeKTttsV+XaoNwA8/ezByuJxOlBWtsH+FWJQl+UktcY7Otnv+7CHA42aNpPT4GnKzxUZcaa6qZdTHbn5TebA31jbG/sg0mZfY4iFyqcOLA1xfWxf2g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WH9xs0tc; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-87c124eb056so20878239f.2;
        Fri, 18 Jul 2025 01:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752826002; x=1753430802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vx0q77AoxjqthF4ccMdayGHHZsrST9CpwJM5Mt74LpI=;
        b=WH9xs0tcLWVi8f3xM3B48qCyCv7K4CP6tV1/Z1M4vun6wPtwegcix8f63+ofJM/HJW
         scWvqIRCqP+gd43HR7xs/sDRw1gH3ldztJfaad25IHs2w+o6NZSNFIWxTjzOvTuGvMwX
         aFYSi48Gu0nCNp+m/U/y6Oc5NY99XY9G5IK9CkvdgwNBxmTyu9QgR3c6UKGtaKny3+Da
         91vxhP0IpVBwPzCsRGApNoWyuq3QGc1OaiSofDUy4U9V3NWO8t7fMMYmadU0qfbOtuTX
         xHF/J2bEs5CS3CnrFtP22AsB5YHyoZgzv+LnbDWxpu28dHesp3KYlePKj8bxyvSwN3Yo
         6NXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752826002; x=1753430802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vx0q77AoxjqthF4ccMdayGHHZsrST9CpwJM5Mt74LpI=;
        b=bGKhQhkc80/nxeQnfYShTpbyCT4DkctoKNGP4UlIwpNUJFZnaC/3lE3F6PLVENQFqx
         X/KSKas3ndtiQl98oOf+VlPDftmVUKOPJGmgtAZXMbfQT5SV1PpGkZNdPfqIxWBWZeYk
         KYP/UWJyyauhBA8dC7RNahy2hS6WbZoGsVKSnrZOvrS16698CS/MyjEKKmgUpHibl4WR
         pW0b2WbMBByDnJbAmy3gzB4kU2f+gyWWMvArfVA2Z4qhHcUZrKC+v90Vu/0YV4m33GJf
         6OdxHWPFx60UjsUT5L5uBBJtDrqwOENkXN7vCjEuJTD0TfJAClaswlsfsOgo4GcbFzqc
         1KSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3hKlDerdeJujTCsR6BIeATLCB9UasT71+wUi6OfkvWWJwvvm6q4+NuJSy5byLAJyIylK3V/3eb5z3@vger.kernel.org, AJvYcCXBTXHel/UruW+gVlI5PIh8zEO+XJ4LgnjD/rqXdHKx/tl3/rNv8dQMNeS2mXgMHL7aWxKtfVO7z9EULv4q@vger.kernel.org
X-Gm-Message-State: AOJu0YzRimU5HxXMOScIdflbKRwSq4lyz9SaDBT0tpM5GV6vNW+Znzsy
	A7eKjEsnzYBK4CCHnEx89BDU6QET7/xCxRrdqYdTB3L5po1UR0Cm4cXVTnMDSgRtPAuGeAP6Tyf
	16gnAOjrNxxKW9yDJovAxZgIvFcz2vv4=
X-Gm-Gg: ASbGnctR+YHXf0ieVGWkm/1lAZ2EqWo2EWWfg6fz2FY177vlHzuV5xSGOwVQuiMevH0
	FFVAtt6jr2ACs0MJr/1Qk5vDxejqSNs9o7cn+S9sscXwhLYuepxKGb2u0921otwUuibutch8Yol
	e6+y5+WDxiltRUBRq3glCzQm7KVq1fTeF80yQ19Cx3civbztWyf/nHXxXrGrWno9cFGX28sU7Vt
	8SnMMc=
X-Google-Smtp-Source: AGHT+IE7GtvrLtIVr6iZFDN2EctnHvZOIyXlxWh6MzNugLEC1QoF3JNN0biXxaa1KHAjBcNYlASQWsOf7emqcbdQTgg=
X-Received: by 2002:a05:6602:6b07:b0:861:d8ca:3587 with SMTP id
 ca18e2360f4ac-879c29170cdmr1158031539f.4.1752826002287; Fri, 18 Jul 2025
 01:06:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716061114.2405272-1-shengjiu.wang@nxp.com>
 <20250716061114.2405272-2-shengjiu.wang@nxp.com> <aHf6q9asHvmw2Zc8@lizhi-Precision-Tower-5810>
In-Reply-To: <aHf6q9asHvmw2Zc8@lizhi-Precision-Tower-5810>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 18 Jul 2025 16:06:30 +0800
X-Gm-Features: Ac12FXzO6DToRCzTYT9Ee12DWJJ77xXjVtDSkAwa86OZgA_lFa-sYoMhsihMh14
Message-ID: <CAA+D8AM_3zK5Gp0_OWzc9B-qJU9CNYvDynMH5_a-o8+4ShE6Mw@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: imx8mm-evk: support more sample rates for
 wm8524 card
To: Frank Li <Frank.li@nxp.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 3:17=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Wed, Jul 16, 2025 at 02:11:12PM +0800, Shengjiu Wang wrote:
> > The wm8524 codec is connected to the SAI interface. There are two audio
> > plls on i.MX8MM, one pll can be the clock source of 44kHz series rates,
> > another pll can be clock source of 48kHz series rates.
> >
> > Add mclk-fs property for the clock ratio, remove 'clocks' property for
> > codec that doesn't need to handle clock enablement, add
> > 'system-clock-direction-out' for clock is from cpu dai.
>
> Can you provide the reason why need such change?

As commit
17cc308b1833 ASoC: wm8524: enable constraints when sysclk is configured.
make wm8524 release the constraint when codec's sysclk is not configured
so we can configure the cpu dai's sysclk to support more rates. previously =
it
only support 48k series rates, now it can support 44k series rates.

will add these info is commit message.

>
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64=
/boot/dts/freescale/imx8mm-evk.dtsi
> > index 622caaa78eaf..ff7ca2075230 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > @@ -147,6 +147,7 @@ sound-wm8524 {
> >               simple-audio-card,format =3D "i2s";
> >               simple-audio-card,frame-master =3D <&cpudai>;
> >               simple-audio-card,bitclock-master =3D <&cpudai>;
> > +             simple-audio-card,mclk-fs =3D <256>;
>
> what's measn 256? Do you need mention in commit message?

mclk-fs is the ratio to calculate the sysclk,  sysclk =3D mclk-fs * sample =
rate.
256 is a common ratio for audio.

will add these info in commit message.

best regards
Shengjiu Wang
>
> Frank
> >               simple-audio-card,widgets =3D
> >                       "Line", "Left Line Out Jack",
> >                       "Line", "Right Line Out Jack";
> > @@ -158,11 +159,11 @@ cpudai: simple-audio-card,cpu {
> >                       sound-dai =3D <&sai3>;
> >                       dai-tdm-slot-num =3D <2>;
> >                       dai-tdm-slot-width =3D <32>;
> > +                     system-clock-direction-out;
> >               };
> >
> >               simple-audio-card,codec {
> >                       sound-dai =3D <&wm8524>;
> > -                     clocks =3D <&clk IMX8MM_CLK_SAI3_ROOT>;
> >               };
> >       };
> >
> > @@ -570,9 +571,17 @@ &sai2 {
> >  &sai3 {
> >       pinctrl-names =3D "default";
> >       pinctrl-0 =3D <&pinctrl_sai3>;
> > -     assigned-clocks =3D <&clk IMX8MM_CLK_SAI3>;
> > -     assigned-clock-parents =3D <&clk IMX8MM_AUDIO_PLL1_OUT>;
> > -     assigned-clock-rates =3D <24576000>;
> > +     assigned-clocks =3D <&clk IMX8MM_AUDIO_PLL1>,
> > +                       <&clk IMX8MM_AUDIO_PLL2>,
> > +                       <&clk IMX8MM_CLK_SAI3>;
> > +     assigned-clock-parents =3D <0>, <0>, <&clk IMX8MM_AUDIO_PLL1_OUT>=
;
> > +     assigned-clock-rates =3D <393216000>, <361267200>, <24576000>;
> > +     fsl,sai-mclk-direction-output;
> > +     clocks =3D <&clk IMX8MM_CLK_SAI3_IPG>, <&clk IMX8MM_CLK_DUMMY>,
> > +             <&clk IMX8MM_CLK_SAI3_ROOT>, <&clk IMX8MM_CLK_DUMMY>,
> > +             <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_AUDIO_PLL1_OUT>,
> > +             <&clk IMX8MM_AUDIO_PLL2_OUT>;
> > +     clock-names =3D "bus", "mclk0", "mclk1", "mclk2", "mclk3", "pll8k=
", "pll11k";
> >       status =3D "okay";
> >  };
> >
> > --
> > 2.34.1
> >

