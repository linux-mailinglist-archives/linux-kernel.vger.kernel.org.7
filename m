Return-Path: <linux-kernel+bounces-850946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C7BBD4D33
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A614581A12
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37081314D2B;
	Mon, 13 Oct 2025 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPch/fN5"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A217A223DC1
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370226; cv=none; b=t631gf/sCDetXfrARYWlS7ZaGXQWPuDlbMOVmsNZWc/Ops8MCqO/H6UzmWNsiPz4jIZbczM4JyVcKYAWSgrihKlkNYOqaRnbftUyoEr2j/iG0AMUvm3u4b7INb18QZG9KJkRl1mby3/5kgBxC0b9q+fFN44lW2AjogpCH7LLAGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370226; c=relaxed/simple;
	bh=yN4I19Z/Zxa0OAvQeCoXidtC7w6Fi4uf1d42DNqijxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTSK/g5UC2cjKOJ0OhA9FLv6rBUio7slNaY2S40Ewa14cfj3ztcRQdfjmBr+1yE7DIXK50ppS46Ey90mdvNFwjv6aFMnyxwXWXPDfg5QVNB9VuvMaEU1d4KNiZ1zA4ad/tapvrCK3BayX9qOLF+sqVRBAZU05hVEJfXzIexBkrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPch/fN5; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-639e34ffa69so6875383a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760370223; x=1760975023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJ71KTvKAMUC1AACHaaj8OA3SEI5NusmyGpJc9+nnWQ=;
        b=JPch/fN5S5ALTM0I5JzuDz5zpGdFXQ3WUqsbkS5quVLAs/NCpUqBC2FiWg+3xv73Yp
         2C5VNBU9ZiuDFJ7Dsq0Xs3a8EUy45qhTE3wfL9LyKLxh3gmhxW32/HIy/1u/EpRSi3Pa
         agoJDtGrbyvsKWaFDF8d6T/MScLLUujMUvjvven/IyjRty9EThn4fKTi2HzvGar6gEU2
         OoPz5q9mmO7XDGh7BskYvOPNPieXaqN09pZS+/+XSqOE6ghNRLwO/RgYy24JmuwcFDNW
         SsJiczMliJGMcEQ/EZYsgqHvFbMA/KOjvmBuzXQ5EcHjb46j4GmwsG7Ho7rpgolhMUgp
         Hfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760370223; x=1760975023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJ71KTvKAMUC1AACHaaj8OA3SEI5NusmyGpJc9+nnWQ=;
        b=PojSNevU0e9SZ72Sedh4D/zQ96grt/jwoIs9alknowcqiRIGIZVrraE+T/wVGL/9NT
         ZgNuemBtPb9vmjMa+Vz16KRH6vmv6QGoBKwp0Y/0ZCqOTKkC1Nyh70Rg5KXzFfGCLkEa
         hkYv4PyuXD88QU8aa+sMcIYXSLhGwjCvDKMRqd71C//vWdicaYF4tWEIgLh2oQio3oQK
         Vexl1+cVeWEkEJtIVzPrDA8xD82UvWYROFO+KZ8rcimYI/Evp2JXmoM9eg9rlr5ABGNh
         47l1UzjTI56UvjOOgtVPV5gx3zMY8EuibOKK8knrkYvWLig9w6ky6ktRmi07BTyU1w/K
         J4/w==
X-Forwarded-Encrypted: i=1; AJvYcCXbWSA37WJnU6d0znlxd0+/IGoy2KrOl5Jvrr3JKAm/acmnCZRBded+Bk0PA4QnMDX+eXigR3CwDbtdKms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaS945zJm3cpyVp48XSoCGBySkXIfs6izWLrm4v09Gl/Z09CKs
	ccGWAcPqB1kZYnf0aN5hC/EiZYx82jpAXqrHF3d4Xl5/TuvY7YaI2j12
X-Gm-Gg: ASbGncvCsYdsIRpKRb8LBQsXrmNpIrLR9N1fpXRvoHzdwdiBA6mE4bGdPQwQJi9E+Zm
	jh0qSgm5WRNU2Q6OD5HRns54TSNUZaKK4P9PCI4M2s1gnpZdlsitduWMlMejV34DgwfD5Pzxt3/
	LyiDPgu2tVJeQtUznR3Wn/eb9JkoFiAvSVJEDa+J6OxXwHxuIaN1Uha/MHgt2CGBw7C/B+6L1CO
	0RwF/rLknd09P3PUDTJXHL9WPneiP9t9CivZeCx1Ch2zvW+tTBqqFglfv1m8w2AVlpLtf6dTKHq
	utU/u7yslejzTgvPlAk4Rz5Pf6K1x9MkZHGdCqZOnBF1iM0PE5aPqxPdQoZ0RABrChmcmBaFy+g
	kOyihtL1vSK1lGjYUv5/uVP3yuZS+UMON0QY+AF4GQTw2ODZYWPhMIunPylcFg8VnMGorKhNAq1
	GDOjq4Opw0jyfjXBv5+x7DOOI=
