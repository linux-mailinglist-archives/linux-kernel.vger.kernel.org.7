Return-Path: <linux-kernel+bounces-867888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FE2C03BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510B23B24F2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC9028002B;
	Thu, 23 Oct 2025 23:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nFn7V/Hx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5A6233723
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761260621; cv=none; b=KrYJZsjvsx+WI/3rMCZXyhoyS3jS3Kd620dAkTGkna89AvTuSHBgjHBjSAb5J2p8trNuvf1shhC1OVZfihJQQMlHb+Ohkpt5K3nKWV/xHhXRJYm6Q6eZI+WGt9FvRsBCuZBda/suLwYM+QKT6LTMBBI8BWCJenH21SsSWVFV6eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761260621; c=relaxed/simple;
	bh=Uf6vdpIMhqiFJb2Ai7F4KgvzXlqs5AJUHLFC4w3AEhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qz3Nmw6d/qiOUxXthVczwxGqDUEQeDrldMK96XXIk7is8V0ZRetGIlvEZ1Y6/m+1yh87M9dY32v4618mQ9wpp+0s0Lj+++4fg3+++xLqzYy/t/DWmyiNWH1IMhYHMzWgv/dwSGgJKHlwUoN/2jvDki/wUz6dh9zZLnuYepa4dag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nFn7V/Hx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NEtMRC022471
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yz1FKwyZ35REPRPl+uTbA1pbxfFaVvWgZK3KBVlHQrM=; b=nFn7V/Hxn/9SxRiV
	HuusfQEbGGC8kY0kotHJ6ONBJGcwf4Xjd8az1bUbTgdGFfQMYn+tbMDu7bo/6XuY
	USgE9RcKgFAz1p6MYTVUpsOCDNU/skWVTyJVAVXb0bdMVMYEoayYN5vRa7UYWq53
	w1MqyW7Dii5y9kdFl01YHkAnPReVEQ5cpK37IXPfUrUMIU5aWm17JVC6KkmLjKsq
	Tc+R9ldesbK0IbkPLM/unDKkMy8Nb52MtxdAUN0sG9YvABGwNlXUi/Mz0/D3p2fK
	BbyYw/lBy97XUOUzUYFT6fRiYpKmOLjxnLwLQYu/UWZDU5vUb26JcOMyDYwIu7Op
	9nCddQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w8a534-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:03:38 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-269880a7bd9so14351955ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761260618; x=1761865418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yz1FKwyZ35REPRPl+uTbA1pbxfFaVvWgZK3KBVlHQrM=;
        b=LCgJji8VUw/AaCX0othMYsjRqvIkq6yXmOJ6vMMF3sVyq6oNbh5+i8o5MwBOUqGP6B
         LgavoVGFjnYiUNxEpYh8awjoW6+/Z/ucaJTKvMpmDFYd1A4iao95tShnAi2wzNFLk/kP
         Sc/WuwLy1C/ZMpCo+LrtcsGyxk4dKw4hxx0XQkjjLD2X606FWG+meY4bJxKSW8FMiIpJ
         fQ71PoxYDmsRwfCzU0pN/5XRZ/ZHs44+eTyMEvEkXYExSOQ93D5UT67Vs/bFdElyyDXg
         ZunioyOTZBuToPuVMrUeY7ylh1cRaldRkN38U+dfbNRetfZysg5MgOKgPKyYCJ3IB9AJ
         vWUA==
X-Forwarded-Encrypted: i=1; AJvYcCXBSk0pKrJcPDyyZtoVeyjUbik31Lf6lxI/7LQoHmmXI9QNyFk5fmfal+ifTgcF0B+Ip/nhwFn8Bi/m16I=@vger.kernel.org
X-Gm-Message-State: AOJu0YznlBeJ0a/1Zey29EIKhrqLrXSZoMNevFhyQAXKcxBgBHNVsaVD
	RfxkIGTduNHcc0ROeIyMs+FJ70/D0Ktcwcj9DFsfRpFTxAGZswQIfCcgfljevamScPlyxbbbjlr
	3bCFn52V5EnskW4qOfn5+XBRJ98rrU7rh5eNbdgWGnXky0sWekJdhT0SDSuT5mXFOAwI=
X-Gm-Gg: ASbGnctPmjMJAceoacHarCBpy6pFD6X3u4NXIHGMZ4dlcn0iItkrhozFttcpbU2tLi1
	S5Wgt/OXl4tz0EQIOHztA0OueziRPT//2inxnU8/4YwdejZgqLZfGC5KgL17x0ZQolE81G1I+Yk
	+ulY1hm6inL36J3UgZORrev6jY/A2p9uybm8Y7uT/vdtIoMrUucqFbylJcWy9HSxr0hYbRH7+7N
	GVBypHzuhS63M2nef3KRkGs3pgsCwAqzTqMQND3Sq3+Wi5gcPazd6xJNArn0gP2x5+zTuOuYER8
	wIxQfAsKCYgeSgzQL/dPOvDk1cC8mSjhysKbmok1jV/LRIPbhaQ08vjoqnOIMkaNmXaigA4u3Jb
	6AO4mif9cJd5REJ6YFekFfCk=
