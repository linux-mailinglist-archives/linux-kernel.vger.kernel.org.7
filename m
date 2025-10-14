Return-Path: <linux-kernel+bounces-852337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9596ABD8B64
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AA794EF7DC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4182F28F0;
	Tue, 14 Oct 2025 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GgYufA6Z"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A8E2ECD03
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437092; cv=none; b=V4R867Ma3L+KS+vVSXIpoVFsbdn5KeJ1/mSK0CfV3sGmTVvkfsFiIAJQZYrB1PlNFIm+9I/jesucHW9QL9NCg7AWE0NyS7eF2POMGbnfiwv7vzR5bHmJEJeU5OogYTHYrmWIxSY0n3dJxYPnntC72j1rNtRqT4goJiuzKTpxU6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437092; c=relaxed/simple;
	bh=w7gnzCZQ6nRhynPolPCfbnwk0UwzKPoJZt3kck8zss4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtkWWgZnpcvbNV+sNlDSpwMOiRNfW2hcm2FYJ8XataiHNUmEAwE7vxQhCLsd5VNJ1+zkdW7ZjV2PSJ+y9ch/IfO6jdPLNTZmYxoiZQ6N3wHw8Go2c3UEk5YDgNnpXOYL8i62TwZ6MTDJcGguh4JgI8JQNXjcC7iWACkid0s9gO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GgYufA6Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87Os9021230
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pwptx/VesgCBtJDbpJ0h31jG
	Os/N1oEOleOLOClW4QM=; b=GgYufA6ZQVAqzPGbedZW2BexYSPUaA55oJrvgezu
	A9V1NsT3tYXIon1derOce/NFCbGJTyXqdI57sTwCmYv2OtA8JS4JxzCKlkcm+8NJ
	IKDWONthUSPJIw0LBqR3s44PkHHF4loLfAOfFwJY9X9usWUii65PGa6AYrpPNtFi
	D2tdFwb1QHLECrwPzWxc0fiYLgorn/YOo8GJxPNPCrIVoysmRpFQ4lnyzu35aLtT
	RoiktZN2jiZorPe7y1eF2fvVcDvVkaPd2WBu6n16G2+0mu0HVygWJprXRsAVh07V
	Elu7sTtrHvrrxug7sGu0WEYeJ7Vz1By+4Mt0VxLnII811g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwjc0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:18:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-88d842aa73aso26194685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437087; x=1761041887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwptx/VesgCBtJDbpJ0h31jGOs/N1oEOleOLOClW4QM=;
        b=mpHoH0PhgAq4yVYPOTPGTarwMrwY1DVPi8Xv6Jc8GoZtgxvh8sd1YV3WFe3cB1afc2
         se69cwBV+6civZNVDhCKRMGoRDBn4dks3S2Qd5VVvpz51PrPuR3zRceYQdFEWnk6CR13
         oha13NAaDNvJRcNprLKvI0zCudItGeIBtAV2m48louVm60t3XknJrKOVND76nHSwnxRE
         XS/Su/ka4Icf53emg462X4OlYeG1kuuyPncZFOZqmp1/P3/8DffVcPGg1Z8yTGH95g/+
         w2jvFYir8PEfAdxJtKXwKE0iuViqmYX9H7DN6Lytd2LkgOYGjBI52V4AeIUg0CGHV5Wy
         T4lw==
X-Forwarded-Encrypted: i=1; AJvYcCWrbJlpZuJeidWmREgwoNQpeO9BtirBhvtp9xMHKzxcL0xT6ZEb9HULb7VrWd0m5Y8HFNr8yDSAkr60rzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzejzEGa+RKCDC2P12UlrEt/ttrOi/MaBVHQKXMNzUHZBuROfKR
	Qd/vjNe9ZUMEVyrgiwPDvgFHbNjypontC21AVxO8X/K/hGT2NGKGQlOKmriwUxrWNQndZzmVFMN
	/IafZKcn+7nkQoGO3ZxZx0fzpiVjvuO9NbjRvV3XLpEhaWTuUW+wFAlGC4oe8jvbQzo8=
X-Gm-Gg: ASbGncuRUSEvdV7lICK1pSjT2inM6Q/Z1zEOO8Hmfm2vJiLpFulzrsTce2AGsqY0oJx
	06IDa7IQvA0RkFcG6f22CBT32gmMf9JMZ2f2f9T5QJuAZGdk2d15jIti2iUZvIjH0sRVJTAvvFP
	7Xsfe/rXtGaBRd1susy/+CSuENApNadvB9OenR3iPgTc9hS+ASEx6DukkFGIpeXXBoKbPvzlP/K
	2FIsgxatR/DbYBULMI0bHSuSn1J0nxrh/IWLvLX1NXXIj6r09+PeuSYUxPwpogLtVAcJLFC0ift
	zhdhMttDBo9FIK/b8h6YJIVrxiH18tVjD/2KFkf2FiX89QdNPcf0XWEMxyQ56oWq7p2g7n+cQV5
	PijaOMm/HfhIoGeuneBplOfd0gOV72aLQ3iLzQdm9qVGl1YQ+JUGz