X-Google-Smtp-Source: AGHT+IG3FRsw4wCBnmi9CngEI7WoVxEvQAt2WNJU3I/XEDcpUDTwP0J77KuXRMbbHoTA+pSwJQSXNw==
X-Received: by 2002:a05:6402:b28:b0:634:6d87:1d28 with SMTP id 4fb4d7f45d1cf-639d5c74a9fmr13775050a12.35.1760370222659;
        Mon, 13 Oct 2025 08:43:42 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c133f58sm9091983a12.30.2025.10.13.08.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 08:43:42 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Richard Genoud <richard.genoud@bootlin.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Wentao Liang <vulab@iscas.ac.cn>, Johan Hovold <johan@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Richard Genoud <richard.genoud@bootlin.com>
Subject: Re: [PATCH v2 15/15] arm64: dts: allwinner: h616: add NAND controller
Date: Mon, 13 Oct 2025 17:43:39 +0200
Message-ID: <2800174.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20251013152645.1119308-16-richard.genoud@bootlin.com>
References:
 <20251013152645.1119308-1-richard.genoud@bootlin.com>
 <20251013152645.1119308-16-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 13. oktober 2025 ob 17:26:45 Srednjeevropski poletni =C4=8D=
as je Richard Genoud napisal(a):
> The H616 has a NAND controller quite similar to the A10/A23 ones, but
> with some register differences, more clocks (for ECC and MBUS), more ECC
> strengths, so this requires a new compatible string.
>=20
> Add the NAND controller node and pins in the device tree.
>=20
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-h616.dtsi
> index ceedae9e399b..bb53c6c63836 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> @@ -304,6 +304,42 @@ mmc2_pins: mmc2-pins {
>  				bias-pull-up;
>  			};
> =20
> +			/omit-if-no-ref/
> +			nand_pins: nand-pins {
> +				pins =3D "PC0", "PC1", "PC2", "PC5", "PC8", "PC9",
> +				       "PC10", "PC11", "PC12", "PC13", "PC14",
> +				       "PC15", "PC16";
> +				function =3D "nand0";
> +			};
> +
> +			/omit-if-no-ref/
> +			nand_cs0_pin: nand-cs0-pin {
> +				pins =3D "PC4";
> +				function =3D "nand0";
> +				bias-pull-up;
> +			};
> +
> +			/omit-if-no-ref/
> +			nand_cs1_pin: nand-cs1-pin {
> +				pins =3D "PC3";
> +				function =3D "nand0";
> +				bias-pull-up;
> +			};
> +
> +			/omit-if-no-ref/
> +			nand_rb0_pin: nand-rb0-pin {
> +				pins =3D "PC6";
> +				function =3D "nand0";
> +				bias-pull-up;
> +			};
> +
> +			/omit-if-no-ref/
> +			nand_rb1_pin: nand-rb1-pin {
> +				pins =3D "PC7";
> +				function =3D "nand0";
> +				bias-pull-up;
> +			};
> +
>  			/omit-if-no-ref/
>  			spi0_pins: spi0-pins {
>  				pins =3D "PC0", "PC2", "PC4";
> @@ -377,6 +413,21 @@ iommu: iommu@30f0000 {
>  			#iommu-cells =3D <1>;
>  		};
> =20
> +		nfc: nand-controller@4011000 {
> +			compatible =3D "allwinner,sun50i-h616-nand-controller";
> +			reg =3D <0x04011000 0x1000>;
> +			interrupts =3D <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_NAND>, <&ccu CLK_NAND0>,
> +				<&ccu CLK_NAND1>, <&ccu CLK_MBUS_NAND>;
> +			clock-names =3D "ahb", "mod", "ecc", "mbus";
> +			resets =3D <&ccu RST_BUS_NAND>;
> +			reset-names =3D "ahb";
> +			dmas =3D <&dma 10>;
> +			dma-names =3D "rxtx";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};

Sorry, forgot to mention. This should be marked as disabled, as most of
the boards don't have NAND connected.

Best regards,
Jernej

> +
>  		mmc0: mmc@4020000 {
>  			compatible =3D "allwinner,sun50i-h616-mmc",
>  				     "allwinner,sun50i-a100-mmc";
>=20





