Return-Path: <linux-kernel+bounces-733336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8465DB0734D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48BB1C22955
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A885D2F3641;
	Wed, 16 Jul 2025 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ljasKkbH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2C62F2359
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661618; cv=none; b=ml1c187NsS3G3fyEe6j5//dIcDg1+1C6MpzyFm/Os92MLzSiq8Q55LUW9wHFkr3km7NNVu7tikXo5DjFreL2eD3pJmPltMnEEbNoyixln0/YsxyTsdiZps2EIRYQC/rSLxZFvEhmevo5xrmCDkybLox+djy+ciWJnWI1tF8+eaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661618; c=relaxed/simple;
	bh=dkcnz2DvhVBraNdPkknEde5QEnIQI0sshBOKGYDq0/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXoWuK9VBU9E38cFUbcXABulyj64gIf0Iz6fuPPzKhmQRjdAb2YeV+0aA2RmKMcDTruqlbm/qbRB84gChdofSYvrlJyjW/HMfcL0VY2+PrP4++wyK455YYJtKj8X9CZH7um80Ph7Gk/+p/4q/N5tMlm37uUxT1FDngCy6FHXq1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ljasKkbH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G63EQ2022730
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UEIv5Q5pbfuoiy+cWUkNc8sRfBTll0fo56yYG/WZqis=; b=ljasKkbHOwB5hHZn
	chg7RZpzIk5HwOWIvCZBx0RRM3Wnr+WjffkaTPH/R6/BBz4O9KUUZUHbZlDh1NGn
	amZtYIGOIPkIQ+sD2cKWUBoiX9Ym/xdcSiL8KovIPk4HrOsDmRwX06Z7HlOupFtr
	YDUzfUuPPN+kamJOOCh7slUpXv9ayZvEas2CssZL4KD6NDGhmsAnyARTiQlbTrAu
	xgNEnpvMB4DVCd+5+ZiLSHtAykJFFAEAtHkCQ9CfiLf25y/DoXAf78WNo3MVv2D1
	7FvZYFoe5afRfYEHcMSZXIRKIBgb/MDVTyKyKcQj7apPi8sLUbRiFnk8Z6ozMSTP
	uTKk0Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wkrum7pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:26:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ab77393308so10998711cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752661614; x=1753266414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UEIv5Q5pbfuoiy+cWUkNc8sRfBTll0fo56yYG/WZqis=;
        b=FmJMAOGlXhjBldTX1RXBFgqMJ9KV7t2130O83XVHJol3owkmpPtMNauKLjyxIHWFmQ
         qxNsx8ZOIKJ5iS3c4B96EHssa99u7tSONeGDjlVAl5YkSAnwZeDLmPj0dF2d7qmDo7kY
         4mDeH2UcLEJviX4WAqae1yWCHCN62cLkImk+sMBU/2M8u1N+7+OOASBRtczvygv6+OIt
         HfYnRmFMLS+QBM4KEdrJMPdx7Ut+HpqfTPhqR7r34Awn2MR9t18CsPSqg0nj3lTh9XEP
         FwBYFlWKwWM5J+id8WXihdj7xxXtpFqbYKOaFGSR16KOsqaISDUsGMUJvheGbsYpR4ty
         bmZg==
X-Forwarded-Encrypted: i=1; AJvYcCUskyXkj3ecCnQzgKVKTdOxc6NMeDhp+WaeDQt91gkzInIVEhtGzgDPOPNKzdsg7aPIQuNJGFWoGEOs9Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+MmJrG5KEVwjBGUfZi8qgtXyh5/9PdRDQ6Z3rJkOZ4cnnSxdO
	F1cQp9aPoCEoAvzNnWmtLyO9S6FN40qyAzt/Egp4JpftwjqHAtF23bBzfDQIOx30iX35A9QWKvG
	bB2kbsfXW1vi7ZesH9qnwEeZuDdaitgH4OjiAvbdSTbM91MmlI7grxVMRDmpErdRX7W0=
X-Gm-Gg: ASbGncu9spi4+SCtMM9CCjLLjanzg1RJB+H30XEoHna7eiL+C4CHV9RJsFCixM7FAzi
	ceWVshCOuQKVhTZsQ7on6oKTHrVoHzydSycT2/Hxx9xkoSyqR+7VV/JAGHxDhmVsd69OkqCm1n1
	lQJKX0+/HT8zofjb8yCrt/2HK8yOahmDJABVnAaJ4b347DX5vKbK+rUnT+3qAXr+fbLYzov1air
	Wb9Rz8ussr85+Gxyxeb4c+e60rbA/TuFYAPrsFahRxqMN1q9682tPytpK/J9/ADoYRCEt1B2Ybi
	E1XzrMKuXta32V6u619cTlB6lfubjDnzo+0H3MEX4BnBJb/dHxuIPZ3D6Hiu3RbtJQ37J+S0vd0
	/+n+9vIvcGCDFS/iF/07x
