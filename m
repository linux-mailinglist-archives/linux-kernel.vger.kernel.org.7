Return-Path: <linux-kernel+bounces-898624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B103C559C2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D9E983469D9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337492DF130;
	Thu, 13 Nov 2025 04:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e3SxdEh0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XbC/H6Hl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22D92BD58C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763006495; cv=none; b=MzRkwFN2TrQvAAoFP6T/z5Oj2gfQjpCpiio8ct+vUX8tdEfxG8F3RXJwyfOCK6ERMhzEuB0NQuBp2XcZ9RrpTqvnkL3u49eJ13Zscb3Oi8d1t1DqUN2ReJf4DAwTaMb/NXDcav2ewRjT3P3PBd4H0kmGEoQaZJeHX0usrZRJSeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763006495; c=relaxed/simple;
	bh=ApgxYi86HOjwkB9t8ICvCXOaL9Z0Rzqi6CJ+ls2Guvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXYmhBTcbBrH7zqCc7kNKkXWOgM2qiI9N+XKU+CR1aTLXwtrmTz+skrVtikpmyM/49/DV22ZFOZ2jx+465Ju2+PqdLD9/LTPe3FOUsAZo6WkMVM9I3Z31rOuCFTFtYtgIrdqbeeP2uCLA2nnzGO5hdw1py01hradMHfJd4yPMY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e3SxdEh0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XbC/H6Hl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD11Lr53149994
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vvTqxjY0uLJN26zmCg4YTJ3J
	aEBP3xx+24biRA8g7d4=; b=e3SxdEh0gDpU6yvFyLiqUqbzbes9FGIhbT4bkFQx
	fMIeMHr6gYnLHCeF01oujCjTjL33vBreqhl8viou8Xe+uY0A9pXxNzuo06w87C0f
	XdNrKrpc6SWaJBYdU07k84CnS37e/n7Ne/ja2dz+wMAQh8T8Pw5pxTcPDkQvFmhh
	Y8WwR+mkV8vi1v1LJq6iZxPi5Az/SjxontYJz04vId/J2oyOBBhJ3729p2yoFDvW
	CNyS2fEu31KMpYxsekXnFbA4btzdNvmc+LP/WUeHs96r/s3s0vslX+8+BAqpofCc
	qJgqdDvXgCqiq4AMqK99O9T8FKkJsNhyWhbZZm1jxLwVNg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acwve9t2s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:01:33 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9371a5de3f0so1249511241.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763006492; x=1763611292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vvTqxjY0uLJN26zmCg4YTJ3JaEBP3xx+24biRA8g7d4=;
        b=XbC/H6Hlku0+51x0ibVeIB1WyYPMUbWo04YBpEejmxq8POG7f+6L+0w/x5PrZttpaO
         GPt/BrT9mz1E5ilGKUHPO1UZFnhAO+m6k6U4swO2tFhQNAeuph77bx+sf1yLL2K0asp2
         GIEX0265cNLNu+MYnurpw6U42C3BkHPYBpUzJkAPodVuAyfRodOgolqXYl8kpIP9NJej
         in9ZeOPoJgV3YLCVX7VNmtQkIjqROxWog0hXwr+uBYo0sSRkaGNzSZfUhrN//oGe1DbX
         FH0Tw/CO7KVyszkeSE3rl1/5Q2rRQVTzIE1FbEp1hs4nndGlfdZdTxQp9tu3rA53zs1k
         nkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763006492; x=1763611292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvTqxjY0uLJN26zmCg4YTJ3JaEBP3xx+24biRA8g7d4=;
        b=RosYlYgnHxlA5iiW/axe98BYVoYeBfCjehbKZDsjFFQUlTxm3pbWuCHsxczKDXfTwo
         DUdTSrwkBy8HehYM5UhsmiXbiSIgniwaeTIBML0YzI6+vA7T6UIcQ46JSkZhOb05zIcK
         q9tWGk6u77FSJPlwI24n5ReKAiB848D8MyBZjp7LV9XBMFgZktE0YRFtzE8XHVfVpTb1
         enyREZ0mqvUffBPhS2AMEncJEIj+pT7+evLDGf0qiaYdZk0TgzxJSxxeiAUKmKYJb1A1
         14BhBYvQbufyf7EwGJCRk9eqzayoe+FN2/bLGLExXlgW+aMPfX27ilRV/3r+CpGz/wsa
         mXpg==
X-Forwarded-Encrypted: i=1; AJvYcCX/SmGHjTJ2lDuCP8ZFFuDOz3RqT1iHVAqjYEtz3JG+B2vmr3oHstJUVT2Q+x7LhM6N1ZaOxwho3Fzk0QI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbl5+HrWz/GbcV54W7MhT/tfhtHALizjKEP/S7Mwv3ZHrnY9Bo
	kcWC5UCSkQwARORBKxqvxN+fzBWqFCSAawhyBYGpYP6gOkK0QwPBZm2EypNkzFfxDpl2LOXu4DH
	Ss7fY1seXs2zRH82RN4s32D1Aqmu8fyrHBlhxrql3hsK6AJKZvYaeBiaGkPgzVpGDfYM=
