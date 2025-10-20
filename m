Return-Path: <linux-kernel+bounces-861528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BD26CBF2F79
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3137734E590
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF212D062F;
	Mon, 20 Oct 2025 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L5a5tW1P"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54519202961
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760985546; cv=none; b=OkTuMrbKD2IHrFxfnEvabb6NGavafclUSyYPQtuCg2xUG0Htm+5+X4azfEQIKsSkAYgEBtBxV1kaBZTqn/dQlWtaMej4pwi2u3TvhlTxkrfBXH/6pe51ciKhKBrpk1Bj0I8I5Vyb77M66BmluRiXwJP/hWI0qSxjdkdmOFJAtJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760985546; c=relaxed/simple;
	bh=yulSoibBDiWX6jmpP3Ns1uXrdkIcA9BOI6Zi04OhpfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTLmseWTSWyGocHMfQv6UNk8ODTArJGfmoylv2qGPqM/byXcRZPUKfA5qUhk5whRHZ411yc3FPGRa08X7RV9I2ljXjhOGXKbQ9aZlkoSYH7waWDhqoLsiG4xjm63fYxRcClciKDLoumGtZY6RGFq5XTInyh3MdcrxY6ggULk4KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L5a5tW1P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBCRGJ022317
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fcmR2kO0kprkS+hm2HYcnN1OE+DeFwRjnQPZTNVK23s=; b=L5a5tW1PBrgMDnbQ
	86ykVpx576xBLHDMIL1J2G1cas1zjehYpfvjWU0c5sbhTqajZXcaFfopgW4KqmM8
	A/Q7gf228qOx0umNVcSmWhaxW/golnCh69NgO5mlEIW8LpSPz+vLI6G/B9sOXTYE
	oPAWDEAw2wNHJzJW1i2X7h4FIsfXfT61oKTn15naaxjGQnI2AUPosw6hpag+2f+O
	nBoNHODh7MnLVM0R1Yq0dKqAY1hXCSkVbX3Q3i3Jyf4DMszQg07tIfVBW+3p2nlA
	dMKoqqwC02rAvFzRnzD/f88bSCEmjx3rRR9XrftMyBuTreLelMfHHwY+89o19reb
	HjXKkw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2gdwt1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:39:03 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-780f9cc532bso4384245b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760985542; x=1761590342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcmR2kO0kprkS+hm2HYcnN1OE+DeFwRjnQPZTNVK23s=;
        b=lxCESHMI1PLfxmgmxlA0aiEE/+P/1UbkIP3WtqwJFbzHT+uwhqCau1aUwAf7j/37Iy
         UMLGExuKGjLYVupLlpZmL1lTaCajeuNSjKRlVrV0zT2oGQrEVJ95lt1ZZH2+LFDwKY5o
         uTOGW0zj91S4gwpk458rt32Q+UQqKcf4z5HRYqKqK9SyNl6wqc3r0fmtrq/m5zYI0kYi
         MBr6mwfcphA7TfHsOKa3Waif0kNI6W/wFjQT6APCb0F3+lRq4bCrDCp0fafwpfdBq9Kw
         XRC7vuIQyPxx4KxR1OKj8tPsog9iyGiOTMgwUH4ygL/vqyzslea7R6GpJ3v/WIXGFddH
         lACw==
X-Forwarded-Encrypted: i=1; AJvYcCVsVx2MEu3BG52hb6T3xSIPkm3nozWAuwj+VQnUh8chBR7m/EH48CGH4Az3Cr3cnbvopLr49ueuPYc9dn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+nHOOOvX9hrj8zW7zBZIJHg7VP/rdQN1lt5joGi0YZWAMK52V
	Mfjmz/uEzqoxa7NuWLOML6V7Yf+mPaNnBD0PvM9n+Ma7jkWxeADzf5HZyrHUPQIMRn1g2oc8pHy
	PY6SKUbBTLors66PrjFhkJlro8oiH1HdNNzW3+7wppVI0NSfRL3drzvMLLzAyOnoX0Pg=
