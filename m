Return-Path: <linux-kernel+bounces-854120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F5FBDD976
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 763BA4F7109
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB60430BF4B;
	Wed, 15 Oct 2025 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4x1AhMp"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B58030B506
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518945; cv=none; b=Qo9rCQsK9WeuaVRXJIqjmyosYFrRTixklPwnONW03DWYbwWm3n5rmhCuB/U4U2GmJDar1fqXvqyDuPUZEHDU1RZ9BvBEADVuoNejZYwqrGD62e6+W33wG58aG/FT95GbT6yqQAtj1+n9llSn/ZOFq/s0a22CN3y13VP8ynL8YRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518945; c=relaxed/simple;
	bh=RDZfPG6F9pZtmU8Gkv33LWcmNPlLhbwFu6m2B9/1zPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XuCRcu9zWFrzexUyelhqlhH1q9x0Zr0C1woZqwGS1yiLR9GTZy9d9cOUrugjZpzxUZYV5+CsMsfarkFjpwGQ+Z5P+e6NiZkK9aPWxtJ0HqHBVZFjt4eMq4D9XoqC+LuTXTrHeBpH/PI2aI1sK0oI66kiA9cg9bOL2I53Yd1WGX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4x1AhMp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47103b6058fso2403405e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760518942; x=1761123742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FV3KRblijrAdpwToi+Mhyrh4bXSjZg3WfC9q1tzKT4E=;
        b=m4x1AhMpzxLo4XqhN33wYmSjmpWeUVZKHq+uHpkOKkh6a66fY1eRip4bciSeUfd3uK
         jzT2cyeYO3O22V6xWYiGnYSqbYkqk/2+gY63QePf7MxxsqzBZtW5H02P5yYOPwXWm7Wb
         Km0pndtn+3nN4qG6SeHrjklg0VI+B8YXiTaWl6r5a6s+TMOiEOsqaq/r/Ub/7dqEwOIS
         jvUmM9bor1t+bG0xkVY97kwMokT/tKlBpCEqVL85t9YAovyIfHrKqg5UhIh1bn3GDWkb
         QvPeNnaasmN8xvf3FTIS3NQmsx4QGWT1+0LgJkxoYY4oA3/YvETdBmkw43qlANM0AdC+
         Vosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760518942; x=1761123742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FV3KRblijrAdpwToi+Mhyrh4bXSjZg3WfC9q1tzKT4E=;
        b=wFaqmeEfful5F50+COHyI2qwiy6xPEVWuZGNAo2dgsH8t1YFfBY0sc+YqwEcfNV9pu
         6syvI/YFQtZhx9KuDWXsnVOqCEbjnJ/u5Rv3hmhN4yxUbgelWGOSivZE/q+hdLQ/KMJa
         wO7h4Y3u5k+xtRR54tyTvWvrabPBK40bf4n+75X44cLY75sFaxdvrldLrYJpeKSGnZjc
         cRcG2d68RhcjFKlLizOL0pczH18T+Z3cd1R2JiG9Ky1U6WP6wBM+BxnQUqvi63CCB4KA
         kfeHq7ah5gBwUCQDVGmmS4Khrosun1SwXY6rsUZbM/qMZZMl3jYk3y05DebN5ZwZFmdp
         TJYw==
X-Forwarded-Encrypted: i=1; AJvYcCUvpYV8WPCRC7Jcg04trCaXJtCTw/oY9qNVlrT5u1XGJhsPi3OwfCBQA3MPh1SvSHg2SUJGgaSIMZBgm1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv0beL6u1vCSWiRqG5TPoo6VBSZBdHpyONnWj2X/i7+T5JXUs5
	Q+hsI+WKAjO0PfUZH+ZoXjuj24TNgi8rYOtmw4EhTV8I/odchm2dLJCeXw/vC8CFKqMYTedESEq
	W0mpSHoj2jZXR7OxO5cmppPGXZF6J8OA=