X-Gm-Gg: ASbGncuAKmmVFNu5cEicvCCPPYddiemGNdVR8YvDxSUoipqq8pXCXoS0c2I2cedsyOo
	haYl7VY4wWYdPeYM8/tXMDUZAaLDVYNcsm7fF/lDSwHS+aT4vlXoG9oSyuz+uGS3CIAKRjPmyHy
	o/VL68t4EC8kNXTXVCmuroux3Aq4rhOvUWwEeQY1DsM/kTyCeAqeTBbJlTscfKcVdd23Df/BDJj
	LG2JmReNSWXNkaRULxEjK7XqjQrkUHkzygMyHFR/iO8H0g2wKumSJS4XAl4a0InE2/U0fAxRCJ0
	H7Yf0HQhnbxkCYhi1BspVta6+dSZd+6FQBj0v/FV0rlNH3xRzvp33zOgicj4OXYYEAwjrAt3KEv
	tg+lEWQwrL5zeHBiwrZkuoQ2SDlgGPsUBfvsrx0mQvPmJKz3KWf9BpuN31RrR49wnAJ/TC9lZ+Z
	olMorZnGP72+6d
X-Received: by 2002:a05:622a:130d:b0:4ed:6032:f644 with SMTP id d75a77b69052e-4eddbe5441cmr73815611cf.79.1763005830888;
        Wed, 12 Nov 2025 19:50:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAdMc9Ms5ogZyKy+9znvlX5hIpbU9lzUUxY9/KHe0/crxn4EPl2IH8EBglGLkj0bpwcY8HrA==
X-Received: by 2002:a05:622a:130d:b0:4ed:6032:f644 with SMTP id d75a77b69052e-4eddbe5441cmr73815491cf.79.1763005830480;
        Wed, 12 Nov 2025 19:50:30 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-595804057b0sm123940e87.85.2025.11.12.19.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 19:50:29 -0800 (PST)
Date: Thu, 13 Nov 2025 05:50:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jessica Zhang <jesszhan@quicinc.com>,
        Abhinav Kumar <abhinavk@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: sm8750-mtp: Enable display
Message-ID: <knfknl26as6becjwg2noedxklty65i6bdixx4vxwusyswppdsk@vstzkn5xivnv>
References: <20251112-sm8750-display-dts-v2-0-d1567c583821@linaro.org>
 <20251112-sm8750-display-dts-v2-2-d1567c583821@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112-sm8750-display-dts-v2-2-d1567c583821@linaro.org>
X-Proofpoint-GUID: gjMAe1TDWeJ5TmUxfk0NTNx1cDG52vAU
X-Authority-Analysis: v=2.4 cv=F7Rat6hN c=1 sm=1 tr=0 ts=6915581d cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ZB6lwbF0aVbjLvXVTRgA:9 a=CjuIK1q_8ugA:10
 a=TD8TdBvy0hsOASGTdmB-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: gjMAe1TDWeJ5TmUxfk0NTNx1cDG52vAU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAyNCBTYWx0ZWRfX5YBD1ywPp5XB
 LODI9/IRhizg23THRkJmOXVMw8obI6gWFjxIPvO3P6rRsI/LoHIo/ifqtx5iYc+9a4X4pkHKBcW
 9/NEGZwejqSwOjPSU17TOcPiSLggDyWguymNt4EHv4HhbQ/Gxb+RWTFvnQRh/jvNYJ12IAyE0dF
 R5EAJIiD0KIM5ImSOKD42VBvJYcJiZ5VizbF8gB4qOeOPlABaIhYnEftGgLbdQ9gywwNNedpTw4
 vG2oFjKVLd0/C5X/cQsGASqF0Q0QW6Mbnv1pQskmLum612CcdzsJSywWqwQZyg6ulqAABtpRraH
 Mr4lv0MkAjtiIWOXM417rFVNzD0wYmkWUXtYnLkceBs1/8c5uUBz8kAIoCjHChthGJQt+tngwem
 Pj0OxLqMcJJCIHUias/qJwZX7KlhSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130024

On Wed, Nov 12, 2025 at 04:02:39PM +0100, Krzysztof Kozlowski wrote:
> Enable display on MTP8750 board with Novatek NT37801 panel.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 70 +++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
> index c8cb521b4c26..68644eccdbff 100644
> --- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
> @@ -933,6 +933,48 @@ &lpass_vamacro {
>  	qcom,dmic-sample-rate = <4800000>;
>  };
>  
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_dsi0 {
> +	vdda-supply = <&vreg_l3g_1p2>;
> +
> +	status = "okay";
> +
> +	panel@0 {
> +		compatible = "novatek,nt37801";
> +		reg = <0>;
> +
> +		reset-gpios = <&tlmm 98 GPIO_ACTIVE_LOW>;
> +
> +		vddio-supply = <&vreg_l12b_1p8>;
> +		vci-supply = <&vreg_l13b_3p0>;
> +		vdd-supply = <&vreg_l11b_1p0>;
> +
> +		pinctrl-0 = <&disp0_reset_n_active>, <&mdp_vsync_active>;
> +		pinctrl-1 = <&disp0_reset_n_suspend>, <&mdp_vsync_suspend>;

Nit: Is the VSYNC pin a pinctrl for the panel? I think it's a pin used
by DSI controller or by the DPU.

Other than that:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry

