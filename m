Return-Path: <linux-kernel+bounces-756171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768ECB1B0C9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F20AC7AAD17
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA58E2641E7;
	Tue,  5 Aug 2025 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NYqNsA6j"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743DA25FA10
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754385354; cv=none; b=PDKqAShpruexfmeWHZckBhWDGhQvENuDDpsHlElkhsQ3aFawiKyUIpm5/thEh+Ju3zFEbbzHPljJcMMNUzjRcvSQTO+wkQFOUMJP0QKVASAwyAtLmDnaQ9hag5blM1tuAwYB0OIkqct1SYIB9yPXXbfkgo+LWcuceeyiBpwNItY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754385354; c=relaxed/simple;
	bh=SVJLLY9b+A2Ow6Hfl6TdqTYLbgy0WRgvTvRSaRu+4i4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XaW+wI75Zp33Uml1vvAmJw/jq7PIdsUGFii2vjCRGyvQbTJO/Vsd3jZNYuunB1MGKaHPPNTItrP0yvYbmfmQ9qj2iK5kMvZXTFgqD8F5hNgWeaarCD9zj2mDRUmqPtUJ0g3t/kdL+5tEacdAnFakYe3PIQBFpT6IG7KKINRbD3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NYqNsA6j; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af958127df5so453951366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 02:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754385350; x=1754990150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mI3NXVqyKiVG50xbkud2NPNqvmCUVZbmYL0tUjmcuaE=;
        b=NYqNsA6jwZwjDZnE0plMfvGCcahb7ixEQlFYX6Wb2cj5rRMCEmDN+f1bxkq9vNo4Ob
         r3nBWulQEZoOo2hD4HWDggA/Ar0vL9dae9pF8kRyCtC3GGAkAq9VT31yhWDRrxmWj0c8
         SKSuComGv7PbFBNN1+Xb46J7WzWKliowxLqFTMsteNLfSTksSuVHx/pQp3ItEYJOT8c1
         ruq++7oqhuJy9WkGjWt8UzSEom9Ql8CuylRxQ9aqgACPECJNnopNRTH2lSbEgSxrNllb
         BTONAtZgYLnrx5rPj/alLja3RgXuwWTuKa5KYCrY9J1EGDs2SUydy7r3x8v+Kycc+R0k
         KXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754385350; x=1754990150;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mI3NXVqyKiVG50xbkud2NPNqvmCUVZbmYL0tUjmcuaE=;
        b=GLqWyzK2avz8rF5c7FXM1ESNB7/JXeOpmovVhFXqqQuDRZ8GG2iAI4J/+jJOz3Wxqc
         rTw3N484dw4m428YBm5aFPz9g0NaMEqaEdUKaV1l5xBZvgn9tTJDMOon4i5AJ55njlUl
         fYB+q6y28Hgc3rPBMI+GM5yZ+Ac0SPI+WSRRH072jPLhoilPdApIep8z1WN41Gbmcz1N
         whPgshJMJzXY/mzRhOn9eDW3w9CXG+p9Ik+GKTgxWXjgMrsclf+096dmAoDxth9emSxH
         PYQ1JpYp9T+Eum1UxXTVQVHoGGwBYJvZWd1RdY0pjsfYOKwFcQZQoWWr3l/n5tOe2g7p
         SPzA==
X-Forwarded-Encrypted: i=1; AJvYcCVzTb+7oI8o9c5NqZaFpcIrzIHgmsDdWQvk0skCQbRvrrweLJND/dVpc/G1osKrEeJQL7rwIo9RLeg27Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNSECa6Rc8FGNVZPlFMr62yZbLrEFoKYufl63axt4nBoVkn7X3
	cnYYliND6XqBxYClWFECfxY1IZgr9HlW83eQZBPSU7XywMB4w8sxO07j26BmI3egb+w=
X-Gm-Gg: ASbGncvbMXcfVO3SgMqy5uLWKsEw/6waBvUCbBBqWFb2g5xOvmQHgveXIBq9vOTLfSU
	+GFCyt99+nwAvSoKnddVr8mDEVucbPn56AxrJoT23JjGknzcVRmNY8wZBV8rkCnTK3JDLiwuiC9
	qLJ0sszTldAhr7vfWP8Qy7xAj4iSxo5VHn0uPPCB70SrC7K4VmvMUJCiFp1dxrbvl+q1cntRMa4
	1gWA9odB97197TSyybb43q/WLbsRE3OzCm535RhlVLUXc4qF6a0UZ/VNii/WVM1HHSqxstnY3TF
	nuPQyP+W8wBDcctlr8UsRda3yn+MQf06KQqiZaq3Xvdex8l455lQ8Lv1ULj9/B/hlMYXx6T9XER
	hNjK7vHt3sg5QoZkjCmSSnjM3qV0vYSR8+9ANCpwKw5BocPaokwuZFkY1b3xrWYQEaRpxdlpU4A
	==
