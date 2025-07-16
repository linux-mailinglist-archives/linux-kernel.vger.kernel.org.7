Return-Path: <linux-kernel+bounces-734385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FB2B080E2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2129B4E329C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 23:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CCE2EF65C;
	Wed, 16 Jul 2025 23:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jTo1ej1a"
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9A62EE987
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752708179; cv=none; b=QkNxIkEPr/2UhAisEkc2SL+JL9xlSCoF/gVJBRj1EDbp31cbXWdZQkiShgiFE1ILGMSbz7JFyPfJkS4qnFUBNlFJGhqdrQE8mLIpnlL56rExkmwIx5lyVOOasPX/q51g1luMRR1651hgctQ9HDZLa1oOu4NOVNzn1ns82Ta0NxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752708179; c=relaxed/simple;
	bh=lHrO7ghXNv+BOwuxjbXikdvUSRwMlfAidd09c75UGII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aeC3Dtw4srUOoiVeLxlRGbb0LyB2iUHPKf2EGSV9FaAxesA4YPNYT3doeIxW6p1HMld3ljjgVE5hyKE02zru+c6UhY3FLJ/GCxQVkGLCxKvpl+63g/f3ISWqFwW3JJAIssw6XukswbCgdFx7Nu4h0D5DxjHcoTxR12sBFXz1uIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jTo1ej1a; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so916250f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752708175; x=1753312975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DkPtKIO7NhPfmSP1zxkzxJPlW/xiUwZt47WKbfa7rFw=;
        b=jTo1ej1ax5q7zJIySgyDP0pLhG6fMEEHuMMMDmu8JI6GSFkpj/2w9iUvTJnZC9M9Ns
         b8BPzL3MTh3yfNwEDTGllV672A2rDQtdXokmsw4KXQx6JirL/gOIj+TwQDd+m73yE9m7
         ob4oxbYzu6QMsVqfzTfFHSLVg2wnC62rIocOvig/WKs0E/ddkn8WROjq5Qe+yW6FpTJm
         U8fO39BI0AfeNIPZNQ6gvmVNzY+PmUdzt0wZz5ztCGmEpL8zENjvlb1hWdIceXiOML8d
         wW5ewq3x5238fuhFtINcuVVixgqM3pgp9bzLltjGQQubMiu9s97xIBGYA41wKP03Unxh
         9PIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752708175; x=1753312975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DkPtKIO7NhPfmSP1zxkzxJPlW/xiUwZt47WKbfa7rFw=;
        b=H6ZaWngo78u0BfzzZBrKnyWbUz6p0Q0lTSUYX41+ScUMK9B5M6ZTQrZxm5ZFKSVVpQ
         qATv05brlnVI/DVTYnb0NklHlyw3kGJvFduxMOMB3XkIZX/FvdOeElGm4PsTPCy3aGFl
         f+VzIh0dTlBRr/+U6mjlwc9ceZhGrS08M+X3nimKdevQECjTvFfQ54itYaieA15VEfel
         3Iz+o7AVNbiKex9SVEwInAJ7o+NzCcwSkmfSGomPb58EpwyLo4GV9Z7d2MEaVdT7/bML
         ZpZhtCHyebs8WaEWUc7hW4EAx9jcDHc+1uA8h/QPvh4xYVKIElrbBI380J/MPdoxBX7k
         rO9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX03EI7OeqgoEwEovJrT8OW180Y96xbCvQtbxvarvd95/VgLL/OVlgtXpz0MxTtd53HIyWjCLl3MJc1fTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjFSRuGOs2zBxjhVkvatodBme0EKmUyggK67jYS1Lsk7l4RLKB
	ymACFDm6AAJ3KqBtLlzRwFhoTg4X6kfoPnByIscAZ94ta90dBfz/vwqDbiHM2ds9u1c=
X-Gm-Gg: ASbGncvDMHtcG2so4Yi4h1z5graLk7NPaS4K/UG8UvngwFpeJMpQ1xU8wHb/KRHJAXh
	/FIUaLdBz4a83ACSOFCO3eSJ64kyMVdER5S+tPWDff12UFdnlLfl4IoLe+FMHvidfqu/0B9pjPg
	p9Qs0j63rStnwcgpn0J4V0sO8uoFKjH1lsOtTzxnKuDUJRpUBHGQ4AxRb1M8K8f0Z9fsvQJ46te
	iHVKhOAVERpJb0zQPBaAInMupSl3/jCULd22U+aQCq8DI9kkDWqtFoNVgcPTYOtIcQ5pufhi3vr
	LG9tqOkacROn4nCBRMRbOsyEY2yrbYCD0jXgqUd347iXDEA03SLBIC4jk7KPbBqNgrYwtvxSSFx
	Epz4aVgbePB+2FK5/y4zjw7nuw8+wyvU9hWZsTz5Uh9PirKZrYW8Ugv8s/AW+d7DM
X-Google-Smtp-Source: AGHT+IHwXJaztqWJkdTIkVdOxyH1299bOPGJlgaVcAkmrBYL12PbZpGxwAGAEuNylkrKZJgPKYBnRQ==
X-Received: by 2002:a05:6000:2a0c:b0:3a5:8934:4959 with SMTP id ffacd0b85a97d-3b613a3ff3fmr694018f8f.27.1752708175443;
        Wed, 16 Jul 2025 16:22:55 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45634f9d599sm5060255e9.33.2025.07.16.16.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 16:22:54 -0700 (PDT)
