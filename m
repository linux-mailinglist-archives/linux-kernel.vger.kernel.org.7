Return-Path: <linux-kernel+bounces-894067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F00D8C49313
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA2354E35AD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8CF33F8BA;
	Mon, 10 Nov 2025 20:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOcnhNRO"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0786633F375
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762805357; cv=none; b=VTftfmS3oP9X8H6zXRc04l6kbXsX9VorO5lHvtrz1bI1G9OAti8mgoWfaKdwV92cOLZ1x4TVtJOKxpJSSmWHgw4r1yOyVcNvMF7rvMqMX7OwZKNqb2aoYwDns1pfDnyij0ovCjnI93We+qr1ItEGSvX8rFgkBA86wBOqPH5MCkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762805357; c=relaxed/simple;
	bh=Fc12/PvrBIndR8B2bwS9iElumVgvnnraspp7fohP1eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lhapk+XEe7Gr+On9seHXso94O2uc2j6R4b7ax5XQDqavVF1Fd0PR0rxJrvlyP9eNwv/i+51ODk+8IYYt0e2QIBt/T29hDyKJO1+E8SPHqRj475cC95Qq61025yJIg8mFfuvdkEzVkXiUVZhQedxlH8bOMe/bK1Ufb5EkTZXDgFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOcnhNRO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b3108f41fso1187494f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762805353; x=1763410153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kx/DMsheXfsMCLg+vEWvxZbWK5CKrTYS3PL9Y+pjYdA=;
        b=jOcnhNROXssdfC2RFYFuRNvXg1UeMThd62KkXo+kcX5kuwFlYWqQ7Yw+Viy/e6MqN3
         AckquExersxlDvxy3xxH+xkh7Mr8I9ZJIyEmBGknqo5E5TZsjrzLX2EHwQET/2KPPUx+
         oHUgtCKUmhyVB04EUzKIq+fEJq4uEOcNEobgdNBLIciwxo6eb0H5YFLgdvd29FAaNy+P
         LBTHgi1KlO9ei3k40VOJ6aXUCfGNtc0RDQQSJ6oSZ7t7Z4HCZYL2unLpPXA6Jgx1/5p4
         Qj9hVx2znLg7vmuLckdSKEx1b6MnnQMk0q9kwVezQcvsZ5+f6upBJZa0Ig6FwzYopGeO
         +JvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762805353; x=1763410153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kx/DMsheXfsMCLg+vEWvxZbWK5CKrTYS3PL9Y+pjYdA=;
        b=SsQ9v9XlFOk9ARYQ7Lc8PAjODC3DLbv+ZHPBSumUb+2IqGR2BsdICOoAKAe8TGYkhi
         8xV4w3+vzsyEwXCFkP+IXwp3K4msR6T29UDXJseTGDOJPinscsOYjS6zz7YlK4cy9MPp
         UB3dh6FnY4R/K+CiWI+OTmDisteFfU/dsnxdFIv3cnPSVx4PM52rL6udkTmsNQ2DEjS5
         gGefS+MF1U8VEis+PdENZuDBp36ESq51wMfWXkbECIImYolJXTjIWV+e8WFRzFQRl1Xb
         PKKjWWc4ikr56jglhkYohtC0OyGWu0mGSXo4NbLBgfLf1vumLAy/bC6ZwZRpchldGrLL
         g/cw==
X-Forwarded-Encrypted: i=1; AJvYcCVvKjMukKpLjzCGUz4BrlbRAtiarTu+o1KbSzz/1QT8k8Lh3ZbAUMz2KQ8QcI03fDkYJ/u6uSbC3p4I+m8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws5tZXMkgflX7bk1ix7bODTCeGs5UAs+5TjO1VtLxGqK2jIqPx
	JXm2axyORBnk622jDtgwtdfHXtZ8OEKsgarTTs7nU3MxMCHw6b1Q3zsF6bKdhFzbN/XSaO4iG0P
	wL8qy713dVdoINGS5UekVZ2Csxvnryls=
