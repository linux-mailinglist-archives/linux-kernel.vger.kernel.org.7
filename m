Return-Path: <linux-kernel+bounces-857932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C09BE8466
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A4242626C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE2C34321D;
	Fri, 17 Oct 2025 11:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QQyOs01W"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5E832252E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760699937; cv=none; b=KNgaRhBUU2tuBOJSmeL+mE9vUJfgnAlUqFVRLwvO/RH/2+D3SvP8lBXy8HE/YthEzUxAl8IvS4pYYQNikNrVlOqWoZ6A8D2DqtdT6GUCiFD64R/DugEzDE41bniZKowzoR5gzO6becI0+Sr0xtZBwc9O0/1eGu2IUg0ZaK5C4mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760699937; c=relaxed/simple;
	bh=oOAbWrdIWy8QTIeq7s27EupODM0hsiWV2SWffEEP900=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKHRP3TI1V08386AOLd9dF2QQpyxOgNCUuw+ZhdxJzq6hKbrJ8EIilUIFI5EhfG3UwzlR+YIZXOA62v1xIGMj6dmte2l72cAzGDCHWF0r7bhpYwEMQAACMd90zV3LgSU2tWIn19VRSgvhnkKdGW7yngrLWWHKXR41gV8x0RBzxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QQyOs01W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7pgLh009599
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uRpDYpc/IEeUA+KEWpYpACEZ5933xUZoquxcDmxbVME=; b=QQyOs01W6RAb8ve4
	PorT425SvxxK3wcxG+Zv0ipLFZMU+dRg0fjBZ3K3+Bq4I+sNCoLBWh4k88tUoiud
	zApYI/Y2uC6PgLMQRpqk0UYUdHe2uNBWU1fGGpmw3uFFnwKIk9Pnk/hTfEL/gDNw
	9N48eMWiZWRRRUtUmVaHcrxLrod049PXFGRXFeGBxQbtRvzanEzVDKoWES7phb7a
	NTrej/n8wPoeNX2fSI+x8bEiKWQUvmI1YtIzeOGs21UAwiTlnXEKMdp1Rj1n+3LG
	xI2k8Kgp52cmzXPrr14GmBNSOd6Z4N4popZY6SY9m9OOgdyQwkaKHVjWuwhGyDw9
	MO7V9w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0cbuyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:18:54 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2909daa65f2so22210255ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760699934; x=1761304734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRpDYpc/IEeUA+KEWpYpACEZ5933xUZoquxcDmxbVME=;
        b=kKPbaDa7yw8wCYm4vxIku/P+qBgjrNegx+AJhy8hdRlgxV9JqoO7DJ8+0t/jSx3fnJ
         pmc9oJrQlJ1yC/1XkIc2tWCECUVFhhE8wOs1740hFSVwwnltI8JfNF7QtcZExx1KEO3R
         UvMFofrtXsye3UMmsqfXOn8yBWwfqTyu7U9rJz9i9c3rTG9YaR33nioRDgZL8rFXLDJJ
         NShdpaSJ+iLQyxe04T1QS727ZQhZLJ61BVG9gohAcJmG7Wod4wLd66mZdwQ4uUJ1usAK
         5MP9RNzPIu9giqYl2yVLJuQM6bZdWl38ktN2TFI77Xc7Tca8XCXPGaVzkh6Cx2Apma31
         tqog==
X-Forwarded-Encrypted: i=1; AJvYcCUyooqz8Gvh7D8wWsWWPTOifYbd19WMoRayBy4MmP+K4tZXaeG7Gm5DKhiMjieC/57WmAu++KBrjD7P6Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlrRcIIYK9dxowonjFeNc7AQVJ/wMipw7Bh6DWVkI8RbeRQeQb
	LVWnZ6M9xdN/GWE9zA6ocpNNkFUG8x2zXzG4CwugOkPoJTSCwTY7zBf3wm1RxZV5C561dZ12ZzJ
	tafh7nOIz5RdYndYR1MD9ecJXHKtsqm12muxxFPeiG3R7skk8shRoByl6wOUYRdE2a7o=
