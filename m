Return-Path: <linux-kernel+bounces-832218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D1AB9EACA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDD93AF873
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833FF2EB86D;
	Thu, 25 Sep 2025 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hN8krS+j"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15F2629C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796346; cv=none; b=YBzBj/WS5Wkk7O8RW8PasfsWxYcEdU0csCjK7o4aRabvTY60ly+To0qk7R2FClMoCXEcViLwX70zDyjTlkj4x1ER9fFVMMmJg3Es07iBaAoVFGWg2839DO5bjOJImDFSKXYiNNj3CtxDiYyq0UidjMY3S6C7HFpBfZhwaAN/uZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796346; c=relaxed/simple;
	bh=HQTOdtr+qdx/m72wmgNGbMLdeMwcxfr4c+KhH4Yq9Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsxyaEgrW1uKccdIHg9bFeqSnyA9+36Sag133/H1zcHeVSu8puYEtO+HfnWtGRzVTdoefZkos0xLCniHiL4lbuN1arAnFZ6nI7GFxlRt0lQSeKk69M7P0dh2rBdGLw3+J62k/RFTI1i6QmFH7Dh/wbfbaWS5FVHXgKGoKqqxTA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hN8krS+j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9RtK2025283
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V9EPLkOHQ+nW8B50CQSYf+2qcs/EKYauVlPSbGFcsJ0=; b=hN8krS+j6Q6It3fX
	2yBlB5BwVf0ue8wDEyBE1q13UwrQwf5fixN+AIrnFi3jR5oJCsKp2Cn1UR2ePKYU
	1y/+Q4UNWBT/md9GCbeUFzMZhznD4CNLfs6+UFDeiTpdHL5DCPaRBWr4VsrmFh5N
	a6zCRLJVuDu4NbBntQMWGoCe5h0eDLgJGy402nf+X7Nd89UEWqguXMe5wpLZfySJ
	D24bx6DvlOxC6Te6ghZ+NbEhTr7e0UpukYPnFvO3UX6OjCh7UpCKmDHMct0mIXyv
	r1q+ec+8lFNOZcIQLDvITiiWj+l1qrr/UcdupO5Eo0FhBEjumAfKg18HTxIp1UFa
	OGF8jQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyf032c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:32:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-85e95d986e2so1523885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758796343; x=1759401143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9EPLkOHQ+nW8B50CQSYf+2qcs/EKYauVlPSbGFcsJ0=;
        b=OS3clwprecqGzVHTncSRxBLBSxooVWkWlmqv/zDj7RY9NEDvKUGE0nuWWNme0zUMZM
         dK76GtYMwYUGeFclUKiGGlOhIMiVyNz13JZXtF3UjhZcb0BaqNzjVCxl5SsUoLQ5g9m9
         t6B9ulr2wQJ7earkWPI4MAHqaSS97vDsVp9zV1NpXWeZMT9rmnYG7tRxXq7H3gBbzkvs
         jUGUeuGzDz90YwtoB724b11PevDGcCvpBaQ6ayO0Q8NQxA/5vwMODcoSbtsNexPDRS9t
         rFmTtafjq8OpHa9XhsSH5uhnatj3VaA1ylsX60aH2HeShdAEjHtuJSrm6YVPpdIDA5FP
         51mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpv8TkMODUvXgjD7iCcZkqqOnByokqg9xfE7FcYDh6Lr/h5Tzw+/IY2mfiIGGvvmmGah1qdsGOWb4zjOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbPBE1byuPWChtSinuopBChgywMuInsbD8zGtolAPdkHHuv99X
	egiej8JjyLSNnbe0/I6RkkyhtB2iGPVJfoZhuqkzeXe54bhRZTViMcOzWlMkLfPhrKDz26XTiSD
	TaSRc4vZ5Qje9r28vEshTHZPJpx1C86LesCAbsPjvC14fALUUHEUtWa8y/QAEYC9mBt0=
