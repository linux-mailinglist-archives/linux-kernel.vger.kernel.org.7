Return-Path: <linux-kernel+bounces-886211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3DFC35012
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF7D56044B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816E3309F17;
	Wed,  5 Nov 2025 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lGt3Kh0P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NU2UyahC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E051930AD11
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336719; cv=none; b=dbUFgKKkT9yEyO5a8ylYzX2xsyYVGWiRzvNLF4G/jGx8iKOlY/uu4ziyl35PztBIwXurQ0F0LGeWrM65ZIWcvlBcXX5tFS6RPJBQxzEQIoBg9fyuVaEbWxms2OmOS4e0+5ZJE2fNCcl9ZLKOfI6NCjtpla2h1GBhPLrsZyALqVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336719; c=relaxed/simple;
	bh=vOhz5ndzH3AgkTvkxsMHHFtz4RzDalJMyAfA0L0yuWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtFMu4nn/Fd7WN0MAi+OVzUXj2E5E4W7oOE1/KivF2D6bKk/GR3LzbqTzKe4bQajVsMt7LAaFAXNNbDBjlReWKrmLnWaQFtzS5juIbF9+Aa2LZKpCU2mZ/IXGOLxWKiBG2aELxpFX0YSKJsmS13WNzNw1hpAlQkUPndMdKCtgEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lGt3Kh0P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NU2UyahC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A58IeoP3090853
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 09:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	skwKvBPBxOR6Rt5VCpoChZ8BBo4UGnCPo15CcKo22xg=; b=lGt3Kh0PN8YlXW5Z
	yXpez3F2M5USIkHd6GRRArE2YULtHk31mQY6V19RXsg/nzOkIQmEYvREM62vw7U0
	C8Ol0+Be+t/uxsLcdohe/+gaNWHTcusczITdVc8n+7uvrE0BtWykEWs31BxgX5K8
	K3pV21ySegQGGwS7Q4K8yAw4HgQwFUIijuLUXJnogHH+1vrZ8xV+YQfESLL4i2wK
	Bzv2Kgo4cQAnje8gkDWW3s8Y9eYPHKbuXYjQ78lHdkZ0sniMeCC38LhhkBVCZ3ab
	2Pmp0pa8mrsf+P64Z0mGvB/t7QCk9veGTv53qc8KyAqwHhosVl6I+Cwfy2azVG4y
	CSFi3A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7s5e9xcd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:58:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8a54cd09b97so2792597685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762336715; x=1762941515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=skwKvBPBxOR6Rt5VCpoChZ8BBo4UGnCPo15CcKo22xg=;
        b=NU2UyahCkXLHCTWb1c8hjzHm/n1jtqrBAmCtIUPLP09+XldS95ZNU/J+3mKQ+ncEbs
         gcCLHQgxzZXYG06wZisrXrJDXuQBTVsA0Yj8poUuFHMJ3vT+E9+sPSXC39dmKt+ilP64
         PQBpp4LQ7CBvyKW3Z8JUSIajEBkmraRh52tVEUMix9DfhCGq9a6lImyDxmYy+I4CDOLe
         oCImcD9EjNJNdLM5RRos/ly+IWTbnPmavNF8QNe2YApWfdNov54vbPnQ4CCGS/4vovYP
         5uQA7v6hNYhANRPc+pFVYT5Lerd/tbM6mHZu5fv/oKcCWevSOXpPrr0ReGR90/2z1lWI
         dv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762336715; x=1762941515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=skwKvBPBxOR6Rt5VCpoChZ8BBo4UGnCPo15CcKo22xg=;
        b=Z9UWm8r8pgR6A2RNv1+kQCwVRXKt6HW+XsUZ5iWWdlMSDCpWD3GVmWcCxqvSNTv8Pl
         U8SuoHH1Jcr0XSyD/mHxI+ITN/n+x4OgGgQQMKNBPMkE8dBBO8jC1G0FL7p4sUpRdgZw
         fyrtiGJ0+vBeTPlsQHZPnDyLrSXC/gRMtNFXthbdBbcUhyKtPwo9bmriwPSXh6EwjBsX
         6QyJLVelPVoQoevnLjuFXFlDMEBtXgDv4qWTKyujtVUn2DHOFgWMsAeJj1UQd3ZkyosV
         bsQC/zBUbb2COkyauSRgOoSEnGwCM4Kxg7FBG5YIh5s/czx2dspxENsNXPDT//DHVSVv
         c2fA==