X-Gm-Gg: ASbGnctLtHMb7/7KJIIYLyZG7EEh6Rs71NkGiZUnu1/zh0yDjtGSfZEJCD5x24N72gx
	sIBJDtrkwbWyzjHyRqnh4CXEP6JlTiC/P1NxeflGN+TTy7077I1jt3HVtVa02DeLJbylze7BnLZ
	MWHH7d7Kyt6f4N57ClA+OPfoDljqEe2iFJO8q45b+7g3s9fNi1iv91rm7FO7g72pJxWMvCO2yhE
	FOQ7MRRud+45V5OCrHkcxWWLl/IPdsBHbkoQfHiRWykC6jMVQIAoJS7zp7TfyXuVExh3qPy95gp
	o7QjGINh5rH9HDJeROZ4SkdlaF7dNAoj5t3V2vzZy3eLxFwHa5CLv8Q29ANksiRlZV6ek0RYjfq
	VwNT44fJ9NdnhfZJsf871b6u097uwI4g=
X-Received: by 2002:a17:903:19e7:b0:267:cdc1:83e with SMTP id d9443c01a7336-29091b586d2mr92162135ad.15.1760699933467;
        Fri, 17 Oct 2025 04:18:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYJ3ZunwrRNVnlYzmBkV0+8dpKLlZWhJj8Tv4UNS+d8TzTV200DdWwmNQLBB06wtIOD7N2xw==
X-Received: by 2002:a17:903:19e7:b0:267:cdc1:83e with SMTP id d9443c01a7336-29091b586d2mr92161545ad.15.1760699932971;
        Fri, 17 Oct 2025 04:18:52 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909a4590d9sm59498775ad.50.2025.10.17.04.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 04:18:52 -0700 (PDT)
Message-ID: <68a9b8e8-bdf4-430f-baef-6a293ccea78d@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 16:48:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/5] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
        rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250826083657.4005727-4-jishnu.prakash@oss.qualcomm.com>
 <20250829-classic-dynamic-clam-addbd8@kuoka>
 <5d662148-408f-49e1-a769-2a5d61371cae@oss.qualcomm.com>
 <4e974e77-adfc-49e5-90c8-cf8996ded513@kernel.org>
 <a0e885be-e87d-411a-884e-3e38a0d761e5@oss.qualcomm.com>
 <8c90cc3f-115e-4362-9293-05d9bee24214@linaro.org>
 <5d4edecf-51f3-4d4a-861f-fce419e3a314@oss.qualcomm.com>
 <20250927144757.4d36d5c8@jic23-huawei>
 <a3158843-dfac-4adc-838a-35bb4b0cbea4@oss.qualcomm.com>
 <CAGE=qrrCvq28pr9Y7it-CGMW=szKUnU+XBj1TmpoUwuASM05ig@mail.gmail.com>
 <31bd08ce-823a-4a71-baca-a9d1e02fcb6a@oss.qualcomm.com>
 <08eb477f-ea34-4a31-b181-bfc629aef4c8@kernel.org>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <08eb477f-ea34-4a31-b181-bfc629aef4c8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7YDTUj0p1-lPJyLnkZut2OoryONroLWm
X-Proofpoint-ORIG-GUID: 7YDTUj0p1-lPJyLnkZut2OoryONroLWm
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68f2261e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=0Enez7m-cBcTSUDfOx8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfX7YkwrQZKt+8/
 4UGd7kC7HBkIZa6hl5xctLK8+42kilP7XVUFJUgc1rCsik2jcWM3KFZaDd48JGchmIbha9W64Ml
 6mgqMR7UZ82MMtGBwzWJ4cIkfBCYYfeVl8tlImIVKyhX5oSn30KZswbEtfcCdSJe6mupuEnjgfe
 WJ1RRddL9UMRVHp/14Ee2oq3to1LdMRQLclO6O1j8ArKVJ9i11b57HtUipzeqj0HBp/YGSIo5so
 J+iq6/JCleQUfYTw0k7HVraoUkM8l89wN+T4+1jQsK0CIOPdmqVVBU8Djy79O1HulXSkn6tbyaB
 dGCi9ngjhwpyGuPFCh5k8ILJL5bba9goxWaqjzvABMy6MUjIQZuq/0fRvGWcWh5OF9c4xHvF6ZP
 TQy/TpXcikh+1NPSaCJVkIxpsgI85g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

