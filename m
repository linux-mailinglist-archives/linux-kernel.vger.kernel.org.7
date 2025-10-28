Return-Path: <linux-kernel+bounces-873365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A2CC13C44
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC3E5E1F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84B42FFF87;
	Tue, 28 Oct 2025 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MmNLpI80"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0BD2FFDCB
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643152; cv=none; b=F2vn0hRHgJiKqsElQ+BEwTHZTUDiGnyuNosJatorwfWDH9/ozij60MIBJWXtU3WwVGBoys8nIKRqwdiwVmb2SwzRmlzdfz6JvnMUZf3J1Y4dxLvqiCgzZR7YbqeQkQSjGjbJzN9453hISBgk9ygYwt2pkeFeW6UKpUmsXudj97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643152; c=relaxed/simple;
	bh=Pnj/ANiWZ3zbGY5THI/UoM08Gmvsdy56Z74g/owEQ3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TcFJ257XvcOFfeaX3jkzosG+zQY9g0JqIhpEZnU5OY52EIsmtQ54BRGJjbDx5Ge2xrR9+Gd5M7/RVMj27AvC3jwyE3CMp4NvFI6SaTxLZrfDy704TC9wolzanCUhLT4kBZRhnYtrxxlUPZ6JFu4ZFJiKyBz7DOT37uV0XWI8SBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MmNLpI80; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S6g3gn2547940
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B2aobvIHktpLHzNo8G24JAfXJ2XnQNll5brV8BTWDVI=; b=MmNLpI80nEebDgZ1
	s3rkGaYQWPTE9Gx+uIdVyzPqz9I1hYJNGUccRNWhQ7EEmU1NKWSVmcmGyPTsitLY
	70zNPZ+8X+DZs8esFMzKUwo4UR9wCwLdkyYnTS1gGN1W1eQSLuG4IXqQw1thMYjM
	4guYoA431eickn4RGF4i/+i8m8DMvvUwJLwadn/PNNaA64LA0oNryiX8Tgb6igxR
	//0ux2IWF0z9d3Osp8XmiBQ+tsrYW3kMAu/UegItMzNCKescDxZZH+MXZdLxxPv4
	mvSUR5UWaMdPM14g0yOh7edC2TVD4dtsJmcnYccp8jBbncnOc1J+r9KjS5IlvI6r
	xRaLnQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a27s2kjsk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:19:06 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c262c72b5so17811166d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761643146; x=1762247946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2aobvIHktpLHzNo8G24JAfXJ2XnQNll5brV8BTWDVI=;
        b=ckXIpTwngwl83HIxmrQG33zYAgcJ3+K3DjDcsPFjCoPxOX3mNpwjqL2tcZR3T+8uTu
         F4dISnXwL1tzsZEBpAAUOLKMU1/EFcnAA57qiSqpPsBmi6Nzyczm5ezVvdq76xPpC778
         yG5dS/xkbh8tsfSTbInv3tYISMchGaNL0iV/NM/AclGABJGqhHUIKW4S+tjgxyvuSRLd
         ATffnsaOfOKnf8dmHeYeC6nlXVoVUugHggypZUV4PB5YrAb+T3uDFRpRDZ8L/3p6sQ5M
         ZfM5H6myS9NKViOjCbjCrKNSflaR+TrXneCsaa2WVRnqkRfR4JDv2Qsi3KRx/t6RP0Rn
         tGig==
X-Forwarded-Encrypted: i=1; AJvYcCXe7J305rFNPNXi5NwYLhXJaNRPx+4lMKcTBUzEv+dL7TunZOa79oCO1y5bxnzC3oJR5r4dy8TobheDK1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0nM8/813lCFNl1dXj9OeUYCoNureyS83o0zmLDdPuSaRp/u6D
	YGYjNAhyiWcIJPk3/0y6pCKvJiYRU9FbcTz80UoAJ5/oDuKHGZy6pSxKpZE/6kJ5XtA5Dl/CQJb
	PO3mGdc7f/c8qXoQaPb9Qo9SwJbftNf2Cn92JjLrpNuoL41vc06NrAnRI6pxf9sJvt6Q=
