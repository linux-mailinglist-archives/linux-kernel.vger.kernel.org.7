Return-Path: <linux-kernel+bounces-851648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 862E8BD6FA4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25BF94F7526
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF61A2877FA;
	Tue, 14 Oct 2025 01:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HqHUwIXZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415282877CF
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760404567; cv=none; b=Y89ZVCtR8M43SoFQbl0bm5jylZ1aaeN86Lb7xIrDHFAlM/MmremsoO6tj+LWCG/iHhg6MESKEKbeV8lNTQ2ENy4w0DSdo3vcvoPBnDNhTb2WggSnamegYR3Bcffcy7yb09fPr6koCR2p2/FNtX2QUa2yBMjkgp6glLARUY67ZSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760404567; c=relaxed/simple;
	bh=EP0dab8QWVw8F2Oho9PP3xZsSiVZ6Hs0NI1VFXmo3zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tun+UTBtQBHzKlqYrQoA8vu7jdxAeKa+aYl8KbghE5R31XFGxLWK1eWvHZ2PDCoStRzTtHAj0TtRtZEJlgGdezDlaN3dnDQ0i0arXn8cTZQ//BaZwAWt7zcHIxUWCi7H6aZfVEWaU+KpyDuJCrOWliRLMOwOjNwVgb4MjZ3Ng2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HqHUwIXZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DIMMpA024038
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aBxsTtnZ+1IYc29HTC1+91xtqulsSxhtxcQZF6gRcXU=; b=HqHUwIXZoBKQoLm1
	pp9KPIkA1VbhXLJqkbHHet1Mv+qQv6VU3XDUH5gCVQHInTgSTfDpS0Dn4HQSeiqA
	Dl7uf3cqUEfMBxGJ7DDx7B/2egqqQ4ZGG64EdWyj9ymBlg2UJX1CuFFRbFiRY/xt
	CDN0EfpocrBqJ942MJ8IEoPp37DvHcBzpZWY8NLbETyQLxwwV5wfdPSAOJr5YudF
	0rKubX8CwqHS61Fdrh5oQNXnEqKyIxUInCQ9Na0sLW7vHct065Q/wAFATzbHGV1G
	cjpAiZBkMdMscImjpnb+UvAfWpqB3e3lXl//XoDswk5c08YQh6InX+oE/+SLqKqW
	oXBa/w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwgy77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:16:04 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so8103967a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760404563; x=1761009363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBxsTtnZ+1IYc29HTC1+91xtqulsSxhtxcQZF6gRcXU=;
        b=KMtO0tt4my8LSEXZn6DYFgQJo3cc0VT+cfFJTwOHYs1WH7sPHnExfJzfTtx7Z9Ct/T
         vVUJn9M5r3S11WjNyttPjLymqaK1/bXvm/m4NkFx7JA+3CSVeAx1FvUe/aetv20cbVAH
         c3xTgGXDjjbKCqk7xRYKcPGulmB36xBsDmI6r/4ljmBzkTKXQOQdhI4IcpR6bWKt+r9J
         tNiMtj5WBj5YAiQUZ1TE0WgY7oqDJTfB1FUS8U3M36FAz6FvBXTsF4izM+asp2cMZxmn
         aJiwxP60nk667pDuoezcBwM4KrZIc7s1YawVkO+8VS96QIgw9QXtBytanSHEZ1Ak47p4
         ZWKg==
X-Forwarded-Encrypted: i=1; AJvYcCVXp43EewVBkvYuSlHFgc/gkDS0jpTnA35TakXjbGJH5J6jowea3A9dIH2x0234umkQpJ6tgEGyjDxeB3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqnBlZSHcDeawkhzujkKzrypHWnpK1FaMATcZji58aFXDG+y+w
	T7u464vfb4Fg2oBGKvOZU6LWbxerXvKM+zaBMZazKDONlFlrBCyMuZRCOUtyT8hqYx/LqLdXytJ
	pZbeLOygLoAX95YA5sHjr6zGUcMblwBsHO1DSLHy2+VYx2yQEAudbNpgQrTboZv2BFtY=
X-Gm-Gg: ASbGncs71tQZn1RV3jqZ5mPbgyAkoDs3npivHZm4lD6hii6qTJuQFSFPMP4Pzrumetm
	N3OxEu5cGO/qgFx5rX/SGmf+amwBRqPr/gb3K5ZFE3h/QHAvEB0pPYVcSpeTjFsIe1ilt17mhfi
	nXp5IXxR8rdyedoM4mp3YHOChFf9OSUIhafEngoAu9TTDI3tPRWTtIKSSMQiBZCXbwBAtcrhXRq
	nNWxEcNc3bljKKR9uL5k01ugE1R3QjRACw+VPP+ELAB4/kTp1oMxe2kOZKJwRG67QQ1VZPsPeev
	veHC7bVi6MG7ewtH/2iHwxgcrt2CO7/wNHO95h2lgImVvf+lpXDEmSYNk7Xa89dq6ewBLD/p9en
	j7NnjvQ==
