Return-Path: <linux-kernel+bounces-790052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70126B39EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024993A8EAA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA8531196D;
	Thu, 28 Aug 2025 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bAZTLsHO"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99D3311957
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387509; cv=none; b=QWLAHqcHPQrfACLHiPeDA2IuBttmUdDlSVB0lNJzhHuK9q73KFZS7EzGsT/uTNIRvl33SrXgDCYcO6m5tm4dp+I1tMKdSaGn4Eynz1sfS5ztC/GsU3NXTDW6o/BNoFqsr8ojMraz9PlT2vyh+A6mZVw5z0D4t8dXOeC9bzUjtTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387509; c=relaxed/simple;
	bh=Hx62hC2efafCdbQDxHi2B7OiIdyW02BYTfvtgOt7YqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2fNlk1t5bzU+tryjMmvmNGtBiK5Z+e8N4Gu9ic8MVNhodAi6SHscJbWXwWRFWfimTOSSTU1CW2xN8k3FQ1HT7NakgHAYpGs/ibEl4LBmZtMPKpaS4aig5DtrwAPJZ7glOLiSUHQBfLQ37zIpgHnM/AzBz8AR+P3E7L3UrzJwsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bAZTLsHO; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afe9358fe77so65452366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756387506; x=1756992306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KP6GeI4QNlyVzRWNe4PL6HeP+siA3vt2wqk6FJm5c6M=;
        b=bAZTLsHO/Ek0iJUlU9+BwBvPmcc66TMQHGAezBrvw612q33DXdmoSIsAgzm4j3dlkm
         p7HtmNg6Lupz32URTUJBZSODp/eWybdEK3dIAHP+PkhxCRPGqZaxLRyDcOfC8/CWTNFK
         I35rFlORfP8G4dYCd+i+oo6L7MDidxJcbJrj8aj1YfWyUODCRgbqh1Swmj94DUmhEcGa
         OeSrPfiNxZ4Bg6pJJpW1OB8F+e2dWeoQCJGqjJlKSOcKFF8wuU07AoHV0zh50ufGqSIw
         /9r9no2ATg2pudkbron5FcNnVhwF2WH0EPB9v8xo9cFvX7Sskm8+x1UrtHdR3yQ5k2fI
         Yoxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756387506; x=1756992306;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KP6GeI4QNlyVzRWNe4PL6HeP+siA3vt2wqk6FJm5c6M=;
        b=jNWDSiiBeFMZJlsvMf11hNtSlepzckLY61OZhEybi+Esi7UetQ1vCs4iV+qfvN9wW4
         ykszNCy8yaItvIzDChFsnFCEGJCWKWPT0HydIenUUanjLvEN5Xuiwn4pYGx21VKvTHLE
         m2QX5RBdYy5Ihrn8twSa/XVmmhZHgDp8N5P3FyHFv2Jm9URG78NX+91g7keSSAggwVvd
         L80IvdoxS+NIg8W+sXM5Qhdl+znhY9HBFnJ+uZjSflkVQy5JLsKDK8mravZ+T9/aJPU/
         3JEckslCvruL+zvVygCCCNBKfB7tUDEn0xyUm5Hw7HGQpkjuh5YoM3jsXbJdBuqGr9qo
         lqhg==
X-Forwarded-Encrypted: i=1; AJvYcCXmw1tD9QtLTbMG3USkkNX+vanAv6wjuFDh9Hu9EflWWmu4MsKKYJMcrAuufFiGbsI/WabQfYO0Ctp0IwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMNEFjYVzSdi2C8yoc4y77L8udWv2T7HxfDPklD6FsP42ha7Kj
	WXZkKH24iPEaua8R/M3Sgfkw7qawR6AhMbbsbchtqyKZhsPo0GCwq8+YxaU9UgwuFFI=
