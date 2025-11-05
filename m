Return-Path: <linux-kernel+bounces-886220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C65C35036
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D50F4E5616
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5503123183F;
	Wed,  5 Nov 2025 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aEBhuqAf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dvcyn5Jo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED8C381C4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336976; cv=none; b=KHb9Y17JBD57qhvNghFctVOjrA6yCkog8ZCG6zDWuobma4jbo31/dYNvpWdCk3I8MjvDAuCNTsnlJkXbSN9YahmXk67IPARyvtGPxrM7gigNliqg1d4M98SqG9yeoYlp9dXu9uwPYd0aL+7ITZKBZHszMSO6p3FFDNymhK7pElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336976; c=relaxed/simple;
	bh=HnAad4lzGBUYjbuxXOZB8V6WhYsxdOZ+G3HhtcB3SLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aur+dwbYFNMvHNaE44+zk+dQsLLpzmGdQIKhHBcHP1ctVY34sG6qDxQW+mJ3VKxqrJ09xjKkBME6tVDDmLYQx6AgaTJGkFFH9hfRK6vDX+Ar1PbkqzGFzH/eG3hUIeZgaZIyNUKwHwZlZdTTduLeZl0aMrqvQSoDgQ8DNluwNTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aEBhuqAf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dvcyn5Jo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5881xH2904447
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 10:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2+7mJqRdv9CzahvJIT/1lcBXKam/uxssND9O44YePDk=; b=aEBhuqAf+0++nF9n
	gWx1b9GBd8VrZuGccax4DCt9VSiNft46om2guZ69f0bBxLOAdNStjSAnf9b2Cq6T
	8oVsHCkJzbkOgFVuuyU1FZ68iGxNbJBaZJKsfPhmRpxuRT5XveiXLkbBWg6lj4oz
	yJQwEHKWtunGFuYdzUAScE33qvU5jHUuMYev5ct5Eieh0Ex8qJ7GJMXBvphAPlx3
	MmfCqkr1ujywez0c7ZccmnOR5Qy8yLI5JXfxtHFey3NJZCMG+TvJQTpPxHS6obvZ
	zibXylKm6kCA1+kkerI6nJw/X/CINtGM1VVu/e+TN9A5HUbCl8Im+AVk6dcbzi2S
	8cIsQQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7mbbtvnt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 10:02:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b227a71fc6so13168185a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762336973; x=1762941773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+7mJqRdv9CzahvJIT/1lcBXKam/uxssND9O44YePDk=;
        b=dvcyn5Joo+i7Fsue+K1VmO/OU99znNy67/JkgFOiqZm21MfcVhtR6iOtwoQ9meiD2A
         9Pidy6VAJB9ZRU5k0KbdcXaEQzeAPi/wChvdQDzL7nO5lgGc2CHzO8rNXUKczA6YG19+
         1vxFmvLh2iyw8tauIb1nViWXRyg3gD+WAxKuVA46zRSc8QEMy9FRRVhgv9XKsCZBod1y
         iY4SxJLMTYB7ZGXehjxI7pwRHoHsDSbFOR8sIhj4bHF2IjoeoRgE1H2c2TzbX5iA5kIc
         977iaUgyQ/zBE36iwTj4IxVRV/3Xn3Uh0YZ7DqWGa18RiYTsFn8lG7hFzwrIR9ecYRXZ
         dXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762336973; x=1762941773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+7mJqRdv9CzahvJIT/1lcBXKam/uxssND9O44YePDk=;
        b=xQR93kuA946hDrEWyZEoUA6io6YfGSnLF2bqJ7WIZXrxQZQTvdxgMHvyaz3LScr/sM
         6waa6qA5p/7bY9/xB/ITquCjUAjWKZWqdYeuWFIeqJC0kEtG5c29FOtk/WWAg1cKmGya
         My519bN4TtV7vPJlxcnfICpavSxn/njxqUytdC3/zI+29F3U+HqmfNI4Gk/eJ2QfrUhG
         crBcz2Ha4l0SxChTDdoVGM8rGUkNlpMFiGMOklARH6c6k3RFtEURZYh+M6G4r/SkEw1B
         Kuzcm1Ac7OD0PyocCTW8DfmBODqnmnmFu3437U++CyeudIhOZY4TWGqh+h7AjPq+eS1O
         o1Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVGM3oE4QTNRFGtiJhGFyu1IA+R0qysqYOFivNe7SWKFZV6rEnyXrN0C1+WC6iaSfEfVXDa5BjTwxWWG1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr/hJRShgzWgaKlAtALc3k0ia+kr9MsXTGuoup3prE898URdw5
	OM2xpNXrO66f2coteQpcetwdJwmSNaH60Yc9luIoVu2pvhaH26E0/mIhcY0QjVv5WXRNKSGb9WK
	xjQbeAcmiV6U9KijbjYvs39Xymt9g7//EH5V2tlhmgqXZaHmwmbmkLbRhvKeajrAWF8A=
