Return-Path: <linux-kernel+bounces-745409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7186BB1197C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A60AC5C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475AA2BE7BA;
	Fri, 25 Jul 2025 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kVkarbgo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEF114A4DB
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753430598; cv=none; b=ZYSASOF7EcMdw0Gf4KMvbAvPBQ87s7H6YnVrMsHbBGKilhMw4CtW1xT4xkMSZH4/tDDSNPfdsv6dCkxh7lYbZ84NmyU4tQzujIZOUeSRik4/9ZW5TZLdAal7u4M2IJIV6qPbze2LQXqrIfwm54EppxGgaH0BzWsUl2th01kirBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753430598; c=relaxed/simple;
	bh=RiEMJlr5Ad7E7QBTCbokE2mQrnmCQiB4o1Vq9dQ045U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fkUJov/6S6C5hb2DSHR8WSkcCBnxZOMi+f8qvap10BWpvyEblJnetquaVVAYNH8Z5CMjB+FycO+RJupTBHNx2GyIPM1YyL8jv+oJXDps/SjKHXoLJfeRFVNHpPtJDE2EZYMmTTJ0meXgDiZM42xrNUI+CM/RZiu333w6o28+7gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kVkarbgo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLnJwR026720
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gbtfcu6uHop71TvodFK0hd1UxxiGo/jNtdYvZ92lnfM=; b=kVkarbgoKnPa38Ma
	FauZy9kThbDeL5qmC1NhiM8xZAihknJAwv1jQ88mHvVqbqSOtNdAsDMUh2K5go+P
	53b+33CMaDhhjTIk0JmiYbq5N8DXLotff7IABZUm5IkHjrMw9/INKd0mL6atzhhj
	MqQvrwuTbO1+lmNxFR0+uF3sjreooe6CxUz1jEEN8V6ftB31WAApRkCynP7Rh9iB
	jj2gJCdNX+hv+jZNwjG5sGIJ6v6U+k4EUEAwW/WOnZ9FRyaZ6ed6aDGLY/6hdKOZ
	2txXEJPW3WhUinuBSG2UBuFZp7geuMP1TkILZQlyv3h7FAgq0bKqdBWcIuMSn9c0
	8wo4lQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w30sabr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:03:14 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b00e4358a34so1359504a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753430593; x=1754035393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gbtfcu6uHop71TvodFK0hd1UxxiGo/jNtdYvZ92lnfM=;
        b=V/fuaMPJRDmxOeCMlkFFcYBKe5iKK3TasRVlZWJOqLMceONBU/kyCarxVGFVAAlyUs
         YsiL/qjn9CeDlTlXyN1VGGDyPA/j1BcjSkarvvSp/ZZwjrY6KeOkToshjn0ToGOk1QFZ
         JNavrJy3uZHAQCI2QvZa3uaottd5CHho6rFOnJLqqiO7yQYiaqX9gcU56rvINoo68jBM
         OQ/EmddDgy/Kv+LNAsQy/6iF0FXxUS3/m/JgDzEo9KPBWfFD+/mzFmX9MfLRWdISpwGF
         6rrmOlOUrEXi1CpL5WMM1HGEvyni+Aqu88WOo1sOlbnS5MQtVxKlk6zazI5DotK5V2Ru
         s6+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrz+xG+eoHphbxsPPf1p5ET+bQo4qvIABuY2/k3edr9/E+8P07Qta1XySX7a0e6U6wv5Kf99mGalrV97Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjqerTpOnwGpZJpFQEl/xnKgkhnyA9A/IjnomCEUju8ej650xH
	irYzCTVWfjpY4wDQolFrRhWzBhg8++m/9/4f1cH4VaJC0YX1w2DTru/w2XaMfYgLgWj2L9bPeF3
	LKnw0cKWo+HQ/AaUd3mF4o3qE4qK9l4AuSFsAps1kaBk9WNiuYCMG60jKjuIvfLvZlxQ=
X-Gm-Gg: ASbGnctlCEngvct7Z/L2WAWNhvQBhHMuQ0s3U8nvlwKwYWh8zLUdVtDOoITGrilX+hn
	FfEXoGbmF8ymHUNQyQmJIVgPsLhkOgDfr3fZ/pMy0hZSH+gEnkUtnuLf9fKwFYELOI3ComPy05/
	Jf86/CQ5i73dpgX28mfMIxFJDM6qG0LDU8eFflAB6N/tqoKel0JeNogXkc1ia4p2uXHM5NQobQM
	O/6KBMST8rxIxAgzCUW2xZ/be14BhYPATNTrTcZcPeMDU4/ljGfTub4Q700wFV3SZNbn76EJAHs
	2gsZfudnhHvsPEvYtMjO7SeYWIMfFUfJmoOFnu4CHjOiX6cENgjhh+4s8REDlzh7zvviyeFnKfA
	LHB1k56RsSe9cuNXk6tqvj8me2Cg=
