Return-Path: <linux-kernel+bounces-854795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7007BDF69C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2569119A1691
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B56B306D47;
	Wed, 15 Oct 2025 15:36:13 +0000 (UTC)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7366A306499
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542573; cv=none; b=Kf7kErB9wGunMdNJPsF5LUOT2ysomFMARdCCRXDP7XlTus6YUfCuz2+Mxu5fLE89IcBW5Qm3TYAwCVpuHSOQYi4MYkKnIyxDBAdAElKCNT2a/O7dCuTSt3NG9UfxppeASwm/PG53a+lZIEPdPP+IaCW4zmrb23RPUGcwKEsqmD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542573; c=relaxed/simple;
	bh=I6P15+XhidIm4wEGq3EBOacS03cItxiFUaa6LkWs8hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcjRH5AwdovH/oortKtLXFcNZ9P6bHNl6Q8jjHt1j7Zgmjde+kQFd0Fj3P4lvu4GQmwWNyoFcHocEZrcwoDgkY/0mra+k3g7/LXqJAUru7jYiXo6HuWpbchpcrNFt3BY92zQ6XMhL5n8uWy+vE5p7kTIS+KrgbAnDD/vgJJ03oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5a2b3bb803bso3768737137.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760542570; x=1761147370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DNmUCrYMJqR/KXnbLWdaSqa9Gxw7R7jjIcZiaJXQXIA=;
        b=le/oh4vGTOVgwl6wOYFKAb+Zz/OZaftSCOdQmSVA7v3HQGsNM0NZy0m7i/2NtSlWdP
         IfvdEBK8yEmsRhMMY2x9v/ezUoqBXzFiCZ/J9O1NoWDEhy9z0JcZCY0LhGuxaRrJfu9d
         QVIRPuDjl7xzmsx9b+VP8wH+lUdsh0CvYHlReRzP0243kDxrL3asq25X/wy5mbKK7b6q
         +dGifce/LCdAZORtFJ5oTT8nmnlzRLVG+6CeidVCo47ADdejJb1bdyqG5kL9oNu1niDy
         vRXrV2oabLC+Ykef/wi3ouei/bJIsECHfRN7d8aYA9TEYQCEtOZlg7+JSIQ+Frkp2llq
         QnKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRDHGRGJIlolp4WhdMk0bUuMQcF+4GxB/99Lzcvl6na7Gn7jq9rTsDMbx8EymKtmWNjWYACLtzMTv48RA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFd22UhI537ZNunhppVNLSWsLAoPTuA1hY8S2qjHqk/xEYfZqZ
	2DDJ2j8cUKJD+O09d2vuI9dTsMcKyxxZcIK4SfVQD/3spPqlQDncKnOCOrOh2hpc
X-Gm-Gg: ASbGncs8MzrE2Ik6m7gdrOK+Ev+J+fjzVOz4suHwWYaFumiUwsvZdaItVSzO19oMVCG
	50djc6IEQrBv3yJPXAzDRomkMr9LfR2F8f9lGP3jT163D1LA0JDklAIRgylPGMWSu+mxSEwdxCW
	SjRBVfe60JVAxPmK1wcJ9pNYZk9ps8kA0kjG8pahfvtYNvx6JYL+WYlJfURJ/pFPo7Gc/Y1DMTR
	6aO43qdqe4y/nFBA3n478AhzTUUV4vuvclKUIHLvG9XK1mO2FCMv2s+K3D0AogkErxvW61L3//+
	7EIflHXWEPCnrr5NdqjnYJX9yF2rBbUjfWMuJfL2hBDWC8c33S9IX4q+qRfahcZRZIT7K7pJ+dL
	2z3XCID2MGH26USTS88VYz2mcclnkRN2iwXSLsxDMveA6eYu6sxdqskHJvjUmwo9Lvjh64loRxy
	XGer4nbLgechnijcfm1Q==
X-Google-Smtp-Source: AGHT+IGsZx7HWk7Ci5wp/F4TiIfN2BfigspHhn2SQ6jvzeFlGbH1X0DraFlqol9/CUzHIwtHAMmS/A==
X-Received: by 2002:a05:6102:2910:b0:52f:12b3:4505 with SMTP id ada2fe7eead31-5d5e2375adcmr11719127137.23.1760542569868;
        Wed, 15 Oct 2025 08:36:09 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d6347977d6sm1710959137.2.2025.10.15.08.36.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 08:36:08 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-54bd3158f7bso4504942e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:36:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLSrL4adIEFVgDWrREfw1SVRp6ERu6gEtRtCGLj7ykVDKqegVLBoP1NoIUs4tWRB2777YqOptsPRJC0iA=@vger.kernel.org
X-Received: by 2002:a05:6102:3f8d:b0:5d6:254f:4e24 with SMTP id
 ada2fe7eead31-5d6254f4e58mr4448769137.32.1760542568340; Wed, 15 Oct 2025
 08:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014153314.177300-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251014153314.177300-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Oct 2025 17:35:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUBthNYYOg4WHjt+gJRL=g00wmiqCsx+La_3NCUrCJ9gg@mail.gmail.com>
X-Gm-Features: AS18NWC2xZ5k0_H_MwKSUXMl7-yjZeX_uMDf4r_eO11t9puIMof4gvI7VNM2V8g
Message-ID: <CAMuHMdUBthNYYOg4WHjt+gJRL=g00wmiqCsx+La_3NCUrCJ9gg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: rzt2h-n2h-evk: Add VCC supply for EEPROM
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux I2C <linux-i2c@vger.kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar,

CC at24, regulator

On Tue, 14 Oct 2025 at 17:33, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> The R1EX24016 EEPROM on the RZ/T2H-N2H Evaluation Kit is powered from
> the 3.3V rail. Add the regulator phandle for the VCC supply to reflect
> this in the device tree and avoid the fallback to the dummy regulator:
>
>     at24 0-0050: supply vcc not found, using dummy regulator
>
> Fixes: 0176c9e82e10 ("arm64: dts: renesas: rzt2h-n2h-evk-common: Enable EEPROM on I2C0")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
> @@ -160,6 +160,7 @@ eeprom: eeprom@50 {
>                 compatible = "renesas,r1ex24016", "atmel,24c16";
>                 reg = <0x50>;
>                 pagesize = <16>;
> +               vcc-supply = <&reg_3p3v>;
>         };
>  };

"vcc-supply" is not a required property, according to the DT bindings,
and I believe the 3.3V supply can be considered always-on (but see
below to encounter dragons).
I was always under the impression that these "supply not found, using
dummy regulator"-messages are just informational, and can be ignored,
but they are at the KERN_WARNING level.
So should we add real dummy supplies to DTS, or not?

Thanks!

P.S. Actually the 3.3V supply is controlled by an SLG7RN46899, which is
     an "RZ/T2H Power Sequencer with IIC".  From a quick glance at the
     documentation, it is not clear to me what is the purpose of the
     I2C interface, and whether it can be used to control the outputs
     or not.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