X-Gm-Gg: ASbGncvWB59bRFJfCXsHFoHdIABZdc5wRNF9aG4XqbOsqww3BloGqgjt53Td4krVVhX
	HcDvo7MsbpIz1TSiZlaLVE7HXsKb6tiM/2PnJZFmU0QMYitQ4JXGRUe4nf8kgC8KqCojmgTJW3h
	hCnx+7hCbbGM/2/Uq24IzLPK5/mn6NQ01HEt4+DYZNsn4g/d9ei7WJEx/BOUe5P9K2nKrpDlzDh
	0gTILCJYDMcf9oDaPPdr2t1ezHB4+FqUZD7QhPZIHsP7LOSgQlXIetSCc1DQ32S4/mL9kMX4beY
	72ysmHyHz/N5uJZR3B7IYmLNGzXwcRQO/HwB45ZvUwIss2hW+ePmrys+nfh7qioPtdOQpxd9CUX
	8R08VgVA6L8QmwFy3PHj6I8W+BW8NEZO1TggdbLkdIUIJszENxz/tWo71
X-Received: by 2002:a05:620a:4490:b0:8b1:95e2:4827 with SMTP id af79cd13be357-8b2207ce66bmr248210885a.0.1762336972939;
        Wed, 05 Nov 2025 02:02:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmlPUmABC0KXNowYoFlfnhU2/PAbD4c7vgDL6QH3w4O1cjeIvVXsezcMv6JNbv1CkYPYMAVA==
X-Received: by 2002:a05:620a:4490:b0:8b1:95e2:4827 with SMTP id af79cd13be357-8b2207ce66bmr248208685a.0.1762336972351;
        Wed, 05 Nov 2025 02:02:52 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7240540d7csm437308766b.71.2025.11.05.02.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 02:02:51 -0800 (PST)
Message-ID: <03dce1ab-3ef4-4441-b363-ca0a58664e96@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 11:02:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: Add backlight support for eDP panel
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
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
 <4d0f1892-8aa6-4282-8c36-75f1e46cbae1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <4d0f1892-8aa6-4282-8c36-75f1e46cbae1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lNkFZjNOD7wrN4sGvoRmeJm5OYKizWl3
X-Proofpoint-GUID: lNkFZjNOD7wrN4sGvoRmeJm5OYKizWl3
X-Authority-Analysis: v=2.4 cv=MK1tWcZl c=1 sm=1 tr=0 ts=690b20ce cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=eZhEbVVfMUXm6rNhgUoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA3MyBTYWx0ZWRfX/Km8VUns+EZw
 fqIjDUF4BiAHTBEGwpaGngy+lhEMvsi43gh5+aElgiuJd3rzAf296fXNIgDEhq+5Senc8+NO5+t
 Yk4pE0xCfPiER6f8TS4qQHUINQ7cvU43fqpEbLqPKyZ8MM3PbBrAsPiP3imNxpFp2XjvdNF1y1K
 nekeJFZwy1KzXs7eAf8PU+7TjYEHMA17NFsLOAsF0UY6KQTz9GpIokWeQZFcJtCSv8hmA6U84mS
 cS6yCn9RO6nE3Idwv8lJfT/+TQCSulNBX33Im9J6bjkooIkiTIB7MTLe1uTbT6JA1Vk8fx/vcO2
 2s54DMEBRtAIevosBUSAAS/Y4Vc7DEKgheoDvf6Gk/8JIWx0uoxBJUYoSAoBR2YTutqlDPCBGBK
 DpziZ72vs49YgkxmIQCE4J9qvGBeXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050073