X-Gm-Gg: ASbGnctjzs/+F5VoTnczdGyxUq6hB6UbPTUMrjmVwOqoJ58idrUwwVsG/QVXNfOr1RV
	mv7Cgto4tWx2CQKZCzQZ5r4rG0LBkAau4mvK3kNaGhS65W5ceEsQAsTM45JW5BMntQ25Y4byy1C
	2BBs1BmWpkMVNdhf6N4WOp9C9QJMR4zebHrCwOmgc+VJDVq33Cgpn6P3/u4dRvLdUU9cZlI50hl
	7PvO2+jAiIzhDynAeFQLKzCDym4drLSx1dZF4/h3ynbU4jDeEItSVSquIwNwVNHIH97wja/Csva
	xYT1+BRC1JkQD1xwJmz19MvtDI7utRyLxOXh6G265RprPixsINu7q5vSamunrX240t5xxfUQiB7
	yp68wjxPRHwXYeafInC9cWw==
X-Received: by 2002:a05:620a:468e:b0:850:75d6:3da8 with SMTP id af79cd13be357-85ae8d1be1fmr217526685a.10.1758796343230;
        Thu, 25 Sep 2025 03:32:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrfUlNU55bcz4nXz0i0xu/T6mVDI/gqlomCgirM5MRBRQq4GVnXDHqldtsjAxpYhpAFaGLdg==
X-Received: by 2002:a05:620a:468e:b0:850:75d6:3da8 with SMTP id af79cd13be357-85ae8d1be1fmr217524285a.10.1758796342683;
        Thu, 25 Sep 2025 03:32:22 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f7506sm136913966b.52.2025.09.25.03.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:32:22 -0700 (PDT)
Message-ID: <09b2ee28-ee2b-46a8-b273-110fb0b4d8a7@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:32:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/24] arm64: dts: qcom: glymur: Add PMIC glink node
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-18-24b601bbecc0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-18-24b601bbecc0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 72CyBQpppZBMCOeMaQiOK6A8j8uF0RJZ
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d51a38 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=XhRRIRvm7l31mynVaKEA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX7PxMGjafQTfe
 qEyBJA3WHpl42VxNOi3OdeHYg3IdfL62M+7kDgIKn6t0sl9jIUOkR/vQsBwCsHxzeMUBHEhvTSs
 bJciq1ZTwnvQN9pIDVQL+6wJCJpTiNpuHb1JXRsSNQPjZm4+Xka2RbXZ8rFDx7I4Oq1wp6s8oO/
 Evi1ekjAw2NvP7SlWtpJAGxxKhHXyh+J2hUBGXKHF5XcFgT4d0xlZRgMzjPJb5jPvZE/iFvA7Ge
 i3bjwjhvAAh+1d9xCzdezzUJsF8UROpf4/5gD27CXW+V8/es/kmPo+xqC9xc+xNrGYg2osR+Olq
 OswzIgOdeb/jBOAE4kkIWW4MJOSPeprPbIsoCyj8U0HXyQHWD/7SsxAt8PntjBGpuEgFaBUQam5
 0O8YoGhS
X-Proofpoint-ORIG-GUID: 72CyBQpppZBMCOeMaQiOK6A8j8uF0RJZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

On 9/25/25 8:32 AM, Pankaj Patil wrote:
> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> 
> Add the pmic glink node with connectors.
> 
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur-crd.dts | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> index b04c0ed28468620673237fffb4013adacc7ef7ba..3f94bdf8b3ccfdff182005d67b8b3f84f956a430 100644
> --- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> @@ -79,6 +79,34 @@ key-volume-up {
>  			wakeup-source;
>  		};
>  	};
> +
> +	pmic-glink {
> +		compatible = "qcom,sm8550-pmic-glink",

You *must* include a glymur compatible

> +			     "qcom,pmic-glink";

Are you sure this is still compatible with 8550 after this
series landed?

https://lore.kernel.org/linux-arm-msm/20250917-qcom_battmgr_update-v5-0-270ade9ffe13@oss.qualcomm.com/

Konrad

