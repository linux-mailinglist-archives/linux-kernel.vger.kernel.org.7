Return-Path: <linux-kernel+bounces-851563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8040BD6C56
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376EF3B995F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DA12DCF45;
	Mon, 13 Oct 2025 23:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hPgki7Z5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013EB27280B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399203; cv=none; b=j/UVSUC/uAcJMmVRiWVjuub92+tkPr0OLruJLuXNQ4+YtY1mGtYKM2b/H+vc7bc2XFWvDr/DZkyNxRcWWlKY44xKx383gbe6bmNtW/iWq8wAxWMi8AP2uwsC3BZENy9efGBe/wk7E8CTYwupaP2Xsi+fHEA82a5q4jOKO3ncVNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399203; c=relaxed/simple;
	bh=YnzpM7Y3mBbh8bZ2to50Hng5XokBr3pWjqm6tkmbauI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZCbkrYBfjDp4L5Pi0N8s2Bm18+kNvovve27LtfYh1oqUCNGJuWfkZmOZTpAlGnvcGIapeuCXYcWHcRr2fwSFU095fPLrCzbybmfv8atylgypN85a7mnWsB3A70El6H5KVOvahkVBvSj2O/u20rSN5qvRYR5tqMJ5y4pZKG3K52I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hPgki7Z5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DHDUWi004001
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0gy/eN2/a4rW4UleojofitvwB4RNCpSUHYOp2DX/Fow=; b=hPgki7Z50ZRq9hOS
	T0nU3sRtj5IwJhU54lR2Ukes3zX+phYc0nNsOojUpxwBphdIFvIuAKwxB9/u0kSX
	0gHzwEqq4V7MM6Ua+JNVpUWEloc6KdRMv193ISgAbr9iZrwMh44PbTQgR7kZVChC
	oeWhFKwEqx9Xy/E42igqPdtpgM/Xb+ajdnQ4OcReHQIrARHp9HiPnVo3CBX2y1ST
	mWM+Oe2kKEnltiecr8PjuX9Ji+TJUjuAsADqBCN+ctUMsutIMi8h03NMIJXeYYFX
	Hy9xIo9kT0U5cB3wEPUbFYS2tfnTHOnoh6UAkjCkI7LWhE9ZJFL2g0MPvgZUwzqw
	y27OoQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0pgfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:46:41 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-28bd8b3fa67so76789145ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760399200; x=1761004000;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gy/eN2/a4rW4UleojofitvwB4RNCpSUHYOp2DX/Fow=;
        b=iH7MwXedHL00yJOXHeqSy/BIbTKkUYwE5bbJJs+VvsN+B6WKQrjAfKKIZ0uYf83p0E
         GZPJPX2ohVIoamTW+qSP2FCiTGgS00qt6agXZrVeT2sWhj9WoWGsNF0fkcBcQXfxtvDL
         tN99DWIVwFHRI2YqhvCdAiZ/L/IVWO4LwZv6axzcwYRllWcmfNO9tsa1WL7rXhShvF93
         ehB5b7/lNOo6WD+g3GBBvdw8xaLp2QGdL2S+hs/ZEWFrFG1TqScChqHj2ag1h6U10jR7
         GnYFshFOS1KhC8c24XACEL3lCMYCYq37/1sVSWJoYq+pgDAhkGFloSn2N+CurZnbAYwL
         CUBw==
X-Forwarded-Encrypted: i=1; AJvYcCXnMMgTpNd+q5RHMCUOVf5SRYFko+l7tvAN6DQG8NjAybqFJgsdlrxQwKXmtobXiCrglebr1j2Vv3eBdQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRWj3RFe+6vbx8dt9BclmxovhCbMGniRryIPet5xAh4DM+fYSx
	sezJXIhMdN8jA3/BNlRz27mqKqTLytTazySKh+urERd61vEfggHt1+JJ2DyvcJDj3k8pWmcDP0+
	Ka0isO99+BH5Kn9lYV8YVZpkKAfgYE5axjjRYoFh5iUS5Z9/nZbv6AjSPxVh0ynqyi3I=
X-Gm-Gg: ASbGncu9qz+iTzdE5HK2ZQIrUWIINzOklFApnxWe2agd7N80jh7HSEuXBdlwxXBCqxm
	VMLuNxRufk7YTjtr4FybOiGHFN7O75ZEh9/R883j9Xiq9cDyeaJ/hX25zFN9RFstVXNqAwt3Jqx
	7gSLJbMpBMzjIpn+Pbo73PBlYPX4mbSgeEecpfoHw7V89l6Nr+sCsjyxiaJBg9+tEJGPNoAsrIf
	MkKrNnCSZrezba8GoM5fEGWLpqBPpB/Ruvce6QWG7QyMCgyBNMt7BNAvUDnfNcvAeOrOKlHtpQJ
	01z7PaJfrhSv8V1t9v29LenSl32+gV8qoHt3TqfhGqpXerieIsh+P4nDsww26/Gd8M6opqahqub
	6xLYyMg==
