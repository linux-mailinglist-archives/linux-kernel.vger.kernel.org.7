Return-Path: <linux-kernel+bounces-790032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FD1B39E86
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6862B1B22AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0647131196C;
	Thu, 28 Aug 2025 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oORpWphW"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8C9310628
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387114; cv=none; b=V5z8cIslWfFsTZfcnbFbGObCQCP+DTginbaco+xKK/mt8eErckqRGiReELJlEkC1aV3AnZr/3D7VuWIQzrez01SNVGK5d0SV3idxQrwsvih8mOQ5ckJnDIgL6bgDZEkaudawQl+Cp8Z4Ap9s64MsTBU+DWMI6UBg2NBr+vRxiDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387114; c=relaxed/simple;
	bh=ebhj/zH63szQOxrn2XmKEdObSLoftIObuFab2TP5dTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rImfvaa30cz2V+E5RUt1k3PhsrimZtyK7SzlgDkbupfEnOleWA4vJxKTDEkFpT0Kiv8CoUw4o4Bkd+owOgpZ0RMmzoD46M3xz0pke0IaY+MhQTfMG28yOD5raekQiko4p1R+A/wCBSh9qKU9lJolXkzswUMNM6ykVjoMM1jMvfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oORpWphW; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afe84202bb6so111199066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756387111; x=1756991911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ViZhgiI208mpprvGOd6oxNdz3FM6ZQalsGn/kG8/O+A=;
        b=oORpWphWN9cY8aM8/UiVD8VlC4Mn/GWm2SszlmT/asgvLyRZkC/c8PX9sYlUEwnMhr
         mpwlJKUlYmhH75xiVSe3XHqidTm5LgMymbthbNQZeXqRjJxO6uHehLqV6+gCrPTIwgXp
         Wp5soukZlFm6a9FOc+2FNVTeqA6wSzNq96R00wUldfZ+l5iHInG2C0sTcfLgf3mBY3nL
         9iCbi5jiQhrj9RPlPpPVa5MsV8XNPYNQ97Ajg1uznWpvHvpEmxPk+D+PD9lAqkx7P4+H
         dfoab2OWtAtcKj7Nk6dhOpufxPsUq2LQzCvkUP+Q5PP5k3yusWFvayGx8Yqk8Lrvu8Uz
         aQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756387111; x=1756991911;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ViZhgiI208mpprvGOd6oxNdz3FM6ZQalsGn/kG8/O+A=;
        b=DwK+5nIDDba7CoaYrSJLHe/JgcYg38n0AoFL53yC26h+bbWT7BU0EMp514jl+RjAYk
         CapEb7HM3nKzhdQdJY3ytA+TWUvs/7GOSyYWZWwLaQV5tQ9XWYKr0mI4UGJk4JE2pb0b
         FbFOLAW3HkY5v2XGWsgibfB4rF7LSz/jKlnxSr93ge9GZSmVr87UOteXLuwlyrhju79q
         udJKlM+63CieKUziG9NH+S84w92fT5y9T9Xmt3SiIeB503dq9yGEKyZbYSRbSelT8OgH
         wX4J8qRv3EFa1th3oeh56Nnpy9vB9WoOu4ri3+u/kBSNkghdKp3HqJR1hmzDMy25m6wM
         nZaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu7xslR5Nu2wgmG/IHMj/hAd+ZYeYs1tsxVBZvNi8fvw0bSeYlkYhbHsQifwXvT/64HC6dRVJOTWbCZks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcG4whGyGujOown9y/tUPx1at26R//Vshjg9Bvn6ZynB6OAgBp
	1gnUCCqInf8O03XJJdso6qhdXdOT/d+0tehc9E3c7bjTVezAs9lp70GIr6m0Mo3CUIk=
X-Gm-Gg: ASbGncuGNro4Ru7v996XwVpSODZsH9/yN6J9LJYSxgdYXzj1tHEv6YBVyUzRP/9ZFKh
	M8ibiW3pBOVv0Wqd7ss6XNRZysBJ3L5YABxqwpe51gLRRToqbLIskGxW3cuZ3Jzw1NmnyfOYBiH
	/JYmrEkkSBfDYIoecEPQ6gUFPk5AeatC6UaMSnmih/86Kq27qyDg7AvjBKNvvJtdSHVWOoXoVxs
	zjW7o+UPc3R3OYhLB3iUVYxBmIVmS2as89OC2tDcBzHUo8Y2Eo0Pz95syyOYUtIRAckiYgXIB/Q
	tVfl3db1c34z4KQ/+gbr0+vj0d8r/aIh23wePKk0oE9NxSGcMNj4+mJr2JypRa7ti5/CVTBSsxT
	oRrHVDOQDcU2f2fqArSY7Vt+DdPQPWPQ9DEWnPjtzoYSnBNZiiYSS7pgPHWkp/u8R+Fjy9ePnSJ
	SQJ0Z2F+xPQGI6
X-Google-Smtp-Source: AGHT+IEaSNs6TM+t6ZkGhDUEgtd04oIngPsTBonqSpot3F8/HKB8oZ6LSxQKQNPdYyIrbplDJe/VjA==
X-Received: by 2002:a17:907:7f90:b0:afe:82ef:5433 with SMTP id a640c23a62f3a-afe82ef59a0mr1449610066b.10.1756387110829;
        Thu, 28 Aug 2025 06:18:30 -0700 (PDT)
Received: from [10.41.150.230] ([77.241.232.9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe790e382csm945788466b.79.2025.08.28.06.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 06:18:30 -0700 (PDT)
Message-ID: <1b00069b-e9b8-411f-9a66-de449ce4420d@linaro.org>
Date: Thu, 28 Aug 2025 15:18:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/13] arm64: defconfig: enable rockchip camera
 interface and mipi csi-2 receiver
To: michael.riesch@collabora.com, Mehdi Djait <mehdi.djait@linux.intel.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Gerald Loacker <gerald.loacker@wolfvision.net>,
 Markus Elfring <Markus.Elfring@web.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Collabora Kernel Team <kernel@collabora.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Alexander Shiyan <eagle.alexander923@gmail.com>,
 Val Packett <val@packett.cool>, Rob Herring <robh@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20240220-rk3568-vicap-v10-0-62d8a7b209b4@collabora.com>
 <20240220-rk3568-vicap-v10-9-62d8a7b209b4@collabora.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20240220-rk3568-vicap-v10-9-62d8a7b209b4@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2025 01:26, Michael Riesch via B4 Relay wrote:
> From: Michael Riesch <michael.riesch@collabora.com>
> 
> The Rockchip Camera Interface (CIF) and the Rockchip MIPI CSI-2 Receiver
> are featured in many Rockchip SoCs in different variations.
> Enable the drivers for them in the default configuration.
> 
> Signed-off-by: Michael Riesch <michael.riesch@collabora.com>
> ---
>   arch/arm64/configs/defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 58f87d09366c..625cb5b47fb5 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -876,6 +876,8 @@ CONFIG_VIDEO_RENESAS_FCP=m
>   CONFIG_VIDEO_RENESAS_FDP1=m
>   CONFIG_VIDEO_RENESAS_VSP1=m
>   CONFIG_VIDEO_RCAR_DRIF=m
> +CONFIG_VIDEO_ROCKCHIP_CIF=m
> +CONFIG_VIDEO_ROCKCHIP_CSI=m
>   CONFIG_VIDEO_ROCKCHIP_RGA=m
>   CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
>   CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