X-Received: by 2002:a17:903:244b:b0:290:9a31:26da with SMTP id d9443c01a7336-290c9d31109mr329081705ad.16.1761260617686;
        Thu, 23 Oct 2025 16:03:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+gtW3iL5YfktBLtM22DaFOWiosZsm9piWaW0gD11XXUYwJYStL7NWGN9b5nOT3GQP6iSqfA==
X-Received: by 2002:a17:903:244b:b0:290:9a31:26da with SMTP id d9443c01a7336-290c9d31109mr329081175ad.16.1761260617079;
        Thu, 23 Oct 2025 16:03:37 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.232.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946de0c927sm35158665ad.46.2025.10.23.16.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 16:03:36 -0700 (PDT)
Message-ID: <f677f8ee-d635-4131-8ee2-8ca6ead43095@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 04:33:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: display/msm/gmu: Document A612 RGMU
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <20251017-qcs615-spin-2-v1-0-0baa44f80905@oss.qualcomm.com>
 <20251017-qcs615-spin-2-v1-3-0baa44f80905@oss.qualcomm.com>
 <8f3f4874-2e82-473e-87bd-e3bd58089b90@kernel.org>
 <181af756-09a1-4694-98c4-53cea556e172@oss.qualcomm.com>
 <ff37b635-b3dc-4180-8eae-e798ef6ce55a@kernel.org>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <ff37b635-b3dc-4180-8eae-e798ef6ce55a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfXy1zSHhnOTcyK
 9xiBMt5a5x1E6Iq4pQCsLQx/VZD4ob62RNZVIyj13MtI5RzCpPPlpX1q0JGYZpvBxk80/ZJ5XQg
 5BZo9igsgNXhE8osf/lz5/tq2dL/zd8eiLpHfP3tjU52ZzjcoBti+86QRTCHtlT2jT3cloAmLE6
 HzKg32bVjS+kESvrA1fDORN+aJ6KJuGmY4Vn9tOJnspFlKrGJ6E4evwZWMojnkpSGkqyhdfWjpW
 mwvv9lnHQrNfSZaaTJKU42OOmsn4QTRNxr1CBdPtJ9N7HbBk7JkCt71GsJi9w7Hc8Hx/AzZAWfR
 /8jZhTMZgM0KVrEW5fSDdGbxV950GJ5IMyEPoB/oMma6bYBEmo4zQ9W1DpuTwRykTpQ8BT7ybmG
 r65vT8DnW9YvlrXZOHAJbX+mN/wAwQ==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68fab44b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=OORdEvYNKPdDRPFHMUl15A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Oc1YgfMCT3OOBMc9zysA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 9HnbBRbihY8YxEq0Il7V3m_-WdeVAFpr
X-Proofpoint-ORIG-GUID: 9HnbBRbihY8YxEq0Il7V3m_-WdeVAFpr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

