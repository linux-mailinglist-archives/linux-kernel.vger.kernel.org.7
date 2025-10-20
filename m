Return-Path: <linux-kernel+bounces-860610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF59BF07E5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A40EF4F1D04
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE5C2FA0E9;
	Mon, 20 Oct 2025 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jrb4O64c"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5E82F60D1
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955402; cv=none; b=dgSgy2PAHkp+isoMos+x/dMw3WXQ9UZv+lvAXeyxW0n+HiSPscTz338hnz/9VvDwXV3n5vekuDWwLHGI6uQQcGih3e9uu54u8UhWRfvbvpI9fN4k4MAd/1UpjzaP/24rzNp0pICCbfA/NedHHwXSnpz89uIHsVDSihDI5+ZLm+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955402; c=relaxed/simple;
	bh=mdpf1Oy2ydcWXpHDNlNXheRGi6wp8wV18k/D4DoO4KU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5ugAy/2IMLXh+lm/DCPPiwQZXMfZMvWTWHDtda0NhcmW0xRWenBkv7eQx8AK125OtxHUwBpswDHk+YkQgbGhkMeqD/oMZUb9e+GUaS/YiGxGH/zlmLOti2gk8aLO2eyKmokimrwJJPAhqWFNeHSFpz5s/247rWLL+iM1Y74944=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jrb4O64c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JMauvv015332
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X7GiakkB7w+XPBZzGT+5+Y1LK2gVzD7OqWO9cWs4zks=; b=Jrb4O64cZk/y8r1s
	bWyhZfULLMdw5Z9HLly+yFfaQ87+YeOkBvk3+CCRzbqg8oE6EbnggIq5kcPp6f2t
	lL6b/DkvT8SS0bFfOcnIqtRm+RAJZqLZ2BwdulCVr4ZVJ/bINKJtwsfXbxePSyTH
	r0saGmA+H9JLKuybf/I+lCvAiOstOIzs0Jad8iosDZDcTxtRs7vmJt46DPp5oEUU
	bk3yzjOIwnXcN88ifd3bx9CorjR9X26ZZneBy0MyKVcVf5eoBczoZue3+kGC14J6
	cxssThapAVbxbHQTA01y2IJD0o7Oaxk21Xi4mcLzFBssdFmBUIGSj474kg2TQe3x
	r40VwQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v343ve5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:16:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88f7d885f8dso165824285a.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760955396; x=1761560196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X7GiakkB7w+XPBZzGT+5+Y1LK2gVzD7OqWO9cWs4zks=;
        b=aiLXDBfMZz1TAr4PEhampc1P80Objbj/Mv1ArOPgDapwTZ0eZPwpt2sz8dYXnsKlen
         w/C3U79DvzcP3BMb4qWC+dIxnJ+IFBn77RuXJEukMri2B+1KMKL2gZQR1MfOUkBuIwWG
         VjhFF05RzC1nKJ5+CniMFQRM+KsQ6g+AnvwjjuVeoTH4QYF//u1lhBC8cAb7+MHPWj7B
         oTYXVhHirL1wtrwQ/bOg5rhZLhCUQmaZNiH0+C8PuSJ8aBIi0i2507yw9RzWb49PzoGY
         K7nBhHsqJrAAEApibdEyYS5wx7StcH45DiOR6+YQ34dsAg/ro4/Qgx3Ivj0SL7o+FuK/
         wt9w==
X-Forwarded-Encrypted: i=1; AJvYcCWQM6eHKnm4Ak06IVhE3I0EYIRmOd2tXh1rMnnYC/2Lb0SHkXXn2ykrX8N7HSDPx7KZqyRD5Clx0uBxT9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOXZ/GtB6Wo2WcxFgQHZDupmiMxtBKaPcphX3fqsVijF/TWfz4
	14VUDsqS3q9mm1E1ArMqT419+cnItiyl1z2XwhLDfdydzt3H310u0rgKQBCs28oWJ8v4HOEHXzB
	1YrY6i4o0NBM9z8l75ux00wtXeintiP09PHFPG9jw93dpz6XkD864s69FqCd1tSDYrtw=