X-Google-Smtp-Source: AGHT+IFSQsh79TNXqQaV19dvtSQv+eoeTCrnDui9MT29o5c/h19Vmob28lRx3aBCVAdqKf7927HIkg==
X-Received: by 2002:a17:907:c13:b0:af9:3c68:f743 with SMTP id a640c23a62f3a-af9401ee770mr1301929566b.34.1754385349788;
        Tue, 05 Aug 2025 02:15:49 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a2436c2sm857466266b.141.2025.08.05.02.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 02:15:49 -0700 (PDT)
Message-ID: <9d770617-966b-4b84-a626-59f0ffe83605@linaro.org>
Date: Tue, 5 Aug 2025 10:15:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/7] arm64: dts: qcom: qcm2290: Add Venus video node
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 quic_dikshita@quicinc.com, quic_vgarodia@quicinc.com,
 konradybcio@kernel.org, krzk+dt@kernel.org
Cc: mchehab@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250805064430.782201-1-jorge.ramirez@oss.qualcomm.com>
 <20250805064430.782201-7-jorge.ramirez@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250805064430.782201-7-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/08/2025 07:44, Jorge Ramirez-Ortiz wrote:
> Add DT entries for the qcm2290 Venus encoder/decoder.
> 
> Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/qcm2290.dtsi | 55 +++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> index f49ac1c1f8a3..7cfacd189a10 100644
> --- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> @@ -1628,6 +1628,61 @@ adreno_smmu: iommu@59a0000 {
>   			#iommu-cells = <2>;
>   		};
>   
> +		venus: video-codec@5a00000 {
> +			compatible = "qcom,qcm2290-venus";
> +			reg = <0 0x5a00000 0 0xf0000>;
> +			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			power-domains = <&gcc GCC_VENUS_GDSC>,
> +					<&gcc GCC_VCODEC0_GDSC>,
> +					<&rpmpd QCM2290_VDDCX>;
> +			power-domain-names = "venus",
> +					     "vcodec0",
> +					     "cx";
> +			operating-points-v2 = <&venus_opp_table>;
> +
> +			clocks = <&gcc GCC_VIDEO_VENUS_CTL_CLK>,
> +				 <&gcc GCC_VIDEO_AHB_CLK>,
> +				 <&gcc GCC_VENUS_CTL_AXI_CLK>,
> +				 <&gcc GCC_VIDEO_THROTTLE_CORE_CLK>,
> +				 <&gcc GCC_VIDEO_VCODEC0_SYS_CLK>,
> +				 <&gcc GCC_VCODEC0_AXI_CLK>;
> +			clock-names = "core",
> +				      "iface",
> +				      "bus",
> +				      "throttle",
> +				      "vcodec0_core",
> +				      "vcodec0_bus";
> +
> +			memory-region = <&pil_video_mem>;
> +			iommus = <&apps_smmu 0x860 0x0>,
> +				 <&apps_smmu 0x880 0x0>,
> +				 <&apps_smmu 0x861 0x04>,
> +				 <&apps_smmu 0x863 0x0>,
> +				 <&apps_smmu 0x804 0xe0>;
> +
> +			interconnects = <&mmnrt_virt MASTER_VIDEO_P0 RPM_ALWAYS_TAG
> +					 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>,
> +					<&bimc MASTER_APPSS_PROC RPM_ACTIVE_TAG
> +					 &config_noc SLAVE_VENUS_CFG RPM_ACTIVE_TAG>;
> +			interconnect-names = "video-mem",
> +					     "cpu-cfg";
> +
> +			venus_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-133333333 {
> +					opp-hz = /bits/ 64 <133333333>;
> +					required-opps = <&rpmpd_opp_low_svs>;
> +				};
> +
> +				opp-240000000 {
> +					opp-hz = /bits/ 64 <240000000>;
> +					required-opps = <&rpmpd_opp_svs>;
> +				};
> +			};
> +		};
> +
>   		mdss: display-subsystem@5e00000 {
>   			compatible = "qcom,qcm2290-mdss";
>   			reg = <0x0 0x05e00000 0x0 0x1000>;
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

