Return-Path: <linux-kernel+bounces-832020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983FCB9E27C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49ABD3828D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890882798FD;
	Thu, 25 Sep 2025 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VtgeGXkH"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F194F279795
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790668; cv=none; b=jE6C6plvcDCx0mZsbqPEYGnTd3kTWjDC25rfExdGX/IrFJ+xBda6oWdvJkwlkSK6HwuvhjPOJ19YCKGRz/Fdp5ixKqNHkOBMPb/TLKfeYJgz1JGdKz44yrenVX4i855W7pxhkhCnp7PPJPd0xyf09kpU7KXJqweZ8AEtNv0Q5UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790668; c=relaxed/simple;
	bh=s1IvWBoDghRdTxNI9ntahbtNb3ceyjypNF92BFpPstg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnJaUufPqYTwBSgiz82Lhn9RoiIt1F/6yYOrKQWmIab2qh4xBO4s1MnVti7opw/sHQlbwwbooJml1hAnTV4f6u0rveZfpdmuGW/Z33X3TWvA82reW2GdtyGK/TL19w/hnzAUDX5RYCdIHEdwnAyooeaPlJZDHPNfGn+LIenQn1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VtgeGXkH; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b2e66a300cbso135738766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758790663; x=1759395463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0gyeemM5bv0/cwHb/gRYJJo/u8gfbvqaOjqlOCWg4JE=;
        b=VtgeGXkHItiSlP0KD3DKgSpuIYMSMcbjRUlyNQ/C8xStSBJF/HLkmsdAoMYdZhEb6q
         hn6UJH9x76C3uGBGbGEVCDVD9FkhdAW95q5eF1PJE7Wtfx0n3gNCVRc/+11Mr4Wxtu/d
         gaDUQ30i6e8bqHiuVgKR3jzpR4T5qf897jNk6Zjt4qjguB/NZk5fVNbZGrxaU6PQd7v8
         vjOrK3WUW81wmJVAPnqRE/qWDGvxGAhxMywHRkQ+6H/pqtGNAKoOMuAoRXMwOpa5+mfz
         ygcwQk7mT6yg1yPUXHlCpb6DqIk7m8Ftsen16eew6E1N+Lt7/9jnfZhL+XJ61fgpcL7p
         vY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758790663; x=1759395463;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gyeemM5bv0/cwHb/gRYJJo/u8gfbvqaOjqlOCWg4JE=;
        b=saLTka39L1rp+wG3Flw4jdSVjInKHQc/9rMEwabty8FCe8nFuNCCke4Cu6bOwWRPtR
         i0Mr2t34PGEq6y4CE8VaYEYeMATeLapkkm96vmEPqCfc61QN3qoPppjCQTfysvSQ24FX
         I3aRK8My7lwQ0NlKXGSBD1Rs+MQg2HWOxlVOn6Tovt8nwkf03WW4kO7LBG0N09j0XcyK
         wYMl5B8uJ75Xi+4Yq8IIbvDn278bEd/oRdGr6cwLgS3DbvS3Zr9kCypTxTr/ajJXc7+A
         RjJupT/14p+LB6+aCdfYCwzHx5gSf7RyWIgDCrIjtx7VaNHL+ng2PA98YYuHY9zJmpBG
         gJww==
X-Forwarded-Encrypted: i=1; AJvYcCUvDYPEzHyVYymo17iPRKd6QbhlNIlgOGq3cGl4Q+wv9+0OxIYA+UX+Y6x4yfO99BQLek5I300JGIWwIr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwnfVPUDPevCI35dQYDXMncDUggecZi5oB/Ay4fHaE6CqZlQUu
	SgAZNvoDQET8UMuEgYjj553KJvmOrPEAssi82UZu/aZ7jIVT2QFeer9XH6XRhGggcdw=