X-Received: by 2002:a05:6a20:3d88:b0:232:813b:8331 with SMTP id adf61e73a8af0-23d6ffe8cdemr1470147637.2.1753430592950;
        Fri, 25 Jul 2025 01:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwDBAwcAVmAqN/bBqzL1eUtNkX43ZuhXthRUE59WSNoYyMYG02D7jEEthZPJAa75pLPXHtZA==
X-Received: by 2002:a05:6a20:3d88:b0:232:813b:8331 with SMTP id adf61e73a8af0-23d6ffe8cdemr1470089637.2.1753430592477;
        Fri, 25 Jul 2025 01:03:12 -0700 (PDT)
Received: from [10.133.33.89] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f6c09a1absm2857148a12.23.2025.07.25.01.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 01:03:12 -0700 (PDT)
Message-ID: <3803aed8-3b32-4a7b-860f-8fe049f5ddee@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 16:03:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: qcom: Document HAMOA-IOT-EVK
 board
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250724-hamoa_initial-v2-0-91b00c882d11@oss.qualcomm.com>
 <20250724-hamoa_initial-v2-1-91b00c882d11@oss.qualcomm.com>
 <d49d2755-2967-4bb9-b789-8be5f138d4cd@kernel.org>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <d49d2755-2967-4bb9-b789-8be5f138d4cd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WtArMcfv c=1 sm=1 tr=0 ts=68833a42 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=slic9b_SWHWCqRcW-tMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: uI5iQQf5e1n5_svaOGNoLMwwvSYUpKm8
X-Proofpoint-ORIG-GUID: uI5iQQf5e1n5_svaOGNoLMwwvSYUpKm8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA2NyBTYWx0ZWRfX+lV7Szgtmx8k
 ODHPT3VFijCTRvwgeoY1LeOJEt0AzwY7khjVWvL/nxRrJUoX87G6uStbsD92U3EFJBxR0pXN2e6
 xoOFy+fu9mKcyAtR2dlHSjxV2ERT3rFC/VC8VVVumXFoNN2SoOmFsLm4JsV9ySxxyp11AB7w4C2
 c7SzuTvaocSKsahNDPRl2XrGTTEPiNnZtBBGTCVal6QgE8jZqPRyBCq0torBndV5dz0knnMZR2e
 zLTPMZ83QSDFcPfu+vm3vfKBZP8beVyGfbAHmvU533ZKE+ZTQsixwAhAvyNzceWfixZXjqT2Pl1
 txX1yZ2ReWXykODOi0ozAlagErmxLeoYZPa3tT8neXuYOijEAA65CvVaceU/o1zhS36tIZ8/IuB
 LiIZPQD3LwbTWFQOZa2bA4N1Moq7RWK/m6M5ro2U4FgawhouERvKglxnJRDOHlVy9TK+5ApO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 malwarescore=0
 spamscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250067



On 2025-07-25 14:55, Krzysztof Kozlowski wrote:
> On 24/07/2025 10:15, Yijie Yang wrote:
>> Document the device tree binding for a new board named "EVK" based on
>> the Qualcomm Hamoa-IoT platform.
> 
> What is hamoa-iot?
> 
> Later patches claim this is a SoM, so explain here why you are not
> expecting it to be used outside of EVK (not following standard SoM rules
> like every other vendor)?

The SoM can be used outside of the EVK. Regarding the standard SoM rules 
you mentioned—are you referring to the expectation that a SoM should 
have its own compatible string, such as 'qcom,hamoa-iot-som'?

> 
>>
>> The "hamoa" name refers to a family of SoCs that share the same silicon
>> die but are offered in multiple speed bins. The specific SoC used in
>> this board is the x1e80100, which represents one such bin within the
>> Hamoa family.
> 
> Isn't this obvious from the schema?

This is the first patch set where the Hamoa code name is introduced, so 
I’d like to clarify the relationship between the Hamoa family and the 
SoC ID. Additionally, I want to explain why the compatible string 
includes both the board’s code name and the SoC name.

> 
>>
>> Although "qcom,hamoa-iot-evk" is introduced as the board-specific
>> compatible, the fallback compatible remains "qcom,x1e80100" to preserve
>> compatibility with existing in-kernel drivers and software that already
>> depend on this identifier.
> 
> Not relevant. This is x1e80100 SoC. We do not explain that
> microsoft,romulus15 is using fallback x1e80100, do we?

Same as above.

> 
> You explain less relevant topics but you do not explain the main
> concerns here. It does not matter how you name your board. Can be hamoa,
> can be lemans - we don't care about board names.
> 

I will add more details to describe the relationship between the board 
and the SoM. This is what people are most concerned about, right?

>>
>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>> ---
>>   Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 47a7b1cb3cac1150bcde8c2e2e23f2db256ab082..f004019c5691e0a9a3d56a0e3af395314ceb3745 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -1161,6 +1161,7 @@ properties:
>>                 - lenovo,yoga-slim7x
>>                 - microsoft,romulus13
>>                 - microsoft,romulus15
>> +              - qcom,hamoa-iot-evk
>>                 - qcom,x1e80100-crd
>>                 - qcom,x1e80100-qcp
>>             - const: qcom,x1e80100
>>
> 
> 
> Best regards,
> Krzysztof

-- 
Best Regards,
Yijie