X-Gm-Gg: ASbGncs9ObbpUX5mSurZd8InNpGSTuc3DSQaKsvY5DxZ48Z6dsrqQG2FO9L2DJ/z+wd
	Oas7iIoOzS7/yS2nNFEft5P9OBXhbFLDlTDYP4cZSPeMG68P2wzEF770yJDS2GxNFqSaZtEfv3M
	6TugzTPClMrDozB16xMQw7p8fgD8gBsGc6UDHvl0S7D7bwZG5S/DlTyRtcgyoRZ1N/yjqAy6nDl
	r7gXbz2veCY7FfwLE9+UA/Zj6gwQ+bKVEgArJ1sY3NhZ7+AKN8wz1IGMcPHMtLQdyKsKR57HzpW
	4MimDA==
X-Google-Smtp-Source: AGHT+IEUi6z4S0evmQA4TnJ5mnhm76pyPFHvsITlzTuxuE6K5zX96wi7FQaogf9E9nYcIF1iq0Qp0I3dtBxgjiZTR7Q=
X-Received: by 2002:a05:600c:1d9e:b0:46e:2815:8568 with SMTP id
 5b1f17b1804b1-46fa9ebe0dfmr172293935e9.10.1760518941308; Wed, 15 Oct 2025
 02:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014182035.239956-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <e97327ff-9dca-4764-9973-8223d6b50fa9@kernel.org> <b8137f4e-97d9-4e10-a80b-51ebacf3b3ac@kernel.org>
In-Reply-To: <b8137f4e-97d9-4e10-a80b-51ebacf3b3ac@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 15 Oct 2025 10:01:54 +0100
X-Gm-Features: AS18NWAHDgRSntGqFSxqj0ORtuvvZPtf7_9IZdbAJmgCfonQpX7DDGGK4szxB_A
Message-ID: <CA+V-a8t5x78diD4MQC2P5vhAvKNOi0Y55nQZz3kEHy6rhSGGUw@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Drop duplicate CONFIG_OMAP_USB2 entry
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Nishanth Menon <nm@ti.com>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"michal.simek@amd.com" <michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 11:03=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 15/10/2025 00:00, Krzysztof Kozlowski wrote:
> > On 14/10/2025 20:20, Prabhakar wrote:
> >> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>
> >> CONFIG_OMAP_USB2 is already enabled as a module in the default defconf=
ig
> >> since commit 8a703a728a745 ("arm64: defconfig: Enable USB2 PHY Driver"=
).
> >> Remove the duplicate entry to fix the following warning:
> >>
> >>     arch/arm64/configs/defconfig:1705:warning: override: reassigning t=
o symbol OMAP_USB2
> >>
> >> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >> ---
> >>  arch/arm64/configs/defconfig | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconf=
ig
> >> index e401915e2f2f..478ca72c0aeb 100644
> >> --- a/arch/arm64/configs/defconfig
> >> +++ b/arch/arm64/configs/defconfig
> >> @@ -1702,7 +1702,6 @@ CONFIG_PHY_UNIPHIER_USB3=3Dy
> >>  CONFIG_PHY_TEGRA_XUSB=3Dy
> >>  CONFIG_PHY_AM654_SERDES=3Dm
> >>  CONFIG_PHY_J721E_WIZ=3Dm
> >> -CONFIG_OMAP_USB2=3Dm
> >
> > I don't understand. There is no such line in defconfig. Which next are
> > you referring to? Was it just broken in Renesas tree?
> >
> Ah, no, it got broken by Michal. You should add proper fixes tag which
> results in automatic Cc.
>
Sorry I missed that, I'll add the below and send a v2.

Fixes: 91fe3315cdf9f ("arm64: defconfig: Enable missing AMD/Xilinx drivers"=
)

Cheers,
Prabhakar

> @Michal,
>
> Are you sure your commit did not introduce more of such issues?
>
> Best regards,
> Krzysztof