Hi Krzysztof,

On 10/9/2025 5:22 AM, Krzysztof Kozlowski wrote:
> On 08/10/2025 23:20, Jishnu Prakash wrote:
>> Hi Krzysztof,
>>
>> On 10/4/2025 12:22 PM, Krzysztof Kozlowski wrote:
>>> On Sat, 4 Oct 2025 at 11:42, Jishnu Prakash
>>> <jishnu.prakash@oss.qualcomm.com> wrote:
>>>>
>>>> Hi Jonathan,
>>>>
>>>> On 9/27/2025 7:17 PM, Jonathan Cameron wrote:
>>>>> On Fri, 19 Sep 2025 20:17:43 +0530
>>>>> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
>>>>>
>>>>>> Hi Krzysztof,
>>>>>>
>>>>>> On 9/18/2025 5:45 AM, Krzysztof Kozlowski wrote:
>>>>>>> On 18/09/2025 04:47, Jishnu Prakash wrote:
>>>>>>>> Hi Krzysztof,
>>>>>>>>
>>>>>>>> On 9/17/2025 5:59 AM, Krzysztof Kozlowski wrote:
>>>>>>>>> On 16/09/2025 16:28, Jishnu Prakash wrote:
>>>>>>>>>>> You cannot have empty spaces in ID constants. These are abstract
>>>>>>>>>>> numbers.
>>>>>>>>>>>
>>>>>>>>>>> Otherwise please point me to driver using this constant.
>>>>>>>>>>
>>>>>>>>>> These constants are for ADC channel numbers, which are fixed in HW.
>>>>>>>>>>
>>>>>>>>>> They are used in this driver: drivers/iio/adc/qcom-spmi-adc5-gen3.c,
>>>>>>>>>> which is added in patch 4 of this series.
>>>>>>>>>>
>>>>>>>>>> They can be found in the array named adc5_gen3_chans_pmic[].
>>>>>>>>>
>>>>>>>>> Really? So point me to the line there using ADC5_GEN3_VREF_BAT_THERM.
>>>>>>>>>
>>>>>>>>
>>>>>>>> We may not be using all of these channels right now - we can add them
>>>>>>>> later based on requirements coming up. For now, I'll remove the channels
>>>>>>>> not used in adc5_gen3_chans_pmic[].
>>>>>>>
>>>>>>> You are not implementing the feedback then. Please read it carefully.
>>>>>>>
>>>>>>
>>>>>> Sorry, I misunderstood - so you actually meant I should remove the
>>>>>> empty spaces in the definitions, like this?
>>>>>>
>>>>>> -#define ADC5_GEN3_VREF_BAT_THERM               0x15
>>>>>> +#define ADC5_GEN3_VREF_BAT_THERM 0x15
>>>>>>
>>>>>> I thought this at first, but I somehow doubted this later, as I saw some
>>>>>> other recently added files with empty spaces in #define lines, like:
>>>>>>
>>>>>> include/dt-bindings/iio/adc/mediatek,mt6373-auxadc.h
>>>>>> include/dt-bindings/regulator/st,stm32mp15-regulator.h
>>>>>>
>>>>>> I can make this change, if you prefer this. Please let me know
>>>>>> if I'm still missing something.
>>>>>>
>>>>>> Also please let me know if you want me to remove the unused
>>>>>> channels - I would prefer to keep them if there's no issue,
>>>>>> as we might need them later.
>>>>>>
>>>>> He is referring to 0x14 and below not being defined values.  So what
>>>>> do they mean if they turn up in the DT?
>>>>>
>>>>
>>>> Thanks for your clarification. To address your first point above, the macros
>>>> added here only represent the ADC channel numbers which are supported for
>>>> ADC5 Gen3 devices. If there are numbers missing in between (like 0x14),
>>>> that is because there exist no valid ADC channels in HW matching those
>>>> channel numbers.
>>>>
>>>> For your question above, if any of the undefined channels are used in the DT,
>>>> they should ideally be treated as invalid when parsed in the driver probe and
>>>> lead to an error. When I checked the code again, I saw we do not have such an
>>>> explicit check right now, so I will add that in the next patch series.
>>>>
>>>> And to be clear on which channel numbers are supported, I think it may be
>>>> best if, for now, we only add support for the channel numbers referenced in
>>>> the array adc5_gen3_chans_pmic[] in drivers/iio/adc/qcom-spmi-adc5-gen3.c.
>>>>
>>>> There are only 18 channel numbers used in this array and I would remove
>>>> all channels except for these from the binding files. During parsing, we
>>>> would use this array to confirm if an ADC channel added in DT is supported.
>>>>
>>>> In case we need to add support for any more channels later, we could add
>>>> their macros in the binding file and update the array correspondingly at
>>>> that time.
>>>>
>>>> Does all this sound fine? Please let me know if you have any more concerns
>>>> or queries.
>>>
>>> No, it doesn't.  You keep ignoring my arguments and responding to
>>> something else. I prefer not to store hardware values as bindings,
>>> because these are not bindings (and you failed to prove which SW
>>> interface they bind) and it's really not necessary.

