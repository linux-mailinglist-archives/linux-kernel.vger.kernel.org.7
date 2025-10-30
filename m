Return-Path: <linux-kernel+bounces-878072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF31C1FB49
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4FF0634A3AF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB0B2DE718;
	Thu, 30 Oct 2025 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SqK81fQL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B38ZA2qA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC30266565
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822481; cv=none; b=hyzKxkOnpF2l1HBHEUkqruACdthzkGKLHFeYAZm0Iskh8VXMloiA7V89SLtfaLUnh/kE0xaFzCZwipUNggfRf83z5E6DyQtIOMWYGvRX5wOJY4VazQ2vw9MMrpqReYdaxogVwmd5TIRGsa+FUy/aDGnXduPy9y7YlKwe7b+cSQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822481; c=relaxed/simple;
	bh=IRKNYtf1vJEwsLDdTQLi5CxovY/yweeQLsKQmUuTsBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8BkZNtktI4RgTKCNx+SITmgli9y9DWhvtAGu+cQBHcCZdytsfIzEnvt/4vNpOgrJHt+HdCu9T9w4K+FsP9gKpy+ifM3U/hYu7z//aLWZpqZ6COsx53lzhEkIxE6Qgv+blWplz3V+DwIaG+wJciMK9BTNIRORHZQU+fmfAqqqA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SqK81fQL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B38ZA2qA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7Yj831598878
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K4396cP+NWBPFdj0+tdDVZrkdA3f1TxyUKHP58p9tTU=; b=SqK81fQL7OnZIxji
	pEfmpGJXtZEIftOjOc5OjMlDiHzngwx0kA4Fy8DSvrawR8+/yWvmq3M3Rn8kGYrK
	ZWI3RXoxNGAuTIFV1l3IGrR03PLLubH+WnuHFDtg//VvbNpj+vOP/XYGSrvLFEoJ
	BljeapyzCa36atlWFqIUdVzrKR0fZNX8rzOW9n4GULo3jsJSYjtok+VtsPvRQuMD
	hzfqgWg4h3d05sPTRwJd8QtKU0uDNmn1sd3cbACPUNrROQPkVNMqP6MqcaMymH9p
	7ULqt+EQmLKRpEWcVl4Cm0tpfyWnbv42WDfMEmpIkTWq3x3SZ7oPOJcuEfN+AKe1
	hiiOeQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3ta7t785-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:07:58 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3405c46a22eso593080a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761822478; x=1762427278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K4396cP+NWBPFdj0+tdDVZrkdA3f1TxyUKHP58p9tTU=;
        b=B38ZA2qAjNcQZkCPBAOfAw+wzVkZDsgMzm9OjsI7DFA7oiIWh+Dk40B4tDzaGndtW3
         B87m5fu4jtsklJ4hw2KV2AxzyvwaiiH4tu3q+Un+fJ2Coq4GVsxb8cbW+ZszXW2ojrmw
         81BjQGnxPOcjkGMGt1vXalC2LWUfSYmBLBsJYSqBcOgFtYKhxsTwCokOmFwOcaLWt4nS
         ieVhOBDrxfMDlof/8H6ernshooF9+DrxmHHZdCSAgObD4gsb2+JI+BYZT9dASJAT4w1w
         4CcIeyz07KA7dyNSZf1TQI6qReog4spM8TZkx3U7LAasUYgvKCVUOCCBnhmMJFLlvHhg
         LxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761822478; x=1762427278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4396cP+NWBPFdj0+tdDVZrkdA3f1TxyUKHP58p9tTU=;
        b=PnijIVuVsjuxvM2NGiu2dMJlMs6iQMeAnnootwy3zw3pben6np/xIJ1bO9NwvN0qW4
         2w4W3Eu3SFGD1y7bTxqR4kE0EtR3dv34Q+sZzVo9k9aqt0Sfvy8Sng1fL/ifKmSmIE6y
         VNOZyvJwHdVuIs3Tm9lP0xQszmTq90H5af1aka7D8FpdatEHPbnH+nR8xnjLmxeQ0Lgs
         4s/B0J7gku8omUJg4xdbXiqbT/GRM53ZWCt62gO1AeJ1kM5DMhMfCC+4xbnw0BN2ABBn
         Rz95cfFlSPX2iLdsxhfKxW0WY9tccKJNQEIN0eYcGQfD6rsXjNXfPedLMqf/188lG4XS
         AzSg==
