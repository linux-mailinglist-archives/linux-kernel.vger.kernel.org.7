Return-Path: <linux-kernel+bounces-751896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CDFB16EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC39C4E2F07
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D05F4FA;
	Thu, 31 Jul 2025 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tb3mfCR7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECDB22425B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753955246; cv=none; b=jvhxUXjq7Frd9ccnPclGEz4YGvGLOPwpZ0PV6WekA0Dk74ECqWqtM3psi0Wy9ddnq3XR94qSK7ZcY0kNUPikCOsyQmPBbmovyNbOf2k9yZW01zdVJcRGhgpkmUDOg3AsOlnsbjW1N22/0Rnc7SRmyBoSiCpKIZElgbcRmaXpPUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753955246; c=relaxed/simple;
	bh=IBhBDCDc/hoa49pnfAR+QKQXMndrQBzqnwNrRd0+l6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HeNVliWeIEA4tNNomXYE4JPuifVnsyBQMECfGGw/E+kL4Zp8bVRyb0C/iL/xGi2q9QPdQnlp1YTJGmZJj8V7DGJV1BlEMH2VIat+OKA4Q8X7FUjD5nKjvYsq5E8DdLKe+3VresumvEfcs5cwqOquBGa6boQteuvvKSwolwzKmoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tb3mfCR7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V9fH3c016680
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0MKDZZ+5agMe9RsKHF0PqKWkUAHGtARi3inVO2hvokQ=; b=Tb3mfCR7428xlzQH
	ZUdxLhxqHLPl8IvDnzHOAiMiT3cElfWFWO7XgwLGbhoibwJvBEBz4lKC+ByoeTZz
	PbzE1qJKwq6XF/fvsBsz5Tz9xUV4hOIksekA83Z8ELZma87NEza+8BnaFlsZ025m
	jobPqz8G13bC+bV9M9i5yTEVQud+MgKg5+jhdu/6sc0zY0WrBB63VWSHIZAwBz3z
	lNYDbfhfWJ5rvWCjjEITV235eVFk6eTCPLI3O85TUYYLTBLFkvVKD7KXlhZeeEKv
	p3pRq/Pcmyq6qWHyZvL+DS7JJkpaQ6DXP9lftUMyX9XBmowlxQfu3hqGB7kuzZAe
	O6ZA6g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 487jwgbpct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:47:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7deca3ef277so25390185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753955242; x=1754560042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0MKDZZ+5agMe9RsKHF0PqKWkUAHGtARi3inVO2hvokQ=;
        b=q7dkfE7IKqiPd5c8QakQHrB82mxlVUO44QSb2xB08WoLTD4m40Qwu5qyQjLOGwXrgJ
         y3Ltegek+DsVQI95qzogP0ubbyn2qIBwfiAEyt9Nc1EL1KlNvzTBcRTfxcY1nMfVHIJE
         Xuidg5vw7pAmpKpU3IV/0oVeOVahddlI+vLOGXJGippqbwPw14xKwEtxsRxvL3Tu+b0P
         CBr0rXv/d0vjC7esk1WrVd1XMRa/Xesuhzjoo6REaSaYWXp0b4Yfu1UrAxlRfhmz1Lv/
         1wUrkE6ALITZ13/pTdBFSPIYZDBPM2VWq4So1R2UonoyEly7sK69mtwfMi9W0TC98f/E
         eVlw==
X-Forwarded-Encrypted: i=1; AJvYcCWy/7ltLnQd5EqQWySbKHcOPwzuaE4x0V5yCjjfjCpr+FUwbcOn4bI/UgSVBNMnRcvl0SwfAp9OI3gG/K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO8CE+fElb/Ne1/jDcvYsWRsCGHXLyviWV/ZlerctcY6+yTMZg
	tvjckFPdIQ3GgvJFPl5iR+I9/caOl2PjMDkM4b27bLzwjTSqgljaUrrB1l/OkPDqe8KE+ZYlni/
	CZZYbIHunMwtZ/2imUNIKhTpVwc2zi+h8kvI5B67Dqr95i+J+Rsn3munvj6jkpl1QKKk=
X-Gm-Gg: ASbGncuWtUMz9dSGW73bFk/9S1FvOcBcGBHpw9F1fcAXViS+8IyU6NUdPmUSvt3cBuH
	6Pa94qklg6seDhdThMOc55fPz04cnS7HfQC6iquCq7oozvdqC+YufiDCoK2H1rrnOkp1h0NvlAc
	lnDx3Cuk/Zrz0QmyggHrzMRoMgRSBFWnG/rrpJZvgSQ92lWIduWgyale4wvQiVCye5TfSPxKVkf
	LOVQKPg9oVXzcNgy0tOCBp+srTGFUQhWHLPCA82bfY/jjJ8Z1o09KKQ7jz1t7HxMu68zwWMyJCc
	1xuTSQHEXDmy8Cryjf0u6gK3P6QShTyQU267iDW9uh5WjMcuWo9IaUDT8qZz8v0wUMWRz2tWLbf
	EoSDwHr2maArlb4UoXA==
X-Received: by 2002:a05:620a:288d:b0:7e2:1609:a19a with SMTP id af79cd13be357-7e66f3463e9mr498343385a.8.1753955242131;
        Thu, 31 Jul 2025 02:47:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGETYpvGC8UoS+TadB6s1Bo0qeg/xDdxI9K0XTqqvffUNRJhuCXS6dOJHD8ewe0In6BBqm7+g==
