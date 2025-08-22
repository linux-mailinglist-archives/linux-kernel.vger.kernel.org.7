Return-Path: <linux-kernel+bounces-781733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2CCB31606
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B8DA0189C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3782BEFFD;
	Fri, 22 Aug 2025 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M13f2elA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC0322D9F1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755860499; cv=none; b=fO6bNdzaTas/6Foph8mcb+4UtcE4J6fMYEBfw4yYRG2pmqo8mhaJnhgDmuucg8dr7jkl4eYPodAGRGbMRwdqZ59lAJB435D9f6OsQk735GuvEQ8LnmqA6sbyCV2vkIn4JTGdHV0sbz6FRgM4PWCdGLo5B3cvAxU0EgCJCW8YVnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755860499; c=relaxed/simple;
	bh=1oIR3f6sQ1sG0GTI8Pw2PJtuQjPMw/nkuc5LlZXFwTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oogBNGVFAtQk7RrS3OlRipEKJhq2jx9bXy8s2XMKHmXI76o+1SMyyPv2DkHg4rq5MvN64fs7nooxCMscKMMNuK16/4CvKKEywAKr01xzKh0zLXJrJ0FTmZ9eQEDsJAnwA/GbwIH25s3UCb6mhV4HsRIrEIjSuyqDBLbwE0LaYPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M13f2elA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UVsv011289
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bpyG7EvRpdOl447CLef2b+TR
	MD4CwJUfVvwhnQyhNYo=; b=M13f2elAZwJeBzFTRWQHhrh8/YiTCcU3LZMX6Q+b
	YJgJ+Zj/y3EQZSu2nA1ab2Z5lh7Q2TXzK33X7Y/FmG2ifkpjWrPkZoUKwkCvynRz
	HpDeiwYLkySl8NDF9qTWo4yS/M1wSH1as+5heu3/tNWoCbUwYcvwU+aYbBxY0/Vv
	ak9BoBlYJmZUo+RktuZvgV9whYe7O2YzGQLYTAcH2mIBKZoV7wnaJ0WgXEF7tnH1
	3r0IZhNsDxJY6C3HNbUIx5yb4iG+ykPn+FQ4+KY80d3Bzy6PEvVErS8QuAK1lI9Q
	2l7C1lK5cHeTWswpIs1v7EWb+LV9LfXPAjYWuVsokH0aNg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngt8esad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:01:36 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-89018ea59e0so3334697241.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755860495; x=1756465295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpyG7EvRpdOl447CLef2b+TRMD4CwJUfVvwhnQyhNYo=;
        b=fKD0n8x5hs3jrxwtsPyMj1sWC2wpGGoVv3NNxxy47eFMxu4KkWJsieYEMM5dfMzTVX
         Eea+iKkH7S7OPpAVWLGjJfsvyzdlJC9umksicZcr+vxo6sS/FBzNiOAwhOE1+ymWGlvb
         1lOSHZVbAwiMQI8i0c9muPoYe8EHNoekyXHa7HEtEZJees0XDhQ5TxzcltR80+6Kbs0Q
         UdEJjv7pcLbba5RtJ8T2LjGy+9fmPVWzLXi2ATts1CcuUSsuyfm5o2VcsdMm94tldhKs
         A2GZ49ihTckU8k2Hb7+5wgpGtm6kLJzie1klzh3UqPRPjwQ/Mhc4H3Opci+bxvK+9GAN
         N2KA==
X-Forwarded-Encrypted: i=1; AJvYcCXXRnrLw8/2yCc0DcJyHB4zwDPy58ZvjriUcINB60mL6XzxsMZdIlBYOtN+60fhPRTDUyEn27namJsP+Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQc6crNr3I2wY7u29dS8vGPKUuczKvz3OiunwQcsGADxsEIDfb
	G/pvAjAFne8lAep8kic05WVMbE3Z9WQ+mSaPSKohUlNj6h1+wvoIc0upMl7dOGYifK7i2boac0f
	gFYZ/OTOrJFHeVSnHjymIENiIFUcvjqMCELCKtxv025vcfgnCvMlB2fnZTSPPSpWN1sc=
X-Gm-Gg: ASbGncsScnJQHeUsqMr2X/Zh8JhP+W1YLMUnN9jElFgi2RTbjTRmJYl+x4i0ttS/rF9
	+zSxLYtDvTW4skDS7Gt5bpKjZ7s8KmrPLeLYviJGZDqG26YjdG9HIbQpriQUJLpQrbJx4WyzhR/
	bKLZaNzKFAxmGlpYDLrPv7gBOxdE7WplA0zG7wILlyZNs1eYHyhnhwoVitY9TX4lx+BjsChVvMF
	1qMz/sc+smGurl0IguuwSFgk2AD7xPZQNmRw9zLa9U5ZU2961/7IS72OWI/WPyCizVg7MkM0OjD
	trhBBC8NsX9RMz02iWbT3gmBj08V9ZwCyWVJH4kt5u67OUa9dlBJmoQpOFJWkfloqHTBvyj9Jxx
	x5fdR68tkDcSnxldEkyyD7xzgH/atK/AtQdDM56OkESBcjuXH/8fx
X-Received: by 2002:a05:6102:5a8d:b0:517:1303:630f with SMTP id ada2fe7eead31-51d0cce4e4amr593613137.5.1755860494961;
        Fri, 22 Aug 2025 04:01:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGweYGL+U+B5slkwqq57ojJOnyc8XShcyRzoQeep4TEQavSriPWgyaDDgBU9fPmTMKCGI8tOw==
