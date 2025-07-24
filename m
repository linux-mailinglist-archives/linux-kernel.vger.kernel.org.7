Return-Path: <linux-kernel+bounces-744117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3664B1082D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD300178CD9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C8426AA98;
	Thu, 24 Jul 2025 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Blb8Kj50"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6C1269AEE
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354405; cv=none; b=EqZ3eVuvE56rUUpMLmh4s7urhuuongZRHLHhmbb08qRQ6DVU2ultJwO3U31/wXQLHnEeItbvRxZjLBAf3DuO06c4xMQ17Oe5sonZ3w5+mYv9Xjmr+L/B8+zaMniuAa1HT6/QLMacq4EbGNsPoGdD0sJT3NJ+YjYVp5gPqBkGHj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354405; c=relaxed/simple;
	bh=1wZs7rxeWc3sgu57R3Lf1DTsgdty7IOeDXASPHpx6s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6hmxMdADgQ1IAvdOfoHkYB/UoFei5jSHW2cO0IsDHhnLbewxt0j4Xk87sPZmsC3CZv/TQnrqW9owPKK/egudBTgKtI1r4c9m7k+0mpqG5p0pLEyNBfc+dC7XkqKBxsCToV0/m2cZzS5L6B0WZkWViAKtU4+fPWiMGdhWlwlRlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Blb8Kj50; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9SM3x006130
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tfq20BQzBqBOKeqnOoxB+tXfk+WnuVGMzxjMCsnx1/E=; b=Blb8Kj50nMFFi/or
	puTBWO8MOJR6G3bdE47snTXnn/O1LTwcVDZTK9AQ3uFuzsQzGb/hGYUGmK7wT5+Y
	5QpTmltsM3kWBwxdhaR9XmuD8xtL6xRazqRS0ylKQr34ariD6Q+faSWxnZSIucqv
	ekUFP8DF+OsvV97kxlA+mq/4tXwudHTUFMoRGp8NhHKzU0Wvn9UrYjfLdOdllrt8
	sDZz173i2hlkke5iOZl66nb29cp/DYrKuew05kCIujkfJYO9O3ZGUzUjxvYZBZkg
	XkVKTeBKvTuH8tV/wp6P5eR/qWjsQdD3aAhWLg9ljHDyliBF9n9paeeCEqbhQqv2
	UAtOLA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047qgegy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:53:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e62c0f2254so13511485a.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 03:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753354401; x=1753959201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tfq20BQzBqBOKeqnOoxB+tXfk+WnuVGMzxjMCsnx1/E=;
        b=PzqR2GhqweCEiaNPsgDT4cA1eCbYVK1PQX1i07HLIAbuLDvHzArQNU5ugdXRu8R4QE
         1//FRXDTO6uO6678GzwBdhgC6cNOsJGI4yQJ41RigtXauGE101VBK4Mr1HPYjPZvmTKp
         FRuDtHtxioQVLbxYgNbZl1evc0FeWvQC6SZXxrnr6e+jqMylB1p1BHocZl6PtHAo5Qmu
         Ez5+e9X28Fg5souI/E1sVlrKYKci2uezFBdAf/3/7cf5cZmvenLfNyEUzts5ZHkqhfe5
         y5JypflL0FJj+4Mw6wwFhcRw4+Z+IfE8zzVq8PseBznCyJPlTxJfkXHPRPIgE3TFNTcH
         JBaQ==
X-Forwarded-Encrypted: i=1; AJvYcCURRNEpnnD6mTHV+aZQTJUyeUFmdOkDH27Sp0y0uNf+78SwLMabc6uPyJ0VJ6btLIsl6B5XKnEV0jMpLFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ+lfbfJCiJYPmZuVQ9qXdJMgPsRzJVBVkuTjzZdHjzbBj03md
	oUA02dXGiJgZnXDHj1tCYpBx76w59a7C1IjGs5L1yi93aZNA6choRRaAKQrsqjmkmZKX1PXSCey
	EvryzOB7wgMGjqwSLgiZusgPrppA8iYNfy9bTlsjfE41pU2YiO83ipZ4juU4ELNfy7qI=
X-Gm-Gg: ASbGncueAks5ENSpJoz5q06SZRgRsjE22vNVMnfspnh+t91LvF+KFHjANCMOIW3uz+Z
	klIBS/RA35Ba4F+j2jyF8U/Qzr+oUW/WQjHiWhyHBoijaZepbXcd9acanDkWQHukZ6QonAPuNsF
	OiahKU9137m0A1mE2knF4JAHs46o5DRx1oDuw01VsMa0dKM0NuYOG/EzAmhmniexFtNuUUxhtUL
	Zww5TxrAt2/09KO4h3x1L+R2mrkrHcZI4hi9cWpwX25ejo9Jq0aX/TSJqneW55YVYMUKh3KuD3b
	QEDlkjzGL3MdhsBSQzY4JveM1oI+c1ZAtPENJbIsUsIMettD1kiwAQvoSnYn4MA6jVaUvO/2Qfq
	BVYh9tGxdPJiA3RjzGA==