X-Received: by 2002:a05:620a:288d:b0:7e2:1609:a19a with SMTP id af79cd13be357-7e66f3463e9mr498341485a.8.1753955241670;
        Thu, 31 Jul 2025 02:47:21 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e88desm82062066b.71.2025.07.31.02.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 02:47:20 -0700 (PDT)
Message-ID: <f6b16d1d-3730-46d1-81aa-bfaf09c20754@oss.qualcomm.com>
Date: Thu, 31 Jul 2025 11:47:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] dt-bindings: sram: qcom,imem: Allow
 modem-tables
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Alex Elder <elder@riscstar.com>
References: <20250527-topic-ipa_imem-v2-0-6d1aad91b841@oss.qualcomm.com>
 <20250527-topic-ipa_imem-v2-1-6d1aad91b841@oss.qualcomm.com>
 <97724a4d-fad5-4e98-b415-985e5f19f911@kernel.org>
 <e7ee4653-194c-417a-9eda-2666e9f5244d@oss.qualcomm.com>
 <68622599-02d0-45ca-82f5-cf321c153cde@kernel.org>
 <bf78d681-723b-4372-86e0-c0643ecc2399@oss.qualcomm.com>
 <62b0f514-a8a9-4147-a5c0-da9dbe13ce39@kernel.org>
 <747e5221-0fb1-4081-9e98-94b330ebf8c7@oss.qualcomm.com>
 <e4c5ecc3-fd97-4b13-a057-bb1a3b7f9207@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e4c5ecc3-fd97-4b13-a057-bb1a3b7f9207@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WvgrMcfv c=1 sm=1 tr=0 ts=688b3bab cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=pyDJoz5GBdBVa8UQv8gA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: lwdl6ALgQsoBtUN99Yfj4vfvVMlbomTn
X-Proofpoint-GUID: lwdl6ALgQsoBtUN99Yfj4vfvVMlbomTn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA2NyBTYWx0ZWRfX61nLlwyVjv9w
 Is2o4NmT03JlDOlYKX+4SUDIOot+tUPkJphYhcTZhj468qwzEEZEaWwtj68oZisWZrIUWjVKncg
 JqWjrMg7Ik5QmGcfQIcZ2bW1ARjkaxyBCDoSAjo9Z9SMa3694aIi1INrGcK33c8Rob5BKUxeFwp
 1K6z2LYarNH8jPBi2gLqTPkI5pRXB6xWf5+JiqjoywBeXw45nhsfWn/llOKduXOTXUh04hwkpvi
 Gg/Vo0mvrZEh0a6wzfxCtL7JcAfpFIYlRixRE0ZtdUgnT+fKGfqspCRVPe5AV7ASpX8u4qyhnCc
 xqurUyAidCA4woDwwmfaLeIPUZKjxv9KZlsN8omnqo+R82CiVtJ7/Zo3Dbj+FqwIboverrTNxKP
 ihlNbfH/IcypzwXMxcIaGyNqXQqbEJEs2xcKXKF2qhLtZscpu+h65OY8lKMu3oed6nHiugu7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=899 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507310067

On 7/30/25 3:14 PM, Krzysztof Kozlowski wrote:
> On 30/07/2025 14:07, Konrad Dybcio wrote:
>>>>>>>
>>>>>>> Missing additionalProperties: false, which would point you that this is
>>>>>>> incomplete (or useless because empty).
>>>>>>
>>>>>> How do I describe a 'stupid' node that is just a reg?
>>>>> With "reg" - similarly to many syscon bindings.
>>>>
>>>> Is this sort of inline style acceptable, or should I introduce
>>>> a separate file?
>>>
>>> It's fine, assuming that it is desired in general. We do not describe
>>> individual memory regions of syscon nodes and this is a syscon.
>>>
>>> If this is NVMEM (which it looks like), then could use NVMEM bindings to
>>> describe its cells - individual regions. But otherwise we just don't.
>>
>> It's volatile on-chip memory
>>
>>> There are many exceptions in other platforms, mostly old or even
>>> unreviewed by DT maintainers, so they are not a recommended example.
>>>
>>> This would need serious justification WHY you need to describe the
>>> child. Why phandle to the main node is not enough for consumers.
>>
>> It's simply a region of the SRAM, which needs to be IOMMU-mapped in a
>> specific manner (should IMEM move away from syscon+simple-mfd to
>> mmio-sram?). Describing slices is the DT way to pass them (like under
>> NVMEM providers).
> 
> 
> Then this might be not a syscon, IMO. I don't think mixing syscon and
> SRAM is appropriate, even though Linux could treat it very similar.
> 
> syscon is for registers. mmio-sram is for SRAM or other parts of
> non-volatile RAM.
> 
> Indeed you might need to move towards mmio-sram.
> 
>>
>>>
>>> If the reason is - to instantiate child device driver - then as well no.
>>> This has been NAKed on the lists many times - you need resources if the
>>> child should be a separate node. Address space is one resource but not
>>> enough, because it can easily be obtained from the parent/main node.
>>
>> There is no additional driver for this
> 
> Then it is not a simple-mfd...

Indeed it's really not

I found out however that the computer history museum (i.e.
qcom-apq8064-asus-nexus7-flo.dts and qcom-msm8974.dtsi) seems to
have used simple-mfd, so that the subnode (syscon-reboot-mode) is
matched against a driver

The same can be achieved if we stick an of_platform_populate() at
the end of mmio-sram probe - thoughts?

Konrad

