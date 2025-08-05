Return-Path: <linux-kernel+bounces-756473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 819D5B1B4CF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D21F1883CE5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA148274B31;
	Tue,  5 Aug 2025 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SUOyD6o9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973961E1E16
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754400173; cv=none; b=ZZzmkFrT0NrQc0bjbegGjjzmua8oqn8AjQyRlZY8l/ygM8gbcbZ7i90GUGBVD/Pgnn56VJtC8UZY6f2teoGlbKFE1dyx+m4i9VLGkQ/G/gjaEHOjHvqfC5zs3TDzvcC2Gzt8TT5cew7dMtlzFoXyexXixE5wk3kJdHe80PESVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754400173; c=relaxed/simple;
	bh=vM69YlZ1vil1Kc6o0Mk0jcGWkrgMRscriQoGPfFNdic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlvqOlIjgFrP/Ehs/hWFRXd69Jhaf8Ciqc7FwLR85rvQmzuTcEhNFZOGVFEwA3ZaMJEsTMFWQ2nKsdaURwUU8VIX2iv1wbcCeWV+hfQlueFAxmhTEQTnJqsZrm372l0qXPpE0gWXN8byCyoT2hbFlf9UlYgWLAPDAVbb5GEbuJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SUOyD6o9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5757FTd3003583
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 13:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	szCBzR4GviCnbp8YCyWuodHs17KNEjfZFGcMBSEkhp4=; b=SUOyD6o9vp0ATFRw
	+BcD3UNJgebeKKlDmEfwtUF9XNGt9eeZQ72fzTPdrIZ6EnBrsiMqW6JQuIZ/QuRN
	xkCEdSTm43qqzkbwgcgNl/IcnFsyQ+FYNGt48catnX5w2g6K1aHX2+z2w3lqD4lB
	CUtzLNmHKciOXyFUa73mTeV/FlIfZOkEjC6nZzXnq5yOSaxyttljkUYALMswg9AY
	wTLYW/vcbIvrubEm+hzOn07YLH2jYYHMK03jITDbJrvqty4St/FsLEQg74U8s8R7
	99fQ2YR6uw/wJGxgM4x1CfuoOnL1p457qgP9/k9gFyNhlixb1g38+66mliYPYWQu
	5B5qIw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48b3j3tfvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 13:22:50 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e7f8e1dfd3so43741385a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754400169; x=1755004969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=szCBzR4GviCnbp8YCyWuodHs17KNEjfZFGcMBSEkhp4=;
        b=qElIsuRvVYfBvKVbWhhvpY2P/4vqAVvvwbkyVHqcJYGj4FvnbudRvmYwqtP5oCy++A
         kswVflJ0jZ+587+9LIrgj98FOHHQAFtpiT1/bq/IztUxDIWUED6srPI3yrUbQE9Ay2dv
         u6flaEROZ5auaP3rCs/wHm7rhp9Y+UMgLTj5J1fKcIZuvG5zPNjVu9PGOk/SMjckMYQI
         VAL3H2H3XFXB10Eon12dwlD5VjXoSprlY89Ymtje6ey+jheYFX8Wl5L40OuQ7dLrLQ6q
         fV940SFn4pfk3ybcSELFJd1VFK6+dWjZhs/cvXP2tRZGMjydJLRIBOYdhftHs5JS4f7e
         oXxA==
X-Forwarded-Encrypted: i=1; AJvYcCU+j3blzZlIRq9bJoL85fQxBoKZZkT6W92KjjCiiWj6ltjAuFF4bY6HqK8jA0WJQ/rfW1+Be+7k3yiCRls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx35rEJRG8rPrKHKbDwhbOpUgJGAHi2JZIK7qpiLKLIL4WBfkG2
	RR+GhCh9DfCdmgwYYhM4Ds02G8BXLPFX4duN6EDyoSN6Tqp9thkQu7wGlQes32xzkoNyxJFqEL2
	W7zWxFF3vMa9AznzRNx2zPF5iB9m8Dx8ncxzkEtuZckppBoLNuTTu5qKbCtg8y5PzYFM=
X-Gm-Gg: ASbGncu9iaC68n7GQXkwcFr5tZYe9yMJDx70NImiMHp2T7s9WSpvYMZMlDyaoeEDFMy
	gvTbA1Tzancb40nyh+S7SXEYWbUyafBHu4D8nVKo+8EBLv+YDOGNk+f5XwtPcqz1aYczckf7Tux
	U4QwsVr6zPoUtUihwVK5WYRrUKzmmfWYUlWxsU31x5kZtztZ23nansUdrbsvh21UgdW97e2Ig9Z
	24fu9BMZGurnBgccPloFMF31iewqNEnneXVEGSa2qtQUcypIk8IEmdV/g6wTo/s27LH4a5hKzo2
	y6T6zmChqahdtbOtC7EbNw8CxHKE8l6XijGvTYVwZkDBniPRYrg5byxJbsdQbcIlUTZXDvdY3s/
	RfdDLlJINj33wP1bTAg==
