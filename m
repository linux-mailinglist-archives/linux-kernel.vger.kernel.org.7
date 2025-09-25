Return-Path: <linux-kernel+bounces-833341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C2FBA1B90
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49293BE0DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726FD30DD06;
	Thu, 25 Sep 2025 22:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G0o/9238"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450B92750FB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758837755; cv=none; b=mVJ+qIMR1RM9MBYrMGh1CIn6MPS5ipo1t93A+PQYpueyXKMWPpQMQDFS4zGEUJsf4KzxBP7jdhDB7Mol1fnQ5K48wOwv8Zr2ALoqiZNWrrsYmHLl/kx6RVmT1o0NMBT3MnzOqvf7n5fckw+jR8YKVEgJ/E9XQAMqK8R83xwBYC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758837755; c=relaxed/simple;
	bh=yaBhx0V6k/oUkzfHEOZBpTq8xGsBZ/GMh4qMuVwRIcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USlUEPhXtZQLaUU1Nn3Hkwx6MOEvfa2VTywBhVgrkWBEJWGc96bKpdtVRFc1k1HKztcpvC9wKjQiTQBS/yytL5cBpWAbYW4w+A2T+vxVFW0fWj5nWYOCS5+jfHqZNSO3gLA9a+Yhgonav69GXMu9Dfk0CyvLAEs3ri09Jv/ia4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G0o/9238; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPpCk014479
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WswtcLs0OrUJpjixJvlZQZiB
	DPTlc7OTq9eAlE8GdZk=; b=G0o/9238WnlcOs1XsiHSp3L8+474gfSmXsJ9fZs7
	G9U29w7y7nTLV8zf8OVYA4/bw1NMxkA8ytkYJxD5Zj/X6ZY18mUYq+Q4wZ7qq3EF
	efvN414/wAAHaoHYs9GIXfQReRQ030rnBDkr/SL9kBo2oWz/B3lOAU+DNE+6a86C
	Y/mFNgNd9u3OmjUz0l9ZFCN5IGiGv6MyucxaPsm/iwuXPrIIFT5/Mf/UBrFvkLkv
	lBqwXFROoJAtokjZbOqoVRQ/vMTgEvK06uu8X87wTAOXQnHWcHoabrVKdcfG76XS
	+KZ0oAzwDd2TLBFgYWZyU0cfn7s+LrQIDBglwtZ0iv8UxQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0rgha7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:02:33 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4d7f90350f3so32040581cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758837752; x=1759442552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WswtcLs0OrUJpjixJvlZQZiBDPTlc7OTq9eAlE8GdZk=;
        b=MePF89bt+EJsIkb/87OhhHMjXIE/aeRNs/43xhdCD153oWqD5pnpI4S2bPNuGsIB5L
         4H1Ye6A+40dYDW34pZXpmm9P/D/hd9UiOzhmfdvJeHLpjfNbJFZBe36PMPXDYBhC4qY2
         spdiFPE8lULrhbwItTsjRNOFlQbifNRU0pn47IswntSH81Zoa7s52SEXqBNhd1X+gBZW
         xASUG2WeJtLMiYf32oPLCy9jNybmt4n2frI+DZ3tF3vKbCqWV0R7wFcr/vjcFUBFBcYj
         FrQ/xVJtPGLOZ334OrTFydJi0skf2Mm8zngxGXFaEVtZ7RNVs+UpelAkgW22566mpVXv
         qvDw==
X-Forwarded-Encrypted: i=1; AJvYcCXhqcexFobblFBlWGNzpKZDzRsUHiWu8i4KCXVaDQK8w3DL1fLQZRwFRguevFNNk8152643IESBtOouDgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2b/xJvXwiMLHzXvushicNn/BJ1OaErd/CszZM+/C/TM05c32Z
	8m8xu3ts2jhIUxMOqkl67AqImbVoxFthhXd/XJVwK7GOq+pLLxsCQvURlFWIQ37J/dy9JCNZNfu
	NkKPNA853Wm5rBUrE/Zjnue3Skf14Aru/taxPNhxUSba31CExSE6tVJr6eO4l1uoovOM=