X-Received: by 2002:a05:620a:9605:b0:7e3:297d:ec32 with SMTP id af79cd13be357-7e62a1cdfebmr291059885a.10.1753354401379;
        Thu, 24 Jul 2025 03:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7qKOYrLpCIrlnTO2mUs/Rb0oINk/80uFDk0zZCUvwLLte3sCMwPuLusZ+uDK6mZO6rgCmgA==
X-Received: by 2002:a05:620a:9605:b0:7e3:297d:ec32 with SMTP id af79cd13be357-7e62a1cdfebmr291058385a.10.1753354400954;
        Thu, 24 Jul 2025 03:53:20 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47ff43385sm95492466b.144.2025.07.24.03.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 03:53:17 -0700 (PDT)
Message-ID: <7d444f4c-fa1f-4436-b93a-f2d2b6d49de2@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 12:53:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: qcom: Add SM8750 GPU clocks
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250723-topic-8750_gpucc-v2-0-56c93b84c390@oss.qualcomm.com>
 <20250723-topic-8750_gpucc-v2-1-56c93b84c390@oss.qualcomm.com>
 <20250724-blazing-therapeutic-python-1e96ca@kuoka>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250724-blazing-therapeutic-python-1e96ca@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA4MSBTYWx0ZWRfX7MBitrDg+yA/
 CFk/S0IVAP0jpSY92aWlc2ZHlrpbijmtoTjWbd0hwcWrPcSAf6esHa1rXkCJsjinrfytlhL7jD7
 Di44I56os46kkgbVB2mVbTGZ3NbPsT0NbkqZmnix29pUGFQVUNDKOKja7cvHsCZB+xbMKrwMOKU
 6mPl6VQL9I3ykgMl0WSTeGIdX45IKl2tcx0o1hEHc5lhdIQdidsRQrcAaXLkd2t6r3Bdy/fofl8
 mBfRjSf0iXBd5183K+vQ+FKlkgUy1gS3YkwS+3OPx2OahAhTDkCcSA6AKKcvez8UuJ8zmJThhqM
 xqp6CFqKmBdJ4IffPK5gLOBuKnUiAWXgF7vRVIzzwG6kb3Z8a33DHw9h0vxAA/3gyVkzfn9HtEy
 nBtb/eXCb1ZHIqtSp22JJbt7JEaQtAXVQlf/wA7WBfakyO88wWv0feaVeV91bGd4RosYoLXJ
X-Proofpoint-ORIG-GUID: Le8xlJp6G0cYtfXhrJ2tMqTPX-mtdsfZ
X-Proofpoint-GUID: Le8xlJp6G0cYtfXhrJ2tMqTPX-mtdsfZ
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=688210a2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=y9Hb3FDJ_D53AYP2N1gA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240081

On 7/24/25 10:18 AM, Krzysztof Kozlowski wrote:
> On Wed, Jul 23, 2025 at 10:38:48PM +0200, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> The SM8750 features a "traditional" GPU_CC block, much of which is
>> controlled through the GMU microcontroller. Additionally, there's
>> an separate GX_CC block, where the GX GDSC is moved.
>>
>> Add bindings to accommodate for that.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> ---

[...]

>> +title: Qualcomm Graphics Clock & Reset Controller on SM8750
> 
> There is no clocks nor resets here. Only power domains.

There are clocks and resets in this IP block (inside the register
space mentioned in the dt patch/example), but the OS is not supposed
to poke at them (it can in theory, but we have a uC - the GMU -
doing the same thing so it would be stepping on one another's toes..).
Not sure how to express that.

I could for example add #define indices in include/dt-bindings, listing
out the clocks and never consume them. Does that sound fair?

> 
>> +
>> +maintainers:
>> +  - Konrad Dybcio <konradybcio@kernel.org>
>> +
>> +description: |
>> +  Qualcomm graphics clock control module provides the clocks, resets and power
> 
> Also confusing.
> 
>> +  domains on Qualcomm SoCs.
>> +
>> +  See also:
>> +    include/dt-bindings/reset/qcom,sm8750-gpucc.h
> 
> reset or clock path?

Ugh, clock

> 
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,sm8750-gxcc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  power-domains:
>> +    items:
>> +      - description: GFX voltage rail
>> +      - description: MX_COLLAPSIBLE voltage rail
>> +      - description: GPU_CC_CX GDSC
>> +
>> +  '#power-domain-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - power-domains
>> +  - '#power-domain-cells'
>> +
> 
> You miss ref... or this is a bit confusing.
ref to what? qcom,gcc? I specifically omitted it, as that adds
requirements which you stated above.

Konrad

> 
>> +unevaluatedProperties: false
> 
> additionalProperties instead
> 
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,sm8750-gpucc.h>
>> +    #include <dt-bindings/power/qcom,rpmhpd.h>
>> +
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        clock-controller@3d64000 {
> 
> No, clock controllers have clock-cells. This cannot be a clock
> controller if it does not have any clocks for anyone to use.
> 
> Best regards,
> Krzysztof
> 