X-Received: by 2002:a05:620a:404f:b0:7c0:b3cd:9be0 with SMTP id af79cd13be357-7e696346fefmr816816185a.10.1754400169167;
        Tue, 05 Aug 2025 06:22:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFXEmIee6IbP26kuAnbrZ1NnF5HlWu3jLRuHodegxh1SfCqr3ws+7CGE6x21Dl6JbNvMNXMw==
X-Received: by 2002:a05:620a:404f:b0:7c0:b3cd:9be0 with SMTP id af79cd13be357-7e696346fefmr816813585a.10.1754400168652;
        Tue, 05 Aug 2025 06:22:48 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c099sm892748566b.108.2025.08.05.06.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 06:22:47 -0700 (PDT)
Message-ID: <95959a89-655b-4ac9-86ba-d8d943809b6b@oss.qualcomm.com>
Date: Tue, 5 Aug 2025 15:22:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: ipq5424: Add reserved memory for TF-A
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vignesh Viswanathan <quic_viswanat@quicinc.com>
References: <20250624-atf-reserved-mem-v1-1-43b1940e2853@oss.qualcomm.com>
 <0826de9f-0125-44d9-84cd-1c52ba199a4a@oss.qualcomm.com>
 <7d641576-7ec7-46f2-ad53-e0b8b36351d1@oss.qualcomm.com>
 <64febbd6-abca-4ab2-abe9-93812bc115cb@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <64febbd6-abca-4ab2-abe9-93812bc115cb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BTecSN2neSFIdeLWibG3msrSQOnNP_zV
X-Authority-Analysis: v=2.4 cv=TZ+WtQQh c=1 sm=1 tr=0 ts=689205aa cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=ZhiXV8X_0r9cGbBKTBIA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA5NiBTYWx0ZWRfXxuDOr3sqH4kC
 jZ6iK3jJ85kh5yrQ3grwQ4ELf4lh5+tta++VFVjgPNYw+sWUW1hWGqguXUqrFWX3kfAt8ProF6O
 UoeX9riDlqJsvmQmVw+pKtNK/isKc7BlHvn1kDmHl4ZustgSk9ghOnPK03P0acW8iB7xYVNUuVK
 m965tMJa9MbrA8fVvXFWb/JmsuqiuCj4vuvmkUMuZXD/z3H88y80NMjTSyffoHE5WaPA11HNv8O
 WHKxhSNHty5gxUTlRlvFawN8tdlkMy01LiO/gAWixfharrgoeJHdConEzaoG8TaSqypz8L3J56m
 ha+GsaDXLul1kRPYEfDmkHdfShdz6UyErvw7EgJPdw1Lbh0/Fuvtc1yMEOCNTEAnh0jPPjR4prb
 v5S4dEGLZ7WCtu1R1E5j8gaMPJvpxf9kgnPVYZ5S0kbR2FejAQJekRA9NEcSM5m6sFD2XTzD
X-Proofpoint-ORIG-GUID: BTecSN2neSFIdeLWibG3msrSQOnNP_zV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=544
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050096

On 7/23/25 9:04 AM, Kathiravan Thirumoorthy wrote:
> 
> On 6/25/2025 10:20 AM, Kathiravan Thirumoorthy wrote:
>>
>> On 6/24/2025 6:57 PM, Konrad Dybcio wrote:
>>> On 6/24/25 12:36 PM, Kathiravan Thirumoorthy wrote:
>>>> From: Vignesh Viswanathan <quic_viswanat@quicinc.com>
>>>>
>>>> IPQ5424 supports both TZ and TF-A as secure software options and various
>>>> DDR sizes. In most cases, TF-A or TZ is loaded at the same memory
>>>> location, but in the 256MB DDR configuration TF-A is loaded at a different
>>>> region.
>>>>
>>>> So, add the reserved memory node for TF-A and keep it disabled by default.
>>>> During bootup, U-Boot will detect which secure software is running and
>>>> enable or disable the node accordingly.
>>>>
>>>> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
>>>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>>>> ---
>>> Can the said u-boot simply dynamically add the reservation then?
>>
>> Yeah it could have been done in U-Boot itself but it wasn't. 256MB DDR configuration solution is already shipped out and the stock U-Boot enable this node to avoid the random issues.
> 
> 
> Konrad, Do you have any further comments on this?

I really don't like it, but fine, I won't be blocking this either..

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Please make sure that the next time around the bootloader reserves
its own memory and doesn't depend on what the OS decides to do

Konrad

