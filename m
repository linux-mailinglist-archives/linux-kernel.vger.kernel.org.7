Return-Path: <linux-kernel+bounces-866208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80785BFF2CE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F6234F2D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 04:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDD524676B;
	Thu, 23 Oct 2025 04:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lVe3TA/A"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7E8242D95
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761195133; cv=none; b=e6brjIbAFxLL0kTlk77LcaB70Um20+GAxc2UR3hXi8olOlshjuthm8TZV6SXGTBL3LxQPJJHpPIsfYDMn+Fqwd+wvlmkXJRIZr/oryVxcKV3tMQzVNvwc2hM2KFO1CBkEUYrIlTihdB6hJ6IHWdlYA56aqoU2vyGJGZIb8e2+EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761195133; c=relaxed/simple;
	bh=fuznH2zWBFCQ/nXksrUJyWitjM0pBdwRhP+IXjYccGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgIGb06wjTsNU6PWYcYXYvrssoOC34kO9e7oenDFTIo6aCdzPnXcSpXuWnLZVu3+sgwXiV7nUUUkb2TI1YpbTNhfdfw2YcVEAJImOEadN5Kh9J5QAdSzb47lS4fC392YRCKg1ODhFvo43JOp4KXGBEnVF12SgpJoE3VxhQfnQec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lVe3TA/A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MIfAKx010394
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	44r1bl4Bha0tv0uPs/L15b2JDfXrJhQLdId2kUncqjc=; b=lVe3TA/AELQXgX2I
	ZvnRNdYtWHslDYCuZIDaZOCQsic0n5Y562EfOGoj+GeaPZkIVdiHySonwsiWeHZ9
	CWU2BAet/YbD+XZBFZjQnCPvLYfYuXTPfNpnCkbdIHMhBVIjNa/j5msuFIXZFRJd
	p2N6Ol3WqA6Wk81wPFsSBLp4taQ6REOE7MAOHK0o5rG8QCkQDRkBHynW3ISL6YL6
	fWSXTbuSjbihlGQGkvr1jWHSoyh8oJJD64CwqCEM/SubZJ5YsgrzNhCRqSyx5NdV
	9ikoiEFirVHmtuhl/em14K9DBAG367i1ED/XMqnqy2LBUAgMvEww2r0LnaPRol4j
	nA05MQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v34473sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:52:10 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33bba464b08so407787a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 21:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761195130; x=1761799930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44r1bl4Bha0tv0uPs/L15b2JDfXrJhQLdId2kUncqjc=;
        b=kPaWrKSOqAlIJA26nQwLD5Es0krBXZCLJBdSLU339eMc8t3lP1uA2OBJIkN1OQbhmt
         a08ZQGt0/LT3s2rTBZY9v1hcvn74VXeL4Yq5XC12ayhROrC6jik78r8K4xub1OFbbeyk
         5R/KgQDb1SNlqvArA1QXX4hvxFfUpLCymYfpR0QUMOvvT6KteWyZk8uFZWTUrDSs+592
         vRZG4e+/j81UtGnO5870JNaIPlLGvxCOHu8pxoirB/gkNTd9UM6lGTNCClj6sUVhtNzu
         LOiMPNaZBMpfSvoW7jljGdmLegBxo94t3kPyvs53tVFdyMWHc/7Ucys8B2jAVHIrDonq
         wMug==
X-Forwarded-Encrypted: i=1; AJvYcCWjyrN9nKk5gUF778SMEut1JwTULMojRj5k0IYbkoDYrGqucyFcQUq6E6cStEXVgLBgziGzRdvWD53O3pY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp44NAa8rfWu8Ml4PGHVEsDxKl1cqydIlJD1ON/konHathxJT1
	ywnSxdl7/Q290UWYZ4vbR7WPvDM0nnPzsr6bETdniRwaf0eJZHVOCWCLVmdop65DRCGTgPwO2Ga
	ioTzh8Giab+uVfpG/ZPWrfO2kajAqDPfiIua+auZFQKh2uOrOx45G/oETlVRn0lxkttahrMnbJr
	8=
