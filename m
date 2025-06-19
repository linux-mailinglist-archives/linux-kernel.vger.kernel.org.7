Return-Path: <linux-kernel+bounces-693283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67710ADFD3B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 07:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668413A4147
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 05:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A80B24337B;
	Thu, 19 Jun 2025 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="npWxBd4M"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A4F242D77
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 05:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750312108; cv=none; b=ElymjIQ+HEzvU99HOXM8kXu83aFBCmqnSadtoqFiLUY9nJ5GSrw2rcivzY1X8mNY7Jh7mzsqSg+yDgiCQ2QL2ZLjsUH/pn3tf0ZFgVdWQA5E6MG+jwIx/kbu4aLu0Qv/B2adbF+kJ34g+nC5DbAwRFYkVpvJ4/5qRok7ofSBwjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750312108; c=relaxed/simple;
	bh=s3/gZi7BvAKq0izTDcQE28ZeRUR7J1PrwtDNYqPUSgA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uiwzSh3kFrr/mtFGAVcsyfdVndPwpiYs6jszxU+WCHN2Yab9kylc33NI7X5pAFH2vBqoo3Mi5J6X+0FckaK38zxUHp4dwMrGiK1DKUR1HGVtBXDSYRp0xsdIY/bXzRSpbHzgH08BSrHfY3arp3CXv+MX5P3kt5M4UpuGMUruLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=npWxBd4M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IM6TGq024378
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 05:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	++vri0wmuq+S4bVhSg02YGKQx2ZXW1B1U4mXepw29zU=; b=npWxBd4MayFb4nAN
	/pTreu4gx5S0HwfUjofGFdRcg7PWZ/IdNwJy/t6r1VKU8ZJPKUrJt8WIcg5gbOxE
	2KNkun+XRJ7Km/7GNvHyF5z8IrQC8sJgY6wP5W6nDB32RiHHO/MdcqWKhyUG1jDB
	OJbv7f8oFZYMpxBte8aESWlPzx0D7fRdZwDfhj/zFMOAo+llYuGjtv8iu/3T68Ac
	sNZjZfevBJyNgV0tGuxkC2BOppFQU4H6sozS3M87b8ivK9jX26kPT0km5z26PAgi
	65725JXp3LyS4E16qHsWSpIjC5lfnNDzCG1N2okQPSXgm2z3COimE/2cf9wx2iEQ
	xiaIKg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47bw13ap2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 05:48:24 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7398d70abbfso648734b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 22:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750312104; x=1750916904;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=++vri0wmuq+S4bVhSg02YGKQx2ZXW1B1U4mXepw29zU=;
        b=dnGtj9LoE3oIvQstEHrqAWU7qmomWAU+5FB+sV/vr8Y60pNetTau3CwBzLPzokREZH
         ID/p5cxHVnnREyADmnh7N8HfEl+YlnVx/Ozm55MXd7byRlPJ6ou35XDQgV/VfegO0brJ
         S1D4oNlQvgQ4phyh+7LDi+LVwyvuQCsxIZm2F5hcva0zgkC/86HYLKQ+lt3R8jPnzXYB
         x+e3Ubbty/OEc5rZvbZBqlkb0cvta6aFdvkUmoavbIklx9WK+zcpAegVa8UANTavxttz
         NFXfEqmN6/RLwoCW1GY37YyJHQVvmMt46LVFjQ+fDnY8zwUAccQo2N2qYYp1jZ1DUoDn
         nYFw==
X-Forwarded-Encrypted: i=1; AJvYcCVmTxVxAViMxR7mAP4MqceqH4aQW30ZjS8sVzxiOh9pfn2FcP/ntshDCFOLQBnIHadXpdai24m9uXPM6Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+wBWXcGPMzrnarCG8n1KNEkp/YPIX8jtgRkzUyrg1XIBeMeHf
	UZOb8fYnom7nwWdg2x8p+7dBBoxcvoBwnMFEeZksLFDuYAq33/JVYsrTXYRLGKESiKffju3GGt6
	CvWCc6qYLy8q1K2Ui21kpkpHsWYlWmPT6Ee+udESur1Q2RAt0nEQR3UguT5n+qm5ZW6Y=
X-Gm-Gg: ASbGncvvkI5mK+bbRqjpr8/GDqc7hoq/GGCaEJjMr53u03y9qvPMpzopMB0aWui1NfY
	MHwbyYfhfj4bfxOcBiWbAF+CGDCUHEvbrBm9OAwrvnUJ/dIXrOtjEjUWFscc+Xt9IMlDKiJ4zQj
	V+lWp4+Nqf0J5EQYnc5RxNbdSu7cb6HBGdsDC/BJwsNwlNggv3TA+6wgRiFwR9n7WQ7BpHdSXS6
	KRVBw7on3ZZVLpx+geJpQm/3nj0yp4dIhAY53Tp/O/ZciUlT/vnt1rNY6jh1w+rUwJSokDMNnrp
	kHLoFRWrl/4UOSRzfMJJgyOubQkIHBRY19p+iSha0+bekW0PKhc/j0N1qN7KHrQ=
X-Received: by 2002:a05:6a00:10cf:b0:748:e585:3c42 with SMTP id d2e1a72fcca58-748e5853f7amr7330817b3a.15.1750312103692;
        Wed, 18 Jun 2025 22:48:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtxbSYLcz+kWJraK0awdmVZZ0F++vhAr9IPxIQoqQJlXVvdgdCjVBs460bnIYuvcegcI88ww==
X-Received: by 2002:a05:6a00:10cf:b0:748:e585:3c42 with SMTP id d2e1a72fcca58-748e5853f7amr7330796b3a.15.1750312103305;
        Wed, 18 Jun 2025 22:48:23 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffeccfcsm12279470b3a.4.2025.06.18.22.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 22:48:22 -0700 (PDT)
