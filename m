Return-Path: <linux-kernel+bounces-824747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF03BB8A11E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580091BC5BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA96D273F9;
	Fri, 19 Sep 2025 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TSoOv53s"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A443235360
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293280; cv=none; b=gkDKXVla86UMWfS2e43XOpTNguducUqj6S1dr7pUO/NbHfP9HG1frbD1fEsGNlhBjueFiTVuik6otNSBICC2lrzuIhvJtiAKAndRzGYXYSw/tLSK2ycGNw8Lq3GpSHFek9TFO/5FeTkyvMW8sQSnf5nfBfhyowYG1+IDVrMmQK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293280; c=relaxed/simple;
	bh=Fl5lFtsaSa0aoM45do82bT/2mdUhsFtwUajVfM1OfJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpRyfK+CyHVhM4FewxMTi4sX7KQAnWSsKFazBPWMTHgoWQrEhT2nwAlft17A4L8VguVyub+goKder5FLvvobGcCYIFKwvTNBs1/Ef9E9HDN0vLOa+BAXxyiA84hQeCnz29t+L6KZYMFipldpD7BFH4ZCd4cbbua+kyNt9It4nuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TSoOv53s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J6UrcH017736
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pK2jgFklNvRIcwSxKwSrC3IauNiUyVaZo9Kihcuf/aM=; b=TSoOv53s95HnPGUZ
	G9ZPE3fkYDb8rK+oDBaGytclIOY9/aj7djbQYx61LabICSlgXRLu5IFUqPXd1sYk
	27ZTtmYgEb2NmFDfhZYvP3VV9n72wDA9bs5pVcvxAlPi4R0vslN3/Xp7x9qJ12L0
	fUE0B/kNyhlh/QOncVdMmdYAnRaM/sLCSmcyeTWd7vCgzJ7Dsqmdi69NQsC95cHc
	4mE23Fs0bav6Rq0Lzi+167lhCMrOxWoC6x9l4s3uo9I1aPy+8OjyRHIJzVFRoltv
	Cl7NGrxSjcTSqVA8jI+ohs6hAztWrVTfVb7/8U73MvARARgiWR1Ih/j3pB2lAzZj
	sGGIJg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4982defbjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:47:57 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77b73bddbdcso2396744b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293276; x=1758898076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pK2jgFklNvRIcwSxKwSrC3IauNiUyVaZo9Kihcuf/aM=;
        b=Ix5ummjo1/6IzOYT6HRXEcSV1BJggZ5uB3AdVHp+HhT0Fgwt5vdETbKD8SpsJKPdSg
         AnAQz7wMlUsGpushAyBc+Y2ddstvYGXLmLvU/iL7uqFmAN7bp690zNl/NS70VtTFht9l
         BnHzyBhKVhvbvpqYFSYEG9+fub6dsemNnlol3x788ru5KnICsI7hpW4osenNtcqwcZKj
         VjX8pDPVJPg7sEE8xrgoC1jpLIG+Nj3OuyXX4Z1J4d0hQViHbiay9saX5/WffKOvyoLf
         hiRpZV5gswCHcyhjfPOh1jVSQooB/2uhgwv9Kt3ZuxXO6N3eIHTCBoQmXjO8mL8CZ6hx
         rtzw==
X-Forwarded-Encrypted: i=1; AJvYcCXfJymvKXSD0+akE22gBLD1eYh7DPIukTA6fq+gKPqrM3I45J8oBrYNOLwa6b3mf1gTLvCorlNiDx8lw5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyen0MG+UbH1+qsKOh4FT9J03W6dkw2WtO9Ois4CPZJHGaYM8xv
	SBFEOLvd408v3C0hV9aQaLqrYrq5YviM1HrcmRiI8dIiKGKp+DKKhukurk442sa7MfbH8cy+l1F
	e31/t66aWoTM35qI5r6ZhV4/cItwo/GD/59zjRuiHg/R9Z4AFL+wTZXNi/cAthZHyQZo=
X-Gm-Gg: ASbGncvW7jUtElOyBoFqFZxG3G7r8VqqOBUR7kbLW8gqf0IiZDYleo4ZjfljNFr766Y
	u+KuRHMdiXGkUwH0V1SPNzravO4Gy3ekYfNsX1EL0KdVIdxqCsxjQ7svemn60dMWxU0Ah4axX7z
	T0eGiWaDdBDmjyKYLoWqlzvwrm5+v0hF1V7CfvrtzRTBG6+6mk7gSljgnbxc3F1rtdKf4Xx0itR
	3l7TXEU+EMYjGat71npWdMPN+u3LMDEx+uC2xjd8BjpzCwBjHAWyRYdi1aBjGHaQPSIgXJligZR
	MPmcj6yVGkfk3ArNc6/zY8ON47YQJQ4MQEhlumOjIuQ6CqQnC5XGEI0vtGq3z8PCCkYe8Qfs