X-Gm-Gg: ASbGncsV6v8inZmB14V17bGUGHzsPow/GAn967Szemdop9zL3ywimaHX5mBHPuRxOKA
	6yEbAzg5T7DaciBvYmkN19DDVo0g2XTUzeBJvlUchjn7CKQlTh66vcTvteA6coPNsYewp9MSxne
	qKs9BXC+QvuaKKj1Hil6Odsk+NGFWlUDKHqIxof7k6EbWIs3HSJcOW2r/wi3YHrQNgYo2DDtx2i
	fb9+4vzER7/F4+mJNxt7ykvA5RQGWvFe0Mkj7QtTGrH2HV84VYgz8WEiFwN415dSxKstzID/LP/
	+knLx34S1UkwyzM1xXSTwiKDOUsuiu/DjqJST9/qRdksz18GWm8b15fhQODg88nBjINbwKbXCp3
	h0TkNIh60VSCr1xTGki5kg+37dmkG9ULms8pwCt7h1hDvzihrGhAq
X-Received: by 2002:ac8:5e06:0:b0:4c7:e39a:388a with SMTP id d75a77b69052e-4dac4133cadmr48182961cf.0.1758837751519;
        Thu, 25 Sep 2025 15:02:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjm/ckt7DusryvD+RR3JgMyVr7iU1qTCLo6gNy24ib40rQZETTCozRfZCmrtkgIOjnQ9Px9g==
X-Received: by 2002:ac8:5e06:0:b0:4c7:e39a:388a with SMTP id d75a77b69052e-4dac4133cadmr48182281cf.0.1758837750889;
        Thu, 25 Sep 2025 15:02:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313cde476sm1164996e87.48.2025.09.25.15.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 15:02:29 -0700 (PDT)
Date: Fri, 26 Sep 2025 01:02:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ayushi Makhija <quic_amakhija@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com, sean@poorly.run,
        marijn.suijten@somainline.org, andersson@kernel.org, robh@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, konradybcio@kernel.org,
        conor+dt@kernel.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, quic_rajeevny@quicinc.com,
        quic_vproddut@quicinc.com, quic_jesszhan@quicinc.com
Subject: Re: [PATCH 2/3] arm64: dts: qcom: qcs8300: add Display Serial
 Interface device nodes
Message-ID: <vsty7sy7gi2eeyifokwcqpoycmarxietkijmlkymwrmzmdsfws@x64f4ulbc6ja>
References: <20250925053602.4105329-1-quic_amakhija@quicinc.com>
 <20250925053602.4105329-3-quic_amakhija@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925053602.4105329-3-quic_amakhija@quicinc.com>
X-Authority-Analysis: v=2.4 cv=dP+rWeZb c=1 sm=1 tr=0 ts=68d5bbf9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=HRGN58LKe5rzAvgwDGIA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: nMOKmGStPlPUpmHipXhpuqTp_D0jnanL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX9hZRzS9iu9ID
 LC3BaSPUl7cKRe2umtJ0V+YMinKosK3S3oW3M3cC60lMRYvuFMiov4TGdhoxHyc/6+eFzXhen4D
 Xrmi9REUftwqCqYXzOLLLfn58jow9KdCR6ijKbrIb6ZTTN/DEPQsTcX8tqZlOfUMpZddDyE6WyF
 mVQBArHnO46hHtQczkyIv5r0/gAU0qJWdMD79uO9K+lou9fXJX+eBeitZUErOd4bxOh7BddYuC8
 IP0lZZf81QtdXunwiOM4B6I1DorSEEElbNCBTFeD1mdvunQM1SLGNKqJ4ZtDYJOgWkfnaOEvRRq
 fhUnGsfp5aZiZEr7ZWYiBQDiVV39zJaQmRuc6sEzexKCiNQAObsvYVlLnaN1hgLJVsu9aDK5FkC
 8LDpDyNPiBySOO/tL8leAJpRJmZE6A==
