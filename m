Return-Path: <linux-kernel+bounces-864773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7636BFB839
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FAAE19A5DED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8945930DD27;
	Wed, 22 Oct 2025 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V8ajxbA/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA13630B521
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130933; cv=none; b=WC1NkBGPGbvUJGvNDWmiXEZHHqOqo4NQ0Lvps22hZb07n+oppwPwj0P+bWx4fmCMXwZrT2GU8ApndcI5vNrH2a+jfvzI/wGTsVyEEgrW/r4oazxTeFcvpN0/3OWg39XD0RzMkZ9ak++tZaVu/aCyDtbt7N6a1C8hbc0dpM48mFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130933; c=relaxed/simple;
	bh=hby0fGqeOQgebOP9bVhAIHiXWqnLpdthxPRktXlXyx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nf5rpbhn2SbKuJjlabLhhFb9JK2CCfk5yUnrhaVxAT/TmO3ZpwyaT3t8sn9I7aoWo0UK6t8pXoWO/Us6oyuiiPLB9S2hmY7zmt6S653DjAdqJdpA135DMY0uR1xBtIenWgHKo+bfP8eGhM6lBMN6ANWvKswShKhpNQoVzUxZLKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V8ajxbA/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M7PJv3010315
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7bBoyflX/NuTRUJIvXCNZ90wA1Dv+aq6GZSGm7Ck/iE=; b=V8ajxbA/le88tOGe
	E7MBJSotLVGzNZH4ajLxoqe7nnb0OACJ+wjVczI81r0ba0+1s1QlLHdREtZMF90v
	TsSUlTd5yJfcHjHZhmrnodem/0DoMX6ekdiUXEDnYYItrDP2sUV7WKj2MTfzk9tT
	S4RLlHQym6XjJz6i0b0bCEY+bfmdQXNeTQKUgiRyzaa4vp5BFpxDSP0Bdgv1IbZI
	p3mIAXJOSUf8fYiEOnZytYTeogc6fkUH+ecqFrAr+Il8dBVGJzkOi/ISweqgJI4L
	0OYcVXHBfA6SYTP98I9wIajQ371OmTrMT7ypLMhqkFtUkYedWBKP0DTCajY3zBL7
	00Qp0Q==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0j77u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:02:10 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5a34fceaaacso835376137.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761130930; x=1761735730;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7bBoyflX/NuTRUJIvXCNZ90wA1Dv+aq6GZSGm7Ck/iE=;
        b=RHfNlR8k3i9spTDBqr9ZYrXWCaYCf7up0BH9jdrfB9+QvaeUoEDY5LfqBuOAM9A9Sd
         YPFMLeWP9ENQkTyEVsRlaGN+k3OJg3U15Y5uAvWcPIKkVcc5XBxp/PTYTbgF7g/0vsIA
         qIrqp+wZKhTpQwSWjUQbE3eGPKUti+8XeoHlfipmJUG9gYMJjfwt3JJXb98smoGe2gdq
         AqEUGQ0CzkTFDqCIqz/UAfpY3wfKKviEov5yV+hM5QrtI40mAFLZDc2rYr6pc3w7TE+p
         6PzEEyqLZx6xx42mkeJqFgG4hKHZbg+rooqn6+BNQjcLYRCdjt8tPuIgICByZcLWlXI3
         5emw==
X-Forwarded-Encrypted: i=1; AJvYcCW8RUNBi4jG6c1mhBkmbufkuw1KIqZ+rQqSK4vbdHsJRkxHq9WLEWVry0HolnIxLKYwUEQaD8cQOVnYHj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN2NX8P9C7k8Xs5ml4XMlmUYZE4ZHPgJoSnR9QXwr2Vi9EBX38
	T/gg5kKoSET391K4j3UKW9ulL9nu/ZC0YmH82wPBxx7E+83sexrD3ZfuEdfgcTwPXicSx9qUPkL
	SOS1uDu64/CeEbwg2mgCvLM7xfIc72Y8NjAkV2vVQY2Me174OyE9Af9iEzE2PSyuJbNc=
