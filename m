Return-Path: <linux-kernel+bounces-812717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D764B53BCE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67C5177C24
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550B623A994;
	Thu, 11 Sep 2025 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGMd3GXK"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DC0219A8A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757616368; cv=none; b=GHjol+W9c9AUVvWVRlbDV/LOAca7dmbZlMRFTFg2osxoFFoMTNa89Scgu02iskGPgK6kk7tclQZ1xPFFEOo2gfZt0n+CvE8YeVbJMiPyKKILVPjsIHL67oAKD5gZvo7xrH8YnRGfxwQRiEISQqgC89POqljtRIoS9fJnk50oadk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757616368; c=relaxed/simple;
	bh=45rVoyKHZDL7i67H3mSqnI9i+I5wrDeHw68fg9kOaTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2ELuMJm6gBLN59REjQRHlj2Xht8N3fnPtte9kGGxhJkFLE4rxjjcxXTEEoasVOl7A54TzM6NKZQSvVSMWnyS8JsMee/QJF6/ZJoteDMCGsAJY0O6z2xe+oXGXmMaE9J2Ut+pYZqgeU9xzOdfG95DHJ7/8q53lzYayLzJuZPUYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGMd3GXK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45cb6180b60so7749345e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757616365; x=1758221165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLnSFY5/QAndl78OHoWYd50tPooQqwlEKZC1g+O6M5s=;
        b=JGMd3GXKUcaQ6LOa3KHHAqOg8lciXpbjzpUpZCLPlJJOll0VItWNItYIA8OYY8J6ZF
         WOoXMhq5FIMC3Wa+ZSH1WeEfP1nBq9T49ts7RL630ydUBH/09xTi4K9/bisvdf7dRCNa
         v92VxhcWwqvz5MSnDETnUe1O8HAyu0JVQhkPUhTS5EsIxM5TzsHoUDRmGAuOwqOKCRZC
         YLMla4ggidFPxhEOtoVQzSCizQdkUFy3hdq1n0sV1SmwPr8gYTqDK4IRmsH3pmK1Bvr4
         tRr/rNDk8S6UjFT81q45VGHFYjC/sUwH3O4+RVgishi4e5XULWdr9VqJLeFoPkuYc3OQ
         dPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757616365; x=1758221165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLnSFY5/QAndl78OHoWYd50tPooQqwlEKZC1g+O6M5s=;
        b=mPzGYnq4KBnP1DW4qPoW/fuZanCE2g8wtGpS5g5POfsk5N7rbIcFDFh8uRoNALBtuB
         0e7ERDNSepQEO3XAk7K4+DNebX4hCETRll1YzjnErW40Akksv0nrhz5l+rMZbdGyL1FD
         jwuXZqVIghXolkmxg1rjHeHQtocFN7Zu0U5G4/6fNs0s/f3yAxEVPAjfIrPEai6Bap1d
         wE4BYvwwTMbnIshw4iisozekV9UurTQ3DmIbck5u9KxxuHJ1XuO9UTbcozZygjgmAIUV
         SAH6z4v9LGZSCnMdNb4Ycv2EsIPl9+1qC/I2y0mzhsEpKMZXxCWIvIKhyvqoVFxkI3mi
         X3bA==
X-Forwarded-Encrypted: i=1; AJvYcCVzf30M3ITLDWkJ2vJdEdNsORtibC//gtYgJxHiHh9CVHdVna5iA0Xdej8jFNu1h4o15N1vNTcvy48J0Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRBNt64vS5LHjDoyzoXqI6FM4ASQcXeUl2ZIUAIv+bkeeSxdfb
	IiScjau5nmbeB3dfyFWeA2tVuGf389U6cw80FMQLvs6W5R8buOZlOH6x
X-Gm-Gg: ASbGncumr3dRYutDkSmKykogJeZlvXyE8G8Q1wVAtk80790P4EChUfDbf27kJ8E83ge
	ty2DiA6dS/XmNRDdNNAGsyeYAZWj34nETOlP82jJ6P8J8U8wvhblLzPN2KzlxVE02oouJvXMJZU
	Tx5kQ6HXFtwNvWuInMnj5In/k9uOy1nzFGO7TOb5Zspl1AQ1tH5yuer8VNI+NcVsJSxIyKm0AN2
	chTxOH7RDMt6psD3hUo/2Vk2yDcNMjkdWHP4fmnPbOt0DX2BxBuvGLpoh1PZWSUU8fPe2lGoass
	8uE2/vTeLB19np/BlsDkEmBr5I7NL4+t4I/4rbeSSkBMzz2bE/9z+UDRCEK5hFqNMr4z9rAKyo+
	n0R/vQ7mSmFzS+bqdHcbWnBZgx9+/KOc++RkcQXTPPXSSxy3SgRhlcRg5apfLJHA92BHakwe9om
	iPeK0JywR88XAMPICjgTWQTfglEMDcww==
