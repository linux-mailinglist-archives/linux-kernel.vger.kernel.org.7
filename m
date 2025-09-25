Return-Path: <linux-kernel+bounces-832477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 700A8B9F6BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677C51C20A1C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810C021770A;
	Thu, 25 Sep 2025 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HRed1ArJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723C41B4244
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805657; cv=none; b=V2rm1neisNTzxHNjFSa/c2DuBHsVuLPoUupH1osPElFBMyGIdrQPPOI1QWTGRKhhUC4f3eEM8Fz2ck9bQWWOa3g5OOtJHcE3MnbP0rYtMf1T/w4grRsU5m4bNjsa1eIpcewRczWzlI0qbtKMzmLWHTW1+8JwzYsGsiKl0iqf2nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805657; c=relaxed/simple;
	bh=jvM4Y/vSWLOo/8nu3p9xhzhDJkuYRocYakloDKrO26M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hfne75uM6t5XF+TNFvkdPYqwhK6hZ5QPip51j4X5kmYpTq9tlUctf1tVg9790+wdPZ4uwvMcMhFk6+9zx85BBnxPWx14UPIBpylnX0U82bxsIi47J+55VfAbdlLyV/IJoHBSUDjjlBl9SJcCY9Unfk1yvWFkAW0/pkpng2TLyak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HRed1ArJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9Rcxl024042
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R2ug5vCmu4WsfGi1U6sbqHkqRHEzdXssT8nz/lt+jpw=; b=HRed1ArJhNkRJsbL
	VxOFnbOJ9YF7U6JMyKcVxwd/zLBGGhxL09Sj9mO4s6J4yRDy+dKxiP8Jv/gjvvNR
	NxRaARHHRZiU/dK5QeDDpXg7DYJR56qcAdMgwf1breqxhk6u/qsJ5WTYN9sjQ8VX
	jdw9TZfXuBOAL3DvNRrskzrbO0TDR9YQarXl2T6JS178Tq4feWbg1ClxCjpXPro0
	YCq82tkrnmBgAw35E8UfqC0dqQNTcrzngVh6oP6PeUlj3heZ8QfHznHQjCdU8nl0
	xiwvjsZ3J6p7l7phSkb25cJb02fCS0OT1BvX4wtM1Tc88M4D0slmqsLAIY3Qr11o
	t4yd6w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0f6hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:07:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b77ed74e90so857621cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758805654; x=1759410454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R2ug5vCmu4WsfGi1U6sbqHkqRHEzdXssT8nz/lt+jpw=;
        b=Brm0D9xMBZZYKlS3xJW/HexBe9/yVI/U0NXeybZ3H4HJMZgYmUTxQ2g4/i5IARR+IL
         Bp1tlsuvj/UOgIwhQHIU3zGVSuA9pXmYp3D5vvx8x64NxDhq1FTKJyyjbpANYNtGDcem
         iECRetGlDF9RQc0yOSLAmNVRFDWAadXROA44rg0xpdSyTgTVbjNm8MJgSCKzskBSODkX
         icf+rnQnDceNbtb591neawhF4Qc1UYXAgG09GIJ/izMi3N+MWXOyZ6YKwhFHcPhpdhns
         +P0yeRtIGThx4bApk52C4R2dHkcgASw1hfmHWU7KBXaIKDFufCMDaxvxo3Qghyjj8sDf
         2JEw==
X-Forwarded-Encrypted: i=1; AJvYcCWMGLjSPXb3OimQ44W9UBBPtjh9j8eNjuLYf0KZiDrSL0n7V2BVsRcGDALxPRqh610N1TlqV3NncHr3+k0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1YhCcTjn6ZGkysDJdJSoOOd0OxQ/qKhCDqh2P9VNJ4+zYSJGI
	ZOodJJt+exMgFW3Zmmrr9O8bHmaAdBm5WMBh3TUONO13HVanfLdLVAiug81v4CS/rjvLaIOam6G
	z1oqrc6639GWsDOQ1sNY3M61cYrHor0QbIu0dmHVf0dAQsz9rqCwFracXm/6Avq7o6HaVJW69KI
	c=
