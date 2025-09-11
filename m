Return-Path: <linux-kernel+bounces-812720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F714B53BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C401AA0E93
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21E02DC79F;
	Thu, 11 Sep 2025 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bruhMaGO"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8AA2DC777
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757616407; cv=none; b=Td7l3+FLGpKFvufqRAc2lNNEKZCY1cBBGRFvvLuoL50GV+KuiX/Q7p4a+z+SDg7AjJwkjR4lDBmRJm1kLmkqJ2gxSLapf10zpOvq5CzKQOYIjwrGxTj1VpUz+QR4tXDsvwb5Y8amC51tqq2LJbWU1KWfrnyYExr4I8QqBZ8utcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757616407; c=relaxed/simple;
	bh=vHuwkKXYwD/cpOelPHVBXDenAhVWLgTP21RN1N3bYw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CAV/BJAqpDeis7evi+icOOs+RWeAfDEWgCbg9KpkmIXB4WJYqYXyL+5c+1Qiy7c4ViWAflDDJorI9M/KfLONJ3Om7wXHxbRZt1q610lTk8PZR/P9hMyxc7Rdt0sVFi5W8oIZo32f/prkjOTzevP9wEWeoCqOyd3L4p8VwGc+diQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bruhMaGO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so9324105e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757616404; x=1758221204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3Kk5PCcvdUwK+/fsu2vdafHJIiHRXspA2ECOuACp4w=;
        b=bruhMaGOAuwDUwHqHp7Welvx0uj2y3fdN4/en2LO10bUW7eDYRJvnXxLYn5l6ZTRlR
         jUHL8oA3iXikpoply/FJI8A3GPd8EKDOgotraiK1/UpVfniRJRH26O5mMKoaFn/RWi9n
         7NBsmk/j2r9XHXqyIyA+LeZJFwiYTX9FhoWz2qtWR1185xpBHDUs+ks53+cJjEJaE8uk
         JUT07taNRktzcPCf+U4+eERZPcbka7DjE0/CkvT71qP3WlvG7rNkD2Zfb2hB3DqKWQlo
         fQyXqTkU+UnhZRM0UMrpwaDHstctf9mpIP5Yr4CGVjDy2bg2cgLVbu+TPGQPUslc3QxN
         UlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757616404; x=1758221204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3Kk5PCcvdUwK+/fsu2vdafHJIiHRXspA2ECOuACp4w=;
        b=sIbUDfpec3Pp1VpBw1amI2p0LyQt6O4GuycgovpMiUOfmeT8OF9sjvS5M3qDpj+mxq
         l9Mk+5yYXSgEKaVM9bLHDlDI/3HMy0NNKPSB9rUILg6OtsuwkW/OQDILjZnNsV1EW+uC
         2wX82SjqVgu2swC8CRpimOgpwCsgl+Q9yR1d9MnfkZ57DT0iL02BN5NhW8fujKe37m6o
         g8/re12P708GbuZjmqDCuZmm1xkK5rSBYZdTzeGuJ4J7bxmyab4Pp3xeOm1D/SxPcjh0
         kyXuSQ3tsAT/4QLtHnfbIBnINNMHbZzqR6eOxV8YmYsIA87keON0O0tNr4aQq6QW5tYp
         92fA==
X-Forwarded-Encrypted: i=1; AJvYcCWTBBVO/jA0039JnYtg+dsisEKgzk+Hin2rtO0mf+GNGWXPyIFy1YqTM+Hsqy2DSounSSkkREnftOahqys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAQdQDq4BQxMqVzkoEbFeVFSQr/w4eZYazYJMa/oqBF3W/GqOZ
	uGHhd6D3W9TurCwedo5EcnA4rV4WKJzaS6HYepbPqqGiBK7ekIUFmiAU
X-Gm-Gg: ASbGnctVHiQjAOkmNu1A8LzooadJ6s4CFWctinEr+vN6zG7BvVJMu4Sadk1003Qt3CJ
	cpi+9d1KCfHV7cNDiCwisFyj+7XP8fKrVfjJ76KeVrnh1b2hrBTP7q4nNxXe+YQW51RKHRdhGsi
	+Tn9SUz6EugS5e9KyOukukuAF1P+PYIU6W8mFvCVthUGUCZ+QLt8gbhMimAROjn423aXiWg0hxr
	YxMP3EBqskESre+9pfXO1DQJfhg/iW9jN70z2VaFDVZaFG3+ZxKqj//ZACMnT60facm4fG8Rd5x
	iCIvXxLrTKcKrmO9vxD2HcAufZR6/JHHT+OfikDRQJqfGH3qeqsHCEirs5egeUYv06PJFL2JOv7
	ROCvDoXSyuj/8kbQks2PPWs4/njekGeZz7aU+EDf+YPUqXHQJq9LsAPUK/x25Ry6Be0bB2X5PLG
	HW01z7d3BCH0LKZ3lExnc=
X-Google-Smtp-Source: AGHT+IGPPdj04vc6Z8WnuiT1sf/ZoXQr56xVPN5ocFP5ISIHChh24Q+/p9n0LHx8H0kAPJH/zR+ueg==
X-Received: by 2002:a05:600c:1d03:b0:45b:86bb:af5f with SMTP id 5b1f17b1804b1-45dfd5b59c2mr43153985e9.6.1757616403529;
        Thu, 11 Sep 2025 11:46:43 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0157619fsm36045945e9.7.2025.09.11.11.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 11:46:43 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Chen-Yu Tsai <wens@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, linux-sunxi@lists.linux.dev,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] arm64: dts: allwinner: a523: Add NPU device node
Date: Thu, 11 Sep 2025 20:46:42 +0200
Message-ID: <1930957.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <20250911174710.3149589-8-wens@kernel.org>
References:
 <20250911174710.3149589-1-wens@kernel.org>
 <20250911174710.3149589-8-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne =C4=8Detrtek, 11. september 2025 ob 19:47:10 Srednjeevropski poletni =
=C4=8Das je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> The Allwinner T527 SoC has an NPU built in. Based on identifiers found
> in the BSP, it is a Vivante IP block. After enabling it, the etnaviv
> driver reports it as a GC9000 revision 9003.
>=20
> The standard bindings are used as everything matches directly. There is
> no option for DVFS at the moment. That might require some more work,
> perhaps on the efuse side to map speed bins.
>=20
> It is unclear whether the NPU block is fused out at the hardware level
> or the BSP limits use of the NPU through software, as the author only
> has boards with the T527.
>=20
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>


Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/=
boot/dts/allwinner/sun55i-a523.dtsi
> index f93376372aba..9676caf9bd4e 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> @@ -852,6 +852,18 @@ mcu_ccu: clock-controller@7102000 {
>  			#clock-cells =3D <1>;
>  			#reset-cells =3D <1>;
>  		};
> +
> +		npu: npu@7122000 {
> +			compatible =3D "vivante,gc";
> +			reg =3D <0x07122000 0x1000>;
> +			interrupts =3D <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&mcu_ccu CLK_BUS_MCU_NPU_ACLK>,
> +				 <&ccu CLK_NPU>,
> +				 <&mcu_ccu CLK_BUS_MCU_NPU_HCLK>;
> +			clock-names =3D "bus", "core", "reg";
> +			resets =3D <&mcu_ccu RST_BUS_MCU_NPU>;
> +			power-domains =3D <&ppu PD_NPU>;
> +		};
>  	};
> =20
>  	thermal-zones {
>=20