X-Received: by 2002:a05:6a21:3394:b0:2ea:41f1:d54a with SMTP id adf61e73a8af0-32da8540764mr31709132637.55.1760404563423;
        Mon, 13 Oct 2025 18:16:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELt/YGsVm2PjjEZ477lrGaSp2HNzDVReiR0NJSLQK9e2H2AIf2ucuUQKdNf5z06//FvgGKdQ==
X-Received: by 2002:a05:6a21:3394:b0:2ea:41f1:d54a with SMTP id adf61e73a8af0-32da8540764mr31709094637.55.1760404562901;
        Mon, 13 Oct 2025 18:16:02 -0700 (PDT)
Received: from [10.73.53.19] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b065c40sm13045573b3a.10.2025.10.13.18.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 18:16:02 -0700 (PDT)
Message-ID: <2a70f878-269c-1b40-2e8c-77b5851de9a1@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 18:16:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 02/10] dt-bindings: phy: qcom,qmp-usb: Add Glymur USB
 UNI PHY compatible
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, krzk+dt@kernel.org,
        conor+dt@kernel.org, konrad.dybcio@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, kishon@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251006222002.2182777-1-wesley.cheng@oss.qualcomm.com>
 <20251006222002.2182777-3-wesley.cheng@oss.qualcomm.com>
 <f5e4ae02-b8fa-4406-b2e0-3602b07b7e23@kernel.org>
 <00408896-2e25-2dd1-6e6e-2195317ee7fb@oss.qualcomm.com>
 <14bc2a85-0f1d-3834-9b9c-32654348603a@oss.qualcomm.com>
 <387c707e-613d-433b-a76d-16ef10dabc59@kernel.org>
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
In-Reply-To: <387c707e-613d-433b-a76d-16ef10dabc59@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfX9QqziMuCeCPK
 cVIdb8zX7VJTdDMVFVTeHeTfjBk+/Qanr/1E4RFVqQgYkALepPwI2/ZvgWtMNJz0Ty4Yl1bVnbV
 OjYAPuc7Yj7L5S89QpPxI1vr8YTy31J4SJy8GTVb73ja4Wee/aMePpx7aDOJXd/DFPUCwRVGIsa
 DMe5rpZm2X0fcbk3bvIvxprmQgBz9/Wrzval1VFRp2gtzlkjFkMrINjwdc43HrAAL2WYRoUcuna
 YKXxWhxTmgrVX1yqi6lynfowVmV36SnBJfzRhDxetyLedA+q1dml7g39Ojq55xIFLpcrHCq2XYN
 77swhga/NfqrwSLnliFJxqCOkYmTyBtIdO0+VaX9VM2TUdgcN6fyfoIMey22ZtOAF/60psQh+PP
 qgB7c3yZH8eQrx6GarN9PmDvqybuYA==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68eda454 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=sZIQVmb-xcyDnIycNOAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: VJu27XgMQWNHDW96vGMF9fI01hIvjX-d
X-Proofpoint-ORIG-GUID: VJu27XgMQWNHDW96vGMF9fI01hIvjX-d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_09,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083



On 10/13/2025 4:50 PM, Krzysztof Kozlowski wrote:
> On 14/10/2025 01:46, Wesley Cheng wrote:
>>>>>      "#clock-cells":
>>>>>        const: 0
>>>>> @@ -157,6 +160,25 @@ allOf:
>>>>>            compatible:
>>>>>              contains:
>>>>>                enum:
>>>>> +              - qcom,glymur-qmp-usb3-uni-phy
>>>>> +    then:
>>>>> +      properties:
>>>>> +        clocks:
>>>>
>>>> Missing minItems.
>>>>
>>>
>>> Hi Krzysztof,
>>>
>>> Won't the minItems be inherited by the base definition?
>>>
>>
>> Ah...are you saying to define minItems to 5 as well, since we need to
>> have all 5 clocks handles defined to work?
> 
> 
> You need the minItems constraint as well, to define the dimension
> accurately.
> 
>>
>> Thanks
>> Wesley Cheng
>>
>>>>> +          maxItems: 5
>>>>> +        clock-names:
>>>>> +          items:
>>>>> +            - const: aux
>>>>> +            - const: clkref
>>>>> +            - const: ref
>>>>
>>>> What is the difference between these two? Which block INPUTs
>>>> (important!) they represent?
>>>>
>>>
>>> clkref is the TCSR reference clock switch, and the ref is the actual CXO
>>> handle.
> 
> 
> Then this should be named somehow differently. CXO is clock. Reference
> clock is clock... To me it feels like you are describing the same clock,
> just missing some gate in TCSR. But in case these are not the same
> clocks, you need to name it accurately.
> 

Technically its all handling the same clock branch (CXO), we have the 
TCSR clkref register that allows us to gate the CXO to the USB PHY, as 
CXO is shared across several HW blocks, so it allows us to properly 
powerdown the PHY even though other clients are voting for CXO on.  Then 
we obviously have to remove our vote to the overall CXO, so that it can 
potentially be shutdown.

Maybe we can rename it to "clkref" for the CXO handle and 
"clkref_switch" for the TCSRCC handle?

Thanks
Wesley Cheng


