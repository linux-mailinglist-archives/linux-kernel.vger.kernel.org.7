Return-Path: <linux-kernel+bounces-730271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FCBB0422C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5073A778A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F1C2571C2;
	Mon, 14 Jul 2025 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tnpj5prc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3964824678B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504679; cv=none; b=Z4WT56REOL7ORMfaKGp9s31i0Ony7LE+BtcCOJ23Y6+ooXwxqIX/WJhL1HizWOcvRJfu2pC1870oei51Wwhv0BDIQez2bnY0TG0O72XMfa34gRGGVblQ8mNvKFHGZUiQGH45e5WkKXZ+Fm2dsW9hgTz0A6wgbMsM6tOm7fPMGSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504679; c=relaxed/simple;
	bh=34c3k2JS0Ft1btNphYjTKqe1IWB+QrtfS49zngYMtao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clrjN+nm+RGmI7GVL239zXXk8gfAoichy4EX3goRyX1k4iqVuPj9glC8hb3KYogfELwQ2Ko8Pfm9pxfq2N7y3ZdKjIKmubZSlyBwpBDWr4nIjWs0G6QakHM5PdJ4DeIGNbA9S1byNiD3Q0jKsQ6GqkmiWHtLELnd9BC6Ce8JzLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tnpj5prc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9gqc4029781
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j9W4CuSLttgvJ6FyeozWzpAz4Cuh64rTL2lKSOstBnM=; b=Tnpj5prcJdQb1sjj
	DaqdXinNI+fa/pI24OGOYmul1c0U91R2/kJjbtdbblS4sUrouilbyd/2dEIhzF6u
	SPH784E5X9M5Eu672ZZfeDzjvGq3fOEcBN5S/+OOHhDFUB7yv3SgXEbFp834ndz1
	9P1zz4hT0jNXzreyesyzdBrVga4OjXHlGW52PZjs7iCuBHSMSI4JgYvRIsnrR5zE
	pEiHj8xERc/3fFLgNc2Qib1eGiwxCktRURQgYf6fWeArSxwd2Uz0Bmjl60ZYgEhe
	SyLN9CGqSMqRgYrLzGbLDtMPcE+I1szYfwMQvzoGJpHoBPBTx5K3NjGOuWw8RO9T
	6uP8pQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug37w2rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:51:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e2439259caso22213285a.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752504675; x=1753109475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9W4CuSLttgvJ6FyeozWzpAz4Cuh64rTL2lKSOstBnM=;
        b=CCV22KQ6QaozI+z1Q2rRDlGtooHpnQuAFnyQxqeDu959qAzBpl0z5abf1eqk7K3tPY
         sTgB4qo4aNOvs/3D/lyjMJZy5qPFc06f+OArEuVAA8cCYKf0Pl0/3KfCEISBYlML2W54
         dM2d/T3DP2t4RfRuxP1FKR/y+VXJq5sw8Pyz/siQVP6s/CFsfTsCzz9su2caKNTKaHYi
         1QstmKMdo0YcJeR4lwUbw2SkR0rdPUFFVPSujGiJgLM8rHOg/PUDSiKbpvGHmMDnK5zK
         gIOVR7l95o/2P3wjEBGHZXIN+HMxolPFON50wR4z3aXM685qvf7rk8yPmEmnQn9QBLdj
         bqaw==
X-Forwarded-Encrypted: i=1; AJvYcCV0bQdKaRJcOIzRdAb/8m6mr+L/jPVd+hOhL6mZ6ptHIDQSLJ8OCLuducwurcZtD5TrMuQnBFSXNDfkGI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZJOuoc+bMb1jpJnkHHvdRHPDumt13ZK+FigyUu+TWV1awQmjc
	wEEz7eqKMaFwqJpY360PVP42mcxJa01A7yAjaZtwGWZCcxSIJgFgmAOQSG+Go71Nf/GC8VnF4It
	TFY6v637IuvXrR0spmVuM65wzPkYWpNTKb12/vJaLQWlgUgrD5TSLr9gZAt/ok6HF+O8Nbux5X8
	w=
