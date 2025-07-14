Return-Path: <linux-kernel+bounces-730611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF22FB046F0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22B31A66F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D0C267705;
	Mon, 14 Jul 2025 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YHQCd3V0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD398266F1D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515629; cv=none; b=SOrd8gYdONq4Sp/+hPrw+MRe4vw50+jyQ6FiPcARG5W59jSgdqRLQqOXazRwfX4RXaUJ0kyfhDdlll9fVwJm2QBGpA0nNCk6qpKVQuF5B5JpLdlxRZMb1uAo7dlJHWPXYTl+ZiAFAzB1K14mVuXnkxjcEDiVB5HKn854SqEpeTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515629; c=relaxed/simple;
	bh=YvsJN12SAY9OQ75DnDkBYqvaW6o0cntTB75m162ikOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J44KLY6a+hhOP0CW6Hj9aWNHSxvqJYPg1nfPcCk4tYJb0Ag1sd+3gViQM/fvWu2ByQ9XUmKljns4So0SGJD+7OVocCRaLbZX0NPe2vrIbeRlAyp2fiflABf5hZt8iBYLtWDW7NWtdttGwZrDpemZEMgc6YbzPYHUGqhwde1BvGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YHQCd3V0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EA4qYV031354
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fK6x+ly3xuI/2lAjrk6WHaK2Wj/VJnTiR8SzPU9LGHk=; b=YHQCd3V0Cae+VGUk
	84WIQIRbGymyYAmUvvD4+fCmV2kNvPOF6HVlOqX5DLwSrU6S70yklbcgbE/4BCL+
	EeN22p30ny++MTzzLnKEHGe51UUxwLOAJgUuS0WGNTIrTLnNOgIaKUYRn7yRh/Tx
	8OKLguXe81zaLvLUDJjY3O1ECX5PfZYGD5s8C70atShXlot5Y5W5hClCDa5B2Pp5
	Y4LD/R6L5paSi+da7NqbFjTDzxrtyETwZQO1CVwYdabfMwdbt8ue2kWMe43HHnJ6
	aGbxmaWCbzrXJk1NG2zKXdHN99bw12m1k7OrE9pgmYJ+zy2yL0Hy88DqR2D03cTL
	g/1Y/g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufvbdevs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:53:46 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fac4b5f949so2662706d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752515626; x=1753120426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fK6x+ly3xuI/2lAjrk6WHaK2Wj/VJnTiR8SzPU9LGHk=;
        b=Qcodk6ww5pffRm+1phavam6uyD8t2gaEn2DR2P+o/zdSx/DPYUW+4smY/YcYjvjIyu
         DkLlKiG5LNySePFuTRIEWIM+Bb2BGTpiv0c8jRUDr648Jr2qonZGGReDDwESlj3f1HFR
         cWyHDqtJau3USdpPiU+GJQcIncZJ1Htfg1GdHA1Ox6rj3XN172Sfqx+VF45lMh8scHxR
         dq9FT7bu85Yw+HaTJ0ylyg/I3eteJqstj0+rGgp+EsfuGxqsUUhvVkowaGw4M6+V/+Pd
         n4FKGBhHHAqKo6PDpbOVAPals7fR+gnAqS0QSJUMvzoPSTfin2CL/r7FoeRu7UcuBJvK
         kKTg==
X-Forwarded-Encrypted: i=1; AJvYcCXoopo2hKZ57MlBrYbeOjxCo5dAu6ssP/3vWU0vVMZOnx3u8AX+haOG+ZxvQJS35BX9B85c8rmusW8lkSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw+xC0s0fol3zjVa6zr2eXEv5gieH3wRYSZSnZdhX1DIDCj/hB
	BkOWRxYFERDTYEDaxg+wi8WFYnVWLH0Oa7BorRZfoL8sIMoYGoS7NjO0WLsvKKqSGl8A5hRlj3b
	X2LvFhP9L+pa6voH3JM8MCk+Cz6OCgrVtvXYQ0d8Y55t/4p0DKRSokmylXt3VSjEWO2Q=
