Return-Path: <linux-kernel+bounces-662052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3726DAC34DC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 May 2025 15:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148587ABD11
	for <lists+linux-kernel@lfdr.de>; Sun, 25 May 2025 13:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1AE1F3FDC;
	Sun, 25 May 2025 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d1zAbqcu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB0427462
	for <linux-kernel@vger.kernel.org>; Sun, 25 May 2025 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748179550; cv=none; b=e2qMAbVFIVAXIpM3GEmQH8tBXg1BSWJmUBqe/7ZrwDikw61uegzMQCLre/igUbSN1XEBSBY5ArDgrPzq725L4CaFxKRO0oRW68JB8Kso0dwwxKTNh+5Shls9Fct2Lx3nmDL2lHM68GVxRrCzYnWil2Vl/ANdhsLJmMC5Gkemk6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748179550; c=relaxed/simple;
	bh=JAeHJsMCWwrelS4+QafkAuK9zsLVlF78xZFFRvm2y6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9GtIb7TQQLxGgL8hjqj/dWvaOGSyaHtbBhienS/rS6XMPmiqpMroeoBjY4oq0Uv84zqCiLfKM0yoCz02ij04vJLJMdxws3SOcQ6OnGrkpTZDX3hrKo2u0/m1Umdj+JfPQmsSc0dpkQaF4lzQswOSe/tjhxSrh3QtHFHv+Na/TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d1zAbqcu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54PCi7FU011960
	for <linux-kernel@vger.kernel.org>; Sun, 25 May 2025 13:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8qxwPfAW5rvyxxMO9G7XQKV8
	iYVaJTHBOgdAdXwVtY4=; b=d1zAbqcufinJk2pNh51HnzH0JXX1xiP/F4rySQyp
	SxpqXgXr096XVYDipuX5jPEYg5GS+Wm30GnCbellvEMsTymXIeX8uQ4//WnYDh2w
	luMcT6k3CG+jGGSTrzqPwCBbbMASX/FGdQ8xaqkWv3qIjlRFl2pzjwnGfb91OCR1
	2yWI9NXMiRGTaUR7/oCNwJF9ES293aYImhIukeN1NQ9x62a1atmg6RS7uvsbkrWg
	KCCa6ZLhtWs3rd1CsLhqAv71HJW35+SVJulwDqYy4w+8Uk2yas5WSsRgp5aAi2LY
	xt6mFIK9miBWkIMzFwEJd1kKFtcE0IWn6wEpkeyqLb6Gqg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u6b5j0dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 25 May 2025 13:25:47 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6faa57b2d99so6711016d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 May 2025 06:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748179545; x=1748784345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qxwPfAW5rvyxxMO9G7XQKV8iYVaJTHBOgdAdXwVtY4=;
        b=YGkz0KAMNtFncKhhNr2wE/p8IJ9I0Xii6QlwPIrscZQnCCcfO6QqWlHUgW2hsZlhSt
         u2v0wjSsqnnB8Zhql/bsb/aiDWhNMGvCjzBWnop0ftys/7ER4jY9hMaH4BULGKlaT+0m
         iLV2//jxoyvoORrRm95K5PNT7iUKbuy0IBkgJ/duO1V3dWwN/O9BYv/UVUudDHQNIe7M
         7hwt2aUk6lR59DzJkIQSPIwyKHr2jrvT0Lq9y7kFLAan7doQacIM4Aa3lpEc/O4sCcOR
         cxFIdC1K3Gdyn3Pu8/mIprgYYUizQYSYCZlZ/CPLqQQZzv6i0HERQMP2K24TxBKXDx5W
         FLKA==
