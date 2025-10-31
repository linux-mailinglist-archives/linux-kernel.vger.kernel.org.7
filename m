Return-Path: <linux-kernel+bounces-880394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E898C25AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D31D18814A3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E78134C9A8;
	Fri, 31 Oct 2025 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g5tKUpIm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UExE6mbd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121EB34C9BA
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921853; cv=none; b=F5RJ5ELKVl6XGP7+TYTaDnAXL2QsnNvqFR8clNoR4S+XorIwDgnWhdr8tjqdWdilAviBeK7UX8z1D14p1vVONor6CFcfnyKIc1NbgH7OIev8TCj2nEhBSl+NUf9Mhjb7c3jYeBblM2JQmEmczpHPIMVsXWPkLIk3LlSBLaluwt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921853; c=relaxed/simple;
	bh=GIK3trXcw/sk7VLilHo+YWW2cCNfD/NbCqHnIdsd8Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cA9XFFDkNslzFVPaENQFdkPZwwFUcuiPUI6dx7rNO7JkuOjRiFknLl0ssIvvNDnzYICWPW926JBl0w3n4BipiNl79bxBxsXZqxoKv528QnDwR7YLfBcOJcGHI+JSt5L7LlyQCwi3P+X45rp1lMdVEGtEp1rOWkjPcKq7ln8323E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g5tKUpIm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UExE6mbd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V9lQjL1417238
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1ceM6+N8m+GK9mPld4VxQRv4
	x2AG5nmc3/hEKrhquEU=; b=g5tKUpIm5zoleF5P6fEqktCNw3TwIOoZndUwoWrL
	SsmovNxTob4A5DgYGJvlufcapxY7fr6hYxm7E6EcbBXIlINsoXMmNrBtbPpjxCpJ
	9nwgR0uG3bgrnz/xPryBLY3+/xLr6N0QPu3lVMfvYLux0RTWyyfYBsrmseax5Upo
	lmJ/GHbghJDVNHYucucWWFIV1qwehYBMZV5piSg9wXvyM/YxELAeSobpiEscvdFs
	PhYfvSIm8XWKqPI23jmQ/5WWwxi83x4xZBSwy3EasbxQ0C6JBaOBmepEKNCDo7M0
	2oDwUhgWYkh8ntJ8KPQtYZkxecP2+BQBL/XMR+UHxR7vaw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4k69j2d6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:44:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ecf1b7686cso91247531cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761921850; x=1762526650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ceM6+N8m+GK9mPld4VxQRv4x2AG5nmc3/hEKrhquEU=;
        b=UExE6mbd/BlRxJAICHJGgDAsEb3cHsUm5Qyx8owgeJv3xcoe6hy0/DHoxXg7qnUwG9
         FFmK6FSEtdEPF9SZayLN+An3PGLC4Sf1e1Nms3rIu7sZGH6uNlnvYiGnLi/HNwZ2bSNM
         TwfKAWy59RyBeNdFfBFWQoIlZnqZe/WvpLTobKOhqSE9/tvdN/42Ju/5Vjq0j8FBAo3K
         VUdDlM7WrA2ZoxapTf97oR/OB9zRH/8BuxqVn8sCUxSKv01vTE0pYfC2I5yqrSHJvP08
         A0OnU8Y7YPubpDPzbrsaoccAu64nAsKh+9ahdQHfb9za64eU3MQE5Qx5mEmy6yB1HmiH
         fI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921850; x=1762526650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ceM6+N8m+GK9mPld4VxQRv4x2AG5nmc3/hEKrhquEU=;
        b=IFy+BcF6GYzEciSxcr/Pfc4bTelbx2lMlaOhA/rKey56Sihqd4r3HAxwxz5c1ppDCH
         qFYvR6PCqBUwDu2wIg6PGmuyeF+CbcHug5kFafw9PyYcG98YBXSwJ7llcwp7SgSdvHZp
         z4FXtPZfOxAVXY3UM7QxGse9JH9ew4nKUycrWxYu9t45CXcUN32T9nY6DI3H/L3SEP3U
         DCzrBHD4kBbu9fMVnu19TJCPu/Vhp9Gga4ufgIFZxD1jnh9Q+oQQoJAug5oCOnjS9wGq
         8SkVgYGrlAKitfVhfKnCi+U4lql5ppiMg6FJncTHgWqiKTuuBiy8Q9G3t8ytJQt6bWGF
         1BNw==
X-Forwarded-Encrypted: i=1; AJvYcCVA3H9flvRQJZmhF3uRO6mWOTE4BH6pgg7RQeXQF8RrSurm9UzKvUSWqgxCmdTxKsSSKcxQRJxiZv960fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQXX3kRp8sOvPqtjw7ZBJIHzzyt3oneQHPU9eRChDHfxSJvh/P
	rnx/OVMqeCnZeSCKDRsfvsXg29j8eCEb/gXnIExFTJk6U0JMfzG7EXK9OGHKkalE9ikG/7ojpcT
	t9Eu7venS+I7G0HQOZa7re/R+0m7am4VH4R8VjzY+N9CB1QwgGHhNSzi+Tvcqx4SGZ60=
