Return-Path: <linux-kernel+bounces-847716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F24C7BCB7FB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 05:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027C019E3283
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85164224B0E;
	Fri, 10 Oct 2025 03:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeOWRBSK"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC0621C9E5
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760066422; cv=none; b=MisE8MlKew9NsMCwetFsIF24R5O/VRAgZ1TUsV0VyGTd+15HJjagybuPr4VhM81s1+3P+NyzQ/z9sPoxqR+8MM3i/BBOA6DL4ChWnlRi2E6AnHHQgZGD+EL9SMnuPV9QlEzBm5/OD2iDZrOkeM0DxUZHH4+Uyzh9NfM0Y9WknFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760066422; c=relaxed/simple;
	bh=Ri0MXVh9+wDkxvWMVdi2gj0/08zN30q/5e7xP75X0E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZuXG55h5yX3YLmJ34nQZ+mL3TQICszMF34AoolwpVQErLXzPbQYk0n4vodBuhkvByFq45neEvPrj3qbzdPLqdJkmCoC5QY//pbqO8jLxw09GDeeh/maqo/T8Y51Ui5cx9GvqkhHmzXroUhf7f63iFEppnpUqa6q6SFbQfH8irA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeOWRBSK; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-78ed682e9d3so14655276d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 20:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760066420; x=1760671220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmWw5+Dj1mFyUNTa6/5YxEtv7JkoN4Y3GT6P1fyCsMU=;
        b=jeOWRBSKo+hvHfD3bTOMmJX23lzgnz509XaIEoN1rkrfbVJCDZrLvh/GLvag40NzJz
         LoJgQEg3JvywxcbwNeNrPJfAOnihwdX2SRPxzqER5m+fTlWlOcwV0bkuzQW3LSgfEKnt
         vCv9KemwNPOFjNr5hCHmdY8V8frArpj5DReYCHJZqJGqeU6a7uH0zDr8P3esRhcHZZRO
         b7EWF2xoX+ogEUqPiFWWLdCGnzHnb6Y2KovqfS4RAuralWPOKIT3WgJJJLdQIExF22dc
         WmYQds+nJe5wlx0UUOTywiMh1DCUf1zJfARJeW5z/zvkOCaYhTGNJeELz/DJLhqinxv4
         BYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760066420; x=1760671220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmWw5+Dj1mFyUNTa6/5YxEtv7JkoN4Y3GT6P1fyCsMU=;
        b=RNJyeJrQKUBpwy8FVs9xM1vYxGZm/JfOkAuPDD17oMEvRkkAXGbyTolcIQNmH+qwu8
         MOZJhINSgBubNbdH35z+RFv/eotxLUCBBBvyxPsypnEPwN4fDg8kKweXtWXcN9plcB9f
         DXZvNt4zVCnYb+ew0uGQ2Ri1Cd0CnNNxeOsO3yx1hPpqQ4FqS7y60OwfdtpBOJC+DQLx
         IA4k9ol14YWoTaEeN4KXtOwbZOFUyvXoTGqYAI7FJKPQYs8n1Yx8BxRtgFL6yxCUVWjX
         fnS/Jpz0zyuPH9c0DEXNh4jGBvm1Dquxjkyzz90STeEKk+Kq8jso+ifQXGsvSfIdGcq7
         j46w==
X-Forwarded-Encrypted: i=1; AJvYcCWr0QPKXUMlHCuDBn9Rz2HM5Jk0CAXAp1hidnmX9i4LRwpoJ4O9kXaxHxM+WU2gLARqn+00bjM58FQvQD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkDkmoS6jbWTE2xTv49z4luvE6sRFD9v8vm+mespWRE6os24If
	/dcWDVVUMEFmOJF/wII2ahrLToyczkIOsKROGUy6EqOzwZY9oSMYnCTVg3ZH3rt8trXSTKRekET
	w4Gh4Pq43KziNEDUq1G36GhK5W53092I=
X-Gm-Gg: ASbGncvZTgZBZySX55NxT8auS1wn3Yg/ERjGjxuHr11+jFCNj18+s41+qNj/BOMA1Z7
	5SXBazEgDN/XmLNIPRBDe00zQrCAGL5+aZZpGBR9tyLULC/HVJhpAN7Q6Vw/+ySYNfHEvYnmYJP
	BKM804aKZ6vSm91q4ZaWKQJAfg3hoj2eKS02yFUdVHeIRwRCkhGprnK9YVjRxs6ef4KU+njSims
	blLFqX+nn0rbHYvYvjuvJFqSHG0WVUTgl0Tcg==