X-Received: by 2002:a05:6102:5a8d:b0:517:1303:630f with SMTP id ada2fe7eead31-51d0cce4e4amr593584137.5.1755860494355;
        Fri, 22 Aug 2025 04:01:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef351685sm3539569e87.36.2025.08.22.04.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 04:01:32 -0700 (PDT)
Date: Fri, 22 Aug 2025 14:01:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s:
 add HDMI nodes
Message-ID: <as7pbmhfgsg3ht3s5lu25pfjjamaxyonuohkuohono3kr2mxii@posspuko4vwa>
References: <20250821-topic-x1e80100-hdmi-v1-0-f14ad9430e88@linaro.org>
 <20250821-topic-x1e80100-hdmi-v1-3-f14ad9430e88@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-topic-x1e80100-hdmi-v1-3-f14ad9430e88@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNCBTYWx0ZWRfX+KU8oEgyZdKH
 wjUUUM1Vmt2SBAZkql7zdBX1Su8E7UQ3ok9zDJ53KjoGtQD/aPyLX/lTag2AwI1RAh0VI8lsCfN
 Ta1Qt2aZYFV0iMzP5/eDR/mWqeBmjrWJcKIQI1RK6DLHz+tWoLVivn+l8TKAFRGx02bZoUbAVM1
 +/gY5bW9Rz8NBalCl6o8BKmReDjqYFBb3BMnvzapFirZ3t3jXDUj2tB4touv8YsRoN3GwJIk39m
 vDxTXzY2/5wl8SeeoY9VpLMPVuMRD+Bm4Zd7ZR7jewrcWeodF36LY9K6/fJh2uTKv5faW9RWj0w
 pgzUxZKG4d8RvmqBRxZ06dsQncYK+/Oz+QLe7/uPQ//OXltcKE6qoPHC5jvpl6X/w3gmv09ujnq
 mOc8ttwUuqa1oiQSHjO1MakxmHoh9Q==
X-Authority-Analysis: v=2.4 cv=c/fygR9l c=1 sm=1 tr=0 ts=68a84e10 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=DvVwCw6QEd6eSbBiarEA:9 a=CjuIK1q_8ugA:10
 a=TD8TdBvy0hsOASGTdmB-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: mc0nUuQO29E3qh-NFUwNKzQvBchIvHWG
X-Proofpoint-ORIG-GUID: mc0nUuQO29E3qh-NFUwNKzQvBchIvHWG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200134

On Thu, Aug 21, 2025 at 03:53:28PM +0200, Neil Armstrong wrote:
> The Thinkpad T14s embeds a transparent 4lanes DP->HDMI transceiver
> connected to the third QMP Combo PHY 4 lanes.
> 
> Add all the data routing, disable mode switching and specify the
> QMP Combo PHY should be in DP-Only mode to route the 4 lanes to
> the underlying DP phy.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> index 4cf61c2a34e31233b1adc93332bcabef22de3f86..5b62b8c3123633360f249e3ecdc8ea23f44e8e09 100644
> --- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> @@ -62,6 +62,20 @@ switch-lid {
>  		};
>  	};
>  
> +
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +		pinctrl-0 = <&hdmi_hpd_default>;
> +		pinctrl-names = "default";

If this is a DP HPD signal, it should be a part of the DP device.

> +
> +		port {
> +			hdmi_con: endpoint {
> +				remote-endpoint = <&usb_1_ss2_qmpphy_out>;

Please describe the transparent bridge too. It can be covered by the
simple-bridge.yaml / simple-bridge.c


> +			};
> +		};
> +	};
> +
>  	pmic-glink {
>  		compatible = "qcom,x1e80100-pmic-glink",
>  			     "qcom,sm8550-pmic-glink",
> @@ -1007,6 +1021,14 @@ &mdss_dp1_out {
>  	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
>  };
>  
> +&mdss_dp2 {
> +	status = "okay";
> +};
> +
> +&mdss_dp2_out {
> +	data-lanes = <0 1 2 3>;
> +};
> +
>  &mdss_dp3 {
>  	/delete-property/ #sound-dai-cells;
>  
> @@ -1263,6 +1285,12 @@ &tlmm {
>  			       <72 2>, /* Secure EC I2C connection (?) */
>  			       <238 1>; /* UFS Reset */
>  
> +	hdmi_hpd_default: hdmi-hpd-default-state {
> +		pins = "gpio126";
> +		function = "usb2_dp";
> +		bias-disable;
> +	};
> +
>  	eusb3_reset_n: eusb3-reset-n-state {
>  		pins = "gpio6";
>  		function = "gpio";
> @@ -1486,6 +1514,22 @@ &usb_1_ss0_qmpphy_out {
>  	remote-endpoint = <&retimer_ss0_ss_in>;
>  };
>  
> +&usb_1_ss2_qmpphy {
> +	vdda-phy-supply = <&vreg_l2j_1p2>;
> +	vdda-pll-supply = <&vreg_l2d_0p9>;
> +
> +	qcom,combo-initial-mode = "dp";
> +
> +	/delete-property/ mode-switch;
> +	/delete-property/ orientation-switch;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_ss2_qmpphy_out {
> +	remote-endpoint = <&hdmi_con>;
> +};
> +
>  &usb_1_ss1_hsphy {
>  	vdd-supply = <&vreg_l3j_0p8>;
>  	vdda12-supply = <&vreg_l2j_1p2>;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

