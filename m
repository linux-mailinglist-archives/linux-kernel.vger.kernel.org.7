Return-Path: <linux-kernel+bounces-863305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA619BF7804
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B02E75022A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CA7343D86;
	Tue, 21 Oct 2025 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e/F25Tl+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A952E65D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061910; cv=none; b=s4/OwMcJQMrFQBm4bIOyKOtgBny/2D9e+uV5us55s+YG1JPIk+J7JednUJ+wDf8UwGlcmhNUPeoX4BwDEvrSCe+c7X/+NaIEARhPirJ2YQhwQmC2RC/vhuhOg+uLnBA+dUeV7BlO8DI3f7nQfy3EMP0KIKZI9c8IgmqWuuvHMnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061910; c=relaxed/simple;
	bh=HeH8kNlcx3ibvgPdvwTGJTHubnRG4vvQXdwSeXq1lIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=inI5xu2UZsih2s+kfIlZEPiY291q//yLhAQ01Vm3mTTF7HGG/SLB6mQS5G/QafTs5KDLdRODrxdQncxgJVJpIw4by9pJS4kJ4neEmqXzQSVXutML7CC1v/C6s9ytAtfQGHRefwvR7B/6CbSrsN4YJ4x99h4NDNjbOCI+1vn9gMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e/F25Tl+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LEiwPb014165
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QA+SGH9BRJ0ma1obWpO6OlmiAFE4VJLnzS8FLoARyTE=; b=e/F25Tl+h8sWHYgN
	qvrc5p3XKsRTka3smGrVa7k1Z424Gz+NAR3Uu2VZ39/0qVMtqp/smSTvk3v1rhdG
	BaHNf/VBKEVRfqcc5Lls4EIvBkfyPPbjHunncXpK7CXHVMTteGpv3TB87SJHOSVK
	kBuVupPida5ih416imHw7K8x5mrXzusNjGUFCn4ZNAf2oqkceWxyzTq5SkSL+owf
	48xHeMBmw2EN/NCIiJrncG3DsMXURpN28ewI/rXyEFeclrzA4mJlNaCwa8znshCj
	S38wQpcn03Yk//QCuHvf9YhqrB+1P1A7zPwLHy9i4o3CA6UfgT8xP8bq3zRolFvS
	ZbseKg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49wtgeukc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:51:46 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-792722e4ebeso5368968b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761061905; x=1761666705;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QA+SGH9BRJ0ma1obWpO6OlmiAFE4VJLnzS8FLoARyTE=;
        b=U+FTryyO/cjCuJZSqmGAbtHNLG9Z4tx7xHf44elvRq2AWUGNP4UtBTilh5p6AS4hIZ
         UsL16lozn6pASkdqUNGKMG8zeTNFoIBzlKJdU63SBnauw1QCjvmahkseZoEGOuWbZ9m7
         RpzgykaYkCVahRaYynprTzIreJ8OLN4LQQYLOES9RpKhueVHkqSYjyl+xVp+gYRfMLDT
         oUam1uBk4PApTM4TlN9d3pV5a9XTnK7mWwzfv4HwGUjnufdcr5J1hLjHRde7dM6QptWt
         xIZhIMPdFIZSYSUh6mlf0i2cBGToc0j0yercNZeAcu1WsLIdXQo7LiyfPO8m+2p8t9gf
         Rm2w==
X-Forwarded-Encrypted: i=1; AJvYcCVpTmTsGA6OIsH5GMVzvm8uHNR7xcSmG+pzw/hs6bhhhwBvZhHL9uPbnzQyrxtu3hnDMBEaeI6I31nXDyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRFVq/BXlGGpXUkZVcFSceHF3NOvqPnAT9TrAM1VCC1ce4unEZ
	DroIZM5ZGpuQk3rHxpuul6zfvDQUWoAypKjkhfdUCujYW4p4Pl+Qx5KGsmj9yIz37QyWvdE+FTu
	xyp+aNeLBaITzBo0bbs8h6nSftsJO6+uonp+q5BBJtfROQfAzdNpDky7iwvp5oUUb2IQ=