X-Gm-Gg: ASbGnctsJkSjVxE+o8p5uzC3ii5+yunI/8P0x9NSyrQXOWgix0IVb/Wr2msmCUFDZAv
	S8mB71aTjwvZSDeDQPeKd3ytJwJkvtcyucSQUJSPO8BE6rCOm7KowIf14cnrVqxyZjZvfBdrMdj
	LY8PUgtVb/FnbRQlASdXBUy1eo7RXd5A0mwisoX26A6yJAkTH/TCIj4EK2uNCrdl0NL3W/+HuUv
	QFytQvi0o8by6vKc0c6HCMm+vRO2IxP364dB+FbaiEOZ4/yQo+kM2lFVajvZvsFTEIMeZrEw8Iu
	pUwPLMOA+j0p+Eh+zX372FN0xNnSqAQ5JtL1Wokm8stIqHvf3JN5LavevhbjFB3jLAu+dPnNHpI
	TxMUKdnKOOVOCkErpl8ewXAhaasTPGSPpdycTHQz+VaBRZLWPo8LgQ3pk
X-Received: by 2002:ad4:5cab:0:b0:87d:c7db:7897 with SMTP id 6a1803df08f44-87ffaffe2dfmr21043536d6.2.1761643145824;
        Tue, 28 Oct 2025 02:19:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEurnIObiANgUA7/WbW6dXnIR12D0Q5V5D96yWxFPBx6HjF0EpwoTt8uaIEOM3yWKyv4b5smw==
X-Received: by 2002:ad4:5cab:0:b0:87d:c7db:7897 with SMTP id 6a1803df08f44-87ffaffe2dfmr21043356d6.2.1761643145401;
        Tue, 28 Oct 2025 02:19:05 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8544f8eesm1009886566b.69.2025.10.28.02.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 02:19:04 -0700 (PDT)
Message-ID: <2676d88f-89a9-4b1f-895b-3bdc048f6fbf@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 10:19:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: qcom: qcom,pmic-glink: Add
 Kaanapali and Glymur compatibles
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251027212250.3847537-1-anjelique.melendez@oss.qualcomm.com>
 <20251027212250.3847537-2-anjelique.melendez@oss.qualcomm.com>
 <20251028-private-chirpy-earthworm-6fccfe@kuoka>
 <4cb41e69-fb32-4331-a989-529b5af0081c@kernel.org>
 <918fc9d3-2cd5-4442-8bc6-b930596d95c1@oss.qualcomm.com>
 <ba760468-ac41-48e0-a56e-a675c3c0d5b7@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ba760468-ac41-48e0-a56e-a675c3c0d5b7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ilYiOlpDTdzqquuWQZwMtVlsBF_R542-
X-Proofpoint-GUID: ilYiOlpDTdzqquuWQZwMtVlsBF_R542-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA3OCBTYWx0ZWRfX1Fq9nUu8Nl6J
 f6Kbm6kkv/plVcKOTQjz24PGm6WcyVQkWsiuNFYkl9GfNNB/eudHl1rXjY0p1H3f66GACgQenD6
 NKZG+Adnoc9FPu+zxycqhK5hZA6uugMnAjgKOTVIPh2VtPX6xoVtYueBjgyYkGoiVZIqiQixEfq
 h69r6aUC7kDCVcEivhAMinysyg7JdY3mz/Rn+6h8MMV++qH3c0z/XaGlT+EoEEk7rh/aHhK3JzK
 qMEDEgj8LN5XH3DO83kFrvrvyHLCR4Qsi0rjmGjxnrJPHnogh0JDs1Hl1+PeBnUvX7t/Ez8UjEZ
 3yJmTbMvTAbnYYXtvSCp9dtotNqg2c8HHnYpLYLNcUepLGrO+w7AK40/PLyGfB8z83g1FT4//Ey
 U3MPUC6KvePL/4dZQwGrBaXkrBa5mg==