X-Gm-Gg: ASbGncu3Y89tSBAhblqef47rLSx8LGqlUdrDRpYj6ncEdRPo3o9Vd9dGXnQWVlD85jG
	4/cez16RoeAm7HLBCVh/f8z5m6i49j2iuFukmZNizdHLvMuZ1/pDa9ZHM1a0IkFI/p+IfwBDzNw
	ofnS8jd/iPfZVOScGGvchIBw6DVhYvz6fnJU/IgsgBAbaT0QTDsIQAD7OZxPsXtPaeomV5kNGic
	WONgebiok8V+IHr1i/MV60EdLkPrpi71+uN87xPI1b2OTLqvFAr7d8NRWjvw68uMzheNZkPDRnE
	xGizP5F1vZE9y2Hty8DbS1phQGUIM1maSPi27VbCmE7V/Lngty4FaGD4N1KDw8zrs/okKeNgA0M
	VwWG5krjGHSAhEN82IOYjCW7TVk2hPUZC0gKdMX8s2/Qfu+VuQnCjayWloUWSg4c=
X-Received: by 2002:a05:6102:3e8d:b0:4e9:c913:2c9e with SMTP id ada2fe7eead31-5db0df9a03fmr891621137.1.1761130929243;
        Wed, 22 Oct 2025 04:02:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESC9jbY9cPCm4e8hmUXQgKx8IrxV3YDPJP1exkJtZl6RbRgdoLF67Bj2RD7Pbg9/upZZdy7g==
X-Received: by 2002:a05:6102:3e8d:b0:4e9:c913:2c9e with SMTP id ada2fe7eead31-5db0df9a03fmr891609137.1.1761130928783;
        Wed, 22 Oct 2025 04:02:08 -0700 (PDT)
Received: from [192.168.0.242] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6cfa6cb6e6sm404145466b.49.2025.10.22.04.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 04:02:07 -0700 (PDT)
Message-ID: <c4b2c474-c6d0-4b1d-bcc3-a3fddea699c7@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 13:02:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/5] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
        rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250826083657.4005727-4-jishnu.prakash@oss.qualcomm.com>
 <20250829-classic-dynamic-clam-addbd8@kuoka>
 <5d662148-408f-49e1-a769-2a5d61371cae@oss.qualcomm.com>
 <4e974e77-adfc-49e5-90c8-cf8996ded513@kernel.org>
 <a0e885be-e87d-411a-884e-3e38a0d761e5@oss.qualcomm.com>
 <8c90cc3f-115e-4362-9293-05d9bee24214@linaro.org>
 <5d4edecf-51f3-4d4a-861f-fce419e3a314@oss.qualcomm.com>
 <20250927144757.4d36d5c8@jic23-huawei>
 <a3158843-dfac-4adc-838a-35bb4b0cbea4@oss.qualcomm.com>
 <CAGE=qrrCvq28pr9Y7it-CGMW=szKUnU+XBj1TmpoUwuASM05ig@mail.gmail.com>
 <31bd08ce-823a-4a71-baca-a9d1e02fcb6a@oss.qualcomm.com>
 <08eb477f-ea34-4a31-b181-bfc629aef4c8@kernel.org>
 <68a9b8e8-bdf4-430f-baef-6a293ccea78d@oss.qualcomm.com>
 <d8a78b7c-e3a9-44b5-986d-8ac32f328eb6@kernel.org>
 <3a32746a-5b0e-4c0a-8322-00cd3a84394a@oss.qualcomm.com>
 <4979bd26-0a77-4390-9db2-6d40cd7f963c@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <4979bd26-0a77-4390-9db2-6d40cd7f963c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfXz9XWlj2za2/A
 OSNt/PF04vwiVLd7Im52Nmg4AJFrR3VJnIFYzBMpnaZHDeT/tLYlftPpxwzu71Nt1QzfnNCbysI
 jsUPhxIsp8RQabdDJFPuhh9eUtQlNN0H4WyOWLwX+p7tGNRSzPRyPswa8HeqU3kUGnpRQcYKtrD
 Qa7GMMJYj3ld6Xqn4nFQi5PkiX7y4brxcuH+aKLKqE5HJ6Ul16jQMhIV36lS1FICpjeKsrJFDAG
 22OX7VHSjjBf1Wx+qFx/IAAx0ngnlbOZnXDGHdma/jRy4J/vQkXMvXQjX5yjk2BQQ3Lop9Owy12
 6XPjo/6onKxcEvUzUbG1xMGasgFTIlfdMDXhEl45BwVv8kbOpAvnn6ShavybKxFJj2sUzPM1ZFg
 kJL86ySs99VHktOMdNnFQrRbWiHJNw==
