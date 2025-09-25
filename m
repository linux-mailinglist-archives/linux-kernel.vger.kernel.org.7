Return-Path: <linux-kernel+bounces-832925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CABBA0C34
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F79817250A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDE1A944;
	Thu, 25 Sep 2025 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OfeR5DJt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AFD3081BB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820280; cv=none; b=uVQImwnf9bw6+r6hZ7KJyL9pIRgHsUnFzyGAWj5JMSWtZzZIG3hO/tY0KJXV9hlsU89Mw/8ZMTO6hS5he1StZ2jQr1dr6HGayT4PgVZhmeaYnYjlozTCTABTYblPP8nCJHjxKFD9kNIx+VGcW5H/jRAMDaXk9T5XqQ4cphYuxow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820280; c=relaxed/simple;
	bh=2A2VlsDYMkB/821WPHSmvGeZ4Cdpi/oZMk8ty52o9yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qijbTAlDxyybrBR5tXMzq/oHFe9HKC9R+PwizkJOII+HwxJO+qLWICKKJqABicPEi8FUjjxg/cPEOfNqUfBHQ+fioBQtsWWeaI52vpmgTcejUvLfzusmBPfQxSO9DZaQa/a9doPfF0QIA2Rd8wCp0LetiT38CEuTETjk//WjA90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OfeR5DJt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9QLZ7025572
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kXw3CoTNhUiXzTf4M7hCnKv4
	j02uevXwUtdwRCg5VCs=; b=OfeR5DJtoMu1lUxfqiKvEBtUCBTNDrepul4fswiV
	PINrqbXPgAweF6wn3V7+PLPd8/0CYeH/lP5CIz6VeLBXLt0yZeCqGi44+tKplWL4
	qHPhLxGPruC7mB6bNw2cMKG3RKbf5hRZANCML+3ByTr4SXS3pgnmggQCfWHaoS8E
	jLi9s9Mm//2Ssj3GpW91faSS+RZwSG4R0txYD9GQWWx6RloJdGSGRYMSYDQSVD4g
	UYvKm0bSzm896jXI81Y0vJTb0sUfAK9taMUY+ytmjh5CytFsl+i0Xl8ItWR7B9j1
	9GkQWvMSoLu9ju+DXrMmeq2TcZ4qDodZ2UFo4/OQ4EEM3A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyf1a2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:11:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b793b04fe0so27939061cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758820276; x=1759425076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXw3CoTNhUiXzTf4M7hCnKv4j02uevXwUtdwRCg5VCs=;
        b=tfBQL9a73wIC8LT/EoGPSie+gr7LmhDBk0Rk5D0+tAPqgV9EuyJwWiTSKvkd5lBMPi
         SgUHifovWHAcU+g1K3rbuD959bxnxCPM2TRIscnd+2VtMQeTzZAw8RSCdmHWExuxzceh
         28kHYGVx8jIX1X5oCFKyol6levhWYg4SHgNg0NkfpsPDGfUbCqEDD8o2U+UnhffdKZg0
         ZctQwIpLDThDTB2y+a4URfFJBzM6rm6lxsQxJj+i+pImRTtqp74MPqEBWAdk6/1FOg5f
         P3pf/dpFNiYiYHtD2h9gaeUNoj9LnNjW0PzRSvmEGqqwc1ak8JfwdHYYB9yHE9b9/hH7
         iazQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8kyE+n3WJqfs9NFi3r/yTDSOLRiZArfPzC2HOB+5mByWioCcP0tBb+KocMaiNqZvWHuxMUaHsk7LGTBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyl5g9s9UZOttUPNSuh07do9Ajl+cKs3Yw2lQpEkxGe5cyRsj4
	VMlroUcp3iZJCMlAx+vnWLSxABjBRwsGSWN0c8kc2iC26J/h9Vgo//6VEuQpjy0kKwtFp4X2xrP
	FccVkZ8rPk/goYVtW/bbUeBSWIg6H+8MkuGUfM0bA1eYDtx8hPOq0vII/ljnwiPPOraDxPwICz8
	E=
