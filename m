Return-Path: <linux-kernel+bounces-799013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE26B425D8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683DA1BA6B02
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C336286416;
	Wed,  3 Sep 2025 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l1NjJ32X"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC95721858D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914528; cv=none; b=RV/q2A2k5gcOCf2gvOhHPpaLQKcqqSldAZ8d5k0D8Wtegatxvf43drXGOzXXStKnH79fGBYmCgyRBvKFQVxwIpx0IbDekliqWh09vdnPdOfYxbaxxodkzeqMp8XKQdKpcy74vAd2gmGJ109SskxQKcTHCavpx15dpovtkkMYINA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914528; c=relaxed/simple;
	bh=I4dvzksBGLJ7YYqBj4cjUhjzhWLD2Q/j5EaHEBCG64M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDdtgDjERDM6a04Y677h3AwBrFE8wN87LsxMl2rvpkTSdtAskkLlkIlKz3Lu6/vkM6xpVu22IljBKoQqK2rzxL3QcHeoHb5u139gLb3Y1EMgnExuoXqDmC8OAg80Crj8Pw/9u/YScEHhd1UF7c7V40FZavegTo98e6rvdgp0zHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l1NjJ32X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dwsv6032507
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 15:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AbNhMpUtMiEUnNVgjFV19+ZJvfwkIjVGX0qqonuR6xo=; b=l1NjJ32XMyIouWXu
	5D27dZcyCCd+V2HyYNKBkRytf2E1U5BQhTOUduM2VlnxIBbH0bk7JzAhnAwv6Tf4
	nVNQfvyFG58cvXVianxi8AlFctEDVBAVanAycQUTgoYw/KNW0y0OCn6K3qpuu4Pm
	zSKcLq1GRKGI2jepchKl40cZnRULSoS/JMALFkAW3BrrBpnuxiAMKLCgDTN6R1fb
	BFaf9lD6bm10cU0CQgT5n1alPDxQ5edxHB/wbP+FqqCrH9LQvEhzQcK2muiaPEpG
	jnGb5nxHjOLV7+plzke+kUklmwSUA1RAyJy7PIkROgcdhkKS4tHkBGsgC4vjuawB
	+10pRw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush345au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 15:48:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b48f648249so180001cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756914524; x=1757519324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbNhMpUtMiEUnNVgjFV19+ZJvfwkIjVGX0qqonuR6xo=;
        b=M4mUyWfA+dr4xwTdPNf5Bp0dTDpfotDNpoFosCsGQ1QJ+eAmLxHSUnqO2bRyZjDPMd
         /R5iK/MW82AIZ9TciWlpRwxKIVgW6TlW+9EfMfKFvTnCPn6mrFmoxqybWVfrwVydROt5
         pQLLJ+7lF//hwMH8nVKop72Bk+LE/7X+RuzzhQme9DTaPV0shs4GyuwSE1iHms062lJd
         koEpzfJaFNtbAx5RByvUy5CpmRCTQ1NgCHG5AIdnuoIHPjszaR7fRYdQI2VVE7S2kenL
         pnCT8mYdujRx4Zjl7/12L99/1/7djT/i4wWnCHtiMV6ccBfw7Kq+rWO3iq0nUrqQfTbJ
         g4hg==
X-Forwarded-Encrypted: i=1; AJvYcCVnl3SjAlgn7DnpC4w8BVC1V3zRFWnE5mfZiK857UjCBCIXG1S53XLp36R1ACu7fbjV38Ds6cty2LfJjqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbdsz9W9VGiT2EWQtaxTUGTkP1MQTnpT4fcaDSRHO9dPeEcNEx
	ctC6N8p/EH52XTvp3qqpmH27N6jRnkSY+vKUsrZbRpww02tG+4JlDhtPhL0FyZMf/Y35Hy5QkW5
	Gz0qk+KsuIhH6cO8gV3eqX2oVrV8dpMfa6Rd1wNpGqwKUjtFCTc0Vp2jzCgiIVvgBUoCJViFSed
	0=