On 11/5/25 10:58 AM, Yongxing Mou wrote:
> 
> 
> On 10/30/2025 7:27 PM, Konrad Dybcio wrote:
>> On 10/30/25 12:07 PM, Yongxing Mou wrote:
>>>
>>>
>>> On 10/30/2025 5:41 PM, Konrad Dybcio wrote:
>>>> On 10/30/25 10:08 AM, Yongxing Mou wrote:
>>>>>
>>>>>
>>>>> On 10/28/2025 5:08 PM, Konrad Dybcio wrote:
>>>>>> On 10/28/25 8:04 AM, Yongxing Mou wrote:
>>>>>>> Previously, the eDP panel backlight was enabled via UEFI. Added backlight
>>>>>>> control node in kernel DTS due to some meta may not enable the backlight.
>>>>>>>
>>>>>>> Aligned with other x1e80100-based platforms: the PWM signal is controlled
>>>>>>> by PMK8550, and the backlight enable signal is handled by PMC8380.
>>>>>>>
>>>>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>>>>> ---
>>>>>>
>>>>>> The subject must say "hamoa-iot-evk:"
>>>>> Thanks and got it , will fix it in next version.>> arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 55 ++++++++++++++++++++++++++++++
>>>>>>>     1 file changed, 55 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>>>>>>> index 36dd6599402b4650b7f8ad2c0cd22212116a25fe..fda1b3a3c7673be74832c27849231cba4bc1f25f 100644
>>>>>>> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>>>>>>> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>>>>>>> @@ -17,6 +17,16 @@ aliases {
>>>>>>>             serial1 = &uart14;
>>>>>>>         };
>>>>>>>     +    backlight: backlight {
>>>>>>> +        compatible = "pwm-backlight";
>>>>>>> +        pwms = <&pmk8550_pwm 0 5000000>;
>>>>>>
>>>>>> Try adjusting the backlight value.. you'll find some funny behavior
>>>>>> near the max level.. which reminds me I should send some fixes for
>>>>>> some laptop DTs
>>>>>>
>>>>>    I tried sliding the backlight between the maximum and minimum values. It seems that at a certain sliding speed, when approaching the maximum value, there is some brightness flickering. Is this the phenomenon you’re referring to?> [...]
>>>>
>>>> "maybe" - for me it was the brightness actually going down beyond ~80%
>>>>
>>>> The issue is that the PWM hardware can't really do a period that's
>>>> == 5000000 ns
>>>>
>>>> But it seems like this is no longer an issue since the driver now
>>>> rounds up to the closest supported value, see last couple commits
>>>> to drivers/leds/rgb/leds-qcom-lpg.c
>>>>
>>>> Konrad
>>> Oh,thanks for sharing that. I saw the phenomenon you mentioned. Previously, my baseline had already merged this patch series: https://lore.kernel.org/all/20250305-leds-qcom-lpg-fix-max-pwm-on-hi-res-v4-0-bfe124a53a9f@linaro.org/, so I didn’t observe the ‘brightness actually going down beyond ~80%.’and just very slight flickering. After I reverted patches, it indeed appeared.  So here i want to confirm,
>>> pwms = <&pmk8550_pwm 0 5000000>
>>> can i keep the value 5000000 ?
>>
>> I think so.. perhaps make sure the period is appropriate for
>> the backlight device at the other end since you mentioned it's
>> flickering
>>
>> Konrad
> Compared to ‘brightness actually going down beyond ~80%’, this is just a very slight flicker that only occurs when sliding the brightness bar at a specific speed.It won’t occur in most cases. Also tried another value pwms = <&pmk8550_pwm 0 4266537>, and it looks the same, so can we keep it at 5000000 here?

As I said, just put whatever the backlight that the PWM controller
outputs to expects.

Konrad