X-Gm-Gg: ASbGncteIDNHBj22r9obHgFLwh8A2nJomAPX+H1/NSoujIq4J+oQdVllK7q0A2CbD3J
	ozoT0IFqtMFs+vFFJhQOkONPpu1MGKFSYzWGWKrnwILw7LZGvC5bFWmnj6XAa9MTC73bBx6asNr
	r3IyHcWuMTKazvSFFWfBBVyznsMEPjlZP8Ouf42tZsOfZ0aCZWDa+dEfhuCQkj2dyGXja7aJoUr
	5FtcRMGlt3Cwr07LG11hkVf5S/+gxP5RI7y8hH0FbbEndE+XQ7bYF8UdrmQmDufB+q18zFyxBNv
	uUYcfUGPqZYeS3p0HbMLsXuhC22hexQOCQXVgXrIALvPs2ihLgDUL5U2JObNqUC1SgAW0xw4Uue
	SpFGpp19L07G4zllMZRGX
X-Received: by 2002:a05:620a:618f:b0:7e3:2d1d:bda5 with SMTP id af79cd13be357-7e32d1dc30fmr148798085a.9.1752515625438;
        Mon, 14 Jul 2025 10:53:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH33J/OmI1AFTIjnQFvLICqDRKARWzq6lcWnIeXIfJs1esBEhAy06+UMvKScpJWaDTw5mOsbA==
X-Received: by 2002:a05:620a:618f:b0:7e3:2d1d:bda5 with SMTP id af79cd13be357-7e32d1dc30fmr148796485a.9.1752515624920;
        Mon, 14 Jul 2025 10:53:44 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c976ec04sm6252166a12.60.2025.07.14.10.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 10:53:44 -0700 (PDT)
Message-ID: <bf78d681-723b-4372-86e0-c0643ecc2399@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 19:53:40 +0200
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <68622599-02d0-45ca-82f5-cf321c153cde@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDExMyBTYWx0ZWRfX0EJU6uF6AELU
 myHkRXVTRzt/rYNHlS8hrf9CLpe/ReiRgNTrKiozo14+C6ObnJJm7d4OZhkSfx++bSQVmVcngGr
 xUB11JQBM/itX2KVWQib+MCnvyD6ncEnq65ovTbMGcDGofHF9Dv/qK6OBh/5y8TX3jjI7RzD13d
 7Ol/W//75Jo9mCyms74eHNfi4kMAi2xBViiqfw8eWEvR0QUOYBXyqQ0Co08jlwVoA4WBmwMl6QF
 J0n4C3YIz/S2oVhpXTYWVMIMpmlBlGhJRUo6lMlmDqKg4Gk7vgYBEhE7E/Y/iRChway9DZVc37Z
 780D9UdQgisBLoYOL1Dhi2ChtC7y69AbKpGz4UgJlarrEIUVxXKLEwUNWE0RJkqnVnVsJn47Adk
 oVSCS0elH7+kMF3ou3Htic9epfv4rX9/4T63grEul8AgrX6MsIlVdEsW6BJS63oGe5amoRh7
X-Proofpoint-GUID: xCDJJFaZJNnq87eLhSosmlIE5qI1eNUP
X-Authority-Analysis: v=2.4 cv=RPSzH5i+ c=1 sm=1 tr=0 ts=6875442a cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=kRKpuzDA6j_fRx5RDl4A:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: xCDJJFaZJNnq87eLhSosmlIE5qI1eNUP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140113

On 5/27/25 1:42 PM, Krzysztof Kozlowski wrote:
> On 27/05/2025 13:36, Konrad Dybcio wrote:
>>>> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>>> index 2711f90d9664b70fcd1e2f7e2dfd3386ed5c1952..7c882819222dc04190db357ac6f9a3a35137cc9e 100644
>>>> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>>> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>>> @@ -51,6 +51,9 @@ properties:
>>>>      $ref: /schemas/power/reset/syscon-reboot-mode.yaml#
>>>>  
>>>>  patternProperties:
>>>> +  "^modem-tables@[0-9a-f]+$":
>>>> +    description: Region reserved for the IP Accelerator
>>>
>>> Missing additionalProperties: false, which would point you that this is
>>> incomplete (or useless because empty).
>>
>> How do I describe a 'stupid' node that is just a reg?
> With "reg" - similarly to many syscon bindings.

Is this sort of inline style acceptable, or should I introduce
a separate file?

diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
index 7555947d7001..95fbb4ac9daa 100644
--- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
+++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
@@ -67,7 +67,13 @@ properties:
 
 patternProperties:
   "^modem-tables@[0-9a-f]+$":
+    type: object
+    properties:
+      reg:
+        maxItems: 1
+
     description: Region reserved for the IP Accelerator
+    additionalProperties: false
 
   "^pil-reloc@[0-9a-f]+$":
     $ref: /schemas/remoteproc/qcom,pil-info.yaml#

(fwiw checks are happy with the above)

Konrad