X-Proofpoint-ORIG-GUID: yoQVVXWJO3TTgeWurM0W5MeWr8wAcU6k
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68f8b9b2 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=lSOnRjTSg1CY54VbDlwA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: yoQVVXWJO3TTgeWurM0W5MeWr8wAcU6k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167



On 20-Oct-25 17:55, Krzysztof Kozlowski wrote:
> On 20/10/2025 14:51, Konrad Dybcio wrote:
>> On 10/17/25 3:40 PM, Krzysztof Kozlowski wrote:
>>> On 17/10/2025 13:18, Jishnu Prakash wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On 10/9/2025 5:22 AM, Krzysztof Kozlowski wrote:
>>>>> On 08/10/2025 23:20, Jishnu Prakash wrote:
>>>>>> Hi Krzysztof,
>>>>>>
>>>>>> On 10/4/2025 12:22 PM, Krzysztof Kozlowski wrote:
>>>>>>> On Sat, 4 Oct 2025 at 11:42, Jishnu Prakash
>>>>>>> <jishnu.prakash@oss.qualcomm.com> wrote:
>>>>>>>>
>>>>>>>> Hi Jonathan,
>>>>>>>>
>>>>>>>> On 9/27/2025 7:17 PM, Jonathan Cameron wrote:
>>>>>>>>> On Fri, 19 Sep 2025 20:17:43 +0530
>>>>>>>>> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
>>
>> [...]
>>
>>>> Can you please provide your suggestions on changes we can make
>>>> in the above points ?
>>>
>>> You just pasted DT. I asked about SW, software. Please read carefully
>>> previous comments.
>>
>> Is the problem that Jishnu included some indices in dt-bindings without
>> also adding them in the driver's adc5_gen3_chans_pmic[] array?
>>
>> As in, would the resolution to this thread be simply handling all of
>> them in the driver correctly?
> 
> The solution is to remove them from the bindings, just like we do with
> many other hardware constants. Of course if these are not hardware
> constants, but part of ABI, then solution would be different but no one
> provided proof or argument that this is any binding. All proofs were
> "but I want to use it in my DTS", which proofs nothing. Not a binding.
> 
> While this issue is not that important, we keep discussing it because
> author does not try to understand the problem or even keep up the
> discussion. Instead repeats the same without really reading my
> messages... and then disappears for month or more.

In Bulgaria, people shake their heads left to right to say "yes", and
up&down to say "no" (or so I've heard).. I feel like we're having a
similar situation here..

I'll try to make a case for keeping these defines in some form.
Here's hopefully all the related aspects, condensed down:

1. In a multi-PMIC setup, only the main PMIC's ADC is accessible by the OS.
   It then mediates accesses to secondary PMICs' ADCs through internal
   mechanisms, which requires the SID of the target to be retrieved and written
   to a register, along with the physical index of the desired channel to be
   measured (see patch 3/5 commit msg).

2. The PMIC SIDs are fixed per board and are the values of PMIC top-level
   nodes' reg property (since forever)

3. The channel indices are fixed in HW, but this patchset proposed to reuse
   them for logical mappings consumed through io-channels = <> as well (because
   of 1.), with the drivers taking the lower 8 bits that of reg/io-channels[1]
   value as the ADC channel id and the higher 8 bits as the SID (this is the
   define macros with an argument)

4. Fixing 3. in a "simply define all possible options and bind them to
   consecutive integers" fashion would require a huge table matching 0..n to
   [0-max_sid][0-max_chan] which is unreasonable

The alternative to the SID packing would be to reference the target PMIC
somehow, be it by referencing the PMIC itself:

io-channels = <&pm8550_adc &pmr735a CHANNEL_XYZ>

or by creating a faux node for the actual inaccessible ADC onboard each of
the PMICs:

io-channels = <&pm8550_adc &pmr735a_adc CHANNEL_XYZ>

and have the OS retrieve the SID from the DT node & encode that value instead
of hardcoding it in the DT, leaving just the actual channel IDs in dt-bindings.


The define macros without an argument do specify physical channel indices, but
we do need some sort of an identifier to put into io-channels (which is why this
lives in dt-bindings in the first place), and a 1:1 mapping to the physical id
sounds like a good option.


I don't think anyone objects to any of these resolutions, so long as they
are acceptable from your side

Konrad

