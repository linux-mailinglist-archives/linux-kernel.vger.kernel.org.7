Return-Path: <linux-kernel+bounces-844318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8051ABC18D5
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DDD3E06B9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDDF2DF150;
	Tue,  7 Oct 2025 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TQhY+riM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25BB2E175F
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844676; cv=none; b=Z2xBCw8exUa+uhblMXpbTqyiny05lTlbOCl12XwxNJMiosK1fld+QwzbrmdEz7ysVOKucvooqY3mxWLjJaUX4OAjkymxHWassC0CPuEecNKvC/WtKW0wJ5D769W8MTCVPaiG0YIEQxL7iRN6duVVWe6k47qZRlh7nIy9N1ohGic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844676; c=relaxed/simple;
	bh=RzC5tectGEIyc8XxwlPTI5vbHB+9S4bqXZf7cveYE/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PyOhU16q1RtkU79+tTMilwr5NFAMhrI5Di9LOlZcUGx0A70TPvO1yPIUmygYC3GQYCS8T2C+U2KcZUDW3Iac4ChltEx87UIvcHSx/R8nnrsiVdjxpZmWYyT9QO6ItNgNNFMXl/r6Skhj9MrFX8Kaq3WWtN/57MhQnfQr06H2Y+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TQhY+riM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597CRQR9022432
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 13:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1JMHoyMsE7HxNwaf3O4ncQVvQFojmL8uHi3mQasDHEY=; b=TQhY+riM3+3DtFvH
	nsog7XPbnYl0EE7YDsSEsARjskw+WJYDIzLEy4NKY/Hsp7jt0eLC5nr6A5jWkyQq
	8zwQRlXJfTdX2+0nBdCAT3COSC8WGwcwdL4+onnATRAcpThkWAG1w4ZDpqMAB6kH
	6Vtj3EjKE31zSuZWI7SAtCi0LVVqWOA84ZQsS4dlgZ1KKBxAjMimb6K8VFPCqR3i
	LEemf1J0nt3l7h5TEhS/wh7lPcHnbA/ILq/xovfIInMU7FvFrdTNX2G6roVlhqoA
	zjEl7DJddkJl8CePyS2hnNnRSGfOoTTuvN3y2SfKlPEDcZk/VyxO3qIEpQ6UhF8p
	wQmJ8A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvv7q889-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 13:44:33 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7f5798303b3so15172636d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759844672; x=1760449472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JMHoyMsE7HxNwaf3O4ncQVvQFojmL8uHi3mQasDHEY=;
        b=ar0IqUoZd44s57bDeH4wmB1Bu0Ik+J6vBbieJncjx5EjCK7X/Y5Pk2vkS0/axj22Ym
         GSxNJKQEguFhcg+KZ5Q2HHmsAfUL7cY/nDN2gi4LFKBqhdhYE3kX6Vh8OIeQzBx5XEiK
         FPYB3FScwJWJTzygtC8bLEQZorU5Nk93hXEvS+u2PoLil/0C+dIyFTMQYynCP1X3J6a4
         KWUsQBtB1rLPV8FU8XEupSZW9ELZvBdTpmgex/076QSFm+tUyApSH4kNYuDpShiSB/jn
         oM16hCvWTx1RlAZQvvxCkb1UchSMvUIVtt2YzGeEwqBcc1VT0dRAXsSWtX6IzLilmjK3
         msaw==
X-Forwarded-Encrypted: i=1; AJvYcCUPB0QI0xG0MBsAHW+B24Op7Lm2QyfXApT5lAya+Czh0JH7oS2Fknsff0iiPgFz/uGdNJ8FpKtO9gwKKT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDYaDVwwY6oevA2sZaa4ImbAmKFCKy3l/rWDVE70+aqDNFb4td
	OcQOtdEJBoNv6VkYegwEgcDjtre0PJuVNPWKr5hO97x9GEH4P8WBRYrGL2MJY+9vPR661HjGw6O
	F9N5vboj7WaplRogYf835wb+7Tzl+j6nXHsjNxGkS82bcwTiCftp5yXzt8yDsZoNT1Zg=