X-Forwarded-Encrypted: i=1; AJvYcCWDhlW3cDKnmqzo/FLG0W8BPvBkNVNpBLyX19mV/BOYbFtldmhxPXa/KjG11TzUYt+GXp9IIV3zfJIo10U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwulIDMbXgEP0WtaRsSYATVc566r55k7tFCWLek4DrEapj9jR3R
	kJX8zXIeruRInUljIAFR0fmiT1ryaO/m3vqSRBO2ijdSknytsrqNOqC1fSBojkxFBoTISg60gPB
	0XqAPqlcCJYA/81bviDxDye/sA8WXPW16GZU1aPp2nDMvIpAzkN4b+CVKx4hxx8A2rcI=
X-Gm-Gg: ASbGnctxzsWeAGLRINqwoAjGnePhqzdanCLb4qTSdRnFVsh49eQzSLE+mpSFGyzFT9m
	On0Jl58L2pV/baewbB8Zgji42+nJtUIFcFrLUTX+aYrpv+ZxxIr9r+DE+vaaouAMlZLXlDgmrmc
	VqKZSYJfKL+setqajnHgnp36UJK337C5FCFPZZfEChF5O2t/g7swMt0hIWkXp8qrQvDRzqxhVJP
	2KGeuciZEB7TWQ6Vm54raMvg7R1sMgnM4VzeaZ2ti1AHdZa4JFhnLXmDlG1taHXhtD1iqNNnOtL
	IMzHjYtKhREKp26nDBzArQeGgj/Sd1l7EHk5COsVmDs8aaLFYVFALg+kGncAxiElnSyZvVp7YOw
	=
X-Received: by 2002:a05:6214:c41:b0:6f8:c53f:48e with SMTP id 6a1803df08f44-6fa9353802bmr143369466d6.0.1748179545159;
        Sun, 25 May 2025 06:25:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtrZjOUglEDwNT4Bci5DHSCoW4Me6LPk/kevDxBGSjaqg6AigcYA1Mut5GNz6LsMKmzFQneg==
X-Received: by 2002:a05:6214:c41:b0:6f8:c53f:48e with SMTP id 6a1803df08f44-6fa9353802bmr143369106d6.0.1748179544635;
        Sun, 25 May 2025 06:25:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-328085b8e79sm43850381fa.85.2025.05.25.06.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 06:25:43 -0700 (PDT)
Date: Sun, 25 May 2025 16:25:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Val Packett <val@packett.cool>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: qcom: Add support for X1E80100 Dell
 Latitude 7455
Message-ID: <a5tx3ekokrd5zif646ukd5z4gzkyod3b4vcjktwahtej7dpare@43djxfwza2jb>
References: <20250525095341.12462-2-val@packett.cool>
 <20250525095341.12462-4-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250525095341.12462-4-val@packett.cool>
X-Authority-Analysis: v=2.4 cv=ZcodNtVA c=1 sm=1 tr=0 ts=68331a5b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=DBsPRCNaqFyA5W2_L88A:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI1MDEyNCBTYWx0ZWRfX0DsBQ+U9fdfg
 aeQaZuInvKve7w0p4hHqORfIAlfW5xzpUZw8rRTbgqCwtLRmNMMa/10yvmSSkZS1x8inRaSD5Yv
 Hs2EfC9pSrlfM5xh9NKGvZUTc79XcgZLDfiPVA387ue8r22JhaR5j3Mi1GBiulwr+pix58ySZBv
 s29oI0V7kW6dsu/2v54zhifaF8xz9sKW1zr+5618hrGf5wNwYUjUCNkn54bZBrP0IgBcP0dR762
 GXjY6joJpEPsdg2xmTkBuqt+AhvoUhOxyCNnxSnHpOIffKQgeLZlNsc5tIgC3+falbWpIDRV6ue
 yq7h808q7337EtGkmW8hMiyGK0F3ql0O/wwFU9PBPsZNiuIunC+2KlajDSOXr3WMmkJM0uWe9O7
 23cc4Ef/xDEF5RXjfM/76HJXUxjc47e6BegGQS370NE4aAu9T7nQutkJcBHYH03ymkgWLndI