X-Gm-Gg: ASbGncutwV9mTR8jw+OPJly/GB9BvjMXkqWDyhk+Ajra/ReoQPLud2+H52JcuHssGnh
	WaVleA/GIilMumD03CTX3wiuqP9KSfRjue4ov1qUAUIqvMLqFIEdzzeeKlVbgyaY8JTsaX5LGpS
	K4UjNTtbX+Kayxwz3zHXxKQOcPim9fEqxJGG1DrDqbD6M08EcX8Kesn0LvpLIwn7WAwMzIZ17Nj
	pUNDaY9twcP8xBJXuetkJFGkh4zrhd0tP7eBD5/xFgl15XlsJ0oIuiG1oKpaB7I2Fz4kfI7Pn3Y
	rwXSuUUGproO4X5DcAupNrJ2arR0tVRK7Ec2bkyo2FBpR4KLjOClnyrKmS5GOvs4DZ5dU7ae2AW
	VfMdpI5rFpl3hzQqNPnmR8qQLRPhVMjFQYC2dMchma6u+M4c147QWLqgR37Lbz0rNQ6R8VNX1ic
	29kg==
X-Google-Smtp-Source: AGHT+IHnstlza8K9C5w6vOWcSWmYNQEhQr+qMHGXGhuf3pnVngAd6eVaQO3IZGsyPfF2zyp3aTQhtA==
X-Received: by 2002:a17:907:968c:b0:afd:d9e4:51e7 with SMTP id a640c23a62f3a-afe296bceabmr2217290166b.63.1756387505863;
        Thu, 28 Aug 2025 06:25:05 -0700 (PDT)
Received: from [10.41.150.230] ([77.241.232.9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe79fba62dsm926560266b.100.2025.08.28.06.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 06:25:04 -0700 (PDT)
Message-ID: <ecbde2de-d08a-4951-82a4-fb73760de73e@linaro.org>
Date: Thu, 28 Aug 2025 15:25:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 10/13] arm64: dts: rockchip: add the vip node to px30
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
 linux-rockchip@lists.infradead.org, Mehdi Djait <mehdi.djait@bootlin.com>
References: <20240220-rk3568-vicap-v10-0-62d8a7b209b4@collabora.com>
 <20240220-rk3568-vicap-v10-10-62d8a7b209b4@collabora.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20240220-rk3568-vicap-v10-10-62d8a7b209b4@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2025 01:26, Michael Riesch via B4 Relay wrote:
> From: Mehdi Djait <mehdi.djait@bootlin.com>
> 
> Add the device tree node for the PX30 Video Input Processor (VIP).
> 
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> [added cosmetic changes]
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> Signed-off-by: Michael Riesch <michael.riesch@collabora.com>
> ---
>   arch/arm64/boot/dts/rockchip/px30.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
> index 46f64cd33b9b..ef52879d6a73 100644
> --- a/arch/arm64/boot/dts/rockchip/px30.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
> @@ -1280,6 +1280,18 @@ isp_mmu: iommu@ff4a8000 {
>   		#iommu-cells = <0>;
>   	};
>   
> +	cif: video-capture@ff490000 {
> +		compatible = "rockchip,px30-vip";
> +		reg = <0x0 0xff490000 0x0 0x200>;
> +		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru ACLK_CIF>, <&cru HCLK_CIF>, <&cru PCLK_CIF>;
> +		clock-names = "aclk", "hclk", "pclk";
> +		power-domains = <&power PX30_PD_VI>;
> +		resets = <&cru SRST_CIF_A>, <&cru SRST_CIF_H>, <&cru SRST_CIF_PCLKIN>;
> +		reset-names = "axi", "ahb", "pclkin";
> +		status = "disabled";
> +	};
> +
>   	qos_gmac: qos@ff518000 {
>   		compatible = "rockchip,px30-qos", "syscon";
>   		reg = <0x0 0xff518000 0x0 0x20>;
> 

Now that I look at the rockchip dtsi it appears newline scarcity is the 
norm, you can disregard my suggestion for your example in the previous 
patch so.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