X-Forwarded-Encrypted: i=1; AJvYcCXLVuEUWFZldzswch34ddhSVbPhuDSsDlw/XRfp4n925hyuI3bbYSAkED4gVt2k+10D4JEGAapNmPVNa3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbt8LseBKuuizW16TBO56VGpUYDPrgBqAGMAeLjXrg7pHPc8Mw
	sqJA1clKRgJelEJaD/C4v3PiIYcbfo75u/Q8AYhTbv4RMR9Owr//ncFiCTWRUQduNPjPPBxiICI
	58TjaBweqzng+dGjG9GSeymat9czh45B8VgkixhRQE6bL8huS2D9SUaqwwHxsMJKfpn4=
X-Gm-Gg: ASbGnctWzKWQeuFuZ9PpDwrbVXKI3fADlw1rBzvHUnUUGTWvWxpkXumZ5Pul9Hs+LyD
	XEeAnqDn3BWdQYXnIpAAUkEEhxmH5KYi/DmqJpU8qEXrzBUMNaR9g9empyhn33sjkiQcBC/ih45
	CsfaS4IFxJksQp/WYbKsoAfOtOZBH4J9Rxsh6tPg/61K286vHt8NLwxV0df2svC1aHebXZEhVk4
	JzwleBL8lqWFh+Jw/Xkx4GWrHSQsm6V4yopdQWWnQiTBe193xhYWW7Fb6W16g/beWhWpOoTOhfP
	5aCapCM6ADf3OifWl6cQiUFtrz05dSX17AJpxojHXvRO9rnPXsPPqzYaipTBRPXwCcZ1+4UJ9jP
	KATDjtQJ/kWIOHrreGtvC4fcjIavrXJe82sSHM0DIPRNHXjuf9/WrWOMMuz0b9JV8xCbQig==
X-Received: by 2002:a17:90b:3ccb:b0:340:299d:f746 with SMTP id 98e67ed59e1d1-3404c3d7690mr3680413a91.8.1761822477520;
        Thu, 30 Oct 2025 04:07:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnPeaFBA+lcam7IsugHvorTigV+88PHITZ9ftmVx6VcbOITX10+z6BNS3781eZvJw0PKFtPA==
X-Received: by 2002:a17:90b:3ccb:b0:340:299d:f746 with SMTP id 98e67ed59e1d1-3404c3d7690mr3680356a91.8.1761822476895;
        Thu, 30 Oct 2025 04:07:56 -0700 (PDT)