X-Gm-Gg: ASbGnct+dH/Rn+/eVR1zyWQ6vS135igpnU47aL+fsW5mTveYqfJUDneHZ/i99/JR4X0
	vBRM4DObpz+5xtxY+XtD6Si3f9tnfR7v7ouSv0FV9fQF7TpZGdLD+FZQiFccsrEME2NI8BPDGa9
	qmXqckLjdQJX+iiXFOQl9/u03PhPj+7clZL5iOLuCJUCuHYssm3eVv6lt+MrSEKmV/3jJS3hONZ
	j6KhFrHBPYPZ2Xw0Ae7pIaIplDFFRDy3Aaf8HWdachxkX3uDaveHgpB94IuWh9ES8+rggMN+3t4
	600CH2moQCLc4T3uc9jQKTqke7w3LnP9872bc7QjiVI5S7J/n5sqyctUdYX7KBS6JocUoqkAfan
	4o62yIr2N/l+nLqhu32GtjxkGRCiz2bbogNsztnSey5MnDIMvc9dq
X-Received: by 2002:ac8:5852:0:b0:4d9:5ce:3749 with SMTP id d75a77b69052e-4da4cd4791cmr52410591cf.72.1758820275564;
        Thu, 25 Sep 2025 10:11:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGoHvBOPLPvyJUniaKzaRAGpPOF+o4ZXMRhf7+ISSnlvoSo5lj+B74ghkMrUs0F7vcZagSMQ==
X-Received: by 2002:ac8:5852:0:b0:4d9:5ce:3749 with SMTP id d75a77b69052e-4da4cd4791cmr52409821cf.72.1758820274662;
        Thu, 25 Sep 2025 10:11:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313cde476sm951564e87.48.2025.09.25.10.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 10:11:13 -0700 (PDT)
Date: Thu, 25 Sep 2025 20:11:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: glymur: Describe display related
 nodes
Message-ID: <43jgqfcw2nnasdnskfdri5swddr6kunvvp6oxzqibnlvyc4jd2@4y6x7fy5shq2>
References: <20250925-dts-qcom-glymur-crd-add-edp-v1-0-20233de3c1e2@linaro.org>
 <20250925-dts-qcom-glymur-crd-add-edp-v1-1-20233de3c1e2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-dts-qcom-glymur-crd-add-edp-v1-1-20233de3c1e2@linaro.org>
X-Proofpoint-GUID: VdjlvIuJC4Zw_CH4s4rDw14wCi3saOx6
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d577b5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=em26Cy0fR9YT-IQVlA0A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX50o/sMu/PPem
 hS0VD+kZ1abA+4C+GLBitIgVSR/3zHkdeCN1rMCYiGKwhCp9XOuYt35PyMf+0c5x6re7cxjghJr
 kJdDcyFlTCP63Q0cKNK3jHt2/tg8QqVLBMnSFUkVr8avPrUsaZ7QBbJ7xK1XsFeH2cYY3xKz1zc
 RLSNYmh+f0FFrzCEDg0evKHiKYWxSLGvcDiTDFvvwkNe85Uz/k43koKcq5RONA5w6rghCM2iEFc
 7URioKY92fRWAUxEqN0xCJBATJEfOEj8HTMbhg7qKA1/S/i+uzstYDf8m/B+fsuVWgEubmpLxZa
 BQPYGZozeAXqNWb4vujemlNJkfGAdxsXJG8ANIPtOR4ygetTI5XPU/78/GMNNH2fIV7/v+plYmV
 1Pf4vR2b
X-Proofpoint-ORIG-GUID: VdjlvIuJC4Zw_CH4s4rDw14wCi3saOx6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

