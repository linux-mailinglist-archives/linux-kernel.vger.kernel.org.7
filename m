Return-Path: <linux-kernel+bounces-583264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95669A778B8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 12:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5184F3AC3B5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 10:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526071F09BD;
	Tue,  1 Apr 2025 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kezNLTyo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BEC1F0987
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743502770; cv=none; b=Y2+2IpIDAO0Y1hy5X3b+JRa9nONssg6kgpkTSh77cUVBfslfUZy30bW5ZcgCGfwRpu9YCaEkAneuuMUY4TsfFXO/ib4+p/rtkhvSRg24L6jFZ/NJPsCyxRtIeRMUVpzoAaKFOymZbsEstBG0FgFQa89B2Kp5WiMT36pFhMbLS48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743502770; c=relaxed/simple;
	bh=VLndyfSBwsI92OgxkgucYvEjqkkt/ZCVDRe+KPbDQio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ay2YkvOynFy6hBWgTzZdGIjvgZD8uIv0I1ksp8dvGjVmRgZb+Ey4GOBX3XQRjHB0rg8tQLCbfC6n0sCyArBnYrdr5trZ9WtOQO9C182NQJHD63yZR7vR9nbIdsn8QZ5kAHtzMGjhVwbq82yEJxdmoD5jMWexTkOEy2DA0ZaNaFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kezNLTyo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5315mapu027938
	for <linux-kernel@vger.kernel.org>; Tue, 1 Apr 2025 10:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2DOPs8qVr8I70ztM6rWE5VLdIGBtlthQzmw040FJiSQ=; b=kezNLTyod0Rfl4kQ
	eCeOAyLIBXdZAYqjmEWxfbPtTouMkt1hAjJSWdaeQTVAKA5CONG2aTyu4wgOucpU
	VLgo/wx5qlvOuKO3eQs+1Jgsd0wwC4t7QiS6FEOGYL27+GG3zPUKu5mSCycPlWW3
	AX/2ZXHAcfxsFNaE8OAQb9FNJqKPOcuLwOI/4oMWj4nEQOCNN5oD6+2C1SKIAB7J
	hlXV3EcuwT7pF5Gxg3jolRNS62V2+pmZfIyfGZlLs9XWW68wnEiqyvBrmkVoeFlP
	MlI8Cj7tYuXCNaHoMd0B8GVbxtqDGAXFuRy3j+0leZb4QL+KxN/W6y/ZfX12oeBZ
	MsH2cg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p7v8fpqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 10:19:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4775bdbcdc3so11981041cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 03:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743502767; x=1744107567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2DOPs8qVr8I70ztM6rWE5VLdIGBtlthQzmw040FJiSQ=;
        b=jrfbGzw/RT9jQH8ehRSadHgwlU9I/5qGuQ129Z4bt2f6s/P4IY+Wb+ZN0VgR8iAYZi
         rvMJBf+g1lkeOZ9ehSxAhSi5kykemdtd5tYwJfMTkIChaq6rnnPlFOmJLDjWaBeMa9qB
         trfqt7IzgBozR/dupcck8oxTRf+aPQ5FMZKfw5wvB6edvLVRrukSxbYZJheBbeU6QlE3
         +aUBcIAKXmiS0y9N9zM3H3QQB8tSCCD5S/PfpkwhcPEWV0h8liAPM4cytsOcK71tlNrl
         zamnK7B1MnNTMZK5l7Z/VEsHqM+RD3XWoCw4Gtu1iE+DmPKcHjOCHmd/Gm64dfHVIxVw
         f3dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNxO1dolJA3c+jaKltNSr5L6Xt4huMobGeIAZVSw0MklzDJKUMchjhc7oobNwG0wEtd+7pCdgs1bi1Nh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqh4RhMsf+h2Q2GTTE8NBT6wBN1p8RVmqgcSM9ZMYnkZbl/XQL
	1wA0vhyfg5+dxmCgd9DTzyWrMcfWCJq1M22mZE1OpqJQIhnZQJp9NcYtD3YYlnIySpKW4CUwDHC
	FsmvmLf9MtIJLmIf9zg+0RtlFDnrXOgw20QAH4kwqBilw1NLOBgA+DwTWYZQAiVg=