X-Gm-Gg: ASbGnct2j9aeyDwn8fDOUwCiLQEBS2S057AeigJSsAsMVg7m5XAI7j26IM8pkWSDsER
	N4/Gjlb5G1tUwZ3lEHwh0+3VLAfEt7FZWnNft6ZndqH7ssHLN1kbZ5h0ukVBbW1GiAji7mlHCJh
	wDHXjonSQhHo4QVuaz0mKmBlOr6S7fJvWpy67KQOuONdGuOBP4/xngYcdJqaQ6FSO5NbJs1qe+A
	xWY70T7+32u3YfB3QDUDxaS+5+IIv7XrAKy5mNESUC7Z9QLN93Q1MGJV+UKoOex+00dH8hjcjEx
	LoGtPflJasww95n8mPEtZIcN+RBena7GHnLQpIvwZnbWDO+tqdH9sdtzL/WbMcQVVMzegl+LGDd
	HjWCSiXPUUG6u5m40Od153g==
X-Received: by 2002:ac8:5790:0:b0:4b2:d2ea:f8fa with SMTP id d75a77b69052e-4b313f40452mr157015331cf.9.1756914524055;
        Wed, 03 Sep 2025 08:48:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZCJQ2TWEynp/QBOoS3m9oi3irQOjHy8GVuyxF08zwcCb9nsDksfZu3ls0HCvZ0YFtj5n0xA==
X-Received: by 2002:ac8:5790:0:b0:4b2:d2ea:f8fa with SMTP id d75a77b69052e-4b313f40452mr157015011cf.9.1756914523509;
        Wed, 03 Sep 2025 08:48:43 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b03ab857474sm1070857866b.89.2025.09.03.08.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 08:48:42 -0700 (PDT)
Message-ID: <8a963e12-1113-4604-b15f-a5867c4b5bbf@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 17:48:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] arm64: dts: qcom: lemans: Add SDHC controller
 and SDC pin configuration
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Monish Chunara <quic_mchunara@quicinc.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-2-bfa381bf8ba2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-2-bfa381bf8ba2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX5aSWjcl9fcc0
 NzI5BEimRx4X72si+1B8Z5xKh8kA/ZOjkEyKPpXFOMG15DmzwLoMs3sKOPQ62mHdBxow+l/qA8J
 xhK+bSnDY5ZMK1XsKR/n0G/5l8EFJLYsVP4TdTxYdcVQ1ZzaT0c8HA4GqMGT87JhIM2fSIUXLDh
 9A9ujHONG5gKQg2pt8GQLOQjcXQ3Kp5Z+ZbDzsJ31TcPGeeT2NIqVcYHD7yIr1w5N4xeSgqexW/
 udOARV4EGQuRf8f++sllWXnvTjR0wiRc0b1YRA3OxAJLgzkRhEh8Jis1Y50Ze4BfgnbxzYJJLTo
 GzPmSwdD+ZIxOcOUI6geTWPWTKoqvHK2rVJpMYCwTjFR6Qlp/ULRMm0RWMRPLDfh6ksy8J/A6X7
 ZPognJIP
X-Proofpoint-ORIG-GUID: B7bvM8DAzLhw0cQcmlmkAEdFNVnAnrFK
X-Proofpoint-GUID: B7bvM8DAzLhw0cQcmlmkAEdFNVnAnrFK
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b8635d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=GqXf0neY-Zx-3wbHtdMA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

On 9/3/25 1:47 PM, Wasim Nazir wrote:
> From: Monish Chunara <quic_mchunara@quicinc.com>
> 
> Introduce the SDHC v5 controller node for the Lemans platform.
> This controller supports either eMMC or SD-card, but only one
> can be active at a time. SD-card is the preferred configuration
> on Lemans targets, so describe this controller.
> 
> Define the SDC interface pins including clk, cmd, and data lines
> to enable proper communication with the SDHC controller.
> 
> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans.dtsi | 91 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> index 99a566b42ef2..9e4709dce32b 100644
> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> @@ -3834,6 +3834,57 @@ apss_tpdm2_out: endpoint {
>  			};
>  		};
>  
> +		sdhc: mmc@87c4000 {
> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0x0 0x087c4000 0x0 0x1000>;
> +
> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";

1 entry per line in xx-names too, please> +
> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> +				 <&gcc GCC_SDCC1_APPS_CLK>;
> +			clock-names = "iface", "core";
> +
> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;

QCOM_ICC_TAG_ALWAYS for the first path, both endpoints
QCOM_ICC_TAG_ACTIVE_ONLY for the second one

[...]

> +
> +				data-pins {
> +					pins = "sdc1_data";
> +					bias-pull-up;

Please put bias properties below drive-strength for consistency

Konrad

