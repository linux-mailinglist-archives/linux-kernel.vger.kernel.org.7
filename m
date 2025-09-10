Return-Path: <linux-kernel+bounces-810228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A7DB51779
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B211C83DA1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CD62BE65A;
	Wed, 10 Sep 2025 12:59:08 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466CD306491;
	Wed, 10 Sep 2025 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509148; cv=none; b=ZTsNxexgXfDAeRomplViu3SMP3aAs4Koer84jKsDJovZQ3oGj2bgpWEWjbIwl+QzIqmIpwnoywlIgi9yikmwZZCHVY2vKm43Yq5LxWHKOcUqp8VQi+CzQPoqVIT9e2A3eDpxuv5EeaTDG0oTzG96PCUmiA1cwb/GRc8xMtopeCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509148; c=relaxed/simple;
	bh=JTnYhVVnoMWTtsBpjBekP0EKAVoSvOkjrReUjPD0jt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgNnNemzRRNwEj9tXzE0XKEAQTKU28TpMCrne3FSDuU6VLlQsPq6NUYtMeO7XFdqLksLkA5njwxa7xRdhEjCzYwm3THOpq/OIPfiwCAxyCPwd76dZp4s58nhGya+mpEB1/FdIEfz/6uVbC2qbYELalYiI+9IrTfokmZ/KrB8Mnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-56afe77bc1eso1033015e87.0;
        Wed, 10 Sep 2025 05:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757509143; x=1758113943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0IkDIc30A5I5+5gGYCirVC3ygVlzp+pkEs2HFu2fts4=;
        b=I0U3K8GVMux6rOBHmFnfBKGXj20ormFxUqmH7kcqMHvOAdLxXEPDdzNoKt1nYwt9Yd
         0NA1V5P+tUJjdfkCuXNqngYy2sPyaHwXgd4Y3Embie/jvhEyOTxjvKCmSJ5gck+VHQd6
         lI7UzHhbiOjT64TBGtDc3e7Oqu1GAuWeoLmv6rij33um98jG0jqJk0DA4xbK22AUQf11
         rpSYLw6UCVb84lP8+Fpp/6ud/Rl5kVc3O3g3PYzEuLrqVObfgD0OibBGBWdu1xkarpg1
         3cloJaVRu2UwvwuefLBZQe6FwbtDAXoD7bmI4GbBweMUkN6RLeZgZw+UmYE2teV02Gd2
         vNLw==
X-Forwarded-Encrypted: i=1; AJvYcCUS5AyRBCaXmZpvOpjmq7X/SisYxCnaLbulFP8IR5DweFAYVB5Ur+xsgxICU6JYW0CqMudLSfk8CVmJ@vger.kernel.org, AJvYcCVhQbDZJQNV2hfuya0lrMMLsWLBbq/1hXuBBNJlaoj2H0WRBAulKmdKOfiMSnzBxApD0ufOCFQdNzfa+DV0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0E5I3C/fP3i9M09CfHkPNkumYbG9tkE+xsp5c8oznT1HX4S3A
	BTp7+oWl6gAG8Eg8Txot+xrCnS3/pAQZQKNttx2Xs75UMSeoidhQKWdGx5k7NcPx
X-Gm-Gg: ASbGnctVBOcowum3OpIlBaV2o3+/XD9E+qDyXIuc0Sx5XuCu4/5v4vMxM23uwybCjPo
	4bJCYvAFdyyKfjS069+RIum8gFuRKcu+WJhyHJji7q2FhNj3/qODs/rxoP5VWuMpID3szjI65Mu
	YTkY/TGMXxl+8SgKu1oTvQ5bzbZcMkAc+i1dpn2cTkm6Bwod1PEibnhBOUA7AY6rYbHUtPH0U+n
	/5BPc2Tq/9DvmDF7YIQj9x2PCPL/QgFeq0/22s1TQsKLRnC7bhuEA2VDmwrK+qF9B7mlOc496U4
	rWBGRr/nDLIxgDZ0f6e8m9YwYH4avPmqwY9q3M36QjRttkQtCYBvd06iSYa7XQl8zI2UgrNnLS0
	TNF7w4jUEH/JjuK3mg4kmu1or/DuFUIl8nj+zaj+gLAANvAlF084bDEZuV8nm+Q==