X-Gm-Gg: ASbGncu1Ycb/aXd10h7AgHld1WWVCL+/lQKLJzmxGBsEU+4pw/lSGobb0XiUnVp/tz9
	PvVkT1GmziFDPhBRtIWwWKtZl5KS3JnKXTZgzFVWZJSSnDL4xu3Agv1XsZKZ/LRpKH873EvLQx0
	heCskMh+g7NiQu33rnRecNlP3RdKFQpko1hr63RX7/GKXBzPvFJqsJTcfselGXSN2G2I3zli3L9
	0ymmtqwvhVFQ7O0VibI1FWcAE4JYnH6m1svjLT6JkqB59HNimL2jCSFb3HaDYKrv55UU+qDQOWy
	VyQaQmOEg7JGwCKJfPxBSNFIQeiW96wbMS0u58W/CdWBJk7GOO75a4pNbnNv4iz7TEUJDUWTTP9
	8k17eVHObC8vI1rEKkp69
X-Received: by 2002:a05:620a:44d0:b0:7e2:ee89:205a with SMTP id af79cd13be357-7e2ee893ba1mr225930985a.5.1752504674829;
        Mon, 14 Jul 2025 07:51:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE74z/KAqLPegwZP0R34v4pwdMd2EKA/Hi8iI61zdmqy3z3diiIL2Ji8kmWMZfmjJZIoWEzUg==
X-Received: by 2002:a05:620a:44d0:b0:7e2:ee89:205a with SMTP id af79cd13be357-7e2ee893ba1mr225927485a.5.1752504674098;
        Mon, 14 Jul 2025 07:51:14 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9542fe5sm6049190a12.35.2025.07.14.07.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 07:51:12 -0700 (PDT)
Message-ID: <39acdb37-e6f0-45e3-b54e-bd8a5905b2ec@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 16:51:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] dt-bindings: watchdog: qcom-wdt: Document sram
 property
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
 <linux@roeck-us.net>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20250610-wdt_reset_reason-v5-0-2d2835160ab5@oss.qualcomm.com>
 <20250610-wdt_reset_reason-v5-3-2d2835160ab5@oss.qualcomm.com>
 <20250610180345.GA2382213-robh@kernel.org>
 <a8b33510-c010-452f-9177-ce743b732d21@oss.qualcomm.com>
 <073480a2-0b6f-4dc0-b7eb-eec500b3106e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <073480a2-0b6f-4dc0-b7eb-eec500b3106e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4NyBTYWx0ZWRfX8GPv7OUXQZeC
 08jyslZeuYL9yZ5sac53YGUXcA2BvhBQ5A/iXuODaJepLaM31nph3cCR4qwrZ7P8R+XJSrsIIds
 colYW2asfQ26YDCLnUBpogUKnm6XrtqlM2PbuFAW29Gq0oJS4rBleRTDSc/IgQ2y9JoIQqYuipl
 kXkxZa0AGqtb4LE3I/VfL37aDT4eUA1Ena/29O7AapzSFoGowJ8rBcwoAr8bLSybyHwxhea2wYF
 eQ7EojfZkUPTdGkJKucjJ8FmUPMwsHFM40L2kmNCy/CP7aF1H2PUaAY+L4Pta2mANj5EDJvQT+m
 rpxG7qDZ3Wa/u7Xx9Se2iH4gZyQ+hXo3Odd5RkaZvh1GuGJ+gggf9c6rwf3FDwqsQ3aUq7T3sAz
 5LG1vlsZ6LhGMs1OX+aVulXc8TUwoXN9uH5q4SrTsE6VO9mfyQz48+pGE2KKrgEK38PAsyyh
X-Proofpoint-GUID: gJDlX8YkBctx6jzvOWWiUhvtsEGyKfuj
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=68751964 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=9B6XoSWOLoSC-pKoQf8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: gJDlX8YkBctx6jzvOWWiUhvtsEGyKfuj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140087