X-Gm-Gg: ASbGncsGRiSsZQnAbSvgJBdcetTzGVOTp1phPSGhqeO5v/bCel91PqDby4O6raMPGt2
	Ji2hNrFJwDkBl9VU7nwZKTW5Dbfmflo5x9dReohJjns2+ixylW039mM5O3e34dGyHHPDmWSIfSr
	T0wUVtkVE22xx7iTYmeq2fxjtNuoCJr7CiMs02kFHxZN9nmmR62QLKQza8wDWHiW2tJJTwqtZDR
	KUArCrNbqfP2nY7ZNh+1DHEtHq+czd48M8vH6l1UituE66CYiyX52u2Vesp3O2YSBEu6PigeLLT
	6kMfjSxsRdaiS4oqcMVJgyXsLEjEXr90lLcQYToLfU/eLU9ZNSRpl8pu+NFSliyVRODIMsNt913
	3vG8lAh9SbYa90PfCxvOlMVdFMvJIU3q7Rq3h6EphEGucVSrJ3EJ30FeXQn+9SQuouID/elDUYY
	SeKCexA7uzYMCX
X-Received: by 2002:ac8:5a55:0:b0:4ec:a568:7b1e with SMTP id d75a77b69052e-4ed21818a23mr88302201cf.18.1761921850226;
        Fri, 31 Oct 2025 07:44:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHelD1VXCgMcFcYjxU37LbLyvDsI6dKjKx0q6y3pVlYUBG5k3XQdaFw6pC5rv2qPIwyt1TUlA==
X-Received: by 2002:ac8:5a55:0:b0:4ec:a568:7b1e with SMTP id d75a77b69052e-4ed21818a23mr88301871cf.18.1761921849791;
        Fri, 31 Oct 2025 07:44:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f38d0fbsm538383e87.23.2025.10.31.07.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:44:09 -0700 (PDT)
Date: Fri, 31 Oct 2025 16:44:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Subject: Re: [PATCH v10 3/3] arm64: dts: qcom: sm8750: Add USB support for
 SM8750 MTP platform
Message-ID: <glkwowxkqrhszlh7mpnct2pdc2na7yffq5r3uu73xphtj562oa@mbdlmdltyi4e>
References: <20251031123354.542074-1-krishna.kurapati@oss.qualcomm.com>
 <20251031123354.542074-4-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031123354.542074-4-krishna.kurapati@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzMyBTYWx0ZWRfX0+HkuhaBn3sd
 wvyqrcuE7yFYvWf1M5v2hNCGoHQsitwXod6dM2VKnXOe8ONS3cDcXmV4bDOZlrEr8Ds0IMFA+nv
 J9u0lO/31otVahNiVHqCxKEzbfSSkGpZz+wbrfYIxRvDXz/E5Cp/GeDITyjO2G/tP/Lo8Jb+hHe
 fW0tYKbkQOoFoRiM5flqLFGq1MqA+Ev++3an1zxyENyFBFKASToSCoHL0kQK4wZFBOiNUChGyJX
 gsSFfKdGLGJRnBy6AQ7AXkk17pgvlo4zrgvtbDZfuS6DQZc+ACK8T8BxIJiTjY55UDifs8KG1l1
 q/w9SbF6fAcKRbqpyofwKvKEgPnSztbpDenaChGUPdZVskCYumsRjAf19W3mW+dOUqp+KnmrxI0
 EPkksmb9nrXEkKwqIexkPvGPeTUWXw==
X-Authority-Analysis: v=2.4 cv=Bv2QAIX5 c=1 sm=1 tr=0 ts=6904cb3a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=injzwCg_ScxlFHaeU8wA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: n-ySchIZ7hGK0uLFEJJXYZ-3MuSy9m_r
X-Proofpoint-ORIG-GUID: n-ySchIZ7hGK0uLFEJJXYZ-3MuSy9m_r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310133

On Fri, Oct 31, 2025 at 06:03:54PM +0530, Krishna Kurapati wrote:
> From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> 
> Enable USB support on SM8750 QRD variant. Add the PMIC glink node with
> connector to enable role switch support.

Subject speaks about MTP.

> 
> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> [Konrad: Provided diff to flatten USB node on MTP]
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Co-developed-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 73 +++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
> index 13c7b9664c89..c545695751db 100644
> --- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
> @@ -193,6 +193,51 @@ platform {
>  		};
>  	};
>  
> +	pmic-glink {
> +		compatible = "qcom,sm8750-pmic-glink",
> +			     "qcom,sm8550-pmic-glink",
> +			     "qcom,pmic-glink";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		orientation-gpios = <&tlmm 61 GPIO_ACTIVE_HIGH>;
> +
> +		connector@0 {
> +			compatible = "usb-c-connector";
> +			reg = <0>;
> +
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
> +					pmic_glink_hs_in: endpoint {
> +						remote-endpoint = <&usb_dwc3_hs>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					pmic_glink_ss_in: endpoint {
> +						remote-endpoint = <&usb_dp_qmpphy_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					pmic_glink_sbu: endpoint {
> +					};
> +				};
> +			};
> +		};
> +	};
> +
>  	vph_pwr: vph-pwr-regulator {
>  		compatible = "regulator-fixed";
>  
> @@ -1054,3 +1099,31 @@ &ufs_mem_hc {
>  
>  	status = "okay";
>  };
> +
> +&usb {
> +	status = "okay";
> +};
> +
> +&usb_dwc3_hs {
> +	remote-endpoint = <&pmic_glink_hs_in>;
> +};
> +
> +&usb_hsphy {
> +	vdd-supply = <&vreg_l2d_0p88>;
> +	vdda12-supply = <&vreg_l3g_1p2>;
> +
> +	phys = <&pmih0108_eusb2_repeater>;
> +
> +	status = "okay";
> +};
> +
> +&usb_dp_qmpphy {
> +	vdda-phy-supply = <&vreg_l3g_1p2>;
> +	vdda-pll-supply = <&vreg_l2d_0p88>;
> +
> +	status = "okay";
> +};
> +
> +&usb_dp_qmpphy_out {
> +	remote-endpoint = <&pmic_glink_ss_in>;
> +};

usb_dp < usb_hsphy

> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