X-Gm-Gg: ASbGncvgsaeyzcF6svRWu3j+VXT+CScH5ySP9FzTND6MLkOfxCvYQidJCDkMX5ojg+3
	b3QG/hHVx6HbxcLQMuq/IvN/9IpKVuwXa3xPST998jWhzmF8NJUKrdHqYKCcJpR7hNjgZA4Vzs+
	EDjx/auWob8al2vsgWAi6joyF8P2wYmgk8JBvAdKjHOuCQ5YyokzYPjrVnz163iql7NnW0oc7Ot
	TQQW0Vrn3xeZ7jy9fEe2Tp+EFMTSp2hLG7XFwDgvKLVyaa9Cw9s212LnPEUZPOXjd+CZ3Ky8/eo
	yCiL5m5A9B3N+eKhct/E6PWGFFoLGpq7gB1nxukXUp+/TujJkaWC9v6OtdFkLnlViAZdxD84NjB
	k5vNopQdkzP0h9YfV6qatyKLAvn/NgA==
X-Received: by 2002:a17:902:d60d:b0:24a:a6c8:d6c4 with SMTP id d9443c01a7336-290c9cf0f1amr286382215ad.26.1761195129604;
        Wed, 22 Oct 2025 21:52:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf+v+wMPthTdUqK0OmDXOcgI9WsjK0//yYkh6I74WoMUZR4qHiOirpwfvCoeQ/+ohMqH0prw==
X-Received: by 2002:a17:902:d60d:b0:24a:a6c8:d6c4 with SMTP id d9443c01a7336-290c9cf0f1amr286381985ad.26.1761195129065;
        Wed, 22 Oct 2025 21:52:09 -0700 (PDT)