X-Gm-Gg: ASbGnctxtegQ7tiRXBut6raa6axxIHkLPV/8+oeYj1AnvMpSLfBJ0eN4ZgTr5zyUzDz
	kW1DO1ezmC8H5lW58FHrbwUq4tbdJKL/CZLtAGzDLySVtkidu7sRlLtXDzudxuFvAyOyn6vxX1i
	7dj7Xk92qi33UPrv+UhSWS7BQqOxRwWxGNbWqgqaD5xGmrAcyjNQofIXW6QTKsb6u/CAL54p0fG
	MyUyWvGTJenfI1DAKDDLB+i3L9mW1duVLyY+VwaAprySlsVkHaA7gKcqhi6KMmpk4S+U08nzAnB
	o3Mf4VclmnSHRoxwwBS/neyIHia0eWnfzZvbyCYeikSiQuHQzArc3n0jFqIDu6KjEwBe6iPIMGd
	ogwsk0l4UOep2i5Z6N74H6A==
X-Received: by 2002:a05:6a21:99a0:b0:32d:b925:276b with SMTP id adf61e73a8af0-334a8523dc3mr22535830637.4.1761061905399;
        Tue, 21 Oct 2025 08:51:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHpQcvweF2xt590lxQ0r+ZD4/+/QPgjpSYlH4eFm6Hkm1wvNrCcND/jZo/4fo2HgPZ9UZ6iw==
X-Received: by 2002:a05:6a21:99a0:b0:32d:b925:276b with SMTP id adf61e73a8af0-334a8523dc3mr22535788637.4.1761061904855;
        Tue, 21 Oct 2025 08:51:44 -0700 (PDT)
Received: from [10.204.104.20] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2301211besm11597489b3a.68.2025.10.21.08.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:51:44 -0700 (PDT)
Message-ID: <181af756-09a1-4694-98c4-53cea556e172@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 21:21:37 +0530
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
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8f3f4874-2e82-473e-87bd-e3bd58089b90@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xaBCHTM8uWrKTwtovgXDEUBiEIt7bXy5
X-Authority-Analysis: v=2.4 cv=JeaxbEKV c=1 sm=1 tr=0 ts=68f7ac12 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=0jTnGb_4dxt76ar0_UAA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: xaBCHTM8uWrKTwtovgXDEUBiEIt7bXy5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE1NCBTYWx0ZWRfX9MlyL1yyYbI/
 nbNletYr+RQoISprxk55QtePBYnYkzu6KNQsLb6UeiX/B6+GIsRN2Xhqg8lZiJCTQNHsKGPuCTs
 fX2UmCEAhnB+jkhEH9JTDDJDjKvcScicDZffjq81YK5FzReinlO7H2unDye6OgTy0tT++shyvVL
 RdFooOYt6whw5MagqGJ7Oi/rCQh62KuMaEr6J1/L8HReIKxK/CXuRAH3Bu0mWo9Xw/5KrrdL47X
 quBRv4N7+lLaagg0IvBO6sjZA8spOJI5wybB+dsI58ieAvAdAhNEO1GTSUJh2KjidHu8fU+HcdN
 v5eSHusi0x9ziMNeEyOKs9PMSF2xQCCZ2txjZijFGdv7QeH8OmOxAWfW97Q69yre9sVaumsJMjQ
 PBwKJZIHQvKj9s/xsv0+eN65VslzoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200154

On 10/19/2025 2:43 PM, Krzysztof Kozlowski wrote:
> On 17/10/2025 19:08, Akhil P Oommen wrote:
>> RGMU a.k.a Reduced Graphics Management Unit is a small state machine
>> with the sole purpose of providing IFPC (Inter Frame Power Collapse)
>> support. Compared to GMU, it doesn't manage GPU clock, voltage
>> scaling, bw voting or any other functionalities. All it does is detect
>> an idle GPU and toggle the GDSC switch. As it doesn't access DDR space,
>> it doesn't require iommu.
>>
>> So far, only Adreno 612 GPU has an RGMU core. Document RGMU in the GMU's
>> schema.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  .../devicetree/bindings/display/msm/gmu.yaml       | 98 +++++++++++++++++-----
>>  1 file changed, 79 insertions(+), 19 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
>> index afc1879357440c137cadeb2d9a74ae8459570a25..a262d41755f09f21f607bf7a1fd567f386595f39 100644
>> --- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
>> @@ -26,6 +26,9 @@ properties:
>>        - items:
>>            - pattern: '^qcom,adreno-gmu-x[1-9][0-9][0-9]\.[0-9]$'
>>            - const: qcom,adreno-gmu
>> +      - items:
>> +          - const: qcom,adreno-rgmu-612.0
>> +          - const: qcom,adreno-rgmu
>>        - const: qcom,adreno-gmu-wrapper
>>  
>>    reg:
>> @@ -45,24 +48,30 @@ properties:
>>      maxItems: 7
>>  
>>    interrupts:
>> -    items:
>> -      - description: GMU HFI interrupt
>> -      - description: GMU interrupt
> 
> 
> Both stay, just explain what is the first interrupt. You should not drop
> descriptions here. Look at every other binding - of course except that
> terrible Adreno GPU which is anti-example.