X-Gm-Gg: ASbGncsTNrhxOcuUqb4oiYwv+cL2fYDcUvY5O0UaCGhaM7uU7Wu9vSTnn/cKFjubsMn
	r/5Ro7QcnmUgWsYDptG5mstsJ4Jh2KUiExNxoIKQ4loa3tktYppR5KX+XQUO5j3a0ToJo0ORuOk
	cTNGngOY2w8V/AD5OsdIMF03CrokWbdFXrDRCLJy4G5aJYli4uOP1NxuVuk760sqMHFlLflyLnV
	9LUrVjOxCk9jzb96IP6p59OnBaIy+yGSWs2+zkgRcuqJ1uNPiITqIoU3bfpR+6qJnO6CsHDKoF7
	joPWyv6859uWs1SsTkIKz1GkZ0BPBkEQqtykaZpbzMurRN7rbtIYRF3hoxU0xJEguEyL6M+UFB/
	2HSCmtz1ZO7+3Zu/7I0DlN7CdVQ3lHzAyeI8bFM79JnbB0T6cRZI36w==
X-Received: by 2002:a05:6a00:1ad1:b0:783:44b9:cbc9 with SMTP id d2e1a72fcca58-7a210f59a7dmr21228055b3a.9.1760985541783;
        Mon, 20 Oct 2025 11:39:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd531l029AZFQSWcfW9dfoCX2M4tkX+bVgsI6Qgj1PP+Mt6uKXHJbY5qWihEk2UM8XaRvFog==
X-Received: by 2002:a05:6a00:1ad1:b0:783:44b9:cbc9 with SMTP id d2e1a72fcca58-7a210f59a7dmr21228013b3a.9.1760985541129;
        Mon, 20 Oct 2025 11:39:01 -0700 (PDT)
Received: from [10.62.37.19] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff1599dsm9006920b3a.4.2025.10.20.11.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 11:39:00 -0700 (PDT)
Message-ID: <9d6b7e9d-1656-408d-ae8b-4b3dc95ba905@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 11:38:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: i2c: qcom-cci: Document Kaanapali
 compatible
To: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
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
 <20251014-add-support-for-camss-on-kaanapali-v2-1-f5745ba2dff9@oss.qualcomm.com>
 <e2c43a8c-a9cc-46a1-9ddd-5d6dfc7e917b@linaro.org>
 <49eaf7ec-ac71-4bf3-9a4e-25fa633d815e@oss.qualcomm.com>
 <abc9d825-1e98-4838-9e9c-ca18ba191e11@oss.qualcomm.com>
 <22d47da0-4912-4880-8a42-f6d4e61e094c@oss.qualcomm.com>
Content-Language: en-US
From: Vijay Kumar Tumati <vijay.tumati@oss.qualcomm.com>
In-Reply-To: <22d47da0-4912-4880-8a42-f6d4e61e094c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX+mtgwFwndIW+
 9dGq2wi70jUl30t2jynSry2e4Pudap3LzEe3MPbZLXmBq0rUnQUlmMNKPk9YLHI0sEIp7YX3PB6
 MpR5O3SvKEuxe1EiMvlahQVjO5lSIJlw1aUPP07A2SIEoyjREKZU2YDpaOJ8YYkVDQo7EPcnaAS
 9gg6uoF/em0Ru748zMQLbyGz5XmefBKKfguodZmE0GOj/D7AlKU/kjHVU2u8FDo23Fjmq3vNKaO
 /+psU9kQSMhA1BtQ31lUJ6nLgn4Ud8pKMhZyElpy3z6aWNOc0XQ/G0+7NFh4dmnfxNXXXay1wmp
 Ef6CpwjBXHJXmcNScMFX37F6XG1JLdkJjfz0HC8MFHVsLeinbEnbZRx6IoFZj+P/CprYKqZUr+d
 yHKax9GNq6WzIbCX35UiebHJjBW6DA==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f681c7 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=xzpADP0L3AAWVpYwfikA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: HUZSnYbpQdxKm4Qdas2JS851yb5QNwme
X-Proofpoint-ORIG-GUID: HUZSnYbpQdxKm4Qdas2JS851yb5QNwme
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020