X-Authority-Analysis: v=2.4 cv=R60O2NRX c=1 sm=1 tr=0 ts=69008a8a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Hujz_9XNg8WYzFnulF4A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510280078

On 10/28/25 10:16 AM, Krzysztof Kozlowski wrote:
> On 28/10/2025 10:04, Konrad Dybcio wrote:
>> On 10/28/25 9:36 AM, Krzysztof Kozlowski wrote:
>>> On 28/10/2025 09:29, Krzysztof Kozlowski wrote:
>>>> On Mon, Oct 27, 2025 at 02:22:49PM -0700, Anjelique Melendez wrote:
>>>>> Document the Kaanapali and Glymur compatibles used to describe the PMIC
>>>>> glink on each platform.
>>>>> Kaanapali will have the same battery supply properties as sm8550 platforms
>>>>> so define qcom,sm8550-pmic-glink as fallback for Kaanapali.
>>>>> Glymur will have the same battery supply properties as x1e80100 platforms
>>>>> so define qcom,x1e80100-pmic-glink as fallback for Glymur.
>>>>
>>>> What does it mean "battery supply properties"? Binding does not define
>>>> them, so both paragraphs do not help me understanding the logic behind
>>>> such choice at all.
>>>>
>>>> What are you describing in this binding? Battery properties? No, battery
>>>> properties go to the monitored-battery, right? So maybe you describe SW
>>>> interface...
>>>
>>> Or maybe you describe the device that it is different? >
>>
>> Certain versions of the pmic-glink stack expose services (such as battmgr)
>> which support different features (e.g. 8550 exposes state of health and
>> charge control, x1e exposes charge control, 8280 exposes neither)
>>
>> There seems to be a similar situation here
> 
> Then say that. Otherwise it feels like describing current Linux
> implementation and that would be obvious no-go. Why? Because then
> argument is: change Linux driver implementation.
> 
>>
>>>>>
>>>>> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
>>>>> ---
>>>>>  .../devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml      | 7 +++++++
>>>>>  1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>>>>> index 7085bf88afab..c57022109419 100644
>>>>> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>>>>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>>>>> @@ -37,12 +37,19 @@ properties:
>>>>>            - const: qcom,pmic-glink
>>>>>        - items:
>>>>>            - enum:
>>>>> +              - qcom,kaanapali-pmic-glink
>>>>>                - qcom,milos-pmic-glink
>>>>>                - qcom,sm8650-pmic-glink
>>>>>                - qcom,sm8750-pmic-glink
>>>>
>>>> Why qcom,kaanapali-pmic-glink is not compatible with
>>>> qcom,sm8750-pmic-glink? If Glymur is compatible with previous
>>>> generation, I would expect that here too.
>>>
>>> And again to re-iterate:
>>>
>>> If X1E is compatible with SM8550 AND:
>>> SM8750 is compatible with SM8550 THEN
>>> WHY Glymur is compatible with previous generation but Kaanapali is not
>>> compatible with previous generation?
>>
>> The announcement date does not directly correlate to 'generation'
> I don't know exactly this IP block/component, but in general these SoCs
> follow some sort of previous design, thus term "generation" is correct
> in many cases. Anyway don't be picky about wording.
> 
> You can remove the generation and statement will be the same.
> 
> If A is compatible with B AND
> C is compatible with B
> THEN
> 
> WHY D is compatible with (A and B) but E is not
> compatible with (C and B)?
> 
> Easier for you?
> 
> Why nitpicking on wording "generation" instead of explaining the
> problems or issues with bindings...

What I'm saying is that Kaanapali and Glymur are disjoint projects
that shouldn't be thought of as having a common base

Konrad

