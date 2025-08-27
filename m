Return-Path: <linux-kernel+bounces-787464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CAEB376D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9AF4163209
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5767199E89;
	Wed, 27 Aug 2025 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lu9R20El"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1FF7E0FF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756257628; cv=none; b=KSBbDBkbwmNxcNK4DZDvd1IdRfvRvDn1QAWvkWGnnoM+WVe4JLb0eJnYMZpW4gVzEd288sXVELLCg2GgTDDR7kICyEmUcKZBxnsyRtsDdlRUEPFsLeWxPZefS6q/nVQ6JGkUEuMbJKQZNQJ2qSK+wKDJ4iZ2lEIC/nx2GPDwALg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756257628; c=relaxed/simple;
	bh=poieTlsyY1cLQWGzxhRq7UJJusIqma5TDI0g2OmhCPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCkKVAOPxfiKfkH+CZDF4NLH/AcNojFlFKG1SW1M8lpeAJ9RppWlfN+fHuk9B8cFX/ePRw/In6YucWHe8FdY6YMh44bvI13/7rX1kyz0PtSYKg6z9bQJteB002VkoCXyvUu+tNJOKuE8JActnQAgKY8msAp+UUbMyb7VA/86E/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lu9R20El; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QJpJ1i006924
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=w/Xn+WN5sZN7Gioa60k8DdWJ
	ObxIkjRSuxFZ7uva++I=; b=lu9R20ElEb4wMvM0fGhG2Sc/xNgy2iMWZqhMH4F/
	hDHUsf9UZIqF7DmKCCLFmHYzTS4K6M8JJ01mG8YJ2BsetXgiN7VuCy2dMWBScBOW
	zSmaJQscYtA9Ggxwu+k817ax+pVwKYmnrc7b0TZ0DLp7U0HEYlgLtwaXQrITcShR
	2pj9XIzTYsrZoilKT0T8zdGz0jMBuVCaI3sTNH9jmvFaPYCi4JU2LI05UPXRxQkG
	GBqHT1YC6dQeCQ+5B4nG6ZmoiWyoEyV0B1P0enflkwgRyEqk3xauxOGGYoJZd0oh
	pu+ljD2VpkY0X5cye4DtSG+AMrRwBlp3PLlVKk/zJ9U7/Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5untrsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:20:25 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70ddbb816f3so8010106d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756257624; x=1756862424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/Xn+WN5sZN7Gioa60k8DdWJObxIkjRSuxFZ7uva++I=;
        b=HdxKsDgXXQT3eIysYHG+gg3Txau/8tD3KdkbA4DgNzOd3PY5tLSa6sjQ+UAppP0PwD
         +EyalwiSfD4wDozBXpfxty89bATpiJCXSdP5zMnsl18wtot+RDiAQ2+JgYp17U1JYRpg
         UCke8AfWEEEcSWWbyowWFDBI45I8ARRAjqyUx//h35rJ9jqZAHTTQu2fCFvvgnEIOsTE
         RaV+i6p8sFU7zkZpOMR0mCN8L0SWYNQzRYyCROvGq/dVM4PSLrIwBStjSb8I6DJ1saRA
         gi3SGDDDuVholyX4l7r0tUvn0z07vrU6hWz6TR801unGuMJpbSFn1nJpsKpCuI/OEh1l
         Cddg==
X-Forwarded-Encrypted: i=1; AJvYcCVdT6H1h3VEFNhoOGPAYZpXzIIx0058WeOJfYAcDJLRM4FIjE/tbqgFrjsvQxuJJ+ihmjzRBibh8pxTnRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB69SRQgTW6cW9XBwOWazLsJ7bC8NtkM6UzSWoqyLkiS0SunHU
	brA8rvF5mCFO7e87GNz1L5X30Rj2+4LSO0yCiRW5GZYjf4DiLiDPuEbElWrU2yG/hG0Q0rvetOr
	nmol+hBH7io1FvHoEysyEGGU1FnO045NnHWQpW6ZsZcGpOtoIBxY1ZFH5kDyB9cPkLts=
X-Gm-Gg: ASbGncsI0514yULaRBbZghtrAuOQhEC54M/JZOiY0lDETZInGo4ZX3Yej1/qeTR0oQ/
	AsNWTXiSwvn3SnvdSl/Bq22O8xtXlScbbrha5FjR7AQ98MAkicNBt4OnYsG4JEg8QM56trWhWJx
	J+XtWhFui+uHbNCtqx4/vfsBSwCmAXg4JxxlK9MJQ9kU4aJ7ZIXGCGXlRxGciW/1ZZNlduxMDNT
	8Esl92t4XwLBtmyIC+BnN9xuiiq92N63dEIjE2g5lBqJBvFdcvKuLHBBeb0cigbsoCItPes06JD
	696/7EDVoX08CVuRYggJb+4zchnTAGddhy2i8WXNw6aPBNpPukwVB4c2EeCD+mfKVLboTIAV9tS
	B5AHYF0NRczAmWV+4lttcSMpwPYyWPgRTDi/Uz/ESXK9SQXynQPKT