Do you mean we should use a OneOf and list both combo? Or elaborate the
description of the first interrupt to include OOB too? Something like:

- description: HFI interrupt on GMU and OOB interrupt on RGMU.

Sorry, I am a bit confused.

> 
>> +    minItems: 2
>> +    maxItems: 2
>>  
>>    interrupt-names:
>> -    items:
>> -      - const: hfi
>> -      - const: gmu
>> +    oneOf:
>> +      - items:
>> +          - const: hfi
>> +            description: GMU HFI interrupt
> 
> No, descriptions never go to xxx-names, but to xxx.
> 
>> +          - const: gmu
>> +            description: GMU interrupt
>> +      - items:
>> +          - const: oob
>> +            description: GMU OOB interrupt
>> +          - const: gmu
>> +            description: GMU interrupt
>> +
>>  
>>    power-domains:
>> -    items:
>> -      - description: CX power domain
>> -      - description: GX power domain
>> +    minItems: 2
>> +    maxItems: 3
> 
> No.
I will keep the 'description'. Here, RGMU has 3 power domains instead of
2. I suppose we should add the description for the 3rd power domain here
and keep 'minItems: 2' property to override the default 3?

> 
>>  
>>    power-domain-names:
>> -    items:
>> -      - const: cx
>> -      - const: gx
>> +    minItems: 2
>> +    maxItems: 3
> 
> 
> No. Why?
Same as above.

> 
>>  
>>    iommus:
>>      maxItems: 1
>> @@ -86,6 +95,44 @@ required:
>>  additionalProperties: false
>>  
>>  allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: qcom,adreno-rgmu-612.0
>> +    then:
>> +      properties:
>> +        reg:
>> +          items:
>> +            - description: Core RGMU registers
>> +        reg-names:
>> +          items:
>> +            - const: gmu
>> +        clocks:
>> +          items:
>> +            - description: GMU clock
>> +            - description: GPU CX clock
>> +            - description: GPU AXI clock
>> +            - description: GPU MEMNOC clock
>> +            - description: GPU SMMU vote clock
>> +        clock-names:
>> +          items:
>> +            - const: gmu
>> +            - const: cxo
>> +            - const: axi
>> +            - const: memnoc
>> +            - const: smmu_vote
>> +        power-domains:
>> +          items:
>> +            - description: CX power domain
>> +            - description: GX power domain
>> +            - description: VDD_CX power domain
>> +        power-domain-names:
>> +          items:
>> +            - const: cx
>> +            - const: gx
>> +            - const: vdd_cx
> 
> This does not make even sense. Why did you remove the the common list
> from  power-domain-names?
> 
>> +
>>    - if:
>>        properties:
>>          compatible:
>> @@ -313,13 +360,26 @@ allOf:
>>            items:
>>              - const: gmu
>>      else:
>> -      required:
>> -        - clocks
>> -        - clock-names
>> -        - interrupts
>> -        - interrupt-names
>> -        - iommus
>> -        - operating-points-v2
>> +      if:
>> +        properties:
>> +          compatible:
>> +            contains:
>> +              const: qcom,adreno-rgmu
>> +      then:
>> +        required:
>> +          - clocks
>> +          - clock-names
>> +          - interrupts
>> +          - interrupt-names
>> +          - operating-points-v2
>> +      else:
> 
> No. Don't nest multiple ifs.

I guess we should split this. I will add a 'required' constraint to the
rgmu constraints above. And apply the below 'required' constraint
specifically to 'qcom,adreno-gmu' instead of the 'else' fallback case.

Please let me know if you have any suggestion.

-Akhil>
>> +        required:
>> +          - clocks
>> +          - clock-names
>> +          - interrupts
>> +          - interrupt-names
>> +          - iommus
>> +          - operating-points-v2
>>  
>>  examples:
>>    - |
>>
> 
> 
> Best regards,
> Krzysztof