Received: from [10.133.33.50] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340509e95a3sm2234442a91.19.2025.10.30.04.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 04:07:56 -0700 (PDT)
Message-ID: <c33ae377-454e-4f7c-8af3-0738cf0cf701@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 19:07:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: Add backlight support for eDP panel
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251028-hamoa_dvt_backlight-v1-1-97ecb8d0ad01@oss.qualcomm.com>
 <b5d9d47b-7fb2-4ce4-9bc8-0d28395b78db@oss.qualcomm.com>
 <0cf2521b-8d05-42f0-aab8-35cd370e599e@oss.qualcomm.com>
 <8caa1cec-d881-4e77-8d77-be043f8d13d6@oss.qualcomm.com>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <8caa1cec-d881-4e77-8d77-be043f8d13d6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aaVsXBot c=1 sm=1 tr=0 ts=6903470e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=gZJ2WMP_fuF1vj9OyeAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: S1dHfjxQwXx5xdzbIQP8SvRYhn3bvvx9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA5MCBTYWx0ZWRfXwZYsq7buc2Vs
 hRgWRjZbR0CSR/w/5Cbn7zcXW5EWQYXDFsWemFyliqgXkv7jvu3Yf3/Z/JQRn/hQbDs4w4Ko0Kl
 Q279kYWhF2hEwwV7aWR/y8zGOzRzcK60+ZPLLvUTwnk1D38essQHaD02qDIC6AVwTzF9Vp+38Ym
 6jqOvOx/2NWhW5a6xaUMYW5AMaiJhZTDMGLQVlt5CjPATyI+j4DGKnf603oUeYCFPsEacmwwPzc
 e7EtnjdU02EN3hDo48slJsCAWy2bnf7j6lF1xDqBvUQjK0d0pY25TmoLNtBJquEr9mhEz29pb0M
 8fh07WPUOZ2fOPiFNcbcaalbLqBFigQmBKChp8kyZnD1a9YiVUiTOdGpqdXf78pJVM+dPsMfeh8
 KB1JvVpFk4lhMqgC3k2w93AnaFmDaA==
X-Proofpoint-GUID: S1dHfjxQwXx5xdzbIQP8SvRYhn3bvvx9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300090



On 10/30/2025 5:41 PM, Konrad Dybcio wrote:
> On 10/30/25 10:08 AM, Yongxing Mou wrote:
>>
>>
>> On 10/28/2025 5:08 PM, Konrad Dybcio wrote:
>>> On 10/28/25 8:04 AM, Yongxing Mou wrote:
>>>> Previously, the eDP panel backlight was enabled via UEFI. Added backlight
>>>> control node in kernel DTS due to some meta may not enable the backlight.
>>>>
>>>> Aligned with other x1e80100-based platforms: the PWM signal is controlled
>>>> by PMK8550, and the backlight enable signal is handled by PMC8380.
>>>>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>> ---
>>>
>>> The subject must say "hamoa-iot-evk:"
>> Thanks and got it , will fix it in next version.>> arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 55 ++++++++++++++++++++++++++++++
>>>>    1 file changed, 55 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>>>> index 36dd6599402b4650b7f8ad2c0cd22212116a25fe..fda1b3a3c7673be74832c27849231cba4bc1f25f 100644
>>>> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>>>> @@ -17,6 +17,16 @@ aliases {
>>>>            serial1 = &uart14;
>>>>        };
>>>>    +    backlight: backlight {
>>>> +        compatible = "pwm-backlight";
>>>> +        pwms = <&pmk8550_pwm 0 5000000>;
>>>
>>> Try adjusting the backlight value.. you'll find some funny behavior
>>> near the max level.. which reminds me I should send some fixes for
>>> some laptop DTs
>>>
>>   I tried sliding the backlight between the maximum and minimum values. It seems that at a certain sliding speed, when approaching the maximum value, there is some brightness flickering. Is this the phenomenon you’re referring to?> [...]
> 
> "maybe" - for me it was the brightness actually going down beyond ~80%
> 
> The issue is that the PWM hardware can't really do a period that's
> == 5000000 ns
> 
> But it seems like this is no longer an issue since the driver now
> rounds up to the closest supported value, see last couple commits
> to drivers/leds/rgb/leds-qcom-lpg.c
> 
> Konrad
Oh,thanks for sharing that. I saw the phenomenon you mentioned. 
Previously, my baseline had already merged this patch series: 
https://lore.kernel.org/all/20250305-leds-qcom-lpg-fix-max-pwm-on-hi-res-v4-0-bfe124a53a9f@linaro.org/, 
so I didn’t observe the ‘brightness actually going down beyond ~80%.’and 
just very slight flickering. After I reverted patches, it indeed 
appeared.  So here i want to confirm,
pwms = <&pmk8550_pwm 0 5000000>
can i keep the value 5000000 ?