X-Gm-Gg: ASbGncvYwpj4QDhNz+Ho7gEHA8HXgdtg7+RdS/luhjnp/9KEspkA/A2KXudPyvHtuCD
	qt0wk7DiIWQhJAAlzq4m0NiV0HWti+ppQaMmBxwzdLn5TEnfIHGB2ujDDp2ZMgTaYhaajmEd8Xe
	ypGMdW93muXgMXz7yLP1WpGUah6X7TWONXKrLiSqPzjp/BsVa2hSZqMiCFVdnffXOMTMT6vI5K5
	5DH0/GadCrHv9J+UcwKTt5BMwfJGuNg+2ylmaeiWSBRjXpw3h85z8/H6flNr+bLv5AOohmkmIHB
	GuIl7QTLa1kyirnhIHaamKjQlUtlcthWgKHeG9Cfi+p+hFxl260bdCYnsYMVvndOmeS84LJ5oC0
	bNivmKPPfXVJxolsj1AW4FQ==
X-Received: by 2002:a05:622a:1493:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4da4962b8c5mr28928121cf.7.1758805654049;
        Thu, 25 Sep 2025 06:07:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM/vHHsLiUN5+SkGsloYe2vX3oyOnlbGp28c4efv0ng3OalcK4Chwb/k5D3p9QMYk86mlSnA==
X-Received: by 2002:a05:622a:1493:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4da4962b8c5mr28927661cf.7.1758805653358;
        Thu, 25 Sep 2025 06:07:33 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3650969sm1186569a12.19.2025.09.25.06.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 06:07:32 -0700 (PDT)
Message-ID: <f032db60-d625-4814-a5c9-0610618b7351@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 15:07:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: r0q: enable ufs storage
To: =?UTF-8?Q?Eric_Gon=C3=A7alves?= <ghatto404@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250920014637.38175-1-ghatto404@gmail.com>
 <20250920014637.38175-6-ghatto404@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250920014637.38175-6-ghatto404@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d53e97 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=7eSFts1GM3vNJhxzD_4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 5d3Pd8eFGV3pLiMASQobLf07DzisiqfJ
X-Proofpoint-ORIG-GUID: 5d3Pd8eFGV3pLiMASQobLf07DzisiqfJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX0AmlnSUiLkOO
 aqH5vcW3Cys02sgRfqKk996qy+V//P2tShEffAFd27YWySpJDomV7B82xEizB3HZUKSrXRAz0I6
 cUIKSlx9RxvZefBlOaaMXNrIuSX7LXa1Nx7T4aTLeEAJKMYROLSCVzpGDyDpFq+0GURgzugQJ6u
 GNmoO4LxaP606Q4Np+cVB1G7SlDAVYJoRS95sY13DbiR82/lJ2V2vIjiqiqmn7Pon1y/K7690Vm
 0NVRB95SOVuBlZelWz3NRcBp88dMlIhiniN9GripkxZuoJFXvI562/OKOoje+dM2B1P4sCJtlFX
 eegGb0cDTsNb3EOIWOYfgU3G4y+E5O8Xv95m/s0uHO9LwI4IC5svZ6tqRodi33EsaHZjzkrQfR7
 hEvr6Dbi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

On 9/20/25 3:46 AM, Eric Gonçalves wrote:
> Enable UFS internal storage of the Samsung Galaxy S22.
> 
> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> ---
>  .../boot/dts/qcom/sm8450-samsung-r0q.dts      | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
> index c088f1acf6ea..0a55ce952f93 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
> @@ -146,6 +146,24 @@ vreg_l5b_0p88: ldo5 {
>  			regulator-max-microvolt = <888000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
> +
> +		vreg_l6b_1p2: ldo6 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7b_2p5: ldo7 {
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <2504000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l9b_1p2: ldo9 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
>  	};
>  
>  	regulators-1 {
> @@ -370,6 +388,27 @@ tsp_int_sleep: tsp_int_sleep_state {
>  	};
>  };
>  
> +&ufs_mem_hc {
> +	reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
> +
> +	vcc-supply = <&vreg_l7b_2p5>;
> +	vcc-max-microamp = <1100000>;

because you set this, you should also set regulator-allow-set-mode and
regulator-allowed-modes

Konrad

