Return-Path: <linux-kernel+bounces-639719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B925AAFB25
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 15:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F564C01BB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 13:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74B722B8A1;
	Thu,  8 May 2025 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uq8j7UTv"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E142288F7
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746710428; cv=none; b=AS7nxc8GaFzDaAlAYPPi3LFubHLItIIAHV+LmsFq+fNtmdxdW3dTMerjWziMY3C84NK+92k3VdXwEQO5f3odZCXTr/zUULVezrm9jMO8mLEotCbw8Nb5o4D8AH2E5L2uhR6UqjQVHrC4gPBVsgzqaMZgTktzPGs6Q86NOKOnRdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746710428; c=relaxed/simple;
	bh=Ggq7sLTVtObPJWu9TR8xbrcUROsW0mIC4OEmuNAJ6Sk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=STTHqxo7ORqqiYn1blZbuTNVt4Fpk3xK4cYDG5MKJhUAp9ap6/j9aODNlcapo2UwLL+s/ID9hdOoxQ00ESbACA2dWjvBQ2+xA4iMcyyS50tGOnwzI8JyWbo5VMyIHBswIh/CscK5na8XaWhBffw6sJ9XgCZ05iDmAzHPMEmfn6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uq8j7UTv; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74019695377so726107b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 May 2025 06:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746710426; x=1747315226; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jyuniMudFryF3hn/u/aLddug+sED3jw9d54qmOZEBFQ=;
        b=uq8j7UTvwrwVzSLVy0LbYG77QdyXvW2YloFBmRzvtahEdFy8HPMCjhqkTmQsCErfXM
         qxABsYvtURW4R/TEHJIgC/eCdwRe3XRgVvTMUameN8+XbSRtQxtosVohRzVuLeh6F7wQ
         2TGONHlJnSDK5J/MHF7KZ+upMREemjG9eMm31k7UdFRS5X+Xvl2uZtm6QPHLb6unHnZ+
         PgInSXQRJnpEfRFuNOiJeUaUJ0AfH7Uajgsi0FQM5ZHr8dnMv43OYL19XvevoV0+XB/o
         zRpeOn+Qc/tenfW9Vqx5iu5QTLdOIw9OoEUY+5I8QR5iKfyJXVwLwrw4bRI+JRxHEL0v
         hbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746710426; x=1747315226;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jyuniMudFryF3hn/u/aLddug+sED3jw9d54qmOZEBFQ=;
        b=EeiTBqQyVM1dFCJbvFcHPlka6CemrUNqW5aJ0v9ovL2GZQSOzXOiiamwivFIJAJyV4
         wi7UvxGJ7a6u6G+8AfmKEsiQAN+nTSBQuXYd9bckjsi8adVObUWhTOsfjxSXrjzHqbmt
         LWDC2Ngcj1Q5oyiofq8bcqws6lsgvq5AN+91ZSvyQNvhwYFhxI5jqgLwUlJwk95ZIAGH
         qdcFHuGzwsUxx0soHkXxrP0mD+MtwC6KJ7f7E1W4fm/SxKXSmm0OZC0UWksPLgSFtuy2
         3AjLsiqtEmotJw51rAS+FeRjMufwLvkyF8svUucsrJa6R1ZVz4bxg4m6xgmtFLqqngIc
         prfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+hyAu9X5rjRHBsL+tkxxkbaPBfbvIfeN+4TL+OJTCXc1QFfRcTy3mCb0sBEWQ3Te+ImvWR8y6Ru06RjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIPFVcrR1yT7ioDfbh7NhxeaasZx9U9dK4TQIQV77xsV1t+B5Y
	W6v2x5R7R3lrGK0dayPMxd29b9f8wK8x19qWanQfbKy7r/pfZ2BInBecyZ+g6k0=
X-Gm-Gg: ASbGncvreLI8KfDpzRkGIhfLjAe8C/TiH9MOB4uHl/idEAdiCyYI8BNNQpcKJlD9HbK
	uUormlPs2vKa7cRqbaUl9UaaTaStHCTm7JzYsied6m/h2Xq44NtQNzYGcqw4nUAGPxchY2jCswF
	+Zny6GVLKIAzvc4CR4tyS4MJlAqNkSlAzVmM1Vadp5i7vOFWPYTH/YZL0U3+6EBm7Nnsg0Z5Ou6
	j4MjHerMkge/Ao1wp0yBH4hpro3uGIkoQ/Tx6NT4VOnIkjbwJ91BMWKsZPGcPpd1acnXlk5kXnV
	uj2phM4AeMEzJiduIYKshLXewo2Ay55N5WD9SDA=