X-Proofpoint-GUID: nMOKmGStPlPUpmHipXhpuqTp_D0jnanL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Thu, Sep 25, 2025 at 11:06:01AM +0530, Ayushi Makhija wrote:
> Add device tree nodes for the DSI0 controller with their corresponding
> PHY found on Qualcomm QCS8300 SoC.
> 
> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 95 ++++++++++++++++++++++++++-
>  1 file changed, 94 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> index e0e1f63fc45b..834ae0522f2f 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
> +#include <dt-bindings/clock/qcom,dsi-phy-28nm.h>
>  #include <dt-bindings/clock/qcom,qcs8300-gcc.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/clock/qcom,sa8775p-camcc.h>
> @@ -4854,6 +4855,13 @@ dpu_intf0_out: endpoint {
>  							remote-endpoint = <&mdss_dp0_in>;
>  						};
>  					};
> +
> +					port@1 {
> +						reg = <1>;
> +						dpu_intf1_out: endpoint {
> +							remote-endpoint = <&mdss_dsi0_in>;
> +						};
> +					};
>  				};
>  
>  				mdp_opp_table: opp-table {
> @@ -4881,6 +4889,89 @@ opp-650000000 {
>  				};
>  			};
>  
> +			mdss_dsi0: dsi@ae94000 {
> +				compatible =  "qcom,sa8775p-dsi-ctrl","qcom,mdss-dsi-ctrl";

qcom,qcs8300-dsi-ctrl. You might use three compatibles (qcs8300, sa8775p
and the generic one), but there should be qcs8300 one.

Also please add a whitespace after comma or (even better), keep one
compat per line (align on opening quote).

> +				reg = <0x0 0x0ae94000 0x0 0x400>;
> +				reg-names = "dsi_ctrl";
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <4>;
> +
> +				clocks = <&dispcc MDSS_DISP_CC_MDSS_BYTE0_CLK>,
> +					 <&dispcc MDSS_DISP_CC_MDSS_BYTE0_INTF_CLK>,
> +					 <&dispcc MDSS_DISP_CC_MDSS_PCLK0_CLK>,
> +					 <&dispcc MDSS_DISP_CC_MDSS_ESC0_CLK>,
> +					 <&dispcc MDSS_DISP_CC_MDSS_AHB_CLK>,
> +					 <&gcc GCC_DISP_HF_AXI_CLK>;
> +				clock-names = "byte",
> +					      "byte_intf",
> +					      "pixel",
> +					      "core",
> +					      "iface",
> +					      "bus";
> +
> +				assigned-clocks = <&dispcc MDSS_DISP_CC_MDSS_BYTE0_CLK_SRC>,
> +						  <&dispcc MDSS_DISP_CC_MDSS_PCLK0_CLK_SRC>;
> +				assigned-clock-parents = <&mdss_dsi0_phy DSI_BYTE_PLL_CLK>,
> +							 <&mdss_dsi0_phy DSI_PIXEL_PLL_CLK>;
> +
> +				phys = <&mdss_dsi0_phy>;
> +
> +				operating-points-v2 = <&mdss_dsi_opp_table>;
> +				power-domains = <&rpmhpd RPMHPD_MMCX>;
> +
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						mdss_dsi0_in: endpoint {
> +							remote-endpoint = <&dpu_intf1_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +						mdss_dsi0_out: endpoint {
> +						};
> +					};
> +				};
> +
> +				mdss_dsi_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-358000000 {
> +						opp-hz = /bits/ 64 <358000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +				};
> +			};
> +
> +			mdss_dsi0_phy: phy@ae94400 {
> +				compatible = "qcom,sa8775p-dsi-phy-5nm";

Add qcs8300-specific compatible and use sa8775p as a fallback

> +				reg = <0x0 0x0ae94400 0x0 0x200>,
> +				      <0x0 0x0ae94600 0x0 0x280>,
> +				      <0x0 0x0ae94900 0x0 0x27c>;
> +				reg-names = "dsi_phy",
> +					    "dsi_phy_lane",
> +					    "dsi_pll";
> +
> +				#clock-cells = <1>;
> +				#phy-cells = <0>;
> +
> +				clocks = <&dispcc MDSS_DISP_CC_MDSS_AHB_CLK>,
> +					 <&rpmhcc RPMH_CXO_CLK>;
> +				clock-names = "iface", "ref";
> +
> +				status = "disabled";
> +			};
> +
>  			mdss_dp0_phy: phy@aec2a00 {
>  				compatible = "qcom,qcs8300-edp-phy", "qcom,sa8775p-edp-phy";
>  
> @@ -5008,7 +5099,9 @@ dispcc: clock-controller@af00000 {
>  				 <&mdss_dp0_phy 0>,
>  				 <&mdss_dp0_phy 1>,
>  				 <0>, <0>,
> -				 <0>, <0>, <0>, <0>;
> +				 <&mdss_dsi0_phy DSI_BYTE_PLL_CLK>,
> +				 <&mdss_dsi0_phy DSI_PIXEL_PLL_CLK>,
> +				 <0>, <0>;
>  			power-domains = <&rpmhpd RPMHPD_MMCX>;
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