X-Google-Smtp-Source: AGHT+IG/f2JLTSStGduS6XZjeZ+es0r1EhO6WUkmy1NWRrK48A440J2He6YHChg8tiyLaptae0m7b+ub/wDnL1a78ak=
X-Received: by 2002:a05:6214:19cc:b0:795:67ac:ca5d with SMTP id
 6a1803df08f44-87b2109283cmr151808406d6.30.1760066420103; Thu, 09 Oct 2025
 20:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009084416.45542-1-jjm2473@gmail.com> <20251009084416.45542-4-jjm2473@gmail.com>
 <aOe_0EufouURu7R2@shell.armlinux.org.uk>
In-Reply-To: <aOe_0EufouURu7R2@shell.armlinux.org.uk>
From: Liangbin Lian <jjm2473@gmail.com>
Date: Fri, 10 Oct 2025 11:20:08 +0800
X-Gm-Features: AS18NWCmhVw11nXPu-jU8ygXHImQqmaDaGRECyqzHvDtAZ_V_270USq7PdCB0EY
Message-ID: <CAP_9mL4MfzagxiMD1VdOu=jBuN_XsOrvPQT=XTVgu2+G=+nD9A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] arm64: dts: rockchip: add LinkEase EasePi R1
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	quentin.schulz@cherry.de, kever.yang@rock-chips.com, naoki@radxa.com, 
	honyuenkwun@gmail.com, inindev@gmail.com, ivan8215145640@gmail.com, 
	neil.armstrong@linaro.org, mani@kernel.org, dsimic@manjaro.org, 
	pbrobinson@gmail.com, alchark@gmail.com, didi.debian@cknow.org, 
	jbx6244@gmail.com, andrew@lunn.ch, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Russell King (Oracle) <linux@armlinux.org.uk> =E4=BA=8E2025=E5=B9=B410=E6=
=9C=889=E6=97=A5=E5=91=A8=E5=9B=9B 21:59=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Oct 09, 2025 at 04:44:16PM +0800, Liangbin Lian wrote:
> > +&gmac0 {
> > +     phy-mode =3D "rgmii-id";
> > +     clock_in_out =3D "input";
> ...
> > +&gmac1 {
> > +     phy-mode =3D "rgmii-id";
> > +     clock_in_out =3D "input";
>
> I am fine with what is being proposed here, but I think this
> clock_in_out property needs fixing. The description for it is thus:
>
>   clock_in_out:
>     description:
>       For RGMII, it must be "input", means main clock(125MHz)
>       is not sourced from SoC's PLL, but input from PHY.
>       For RMII, "input" means PHY provides the reference clock(50MHz),
>       "output" means GMAC provides the reference clock.
>     $ref: /schemas/types.yaml#/definitions/string
>     enum: [input, output]
>     default: input
>
> The problems that I have here are:
>
> 1) the description states that the only possible value for this when in
>    RGMII mode is "input" which is reasonable, because it's due to the
>    RGMII specification. The driver code is perfectly able to determine
>    whether RGMII has been specified, and set bsp_priv->clock_input
>    itself, relieving DT of this need.
>
> 2) bsp_priv->clock_input is only used in gmac_clk_enable() when calling
>    the SoC specific set_clock_selection() method. Only RK3528, RK3576,
>    and RK3588 populate this method. Every other SoC supported by this
>    driver still requires the property:
>
>         ret =3D of_property_read_string(dev->of_node, "clock_in_out", &st=
rings);
>         if (ret) {
>                 dev_err(dev, "Can not read property: clock_in_out.\n");
>                 bsp_priv->clock_input =3D true;
>         } ...
>
>   If one doesn't provide it, one gets an error print, which is not nice
>   I note that the DT binding doesn't list this property as required, so
>   the code is at odds with the binding.
>
>   (I note that your Rockchip SoC is RK3568, which doesn't implement this
>   method.)
>
> So, taking both these points together, the code should not be printing
> an error if "clock_in_out" is missing when either:
>
> a) RGMII is being used (or maybe only when RMII is being used?)
> b) the set_clock_selection() method is not present for the SoC variant.
>
> With the driver fixed as indicated above, I then think clock_in_out in
> your descriptions becomes unnecessary, and should be removed.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


>   clock_in_out:
>     description:
>       For RGMII, it must be "input"

This description does not match the actual situation,
there are many dts using 'output':
https://elixir.bootlin.com/linux/v6.17/source/arch/arm64/boot/dts/rockchip/=
rk3568-bpi-r2-pro.dts#L235
https://elixir.bootlin.com/linux/v6.17/source/arch/arm64/boot/dts/rockchip/=
rk3568-evb1-v10.dts#L241
https://elixir.bootlin.com/linux/v6.17/source/arch/arm64/boot/dts/rockchip/=
rk3568-fastrhino-r68s.dts#L33
https://elixir.bootlin.com/linux/v6.17/source/arch/arm64/boot/dts/rockchip/=
rk3568-nanopi-r5s.dts#L78