On 10/22/2025 12:49 AM, Krzysztof Kozlowski wrote:
> On 21/10/2025 17:51, Akhil P Oommen wrote:
>> On 10/19/2025 2:43 PM, Krzysztof Kozlowski wrote:
>>> On 17/10/2025 19:08, Akhil P Oommen wrote:
>>>> RGMU a.k.a Reduced Graphics Management Unit is a small state machine
>>>> with the sole purpose of providing IFPC (Inter Frame Power Collapse)
>>>> support. Compared to GMU, it doesn't manage GPU clock, voltage
>>>> scaling, bw voting or any other functionalities. All it does is detect
>>>> an idle GPU and toggle the GDSC switch. As it doesn't access DDR space,
>>>> it doesn't require iommu.
>>>>
>>>> So far, only Adreno 612 GPU has an RGMU core. Document RGMU in the GMU's
>>>> schema.
>>>>
>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>> ---
>>>>  .../devicetree/bindings/display/msm/gmu.yaml       | 98 +++++++++++++++++-----
>>>>  1 file changed, 79 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
>>>> index afc1879357440c137cadeb2d9a74ae8459570a25..a262d41755f09f21f607bf7a1fd567f386595f39 100644
>>>> --- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
>>>> +++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
>>>> @@ -26,6 +26,9 @@ properties:
>>>>        - items:
>>>>            - pattern: '^qcom,adreno-gmu-x[1-9][0-9][0-9]\.[0-9]$'
>>>>            - const: qcom,adreno-gmu
>>>> +      - items:
>>>> +          - const: qcom,adreno-rgmu-612.0
>>>> +          - const: qcom,adreno-rgmu
>>>>        - const: qcom,adreno-gmu-wrapper
>>>>  
>>>>    reg:
>>>> @@ -45,24 +48,30 @@ properties:
>>>>      maxItems: 7
>>>>  
>>>>    interrupts:
>>>> -    items:
>>>> -      - description: GMU HFI interrupt
>>>> -      - description: GMU interrupt
>>>
>>>
>>> Both stay, just explain what is the first interrupt. You should not drop
>>> descriptions here. Look at every other binding - of course except that
>>> terrible Adreno GPU which is anti-example.
>>
>> Do you mean we should use a OneOf and list both combo? Or elaborate the
>> description of the first interrupt to include OOB too? Something like:
>>
>> - description: HFI interrupt on GMU and OOB interrupt on RGMU.
> 
> Yes, like that.
> 
>>
>> Sorry, I am a bit confused.
>>
>>>
>>>> +    minItems: 2
>>>> +    maxItems: 2
>>>>  
>>>>    interrupt-names:
>>>> -    items:
>>>> -      - const: hfi
>>>> -      - const: gmu
>>>> +    oneOf:
>>>> +      - items:
>>>> +          - const: hfi
>>>> +            description: GMU HFI interrupt
>>>
>>> No, descriptions never go to xxx-names, but to xxx.
>>>
>>>> +          - const: gmu
>>>> +            description: GMU interrupt
>>>> +      - items:
>>>> +          - const: oob
>>>> +            description: GMU OOB interrupt
>>>> +          - const: gmu
>>>> +            description: GMU interrupt
>>>> +
>>>>  
>>>>    power-domains:
>>>> -    items:
>>>> -      - description: CX power domain
>>>> -      - description: GX power domain
>>>> +    minItems: 2
>>>> +    maxItems: 3
>>>
>>> No.
>> I will keep the 'description'. Here, RGMU has 3 power domains instead of
>> 2. I suppose we should add the description for the 3rd power domain here
>> and keep 'minItems: 2' property to override the default 3?
> 
> Yes.
> 
>>
>>>
>>>>  
>>>>    power-domain-names:
>>>> -    items:
>>>> -      - const: cx
>>>> -      - const: gx
>>>> +    minItems: 2
>>>> +    maxItems: 3
>>>
>>>
>>> No. Why?
>> Same as above.
>>
>>>
>>>>  
>>>>    iommus:
>>>>      maxItems: 1
>>>> @@ -86,6 +95,44 @@ required:
>>>>  additionalProperties: false
>>>>  
>>>>  allOf:
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            const: qcom,adreno-rgmu-612.0
>>>> +    then:
>>>> +      properties:
>>>> +        reg:
>>>> +          items:
>>>> +            - description: Core RGMU registers
>>>> +        reg-names:
>>>> +          items:
>>>> +            - const: gmu
>>>> +        clocks:
>>>> +          items:
>>>> +            - description: GMU clock
>>>> +            - description: GPU CX clock
>>>> +            - description: GPU AXI clock
>>>> +            - description: GPU MEMNOC clock
>>>> +            - description: GPU SMMU vote clock
>>>> +        clock-names:
>>>> +          items:
>>>> +            - const: gmu
>>>> +            - const: cxo
>>>> +            - const: axi
>>>> +            - const: memnoc
>>>> +            - const: smmu_vote
>>>> +        power-domains:
>>>> +          items:
>>>> +            - description: CX power domain
>>>> +            - description: GX power domain
>>>> +            - description: VDD_CX power domain
>>>> +        power-domain-names:
>>>> +          items:
>>>> +            - const: cx
>>>> +            - const: gx
>>>> +            - const: vdd_cx
>>>
>>> This does not make even sense. Why did you remove the the common list
>>> from  power-domain-names?
>>>
>>>> +
>>>>    - if:
>>>>        properties:
>>>>          compatible:
>>>> @@ -313,13 +360,26 @@ allOf:
>>>>            items:
>>>>              - const: gmu
>>>>      else:
>>>> -      required:
>>>> -        - clocks
>>>> -        - clock-names
>>>> -        - interrupts
>>>> -        - interrupt-names
>>>> -        - iommus
>>>> -        - operating-points-v2
>>>> +      if:
>>>> +        properties:
>>>> +          compatible:
>>>> +            contains:
>>>> +              const: qcom,adreno-rgmu
>>>> +      then:
>>>> +        required:
>>>> +          - clocks
>>>> +          - clock-names
>>>> +          - interrupts
>>>> +          - interrupt-names
>>>> +          - operating-points-v2
>>>> +      else:
>>>
>>> No. Don't nest multiple ifs.
>>
>> I guess we should split this. I will add a 'required' constraint to the
>> rgmu constraints above. And apply the below 'required' constraint
>> specifically to 'qcom,adreno-gmu' instead of the 'else' fallback case.
>>
>> Please let me know if you have any suggestion.
> 
> Maybe the binding is getting to complicated and RGMU should have its own.

There is just a single chipset with RGMU and we haven't seen another one
in the last 8 yrs. So it is very unlikely we will see another one again.
So I feel it is not worth splitting this file just for RGMU.

Let me send another revision and let's take a call after that.

-Akhil.

> 
> 
> Best regards,
> Krzysztof