X-Gm-Gg: ASbGncuzLtom5FY45Z9OpRBY+gBBTDvh7UKBf8nQ7ogfpQtQVEfRLLLiSNVjdwcScrp
	82qLHZUW97TSVO1bsPNnmIguMjbl/4+C7ynpO09MqJeCODo7HMXRvU705xQswR4TstFN0x0gSnh
	TGQXsmPUodbdIL2pxsTIXX0eQPeSrC9lLHEL8/ofySSKhwwmW+THrPcHTLMu5Fyg8CkHhd6Fble
	EC8BqN8gFvlAYFHl2hcfDQJOZ4684hzvQckLJZwHAvgIo+5/VE43GwBtTQaRlrcLMzvdil0DNTb
	2Cv0vw06H4QF4NDvO094TfdalMUZb9CIxlWSrn2huL1J+OsiVnE4fWdfl9PcbDH66zKy05KhQKq
	oMuhDKaqZp0MvmiM9cCzEh9bR4YU=
X-Received: by 2002:a05:622a:20c:b0:4b7:94af:2998 with SMTP id d75a77b69052e-4e576a81e8emr140344171cf.6.1759844672306;
        Tue, 07 Oct 2025 06:44:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrrZPf0l8ij/9YleMlzi9UQn/coW3h1uLIhDGnK4sj9h9CmyHm2gOyOc7btpiEJZzuV7ogqw==
X-Received: by 2002:a05:622a:20c:b0:4b7:94af:2998 with SMTP id d75a77b69052e-4e576a81e8emr140343811cf.6.1759844671680;
        Tue, 07 Oct 2025 06:44:31 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6394ba637fasm10117255a12.33.2025.10.07.06.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 06:44:31 -0700 (PDT)
Message-ID: <0e6ec1d8-a823-4e17-8efe-27e2b22b5081@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 15:44:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] soc: qcom: llcc-qcom: Add support for Kaanapali
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
References: <20250924-knp-llcc-v1-0-ae6a016e5138@oss.qualcomm.com>
 <20250924-knp-llcc-v1-2-ae6a016e5138@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250924-knp-llcc-v1-2-ae6a016e5138@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNyBTYWx0ZWRfX+PHYVJj8H3Ju
 QTPmHIuGqpCvLB3eQ1XrKFqPn8xFabQfAUuUYTo23amr34egvqJr/VMMH4WsjMsa6xE5Pe6pQ7Q
 MlFhdayorFoRiYCYmPORa3Pg3ZAhMzRhd7UfahFFzg9V3ioSsm1ZN8vKmW8oV7SuxUAW6LdQx4Z
 u06j1tad3i6eZzuStL6IaYzFS36gkzXB+9oaKif0RPlYnK4tTDr5TU6+vkqQmGSiGqHj21UwuTQ
 EW2iURCIc+s4OVl8lumcu+Ve4GyMwQYjRU8RN64Fbf6+X08iqMh4FTNZMTPzyPHYoxeQlrWdQJ7
 gLVdKA+e/8t+MQ9mWZZG2kNkPK2wzRB9OG69ebHvz+S1hHcBPvjNpGCPeVGybar4ohyUh+CU1GR
 qcKTVLqfxlEoysuSzyRtBwsY0vbpqQ==
X-Proofpoint-ORIG-GUID: 6bfU_iOdkCYiAAWuuWM5v5d0Dm50mE_t
X-Authority-Analysis: v=2.4 cv=WIdyn3sR c=1 sm=1 tr=0 ts=68e51941 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=9J9bQqhuhIfmgtcBUKkA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: 6bfU_iOdkCYiAAWuuWM5v5d0Dm50mE_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040037

On 9/25/25 1:24 AM, Jingyi Wang wrote:
> Add system cache table and configs for Kaanapali SoC.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---

I spot-checked some of these and it looks alright

[...]

> index 7a69210a250c..0287f9182c4d 100644
> --- a/include/linux/soc/qcom/llcc-qcom.h
> +++ b/include/linux/soc/qcom/llcc-qcom.h
> @@ -74,7 +74,14 @@
>  #define LLCC_CAMSRTIP	 73
>  #define LLCC_CAMRTRF	 74
>  #define LLCC_CAMSRTRF	 75
> +#define LLCC_VIDEO_APV	 83
> +#define LLCC_COMPUTE1	 87
> +#define LLCC_CPUSS_OPP	 88
>  #define LLCC_CPUSSMPAM	 89
> +#define LLCC_CAM_IPE_STROV	 92
> +#define LLCC_CAM_OFE_STROV	 93
> +#define LLCC_CPUSS_HEU	 94
> +#define LLCC_MDM_PNG_FIXED	 100

Can we de-obfuscate these names?

Either way:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