Message-ID: <8a63f517-a443-48e4-9b9c-0c4b362f59f8@linaro.org>
Date: Thu, 17 Jul 2025 00:22:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] media: dt-bindings: venus: Add qcm2290 dt schema
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 quic_vgarodia@quicinc.com, quic_dikshita@quicinc.com, krzk+dt@kernel.org,
 konradybcio@kernel.org, mchehab@kernel.org, andersson@kernel.org,
 conor+dt@kernel.org, amit.kucheria@oss.qualcomm.com
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250715204749.2189875-1-jorge.ramirez@oss.qualcomm.com>
 <20250715204749.2189875-2-jorge.ramirez@oss.qualcomm.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250715204749.2189875-2-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/07/2025 21:47, Jorge Ramirez-Ortiz wrote:
> Add a schema for the venus video encoder/decoder on the qcm2290.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   .../bindings/media/qcom,qcm2290-venus.yaml    | 127 ++++++++++++++++++
>   1 file changed, 127 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/media/qcom,qcm2290-venus.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,qcm2290-venus.yaml b/Documentation/devicetree/bindings/media/qcom,qcm2290-venus.yaml
> new file mode 100644
> index 000000000000..0371f8dd91a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/qcom,qcm2290-venus.yaml
> @@ -0,0 +1,127 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/qcom,qcm2290-venus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QCM2290 Venus video encode and decode accelerators
> +
> +maintainers:
> +  - Vikash Garodia <quic_vgarodia@quicinc.com>

Shouldn't you be on this list ? If you upstream a file I think you 
should list yourself as responsible for its glory or its mess.

> +
> +description:
> +  The Venus AR50_LITE IP is a video encode and decode accelerator present
> +  on Qualcomm platforms
> +
> +allOf:
> +  - $ref: qcom,venus-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,qcm2290-venus
> +
> +  power-domains:
> +    maxItems: 3
> +
> +  power-domain-names:
> +    items:
> +      - const: venus
> +      - const: vcodec0
> +      - const: cx
> +
> +  clocks:
> +    maxItems: 6
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: iface
> +      - const: bus
> +      - const: throttle
> +      - const: vcodec0_core
> +      - const: vcodec0_bus
> +
> +  iommus:
> +    minItems: 1
> +    maxItems: 5

I'm confused to see this is still here

https://lore.kernel.org/linux-media/zk5cmielm4urfm22yszmjmwvi4mqvdsfthlonq6mij7rkijcsp@7evb3ejxuaj7/

I think Dima is right, what's the problem with declaring maxItems: 5 here ?


> +  interconnects:
> +    maxItems: 2
> +
> +  interconnect-names:
> +    items:
> +      - const: video-mem
> +      - const: cpu-cfg
> +
> +  operating-points-v2: true
> +  opp-table:
> +    type: object
> +
> +required:
> +  - compatible
> +  - power-domain-names
> +  - iommus
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/qcom,gcc-qcm2290.h>
> +    #include <dt-bindings/interconnect/qcom,qcm2290.h>
> +    #include <dt-bindings/interconnect/qcom,rpm-icc.h>
> +    #include <dt-bindings/power/qcom-rpmpd.h>

Alphabetise includes for preference.

> +
> +    venus: video-codec@5a00000 {
> +        compatible = "qcom,qcm2290-venus";
> +        reg = <0x5a00000 0xf0000>;
> +        interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
> +
> +        power-domains = <&gcc GCC_VENUS_GDSC>,
> +                        <&gcc GCC_VCODEC0_GDSC>,
> +                        <&rpmpd QCM2290_VDDCX>;
> +        power-domain-names = "venus",
> +                             "vcodec0",
> +                             "cx";
> +        operating-points-v2 = <&venus_opp_table>;
> +
> +        clocks = <&gcc GCC_VIDEO_VENUS_CTL_CLK>,
> +                 <&gcc GCC_VIDEO_AHB_CLK>,
> +                 <&gcc GCC_VENUS_CTL_AXI_CLK>,
> +                 <&gcc GCC_VIDEO_THROTTLE_CORE_CLK>,
> +                 <&gcc GCC_VIDEO_VCODEC0_SYS_CLK>,
> +                 <&gcc GCC_VCODEC0_AXI_CLK>;
> +        clock-names = "core",
> +                       "iface",
> +                       "bus",
> +                       "throttle",
> +                       "vcodec0_core",
> +                       "vcodec0_bus";
> +
> +        memory-region = <&pil_video_mem>;
> +        iommus = <&apps_smmu 0x860 0x0>,
> +                 <&apps_smmu 0x880 0x0>,
> +                 <&apps_smmu 0x861 0x04>,
> +                 <&apps_smmu 0x863 0x0>,
> +                 <&apps_smmu 0x804 0xe0>;

You're listing five iommus.

I understand there's some disagreement about whether or not to list all 
of the potential use-cases but, TBH I don't think those are good arguments.

Unless there's some technical prohibition I can't think of listing all 
five maxItems:5 .. let's just do that.

> +
> +        interconnects = <&mmnrt_virt MASTER_VIDEO_P0 RPM_ALWAYS_TAG
> +                         &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>,
> +                        <&bimc MASTER_APPSS_PROC RPM_ACTIVE_TAG
> +                         &config_noc SLAVE_VENUS_CFG RPM_ACTIVE_TAG>;
> +        interconnect-names = "video-mem",
> +                             "cpu-cfg";
> +
> +        venus_opp_table: opp-table {
> +            compatible = "operating-points-v2";
> +
> +            opp-133333333 {
> +                opp-hz = /bits/ 64 <133333333>;
> +                required-opps = <&rpmpd_opp_low_svs>;
> +            };
> +            opp-240000000 {
> +                opp-hz = /bits/ 64 <240000000>;
> +                required-opps = <&rpmpd_opp_svs>;
> +            };
> +        };
> +    };
---
bod