X-Received: by 2002:a05:620a:25cf:b0:82e:ef43:38f0 with SMTP id af79cd13be357-8834d1ab25cmr3439239885a.0.1760437087177;
        Tue, 14 Oct 2025 03:18:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJhGGgyvvXZT48tFGwd0V8RDCf9K7hHaMnSajQnKeeUDp+q+bm7eaDMfpNfVN/V/oft3MlEw==
X-Received: by 2002:a05:620a:25cf:b0:82e:ef43:38f0 with SMTP id af79cd13be357-8834d1ab25cmr3439234785a.0.1760437086684;
        Tue, 14 Oct 2025 03:18:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762ea109afsm40265551fa.33.2025.10.14.03.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:18:05 -0700 (PDT)
Date: Tue, 14 Oct 2025 13:18:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: xiangxu.yin@oss.qualcomm.com
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: Add DisplayPort and QMP USB3DP
 PHY for SM6150
Message-ID: <mij6av23fni6i4yb72xbjv3s2mil4eankjwt5n7jbafslvilem@qsk3644ilgcp>
References: <20251014-add-displayport-support-to-qcs615-devicetree-v2-0-1209df74d410@oss.qualcomm.com>
 <20251014-add-displayport-support-to-qcs615-devicetree-v2-2-1209df74d410@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-add-displayport-support-to-qcs615-devicetree-v2-2-1209df74d410@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfX1xFFWjOjAn+k
 uwV+swOm1lDr/A7pTeo2hdKKz4KhHfeSGzQGcw0b7Q+dnuPyQ5wEc8lIV/6plD6CyA8WcFXz+oe
 Xvuwxiac/j5t5x+eAhkcezu8U1ymyiLw5CQmzCjX7awCkGdtINDRLOeyBw77Nd4KhmqnifaHY3a
 LoRL4ZZ/pfiQcC6Pf71GbScMgSjKvQjtOdV/VnH0XPIluAp20TmHfjdSTGkL7xjVp/ONi1aiWK+
 4awXovn7FQ3Cz2Cq96k3A8xlsOQ40hIy4OqKxGPhdZujuHzKbmu5HivUAZ6rKY2eZsncI9ZM0mC
 Rayi4RQkQCDnpvv4lpectyjyA1fq0U2cfO9tNVzsJGG6O43PB6Oqy9QUVqlHQ8E+gP6fCYkDTD8
 RAPRdekNRuAEugAXpo7XwRtZhI5Y8g==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68ee2360 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=j4UgqydKDgg0KIll92UA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: UIshg513w-veQlc5dgiulRc-zcCoP10C
X-Proofpoint-ORIG-GUID: UIshg513w-veQlc5dgiulRc-zcCoP10C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083

On Tue, Oct 14, 2025 at 05:42:11PM +0800, Xiangxu Yin via B4 Relay wrote:
> From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> 
> Introduce DisplayPort controller node and associated QMP USB3-DP PHY
> for SM6150 SoC. Update clock and endpoint connections to enable DP
> integration.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm6150.dtsi | 110 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 108 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/sm6150.dtsi
> index 6128d8c48f9c0807ac488ddac3b2377678e8f8c3..cdf53d74c778c652080b0288278353e20c317379 100644
> --- a/arch/arm64/boot/dts/qcom/sm6150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6150.dtsi
> @@ -17,6 +17,7 @@
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/power/qcom,rpmhpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/phy/phy-qcom-qmp.h>
>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -3717,6 +3718,7 @@ port@0 {
>  						reg = <0>;
>  
>  						dpu_intf0_out: endpoint {
> +							remote-endpoint = <&mdss_dp0_in>;
>  						};
>  					};
>  
> @@ -3749,6 +3751,84 @@ opp-307200000 {
>  				};
>  			};
>  
> +			mdss_dp0: displayport-controller@ae90000 {
> +				compatible = "qcom,sm6150-dp", "qcom,sm8150-dp", "qcom,sm8350-dp";
> +
> +				reg = <0x0 0x0ae90000 0x0 0x200>,
> +				      <0x0 0x0ae90200 0x0 0x200>,
> +				      <0x0 0x0ae90400 0x0 0x600>,
> +				      <0x0 0x0ae90a00 0x0 0x600>,
> +				      <0x0 0x0ae91000 0x0 0x600>;
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <12>;
> +
> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK>;
> +				clock-names = "core_iface",
> +					      "core_aux",
> +					      "ctrl_link",
> +					      "ctrl_link_iface",
> +					      "stream_pixel",
> +					      "stream_1_pixel";
> +
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
> +						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
> +				assigned-clock-parents = <&usb_qmpphy_2 QMP_USB43DP_DP_LINK_CLK>,
> +							 <&usb_qmpphy_2 QMP_USB43DP_DP_VCO_DIV_CLK>;

Missing PIXEL1_CLK_SRC assignment

> +
> +				phys = <&usb_qmpphy_2 QMP_USB43DP_DP_PHY>;
> +				phy-names = "dp";
> +
> +				operating-points-v2 = <&dp_opp_table>;
> +				power-domains = <&rpmhpd RPMHPD_CX>;
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
> +						mdss_dp0_in: endpoint {
> +							remote-endpoint = <&dpu_intf0_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +						mdss_dp0_out: endpoint {

I thought that we need a data-lanes property somewhere here.

> +						};
> +					};
> +				};
> +
-- 
With best wishes
Dmitry