X-Received: by 2002:ac8:5942:0:b0:4ab:7a5c:fc9a with SMTP id d75a77b69052e-4ab90aa14camr16129361cf.8.1752661614029;
        Wed, 16 Jul 2025 03:26:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS/bx6dHr7YlW34OZ9B32jhEtnpkNZ3+stxyMSlcMbABfC0piVan4Nuc13I/veqJQKwZHKuA==
X-Received: by 2002:ac8:5942:0:b0:4ab:7a5c:fc9a with SMTP id d75a77b69052e-4ab90aa14camr16129141cf.8.1752661613342;
        Wed, 16 Jul 2025 03:26:53 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7eeae5fsm1171801466b.64.2025.07.16.03.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 03:26:52 -0700 (PDT)
Message-ID: <e65c43fc-c188-4acf-a0ae-c34ad171fded@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 12:26:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: arm: qcom: Document HAMOA-IOT-EVK board
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com>
 <20250716-hamoa_initial-v1-1-f6f5d0f9a163@oss.qualcomm.com>
 <604a5823-c563-4d37-ab14-e3164f3b1cd8@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <604a5823-c563-4d37-ab14-e3164f3b1cd8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: WdN8L2ahn4Xb78hq91Rb5iJbIRND66Hv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA5MyBTYWx0ZWRfXxJ/sDcDsdX93
 CZJlhYlb2LWHYPjRAzHaL1bCUrqnvDoX8YcyAF4/+aPTQB7tHulCRi7lrvaI7g9E60monmUfyy0
 MTTrO0z+TFTyky81zD906l4amL3sQV23PE/Wiu8TJo1IlO9snGBXr81carf9BaysjI53tB1SVYg
 p0e4J4Hj5H8xB5H4JTeqQeA440fXxV1zF8hIETi3wqekkZ41Hh+aRTDewCcA2/0+E7pQ6t7FzIS
 ZgrWVSTGEQHUZ80G3Dfyaj6m0ob7rh33NUBrohEpkyQV58/NzokLFzK9s9IvOdmCwJxEZQo5EWz
 /LZIepNsINJxwJClHBw2ZT0NL0b9JgmgYXL2ZCsfcsVBt2asfuRZonBDT/6Q8H7MMRwuNUhcYf0
 D7XYwbfJGO7kenDDsmgJpyWb5cK7UblVMvvJi3yxOqNh/UQEWhQBXw1uejuZd2ZcrHfPN2xL
X-Authority-Analysis: v=2.4 cv=WqUrMcfv c=1 sm=1 tr=0 ts=68777e6f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VgApEbnXb6FI9c-La98A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: WdN8L2ahn4Xb78hq91Rb5iJbIRND66Hv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160093

On 7/16/25 11:30 AM, Krzysztof Kozlowski wrote:
> On 16/07/2025 11:08, Yijie Yang wrote:
>> Document the device tree binding for a new board named "EVK" based on
>> the Qualcomm Hamoa-IoT platform.
>>
>> The "hamoa" name refers to a family of SoCs that share the same silicon
>> die but are offered in multiple speed bins. The specific SoC used in
>> this board is the x1e80100, which represents one such bin within the
>> Hamoa family.
>>
>> Although "qcom,hamoa-iot-evk" is introduced as the board-specific
>> compatible, the fallback compatible remains "qcom,x1e80100" to preserve
>> compatibility with existing in-kernel drivers and software that already
>> depend on this identifier.
>>
>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>> ---
>>  Documentation/devicetree/bindings/arm/qcom.yaml | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index ae43b35565808ed27cd8354b9a342545c4a98ed6..83b09ec1100ca03044c832212a99e65cc1177985 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -100,8 +100,8 @@ description: |
>>          sm8550
>>          sm8650
>>          sm8750
>> -        x1e78100
>> -        x1e80100
>> +        x1e78100 # hamoa
>> +        x1e80100 # hamoa
> 
> 
> Huh? Why, no drop.

I suggested this, so that people who read this file for the first
time have an idea of which magic numbers correspond to what magic
name for existing platforms (where new DTs will be expected to include
the codename in the file name (just like this submission) to get away
from SKU/speedbin names).

We can drop it if you insist, but I'd rather keep it for newcomers.

Konrad


