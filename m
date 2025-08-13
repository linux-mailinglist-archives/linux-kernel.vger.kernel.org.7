Return-Path: <linux-kernel+bounces-767534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FFCB255AB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D86561F34
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126693009C0;
	Wed, 13 Aug 2025 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NOLbygg8"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CC13009C6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121060; cv=none; b=JvJ4NUJAXKzRFa+QxIBilHMDme4edWGMKbQPyWlYDZgEVWoPUwdMGkifBOpaT1lZTZPc79eaO3sQffiDTgpq/Nz2qmO96Klg3ltLyIc0v/iovHlIMmokTSXqPzCBtZ5o4xiArk0edWmcHo5NlMGZHhiECo+GOmztMQQOnrEKpHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121060; c=relaxed/simple;
	bh=OIHFNFGpI3Nnr1laP8Tk/ZYcGpLTmB4+VLlc5+ifYaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgSg+Sq0gmt/hJE63q90kAByoR6KXUv5VkoIVTBH40KR3ouECL8z+8UnlG/770BBTAGdWDXuJ1yhNiNN4zK8+m1dfQpnu+eL4HSfop/tpqaibH1m8+2ip1xjQhmeIoExU2lzbSZHllUXvY0uoC5dc/iNyKZX8w2iFOn2g2ufkAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NOLbygg8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9a342e8ffso229625f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755121056; x=1755725856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/R0PLr1UJ15LH0yUiipvHzrelupSAOLxlwfOAUkKpZE=;
        b=NOLbygg8wCZ7xDS8sY6/8XVxhJIdZ/UyZHh5Rk+mxXuE2sGvyvcgxK4gSBj+gUJrNg
         Mfy6CDfSnfDisC7Ay48wHY55NwBLsyN+LuEfZNJqyZtlNwBzyQhgN88KY6nzAHmjq/8Q
         4TMmf3pmFu7Y7AzqpLhTS+PtvENEPjWnb2UN1Q9p7H3kLxQQmFW7dq3wwu+f9ShjwKxf
         9l8xeFWW6SLzvOnHZgOhSzt7jAsCkEU60DfVtMpzNzzEBkD229b6LBUAwGTeIBkH2naJ
         ah/Ejnf+gyZlBqTuK5fsJ9WX6rU/N094XaevnXaucRsuWP5NJsQMLLsmJxOrqKrCeMgW
         vM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755121056; x=1755725856;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/R0PLr1UJ15LH0yUiipvHzrelupSAOLxlwfOAUkKpZE=;
        b=icMIJzbpEIJLNpPNtLqTkk7Kw3ibW8V9T7trsabqEPE7VPbKZop2BRSdUUuQiyePKK
         gF/FitbhNDmMse3jkfH7ucUuo55DW3SufomVf5Rd0RxeEWRGZGeprnlXnkTQ/XtPGlFK
         2/MRAfEuHKJHk671uwcVYGcXLje7sIjwiktOtfrdjHge112GYqKCDOWCnw2jP53g3ovz
         1P0mu1AqbBYHZ7BU5+vp2zoc3U3pvSj1PN3ZK4M9cGLoLbkd0HkWAZBdaaKrwtpwDuSn
         d10ATeuSFZjRZt+Lt+1RMj04Xo1a+E2wG6MoNBkX+YUikK7JbMk+JLKayKrRqyhrewoM
         c3lw==
X-Forwarded-Encrypted: i=1; AJvYcCVRPU4mhDLmHmRXs8RN9bgOp3Ht/VLMJJPHkceu5+ooaA+991sdOHVuZ1NEggXZLZ2RRQNO1PoUk3A5IHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQIzseOzqMxBbcQYsqFLNIsusT3j6uhFh5l1fJghX4y02vgYOu
	qI/c3EiyxOBMxmn4UAYONWEsGzioJYy4sl5J+T6WZzD1tyMr5kh1kswaaC6KCrWSXII=
X-Gm-Gg: ASbGnctz4VuRHXyUR8PxHHfXNBD9GLyEkzo0YoTJR/GQ4wMOyF/r8O+cyP6m3XtBW5A
	TIkqV54ji5be3Km3YitoBzcNiu4dFGuPP95KGg9xMZEBqjRKCzlsMxVyNGejUhBJqUHTGt5wRrh
	PBz4S2zw7hA55ECZUzHKE4kn3RiCEpNERDa80lwXlALebflx1aEVCXhTvXxQSAiP/ONXAQxsdAH
	PAH4jsyiqFdvcV6DxGNKqsnw/SCorJ+JIk8ELfPNRjgKPyG56NuOalm/10li0aVWkbGybSwR+bz
	TSkKHklERbPP81Dqz/KiHWEolnbZKZsQoWW31jA673PlBFHi/RbuIMBYD5yJi6egXsgebUkcWrX
	O0658GPwENr5RvBwTfZaIxVLzUseTvwWwJ4DSp/gqrsdI7sPUZEp7jQ1L2I17D+wU
X-Google-Smtp-Source: AGHT+IHDgkAiDoUCfIGsD1JHcyl15RLIs40KyXWWTRPJ8npwc6pR4KZc9S2TTnaRFinIsu9wVY/smQ==
X-Received: by 2002:a05:6000:400b:b0:3b7:775d:e923 with SMTP id ffacd0b85a97d-3ba506624edmr206323f8f.4.1755121056198;
        Wed, 13 Aug 2025 14:37:36 -0700 (PDT)
Received: from [192.168.0.13] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a540945sm15247815e9.26.2025.08.13.14.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 14:37:35 -0700 (PDT)
Message-ID: <03947c1c-1d60-472b-883f-c9875df20245@linaro.org>
Date: Wed, 13 Aug 2025 22:37:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: qcs8300: Add support for camss
To: Vikram Sharma <quic_vikramsa@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
 cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250813053724.232494-1-quic_vikramsa@quicinc.com>
 <20250813053724.232494-8-quic_vikramsa@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250813053724.232494-8-quic_vikramsa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2025 06:37, Vikram Sharma wrote:
> Add changes to support the camera subsystem on the QCS8300.
> 
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/qcs8300.dtsi | 171 ++++++++++++++++++++++++++
>   1 file changed, 171 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> index 3cf1d4bc7e4a..538b55a89f28 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> @@ -4641,6 +4641,177 @@ videocc: clock-controller@abf0000 {
>   			#power-domain-cells = <1>;
>   		};
>   
> +		camss: isp@ac78000 {
> +			compatible = "qcom,qcs8300-camss";
> +
> +			reg = <0x0 0xac78000 0x0 0x1000>,
> +			      <0x0 0xac7a000 0x0 0x0f00>,
> +			      <0x0 0xac7c000 0x0 0x0f00>,
> +			      <0x0 0xac84000 0x0 0x0f00>,
> +			      <0x0 0xac88000 0x0 0x0f00>,
> +			      <0x0 0xac8c000 0x0 0x0f00>,
> +			      <0x0 0xac90000 0x0 0x0f00>,
> +			      <0x0 0xac94000 0x0 0x0f00>,
> +			      <0x0 0xac9c000 0x0 0x2000>,
> +			      <0x0 0xac9e000 0x0 0x2000>,
> +			      <0x0 0xaca0000 0x0 0x2000>,
> +			      <0x0 0xacac000 0x0 0x0400>,
> +			      <0x0 0xacad000 0x0 0x0400>,
> +			      <0x0 0xacae000 0x0 0x0400>,
> +			      <0x0 0xac4d000 0x0 0xf000>,
> +			      <0x0 0xac60000 0x0 0xf000>,
> +			      <0x0 0xac85000 0x0 0x0d00>,
> +			      <0x0 0xac89000 0x0 0x0d00>,
> +			      <0x0 0xac8d000 0x0 0x0d00>,
> +			      <0x0 0xac91000 0x0 0x0d00>,
> +			      <0x0 0xac95000 0x0 0x0d00>;
> +			reg-names = "csid_wrapper",
> +				    "csid0",
> +				    "csid1",
> +				    "csid_lite0",
> +				    "csid_lite1",
> +				    "csid_lite2",
> +				    "csid_lite3",
> +				    "csid_lite4",
> +				    "csiphy0",
> +				    "csiphy1",
> +				    "csiphy2",
> +				    "tpg0",
> +				    "tpg1",
> +				    "tpg2",
> +				    "vfe0",
> +				    "vfe1",
> +				    "vfe_lite0",
> +				    "vfe_lite1",
> +				    "vfe_lite2",
> +				    "vfe_lite3",
> +				    "vfe_lite4";
> +
> +			clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>,
> +				 <&camcc CAM_CC_CORE_AHB_CLK>,
> +				 <&camcc CAM_CC_CPAS_AHB_CLK>,
> +				 <&camcc CAM_CC_CPAS_FAST_AHB_CLK>,
> +				 <&camcc CAM_CC_CPAS_IFE_LITE_CLK>,
> +				 <&camcc CAM_CC_CPAS_IFE_0_CLK>,
> +				 <&camcc CAM_CC_CPAS_IFE_1_CLK>,
> +				 <&camcc CAM_CC_CSID_CLK>,
> +				 <&camcc CAM_CC_CSIPHY0_CLK>,
> +				 <&camcc CAM_CC_CSI0PHYTIMER_CLK>,
> +				 <&camcc CAM_CC_CSIPHY1_CLK>,
> +				 <&camcc CAM_CC_CSI1PHYTIMER_CLK>,
> +				 <&camcc CAM_CC_CSIPHY2_CLK>,
> +				 <&camcc CAM_CC_CSI2PHYTIMER_CLK>,
> +				 <&camcc CAM_CC_CSID_CSIPHY_RX_CLK>,
> +				 <&gcc GCC_CAMERA_HF_AXI_CLK>,
> +				 <&gcc GCC_CAMERA_SF_AXI_CLK>,
> +				 <&camcc CAM_CC_ICP_AHB_CLK>,
> +				 <&camcc CAM_CC_IFE_0_CLK>,
> +				 <&camcc CAM_CC_IFE_0_FAST_AHB_CLK>,
> +				 <&camcc CAM_CC_IFE_1_CLK>,
> +				 <&camcc CAM_CC_IFE_1_FAST_AHB_CLK>,
> +				 <&camcc CAM_CC_IFE_LITE_CLK>,
> +				 <&camcc CAM_CC_IFE_LITE_AHB_CLK>,
> +				 <&camcc CAM_CC_IFE_LITE_CPHY_RX_CLK>,
> +				 <&camcc CAM_CC_IFE_LITE_CSID_CLK>;
> +			clock-names = "camnoc_axi",
> +				      "core_ahb",
> +				      "cpas_ahb",
> +				      "cpas_fast_ahb_clk",
> +				      "cpas_vfe_lite",
> +				      "cpas_vfe0",
> +				      "cpas_vfe1",
> +				      "csid",
> +				      "csiphy0",
> +				      "csiphy0_timer",
> +				      "csiphy1",
> +				      "csiphy1_timer",
> +				      "csiphy2",
> +				      "csiphy2_timer",
> +				      "csiphy_rx",
> +				      "gcc_axi_hf",
> +				      "gcc_axi_sf",
> +				      "icp_ahb",
> +				      "vfe0",
> +				      "vfe0_fast_ahb",
> +				      "vfe1",
> +				      "vfe1_fast_ahb",
> +				      "vfe_lite",
> +				      "vfe_lite_ahb",
> +				      "vfe_lite_cphy_rx",
> +				      "vfe_lite_csid";
> +
> +			interrupts = <GIC_SPI 565 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 564 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 468 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 359 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 759 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 758 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 604 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 477 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 478 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 479 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 545 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 546 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 547 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 465 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 467 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 469 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 360 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 761 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 760 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 605 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "csid0",
> +					  "csid1",
> +					  "csid_lite0",
> +					  "csid_lite1",
> +					  "csid_lite2",
> +					  "csid_lite3",
> +					  "csid_lite4",
> +					  "csiphy0",
> +					  "csiphy1",
> +					  "csiphy2",
> +					  "tpg0",
> +					  "tpg1",
> +					  "tpg2",
> +					  "vfe0",
> +					  "vfe1",
> +					  "vfe_lite0",
> +					  "vfe_lite1",
> +					  "vfe_lite2",
> +					  "vfe_lite3",
> +					  "vfe_lite4";
> +
> +			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &config_noc SLAVE_CAMERA_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
> +					<&mmss_noc MASTER_CAMNOC_HF QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
> +			interconnect-names = "ahb",
> +					     "hf_0";
> +
> +			iommus = <&apps_smmu 0x2400 0x20>;
> +
> +			power-domains = <&camcc CAM_CC_TITAN_TOP_GDSC>;
> +			power-domain-names = "top";
> +
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				port@0 {
> +					reg = <0>;
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +				};
> +			};
> +		};
> +
>   		camcc: clock-controller@ade0000 {
>   			compatible = "qcom,qcs8300-camcc";
>   			reg = <0x0 0x0ade0000 0x0 0x20000>;


"Eat recycled food, it's good for the environment and okay for you"

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