On Thu, Sep 25, 2025 at 06:02:48PM +0300, Abel Vesa wrote:
> The MDSS (Mobile Display SubSystem) on Glymur comes with 4 DisplayPort
> controllers. Describe them along with display controller and the eDP
> PHY. Then, attach the combo PHYs link and vco_div clocks to the Display
> clock controller and link up the PHYs and DP endpoints in the graph.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/glymur.dtsi | 492 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 484 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> index a131cd6c3d9e7f14ed1c4aef4b68e1860cc3bca5..41d89998b1fe14a24cd528e73afc37cf2a840bab 100644
> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> @@ -2698,6 +2698,7 @@ port@2 {
>  					reg = <2>;
>  
>  					usb_dp_qmpphy_dp_in: endpoint {
> +						remote-endpoint = <&mdss_dp0_out>;
>  					};
>  				};
>  			};
> @@ -2766,11 +2767,34 @@ port@2 {
>  					reg = <2>;
>  
>  					usb_1_ss1_qmpphy_dp_in: endpoint {
> +						remote-endpoint = <&mdss_dp1_out>;
>  					};
>  				};
>  			};
>  		};
>  
> +		mdss_dp3_phy: phy@faac00 {
> +			compatible = "qcom,glymur-dp-phy";
> +			reg = <0 0x00faac00 0 0x1d0>,
> +			      <0 0x00faa400 0 0x128>,
> +			      <0 0x00faa800 0 0x128>,
> +			      <0 0x00faa000 0 0x358>;
> +
> +			clocks = <&dispcc DISP_CC_MDSS_DPTX3_AUX_CLK>,
> +				 <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +				 <&tcsrcc TCSR_EDP_CLKREF_EN>;
> +			clock-names = "aux",
> +				      "cfg_ahb",
> +				      "ref";
> +
> +			power-domains = <&rpmhpd RPMHPD_MX>;
> +
> +			#clock-cells = <1>;
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
>  		cnoc_main: interconnect@1500000 {
>  			compatible = "qcom,glymur-cnoc-main";
>  			reg = <0x0 0x01500000 0x0 0x17080>;
> @@ -3248,6 +3272,7 @@ port@2 {
>  					reg = <2>;
>  
>  					usb_1_ss2_qmpphy_dp_in: endpoint {
> +						remote-endpoint = <&mdss_dp2_out>;
>  					};
>  				};
>  			};
> @@ -3523,7 +3548,458 @@ usb_mp: usb@a400000 {
>  			dr_mode = "host";
>  
>  			status = "disabled";
> +		};
> +
> +		mdss: display-subsystem@ae00000 {
> +			compatible = "qcom,glymur-mdss";
> +			reg = <0x0 0x0ae00000 0x0 0x1000>;
> +			reg-names = "mdss";
> +
> +			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +				 <&gcc GCC_DISP_HF_AXI_CLK>,
> +				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
> +
> +			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
> +
> +			interconnects = <&mmss_noc MASTER_MDP QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> +					<&hsc_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
> +			interconnect-names = "mdp0-mem",
> +					     "cpu-cfg";
> +
> +			power-domains = <&dispcc DISP_CC_MDSS_CORE_GDSC>;
> +
> +			iommus = <&apps_smmu 0x1de0 0x2>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			status = "disabled";
> +
> +			mdss_mdp: display-controller@ae01000 {
> +				compatible = "qcom,glymur-dpu";
> +				reg = <0 0x0ae01000 0 0x93000>,
> +				      <0 0x0aeb0000 0 0x2008>;
> +				reg-names = "mdp",
> +					    "vbif";
> +
> +				interrupts-extended = <&mdss 0>;
> +
> +				clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> +					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
> +					 <&dispcc DISP_CC_MDSS_MDP_CLK>,
> +					 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
> +				clock-names = "nrt_bus",
> +					      "iface",
> +					      "lut",
> +					      "core",
> +					      "vsync";
> +
> +				operating-points-v2 = <&mdp_opp_table>;
> +
> +				power-domains = <&rpmhpd RPMHPD_MMCX>;
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +
> +						dpu_intf0_out: endpoint {
> +							remote-endpoint = <&mdss_dp0_in>;
> +						};
> +					};
> +
> +					port@4 {
> +						reg = <4>;
> +
> +						mdss_intf4_out: endpoint {
> +							remote-endpoint = <&mdss_dp1_in>;
> +						};
> +					};
> +
> +					port@5 {
> +						reg = <5>;
> +
> +						mdss_intf5_out: endpoint {
> +							remote-endpoint = <&mdss_dp3_in>;
> +						};
> +					};
> +
> +					port@6 {
> +						reg = <6>;
> +
> +						mdss_intf6_out: endpoint {
> +							remote-endpoint = <&mdss_dp2_in>;
> +						};
> +					};
> +				};
> +
> +				mdp_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-205000000 {
> +						opp-hz = /bits/ 64 <205000000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
> +
> +					opp-337000000 {
> +						opp-hz = /bits/ 64 <337000000>;
> +						required-opps = <&rpmhpd_opp_svs>;
> +					};
> +
> +					opp-417000000 {
> +						opp-hz = /bits/ 64 <417000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-532000000 {
> +						opp-hz = /bits/ 64 <532000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +
> +					opp-600000000 {
> +						opp-hz = /bits/ 64 <600000000>;
> +						required-opps = <&rpmhpd_opp_nom_l1>;
> +					};
> +				};
> +			};
> +
> +			mdss_dp0: displayport-controller@af54000 {
> +				compatible = "qcom,glymur-dp";
> +				reg = <0x0 0xaf54000 0x0 0x104>,
> +				      <0x0 0xaf54200 0x0 0xc0>,
> +				      <0x0 0xaf55000 0x0 0x770>,
> +				      <0x0 0xaf56000 0x0 0x9c>,
> +				      <0x0 0xaf57000 0x0 0x9c>;
> +
> +				interrupts-extended = <&mdss 12>;
> +
> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;

No pixel1 clock?

> +				clock-names = "core_iface",
> +					      "core_aux",
> +					      "ctrl_link",
> +					      "ctrl_link_iface",
> +					      "stream_pixel";
> +
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
> +						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
> +				assigned-clock-parents = <&usb_1_ss0_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> +							 <&usb_1_ss0_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;

No pixel1 clock?

> +
> +				operating-points-v2 = <&mdss_dp0_opp_table>;
> +
> +				power-domains = <&rpmhpd RPMHPD_MMCX>;
> +
> +				phys = <&usb_1_ss0_qmpphy QMP_USB43DP_DP_PHY>;
> +				phy-names = "dp";
> +
> +				#sound-dai-cells = <0>;
> +
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +
> +						mdss_dp0_in: endpoint {
> +							remote-endpoint = <&dpu_intf0_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +
> +						mdss_dp0_out: endpoint {
> +							remote-endpoint = <&usb_dp_qmpphy_dp_in>;
> +						};
> +					};
> +				};
> +
> +				mdss_dp0_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-192000000 {
> +						opp-hz = /bits/ 64 <192000000>;
> +						required-opps = <&rpmhpd_opp_low_svs_d1>;
> +					};
> +
> +					opp-270000000 {
> +						opp-hz = /bits/ 64 <270000000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
> +
> +					opp-540000000 {
> +						opp-hz = /bits/ 64 <540000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-810000000 {
> +						opp-hz = /bits/ 64 <810000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +				};
> +			};
> +
> +			mdss_dp1: displayport-controller@af5c000 {
> +				compatible = "qcom,glymur-dp", "qcom,sm8650-dp";

This doesn't match your own bindings. WT?

> +				reg = <0x0 0xaf5c000 0x0 0x104>,
> +				      <0x0 0xaf5c200 0x0 0xc0>,
> +				      <0x0 0xaf5d000 0x0 0x770>,
> +				      <0x0 0xaf5e000 0x0 0x9c>,
> +				      <0x0 0xaf5f000 0x0 0x9c>;
> +
> +				interrupts-extended = <&mdss 13>;
>  
> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX1_AUX_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX1_LINK_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX1_LINK_INTF_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX1_PIXEL0_CLK>;

pixel1

> +				clock-names = "core_iface",
> +					      "core_aux",
> +					      "ctrl_link",
> +					      "ctrl_link_iface",
> +					      "stream_pixel";
> +
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX1_LINK_CLK_SRC>,
> +						  <&dispcc DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC>;
> +				assigned-clock-parents = <&usb_1_ss1_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> +							 <&usb_1_ss1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;

pixel1

> +
> +				operating-points-v2 = <&mdss_dp1_opp_table>;
> +
> +				power-domains = <&rpmhpd RPMHPD_MMCX>;
> +
> +				phys = <&usb_1_ss1_qmpphy QMP_USB43DP_DP_PHY>;
> +				phy-names = "dp";
> +
> +				#sound-dai-cells = <0>;
> +
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +
> +						mdss_dp1_in: endpoint {
> +							remote-endpoint = <&mdss_intf4_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +
> +						mdss_dp1_out: endpoint {
> +							remote-endpoint = <&usb_1_ss1_qmpphy_dp_in>;
> +						};
> +					};
> +				};
> +
> +				mdss_dp1_opp_table: opp-table {
> +					compatible = "operating-points-v2";

Is it differnt from dp0 table?

> +
> +					opp-192000000 {
> +						opp-hz = /bits/ 64 <192000000>;
> +						required-opps = <&rpmhpd_opp_low_svs_d1>;
> +					};
> +
> +					opp-270000000 {
> +						opp-hz = /bits/ 64 <270000000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
> +
> +					opp-540000000 {
> +						opp-hz = /bits/ 64 <540000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-810000000 {
> +						opp-hz = /bits/ 64 <810000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +				};
> +			};
> +
> +			mdss_dp2: displayport-controller@af64000 {
> +				compatible = "qcom,glymur-dp";
> +				reg = <0x0 0x0af64000 0x0 0x104>,
> +				      <0x0 0x0af64200 0x0 0xc0>,
> +				      <0x0 0x0af65000 0x0 0x770>,
> +				      <0x0 0x0af66000 0x0 0x9c>,
> +				      <0x0 0x0af67000 0x0 0x9c>;
> +
> +				interrupts-extended = <&mdss 14>;
> +
> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX2_AUX_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX2_LINK_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX2_LINK_INTF_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX2_PIXEL0_CLK>;

pixel1 clock

> +				clock-names = "core_iface",
> +					      "core_aux",
> +					      "ctrl_link",
> +					      "ctrl_link_iface",
> +					      "stream_pixel";
> +
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX2_LINK_CLK_SRC>,
> +						  <&dispcc DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC>;
> +				assigned-clock-parents = <&usb_1_ss2_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> +							 <&usb_1_ss2_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;

pixel1

> +
> +				operating-points-v2 = <&mdss_dp2_opp_table>;
> +
> +				power-domains = <&rpmhpd RPMHPD_MMCX>;
> +
> +				phys = <&usb_1_ss2_qmpphy QMP_USB43DP_DP_PHY>;
> +				phy-names = "dp";
> +
> +				#sound-dai-cells = <0>;
> +
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						mdss_dp2_in: endpoint {
> +							remote-endpoint = <&mdss_intf6_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +
> +						mdss_dp2_out: endpoint {
> +							remote-endpoint = <&usb_1_ss2_qmpphy_dp_in>;
> +						};
> +					};
> +				};
> +
> +				mdss_dp2_opp_table: opp-table {


Different from dp0?

> +					compatible = "operating-points-v2";
> +
> +					opp-160000000 {
> +						opp-hz = /bits/ 64 <160000000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
> +
> +					opp-270000000 {
> +						opp-hz = /bits/ 64 <270000000>;
> +						required-opps = <&rpmhpd_opp_svs>;
> +					};
> +
> +					opp-540000000 {
> +						opp-hz = /bits/ 64 <540000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-810000000 {
> +						opp-hz = /bits/ 64 <810000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +				};
> +			};
> +

-- 
With best wishes
Dmitry

