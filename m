Return-Path: <linux-kernel+bounces-853953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5E3BDD26B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDC20506C92
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA673016F9;
	Wed, 15 Oct 2025 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JfZTDgFp"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F389919F48D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760513497; cv=none; b=VuwrA0lBABajA8YawxZ+/Qx+J68tbKGRU/04VrQYdOJYCPp5bvHNEAbpoNV2qwMqmXd4CXHavBgiN6ngYC7xPwaj7GNzns4vj55ptpKu2Sl0z4JFXqkeZdu7xv14R5ZGKCp7A8lbeQN6N8phoTJVQrfWBvpIO6h/yJuRe57CiGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760513497; c=relaxed/simple;
	bh=TME/bc4C+wB1fq1hlQMiyc3eFkDhN0DfF2RzsVD5qnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwFZABkrtldR70vyf/6rUoV065asY3U523HkIC7WPMF9LLzk4kWM7yWDtNfoVPfLdLLUk84qHp1aTBc5gk0OjlnDHtp3zQawiMaj05X8FzoPdESaYp+F0s68W0RLN+IsE+UN91ICnZ/sKISky3PcKWE77awRmCuqN5vhZ5lbHrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JfZTDgFp; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3737d09d123so48035391fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760513494; x=1761118294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA/rGkqw3N7PVH4gFdLuRaD7H9TojqRrEXcECrcqYbg=;
        b=JfZTDgFpeBt/WTW7iTKYRn8gfc6CLI52GssoS5wVb3pYwgGE6qiE1XgI8L+IIwN6ll
         LrQu84PVlp0l0kmkbbWrI1zeorxdrddrDl3aZxg6ac3oYzNoocjjEMpRYhMAlJxcAggp
         PCKqRtoK7g5oakkB0UylosZumQR3gWWIFWSDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760513494; x=1761118294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XA/rGkqw3N7PVH4gFdLuRaD7H9TojqRrEXcECrcqYbg=;
        b=ubmGXJOf+VzvFCWoQnoiRDCWpCBoyaNTwgc/vgW79NrRdqbVU0E4zqzO8Xn0RBycTm
         tyn2Sb6fMjxIS9sA6ukaJiODq/hHyuUJdf+9wMNhAOtRpJOZvgQKsMVVbZG3eB7TnnJ5
         baCJmVYHLcqBrwGdzydytjC/Azpwo0xKAtqK5fWgFUGGQy/40/0wkDzgSqHxp76n8MYW
         hxWDEyeBxKXbg1+jFLgai7/y/5XSmU3yu1SEVEZ+drZmUt7OM7p7Jr8dIiF9yIhatFuK
         /kzZ/W26xwuFJWsSyw9TWxq5SyyOgvbuo1x+Tz1XVzrVbv6yoEQwlAXuwUj+/II7lfyo
         XSpg==
X-Forwarded-Encrypted: i=1; AJvYcCVh2frM/Vef2oWnlvdQsD1bkT9PNX32cUzLjWBPUzOhVG6V5ZnrtifjGebNGM9kZxVHW4MhAwqqdQMWzIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy78WkwGQcazhRXJ9iVZO0LCULJ5LgpMoQORGEj2uylRuu1Etp4
	JPgwegvyGLHDgt+Sej2sroyk/P2QCtAONiRHVPBaQQWwV6vZUQ7gvEZwRxQfBuRlyvqOgrxES7Z
	ka4Va4PkqvpP+96LVE8EZtAyQ401KB/2FZPFmmuVs
X-Gm-Gg: ASbGnctVCA71QpvV9Wy70NLyZPyrbTLb0MCoFyGfZnvJSPjYrJ0qHGVTwUdXzo0dkRC
	WTrJB6fvJGrKGwyPn55mvyhuFJQz+mLDREvayHuM22XMlId1pHDOgkUDHZuGGlj5b5bE2anOcNy
	vCXEvHX3IwZ57bM3vmzr4EF4HjTszJhxii/c39vLQURN/WYYXnmnNzkOCajVrrk7ZU4dy0zc7NB
	l/madP8FS5rTmgAjl78qYwwtHbjckWprjTIHwzvrk5ZD59Ib6mig36rt0KH/d0BtA3px6ebYhaQ
	WA==
