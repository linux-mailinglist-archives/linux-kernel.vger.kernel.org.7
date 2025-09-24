Return-Path: <linux-kernel+bounces-829812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4376DB97F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8085F2A4756
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 01:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486AF1EEA5D;
	Wed, 24 Sep 2025 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fdADJHtk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257A96F305
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758675617; cv=none; b=ucOmCdd34xqZKaUkRHLoZQbhvYRfZsyxmPUEBynp+yQrgVZ5rO/id6Qs/IaCpprmIKsAsd49tVLJcD/Q/RO7o2acBd3/o5+VerhtBdviIGAOYsf/bx5nXIwmEBxIdcrzeflqFIHh9WEGpiTiUN5ZXa/ue7mFKc15HbL49SqS2n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758675617; c=relaxed/simple;
	bh=aPg0UmtWDWWN4/58XT6GxNp1y+uyLy8yBlL0KKGR5cQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GwEpGQNZ/FRlAPJ9QEGNoGjH4svNxYbYdZgAyB2Yivj6WHdGPmocMABvqoOgzx6GwCF2PfeA9WO/cEVqTdFdtTTFeP1a57UN9zVcvnblSHHmvuVR2En36YyPVHlFLIKu67NBpePJcfGzqPCtjRbQ0I88lE0h1Uhidqvaq+FQbUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fdADJHtk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NFOVt6026360
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X2zvsIx0xpsseLnuqD3wgD1uVrKng7sqp3Iah6620cQ=; b=fdADJHtkDZluEdxf
	dWy2qaD1z6tiE0NDephEw64aP6tE4TUKhFxUpOnASzJfCsajURWkEQgWLmCSSA4o
	+SmlVg7B+MVPs/l/omMhm8Mf9EYVjUAqNNnzkVpXhexxfcJp+yYoRK4L2EXQyXkJ
	ragWJMOYEpGZ4R7sC0r1R5mUTuEw7uqvT4sBodFaG0IITK4ourkDoVXPAT9U+P/w
	7p5IUliSUv0Vo3SZh7pU15QAVON0Oe13AfYqYUV2crBIzWJWLTzzu/IUCmI2sOCw
	vaDZFybNnROri0cEDaIdbrsqbRA4atH/kIh4lSTSXSzPCLcSSMTaXTQv3gXmfoX6
	0nWlJA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyetv1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:00:15 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b551ca103d8so3287118a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758675607; x=1759280407;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X2zvsIx0xpsseLnuqD3wgD1uVrKng7sqp3Iah6620cQ=;
        b=HT94wJW9UAQv9ikr71roDEIam5IHUs3+7h6bTPCvMvVwZW9j0m3PTFeDAx+NcPbJDK
         M0hAbOha3Tc/zt9oxpj9UJIn36T5UZg43bslaXyVBLLs0IOpKro1ajxEhuTfN/tIK8In
         Y4X4APVKH5r9OyOuL/2qs4QOk/EBhr6HiY39bPoysB2fUEDqiY3tT1wygwuc3VPtWbfD
         oumWhxAMTgsHpIHfHAVE+Wcm8tXFoQb4EMJbclilORK3qstztt8m1LUb5//pFBZvCREU
         5XuUTQ4wWZmJ6rxAb8rmn7d6xKUykkDQe+mbJW6D9m4afefMlVi9OyXY4MHt6Ak5t1T9
         4mog==
X-Forwarded-Encrypted: i=1; AJvYcCVI0ZX3AaF27xSMQ8Kng2zGLdQY9WPPsf2H2YSF+I86DOnVfHEKD0eJNaFgzj7/exI9SRpFqLkvnoC7Fxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0G34UakxSn+8prBRUcXQnDA895ODrA47aggRR5FPnotBG3GbD
	x6+paGrSIMV8Jxs4z3VKIrhO+C9EARsliyKZM09zK6mAya37Fv8/N9WwvVNwkyciN14Rvxit3Ag
	q+cg1lO/y/EUEZPvmeI+GYYWib2iKHmSn0P4cc3mzgZXQJF6QUPj3MdDqY2WHNkpZZzs=
X-Gm-Gg: ASbGncv4yhnLAM6k/k2Ply4M8i43noPTObS5eUgdn1D2LOIEnCm3x/E7suP0c5juR3Q
	yLqFSifYcStAWhAw2XhLUL5ZR+rR/j91sx0Q/zNzOH5Ko7pMZddpCs5NBVtdVaIHndvwrNEOQkK
	nhoU9YSGJnTVSwU2wk06MG2vN56dh0+5wwrM4d6qsWn4Nri5mkdoVap6gJuAIFuJry4JXP5Z6Va
	Tg5F4Dr1BXErZolZvcCy46cMELvr83X2LBNqhASlA69f8otLQt8vtHypM8HE4UoOklIkmaLJHSL
	SAQusxCHImd56bJwXsbr4NGS0ktHskVqEgefX1hvkzoY7IZ0CQU/u2riYcZClrdX8MNfiqglBay
	E9LlnLQ==