X-Gm-Gg: ASbGncsQIqlfS/oWJ2YrMNVij4ygOfyEgH8h8eOb4heSpi7lM3C2SuxMskl/D4fVEOm
	7zA/P6rLkrFhQ/rX6r6rGG3dQdso6VFbVxRPIP1IaEFAzG0NDUHNqefV+u3JKa9RMbOWx+wUDxi
	c2Sg/BIjOXYUqSILbTHK6VGBMfRr1kVuQQv6L9YV8RUParFy9oXvRpZQJYMgtYMm6oPRSLB7Mh3
	8V2Lz3loGK6w6H9h/IPb+BNMp2JY77SJJWzzVWzDPr1jV9W9bIDA4qXW6F7MBeg02YnWFAMznm6
	du/ZCjtGYx0AOcOqtYgWY/yACNv5fQmQFi44ZmwgcBEnKDWuQYw3u3M2Kck0d63aNN/b6wQ4Vjr
	1ZfvloSp8k3jYyavMQV4TTuiV+1Ky/Ip2zLLVWTpRikuPu8nRKxvhmmi6
X-Received: by 2002:a05:622a:164b:b0:4e8:9126:31d2 with SMTP id d75a77b69052e-4e8c1ab2c0dmr24082511cf.5.1760955395820;
        Mon, 20 Oct 2025 03:16:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS3mAY5bftHTOOPGyd0UuN914pq2mMKSAA/PCsiHWYAXoa3iQZKyBuxtJgaJglQpUr7gc+jw==
X-Received: by 2002:a05:622a:164b:b0:4e8:9126:31d2 with SMTP id d75a77b69052e-4e8c1ab2c0dmr24082251cf.5.1760955395353;
        Mon, 20 Oct 2025 03:16:35 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da3412sm750511666b.3.2025.10.20.03.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 03:16:34 -0700 (PDT)
Message-ID: <c754eaa1-555b-4ec7-8539-b98a037bc2c0@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 12:16:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-shift-axolotl: Move address and
 size cells upwards
To: =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
References: <20251020-shift6mq-dt-v1-1-8714087118b8@sigxcpu.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251020-shift6mq-dt-v1-1-8714087118b8@sigxcpu.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iuez8ylurglxzf2nsUt4RdebbXeP3X0J
X-Proofpoint-ORIG-GUID: iuez8ylurglxzf2nsUt4RdebbXeP3X0J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX/O/vKGCkvNfl
 Iqx4l5ifyoteQV2IsMo0KvVftK18Rraj74M6+cXALcyAN/Q3oHr+edY0eOPiNr9lJlrwD9+lA+w
 ZYGKSfINQpY9H7bqcK6gGupw2J8gYc/6lH+DFhV92Y8ymGWwwYgaiR3YZM8AVJ1A/nf0DOqhVbt
 e5e4bdDXyxxy2rPz6Mx9lBet0x+UhGwfV5rhCcP0L/kStAeB6X8STO4pRA3etkpW8OG4fSUj5PO
 6O61AFL2t+i1wxGy5gOmYed7hTWIO/rvQc1Z3TzqVu811k2M3mQ3ZuYkDW9DTHqauFng8IOYbZF
 R8HtENByevWeXnW9TRiE0Ag+OEPBwk3sCqpDPn3BGhtJjTbh2qtxyBSEFJltyJ5xmo/IzyzFd6B
 lDmbEhy5yX2SJROFwJ/yLcYmrtr5iA==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68f60c05 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ze386MxoAAAA:8 a=_PUjjehnJBWPTTrYcrMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=iBZjaW-pnkserzjvUTHh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

On 10/20/25 9:55 AM, Guido Günther wrote:
> They're used in the parent to describe the panel's reg property.
> 
> Fixes the
> 
> linux/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dtb: panel@0 (visionox,rm69299-shift): '#address-cells', '#size-cells' do not match any of the regexes: '^pinctrl-[0-9]+$'
> 
> warning.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> index 89260fce6513..44e7b5015d26 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> @@ -472,6 +472,9 @@ &mdss_dsi0 {
>  	status = "okay";
>  	vdda-supply = <&vdda_mipi_dsi0_1p2>;
>  
> +	#address-cells = <1>;
> +	#size-cells = <0>;

These are already defined in sdm845. you can simply delete the lines
below

Konrad

> +
>  	panel@0 {
>  		compatible = "visionox,rm69299-shift";
>  		status = "okay";
> @@ -479,9 +482,6 @@ panel@0 {
>  		vdda-supply = <&vreg_l14a_1p88>;
>  		vdd3p3-supply = <&vreg_l28a_3p0>;
>  
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
>  		reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
>  
>  		pinctrl-names = "default", "sleep";
> 
> ---
> base-commit: f406055cb18c6e299c4a783fc1effeb16be41803
> change-id: 20251019-shift6mq-dt-e4b9e7dc7169
> 
> Best regards,