X-Gm-Gg: ASbGncsMmFO9YSgp2Fa5q5gFWpg6P9nyIfNmmeBXm10kSrntI/35ADPzRWSdAbPKRzK
	k6A9rnWsJEolD5ZObs/Fem+PiHzF+BjAVRpGvNnEp3XJHn4hRR+WMn3Pl/c9mp6y3ZQC5f1ljwe
	pA9Q7KrMC/8vBWT4tRauBcwt4tKxf3Yb8NNTVfo7wQ7xg3BtG5MZN2kHKwe7ugmvkvrf5uJyLln
	SOAlnxo4RL1LpFnsWqkZekGnnsJJISiHOWVYjyLwF63le4qywkSD9IQvZk3TZ0PoY61g22fwV5Q
	ff0NrB8m9gg3SN7vqBtvCIQUnVCOHg==
X-Google-Smtp-Source: AGHT+IFlYn4KFkQSyIizO8diBMDui/BV07pQfNCqUTgDlQGOdyL0HmF4jakyIcSmVMP9Fn8WSGY2xIiXKL0V5omOYII=
X-Received: by 2002:a05:6000:2109:b0:42b:3e60:189d with SMTP id
 ffacd0b85a97d-42b3e601c46mr2041495f8f.24.1762805352991; Mon, 10 Nov 2025
 12:09:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028175458.1037397-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251028175458.1037397-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdU4YTdy7zCiTyYbTY_t84q_xjjf0+XpDcyuGqB-zv6r5g@mail.gmail.com>
In-Reply-To: <CAMuHMdU4YTdy7zCiTyYbTY_t84q_xjjf0+XpDcyuGqB-zv6r5g@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 10 Nov 2025 20:08:46 +0000
X-Gm-Features: AWmQ_blSw-Bz5GnFYdwi3E_cFTFesOknzU5H16d_6ZzXlB09aokgn6pNHqxUXQQ
Message-ID: <CA+V-a8td-QKOYAG-uuu1kN9TE3ZhquQHXFDGpy-c5iDr179WvQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: renesas: rzt2h-n2h-evk: Enable
 Ethernet support
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Mon, Nov 10, 2025 at 4:16=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, 28 Oct 2025 at 18:55, Prabhakar <prabhakar.csengg@gmail.com> wrot=
e:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Enable Ethernet support on the RZ/T2H and RZ/N2H EVKs.
> >
> > Configure the MIIC converter in mode 0x6:
> >   Port 0 <-> ETHSW Port 0
> >   Port 1 <-> ETHSW Port 1
> >   Port 2 <-> GMAC2
> >   Port 3 <-> GMAC1
> >
> > Enable the ETHSS, GMAC1 and GMAC2 nodes. ETHSW support will be added
> > once the switch driver is available.
> >
> > Configure the MIIC converters to map ports according to the selected
> > switching mode, with converters 0 and 1 mapped to switch ports and
> > converters 2 and 3 mapped to GMAC ports.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> I found the mapping between GMACx, ETHy, PHYz, and board connector
> rather hard to follow.  Some suggestions for improvement are included
> below...
>
> > --- a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
> > +++ b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
> > @@ -149,7 +149,77 @@ &i2c1 {
> >         status =3D "okay";
> >  };
> >
> > +&phy2 {
> > +       /*
> > +        * PHY2 Reset Configuration:
> > +        *
> > +        * SW6[1] =3D OFF; SW6[2] =3D ON; SW6[3] =3D OFF;
> > +        * P17_5 is used as GMAC_RESETOUT2#
> > +        */
> > +       reset-gpios =3D <&pinctrl RZT2H_GPIO(17, 5) GPIO_ACTIVE_LOW>;
> > +};
> > +
> > +&phy3 {
> > +       reset-gpios =3D <&pinctrl RZT2H_GPIO(32, 3) GPIO_ACTIVE_LOW>;
> > +};
> > +
> >  &pinctrl {
> > +       /*
> > +        * ETH2 Pin Configuration:
> > +        *
> > +        * SW2[6] =3D OFF: MDC and MDIO of Ethernet port 2 are connecte=
d to GMAC2
> > +        * SW2[7] =3D ON:  Pins P29_1-P29_7, P30_0-P30_4, and P31_2-P31=
_5 are used for Ethernet port 2
>
> Please split this long line.
>
Ok, I will split it up.

> > +        */
> > +       eth2_pins: eth2-pins {
>
> Perhaps s/eth2/gmac2/, to make the mapping easier to follow?
>
Agreed.

> > +               pinmux =3D <RZT2H_PORT_PINMUX(29, 1, 0xf)>, /* ETH2_TXC=
LK */
> > +                        <RZT2H_PORT_PINMUX(29, 2, 0xf)>, /* ETH2_TXD[0=
] */
> > +                        <RZT2H_PORT_PINMUX(29, 3, 0xf)>, /* ETH2_TXD[1=
] */
> > +                        <RZT2H_PORT_PINMUX(29, 4, 0xf)>, /* ETH2_TXD[2=
] */
> > +                        <RZT2H_PORT_PINMUX(29, 5, 0xf)>, /* ETH2_TXD[3=
] */
>
> The documentation doesn't use square brackets in the signal names.
>
Ok I will drop the square brackets.

> > +                        <RZT2H_PORT_PINMUX(29, 6, 0xf)>, /* ETH2_TXEN =
*/
> > +                        <RZT2H_PORT_PINMUX(29, 7, 0xf)>, /* ETH2_RXCLK=
 */
> > +                        <RZT2H_PORT_PINMUX(30, 0, 0xf)>, /* ETH2_RXD[0=
] */
> > +                        <RZT2H_PORT_PINMUX(30, 1, 0xf)>, /* ETH2_RXD[1=
] */
> > +                        <RZT2H_PORT_PINMUX(30, 2, 0xf)>, /* ETH2_RXD[2=
] */
> > +                        <RZT2H_PORT_PINMUX(30, 3, 0xf)>, /* ETH2_RXD[3=
] */
> > +                        <RZT2H_PORT_PINMUX(30, 4, 0xf)>, /* ETH2_RXDV =
*/
> > +                        <RZT2H_PORT_PINMUX(31, 2, 0xf)>, /* ETH2_TXER =
*/
> > +                        <RZT2H_PORT_PINMUX(31, 3, 0xf)>, /* ETH2_RXER =
*/
> > +                        <RZT2H_PORT_PINMUX(31, 4, 0xf)>, /* ETH2_CRS *=
/
> > +                        <RZT2H_PORT_PINMUX(31, 5, 0xf)>, /* ETH2_COL *=
/
> > +                        <RZT2H_PORT_PINMUX(30, 5, 0x10)>, /* ETH2_MDC =
*/
> > +                        <RZT2H_PORT_PINMUX(30, 6, 0x10)>, /* ETH2_MDIO=
 */
>
> The documentation calls these GMAC2_{MDC,MDIO}.
>
Agreed, I will rename them.

> > +                        <RZT2H_PORT_PINMUX(31, 0, 0x02)>; /* ETH2_REFC=
LK */
>
> Please settle on a common convention for formatting pinmux settings:
> either use 0x2 here (no leading zero), or 0x0f in the other entries.
>
Ok, I will drop the leading zero.

> > +       };
> > +
> > +       /*
> > +        * ETH3 Pin Configuration:
> > +        *
> > +        * SW2[8] =3D ON, P27_2, P33_2-P33_7, P34_0-P34_5, P34_7 and P3=
5_0-P35_5
>
> P27_2 and P35_3-P35_5 don't seem to be muxed by SW2[8]?
>
Agreed, I will drop them (the EVK user manual had it).

> > +        * are used for Ethernet port 3
> > +        */
> > +       eth3_pins: eth3-pins {
> > +               pinmux =3D <RZT2H_PORT_PINMUX(33, 2, 0xf)>, /* ETH3_TXC=
LK */
> > +                        <RZT2H_PORT_PINMUX(33, 3, 0xf)>, /* ETH3_TXD[0=
] */
> > +                        <RZT2H_PORT_PINMUX(33, 4, 0xf)>, /* ETH3_TXD[1=
] */
> > +                        <RZT2H_PORT_PINMUX(33, 5, 0xf)>, /* ETH3_TXD[2=
] */
> > +                        <RZT2H_PORT_PINMUX(33, 6, 0xf)>, /* ETH3_TXD[3=
] */
> > +                        <RZT2H_PORT_PINMUX(33, 7, 0xf)>, /* ETH3_TXEN =
*/
> > +                        <RZT2H_PORT_PINMUX(34, 0, 0xf)>, /* ETH3_RXCLK=
 */
> > +                        <RZT2H_PORT_PINMUX(34, 1, 0xf)>, /* ETH3_RXD[0=
] */
> > +                        <RZT2H_PORT_PINMUX(34, 2, 0xf)>, /* ETH3_RXD[1=
] */
> > +                        <RZT2H_PORT_PINMUX(34, 3, 0xf)>, /* ETH3_RXD[2=
] */
> > +                        <RZT2H_PORT_PINMUX(34, 4, 0xf)>, /* ETH3_RXD[3=
] */
> > +                        <RZT2H_PORT_PINMUX(34, 5, 0xf)>, /* ETH3_RXDV =
*/
> > +                        <RZT2H_PORT_PINMUX(34, 7, 0xf)>, /* ETH3_TXER =
*/
> > +                        <RZT2H_PORT_PINMUX(35, 0, 0xf)>, /* ETH3_RXER =
*/
> > +                        <RZT2H_PORT_PINMUX(35, 1, 0xf)>, /* ETH3_CRS *=
/
> > +                        <RZT2H_PORT_PINMUX(35, 2, 0xf)>, /* ETH3_COL *=
/
> > +                        <RZT2H_PORT_PINMUX(26, 1, 0x10)>, /* ETH3_MDC =
*/
> > +                        <RZT2H_PORT_PINMUX(26, 2, 0x10)>, /* ETH3_MDIO=
 */
> > +                        <RZT2H_PORT_PINMUX(34, 6, 0x02)>; /* ETH3_REFC=
LK */
> > +       };
> > +
> >         /*
> >          * I2C0 Pin Configuration:
> >          * ------------------------
> > diff --git a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts b/a=
rch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
> > index d698b6368ee7..7ebc89bafaf1 100644
> > --- a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
> > +++ b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
> > @@ -186,7 +186,86 @@ &i2c1 {
> >         status =3D "okay";
> >  };
> >
> > +&phy2 {
> > +       /*
> > +        * PHY2 Reset Configuration:
> > +        *
> > +        * DSW8[1] =3D ON; DSW8[2] =3D OFF
> > +        * DSW12[7] =3D OFF; DSW12[8] =3D ON
> > +        * P03_1 is used as GMAC_RESETOUT2#
> > +        */
> > +       reset-gpios =3D <&pinctrl RZT2H_GPIO(3, 1) GPIO_ACTIVE_LOW>;
> > +};
> > +
> > +&phy3 {
> > +       /*
> > +        * PHY3 Reset Configuration:
> > +        *
> > +        * DSW12[5] =3D OFF; DSW12[6] =3D ON
> > +        * P03_2 is used as GMAC_RESETOUT3#
> > +        */
> > +       reset-gpios =3D <&pinctrl RZT2H_GPIO(3, 2) GPIO_ACTIVE_LOW>;
> > +};
> > +
> >  &pinctrl {
> > +       /*
> > +        * ETH2 Pin Configuration:
> > +        *
> > +        * DSW5[6] =3D OFF, P21_4-P21_5 are used for Ethernet port 2
>
> MDC and MDIO of Ethernet port 2 are connected to GMAC2
>
Ok, I will update it to `DSW5[6] OFF - connect MDC/MDIO of Ethernet
port 2 to GMAC2`.

> > +        * DSW5[7] =3D ON, P29_1-P29_7, P30_0-P30_4, P30_7, P31_2, P31_=
4
> > +        * and P31_5 are used for Ethernet port 2
> > +        */
> > +       eth2_pins: eth2-pins {
>
> Perhaps s/eth2/gmac2/, to make the mapping easier to follow?
>
Agreed.

> > +               pinmux =3D <RZT2H_PORT_PINMUX(29, 1, 0xf)>, /* ETH2_TXC=
LK */
> > +                        <RZT2H_PORT_PINMUX(29, 2, 0xf)>, /* ETH2_TXD[0=
] */
> > +                        <RZT2H_PORT_PINMUX(29, 3, 0xf)>, /* ETH2_TXD[1=
] */
> > +                        <RZT2H_PORT_PINMUX(29, 4, 0xf)>, /* ETH2_TXD[2=
] */
> > +                        <RZT2H_PORT_PINMUX(29, 5, 0xf)>, /* ETH2_TXD[3=
] */
> > +                        <RZT2H_PORT_PINMUX(29, 6, 0xf)>, /* ETH2_TXEN =
*/
> > +                        <RZT2H_PORT_PINMUX(29, 7, 0xf)>, /* ETH2_RXCLK=
 */
> > +                        <RZT2H_PORT_PINMUX(30, 0, 0xf)>, /* ETH2_RXD[0=
] */
> > +                        <RZT2H_PORT_PINMUX(30, 1, 0xf)>, /* ETH2_RXD[1=
] */
> > +                        <RZT2H_PORT_PINMUX(30, 2, 0xf)>, /* ETH2_RXD[2=
] */
> > +                        <RZT2H_PORT_PINMUX(30, 3, 0xf)>, /* ETH2_RXD[3=
] */
> > +                        <RZT2H_PORT_PINMUX(30, 4, 0xf)>, /* ETH2_RXDV =
*/
> > +                        <RZT2H_PORT_PINMUX(31, 2, 0xf)>, /* ETH2_TXER =
*/
> > +                        <RZT2H_PORT_PINMUX(31, 3, 0xf)>, /* ETH2_RXER =
*/
>
> 31, 1, 0xf
>
Agreed.

> > +                        <RZT2H_PORT_PINMUX(31, 4, 0xf)>, /* ETH2_CRS *=
/
> > +                        <RZT2H_PORT_PINMUX(31, 5, 0xf)>, /* ETH2_COL *=
/
> > +                        <RZT2H_PORT_PINMUX(30, 5, 0x10)>, /* ETH2_MDC =
*/
> > +                        <RZT2H_PORT_PINMUX(30, 6, 0x10)>, /* ETH2_MDIO=
 */
>
> The documentation calls these GMAC2_{MDC,MDIO}.
>
Agreed, I will switch to using GMACX_*.

> > +                        <RZT2H_PORT_PINMUX(31, 0, 0x02)>; /* ETH2_REFC=
LK */
>
> > +
> > +       };
> > +
> > +       /*
> > +        * ETH3 Pin Configuration:
> > +        *
> > +        * DSW5[8] =3D ON, P00_0-P00_2, P33_2-P33_7, P34_0-P34_6, are u=
sed for Ethernet port 3
> > +        * DSW12[1] =3D OFF;DSW12[2] =3D ON, P00_3 is used for Ethernet=
 port 3
> > +        */
> > +       eth3_pins: eth3-pins {
>
> Perhaps s/eth3/gmac1/, to make the mapping easier to follow?
>
Agreed.

> > +               pinmux =3D <RZT2H_PORT_PINMUX(33, 2, 0xf)>, /* ETH3_TXC=
LK */
> > +                        <RZT2H_PORT_PINMUX(33, 3, 0xf)>, /* ETH3_TXD[0=
] */
> > +                        <RZT2H_PORT_PINMUX(33, 4, 0xf)>, /* ETH3_TXD[1=
] */
> > +                        <RZT2H_PORT_PINMUX(33, 5, 0xf)>, /* ETH3_TXD[2=
] */
> > +                        <RZT2H_PORT_PINMUX(33, 6, 0xf)>, /* ETH3_TXD[3=
] */
> > +                        <RZT2H_PORT_PINMUX(33, 7, 0xf)>, /* ETH3_TXEN =
*/
> > +                        <RZT2H_PORT_PINMUX(34, 0, 0xf)>, /* ETH3_RXCLK=
 */
> > +                        <RZT2H_PORT_PINMUX(34, 1, 0xf)>, /* ETH3_RXD[0=
] */
> > +                        <RZT2H_PORT_PINMUX(34, 2, 0xf)>, /* ETH3_RXD[1=
] */
> > +                        <RZT2H_PORT_PINMUX(34, 3, 0xf)>, /* ETH3_RXD[2=
] */
> > +                        <RZT2H_PORT_PINMUX(34, 4, 0xf)>, /* ETH3_RXD[3=
] */
> > +                        <RZT2H_PORT_PINMUX(34, 5, 0xf)>, /* ETH3_RXDV =
*/
> > +                        <RZT2H_PORT_PINMUX(0, 0, 0xf)>, /* ETH3_TXER *=
/
> > +                        <RZT2H_PORT_PINMUX(0, 1, 0xf)>, /* ETH3_RXER *=
/
> > +                        <RZT2H_PORT_PINMUX(0, 2, 0xf)>, /* ETH3_CRS */
> > +                        <RZT2H_PORT_PINMUX(0, 3, 0xf)>, /* ETH3_COL */
> > +                        <RZT2H_PORT_PINMUX(26, 1, 0x10)>, /* ETH3_MDC =
*/
> > +                        <RZT2H_PORT_PINMUX(26, 2, 0x10)>, /* ETH3_MDIO=
 */
>
> The documentation calls these GMAC1_{MDC,MDIO}.
>
Agreed.

> > +                        <RZT2H_PORT_PINMUX(34, 6, 0x02)>; /* ETH3_REFC=
LK */
> > +       };
> > +
> >         /*
> >          * I2C0 Pin Configuration:
> >          * ------------------------
> > diff --git a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi b/ar=
ch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
> > index 924a38c6cb0f..c608d97586ff 100644
> > --- a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
> > @@ -7,10 +7,14 @@
> >
> >  #include <dt-bindings/gpio/gpio.h>
> >  #include <dt-bindings/leds/common.h>
> > +#include <dt-bindings/net/mscc-phy-vsc8531.h>
> > +#include <dt-bindings/net/renesas,r9a09g077-pcs-miic.h>
> >  #include <dt-bindings/pinctrl/renesas,r9a09g077-pinctrl.h>
> >
> >  / {
> >         aliases {
> > +               ethernet0 =3D &gmac1;
>
> Is this the port labeled "Ethernet(ETH3) Connector" in the Board's
> User Manual?  Shouldn't that be "ethernet3"?
>
Yes this is labeled as ETH3, so I will update it to "ethernet3".

> > +               ethernet1 =3D &gmac2;
>
> Is this the port labeled "Ethernet(ETH2) Connector" in the Board's
> User Manual?  Shouldn't that be "ethernet2"?
>
Yes this is labeled as ETH2, so I will update it to "ethernet2".

> >                 i2c0 =3D &i2c0;
> >                 i2c1 =3D &i2c1;
> >                 mmc0 =3D &sdhi0;
> > @@ -70,10 +74,34 @@ &ehci {
> >         status =3D "okay";
> >  };
> >
> > +&ethss {
> > +       status =3D "okay";
> > +
> > +       renesas,miic-switch-portin =3D <ETHSS_GMAC0_PORT>;
> > +};
> > +
> >  &extal_clk {
> >         clock-frequency =3D <25000000>;
> >  };
> >
> > +&gmac1 {
> > +       pinctrl-0 =3D <&eth3_pins>;
> > +       pinctrl-names =3D "default";
> > +       phy-handle =3D <&phy3>;
> > +       phy-mode =3D "rgmii-id";
> > +       pcs-handle =3D <&mii_conv3>;
> > +       status =3D "okay";
> > +};
> > +
> > +&gmac2 {
> > +       pinctrl-0 =3D <&eth2_pins>;
> > +       pinctrl-names =3D "default";
> > +       phy-handle =3D <&phy2>;
> > +       phy-mode =3D "rgmii-id";
> > +       pcs-handle =3D <&mii_conv2>;
> > +       status =3D "okay";
> > +};
> > +
> >  &hsusb {
> >         dr_mode =3D "otg";
> >         status =3D "okay";
> > @@ -87,6 +115,48 @@ eeprom: eeprom@50 {
> >         };
> >  };
> >
> > +&mdio1 {
> > +       phy3: ethernet-phy@3 {
>
> Ah, the "3" corresponds to the PHY address in this mdio node...
> Perhaps "mdio1_phy", to make it easier to match mdio and phy nodes?
>
Ok, I will use "mdio1_phy" for clarity.

> > +               compatible =3D "ethernet-phy-id0007.0772", "ethernet-ph=
y-ieee802.3-c22";
> > +               reg =3D <3>;
> > +               vsc8531,led-0-mode =3D <VSC8531_LINK_ACTIVITY>;
>
> VSC8531_ACTIVITY?
>
Agreed.

> > +               vsc8531,led-1-mode =3D <VSC8531_LINK_ACTIVITY>;
> > +               reset-assert-us =3D <2000>;
> > +               reset-deassert-us =3D <15000>;
> > +       };
> > +};
> > +
> > +&mdio2 {
> > +       phy2: ethernet-phy@2 {
>
> mdio2_phy?
>
OK.

> > +               compatible =3D "ethernet-phy-id0007.0772", "ethernet-ph=
y-ieee802.3-c22";
> > +               reg =3D <2>;
> > +               vsc8531,led-0-mode =3D <VSC8531_LINK_ACTIVITY>;
>
> VSC8531_ACTIVITY?
>
OK.

Cheers,
Prabhakar