X-Google-Smtp-Source: AGHT+IET79Nq5FMlY1YATt34uIy9W6bQc0RASasVjOkYJxKwtGwvC9A4L+o3Stc03w0qdqPEQha4oQ==
X-Received: by 2002:a05:6a20:3d92:b0:1f5:8072:d7f3 with SMTP id adf61e73a8af0-2159b04ebd7mr5425027637.30.1746710425718;
        Thu, 08 May 2025 06:20:25 -0700 (PDT)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740b0d154b5sm1350253b3a.56.2025.05.08.06.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 06:20:24 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Sukrut Bellary <sbellary@baylibre.com>, Russell King
 <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Nishanth
 Menon <nm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 soc@lists.linux.dev
Cc: Sukrut Bellary <sbellary@baylibre.com>, Aaro Koskinen
 <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, Roger
 Quadros <rogerq@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Santosh
 Shilimkar <ssantosh@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Raghavendra Vignesh <vigneshr@ti.com>, Bin Liu <b-liu@ti.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/4] ARM: multi_v7_defconfig: Enable am335x PM configs
In-Reply-To: <20250318230042.3138542-5-sbellary@baylibre.com>
References: <20250318230042.3138542-1-sbellary@baylibre.com>
 <20250318230042.3138542-5-sbellary@baylibre.com>
Date: Thu, 08 May 2025 06:20:24 -0700
Message-ID: <7hbjs3tf1j.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sukrut Bellary <sbellary@baylibre.com> writes:

> Enable Power management related defconfigs for TI AM335x[1].
>
> [1] AM335x TRM - https://www.ti.com/lit/ug/spruh73q/spruh73q.pdf
>
> Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Arnd, can you take this via the SoC tree please?

Kevin


> ---
>  arch/arm/configs/multi_v7_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 37e3baa33b67..1d2600b5f975 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -985,6 +985,7 @@ CONFIG_EDAC=y
>  CONFIG_EDAC_LAYERSCAPE=y
>  CONFIG_EDAC_HIGHBANK_MC=y
>  CONFIG_EDAC_HIGHBANK_L2=y
> +CONFIG_RTC_DRV_OMAP=y
>  CONFIG_RTC_CLASS=y
>  CONFIG_RTC_DRV_AC100=y
>  CONFIG_RTC_DRV_AS3722=y
> @@ -1095,6 +1096,7 @@ CONFIG_TEGRA_IOMMU_SMMU=y
>  CONFIG_EXYNOS_IOMMU=y
>  CONFIG_QCOM_IOMMU=y
>  CONFIG_REMOTEPROC=y
> +CONFIG_WKUP_M3_RPROC=m
>  CONFIG_OMAP_REMOTEPROC=m
>  CONFIG_OMAP_REMOTEPROC_WATCHDOG=y
>  CONFIG_KEYSTONE_REMOTEPROC=m
> @@ -1146,6 +1148,8 @@ CONFIG_ARCH_TEGRA_3x_SOC=y
>  CONFIG_ARCH_TEGRA_114_SOC=y
>  CONFIG_ARCH_TEGRA_124_SOC=y
>  CONFIG_SOC_TI=y
> +CONFIG_AMX3_PM=m
> +CONFIG_WKUP_M3_IPC=m
>  CONFIG_KEYSTONE_NAVIGATOR_QMSS=y
>  CONFIG_KEYSTONE_NAVIGATOR_DMA=y
>  CONFIG_RASPBERRYPI_POWER=y
> @@ -1162,6 +1166,7 @@ CONFIG_EXTCON_MAX77693=m
>  CONFIG_EXTCON_MAX8997=m
>  CONFIG_EXTCON_USB_GPIO=y
>  CONFIG_TI_AEMIF=y
> +CONFIG_TI_EMIF_SRAM=m
>  CONFIG_STM32_FMC2_EBI=y
>  CONFIG_EXYNOS5422_DMC=m
>  CONFIG_IIO=y
> -- 
> 2.34.1

