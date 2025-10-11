Return-Path: <linux-kernel+bounces-849111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2C4BCF3AA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578D519A0D93
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 10:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAAA25C816;
	Sat, 11 Oct 2025 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H23lmt7v"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE18258EDF
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760178847; cv=none; b=AQHMbO/7gQxvW/H3/5ht2itt04yTT6iykKtQIsOHoTq6+ts6kMcSPcptyGw7Z8fBQKvVqMOgdktOx9X6YRtrN3PYKZIfXIQp6W+WZg9iSC4Wgtp7KIEoFYvgizJ95wkZLfeUrCaghRTEQx8+9usQ7BC2yc9ZHyAl+jGILCh4zEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760178847; c=relaxed/simple;
	bh=/RHuJN8mBmn1rPV1anCMzCvuwIBWUCVFFlaXjDz3/8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/4ot3MhpD/9xViTfnuf+MUAyPCvu+FVMdAkVQgGk9uATlL5OuUF62Jh43OVNuqF9NlotN4Qn7k8+uclR27JzHOFg5tWyqysLQ0FkQ8BlNQLCDsAKugRXBTzYRr7tPBzKaoftsrOkD0z77pq43DOgGm1jgnguu+YXm9/JAJMSHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H23lmt7v; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3b27b50090so525720266b.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 03:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760178840; x=1760783640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYAPdYV4D3yX5RzlvX7A+6gcHuPHfoEYTyIdk9OJfZs=;
        b=H23lmt7vPaMBrmmhxmfu7aO3Pf6xce8xW0JdzLYcsp1FkYYOQdFUe9PaVJFnqxhtgO
         0UzcLp0KBBlXKsHXsAzDHQh500IapVlOeHH/XcQliJPkduuefld2T2OOAj38frn7sWaQ
         TgihW9plxBbQxKXJCqK/NM4cmIWmcyiTVX8RbdvKpiWWTSox0enTpJGjAfz1n7TZN5eq
         7TIJVybPpjgTpSbNxezxox07LqA9rM4SClRDCbJsE0lo+XIcJbKsjlPT47BZB5cTymUv
         VXsO1XaQ7YDwqUaxaFyxFk+U20gGjEdeqkxXK8xokfoRGJl5G25JwgOQFFCD7hZ0tHfG
         JGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760178840; x=1760783640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYAPdYV4D3yX5RzlvX7A+6gcHuPHfoEYTyIdk9OJfZs=;
        b=sSQVX7btPr+qdvnst9c+iYGRT2t7Q04I9C6aDx1/Ey5lFLuSg+ASFN8PAS1lLIX8fM
         JH5azbUWFVKaUeuohd2Tsk8a5wIUD1hREt6Af23OcA72DSfu7QoDkDXQl37H890vvOiW
         0nESme912IMalE9WqLTfH9Tq31v6bY93JVgXIZIArU+PKvQzT57d4vOv+K53l1fSClmc
         QV1Ww0l6VE7ay0JoS7WxB7MdP2HQoXVDc+nzBQtI94f0ukLNyeOjzmDGSh0mzXdh4rLk
         3DH5lkkS1GDjpEYOzsG9Rarn2PwisOPRTcKb665EjIw1Ts/RnLGgstd4jcGpul86Sxmp
         9BOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSY6GFl3ozQxN+3b+tr4gc26dY8sigxRQbPZjfO1V8XvL12c+dzewDE0BQu0mDRY22i0uvcv0URYiO7rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJpZmYAbeDrWHBQe1CUZCgGkmz8VQC7vNT5Ch/kGaCPuVK1orz
	lGzkmM025jWdrB/kAvJ0+sLuKpSc4hc8OQTX0bCZ1yTNTzw63TJeTUcM
X-Gm-Gg: ASbGncu8VdbmrzDMoAnQDztDaspVnOCfJIW3OGsvEl66N3RUiJAUUcLXTjRJnlo702B
	GY5ibEzGXOCS8NZ+wzoximg3Oj7F4lbHfoNWawkwgtkTf0EV1zUeAeGZXH0x928y1c7q0yFocd3
	w6O7/jjw4rZh9pCFdb4BN1suaOxY/NP2xHgmjSCrpr4jQF+JkUcXS5Otgd+FmHOEqDKOIs4ar5F
	mgJj3cWwzJ5w3HFbEw7w4n3sIAVRTg2ZhgtXk06SVWQyRR+Wpn27mI5Oxo9N6tPpVILxectCBkv
	VxgbvlvxzMdcDuJgqQiLA8AZbcAIZP02KupEYGsWkzcQ8pxmiJLvBJEG7hxlIU3ksVdjBnuyVcA
	aqpRCaQ0CjV8g3mG6yYsW7tpH6GK0cJVkoGoJ2P7uLUfjpYLup+QA0O6XG5QuscQstyNyoctA3g
	==