X-Proofpoint-GUID: xLLVMjMrFJUR7DA9Ny3uKuTP3RuKipuc
X-Proofpoint-ORIG-GUID: xLLVMjMrFJUR7DA9Ny3uKuTP3RuKipuc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-25_05,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505250124

On Sun, May 25, 2025 at 06:53:34AM -0300, Val Packett wrote:
> Add a device tree for the Dell Latitude 7455 (X Elite) laptop.
> 
> Working:
> - Wi-Fi (WCN7850 hw2.0)
> - Bluetooth
> - USB Type-C x2 (with DP alt mode)
> - USB Type-A
> - USB Fingerprint reader
> - eDP Display (with brightness)
> - NVMe
> - SDHC (microSD slot)
> - Keyboard
> - Touchpad
> - Touchscreen
> - Battery
> 
> Not included:
> - Audio
> - Camera
> 
> Signed-off-by: Val Packett <val@packett.cool>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |    2 +
>  .../dts/qcom/x1e80100-dell-latitude-7455.dts  | 1484 +++++++++++++++++
>  2 files changed, 1486 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts
> 

> +	pmic-glink {
> +		compatible = "qcom,x1e80100-pmic-glink",
> +			     "qcom,sm8550-pmic-glink",
> +			     "qcom,pmic-glink";
> +		orientation-gpios = <&tlmm 121 GPIO_ACTIVE_HIGH>,
> +				    <&tlmm 123 GPIO_ACTIVE_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* Display-adjacent port */
> +		connector@0 {
> +			compatible = "usb-c-connector";
> +			reg = <0>;
> +			power-role = "dual";
> +			data-role = "dual";

What does UCSI tell about these connectors? Are they really
dual-data-role?

> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					pmic_glink_ss0_hs_in: endpoint {
> +						remote-endpoint = <&usb_1_ss0_dwc3_hs>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					pmic_glink_ss0_ss_in: endpoint {
> +						remote-endpoint = <&retimer_ss0_ss_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					pmic_glink_ss0_con_sbu_in: endpoint {
> +						remote-endpoint = <&retimer_ss0_con_sbu_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		/* User-adjacent port */
> +		connector@1 {
> +			compatible = "usb-c-connector";
> +			reg = <1>;
> +			power-role = "dual";
> +			data-role = "dual";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					pmic_glink_ss1_hs_in: endpoint {
> +						remote-endpoint = <&usb_1_ss1_dwc3_hs>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					pmic_glink_ss1_ss_in: endpoint {
> +						remote-endpoint = <&retimer_ss1_ss_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					pmic_glink_ss1_con_sbu_in: endpoint {
> +						remote-endpoint = <&retimer_ss1_con_sbu_out>;
> +					};
> +				};
> +			};
> +		};
> +	};

> +
> +	vreg_wcn_3p3: regulator-wcn-3p3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_WCN_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 214 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&wcn_sw_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	/*
> +	 * TODO: These two regulators are actually part of the removable M.2
> +	 * card and not the mainboard. Need to describe this differently.
> +	 * Functionally it works correctly, because all we need to do is to
> +	 * turn on the actual 3.3V supply above.
> +	 */

Indeed, it should be possible to describe just M.2 card, because in
theory nothing prevents you from swapping it with some other card.
I _think_, it should be possible to describe WiFI part by listing 3.3V
supply as slot supply. However I don't think we have a way "random BT
connected to the UART". So, this is probably suitable.

> +	vreg_wcn_0p95: regulator-wcn-0p95 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_WCN_0P95";
> +		regulator-min-microvolt = <950000>;
> +		regulator-max-microvolt = <950000>;
> +
> +		vin-supply = <&vreg_wcn_3p3>;
> +	};
> +
> +	vreg_wcn_1p9: regulator-wcn-1p9 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_WCN_1P9";
> +		regulator-min-microvolt = <1900000>;
> +		regulator-max-microvolt = <1900000>;
> +
> +		vin-supply = <&vreg_wcn_3p3>;
> +	};
> +
> +	wcn7850-pmu {
> +		compatible = "qcom,wcn7850-pmu";
> +
> +		vdd-supply = <&vreg_wcn_0p95>;
> +		vddio-supply = <&vreg_l15b_1p8>;
> +		vddaon-supply = <&vreg_wcn_0p95>;
> +		vdddig-supply = <&vreg_wcn_0p95>;
> +		vddrfa1p2-supply = <&vreg_wcn_1p9>;
> +		vddrfa1p8-supply = <&vreg_wcn_1p9>;
> +
> +		wlan-enable-gpios = <&tlmm 117 GPIO_ACTIVE_HIGH>;
> +		bt-enable-gpios = <&tlmm 116 GPIO_ACTIVE_HIGH>;
> +
> +		pinctrl-0 = <&wcn_wlan_bt_en>;
> +		pinctrl-names = "default";
> +
> +		regulators {
> +			vreg_pmu_rfa_cmn: ldo0 {
> +				regulator-name = "vreg_pmu_rfa_cmn";
> +			};
> +
> +			vreg_pmu_aon_0p59: ldo1 {
> +				regulator-name = "vreg_pmu_aon_0p59";
> +			};
> +
> +			vreg_pmu_wlcx_0p8: ldo2 {
> +				regulator-name = "vreg_pmu_wlcx_0p8";
> +			};
> +
> +			vreg_pmu_wlmx_0p85: ldo3 {
> +				regulator-name = "vreg_pmu_wlmx_0p85";
> +			};
> +
> +			vreg_pmu_btcmx_0p85: ldo4 {
> +				regulator-name = "vreg_pmu_btcmx_0p85";
> +			};
> +
> +			vreg_pmu_rfa_0p8: ldo5 {
> +				regulator-name = "vreg_pmu_rfa_0p8";
> +			};
> +
> +			vreg_pmu_rfa_1p2: ldo6 {
> +				regulator-name = "vreg_pmu_rfa_1p2";
> +			};
> +
> +			vreg_pmu_rfa_1p8: ldo7 {
> +				regulator-name = "vreg_pmu_rfa_1p8";
> +			};
> +
> +			vreg_pmu_pcie_0p9: ldo8 {
> +				regulator-name = "vreg_pmu_pcie_0p9";
> +			};
> +
> +			vreg_pmu_pcie_1p8: ldo9 {
> +				regulator-name = "vreg_pmu_pcie_1p8";
> +			};
> +		};
> +	};
> +};
> +
> +&apps_rsc {
> +	regulators-0 {
> +		compatible = "qcom,pm8550-rpmh-regulators";
> +		qcom,pmic-id = "b";
> +
> +		vdd-bob1-supply = <&vph_pwr>;
> +		vdd-bob2-supply = <&vph_pwr>;
> +		vdd-l1-l4-l10-supply = <&vreg_s4c_1p8>;
> +		vdd-l2-l13-l14-supply = <&vreg_bob1>;
> +		vdd-l5-l16-supply = <&vreg_bob1>;
> +		vdd-l6-l7-supply = <&vreg_bob2>;
> +		vdd-l8-l9-supply = <&vreg_bob1>;
> +		vdd-l12-supply = <&vreg_s5j_1p2>;
> +		vdd-l15-supply = <&vreg_s4c_1p8>;
> +		vdd-l17-supply = <&vreg_bob2>;
> +
> +		vreg_bob1: bob1 {
> +			regulator-name = "vreg_bob1";
> +			regulator-min-microvolt = <3008000>;
> +			regulator-max-microvolt = <3960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_bob2: bob2 {
> +			regulator-name = "vreg_bob2";
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1b_1p8: ldo1 {
> +			regulator-name = "vreg_l1b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2b_3p0: ldo2 {
> +			regulator-name = "vreg_l2b_3p0";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3100000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4b_1p8: ldo4 {
> +			regulator-name = "vreg_l4b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6b_1p8: ldo6 {
> +			regulator-name = "vreg_l6b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7b_2p8: ldo7 {
> +			regulator-name = "vreg_l7b_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l8b_3p0: ldo8 {
> +			regulator-name = "vreg_l8b_3p0";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3072000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l9b_2p9: ldo9 {
> +			regulator-name = "vreg_l9b_2p9";
> +			regulator-min-microvolt = <2960000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l12b_1p2: ldo12 {
> +			regulator-name = "vreg_l12b_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l13b_3p0: ldo13 {
> +			regulator-name = "vreg_l13b_3p0";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3100000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l14b_3p0: ldo14 {
> +			regulator-name = "vreg_l14b_3p0";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3072000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l15b_1p8: ldo15 {
> +			regulator-name = "vreg_l15b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-1 {
> +		compatible = "qcom,pm8550ve-rpmh-regulators";
> +		qcom,pmic-id = "c";
> +
> +		vdd-l1-supply = <&vreg_s5j_1p2>;
> +		vdd-l2-supply = <&vreg_s1f_0p7>;
> +		vdd-l3-supply = <&vreg_s1f_0p7>;
> +		vdd-s4-supply = <&vph_pwr>;
> +
> +		vreg_s4c_1p8: smps4 {
> +			regulator-name = "vreg_s4c_1p8";
> +			regulator-min-microvolt = <1856000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1c_1p2: ldo1 {
> +			regulator-name = "vreg_l1c_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2c_0p8: ldo2 {
> +			regulator-name = "vreg_l2c_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3c_0p8: ldo3 {
> +			regulator-name = "vreg_l3c_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-2 {
> +		compatible = "qcom,pmc8380-rpmh-regulators";
> +		qcom,pmic-id = "d";
> +
> +		vdd-l1-supply = <&vreg_s1f_0p7>;
> +		vdd-l2-supply = <&vreg_s1f_0p7>;
> +		vdd-l3-supply = <&vreg_s4c_1p8>;
> +		vdd-s1-supply = <&vph_pwr>;
> +
> +		vreg_l1d_0p8: ldo1 {
> +			regulator-name = "vreg_l1d_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2d_0p9: ldo2 {
> +			regulator-name = "vreg_l2d_0p9";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3d_1p8: ldo3 {
> +			regulator-name = "vreg_l3d_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-3 {
> +		compatible = "qcom,pmc8380-rpmh-regulators";
> +		qcom,pmic-id = "e";
> +
> +		vdd-l2-supply = <&vreg_s1f_0p7>;
> +		vdd-l3-supply = <&vreg_s5j_1p2>;
> +
> +		vreg_l2e_0p8: ldo2 {
> +			regulator-name = "vreg_l2e_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3e_1p2: ldo3 {
> +			regulator-name = "vreg_l3e_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-4 {
> +		compatible = "qcom,pmc8380-rpmh-regulators";
> +		qcom,pmic-id = "f";
> +
> +		vdd-l1-supply = <&vreg_s5j_1p2>;
> +		vdd-l2-supply = <&vreg_s5j_1p2>;
> +		vdd-l3-supply = <&vreg_s5j_1p2>;
> +		vdd-s1-supply = <&vph_pwr>;
> +
> +		vreg_s1f_0p7: smps1 {
> +			regulator-name = "vreg_s1f_0p7";
> +			regulator-min-microvolt = <700000>;
> +			regulator-max-microvolt = <1100000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-6 {
> +		compatible = "qcom,pm8550ve-rpmh-regulators";
> +		qcom,pmic-id = "i";
> +
> +		vdd-l1-supply = <&vreg_s4c_1p8>;
> +		vdd-l2-supply = <&vreg_s5j_1p2>;
> +		vdd-l3-supply = <&vreg_s1f_0p7>;
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s2-supply = <&vph_pwr>;
> +
> +		vreg_l1i_1p8: ldo1 {
> +			regulator-name = "vreg_l1i_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2i_1p2: ldo2 {
> +			regulator-name = "vreg_l2i_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3i_0p8: ldo3 {
> +			regulator-name = "vreg_l3i_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-7 {
> +		compatible = "qcom,pm8550ve-rpmh-regulators";
> +		qcom,pmic-id = "j";
> +
> +		vdd-l1-supply = <&vreg_s1f_0p7>;
> +		vdd-l2-supply = <&vreg_s5j_1p2>;
> +		vdd-l3-supply = <&vreg_s1f_0p7>;
> +		vdd-s5-supply = <&vph_pwr>;
> +
> +		vreg_s5j_1p2: smps5 {
> +			regulator-name = "vreg_s5j_1p2";
> +			regulator-min-microvolt = <1256000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1j_0p8: ldo1 {
> +			regulator-name = "vreg_l1j_0p8";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2j_1p2: ldo2 {
> +			regulator-name = "vreg_l2j_1p2";
> +			regulator-min-microvolt = <1256000>;
> +			regulator-max-microvolt = <1256000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3j_0p8: ldo3 {
> +			regulator-name = "vreg_l3j_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +};
> +
> +&gpu {
> +	status = "okay";
> +
> +	zap-shader {
> +		firmware-name = "qcom/x1e80100/dell/latitude-7455/qcdxkmsuc8380.mbn";
> +	};
> +};
> +
> +&i2c0 {
> +	clock-frequency = <400000>;
> +
> +	status = "okay";
> +
> +	keyboard@5 {
> +		compatible = "hid-over-i2c";
> +		reg = <0x5>;
> +
> +		hid-descr-addr = <0x20>;
> +		interrupts-extended = <&tlmm 67 IRQ_TYPE_LEVEL_LOW>;
> +
> +		pinctrl-0 = <&kybd_default>;
> +		pinctrl-names = "default";
> +
> +		wakeup-source;
> +	};
> +
> +	touchpad@2c {
> +		compatible = "hid-over-i2c";
> +		reg = <0x2c>;
> +
> +		hid-descr-addr = <0x20>;
> +		interrupts-extended = <&tlmm 3 IRQ_TYPE_LEVEL_LOW>;
> +
> +		pinctrl-0 = <&tpad_default>;
> +		pinctrl-names = "default";
> +
> +		wakeup-source;
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +
> +	status = "okay";

Anything present on the bus? You can add a comment with chip names (if
you know them) or just probed I2C addresses.

> +};
> +
> +
> +&i2c4 {
> +	clock-frequency = <400000>;
> +
> +	status = "okay";
> +};

Same here

> +
> +
> +&i2c20 {
> +	clock-frequency = <400000>;
> +
> +	status = "okay";

And here

> +};
> +
> +
> +&qupv3_0 {
> +	status = "okay";
> +};
> +
> +&qupv3_1 {
> +	status = "okay";
> +};
> +
> +&qupv3_2 {
> +	status = "okay";
> +};

And no GPI DMA devices?

> +
> +&remoteproc_adsp {
> +	firmware-name = "qcom/x1e80100/dell/latitude-7455/qcadsp8380.mbn",
> +			"qcom/x1e80100/dell/latitude-7455/adsp_dtbs.elf";
> +
> +	status = "okay";
> +};
> +
> +&remoteproc_cdsp {
> +	firmware-name = "qcom/x1e80100/dell/latitude-7455/qccdsp8380.mbn",
> +			"qcom/x1e80100/dell/latitude-7455/cdsp_dtbs.elf";
> +
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	cd-gpios = <&tlmm 71 GPIO_ACTIVE_LOW>;
> +	pinctrl-0 = <&sdc2_default &sdc2_card_det_n>;
> +	pinctrl-1 = <&sdc2_sleep &sdc2_card_det_n>;
> +	pinctrl-names = "default", "sleep";
> +	vmmc-supply = <&vreg_l9b_2p9>;
> +	vqmmc-supply = <&vreg_l6b_1p8>;
> +	bus-width = <4>;
> +	no-sdio;
> +	no-mmc;
> +	status = "okay";
> +};
> +
> +&smb2360_0 {
> +	status = "okay";
> +};
> +
> +&smb2360_0_eusb2_repeater {
> +	vdd18-supply = <&vreg_l3d_1p8>;
> +	vdd3-supply = <&vreg_l2b_3p0>;
> +};
> +
> +&smb2360_1 {
> +	status = "okay";
> +};
> +
> +&smb2360_1_eusb2_repeater {
> +	vdd18-supply = <&vreg_l3d_1p8>;
> +	vdd3-supply = <&vreg_l14b_3p0>;
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <44 4>,  /* SPI11 (TPM) */
> +			       <76 4>,  /* SPI19 (TZ Protected) */
> +			       <238 1>; /* UFS Reset */
> +
> +	cam_rgb_default: cam-rgb-default-state {
> +		mclk-pins {
> +			pins = "gpio100";
> +			function = "cam_aon";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +
> +		reset-n-pins {
> +			pins = "gpio237";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	cam_indicator_en: cam-indicator-en-state {
> +		pins = "gpio110";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	cam_ldo_en: cam-ldo-en-state {
> +		pins = "gpio91";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	edp_bl_en: edp-bl-en-state {
> +		pins = "gpio74";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	edp_reg_en: edp-reg-en-state {
> +		pins = "gpio70";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +
> +	eusb3_reset_n: eusb3-reset-n-state {
> +		pins = "gpio6";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-low;
> +	};
> +
> +	eusb5_reset_n: eusb5-reset-n-state {
> +		pins = "gpio184";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-low;
> +	};
> +
> +	hall_int_n_default: hall-int-n-state {
> +		pins = "gpio92";
> +		function = "gpio";
> +
> +		bias-disable;
> +	};
> +
> +	kybd_default: kybd-default-state {
> +		pins = "gpio67";
> +		function = "gpio";
> +		bias-pull-up;
> +	};
> +
> +	nvme_reg_en: nvme-reg-en-state {
> +		pins = "gpio18";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	pcie4_default: pcie4-default-state {
> +		clkreq-n-pins {
> +			pins = "gpio147";
> +			function = "pcie4_clk";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-n-pins {
> +			pins = "gpio146";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		wake-n-pins {
> +			pins = "gpio148";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	pcie6a_default: pcie6a-default-state {
> +		clkreq-n-pins {
> +			pins = "gpio153";
> +			function = "pcie6a_clk";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-n-pins {
> +			pins = "gpio152";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		wake-n-pins {
> +			pins = "gpio154";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	rtmr1_default: rtmr1-reset-n-active-state {
> +		pins = "gpio176";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	sdc2_card_det_n: sdc2-card-det-state {
> +		pins = "gpio71";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +	tpad_default: tpad-default-state {
> +		disable-pins {
> +			pins = "gpio38";
> +			function = "gpio";
> +			output-high;
> +		};
> +
> +		int-n-pins {
> +			pins = "gpio3";
> +			function = "gpio";
> +			bias-pull-up;
> +		};
> +
> +		reset-n-pins {
> +			pins = "gpio52";
> +			function = "gpio";
> +			bias-disable;
> +		};
> +	};
> +
> +	ts0_default: ts0-default-state {
> +		disable-pins {
> +			pins = "gpio75";
> +			function = "gpio";
> +			output-high;
> +		};
> +
> +		int-n-pins {
> +			pins = "gpio51";
> +			function = "gpio";
> +			bias-pull-up;
> +		};
> +
> +		reset-n-pins {
> +			/* Technically should be High-Z input */
> +			pins = "gpio48";
> +			function = "gpio";
> +			output-low;
> +			drive-strength = <2>;
> +		};
> +	};
> +
> +	usb1_pwr_1p15_reg_en: usb1-pwr-1p15-reg-en-state {
> +		pins = "gpio188";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	usb1_pwr_1p8_reg_en: usb1-pwr-1p8-reg-en-state {
> +		pins = "gpio175";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	usb1_pwr_3p3_reg_en: usb1-pwr-3p3-reg-en-state {
> +		pins = "gpio186";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	wcn_sw_en: wcn-sw-en-state {
> +		pins = "gpio214";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	wcn_wlan_bt_en: wcn-wlan-bt-en-state {
> +		pins = "gpio116", "gpio117";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +};
> +
> +&uart14 {
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "qcom,wcn7850-bt";
> +		max-speed = <3200000>;
> +
> +		vddaon-supply = <&vreg_pmu_aon_0p59>;
> +		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
> +		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
> +		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
> +		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
> +		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
> +		vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
> +	};
> +};
> +
> +&usb_1_ss0_hsphy {
> +	vdd-supply = <&vreg_l3j_0p8>;
> +	vdda12-supply = <&vreg_l2j_1p2>;
> +
> +	phys = <&smb2360_0_eusb2_repeater>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_ss0_qmpphy {
> +	vdda-phy-supply = <&vreg_l2j_1p2>;
> +	vdda-pll-supply = <&vreg_l1j_0p8>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_ss0 {
> +	status = "okay";
> +};

Please order the chunks alphabetically. &usb_1_ss0_qmpphy can't be
before &usb_1_ss0.

> +
> +&usb_1_ss0_dwc3 {
> +	dr_mode = "host";

This doesn't seem to match with the PMIC glink properties.

> +};
> +
> +&usb_1_ss0_dwc3_hs {
> +	remote-endpoint = <&pmic_glink_ss0_hs_in>;
> +};
> +
> +&usb_1_ss0_qmpphy_out {
> +	remote-endpoint = <&retimer_ss0_ss_in>;
> +};
> +
> +&usb_1_ss1_hsphy {
> +	vdd-supply = <&vreg_l3j_0p8>;
> +	vdda12-supply = <&vreg_l2j_1p2>;
> +
> +	phys = <&smb2360_1_eusb2_repeater>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_ss1_qmpphy {
> +	vdda-phy-supply = <&vreg_l2j_1p2>;
> +	vdda-pll-supply = <&vreg_l2d_0p9>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_ss1 {
> +	status = "okay";
> +};
> +
> +&usb_1_ss1_dwc3 {
> +	dr_mode = "host";

This also doesn't match PMIC GLINK configuration.

> +};
> +
> +&usb_1_ss1_dwc3_hs {
> +	remote-endpoint = <&pmic_glink_ss1_hs_in>;
> +};
> +
> +&usb_1_ss1_qmpphy_out {
> +	remote-endpoint = <&retimer_ss1_ss_in>;
> +};
> +
> +&usb_2 {
> +	status = "okay";
> +};
> +
> +&usb_2_dwc3 {
> +	dr_mode = "host";
> +};
> +
> +&usb_2_hsphy {
> +	vdd-supply = <&vreg_l2e_0p8>;
> +	vdda12-supply = <&vreg_l3e_1p2>;
> +
> +	phys = <&eusb5_frp_repeater>;
> +
> +	status = "okay";
> +};
> +
> +&usb_mp {
> +	status = "okay";
> +};
> +
> +&usb_mp_dwc3 {
> +	phys = <&usb_mp_hsphy0>, <&usb_mp_qmpphy0>;
> +	phy-names = "usb2-0", "usb3-0";
> +};
> +
> +&usb_mp_hsphy0 {
> +	vdd-supply = <&vreg_l2e_0p8>;
> +	vdda12-supply = <&vreg_l3e_1p2>;
> +
> +	phys = <&eusb3_typea_repeater>;
> +
> +	status = "okay";
> +};
> +
> +&usb_mp_qmpphy0 {
> +	vdda-phy-supply = <&vreg_l3e_1p2>;
> +	vdda-pll-supply = <&vreg_l3c_0p8>;
> +
> +	status = "okay";
> +};
> -- 
> 2.49.0
> 

-- 
With best wishes
Dmitry

