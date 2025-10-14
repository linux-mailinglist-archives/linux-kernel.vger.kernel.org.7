Return-Path: <linux-kernel+bounces-852345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3DABD8BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 892E14FCB0B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2262F6583;
	Tue, 14 Oct 2025 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VOcEkjAA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7899A2F5A09
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437317; cv=none; b=r5Uq8gkHSK5dbXF5XoOEtge30edXvVvorkdBp5XHp0AI20R+7hVRitYJ3aeoXRt8EyzYjCSWfUI6P22U5m7P5moWD/VbPSIZI3bGdfHbcLGJSLl7Gzx0uYYoHOZpnRV6GnEluK39ZYEd5rz56277JcdfoBqEYWhw9koit38L00I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437317; c=relaxed/simple;
	bh=qzqeINd3TniuNVzah8+y5Pm00xrXr+NqqZ4nuDa0i34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Epr5pJdK1lXIGsPYvu/gIdTe6XENhvQKZiXgdTdsD9WFzImS1FaltKObp+8lrYq5nv8z0lGH4qLo6sxQ189k5KOAvzbqXZJPrJ/zvjJuUxpTpBbxKS0rBGdrnh2P+cbrvtjarJOPaOrkRtzpnm6iJl/srSiHcb9TZfslolEquBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VOcEkjAA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87Nl4031481
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iNSQ6LRQ1Cbo1PkY0QhX/x6y
	YGsX22LMPrXlD4eZXtY=; b=VOcEkjAAYW3HxoXQJrAPoPRS1H0DpnKc1Ejl+suy
	45hI7iAXC+r1GPylGOksA/FHWeCB0X6xmINdZ2VDenqZooLgzv52c7zTi5xbWKoG
	cvbTgYI1NbSH4c5HkutAUJObwdEh+t5n/de+j+Xv8YaRjw0MvjDGOBjuHgw92uc9
	e6iDemj0fcTYqQw0lvNJfzoMYZDQELlqJ9Vqj+v95QJhasgsjK9luQjqsNhBBcB1
	9RxYv8WuhGvQ8HF4SllFM9pof2CaviPX+GHRZkPdhG5xtmFkK9hHPBf1sZwVQ2B9
	UrjDBDwLuHIFM9g8wVHZFCtFGCkSxg6ruESGA7LHVb0jTA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0r2fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:21:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-827061b4ca9so2399500985a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437314; x=1761042114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNSQ6LRQ1Cbo1PkY0QhX/x6yYGsX22LMPrXlD4eZXtY=;
        b=SnO2YGEo+cz7RRT5OrKkTTg70hI93Xdp/m1UYOuYrJX/yd91+Sx1ohSjGYWo5haNuL
         eGsiIj+HqPBLIwaZxGASirL8Do+KvMlBquQW4t/n0kFdAWT1qHNPcssMpMaBk+ucSjGO
         TmHHmZvgBJKqLqXoKRsY22GRsonz+CzWQ3ic3yrtnIE0GX6v/7SSb5msIClcx4KheUAX
         DBN/Mk+y2ZEXw6DuWEh7jGqwNmB1UFou5mrqo0SBOWsKPE+Ire3OMqQ3dZ/V+nwxBiAg
         Am3BA7rb0kxZxC/I1aWcQjzVaHw+pMO82csXBjUWyunc0+GvlMevcyRKsYf/YkQnXbGd
         iDew==
X-Forwarded-Encrypted: i=1; AJvYcCV5u7KsJmR689kc7QCw8CKu+5BLoep2Ks8NUhPeXVoMTmHdwyMB2rfcJ0lZhJ7vrT3DrJxF81V0EKHzKDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfSVpz9DyGx3R5+FG0fiHfmGEFoubO+RzZZxKDhpVleq5whhrP
	YdVyRUIBm/ar9NkSOhVH3WXztimorIEtaanLgAYyK2a97n41l2BTwb/eYEa7rPUH1tCikhPD6JN
	nbY64mEQ8s0TauNIVshgQK5oH9kZ/aObMYStLiGGSPyFpvDD5rCfL0ehhtTeTDm12tBY=
X-Gm-Gg: ASbGncs+D8Gb5z43342a9FgUw7x1Fi1NfVYylouM4WfO6IT9+n3XUVKq/VWoG0DdNXR
	H8YPVWLvuj2422jVZYVvYbVe0PMjskUExFpjlXz1JJz9YcudFMmbdog9BlFICUA7gAjDJBJcGRB
	eZcYJ8YhzGozVk+ANHzmQmolp+ao2GFRV+j1SQCV0tKuMNRfBduk1R1s2IgoBnHE9u3THp6pa+A
	dIUSl0zIsWunWFJi8SX0MpktxbWc+NtQv3FB9Yag1VWSUljYN0iyBGsj9ba/oWF5QO1avxZu1+X
	A0tOmfhe4g4mZP9BoVtJUZw0js86Olo729n3DctX9rLIz/Awm3RMtPwr02W6Lkuv55E0shb2Ees
	d1ll0BkSbX74rEaQruq0MkgfmTpJ3k2jZM6WEA30OWp6GkqwBbeiq