X-Google-Smtp-Source: AGHT+IGix7SiLyiT/iVo280/TBO4WaVIjuGiYnKRmsDHJTLJH8R+MNxCQXl3EtGV1sD7rAb12vm7OwOdCHylb5Oip9A=
X-Received: by 2002:a05:651c:3608:b0:364:f7e2:3908 with SMTP id
 38308e7fff4ca-37609e0fbbcmr72211741fa.26.1760513493816; Wed, 15 Oct 2025
 00:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814092510.211672-1-wenst@chromium.org> <b20a1c7d-0da5-433b-987c-f55a5a229bed@collabora.com>
In-Reply-To: <b20a1c7d-0da5-433b-987c-f55a5a229bed@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 15 Oct 2025 15:31:22 +0800
X-Gm-Features: AS18NWDz5vKCVYo2LSqzyJIsi9qNL-WB0jpDYaeMQh-Pcz5jywfjijzblwQFm7E
Message-ID: <CAGXv+5EPd5hLSNTFYkBWPCL1Bq4CJN4R7v5ZWtoRMYSi9+TeCA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8188-geralt: Enable first SCP core
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Fei Shao <fshao@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 9:27=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 14/08/25 11:25, Chen-Yu Tsai ha scritto:
> > The first SCP core is used to drive the video decoder and encoders.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v1:
> > - Added SCP vreq pin
> > ---
> >   .../boot/dts/mediatek/mt8188-geralt.dtsi      | 25 ++++++++++++++++++=
+
> >   1 file changed, 25 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi b/arch/arm=
64/boot/dts/mediatek/mt8188-geralt.dtsi
> > index c5254ae0bb99..7fedbacdac44 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
> > @@ -164,6 +164,12 @@ reserved_memory: reserved-memory {
> >               #size-cells =3D <2>;
> >               ranges;
> >
> > +             scp_mem_reserved: memory@50000000 {
> > +                     compatible =3D "shared-dma-pool";
> > +                     reg =3D <0 0x50000000 0 0x800000>;
> > +                     no-map;
> > +             };
> > +
> >               apu_mem: memory@55000000 {
> >                       compatible =3D "shared-dma-pool";
> >                       reg =3D <0 0x55000000 0 0x1400000>;
> > @@ -1077,6 +1083,13 @@ pins-bus {
> >               };
> >       };
> >
> > +     scp_pins: scp-pins {
> > +             pins-scp-vreq {
> > +                     pinmux =3D <PINMUX_GPIO98__FUNC_O_SCP_VREQ_VAO>;
> > +                     bias-disable;
> > +             };
> > +     };
> > +
> >       spi0_pins: spi0-pins {
> >               pins-bus {
> >                       pinmux =3D <PINMUX_GPIO69__FUNC_O_SPIM0_CSB>,
> > @@ -1146,6 +1159,18 @@ &postmask0_out {
> >       remote-endpoint =3D <&dither0_in>;
> >   };
> >
> > +&scp_cluster {
> > +     status =3D "okay";
> > +};
> > +
> > +&scp_c0 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&scp_pins>;
> > +     firmware-name =3D "mediatek/mt8188/scp.img";
>
> After a (very brief) discussion with Arnd last time, turns out we decided=
 to avoid
> using the firmware-name property, including for mtk-scp.
>
> Please resend without firmware-name.
>
> P.S.: there's a patch to construct the firmware name from compatible...
> https://lore.kernel.org/r/20250911140043.190801-1-angelogioacchino.delreg=
no@collabora.com

I'm aware of the patch, but did that get merged? If not then this would
cause it to default to just /lib/firmware/scp.img?

ChenYu

> Cheers,
> Angelo
>
> > +     memory-region =3D <&scp_mem_reserved>;
> > +     status =3D "okay";
> > +};
> > +
> >   &sound {
> >       pinctrl-names =3D "aud_etdm_hp_on", "aud_etdm_hp_off",
> >                       "aud_etdm_spk_on", "aud_etdm_spk_off",
>
>