X-Google-Smtp-Source: AGHT+IH1eoAESwH3mOqBEu1EDRUwtU9bT+NVdrf9ZOgZBSqxSfPicQG9iVoecXpREjH59drqKdf77A==
X-Received: by 2002:a5d:5d89:0:b0:3df:c5e3:55f8 with SMTP id ffacd0b85a97d-3e765a12a7fmr375119f8f.54.1757616364866;
        Thu, 11 Sep 2025 11:46:04 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e3a91504fsm20727255e9.13.2025.09.11.11.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 11:46:04 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Chen-Yu Tsai <wens@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, linux-sunxi@lists.linux.dev,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] arm64: dts: allwinner: a523: Add MCU PRCM CCU node
Date: Thu, 11 Sep 2025 20:46:03 +0200
Message-ID: <2380002.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20250911174710.3149589-7-wens@kernel.org>
References:
 <20250911174710.3149589-1-wens@kernel.org>
 <20250911174710.3149589-7-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne =C4=8Detrtek, 11. september 2025 ob 19:47:09 Srednjeevropski poletni =
=C4=8Das je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> Add a device node for the third supported clock controller found in the
> A523 / T527 SoCs. This controller has clocks and resets for the RISC-V
> MCU, and others peripherals possibly meant to operate in low power mode
> driven by the MCU, such as audio interfaces, an audio DSP, and the NPU.
>=20
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> Changes since v1:
> - Enlarged MCU PRCM register range to 0x200
> - Moved "r-ahb" clock to the end of the list and added "r-apb0" clock
> ---
>  .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/=
boot/dts/allwinner/sun55i-a523.dtsi
> index 79bd9ce08c7c..f93376372aba 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> @@ -4,8 +4,10 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/sun6i-rtc.h>
>  #include <dt-bindings/clock/sun55i-a523-ccu.h>
> +#include <dt-bindings/clock/sun55i-a523-mcu-ccu.h>
>  #include <dt-bindings/clock/sun55i-a523-r-ccu.h>
>  #include <dt-bindings/reset/sun55i-a523-ccu.h>
> +#include <dt-bindings/reset/sun55i-a523-mcu-ccu.h>
>  #include <dt-bindings/reset/sun55i-a523-r-ccu.h>
>  #include <dt-bindings/power/allwinner,sun55i-a523-ppu.h>
>  #include <dt-bindings/power/allwinner,sun55i-a523-pck-600.h>
> @@ -825,6 +827,31 @@ rtc: rtc@7090000 {
>  			clock-names =3D "bus", "hosc", "ahb";
>  			#clock-cells =3D <1>;
>  		};
> +
> +		mcu_ccu: clock-controller@7102000 {
> +			compatible =3D "allwinner,sun55i-a523-mcu-ccu";
> +			reg =3D <0x7102000 0x200>;
> +			clocks =3D <&osc24M>,
> +				 <&rtc CLK_OSC32K>,
> +				 <&rtc CLK_IOSC>,
> +				 <&ccu CLK_PLL_AUDIO0_4X>,
> +				 <&ccu CLK_PLL_PERIPH0_300M>,
> +				 <&ccu CLK_DSP>,
> +				 <&ccu CLK_MBUS>,
> +				 <&r_ccu CLK_R_AHB>,
> +				 <&r_ccu CLK_R_APB0>;
> +			clock-names =3D "hosc",
> +				      "losc",
> +				      "iosc",
> +				      "pll-audio0-4x",
> +				      "pll-periph0-300m",
> +				      "dsp",
> +				      "mbus",
> +				      "r-ahb",
> +				      "r-apb0";
> +			#clock-cells =3D <1>;
> +			#reset-cells =3D <1>;
> +		};
>  	};
> =20
>  	thermal-zones {
>=20