X-Received: by 2002:a05:620a:2981:b0:84a:f7cc:1eaf with SMTP id af79cd13be357-88350f575a5mr3980331185a.35.1760437314182;
        Tue, 14 Oct 2025 03:21:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDMRw6EyVXSGprMYoPwa1DMLzUKICAtaPYbkxU2KjxKpjARAfamItqNhipppks0GQVOsrWYg==
X-Received: by 2002:a05:620a:2981:b0:84a:f7cc:1eaf with SMTP id af79cd13be357-88350f575a5mr3980327285a.35.1760437313692;
        Tue, 14 Oct 2025 03:21:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908856e301sm5095511e87.93.2025.10.14.03.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:21:52 -0700 (PDT)
Date: Tue, 14 Oct 2025 13:21:51 +0300
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
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Enable DisplayPort on QCS615
 Ride platform
Message-ID: <kxwavurs7ebp5f22gxutvw4thwm24twqpahszhyxsodsikunja@7hl3y65ppqmo>
References: <20251014-add-displayport-support-to-qcs615-devicetree-v2-0-1209df74d410@oss.qualcomm.com>
 <20251014-add-displayport-support-to-qcs615-devicetree-v2-3-1209df74d410@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-add-displayport-support-to-qcs615-devicetree-v2-3-1209df74d410@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX1KCFUx77zA7I
 SH/DDO0tmQkfU9F/sLQHfZhETA9yLuHmP4RyM2dE0JadgTqnULeIbOk1CpHWq31BXifJ7TW/EWL
 jt++mjk442AtHdUlxBQMmFUNEOJ1TI8mbO65RKW0aB/SUXNtsCVcrj6XJ2bgiAfT3D4V0lMCtSr
 IklKf6NvrA4WZ7bvqi34k0ZvgmDhlssrvf5HopwHve7PWg+oufhnyBlEK7zFEcD3oJ4mRfSFxEW
 gaHgDH2JNQel6NyaHRbtlNWF+Ee07MjncEl7hxC6AtyZXTSkctTwFnfaz0nDMAN6kaW6OA6A/qy
 UcUoOvDLVlX6NEOjy3G/k2ouYwKTBYnUH9ud1wte6TnSoEVdHeBl2pGBRv2VVCEQ5hIE+A0JdlL
 QMONli5EGPei6BXyB7vM+I5hCvx11g==
X-Proofpoint-GUID: pbqDIAnnByiHbiJm2mxGOC7K3uhPZUcT
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68ee2443 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=552JS0bYzuNWtSTagGgA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: pbqDIAnnByiHbiJm2mxGOC7K3uhPZUcT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Tue, Oct 14, 2025 at 05:42:12PM +0800, Xiangxu Yin via B4 Relay wrote:
> From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> 
> Add DP connector node and configure MDSS DisplayPort controller for
> QCS615 Ride platform. Include lane mapping and PHY supply settings
> to support DP output.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> index 9ac1dd3483b56f9d1652f8a38f62d759efa92b6a..0b8bcabdd90a0820b1f9c85e43b78e40eb8a9a38 100644
> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> @@ -39,6 +39,20 @@ xo_board_clk: xo-board-clk {
>  		};
>  	};
>  
> +	dp0-connector {
> +		compatible = "dp-connector";
> +		label = "DP0";
> +		type = "mini";
> +
> +		hpd-gpios = <&io_expander 8 GPIO_ACTIVE_HIGH>;

Not the gpio102/ 103 / 104? Interesting.

> +
> +		port {
> +			dp0_connector_in: endpoint {
> +				remote-endpoint = <&mdss_dp0_out>;
> +			};
> +		};
> +	};
> +
>  	dp-dsi0-connector {
>  		compatible = "dp-connector";
>  		label = "DSI0";
> @@ -423,6 +437,16 @@ &mdss {
>  	status = "okay";
>  };
>  
> +&mdss_dp0 {
> +	status = "okay";
> +};
> +
> +&mdss_dp0_out {
> +	data-lanes = <3 2 0 1>;

It's not a board peculiarity. All QCS615 / SM6150 devices are affected
by this twist. Please move this to the SoC DT file.

> +	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000>;
> +	remote-endpoint = <&dp0_connector_in>;
> +};
> +
>  &mdss_dsi0 {
>  	vdda-supply = <&vreg_l11a>;
>  	status = "okay";
> @@ -623,6 +647,13 @@ &usb_qmpphy {
>  	status = "okay";
>  };
>  
> +&usb_qmpphy_2 {
> +	vdda-phy-supply = <&vreg_l5a>;
> +	vdda-pll-supply = <&vreg_l12a>;
> +
> +	status = "okay";
> +};
> +
>  &usb_1 {
>  	status = "okay";
>  };
> 
> -- 
> 2.34.1
> 
> 

-- 
With best wishes
Dmitry