X-Gm-Gg: ASbGncskyA4Ck5gm9RpzkFjR8Y75F9TJLKsESpGYg7zED7uvMi6K5Q5kh01/0mJ8Llk
	AZxnRMEeI1lxGkogMGr+IBoveqLVkAwZD6FjYz8mlnljTcPeWiQgFUFuv9HXIKvXRsAtNIuEeb+
	Huwcpr4OmjsJCeDAKhw4x58Hd+IG+MyrYiVE1UJ8kzo9e6uZvLZEyYekKKdmbHYUQdukh1NPkjv
	qdITDVQiTaF42eA1rvfvUUxNmljZPvn4KtXj9GD8Da13Sv2i4li/18Wxk3IdW/VICW1k8QPO8vU
	CN2mtgqRLpcsvgzjHN/BOAH96VzslMt4p00sk7PuBbDRdNfvm7fwu+tjmjdzQfaqxxOOvGM9fxF
	nOSCfpyEPTrIE4tMR5Q6Vsn1kmenaLw==
X-Google-Smtp-Source: AGHT+IHAqvFuArcYlmLsH6QWv4YuNWEk6UM56Ovz265N4A8KauZbqfvtw43LomwCRUeB+PPlGp6V8w==
X-Received: by 2002:a17:907:7e84:b0:b29:e717:f0af with SMTP id a640c23a62f3a-b34b9f4fc52mr328324766b.18.1758790663253;
        Thu, 25 Sep 2025 01:57:43 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f7472sm122712666b.57.2025.09.25.01.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 01:57:42 -0700 (PDT)
Message-ID: <ea291acc-bfdc-4a04-ba60-fc59a55ada28@linaro.org>
Date: Thu, 25 Sep 2025 11:57:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Kaanapali SoC
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
 trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-interconnect-v1-0-4c822a72141c@oss.qualcomm.com>
 <20250924-knp-interconnect-v1-1-4c822a72141c@oss.qualcomm.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250924-knp-interconnect-v1-1-4c822a72141c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/25 02:02, Jingyi Wang wrote:
> From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> 
> Document the RPMh Network-On-Chip Interconnect of the Kaanapali platform.
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,kaanapali-rpmh.yaml | 126 +++++++++++++++++
>  .../dt-bindings/interconnect/qcom,kaanapali-rpmh.h | 149 +++++++++++++++++++++
>  2 files changed, 275 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,kaanapali-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,kaanapali-rpmh.yaml
> new file mode 100644
> index 000000000000..574150cc4930
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,kaanapali-rpmh.yaml
> @@ -0,0 +1,126 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,kaanapali-rpmh.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm RPMh Network-On-Chip Interconnect on KAANAPALI
> +
> +maintainers:
> +  - Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> +
> +description: |
> +  RPMh interconnect providers support system bandwidth requirements through
> +  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
> +  able to communicate with the BCM through the Resource State Coordinator (RSC)
> +  associated with each execution environment. Provider nodes must point to at
> +  least one RPMh device child node pertaining to their RSC and each provider
> +  can map to multiple RPMh resources.
> +
> +  See also: include/dt-bindings/interconnect/qcom,kaanapali-rpmh.h
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,kaanapali-aggre-noc

Hi,

Does Kaanapali have a single aggre node, or there are several ?
On previous SoC, I see there are two (aggre1 and aggre2).
Also in your driver (second patch), I notice aggre1_noc and aggre2_noc .
It would make sense to accurately describe here the hardware.

Eugen

