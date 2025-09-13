Return-Path: <linux-kernel+bounces-815170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC25B56082
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 13:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012E71BC5773
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 11:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0C12EC08A;
	Sat, 13 Sep 2025 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+T8hLja"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B1325CC74
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757763106; cv=none; b=syOS/SJyb9v9s26CX7gg1T/04Gj10yyDmRV6mJz2rl7itWhtbaZtcIC90z/+TwZyAsSgXfncOP6LbAXpdiWaTwDOYlodCJKmgtNt2LUsGNiY/OSkHL5Aj/XhYmESZrQpAJOdlMud+KE56/6JY6k/whApAnK0CR85FeIE3heKaRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757763106; c=relaxed/simple;
	bh=Pd7LXL3e3fziuQtA+gIdsuKsBHrZf8/dR473MaUf6HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eciHYb5g3HO//5odgHS0U+gU9GXt0Mjcz22u7EiRKezLBH9rrGun/08mELKX/a/4ra/RLeaEmRhKa9Zp8ppAP1u/30jQuyUgNNYFuvFLsy5IlDd06SLku9zLI7fvFxqDXPf4zu9Pc5MEyt8koBmBoKcc2KG6KpKZfa1Cn42+Ezs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+T8hLja; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62598fcf41aso3796776a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 04:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757763103; x=1758367903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhiOMZzJmlK07q9Yx4eHe//JB/+U6zF5S8d+vjc7i3g=;
        b=G+T8hLja00fDYD5eggA29QCGKu/MVbP3nf2Nr817eqWHvCR8kvymXueuMANRAUxoEP
         +EX/i1F/9HANozGk+wl+Nop8GaLpr55NKNhezZ30MZql/eZgtAjsjnEqXXnUB86Qz3T7
         xyCtJmYUDBknPR3YwohoCfuvtuYf9cnq5eIlBUH1CpXQZ1I0D6OYkxfho1XVOexuiZFh
         C5AVLA9vppURkIqBo3TB/BV0TCu34hwn3MzZfyJRlRJRmuViRkvlvZgmXxaxQ/W90TZR
         2pjVZ+gtHoWBESMONde8nr9qVuIWW7GDzJENuSLwDAz3ybqUAZ0nCvpJNlkOVcyyJVOQ
         BDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757763103; x=1758367903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhiOMZzJmlK07q9Yx4eHe//JB/+U6zF5S8d+vjc7i3g=;
        b=Q3Vwz9TGDlCdpjIld/Jl2lkBwOLHkaH7O2vQWQZyDMzz3dV83G6XF80SAIQzCJgpLE
         BdUOZdvQ274Mp38MybmoznUaNEiAUGyFheHZ8dza0moI0icsKQRZPWFZnyMmehBMBRVG
         d4fadMiaEBQ+U1ebYPNZT+JJ3Rwb2BGS23cKXJ3D4LnwHj2gpC4skM66WKctj7f4KY1B
         AOL///jIpM/CAusEKdZFm8xXNS2OjXTr84vmjKvBrbEc7V7+a3fqfCX8UZwLMcczXoAj
         Dy+jaMrcaWKpGe6TKeoLCjv33Oq+1WnUCH0x+UeFLJYxEqiIuURE30mGzjLhseGzfijn
         aSNg==
X-Forwarded-Encrypted: i=1; AJvYcCUZckHLdKVezo4bMSunOgJ70PdDjumv+4dmt+PZXgozHBW9/MkQ+bjBgSC83TTQV3fopbW3rFq1MV/J+7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUVeUfRtu3SBSc1F9QAzO5Er1Z8xAlXDh2p4jwE65kNGOS3H4m
	mIskzCPsEiC+D4pLqtHWzSTJZOK3LH/wQmacAU2R6D7tmJUXOaRigou2ThqpZA==
X-Gm-Gg: ASbGncui9jnuKkY8TTVKyZaIbZhCCWqKtzZU8Xm1uY3QekKWUlb44zbZtWbL3U3iYwh
	p30hZTc63cu71PazuPxtABSN9F9rJAVoal/1gswHor5LFdFZTr3a4c2UN0FT4COJT//4s8T1pwE
	QU9ZZbrjyYSWJ2Y91015MN3taspBvy+Va7iJilHZfyCPQhsdUuO/CZ1SyC/+kKEHpK74rRyVWuA
	Yq32UqJOJC2Uwds8YZ/eCAUci4FacoNmg5HyCa5TgYb3hsGr0MyOkZUUePpcCY+5B7YJyu9vgNC
	mf70IkTir2GDqw0s+TPtIQyhX2APdcSEF35gV8sPi4uBXqkPzHDstIp5AhHtvjtbfqOdRSJkEdv
	AWWTpXiHPkIgRC2T0Dq2eG8pszv0zb1aVTW7Zi/2tqh2i4l2XxVZkHvBiTDoqlth5aQ==
X-Google-Smtp-Source: AGHT+IHykb2wro/3EPEKGFRhfZdxz0R+s5067Brp4xRx1L5hET4V9Jhz88T1kD9l7Nn6Y1hOSTS1Sw==
X-Received: by 2002:a05:6402:5204:b0:62d:b1c9:f0ca with SMTP id 4fb4d7f45d1cf-62ed80c9f05mr6124659a12.3.1757763102637;
        Sat, 13 Sep 2025 04:31:42 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f136cead7sm825431a12.36.2025.09.13.04.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 04:31:42 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@kernel.org>
Cc: linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 3/3] arm64: dts: allwinner: t527: orangepi-4a: hook up external
 32k crystal
Date: Sat, 13 Sep 2025 13:31:40 +0200
Message-ID: <5009461.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <20250913102450.3935943-3-wens@kernel.org>
References:
 <20250913102450.3935943-1-wens@kernel.org>
 <20250913102450.3935943-3-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sobota, 13. september 2025 ob 12:24:50 Srednjeevropski poletni =C4=8Das=
 je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> When the board was added, its external 32.768 KHz crystal was described
> but not hooked up correctly. This meant the device had to fall back to
> the SoC's internal oscillator or divide a 32 KHz clock from the main
> oscillator, neither of which are accurate for the RTC. As a result the
> RTC clock will drift badly.
>=20
> Hook the crystal up to the RTC block and request the correct clock rate.
>=20
> Fixes: de713ccb9934 ("arm64: dts: allwinner: t527: Add OrangePi 4A board")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts b/=
arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
> index fb5311a46c2e..f71860db83d3 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
> @@ -393,6 +393,14 @@ &r_pio {
>  	vcc-pm-supply =3D <&reg_bldo2>;
>  };
> =20
> +&rtc {
> +	clocks =3D <&r_ccu CLK_BUS_R_RTC>, <&osc24M>,
> +		 <&r_ccu CLK_R_AHB>, <&ext_osc32k>;
> +	clock-names =3D "bus", "hosc", "ahb", "ext-osc32k";
> +	assigned-clocks =3D <&rtc CLK_OSC32K>;
> +	assigned-clock-rates =3D <32768>;
> +};
> +
>  &uart0 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&uart0_pb_pins>;
>=20