X-Forwarded-Encrypted: i=1; AJvYcCW5yGZ7dzimaqhqIDSN3PL1dc0l8YwVW+hfREhgZiLqFfxuhUJN68gR54Pr2Q88HpuvepAvzBk24qxzxNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfQxPZunQgf8CAOooExZed4CvqqIyc0zf/DWzMq9IJlWESOBx9
	hiPgfQL6zhdsdH3NQ/gczpQoUGIljzDHNnHGxRxzJawsXBphl/frAUIWwc3K7zg8mG5QlrQAa7D
	22FDueEJNrFzOsVdI6TUCmUG04GBSPg5/SBR9Dt4GrRrOryb+Ut/im2WzJeH8H6t+7gv0rYZ9sJ
	Q=
X-Gm-Gg: ASbGncuj/Ek/DY4M8qyVkKxqdHIFBdHyIuu3FEaEXy3TVMYOE8p3gMgOYCg8yw0b3aD
	MqEUURIh7otPdPx0+/NIZEaK746eDgDRcNFkaaPvYIcymhuTt7d1jLBwxrkg7rJNXADxcDHqIHL
	5mlRBkxK9vBuK2naMZeSi1J6+iYLCDjCr3MET22jeXmDEwZHklkrm7c7hx0u43iN7IttZu4H1ih
	s3kYXpPQUc65hUmPSB+P9guU7C8ojRv9w+9AEaJ3Ojb2OpLGl+0c9j1L+qt+j+hMg55h3K4IsEQ
	6EKTyXpzxhONxdDmB2AZIHXmbLDpJElEuMvzA894FaMUChrMHhUCu0CzTf2qewOlBDVRWsHZnle
	eEGJ1Yij154DnSMlnIY7B6q6+
X-Received: by 2002:a05:620a:2585:b0:8ab:8037:509c with SMTP id af79cd13be357-8b220ae81c4mr334534785a.12.1762336714626;
        Wed, 05 Nov 2025 01:58:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8l03hnzW8Hq2aiIwQ+wxlKKDIhW9it9JC9psm6aSHXGhR6kT0qk35yVC1xi3wmIamoJadyg==
X-Received: by 2002:a05:620a:2585:b0:8ab:8037:509c with SMTP id af79cd13be357-8b220ae81c4mr334533385a.12.1762336714113;
        Wed, 05 Nov 2025 01:58:34 -0800 (PST)
Received: from [10.64.68.119] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f51eed83sm370413685a.1.2025.11.05.01.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 01:58:33 -0800 (PST)
Message-ID: <4d0f1892-8aa6-4282-8c36-75f1e46cbae1@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 17:58:26 +0800
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
 <c33ae377-454e-4f7c-8af3-0738cf0cf701@oss.qualcomm.com>
 <d9d0947e-66a1-4ed0-b784-53c38bca784f@oss.qualcomm.com>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <d9d0947e-66a1-4ed0-b784-53c38bca784f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ys5KfQpfcoS491PteTLKZhLUPimHAXCL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA3MyBTYWx0ZWRfX7eXxTjp/gxwM
 DBJzvbhrME17y5RNmsK0eb6VX0wcDFqhB/0zeV/JbGGql0I8zzxAV+EbZsn+QstrXYDJ8jWFuIf
 azuYhtq452sOTWhv1qWSpamesETP6nK/hjKScHiKzFz41/miB281y7Okt5jOtmDIVpgg1HYOJHe
 b2D2pcdn2qbWGMpy6Qch17rcV1SfIsw0KkrxsAOviG7xvrCNdnqrm/vSn4Fa1bGFv/h88pf3KIJ
 IIKlBVfnXDsUfAGaroXawhli09Yrk6Q3QwRx8UO6O6+EZeJX6lO83exz149vbPHi5cDjVMMbb2Z
 Pa6GczSpkRmBj9cSYurEcSMrIxP9F8A8hEZY3Sj2EaoDNvtgsyIjo7wlhefF5ScCLt2HsA+FQB8
 zRGV6Tgbe4ifhgj+1oeRjm8qWwCksA==