Sorry about the delay in replying. Let me go step by step
over the use of the macros and how they are used by clients
SW.

1. In ADC Gen3, this is the superset of channels supported on all
PMICs (with ADC):

Ref: include/dt-bindings/iio/adc/qcom,spmi-vadc.h

/* ADC channels for PMIC5 Gen3 */

#define ADC5_GEN3_REF_GND		0x00
#define ADC5_GEN3_1P25VREF		0x01
#define ADC5_GEN3_VREF_VADC		0x02
#define ADC5_GEN3_DIE_TEMP		0x03
....


2. Since some PMICs may not have all of these channels supported in
HW, we have the PMIC-specific channel definitions (starting with PMIC
name like PM8550_..) made referencing the above definitions.

Ref: include/dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h:
...
    #define PM8550_ADC5_GEN3_DIE_TEMP(sid)	((sid) << 8 | ADC5_GEN3_DIE_TEMP)
...

side note: This is also used for the "reg" property in the ADC channel
definition DT nodes.

Here `sid` is needed as there can be different instances of same PMIC
using different `sid`s on a single SoC, and also on different SoCs, the
same PMIC may have different `sid`s.


3. This PMIC-specific definition will be used by clients like below
(in io-channels) to get the ADC channel they need to read.

    pmic@1 {
        temp-alarm@a00 {
            compatible = "qcom,spmi-temp-alarm";
	    ...
            io-channels = <&pmk8550_adc PM8550_ADC5_GEN3_DIE_TEMP(1)>;
            io-channel-names = "thermal";
        };
    };


Can you please provide your suggestions on changes we can make
in the above points ?


>>
>> In my previous replies in this thread, I missed mentioning that the macros
>> defined in include/dt-bindings/iio/adc/qcom,spmi-vadc.h are also used in
>> other places than the driver file - they are also used in the PMIC-specific
>> binding files added in this patch, for channel definitions. Considering
>> one channel for example:
>>  
>> We have this in include/dt-bindings/iio/adc/qcom,spmi-vadc.h:
>> +#define ADC5_GEN3_DIE_TEMP			0x03
>>  
>> The above is used in include/dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h:
>> +#define PM8550VS_ADC5_GEN3_DIE_TEMP(sid)			((sid) << 8 | ADC5_GEN3_DIE_TEMP)
>>  
>> And the above definition may be used in device tree, like in the example added
>> in Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml:
>>  
>> +        channel@203 {
>> +          reg = <PM8550VS_ADC5_GEN3_DIE_TEMP(2)>;
>> +          label = "pm8550vs_c_die_temp";
>> +          qcom,pre-scaling = <1 1>;
>> +        };
> 
> This is not a driver. I do not understand your argumentation at all.
> 

I hope with the comments above I was able to explain the purpose of
the different macros added in dt-bindings. Please let me know if
you want me to elaborate anything more.

Thanks,
Jishnu

> Best regards,
> Krzysztof