X-Received: by 2002:a05:6214:5013:b0:70d:a9aa:cf4d with SMTP id 6a1803df08f44-70da9aad0edmr158898376d6.18.1756257623961;
        Tue, 26 Aug 2025 18:20:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj7mqvlBJ1auHCNj37evOwAu64GQSmzOL1BDuqIdwslMygY6vB1q7fRLG4+OgUF4zumDU1lw==
X-Received: by 2002:a05:6214:5013:b0:70d:a9aa:cf4d with SMTP id 6a1803df08f44-70da9aad0edmr158898066d6.18.1756257623302;
        Tue, 26 Aug 2025 18:20:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e60a67bsm24910871fa.73.2025.08.26.18.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:20:22 -0700 (PDT)
Date: Wed, 27 Aug 2025 04:20:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
Subject: Re: [PATCH 2/5] arm64: dts: qcom: lemans: Add SDHC controller and
 SDC pin configuration
Message-ID: <rxd4js6hb5ccejge2i2fp2syqlzdghqs75hb5ufqrhvpwubjyz@zwumzc7wphjx>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-2-08016e0d3ce5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826-lemans-evk-bu-v1-2-08016e0d3ce5@oss.qualcomm.com>
X-Proofpoint-GUID: owU_cW3MQKKBfd_vzZox6cHhFZrzrcTa
X-Proofpoint-ORIG-GUID: owU_cW3MQKKBfd_vzZox6cHhFZrzrcTa
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68ae5d59 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=xnlQaYUteIq3HUSXtOEA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX5ZyLFW9hCpBe
 8m64SFCOmzeXdS5Aerv+eJ0sDND7W9816yBK8L568WTvFWF5oVX9wCuqvxC4gGZhWPcCUk3me7r
 yMPgM/2acN8B2qpL7OXty6ydpdx4aFVt9CvT+NRDWGQdqpazb4CuhVOjUcsG1kAh47x8lhOJiN8
 5PHcF+cnlO6UQsEebYx4NrZt9jp4I823w8xhUTU0UU7OuRcb1sJDKlBoywIWtV4O0AFybX0F747
 lAK7PXK+efxG+ejVe1uGip4wQbJNxhUmeIWMzWmB427hOsW6iXFs1OMIyboxGXSGtF0apXcIjmd
 s5lUgJm/lqZRdMvVC8wSVdP/qoP/AuGqt9QZfdaLIuQZfZAQihWX5JhZut57HqZUt4bZkFRa+NP
 w53cylf/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
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
>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> index 99a566b42ef2..a5a3cdba47f3 100644
> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
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
> +
> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> +				 <&gcc GCC_SDCC1_APPS_CLK>;
> +			clock-names = "iface", "core";
> +
> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
> +
> +			iommus = <&apps_smmu 0x0 0x0>;
> +			dma-coherent;
> +
> +			resets = <&gcc GCC_SDCC1_BCR>;
> +
> +			no-sdio;
> +			no-mmc;
> +			bus-width = <4>;

This is the board configuration, it should be defined in the EVK DTS.

> +			qcom,dll-config = <0x0007642c>;
> +			qcom,ddr-config = <0x80040868>;
> +
> +			status = "disabled";
> +		};
> +
>  		usb_0_hsphy: phy@88e4000 {
>  			compatible = "qcom,sa8775p-usb-hs-phy",
>  				     "qcom,usb-snps-hs-5nm-phy";
> @@ -5643,6 +5673,46 @@ qup_uart21_rx: qup-uart21-rx-pins {
>  					function = "qup3_se0";
>  				};
>  			};
> +
> +			sdc_default: sdc-default-state {
> +				clk-pins {
> +					pins = "sdc1_clk";
> +					bias-disable;
> +					drive-strength = <16>;
> +				};
> +
> +				cmd-pins {
> +					pins = "sdc1_cmd";
> +					bias-pull-up;
> +					drive-strength = <10>;
> +				};
> +
> +				data-pins {
> +					pins = "sdc1_data";
> +					bias-pull-up;
> +					drive-strength = <10>;
> +				};
> +			};
> +
> +			sdc_sleep: sdc-sleep-state {
> +				clk-pins {
> +					pins = "sdc1_clk";
> +					drive-strength = <2>;
> +					bias-bus-hold;
> +				};
> +
> +				cmd-pins {
> +					pins = "sdc1_cmd";
> +					drive-strength = <2>;
> +					bias-bus-hold;
> +				};
> +
> +				data-pins {
> +					pins = "sdc1_data";
> +					drive-strength = <2>;
> +					bias-bus-hold;
> +				};
> +			};
>  		};
>  
>  		sram: sram@146d8000 {
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