X-Gm-Gg: ASbGncsnqa94wkqntcsWCSfXh8/74NenBIYBVVSvXxtcyxhTuttLAEeHeKTLzKWjyhJ
	8tL6JcC/CUBkmxau0I12FfC0iaJQ2th+H+xcUIYkHYYpNCVUx0QGwCqXkdNJ74MNUOf4Zm0hQO7
	/5/jw61VGGwTh3H6fJwktwmc55Rbio6/b8neLxVmBbuNewLGosS5KyoPIYWEpf3xyISYn0eK+1C
	S/pL+tZnPaD0p7mIWT3iCefva88vctUSkKTqp7Vt4UmaxGGWJeXS1mVJZm2AVqFprRmsmPuRve2
	LeLgC/bVrQO/HPsRgYa788FjMPWTa/FfBqU01A+HgAcxKQ+T7mtwKCep7NJ8gJUKQx5JIA==
X-Received: by 2002:ac8:5743:0:b0:472:15be:54ad with SMTP id d75a77b69052e-478f8caaa3emr8015341cf.14.1743502766794;
        Tue, 01 Apr 2025 03:19:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVCXq1wEZzeuviNZFWjwRTsD/J2nl2Zsg5QfwBRNLIyCOjFWs9y0I9oOKP+u8l03W7oJ4KfA==
X-Received: by 2002:ac8:5743:0:b0:472:15be:54ad with SMTP id d75a77b69052e-478f8caaa3emr8015221cf.14.1743502766458;
        Tue, 01 Apr 2025 03:19:26 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16aae6fsm6857889a12.16.2025.04.01.03.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 03:19:25 -0700 (PDT)
Message-ID: <219c03ee-4440-4452-94c8-f8b32c147db5@oss.qualcomm.com>
Date: Tue, 1 Apr 2025 12:19:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] arm64: dts: qcom: move pcie6a type change from
 X1P42100 to X1P42100-crd
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20250331215720.19692-1-alex.vinarskis@gmail.com>
 <20250331215720.19692-2-alex.vinarskis@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250331215720.19692-2-alex.vinarskis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ygxlwLmJO1vK0OWQ1EvuljOl_6tHjn_t
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=67ebbdaf cx=c_pps a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=umw4QfNw0YT-tJYoN0AA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ygxlwLmJO1vK0OWQ1EvuljOl_6tHjn_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=931 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504010066

On 3/31/25 11:53 PM, Aleksandrs Vinarskis wrote:
> It appears at least on some devices (Asus Zenbook A14, x1-26-100) change
> of pcie6a_phy's compatible breaks the controller. Move compatible change
> from generic x1p42100.dtsi to CRD's specific x1p42100-crd.dts instead.
> 
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/x1p42100-crd.dts | 4 ++++
>  arch/arm64/boot/dts/qcom/x1p42100.dtsi    | 4 ----
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1p42100-crd.dts b/arch/arm64/boot/dts/qcom/x1p42100-crd.dts
> index cf07860a63e9..a2a212b31556 100644
> --- a/arch/arm64/boot/dts/qcom/x1p42100-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/x1p42100-crd.dts
> @@ -15,3 +15,7 @@ / {
>  	model = "Qualcomm Technologies, Inc. X1P42100 CRD";
>  	compatible = "qcom,x1p42100-crd", "qcom,x1p42100";
>  };
> +
> +&pcie6a_phy {
> +	compatible = "qcom,x1p42100-qmp-gen4x4-pcie-phy";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/x1p42100.dtsi b/arch/arm64/boot/dts/qcom/x1p42100.dtsi
> index 27f479010bc3..4424a8708d39 100644
> --- a/arch/arm64/boot/dts/qcom/x1p42100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1p42100.dtsi
> @@ -37,10 +37,6 @@ &pcie3 {
>  	num-lanes = <4>;
>  };
>  
> -&pcie6a_phy {
> -	compatible = "qcom,x1p42100-qmp-gen4x4-pcie-phy";
> -};


This is not correct. The hardware is different in all SoCs, not just the
ones put in the CRD.

You're probably missing this change [1], please test it out and leave a t-b
if it's confirmed working for you.

Konrad

[1] https://lore.kernel.org/linux-arm-msm/4c7059a0-46a0-424d-9068-60894c6cec1c@quicinc.com/T/#m9675593a62b2334ab2afd4269da6938464a03fa6

