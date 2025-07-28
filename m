Return-Path: <linux-kernel+bounces-748045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43080B13BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E029A189E52C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA72263892;
	Mon, 28 Jul 2025 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I6ra81j3"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A734C26A0A0
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710430; cv=none; b=tpXboE71Hp6+HEh7mWGLmBZOQyRW8qu9+ZoJ9i4eGcHO9ldVX0M/M8w5kgTP1WeOLSk5LaHw4yG3nPmk1ZplYRQ13KdjF6DPOEZ1RcDOXSJyaWFRFaKbxL8i9CvAgTvg3xpL3F4f8/F1cEGyCJfY6e65cFOar69M95k7b3wMPFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710430; c=relaxed/simple;
	bh=52ZUHd2Om0Jzwyc4KQ3ebBTYlP2jpX6ViVgWEvN56jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=io8GN3n58KgpaW3BcJZG+hj1treDg8tLGfX2jTgF02e5c2RRGM/+6fXpADr2JHkdsTbbmSgI6az3GmEbOsXnQSdVvJDvOaxUF+8dSukTRqw2/rb+T3SYOoPq1umLAiLSbyeKzO0REVrh84T/iKkklc+0fVbZE+ulZSMPCf+VkXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I6ra81j3; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b78bca0890so330650f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 06:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753710426; x=1754315226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4aaAoqv5+ouHYGZZLFjrXRilOOwM4Jup3fbChPgYdkk=;
        b=I6ra81j3r0UApKo4MKIgFTWUnHVe3SpxVPMX9j1mB6xVqPbcrJim+u+7KbAKWKXXTX
         4GNEHMZlPrnq9Qrw++J5LAlxfckWCFx5eZz4Tp7GRU4PcL49y9kR6cFsG1tMgk77fCp3
         +5/TY2xFrGM36UsC8lb+5Ko6a5iFuza0SBVFdywS2w1KbOzBGAsMqjcoiClbx8sOtM00
         tkwt9LKuTsOt2M9gNhU0i83cUoZnYdn62hhSXzeV835e5ceU56TgQTw9KCVBlzdlkUNM
         DWssd1eIhW2jSXcTl4HQD+oKAXq2b8pvq94g7SDhdbGzyhtBVE4F8wceP7Q95Nv126Al
         N6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753710426; x=1754315226;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4aaAoqv5+ouHYGZZLFjrXRilOOwM4Jup3fbChPgYdkk=;
        b=MC2Sz4BrEmbF67prOTE+EdAmM3y+VoNHGew+NI5dT+OAzPV9HOaPwu28x4sbnpNRxv
         Ppuniq+ep7W1nRYByrfTztPG2o9NMq5Oqg2dim8XK5QKdpaJcHlORfwcRAozfqadO5iu
         1OaBMcEEdNxgEPvjDBcDIq0MXW7aI7so4sohGdWCafIqbY09UlfiOddW/lRkT2hiiUxn
         ng++4IZEQgLoG5yaN5YwbPMz8BU8VwPWPAiCqEkl+s3fCKO6Yrl7IbUL6UJVMRKXfFOp
         UdRJeq2/MpGrr7+IHGr9Nrzz2Cjw0K3zbMVbrGwwFZLvEffw0N1LajdExw4dVjAo03kU
         OwRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNSp6xTwB/ajBICXl5QNE6rrmOFkRlAkTwQAOxMWsRPXzXOYcEZ8+mXPx08wKnLeGPxHEfHdoMJ3Bv0Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YypP5YMvnAjlcFFeXApBoXLBcoiWrrEy7OstTTwCmFF+qa6KVD0
	ZPwrSV2jwj4iFyoU3pdgQ2k4M9DxHE7QFGfEN2IYWDbYkYV3ZhgbcLDPW5Dz+PhJUjg=
X-Gm-Gg: ASbGncuM++ZQMRsKCuS4RWfrSF8Pxw0/6M55lG37WSTRHyXaJFQXWon55jjP5HJMptp
	Mfo7gpcI80i9Hs5Qn2kYKprogJ9O5N+MxdJj06SmnrLXL3oJHyZ26I9D30MG6UfaNJ/5C36wWHj
	SQGhwj/Kp27qHfk5xTbqw+2eJWkhNkizKG7A832xWYdF0k68f8EXCdSU7gAsTXKtZxYYLp42lO3
	OpRjMmmtOEyaUbBfjMIKrwhHivQwswUNIxRW/IKbe1eu6u8lZAnl4lHhyprTmN/+HhDXqPhllOm
	QEengkZ0FOuW9xF3zA0TlyTc79jy0yVPi+0dPxpipJsApnf61FRFQOwO7eK2U0yIl91/J9OVCxo
	d7MWfZGDkYH46cD2YINSFfVEZKXZUyyKuqI4Ggg/PL9j8ClWIDDkoGj32Agvg5BCD+QpgRKROuQ
	==
X-Google-Smtp-Source: AGHT+IEmyRdJ5hUcc+FCHw4q7fjwq2f7c66lh0lffLNTrZj+CMP5Khlz0+rxsLL4mi6tfmYQmWKZbw==
X-Received: by 2002:a05:6000:288c:b0:3a3:7593:818b with SMTP id ffacd0b85a97d-3b776732accmr9927466f8f.21.1753710425692;
        Mon, 28 Jul 2025 06:47:05 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705bccc5sm156569365e9.22.2025.07.28.06.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 06:47:05 -0700 (PDT)
Message-ID: <6560f783-c50d-4509-8937-f76553c8bbb4@linaro.org>
Date: Mon, 28 Jul 2025 14:47:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] media: dt-bindings: Add qcom,sa8775p-camss
 compatible
To: Vikram Sharma <quic_vikramsa@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
 cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, quic_svankada@quicinc.com,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Wenmeng Liu <quic_wenmliu@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250703171938.3606998-1-quic_vikramsa@quicinc.com>
 <20250703171938.3606998-4-quic_vikramsa@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250703171938.3606998-4-quic_vikramsa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/07/2025 18:19, Vikram Sharma wrote:
> Add the compatible string "qcom,sa8775p-camss" to support the
> Camera Subsystem (CAMSS) on the Qualcomm SA8775P platform.
> 
> The SA8775P platform provides:
> - 2 x VFE (version 690), each with 3 RDI
> - 5 x VFE Lite (version 690), each with 6 RDI
> - 2 x CSID (version 690)
> - 5 x CSID Lite (version 690)
> - 4 x CSIPHY (version 690)
> - 3 x TPG
> 
> SA8775P is the first Qualcomm SoC to introduce a CSIPHY-based
> Test Pattern Generator (TPG).
> 
> Co-developed-by: Wenmeng Liu <quic_wenmliu@quicinc.com>
> Signed-off-by: Wenmeng Liu <quic_wenmliu@quicinc.com>
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../bindings/media/qcom,sa8775p-camss.yaml    | 361 ++++++++++++++++++
>   1 file changed, 361 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/media/qcom,sa8775p-camss.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,sa8775p-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sa8775p-camss.yaml
> new file mode 100644
> index 000000000000..b9f351546cd1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/qcom,sa8775p-camss.yaml
> @@ -0,0 +1,361 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/qcom,sa8775p-camss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SA8775P CAMSS ISP
> +
> +maintainers:
> +  - Vikram Sharma <quic_vikramsa@quicinc.com>
> +
> +description:
> +  The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
> +
> +properties:
> +  compatible:
> +    const: qcom,sa8775p-camss
> +
> +  reg:
> +    maxItems: 22
> +
> +  reg-names:
> +    items:
> +      - const: csid0
> +      - const: csid1
> +      - const: csid_lite0
> +      - const: csid_lite1
> +      - const: csid_lite2
> +      - const: csid_lite3
> +      - const: csid_lite4
> +      - const: csid_wrapper
> +      - const: csiphy0
> +      - const: csiphy1
> +      - const: csiphy2
> +      - const: csiphy3
> +      - const: tpg0
> +      - const: tpg1
> +      - const: tpg2
> +      - const: vfe0
> +      - const: vfe1
> +      - const: vfe_lite0
> +      - const: vfe_lite1
> +      - const: vfe_lite2
> +      - const: vfe_lite3
> +      - const: vfe_lite4
> +
> +  clocks:
> +    maxItems: 28
> +
> +  clock-names:
> +    items:
> +      - const: camnoc_axi
> +      - const: core_ahb
> +      - const: cpas_ahb
> +      - const: cpas_fast_ahb_clk
> +      - const: cpas_vfe_lite
> +      - const: cpas_vfe0
> +      - const: cpas_vfe1
> +      - const: csid
> +      - const: csiphy0
> +      - const: csiphy0_timer
> +      - const: csiphy1
> +      - const: csiphy1_timer
> +      - const: csiphy2
> +      - const: csiphy2_timer
> +      - const: csiphy3
> +      - const: csiphy3_timer
> +      - const: csiphy_rx
> +      - const: gcc_axi_hf
> +      - const: gcc_axi_sf
> +      - const: icp_ahb
> +      - const: vfe0
> +      - const: vfe0_fast_ahb
> +      - const: vfe1
> +      - const: vfe1_fast_ahb
> +      - const: vfe_lite
> +      - const: vfe_lite_ahb
> +      - const: vfe_lite_cphy_rx
> +      - const: vfe_lite_csid
> +
> +  interrupts:
> +    maxItems: 21
> +
> +  interrupt-names:
> +    items:
> +      - const: csid0
> +      - const: csid1
> +      - const: csid_lite0
> +      - const: csid_lite1
> +      - const: csid_lite2
> +      - const: csid_lite3
> +      - const: csid_lite4
> +      - const: csiphy0
> +      - const: csiphy1
> +      - const: csiphy2
> +      - const: csiphy3
> +      - const: tpg0
> +      - const: tpg1
> +      - const: tpg2
> +      - const: vfe0
> +      - const: vfe1
> +      - const: vfe_lite0
> +      - const: vfe_lite1
> +      - const: vfe_lite2
> +      - const: vfe_lite3
> +      - const: vfe_lite4
> +
> +  interconnects:
> +    maxItems: 2
> +
> +  interconnect-names:
> +    items:
> +      - const: ahb
> +      - const: hf_0
> +
> +  iommus:
> +    maxItems: 1
> +
> +  power-domains:
> +    items:
> +      - description: Titan GDSC - Titan ISP Block, Global Distributed Switch Controller.
> +
> +  power-domain-names:
> +    items:
> +      - const: top
> +
> +  vdda-phy-supply:
> +    description:
> +      Phandle to a regulator supply to PHY core block.
> +
> +  vdda-pll-supply:
> +    description:
> +      Phandle to 1.8V regulator supply to PHY refclk pll block.
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    description:
> +      CSI input ports.
> +
> +    patternProperties:
> +      "^port@[0-3]+$":
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port for receiving CSI data on CSIPHY 0-3.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +            required:
> +              - data-lanes
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +  - interconnects
> +  - interconnect-names
> +  - iommus
> +  - power-domains
> +  - power-domain-names
> +  - vdda-phy-supply
> +  - vdda-pll-supply
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,sa8775p-camcc.h>
> +    #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
> +    #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
> +    #include <dt-bindings/interconnect/qcom,icc.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/qcom-rpmpd.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        isp@ac7a000 {
> +            compatible = "qcom,sa8775p-camss";
> +
> +            reg = <0x0 0xac7a000 0x0 0x0f00>,
> +                  <0x0 0xac7c000 0x0 0x0f00>,
> +                  <0x0 0xac84000 0x0 0x0f00>,
> +                  <0x0 0xac88000 0x0 0x0f00>,
> +                  <0x0 0xac8c000 0x0 0x0f00>,
> +                  <0x0 0xac90000 0x0 0x0f00>,
> +                  <0x0 0xac94000 0x0 0x0f00>,
> +                  <0x0 0xac78000 0x0 0x1000>,
> +                  <0x0 0xac9c000 0x0 0x2000>,
> +                  <0x0 0xac9e000 0x0 0x2000>,
> +                  <0x0 0xaca0000 0x0 0x2000>,
> +                  <0x0 0xaca2000 0x0 0x2000>,
> +                  <0x0 0xacac000 0x0 0x0400>,
> +                  <0x0 0xacad000 0x0 0x0400>,
> +                  <0x0 0xacae000 0x0 0x0400>,
> +                  <0x0 0xac4d000 0x0 0xd000>,
> +                  <0x0 0xac5a000 0x0 0xd000>,
> +                  <0x0 0xac85000 0x0 0x0d00>,
> +                  <0x0 0xac89000 0x0 0x0d00>,
> +                  <0x0 0xac8d000 0x0 0x0d00>,
> +                  <0x0 0xac91000 0x0 0x0d00>,
> +                  <0x0 0xac95000 0x0 0x0d00>;
> +            reg-names = "csid0",
> +                        "csid1",
> +                        "csid_lite0",
> +                        "csid_lite1",
> +                        "csid_lite2",
> +                        "csid_lite3",
> +                        "csid_lite4",
> +                        "csid_wrapper",

