Return-Path: <linux-kernel+bounces-832327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 056A7B9EED6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F0319C86C4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D509C2FB96C;
	Thu, 25 Sep 2025 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E8dPJk+i"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A149E2FB60D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758800064; cv=none; b=d3b5tcdXa9zgMpLeBJM8W9m3q+TCioeTai2xiJJWx9v46K1DFn42mOXJQPEEoE8jiWHe6PfWxdWhIDahxCDvxkiafi0g3dV77i6db3bI+CQMF9qJqzjIt16mwgJGkItdiJJmZ/RRZ/W5X+LXYSat7B1DpTkW89jVumqdUYAr6z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758800064; c=relaxed/simple;
	bh=uDSyOXioUNXrVHKoWkU3M5PSfkV+fJscxsqHyZjxwNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hI5dTZeEZFhyGTnzGQlfdcgz4J3BjtdR0/bFxv1zSjnSC2IxgKBtZAYUJiyBmEXcduzlK6g2wYHk+4WgNsdxT3hmtTf8Y5PE9IogfrXm9u+p3kYJQO2EEtwnokGLKT4GJu7ggpYJP1iXPvPUbE8bh0EPwg+nD8iDAPe0ZkrBN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E8dPJk+i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9gCn8002400
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gEwEMKDS+tlZfd8LuFMgAeA19bLeCZC6NzU3JUxIlKg=; b=E8dPJk+iG9ffeHiY
	uB0MubF9/2rpXjY95B/qpQYxCV1E8PHpkZcxpN87K6MSHodo8TUvOER3DJdSNGQ9
	8rtrf/Cm9e9iriLxGObnbS/MlM/o0nt2EbrPJBb7CIhKJlKk09bKFP3GAn2zAhOr
	m+LB3UJWtKswveqGH4aLa/dofUV003VPE48r2LsdUQPvjGv6TxgKcgbPMeJn2qzc
	aZNS2Ybrj62YxNe2aaojFZzqOompba1Y/7jfNO5XxyfxMfLzoTm/mK9fsCX73ezg
	JLKHAUszP1eS2mRhMaHOpiwxrfaMM16wg6XClJv/jz4pwXF9aFj6rMl9fGaeJiOy
	H2KUtA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98qvt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:34:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-85db8cb38ccso8389685a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758800061; x=1759404861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEwEMKDS+tlZfd8LuFMgAeA19bLeCZC6NzU3JUxIlKg=;
        b=qWpKot6I4J6rQm74rDrna+KASfk1ooXWB/JmNdpBRW/xUQwL3y5jQkA+uRBIVW7sC7
         0YfvunGenA6/+wfDYcFfGoZe/+7J3BIv7OrrjtJIupNjZW7QV/1LI5+fOdQ8fbR8pNRJ
         Lw4Nof48A2R6IgEhlpU5o4xFHsMbtaywspTabJaqctIEoJEc8fyEZkASyJKqDhz1GLvw
         X2UAEGrSQSHWDreadkhyTPRZ0GydmDFwNf7PnbvV9qm+yaGPptAXytMNYYazpInxa2WJ
         L8GfbdMmykymDJs9teJhj91dYkE417BtvQ3a2oT6+Um3aaqUgKzF63rNIJkglISw2jeZ
         O1Gw==
X-Forwarded-Encrypted: i=1; AJvYcCV3Dr6knZZ2J7Ts+QqlddyVm7y6qGtuT5ksLP1sACK3BsExgaqN+7q8njn21HvyqCk/RdTfZYaws44vgqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQnY/hJuu2+TuRESAZ0RINbb7irSw3KUdWA+2Pasp02C/55QR+
	NUVs/pBKeF8j5YsFvwQHkzX+6eApLWnucJyZnapgcvueGKRJiquOjPbY+HHcmtr6EtJx5fxNDBr
	/j+0O153F/zWhrkuVaNtoImbEYwELygWJ4OAZd7osnKB7VGq7Qpy8MzE7OsZFHOqR5wY=