> +      - qcom,kaanapali-clk-virt
> +      - qcom,kaanapali-cnoc-main
> +      - qcom,kaanapali-cnoc-cfg
> +      - qcom,kaanapali-gem-noc
> +      - qcom,kaanapali-lpass-ag-noc
> +      - qcom,kaanapali-lpass-lpiaon-noc
> +      - qcom,kaanapali-lpass-lpicx-noc
> +      - qcom,kaanapali-mc-virt
> +      - qcom,kaanapali-mmss-noc
> +      - qcom,kaanapali-nsp-noc
> +      - qcom,kaanapali-pcie-anoc
> +      - qcom,kaanapali-system-noc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 3
> +
> +required:
> +  - compatible
> +
> +allOf:
> +  - $ref: qcom,rpmh-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,kaanapali-clk-virt
> +              - qcom,kaanapali-mc-virt
> +    then:
> +      properties:
> +        reg: false
> +    else:
> +      required:
> +        - reg
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,kaanapali-pcie-anoc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: aggre-NOC PCIe AXI clock
> +            - description: cfg-NOC PCIe a-NOC AHB clock
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,kaanapali-aggre-noc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: aggre UFS PHY AXI clock
> +            - description: aggre USB3 PRIM AXI clock
> +            - description: RPMH CC IPA clock
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,kaanapali-aggre-noc
> +              - qcom,kaanapali-pcie-anoc
> +    then:
> +      required:
> +        - clocks
> +    else:
> +      properties:
> +        clocks: false
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,kaanapali-gcc.h>
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +    clk_virt: interconnect-0 {
> +      compatible = "qcom,kaanapali-clk-virt";
> +      #interconnect-cells = <2>;
> +      qcom,bcm-voters = <&apps_bcm_voter>;
> +    };
> +
> +    aggre_noc: interconnect@16e0000 {
> +      compatible = "qcom,kaanapali-aggre-noc";
> +      reg = <0x016e0000 0x42400>;
> +      #interconnect-cells = <2>;
> +      clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +               <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
> +               <&rpmhcc RPMH_IPA_CLK>;
> +      qcom,bcm-voters = <&apps_bcm_voter>;
> +    };
> diff --git a/include/dt-bindings/interconnect/qcom,kaanapali-rpmh.h b/include/dt-bindings/interconnect/qcom,kaanapali-rpmh.h
> new file mode 100644
> index 000000000000..dde3f9abd677
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,kaanapali-rpmh.h
> @@ -0,0 +1,149 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_KAANAPALI_H
> +#define __DT_BINDINGS_INTERCONNECT_QCOM_KAANAPALI_H
> +
> +#define MASTER_QSPI_0				0
> +#define MASTER_CRYPTO				1
> +#define MASTER_QUP_1				2
> +#define MASTER_SDCC_4				3
> +#define MASTER_UFS_MEM				4
> +#define MASTER_USB3				5
> +#define MASTER_QUP_2				6
> +#define MASTER_QUP_3				7
> +#define MASTER_QUP_4				8
> +#define MASTER_IPA				9
> +#define MASTER_SOCCP_PROC			10
> +#define MASTER_SP				11
> +#define MASTER_QDSS_ETR				12
> +#define MASTER_QDSS_ETR_1			13
> +#define MASTER_SDCC_2				14
> +#define SLAVE_A1NOC_SNOC			15
> +#define SLAVE_A2NOC_SNOC			16
> +
> +#define MASTER_QUP_CORE_0			0
> +#define MASTER_QUP_CORE_1			1
> +#define MASTER_QUP_CORE_2			2
> +#define MASTER_QUP_CORE_3			3
> +#define MASTER_QUP_CORE_4			4
> +#define SLAVE_QUP_CORE_0			5
> +#define SLAVE_QUP_CORE_1			6
> +#define SLAVE_QUP_CORE_2			7
> +#define SLAVE_QUP_CORE_3			8
> +#define SLAVE_QUP_CORE_4			9
> +
> +#define MASTER_CNOC_CFG				0
> +#define SLAVE_AHB2PHY_SOUTH			1
> +#define SLAVE_AHB2PHY_NORTH			2
> +#define SLAVE_CAMERA_CFG			3
> +#define SLAVE_CLK_CTL				4
> +#define SLAVE_CRYPTO_0_CFG			5
> +#define SLAVE_DISPLAY_CFG			6
> +#define SLAVE_EVA_CFG				7
> +#define SLAVE_GFX3D_CFG				8
> +#define SLAVE_I2C				9
> +#define SLAVE_I3C_IBI0_CFG			10
> +#define SLAVE_I3C_IBI1_CFG			11
> +#define SLAVE_IMEM_CFG				12
> +#define SLAVE_IPC_ROUTER_CFG			13
> +#define SLAVE_CNOC_MSS				14
> +#define SLAVE_PCIE_CFG				15
> +#define SLAVE_PRNG				16
> +#define SLAVE_QDSS_CFG				17
> +#define SLAVE_QSPI_0				18
> +#define SLAVE_QUP_1				19
> +#define SLAVE_QUP_2				20
> +#define SLAVE_QUP_3				21
> +#define SLAVE_QUP_4				22
> +#define SLAVE_SDCC_2				23
> +#define SLAVE_SDCC_4				24
> +#define SLAVE_SPSS_CFG				25
> +#define SLAVE_TCSR				26
> +#define SLAVE_TLMM				27
> +#define SLAVE_UFS_MEM_CFG			28
> +#define SLAVE_USB3				29
> +#define SLAVE_VENUS_CFG				30
> +#define SLAVE_VSENSE_CTRL_CFG			31
> +#define SLAVE_CNOC_MNOC_CFG			32
> +#define SLAVE_PCIE_ANOC_CFG			33
> +#define SLAVE_QDSS_STM				34
> +#define SLAVE_TCU				35
> +
> +#define MASTER_GEM_NOC_CNOC			0
> +#define MASTER_GEM_NOC_PCIE_SNOC		1
> +#define SLAVE_AOSS				2
> +#define SLAVE_IPA_CFG				3
> +#define SLAVE_IPC_ROUTER_FENCE			4
> +#define SLAVE_SOCCP				5
> +#define SLAVE_TME_CFG				6
> +#define SLAVE_APPSS				7
> +#define SLAVE_CNOC_CFG				8
> +#define SLAVE_DDRSS_CFG				9
> +#define SLAVE_BOOT_IMEM				10
> +#define SLAVE_IMEM				11
> +#define SLAVE_PCIE_0				12
> +
> +#define MASTER_GPU_TCU				0
> +#define MASTER_SYS_TCU				1
> +#define MASTER_APPSS_PROC			2
> +#define MASTER_GFX3D				3
> +#define MASTER_LPASS_GEM_NOC			4
> +#define MASTER_MSS_PROC				5
> +#define MASTER_MNOC_HF_MEM_NOC			6
> +#define MASTER_MNOC_SF_MEM_NOC			7
> +#define MASTER_COMPUTE_NOC			8
> +#define MASTER_ANOC_PCIE_GEM_NOC		9
> +#define MASTER_QPACE				10
> +#define MASTER_SNOC_SF_MEM_NOC			11
> +#define MASTER_WLAN_Q6				12
> +#define MASTER_GIC				13
> +#define SLAVE_GEM_NOC_CNOC			14
> +#define SLAVE_LLCC				15
> +#define SLAVE_MEM_NOC_PCIE_SNOC			16
> +
> +#define MASTER_LPIAON_NOC			0
> +#define SLAVE_LPASS_GEM_NOC			1
> +
> +#define MASTER_LPASS_LPINOC			0
> +#define SLAVE_LPIAON_NOC_LPASS_AG_NOC		1
> +
> +#define MASTER_LPASS_PROC			0
> +#define SLAVE_LPICX_NOC_LPIAON_NOC		1
> +
> +#define MASTER_LLCC				0
> +#define SLAVE_EBI1				1
> +
> +#define MASTER_CAMNOC_HF			0
> +#define MASTER_CAMNOC_NRT_ICP_SF		1
> +#define MASTER_CAMNOC_RT_CDM_SF			2
> +#define MASTER_CAMNOC_SF			3
> +#define MASTER_MDP				4
> +#define MASTER_MDSS_DCP				5
> +#define MASTER_CDSP_HCP				6
> +#define MASTER_VIDEO_CV_PROC			7
> +#define MASTER_VIDEO_EVA			8
> +#define MASTER_VIDEO_MVP			9
> +#define MASTER_VIDEO_V_PROC			10
> +#define MASTER_CNOC_MNOC_CFG			11
> +#define SLAVE_MNOC_HF_MEM_NOC			12
> +#define SLAVE_MNOC_SF_MEM_NOC			13
> +#define SLAVE_SERVICE_MNOC			14
> +
> +#define MASTER_CDSP_PROC			0
> +#define SLAVE_CDSP_MEM_NOC			1
> +
> +#define MASTER_PCIE_ANOC_CFG			0
> +#define MASTER_PCIE_0				1
> +#define SLAVE_ANOC_PCIE_GEM_NOC			2
> +#define SLAVE_SERVICE_PCIE_ANOC			3
> +
> +#define MASTER_A1NOC_SNOC			0
> +#define MASTER_A2NOC_SNOC			1
> +#define MASTER_APSS_NOC				2
> +#define MASTER_CNOC_SNOC			3
> +#define SLAVE_SNOC_GEM_NOC_SF			4
> +
> +#endif
> 