X-Received: by 2002:a17:902:da85:b0:26a:f69a:4343 with SMTP id d9443c01a7336-29027216513mr239372525ad.4.1760399200288;
        Mon, 13 Oct 2025 16:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnOgt3lwzbUvcJDvzNbU5nzvH3UjGpjKLKhZpUQXp9HGXcUzbD6NyyhTRMy3UAHlSc/tkmkQ==
X-Received: by 2002:a17:902:da85:b0:26a:f69a:4343 with SMTP id d9443c01a7336-29027216513mr239372215ad.4.1760399199808;
        Mon, 13 Oct 2025 16:46:39 -0700 (PDT)
Received: from [10.73.53.19] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29076d7af28sm10202415ad.118.2025.10.13.16.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 16:46:39 -0700 (PDT)
Message-ID: <14bc2a85-0f1d-3834-9b9c-32654348603a@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 16:46:38 -0700
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
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
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
In-Reply-To: <00408896-2e25-2dd1-6e6e-2195317ee7fb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX6E5GhikTjC0x
 FPc4rwoYObaKbiQHMBIZgtte6Qd2vTcG3UVKY8EOth8wLDpjZyfnXrfbjaDr7hrdcKu0RqDrHHy
 U1QR4oMN81NDWjJW8z1JioVA6uMEVXzMggxSFV2cq1ONUE0cQc4O+tGhZyzx5ChMFqv5SU4Cjr4
 2P/x3NoyT+wv9XuKb2LafFDVZCZrIdScrp7evd1qmJgB7OGtMQbmFTA7Wo4HQPAiSvcj723bRJ5
 WQZN8tXuE3Cuh5Vu9FM3vyO3pCoVc3ZYUnYoax+0z5rcDwbbPpY/G1IRdpBVoSvP+2p+mpSTNm8
 hE9rlLktoENAxvqLfD+y1g5aLhK52KtHe2ZlFxEKC1PBIWvKqP/UQejvpUCqz/pYLuicbko9Jag
 BZy8FACUtYQxrzi7FmEnH1ynR7lM9w==
X-Proofpoint-GUID: osDHiRPCgJqs58E6q0YP7jtRSzRgMXLW
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68ed8f61 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=qShf3X6Dcnx_eSjzdeYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: osDHiRPCgJqs58E6q0YP7jtRSzRgMXLW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_08,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018



On 10/13/2025 4:44 PM, Wesley Cheng wrote:
> 
> 
> On 10/10/2025 5:04 PM, Krzysztof Kozlowski wrote:
>> On 07/10/2025 00:19, Wesley Cheng wrote:
>>> The Glymur USB subsystem contains a multiport controller, which utilizes
>>> two QMP UNI PHYs.  Add the proper compatible string for the Glymur 
>>> SoC, and
>>> the required clkref clock name.
>>>
>>> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>>> ---
>>>   .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   | 35 +++++++++++++++++++
>>>   1 file changed, 35 insertions(+)
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>> index a1b55168e050..b0ce803d2b49 100644
>>> --- 
>>> a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>> +++ 
>>> b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>> @@ -16,6 +16,7 @@ description:
>>>   properties:
>>>     compatible:
>>>       enum:
>>> +      - qcom,glymur-qmp-usb3-uni-phy
>>>         - qcom,ipq5424-qmp-usb3-phy
>>>         - qcom,ipq6018-qmp-usb3-phy
>>>         - qcom,ipq8074-qmp-usb3-phy
>>> @@ -62,6 +63,8 @@ properties:
>>>     vdda-pll-supply: true
>>> +  refgen-supply: true
>>> +
>>>     "#clock-cells":
>>>       const: 0
>>> @@ -157,6 +160,25 @@ allOf:
>>>           compatible:
>>>             contains:
>>>               enum:
>>> +              - qcom,glymur-qmp-usb3-uni-phy
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>
>> Missing minItems.
>>
> 
> Hi Krzysztof,
> 
> Won't the minItems be inherited by the base definition?
> 

Ah...are you saying to define minItems to 5 as well, since we need to 
have all 5 clocks handles defined to work?

Thanks
Wesley Cheng

>>> +          maxItems: 5
>>> +        clock-names:
>>> +          items:
>>> +            - const: aux
>>> +            - const: clkref
>>> +            - const: ref
>>
>> What is the difference between these two? Which block INPUTs
>> (important!) they represent?
>>
> 
> clkref is the TCSR reference clock switch, and the ref is the actual CXO 
> handle.
> 
> Thanks
> Wesley Cheng