X-Authority-Analysis: v=2.4 cv=OayVzxTY c=1 sm=1 tr=0 ts=690b1fcb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=hMESfBkPYkNm0GZuxn0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ys5KfQpfcoS491PteTLKZhLUPimHAXCL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050073



On 10/30/2025 7:27 PM, Konrad Dybcio wrote:
> On 10/30/25 12:07 PM, Yongxing Mou wrote:
>>
>>
>> On 10/30/2025 5:41 PM, Konrad Dybcio wrote:
>>> On 10/30/25 10:08 AM, Yongxing Mou wrote:
>>>>
>>>>
>>>> On 10/28/2025 5:08 PM, Konrad Dybcio wrote:
>>>>> On 10/28/25 8:04 AM, Yongxing Mou wrote:
>>>>>> Previously, the eDP panel backlight was enabled via UEFI. Added backlight
>>>>>> control node in kernel DTS due to some meta may not enable the backlight.
>>>>>>
>>>>>> Aligned with other x1e80100-based platforms: the PWM signal is controlled
>>>>>> by PMK8550, and the backlight enable signal is handled by PMC8380.
>>>>>>
>>>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>>>> ---
>>>>>
>>>>> The subject must say "hamoa-iot-evk:"
>>>> Thanks and got it , will fix it in next version.>> arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 55 ++++++++++++++++++++++++++++++
>>>>>>     1 file changed, 55 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>>>>>> index 36dd6599402b4650b7f8ad2c0cd22212116a25fe..fda1b3a3c7673be74832c27849231cba4bc1f25f 100644
>>>>>> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>>>>>> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>>>>>> @@ -17,6 +17,16 @@ aliases {
>>>>>>             serial1 = &uart14;
>>>>>>         };
>>>>>>     +    backlight: backlight {
>>>>>> +        compatible = "pwm-backlight";
>>>>>> +        pwms = <&pmk8550_pwm 0 5000000>;
>>>>>
>>>>> Try adjusting the backlight value.. you'll find some funny behavior
>>>>> near the max level.. which reminds me I should send some fixes for
>>>>> some laptop DTs
>>>>>
>>>>    I tried sliding the backlight between the maximum and minimum values. It seems that at a certain sliding speed, when approaching the maximum value, there is some brightness flickering. Is this the phenomenon you’re referring to?> [...]
>>>
>>> "maybe" - for me it was the brightness actually going down beyond ~80%
>>>
>>> The issue is that the PWM hardware can't really do a period that's
>>> == 5000000 ns
>>>
>>> But it seems like this is no longer an issue since the driver now
>>> rounds up to the closest supported value, see last couple commits
>>> to drivers/leds/rgb/leds-qcom-lpg.c
>>>
>>> Konrad
>> Oh,thanks for sharing that. I saw the phenomenon you mentioned. Previously, my baseline had already merged this patch series: https://lore.kernel.org/all/20250305-leds-qcom-lpg-fix-max-pwm-on-hi-res-v4-0-bfe124a53a9f@linaro.org/, so I didn’t observe the ‘brightness actually going down beyond ~80%.’and just very slight flickering. After I reverted patches, it indeed appeared.  So here i want to confirm,
>> pwms = <&pmk8550_pwm 0 5000000>
>> can i keep the value 5000000 ?
> 
> I think so.. perhaps make sure the period is appropriate for
> the backlight device at the other end since you mentioned it's
> flickering
> 
> Konrad
Compared to ‘brightness actually going down beyond ~80%’, this is just a 
very slight flicker that only occurs when sliding the brightness bar at 
a specific speed.It won’t occur in most cases. Also tried another value 
pwms = <&pmk8550_pwm 0 4266537>, and it looks the same, so can we keep 
it at 5000000 here?