Received: from [192.168.1.57] ([98.148.145.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e0f37a3sm9223315ad.83.2025.10.22.21.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 21:52:08 -0700 (PDT)
Message-ID: <d4b8cd74-0b0a-4fc8-8ed0-a9023a516b58@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 21:52:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] dt-bindings: media: camss: Add
 qcom,kaanapali-camss binding
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>
References: <20251014-add-support-for-camss-on-kaanapali-v2-0-f5745ba2dff9@oss.qualcomm.com>
 <20251014-add-support-for-camss-on-kaanapali-v2-2-f5745ba2dff9@oss.qualcomm.com>
 <dce1018c-6165-407c-8f3d-40859cb36b11@linaro.org>
 <1d6a20d8-b011-4608-a722-a1996b366a56@oss.qualcomm.com>
 <b18fc946-a249-481a-b727-7d3e49d47f8e@linaro.org>
Content-Language: en-US
From: Vijay Kumar Tumati <vijay.tumati@oss.qualcomm.com>
In-Reply-To: <b18fc946-a249-481a-b727-7d3e49d47f8e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ru9i7I_ID7nW6jxO8Pf13xZwnkqoNsss
X-Proofpoint-ORIG-GUID: ru9i7I_ID7nW6jxO8Pf13xZwnkqoNsss
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX0tfLmqwqNJUU
 hqaSdPg0oKpz3Dz1fpcj+wTQm+jRJtO7pfI1kv3DaeVmmsu2P/a28T1J4SlemoBSIyGwflqMUOe
 VwGzY1fk9D7mXasjBaKK1kwOwJ/MLxdDYH9SIXOK2pSnn+dTVI1ammTmP713MIi2f3JZgPAsjsi
 Yd/B+e+N+yrCNH97his84cDE6W5n9Fhv+8uR1XtouD5R8+cjCX3Jd5JPd7sFHZaS0wBKYkj1cdY
 P/5JkxH+KeBU+DmHC1rHrlEvPEdUIRJGI59efyE929YM1pl/AgLCC8PLx65mioOgXBVi8L+tAFE
 J/cPcZogBFvQXPfSaP0nLS62/pWkIDh2We840w7oG2OGBAM99oWmOEC6yAm7V/kkrvCnDxUBDFB
 jgstkxQPdD2ycxfX9VdU52YxSrkQtQ==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68f9b47a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=BiHMn5M11h/vNwziJwzFrg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=q19RU6WnuFYYO1jwFo4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023


On 10/16/2025 5:27 PM, Vladimir Zapolskiy wrote:
> On 10/17/25 02:53, Vijay Kumar Tumati wrote:
>>
>> On 10/15/2025 12:45 PM, Vladimir Zapolskiy wrote:
>>> On 10/15/25 05:56, Hangxiang Ma wrote:
>>>> Add bindings for qcom,kaanapali-camss in order to support the camera
>>>> subsystem for Kaanapali.
>>>>
>>>> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>>>> ---
>>>>    .../bindings/media/qcom,kaanapali-camss.yaml       | 494
>>>> +++++++++++++++++++++
>>>>    1 file changed, 494 insertions(+)
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/media/qcom,kaanapali-camss.yaml
>>>> b/Documentation/devicetree/bindings/media/qcom,kaanapali-camss.yaml
>>>> new file mode 100644
>>>> index 000000000000..d04c21103cfd
>>>> --- /dev/null
>>>> +++ 
>>>> b/Documentation/devicetree/bindings/media/qcom,kaanapali-camss.yaml
>>>> @@ -0,0 +1,494 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/media/qcom,kaanapali-camss.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Qualcomm Kaanapali Camera Subsystem (CAMSS)
>>>> +
>>>> +maintainers:
>>>> +  - Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>>>> +
>>>> +description:
>>>> +  The CAMSS IP is a CSI decoder and ISP present on Qualcomm 
>>>> platforms.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: qcom,kaanapali-camss
>>>> +
>>>> +  reg:
>>>> +    maxItems: 16
>>>> +
>>>> +  reg-names:
>>>> +    items:
>>>> +      - const: csid0
>>>> +      - const: csid1
>>>> +      - const: csid2
>>>> +      - const: csid_lite0
>>>> +      - const: csid_lite1
>>>> +      - const: csiphy0
>>>> +      - const: csiphy1
>>>> +      - const: csiphy2
>>>> +      - const: csiphy3
>>>> +      - const: csiphy4
>>>> +      - const: csiphy5
>>>> +      - const: vfe0
>>>> +      - const: vfe1
>>>> +      - const: vfe2
>>>> +      - const: vfe_lite0
>>>> +      - const: vfe_lite1
>>>> +
>>>> +  clocks:
>>>> +    maxItems: 34
>>>> +
>>>> +  clock-names:
>>>> +    items:
>>>> +      - const: camnoc_nrt_axi
>>>> +      - const: camnoc_rt_axi
>>>> +      - const: camnoc_rt_vfe0
>>>> +      - const: camnoc_rt_vfe1
>>>> +      - const: camnoc_rt_vfe2
>>>> +      - const: camnoc_rt_vfe_lite
>>>> +      - const: cam_top_ahb
>>>> +      - const: cam_top_fast_ahb
>>>> +      - const: csid
>>>> +      - const: csid_csiphy_rx
>>>> +      - const: csiphy0
>>>> +      - const: csiphy0_timer
>>>> +      - const: csiphy1
>>>> +      - const: csiphy1_timer
>>>> +      - const: csiphy2
>>>> +      - const: csiphy2_timer
>>>> +      - const: csiphy3
>>>> +      - const: csiphy3_timer
>>>> +      - const: csiphy4
>>>> +      - const: csiphy4_timer
>>>> +      - const: csiphy5
>>>> +      - const: csiphy5_timer
>>>> +      - const: gcc_hf_axi
>>>> +      - const: qdss_debug_xo
>>>> +      - const: vfe0
>>>> +      - const: vfe0_fast_ahb
>>>> +      - const: vfe1
>>>> +      - const: vfe1_fast_ahb
>>>> +      - const: vfe2
>>>> +      - const: vfe2_fast_ahb
>>>> +      - const: vfe_lite
>>>> +      - const: vfe_lite_ahb
>>>> +      - const: vfe_lite_cphy_rx
>>>> +      - const: vfe_lite_csid
>>>
>>> The list of 'clock-names' values is not alphanumerically sorted.
>>>
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 16
>>>> +  interrupt-names:
>>>
>>> Missing empty line to separate properties.
>>>
>>>> +    items:
>>>> +      - const: csid0
>>>> +      - const: csid1
>>>> +      - const: csid2
>>>> +      - const: csid_lite0
>>>> +      - const: csid_lite1
>>>> +      - const: csiphy0
>>>> +      - const: csiphy1
>>>> +      - const: csiphy2
>>>> +      - const: csiphy3
>>>> +      - const: csiphy4
>>>> +      - const: csiphy5
>>>> +      - const: vfe0
>>>> +      - const: vfe1
>>>> +      - const: vfe2
>>>> +      - const: vfe_lite0
>>>> +      - const: vfe_lite1
>>>> +
>>>> +  interconnects:
>>>> +    maxItems: 2
>>>> +
>>>> +  interconnect-names:
>>>> +    items:
>>>> +      - const: ahb
>>>> +      - const: hf_0_mnoc
>>>
>>> Please rename "hf_0_mnoc" to "hf_mnoc", see qcom,qcm2290-camss.yaml 
>>> etc.
>>>
>>>> +
>>>> +  iommus:
>>>> +    maxItems: 1
>>>> +
>>>> +  power-domains:
>>>> +    items:
>>>> +      - description:
>>>> +          TFE0 GDSC - Thin Front End, Global Distributed Switch
>>>> Controller.
>>>> +      - description:
>>>> +          TFE1 GDSC - Thin Front End, Global Distributed Switch
>>>> Controller.
>>>> +      - description:
>>>> +          TFE2 GDSC - Thin Front End, Global Distributed Switch
>>>> Controller.
>>>> +      - description:
>>>> +          Titan GDSC - Titan ISP Block Global Distributed Switch
>>>> Controller.
>>>> +
>>>> +  power-domain-names:
>>>> +    items:
>>>> +      - const: tfe0
>>>> +      - const: tfe1
>>>> +      - const: tfe2
>>>
>>> Please remove all 'tfeX' power domains, they are not going to be 
>>> utilized
>>> any time soon.
>>>
>>> When 'power-domains' list is just a single Titan GDSC,
>>> 'power-domain-names'
>>> property is not needed.
>>>
>>>> +      - const: top
>>>> +
>>>> +  vdda-pll-supply:
>>>> +    description:
>>>> +      Phandle to 1.2V regulator supply to PHY refclk pll block.
>>>> +
>>>> +  vdda-phy0-supply:
>>>> +    description:
>>>> +      Phandle to 0.8V regulator supply to PHY core block.
>>>> +
>>>> +  vdda-phy1-supply:
>>>> +    description:
>>>> +      Phandle to 0.8V regulator supply to PHY core block.
>>>> +
>>>> +  vdda-phy2-supply:
>>>> +    description:
>>>> +      Phandle to 0.8V regulator supply to PHY core block.
>>>> +
>>>> +  vdda-phy3-supply:
>>>> +    description:
>>>> +      Phandle to 0.8V regulator supply to PHY core block.
>>>> +
>>>> +  vdda-phy4-supply:
>>>> +    description:
>>>> +      Phandle to 0.8V regulator supply to PHY core block.
>>>> +
>>>> +  vdda-phy5-supply:
>>>> +    description:
>>>> +      Phandle to 0.8V regulator supply to PHY core block.
>>>
>>> What is the difference between vdda-phyX-supply properties, why do you
>>> need so many of them, when their descriptions say they are all the 
>>> same?
>> Each of these supply power to a specific CSIPHY and could be different
>> based on the board architecture. But I agree that the description should
>> probably capture that than just relying on the name.
>>>
>>>> +  ports:
>>>> +    $ref: /schemas/graph.yaml#/properties/ports
>>>> +
>>>> +    description:
>>>> +      CSI input ports.
>>>> +
>>>> +    properties:
>>>> +      port@0:
>>>
>>> Please use
>>>
>>>      patternProperties:
>>>        "^port@[0-3]$":
>>>
>>>> +        $ref: /schemas/graph.yaml#/$defs/port-base
>>>> +        unevaluatedProperties: false
>>>> +        description:
>>>> +          Input port for receiving CSI data on CSI0.
>>>> +
>>>> +        properties:
>>>> +          endpoint:
>>>> +            $ref: video-interfaces.yaml#
>>>> +            unevaluatedProperties: false
>>>> +
>>>> +            properties:
>>>> +              clock-lanes:
>>>> +                maxItems: 1
>>>
>>> Please remove 'clock-lanes' property, it is non-configurable, redundant
>>> and tends to store some irrelevant value.
>>>
>>>> +
>>>> +              data-lanes:
>>>> +                minItems: 1
>>>> +                maxItems: 4
>>>> +
>>>> +              bus-type:
>>>> +                enum:
>>>> +                  - 1  # MEDIA_BUS_TYPE_CSI2_CPHY
>>>> +                  - 4  # MEDIA_BUS_TYPE_CSI2_DPHY
>>>> +
>>>> +            required:
>>>> +              - clock-lanes
>>>
>>> The 'clock-lanes' property is expected to be removed.
>>>
>>>> +              - data-lanes
>>>> +
>>>> +      port@1:
>>>> +        $ref: /schemas/graph.yaml#/$defs/port-base
>>>> +        unevaluatedProperties: false
>>>> +        description:
>>>> +          Input port for receiving CSI data on CSI1.
>>>> +
>>>> +        properties:
>>>> +          endpoint:
>>>> +            $ref: video-interfaces.yaml#
>>>> +            unevaluatedProperties: false
>>>> +
>>>> +            properties:
>>>> +              clock-lanes:
>>>> +                maxItems: 1
>>>> +
>>>> +              data-lanes:
>>>> +                minItems: 1
>>>> +                maxItems: 4
>>>> +
>>>> +              bus-type:
>>>> +                enum:
>>>> +                  - 1  # MEDIA_BUS_TYPE_CSI2_CPHY
>>>> +                  - 4  # MEDIA_BUS_TYPE_CSI2_DPHY
>>>> +
>>>> +            required:
>>>> +              - clock-lanes
>>>> +              - data-lanes
>>>> +
>>>> +      port@2:
>>>> +        $ref: /schemas/graph.yaml#/$defs/port-base
>>>> +        unevaluatedProperties: false
>>>> +        description:
>>>> +          Input port for receiving CSI data on CSI2.
>>>> +
>>>> +        properties:
>>>> +          endpoint:
>>>> +            $ref: video-interfaces.yaml#
>>>> +            unevaluatedProperties: false
>>>> +
>>>> +            properties:
>>>> +              clock-lanes:
>>>> +                maxItems: 1
>>>> +
>>>> +              data-lanes:
>>>> +                minItems: 1
>>>> +                maxItems: 4
>>>> +
>>>> +              bus-type:
>>>> +                enum:
>>>> +                  - 1  # MEDIA_BUS_TYPE_CSI2_CPHY
>>>> +                  - 4  # MEDIA_BUS_TYPE_CSI2_DPHY
>>>> +
>>>> +            required:
>>>> +              - clock-lanes
>>>> +              - data-lanes
>>>> +
>>>> +      port@3:
>>>> +        $ref: /schemas/graph.yaml#/$defs/port-base
>>>> +        unevaluatedProperties: false
>>>> +        description:
>>>> +          Input port for receiving CSI data on CSI3.
>>>> +
>>>> +        properties:
>>>> +          endpoint:
>>>> +            $ref: video-interfaces.yaml#
>>>> +            unevaluatedProperties: false
>>>> +
>>>> +            properties:
>>>> +              clock-lanes:
>>>> +                maxItems: 1
>>>> +
>>>> +              data-lanes:
>>>> +                minItems: 1
>>>> +                maxItems: 4
>>>> +
>>>> +              bus-type:
>>>> +                enum:
>>>> +                  - 1  # MEDIA_BUS_TYPE_CSI2_CPHY
>>>> +                  - 4  # MEDIA_BUS_TYPE_CSI2_DPHY
>>>> +
>>>> +            required:
>>>> +              - clock-lanes
>>>> +              - data-lanes
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - reg-names
>>>> +  - clocks
>>>> +  - clock-names
>>>> +  - interrupts
>>>> +  - interrupt-names
>>>> +  - interconnects
>>>> +  - interconnect-names
>>>> +  - iommus
>>>> +  - power-domains
>>>> +  - power-domain-names
>>>> +  - vdda-pll-supply
>>>> +  - vdda-phy0-supply
>>>> +  - vdda-phy1-supply
>>>> +  - vdda-phy2-supply
>>>> +  - vdda-phy3-supply
>>>> +  - vdda-phy4-supply
>>>> +  - vdda-phy5-supply
>>>
>>> Please exclude supplies from the list of required properties.
>> One of these supplies is required based which PHY the use case is being
>> run. Can you please advise how to handle that? Thanks.
>
> 1. Please rename all of them, reference to qcom,x1e80100-camss.yaml,
> qcom,qcm2290-camss.yaml or published on linux-media 
> qcom,sm8650-camss.yaml
>
> 2. Remove all of them from the list of required properties, and in a 
> board
> specific dts file add only the neccesary ones, that's it.
>
Thanks. We will try to follow the same for rev3. Just a caveat though. 
If, for instance, two CSIPHYs have different 1.2 supplies and they are 
required to be operated concurrently, it may be is a problem? as we can 
put only one of those in the board specific DTS for the 1.2 supply node 
(ex: vdd-csiphy-1p2 in SM2290). Is it not? However, if we don't have 
such a use case requirement on the upstream may be it's OK. Thank you.