On 6/19/25 7:48 AM, Kathiravan Thirumoorthy wrote:
> 
> On 6/16/2025 10:48 AM, Kathiravan Thirumoorthy wrote:
>> Thanks Rob for the review comments!
>>
>> On 6/10/2025 11:33 PM, Rob Herring wrote:
>>> On Tue, Jun 10, 2025 at 07:15:19PM +0530, Kathiravan Thirumoorthy wrote:
>>>> Document the "sram" property for the watchdog device on Qualcomm
>>>> IPQ platforms. Use this property to extract the restart reason from
>>>> IMEM, which is updated by XBL. Populate the watchdog's bootstatus sysFS
>>>> entry with this information, when the system reboots due to a watchdog
>>>> timeout.
>>>>
>>>> Describe this property for the IPQ5424 watchdog device and extend support
>>>> to other targets subsequently.
>>>>
>>>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>>>> ---
>>>> Changes in v5:
>>>>     - Rename the property 'qcom,imem' to 'sram'
>>>> Changes in v4:
>>>>     - New patch
>>>> ---
>>>>   .../devicetree/bindings/watchdog/qcom-wdt.yaml       | 20 ++++++++++++++++++++
>>>>   1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
>>>> index 49e2b807db0bc9d3edfc93ec41ad0df0b74ed032..74a09c391fd8e2befeac07f254ea16d0ca362248 100644
>>>> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
>>>> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
>>>> @@ -81,6 +81,16 @@ properties:
>>>>       minItems: 1
>>>>       maxItems: 5
>>>>   +  sram:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>> +    description:
>>>> +      phandle to the IMEM syscon node that exposes the system restart reason
>>>> +    items:
>>>> +      - items:
>>>> +          - description: phandle of IMEM syscon
>>>> +          - description: offset of restart reason region
>>>> +          - description: value indicate that the watchdog timeout has occurred
>>> A 'sram' property points to an SRAM region (see mmio-sram binding), not
>>> a syscon and offset.
>>>
>>> The 'value' should be a separate property or implied by the compatible.
>>
>> Sorry for the delay. It was a long weekend here!
>>
>> Let me start with the requirement (Please feel free to skip it). When the system goes for reboot, Xtensible Boot loader (XBL) find the cause and update the particular offset (in this case it is 0x7b0) in the IMEM region with the known values. On the next boot, if the system is rebooted due to  watchdog timeout, watchdog's bootstatus is updated accordingly, which this series tries to address it.
>>
>> Based on the previous review comments / discussions [1], it is decided to go with the above approach, i.e., name the property to 'sram' and let it points to the syscon region (IMEM) along with the offset to read and what value to expect. So that we don't have to touch the driver if either of the offset or the value changes across the platforms.
>>
>> Currently, IMEM region (which is a on-chip SRAM) in the most of the QCOM platforms are modeled as 'syscon' [2]. So I have followed the same approach here as well. Should I describe the IMEM region as "sram" (mmio-sram)  instead of the "syscon" (existing approach) and retrieve the offset and desired value from the compatible? or stick with existing approach and name the property to something else? Could you guide me here to proceed further?
>>
>> [1] https://lore.kernel.org/linux-arm-msm/20250519-wdt_reset_reason-v4-3-d59d21275c75@oss.qualcomm.com/#t
>>
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> 
> Konrad,
> 
> The bootloader team confirmed that the IMEM offset and restart reason value are fixed for the SoC's lifetime. Based on Rob’s suggestion, let’s pull these values from the device data using the compatible string. Let me know your thoughts.
> 
> Kathiravan T.

So I'm not sure whether I proposed this before, but this is how I solved a
parallel problem for IPA, also consuming a slice of IMEM:

https://lore.kernel.org/all/20250527-topic-ipa_imem-v2-0-6d1aad91b841@oss.qualcomm.com/

Konrad 