On 10/19/2025 9:13 PM, Hangxiang Ma wrote:
> On 10/16/2025 3:56 PM, Konrad Dybcio wrote:
>> On 10/16/25 3:56 AM, Hangxiang Ma wrote:
>>> On 10/16/2025 3:30 AM, Vladimir Zapolskiy wrote:
>>>
>>>> On 10/15/25 05:56, Hangxiang Ma wrote:
>>>>> Add Kaanapali compatible consistent with CAMSS CCI interfaces. The 
>>>>> list
>>>>> of clocks for Kaanapali requires its own compat string 'cam_top_ahb',
>>>>> aggregated into 'qcom,qcm2290-cci' node.
>>>>>
>>>>> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>>>>> ---
>>>>>    Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 6 +++++-
>>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git 
>>>>> a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml 
>>>>> b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>>>> index 9bc99d736343..0140c423f6f4 100644
>>>>> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>>>> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>>>> @@ -25,6 +25,7 @@ properties:
>>>>>          - items:
>>>>>              - enum:
>>>>> +              - qcom,kaanapali-cci
>>>>>                  - qcom,qcm2290-cci
>>>>>                  - qcom,sa8775p-cci
>>>>>                  - qcom,sc7280-cci
>>>>> @@ -128,6 +129,7 @@ allOf:
>>>>>            compatible:
>>>>>              contains:
>>>>>                enum:
>>>>> +              - qcom,kaanapali-cci
>>>>>                  - qcom,qcm2290-cci
>>>>>        then:
>>>>>          properties:
>>>>> @@ -136,7 +138,9 @@ allOf:
>>>>>              maxItems: 2
>>>>>            clock-names:
>>>>>              items:
>>>>> -            - const: ahb
>>>>> +            - enum:
>>>>> +                - ahb
>>>>> +                - cam_top_ahb
>>>>
>>>> Why is not to give the clock "ahb" name like on QCM2290?
>>>>
>>>> On QCM2290 the macro in front of the vlaue is GCC_CAMSS_TOP_AHB_CLK,
>>>> and name "ahb" is good for both, I believe.
>>>>
>>>>>                - const: cci
>>>>>      - if:
>>>>>
>>>>
>>>
>>> On Kaanapali the macro has been changed to CAM_CC_CAM_TOP_AHB_CLK. 
>>> GCC clock domain doesn't manage the AHB clock but CAMCC does. I 
>>> think it's better to create a new and more complete clock name to 
>>> denote the differences between them.
>>
>> Are there any other "AHB" clocks going to this block?
>>
>> If not, then this is more confusing instead
>>
>> Konrad
>
> On 10/16/2025 6:40 PM, Krzysztof Kozlowski wrote:
>> On 16/10/2025 03:56, Hangxiang Ma wrote:
>>>>
>>>> On QCM2290 the macro in front of the vlaue is GCC_CAMSS_TOP_AHB_CLK,
>>>> and name "ahb" is good for both, I believe.
>>>>
>>>>>                - const: cci
>>>>>      - if:
>>>>>
>>>>
>>>
>>> On Kaanapali the macro has been changed to CAM_CC_CAM_TOP_AHB_CLK. GCC
>>
>>
>> It seems you do not see the difference between GCC output clock and
>> actual clock input so some other block.
>>
>>
>>
>> Best regards,
>> Krzysztof
>
> No more clocks will be added, at least for KNP. And I acknowledge the 
> substance of AHB clock doesn't change. I will update and keep AHB 
> clock name the same as QCM2290. Thanks for both of you. @Konrad 
> @Krzysztof
>
> ---
> Hangxiang
There are several AHB clocks into the Titan subsystem, TOP AHB, core 
(TFE, OFE, IPE, IFE Lit etc.)level AHBs and fast and / or slow AHB 
variants of some of those, AHBs to the firmwares etc. It should be 
similar for any architecture, if I am not wrong. So should we consider 
using "cam_top_ahb" for it to be clear commonly for both Kaanapali and 
2290? Thanks.
>
>