X-Received: by 2002:a05:6a20:3d87:b0:252:2bfe:b65d with SMTP id adf61e73a8af0-2cfddc6a137mr6516265637.2.1758675606619;
        Tue, 23 Sep 2025 18:00:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0NAzGMlXuVw5j4OF/iTpNasadjCiM+4Mz3TJZj0Y3pZnZIJg5KRsof0hAuREl2zzoKFq8fw==
X-Received: by 2002:a05:6a20:3d87:b0:252:2bfe:b65d with SMTP id adf61e73a8af0-2cfddc6a137mr6516229637.2.1758675606142;
        Tue, 23 Sep 2025 18:00:06 -0700 (PDT)
Received: from [10.73.52.96] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77eee36c2b2sm12958795b3a.78.2025.09.23.18.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 18:00:05 -0700 (PDT)
Message-ID: <31f61f93-2e9d-565a-cd5e-4f668ed7d6c0@oss.qualcomm.com>
Date: Tue, 23 Sep 2025 18:00:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/9] dt-bindings: phy: qcom-m31-eusb2: Add Glymur
 compatible
Content-Language: en-US
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
 <20250920032108.242643-4-wesley.cheng@oss.qualcomm.com>
 <20250922201449.GA1235521-robh@kernel.org>
 <554cd2ce-a617-9387-7379-a3c2b9de843c@oss.qualcomm.com>
In-Reply-To: <554cd2ce-a617-9387-7379-a3c2b9de843c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 59mKuHNKW4E3iS_TC5kzE0Al1Dgpdymx
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d3429f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=1x5KiYs_k_UboVqHg6sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX/c9LIQCJXZ+4
 TZwa7m5IAyUyavOXk988gqoW/HSJAK1NHz1R9UIQ5Ctbmil0RGgNrJpUUH8+Gk8XZ8fWEMdP6Q+
 pwHu6YTvKReJNxdehsnB1rB/8Hg3lP7z0eTfUBrVnhnRtT5wuOBGqo97Y4sKQ+lUuShs0l26457
 g+ODQQd4GQ6/WiMYdCM3lFXZNgyFk43ILDTjmW4jqfvI0bND3MA4KRQ5+inLn05SbWeF0qg/6R3
 TdvwM5/l3JQLvsrxRRSFIcq8RfZXQEptDkJDxDuLEGs7VdJxLqfigEL+/R8hHNtw3WONrKiWZYE
 X6l6RINEIIlMkOZ2UY6YY0SXHGGWHvmcwj7dfpJiiI/biKLnibYlUkk0Hh/bb2ilDuPcq/zEECn
 QN/XDgda
X-Proofpoint-ORIG-GUID: 59mKuHNKW4E3iS_TC5kzE0Al1Dgpdymx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_07,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004



On 9/22/2025 6:02 PM, Wesley Cheng wrote:
> 
> 
> On 9/22/2025 1:14 PM, Rob Herring wrote:
>> On Fri, Sep 19, 2025 at 08:21:02PM -0700, Wesley Cheng wrote:
>>> Add the Glymur compatible to the M31 eUSB2 PHY, and use the SM8750 as
>>> the fallback.
>>>
>>> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>>> ---
>>>   .../devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml   | 11 ++++++-----
>>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml 
>>> b/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
>>> index c84c62d0e8cb..b96b1ee80257 100644
>>> --- a/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
>>> +++ b/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
>>> @@ -15,9 +15,12 @@ description:
>>>   properties:
>>>     compatible:
>>> -    items:
>>> -      - enum:
>>> -          - qcom,sm8750-m31-eusb2-phy
>>> +    oneOf:
>>> +      - items:
>>> +          - enum:
>>> +              - qcom,glymur-m31-eusb2-phy
>>> +          - const: qcom,sm8750-m31-eusb2-phy
>>> +      - const: qcom,sm8750-m31-eusb2-phy
>>>     reg:
>>>       maxItems: 1
>>> @@ -53,8 +56,6 @@ required:
>>>     - compatible
>>>     - reg
>>>     - "#phy-cells"
>>> -  - clocks
>>> -  - clock-names
>>
>> How is it compatible if clocks aren't required now? And clocks are
>> suddenly no longer required on sm8750?
>>
> 
> Hi Rob,
> 
> It depends on the clock subsystem.  On SM8750, we still need the clock 
> entry, because we need to control the output of our CXO/reference clock 
> to our HS PHY.  However, on chipsets like Glymur, some HS PHYs in our 
> USB subsystem doesn't have this refclk output control.
> 

I've updated the bindings to keep it required for SM8750 and optional on 
Glymur.

Thanks
Wesley Cheng

> Thanks
> Wesley Cheng
> 
>>>     - resets
>>>     - vdd-supply
>>>     - vdda12-supply