X-Received: by 2002:a05:6a00:bd13:b0:771:e5f3:8840 with SMTP id d2e1a72fcca58-77e36935457mr4738818b3a.13.1758293275509;
        Fri, 19 Sep 2025 07:47:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDki/w/fEHcXQU3dq0la/SG+rDFch45lCNFYev7lQ2LKW5H7+gmQs1YUohBh/js4fBRzZI7g==
X-Received: by 2002:a05:6a00:bd13:b0:771:e5f3:8840 with SMTP id d2e1a72fcca58-77e36935457mr4738768b3a.13.1758293274969;
        Fri, 19 Sep 2025 07:47:54 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f097b60e7sm1386902b3a.1.2025.09.19.07.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 07:47:54 -0700 (PDT)
Message-ID: <5d4edecf-51f3-4d4a-861f-fce419e3a314@oss.qualcomm.com>
Date: Fri, 19 Sep 2025 20:17:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/5] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
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
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <8c90cc3f-115e-4362-9293-05d9bee24214@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YfO95xRf c=1 sm=1 tr=0 ts=68cd6d1d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=zIrsKRvHLvAX-MREBNgA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: IS1ZhDxy6BSLnVREMqKjjNb8E7TIrSfW
X-Proofpoint-ORIG-GUID: IS1ZhDxy6BSLnVREMqKjjNb8E7TIrSfW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE4MiBTYWx0ZWRfX84ZAVl1Lwfm6
 g8TlX53IfsaAFcyM484WhgqG3OzGx9142eG94y6c4IM5StYLnWm1jYkUa23wkELVOuHzcagPxYb
 bG+6oLh7ExMKv1thPnwojqh5lMfZYBrCVEa+oW0w44I6fpiQj3svYj/QTWL8SytiCCHRcXrtwVs
 ACRXA2PvGeqv/HMrfkACwck8GgUNXF2H9dOwxPZFllBUFXDP16MDaLFXkGQqZf+9wW/awms9oBV
 ybjrqMvUcHPuG5Aok3lbNw7ovMUaKFhpin1eGaswDsVoNw3Iov0r3bxwwCx0Vz3kRQPXpJduFcM
 oJ54KDQB7LoNOUcmS+aJLTWBi8OM0/1auZe8P0B36cY6DC0HnOPAksv+FzeBuOBCjXBRK+wST9B
 fxRJF3oM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170182

Hi Krzysztof,

On 9/18/2025 5:45 AM, Krzysztof Kozlowski wrote:
> On 18/09/2025 04:47, Jishnu Prakash wrote:
>> Hi Krzysztof,
>>
>> On 9/17/2025 5:59 AM, Krzysztof Kozlowski wrote:
>>> On 16/09/2025 16:28, Jishnu Prakash wrote:
>>>>> You cannot have empty spaces in ID constants. These are abstract
>>>>> numbers.
>>>>>
>>>>> Otherwise please point me to driver using this constant.
>>>>
>>>> These constants are for ADC channel numbers, which are fixed in HW.
>>>>
>>>> They are used in this driver: drivers/iio/adc/qcom-spmi-adc5-gen3.c,
>>>> which is added in patch 4 of this series.
>>>>
>>>> They can be found in the array named adc5_gen3_chans_pmic[].
>>>
>>> Really? So point me to the line there using ADC5_GEN3_VREF_BAT_THERM.
>>>
>>
>> We may not be using all of these channels right now - we can add them
>> later based on requirements coming up. For now, I'll remove the channels
>> not used in adc5_gen3_chans_pmic[].
> 
> You are not implementing the feedback then. Please read it carefully.
> 

Sorry, I misunderstood - so you actually meant I should remove the
empty spaces in the definitions, like this?

-#define ADC5_GEN3_VREF_BAT_THERM               0x15
+#define ADC5_GEN3_VREF_BAT_THERM 0x15

I thought this at first, but I somehow doubted this later, as I saw some
other recently added files with empty spaces in #define lines, like:

include/dt-bindings/iio/adc/mediatek,mt6373-auxadc.h
include/dt-bindings/regulator/st,stm32mp15-regulator.h

I can make this change, if you prefer this. Please let me know
if I'm still missing something.

Also please let me know if you want me to remove the unused
channels - I would prefer to keep them if there's no issue,
as we might need them later.

Thanks,
Jishnu

> Best regards,
> Krzysztof