Message-ID: <073480a2-0b6f-4dc0-b7eb-eec500b3106e@oss.qualcomm.com>
Date: Thu, 19 Jun 2025 11:18:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] dt-bindings: watchdog: qcom-wdt: Document sram
 property
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>
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
In-Reply-To: <a8b33510-c010-452f-9177-ce743b732d21@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QbBmvtbv c=1 sm=1 tr=0 ts=6853a4a8 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=NzB-Z5k-UKuyH_SqCfoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: EQJcfUVLILdIYyy20jXO4hsXUwLMnXxw
X-Proofpoint-GUID: EQJcfUVLILdIYyy20jXO4hsXUwLMnXxw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDA0NyBTYWx0ZWRfX73mSfksQDuWx
 OIvNNLNJXzH+iOG7Jx6XZAYREKeMM6o8L3q02BJsvSfBBHXKFUFLZjtM9ogh1MuBFc5Xd991VD9
 v/Q1faqp8oKVzhR3jsIh3CQAL/Sqss7AS/xFTcZxcWgWucFWhblVuxtYIektA+I4CYvXmrDxCW9
 5hwKDjxojboOXGvrpDuWnp0Tcgwc5ZFoQoWNpPvTmLgkul9pGB2iimsIRhee/UW71IN1zVSeKb4
 /yPOtVjc5IXSZqrmRtv67Bio0pQxt6UaRlWejFThCVQrsH5G+XJNR+euz/NFyFsKqU4Vyc6cL5x
 RGSU9ulse6mcJFI+5YmpFLSc8tbDr2fkfr81in7h5J+m5yS2tBBDnhFqRk1fCF93FLEUjToiwTw
 VlezJj07Sm8DsF5x8FC9oLpFC5uqA0otMZV8JX1//ILxdSjH9mVlmruwnyvs0tq8wKa5g1aJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_02,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 mlxscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506190047


On 6/16/2025 10:48 AM, Kathiravan Thirumoorthy wrote:
> Thanks Rob for the review comments!
>
> On 6/10/2025 11:33 PM, Rob Herring wrote:
>> On Tue, Jun 10, 2025 at 07:15:19PM +0530, Kathiravan Thirumoorthy wrote:
>>> Document the "sram" property for the watchdog device on Qualcomm
>>> IPQ platforms. Use this property to extract the restart reason from
>>> IMEM, which is updated by XBL. Populate the watchdog's bootstatus sysFS
>>> entry with this information, when the system reboots due to a watchdog
>>> timeout.
>>>
>>> Describe this property for the IPQ5424 watchdog device and extend 
>>> support
>>> to other targets subsequently.
>>>
>>> Signed-off-by: Kathiravan Thirumoorthy 
>>> <kathiravan.thirumoorthy@oss.qualcomm.com>
>>> ---
>>> Changes in v5:
>>>     - Rename the property 'qcom,imem' to 'sram'
>>> Changes in v4:
>>>     - New patch
>>> ---
>>>   .../devicetree/bindings/watchdog/qcom-wdt.yaml       | 20 
>>> ++++++++++++++++++++
>>>   1 file changed, 20 insertions(+)
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml 
>>> b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
>>> index 
>>> 49e2b807db0bc9d3edfc93ec41ad0df0b74ed032..74a09c391fd8e2befeac07f254ea16d0ca362248 
>>> 100644
>>> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
>>> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
>>> @@ -81,6 +81,16 @@ properties:
>>>       minItems: 1
>>>       maxItems: 5
>>>   +  sram:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +    description:
>>> +      phandle to the IMEM syscon node that exposes the system 
>>> restart reason
>>> +    items:
>>> +      - items:
>>> +          - description: phandle of IMEM syscon
>>> +          - description: offset of restart reason region
>>> +          - description: value indicate that the watchdog timeout 
>>> has occurred
>> A 'sram' property points to an SRAM region (see mmio-sram binding), not
>> a syscon and offset.
>>
>> The 'value' should be a separate property or implied by the compatible.
>
> Sorry for the delay. It was a long weekend here!
>
> Let me start with the requirement (Please feel free to skip it). When 
> the system goes for reboot, Xtensible Boot loader (XBL) find the cause 
> and update the particular offset (in this case it is 0x7b0) in the 
> IMEM region with the known values. On the next boot, if the system is 
> rebooted due to  watchdog timeout, watchdog's bootstatus is updated 
> accordingly, which this series tries to address it.
>
> Based on the previous review comments / discussions [1], it is decided 
> to go with the above approach, i.e., name the property to 'sram' and 
> let it points to the syscon region (IMEM) along with the offset to 
> read and what value to expect. So that we don't have to touch the 
> driver if either of the offset or the value changes across the platforms.
>
> Currently, IMEM region (which is a on-chip SRAM) in the most of the 
> QCOM platforms are modeled as 'syscon' [2]. So I have followed the 
> same approach here as well. Should I describe the IMEM region as 
> "sram" (mmio-sram)  instead of the "syscon" (existing approach) and 
> retrieve the offset and desired value from the compatible? or stick 
> with existing approach and name the property to something else? Could 
> you guide me here to proceed further?
>
> [1] 
> https://lore.kernel.org/linux-arm-msm/20250519-wdt_reset_reason-v4-3-d59d21275c75@oss.qualcomm.com/#t
>
> [2] 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/sram/qcom,imem.yaml

Konrad,

The bootloader team confirmed that the IMEM offset and restart reason 
value are fixed for the SoC's lifetime. Based on Rob’s suggestion, let’s 
pull these values from the device data using the compatible string. Let 
me know your thoughts.

Kathiravan T.

>
>
> Thanks,
>
> Kathiravan T.
>
>>
>> Rob