X-Google-Smtp-Source: AGHT+IFFycSQY4Q0kx0MQ3fB8e1/4xrhlffbTRZSX2gxi2804bwlqcuj20iB5WX1bDTyi44c3l+bjA==
X-Received: by 2002:a17:907:6d07:b0:b41:79ff:250c with SMTP id a640c23a62f3a-b50aaa96ba5mr1457625766b.23.1760178840185;
        Sat, 11 Oct 2025 03:34:00 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c124a8sm454690166b.51.2025.10.11.03.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 03:33:59 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Richard Genoud <richard.genoud@bootlin.com>
Cc: Wentao Liang <vulab@iscas.ac.cn>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Richard Genoud <richard.genoud@bootlin.com>
Subject: Re: [PATCH 03/15] arm64: dts: allwinner: h616: add NAND controller
Date: Sat, 11 Oct 2025 12:33:58 +0200
Message-ID: <4682810.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <20251010084042.341224-4-richard.genoud@bootlin.com>
References:
 <20251010084042.341224-1-richard.genoud@bootlin.com>
 <20251010084042.341224-4-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 10. oktober 2025 ob 10:40:30 Srednjeevropski poletni =C4=8Das je=
 Richard Genoud napisal(a):
> The H616 has a NAND controller quite similar to the A10/A23 ones, but
> with some register differences, more clocks (for ECC and MBUS), more ECC
> strengths, so this requires a new compatible string.
>=20
> This patch adds the NAND controller node and pins in the device tree.
>=20
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-h616.dtsi
> index ceedae9e399b..60626eba7f7c 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> @@ -278,6 +278,37 @@ ir_rx_pin: ir-rx-pin {
>  				function =3D "ir_rx";
>  			};
> =20
> +			nand_pins: nand-pins {
> +				pins =3D "PC0", "PC1", "PC2", "PC5", "PC8", "PC9",
> +				       "PC10", "PC11", "PC12", "PC13", "PC14",
> +				       "PC15", "PC16";
> +				function =3D "nand0";
> +			};
> +
> +			nand_cs0_pin: nand-cs0-pin {
> +				pins =3D "PC4";
> +				function =3D "nand0";
> +				bias-pull-up;
> +			};
> +
> +			nand_cs1_pin: nand-cs1-pin {
> +				pins =3D "PC3";
> +				function =3D "nand0";
> +				bias-pull-up;
> +			};
> +
> +			nand_rb0_pin: nand-rb0-pin {
> +				pins =3D "PC6";
> +				function =3D "nand0";
> +				bias-pull-up;
> +			};
> +
> +			nand_rb1_pin: nand-rb1-pin {
> +				pins =3D "PC7";
> +				function =3D "nand0";
> +				bias-pull-up;
> +			};
> +
>  			mmc0_pins: mmc0-pins {
>  				pins =3D "PF0", "PF1", "PF2", "PF3",
>  				       "PF4", "PF5";
> @@ -440,6 +471,25 @@ mmc2: mmc@4022000 {
>  			#size-cells =3D <0>;
>  		};
> =20
> +		nfc: nand-controller@4011000 {

Nodes are sorted by memory address. So this one should be moved before
mmc2 and possibly others.

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
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&nand_pins>, <&nand_cs0_pin>,
> +				<&nand_cs1_pin>, <&nand_rb0_pin>,
> +				<&nand_rb1_pin>;

Are you sure that each nand device will use exactly this pin configuration?
IIUC, not all chips will have two CS and two RB pins. If so, pinctrl nodes
should be moved to device DT and pins subnodes should be marked with
/omit-if-no-ref/.

Best regards,
Jernej

> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
>  		uart0: serial@5000000 {
>  			compatible =3D "snps,dw-apb-uart";
>  			reg =3D <0x05000000 0x400>;
>=20