X-Gm-Gg: ASbGncvM2lJF9VbB8Kcx6lE/iOI9EEWQmKJ9c4YhOUN3UZP3d9H7elC5xex4fj+4966
	WyWF4y2K2w/6H0dPY1n8IJVOf5NkbBGw05pa9BrpEaZFOiITr8NcG2DQDI8HDYxwUOwPeiLLdx/
	vt8Hzr+7UxqY5h82Jhi5gbfMklUaUlqiBu8DRchWcInzjw8ZILWgA/U1yWH8IYJZyb9oKC0pGZr
	vDUu+MyHoJDSV0LSq6QmUw/XqJTV557CDMzhtDOmhoe1CNtJPZ8ulNzd5KbRUyotpocaowzUaZi
	NNoDuchw1FJdLFE/iEZs9xphVIZwnIGPQHh4X1FvmL//IgJHraDmBM5aMm9AvFfeI0fso6hI991
	yjlEXIW6f9v0h5jntd37BAA==
X-Received: by 2002:a05:622a:548:b0:4b5:a0fb:59a4 with SMTP id d75a77b69052e-4da4744b7b9mr26621391cf.1.1758800060605;
        Thu, 25 Sep 2025 04:34:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGtQWMIoQQ6aETO+R7z7npnqU2rOsUkYDHw1hbcP6FnknthNsw/qlBhpSdOZVdY3LZkHF65Q==
X-Received: by 2002:a05:622a:548:b0:4b5:a0fb:59a4 with SMTP id d75a77b69052e-4da4744b7b9mr26621011cf.1.1758800060052;
        Thu, 25 Sep 2025 04:34:20 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353fa65a6dsm150055966b.46.2025.09.25.04.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 04:34:19 -0700 (PDT)
Message-ID: <0dd6a528-d204-4073-a4b6-76356e71c5fc@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 13:34:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: lemans: pmic: enable rtc
To: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
References: <20250925-add-rtc-for-lemans-v1-1-17fc56451c84@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-add-rtc-for-lemans-v1-1-17fc56451c84@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: aKN93ApF4vgcKP-VHOp8N2XJn07jb85j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX6uKYnhmAyWsA
 EkIwIoRe/Yw5PNe3FIqdq9i0t9eKDbX3Gfn1xV1CJy2+SADnxQDypoyg3651s71IFd8Kp+YC8zO
 Pguc2ourU9xH5Wq9bycf99OgkUpKFHJ5bnp6xbJBewOvGuLLNlMOWJOCiT6dEvIY2wMtOWAZhzM
 //aKMmHa8dG5j+N7/kkt7M+VCshdNFk8mKmPedYbacw6R8UDOsUpaEOwTFeUeXnmnIdXPlTORSq
 4U8CNtEkgGucdXTjFZp0hhY/JMxUpynW+ers8MQz2PHaCrYmIcnba6iOSqHWHjGqVd1Q7ylTw0e
 XzfnOnvUuPBP0PU1xL2n8bcEVyhgL4Dfv9dOpiKhzlr3Km4NVgeduLSZSwZ+8DovPsWzmJ4ZPVd
 nHKsTnPu
X-Proofpoint-ORIG-GUID: aKN93ApF4vgcKP-VHOp8N2XJn07jb85j
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d528bd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=4CTuLwWeLA73sPtru90A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

On 9/25/25 9:48 AM, Tingguo Cheng wrote:
> Add RTC node, the RTC is controlled by PMIC device via spmi bus.

subject: "arm64: dts: qcom: lemans-pmics: foo"

(following the style for the directory)
> 
> Signed-off-by: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-pmics.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi b/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi
> index 1369c3d43f866de9d8cd5cd4985241b99c0a0454..9e0d05c1b39ce229d5d4310ea1df1bf02e689178 100644
> --- a/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi
> @@ -132,6 +132,13 @@ pmm8654au_0_pon_resin: resin {
>  			};
>  		};
>  
> +		pmm8654au_0_rtc: rtc@6100 {
> +			compatible = "qcom,pmk8350-rtc";
> +			reg = <0x6100>, <0x6200>;
> +			reg-names = "rtc", "alarm";

1 reg and name a line, please

> +			interrupts = <0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;

Do we not need "qcom,no-alarm" on lemans?

Konrad