X-Google-Smtp-Source: AGHT+IHwHvtH4YADd1ssOmyS6+uOGW+iOWaXlVOwVdVNRqExHMxVY64f0LUIT6TM1BpepvtDU3diqg==
X-Received: by 2002:a05:6512:1101:b0:55f:55ad:2263 with SMTP id 2adb3069b0e04-56260e3b3b0mr5650883e87.16.1757509143103;
        Wed, 10 Sep 2025 05:59:03 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680c424fe1sm1230528e87.19.2025.09.10.05.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 05:59:02 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f6f7edf45so6331506e87.2;
        Wed, 10 Sep 2025 05:59:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUShli0kkUZpcOz4arugBTMreJw9uN+Y4qboNF5c318nBq4GKfYIPPGOwNZkna9yzVG4MJCVy3uUsOXlKj0@vger.kernel.org, AJvYcCXYV/VhoM5BIiHimp+kO4ubQURRmu6S+lb+1dhEsg7KXTanGp28v0iz3XfL/l4QJ9YyZ4/kBihnl1T5@vger.kernel.org
X-Received: by 2002:a05:6512:258a:b0:55f:71d2:e5b6 with SMTP id
 2adb3069b0e04-56262667e84mr4272953e87.30.1757509142550; Wed, 10 Sep 2025
 05:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250809-opz-audio-v2-0-f4fd15552a82@posteo.net> <20250809-opz-audio-v2-2-f4fd15552a82@posteo.net>
In-Reply-To: <20250809-opz-audio-v2-2-f4fd15552a82@posteo.net>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 10 Sep 2025 20:58:49 +0800
X-Gmail-Original-Message-ID: <CAGb2v671xTaWkRD0xVPsgGWvykAwPESXuBLgDz-oo4ywOJ=5Xg@mail.gmail.com>
X-Gm-Features: Ac12FXzcg0HuLYsq4drjLq836L_aVuo4Ro9TH7Nv-ZbI1uV7AhXI1LYHqmezi8M
Message-ID: <CAGb2v671xTaWkRD0xVPsgGWvykAwPESXuBLgDz-oo4ywOJ=5Xg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ARM: dts: allwinner: orangepi-zero2: Add default
 audio routing
To: j.ne@posteo.net
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025 at 12:18=E2=80=AFAM J. Neusch=C3=A4fer via B4 Relay
<devnull+j.ne.posteo.net@kernel.org> wrote:
>
> From: "J. Neusch=C3=A4fer" <j.ne@posteo.net>


The subject is misleading. The Orange Pi Zero2 is a different board with
the H616 SoC.

ChenYu

> The Orange Pi Zero Plus 2 has the same pinout[1] as the Orange Pi
> Zero[2] (with the possible exception of line-out left/right being
> swapped), and the Orange Pi Zero Interface Board is sold[3] as
> compatible with both of them. We can thus use the same audio routing.
>
> [1]: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/de=
tails/Orange-Pi-Zero-Plus-2.html
> [2]: https://linux-sunxi.org/Xunlong_Orange_Pi_Zero#Expansion_Port
> [3]: https://orangepi.com/index.php?route=3Dproduct/product&product_id=3D=
871
>
> Signed-off-by: J. Neusch=C3=A4fer <j.ne@posteo.net>
> ---
>
> v2:
> - new patch
> ---
>  .../boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts    | 14 ++++++++=
++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts=
 b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts
> index 7a6444a10e2534458b7380882ea4fd42bd54fea8..97a3565ac7a819be6b18d324f=
a6f65d0d1d2b2ad 100644
> --- a/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts
> +++ b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts
> @@ -99,6 +99,20 @@ wifi_pwrseq: pwrseq {
>         };
>  };
>
> +/*
> + * Audio input/output is exposed on the 13-pin header and can't be used =
for
> + * anything else. However, adapter boards may use different audio routin=
g.
> + * - http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/d=
etails/Orange-Pi-Zero-Plus-2.html
> + * - Allwinner H3 Datasheet, section 3.1. Pin Characteristics
> + */
> +&codec {
> +       allwinner,audio-routing =3D
> +               "Line Out", "LINEOUT",
> +               "MIC1", "Mic",
> +               "Mic",  "MBIAS";
> +       status =3D "disabled";
> +};
> +
>  &de {
>         status =3D "okay";
>  };
>
> --
> 2.48.0.rc1.219.gb6b6757d772
>
>
>