csid_wrapper is IMO the "main" register bank and as such should come 
first in the list of registers.

Please update this description to reflect, remembering to amend your 
isp@address here and in your dts.

> +                        "csiphy0",
> +                        "csiphy1",
> +                        "csiphy2",
> +                        "csiphy3",
> +                        "tpg0",
> +                        "tpg1",
> +                        "tpg2",
> +                        "vfe0",
> +                        "vfe1",
> +                        "vfe_lite0",
> +                        "vfe_lite1",
> +                        "vfe_lite2",
> +                        "vfe_lite3",
> +                        "vfe_lite4";
> +
> +            clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>,
> +                     <&camcc CAM_CC_CORE_AHB_CLK>,
> +                     <&camcc CAM_CC_CPAS_AHB_CLK>,
> +                     <&camcc CAM_CC_CPAS_FAST_AHB_CLK>,
> +                     <&camcc CAM_CC_CPAS_IFE_LITE_CLK>,
> +                     <&camcc CAM_CC_CPAS_IFE_0_CLK>,
> +                     <&camcc CAM_CC_CPAS_IFE_1_CLK>,
> +                     <&camcc CAM_CC_CSID_CLK>,
> +                     <&camcc CAM_CC_CSIPHY0_CLK>,
> +                     <&camcc CAM_CC_CSI0PHYTIMER_CLK>,
> +                     <&camcc CAM_CC_CSIPHY1_CLK>,
> +                     <&camcc CAM_CC_CSI1PHYTIMER_CLK>,
> +                     <&camcc CAM_CC_CSIPHY2_CLK>,
> +                     <&camcc CAM_CC_CSI2PHYTIMER_CLK>,
> +                     <&camcc CAM_CC_CSIPHY3_CLK>,
> +                     <&camcc CAM_CC_CSI3PHYTIMER_CLK>,
> +                     <&camcc CAM_CC_CSID_CSIPHY_RX_CLK>,
> +                     <&gcc GCC_CAMERA_HF_AXI_CLK>,
> +                     <&gcc GCC_CAMERA_SF_AXI_CLK>,
> +                     <&camcc CAM_CC_ICP_AHB_CLK>,
> +                     <&camcc CAM_CC_IFE_0_CLK>,
> +                     <&camcc CAM_CC_IFE_0_FAST_AHB_CLK>,
> +                     <&camcc CAM_CC_IFE_1_CLK>,
> +                     <&camcc CAM_CC_IFE_1_FAST_AHB_CLK>,
> +                     <&camcc CAM_CC_IFE_LITE_CLK>,
> +                     <&camcc CAM_CC_IFE_LITE_AHB_CLK>,
> +                     <&camcc CAM_CC_IFE_LITE_CPHY_RX_CLK>,
> +                     <&camcc CAM_CC_IFE_LITE_CSID_CLK>;
> +            clock-names = "camnoc_axi",
> +                          "core_ahb",
> +                          "cpas_ahb",
> +                          "cpas_fast_ahb_clk",
> +                          "cpas_vfe_lite",
> +                          "cpas_vfe0",
> +                          "cpas_vfe1",
> +                          "csid",
> +                          "csiphy0",
> +                          "csiphy0_timer",
> +                          "csiphy1",
> +                          "csiphy1_timer",
> +                          "csiphy2",
> +                          "csiphy2_timer",
> +                          "csiphy3",
> +                          "csiphy3_timer",
> +                          "csiphy_rx",
> +                          "gcc_axi_hf",
> +                          "gcc_axi_sf",
> +                          "icp_ahb",
> +                          "vfe0",
> +                          "vfe0_fast_ahb",
> +                          "vfe1",
> +                          "vfe1_fast_ahb",
> +                          "vfe_lite",
> +                          "vfe_lite_ahb",
> +                          "vfe_lite_cphy_rx",
> +                          "vfe_lite_csid";
> +
> +            interrupts = <GIC_SPI 565 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 564 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 468 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 359 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 759 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 758 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 604 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 477 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 478 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 479 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 448 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 545 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 546 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 547 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 465 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 467 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 469 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 360 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 761 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 760 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 605 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-names = "csid0",
> +                              "csid1",
> +                              "csid_lite0",
> +                              "csid_lite1",
> +                              "csid_lite2",
> +                              "csid_lite3",
> +                              "csid_lite4",
> +                              "csiphy0",
> +                              "csiphy1",
> +                              "csiphy2",
> +                              "csiphy3",
> +                              "tpg0",
> +                              "tpg1",
> +                              "tpg2",
> +                              "vfe0",
> +                              "vfe1",
> +                              "vfe_lite0",
> +                              "vfe_lite1",
> +                              "vfe_lite2",
> +                              "vfe_lite3",
> +                              "vfe_lite4";
> +
> +            interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +                             &config_noc SLAVE_CAMERA_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
> +                            <&mmss_noc MASTER_CAMNOC_HF QCOM_ICC_TAG_ALWAYS
> +                             &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
> +            interconnect-names = "ahb",
> +                                 "hf_0";
> +
> +            iommus = <&apps_smmu 0x3400 0x20>;
> +
> +            power-domains = <&camcc CAM_CC_TITAN_TOP_GDSC>;
> +            power-domain-names = "top";
> +
> +            vdda-phy-supply = <&vreg_l4a_0p88>;
> +            vdda-pll-supply = <&vreg_l1c_1p2>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +            };
> +        };
> +    };

Otherwise that this looks fine, please fix and then add.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

