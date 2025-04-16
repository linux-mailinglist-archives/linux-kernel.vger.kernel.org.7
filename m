Return-Path: <linux-kernel+bounces-602544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A804A87C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 11:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11393AE0A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 09:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E6B265CD3;
	Mon, 14 Apr 2025 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MGTAg3NE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79568265CD1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744624165; cv=none; b=i8/YW1HarmcWv/IsiAcDfIuOGU72WvX8P5IO7olf8pLT8Y8vA21sVlUnw2Tz7P1zG3e7YqcNUJw8noRh5suJhu6mUZpRrHJ2HTKHp8SjevhDZugxQYYBT/3bArxg70LYzsQrjpNd1516hzb88NL4hJ0Av/Z9TBkm4QD2ANXdl98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744624165; c=relaxed/simple;
	bh=yUKqCPPORdYVe342mQqddOKMLZ0bybmVAHWIG65MK4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZcjDjms/4Z7OidRO05zMiPrvGnhrsZW1S0c7SunLN6Q4trcD17/AG+IfAowMn0+fZ1z+TH2YH8t9vRnBYDcnR0XVXUPtZ7mUYKuewoDo+xYIVZei0ibHaq4EOZDwHrQdQ9wgAIPyF9qiyW1BZF2QqSvmwzb/RidVhWJ5yg2Rjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MGTAg3NE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E99vr7001845
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 09:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/sdJrQAAPCExE5G43phs3Cg9sP4wasVXTslo08/sa84=; b=MGTAg3NEob7NbEkF
	KwirsgchUJrFDt+xwKjcEdYD1rRCu6BM5E7bQv0ZxVRcBP2Dm4KHou/aNK5JWiBl
	onbAxJKCP5xfRzwp+z6zhVwCJ7povMgpLO86sy3iA7o6/lZDtmP6zqlBJdFSToJ4
	lBQcVdiv3AEQPfB10wdZRgaDbcLMNX5Y+hGLY0YOrU9tFIrZAsCBVtXcw86NHQCz
	oWKORFiiU4Usd/Vt2FKCu5690IcrJFZyTi9QZOwQY6lgn2SEsI/IC8jYLXz8R+5S
	U4YI9Jl1jNusicIYY+pLHnFwI5CS+/pOwUoRh9UF2WQgS7wDpqH4AgauSfYAIh+3
	h3vkiw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydhq4ajc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 09:49:21 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8fd4ef023so8003246d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 02:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744624161; x=1745228961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/sdJrQAAPCExE5G43phs3Cg9sP4wasVXTslo08/sa84=;
        b=iJVprkm8YzrG2tQOh2LEjhWy/XMgkgl5pht8w3Zm9EUma3Y5dhzITcO2sWr0LC5RCU
         mEhmbSo8Z56Oau1ywX3Kv1/MFSZdrOzkok7BGxO3XXDA60+ezekgLNa0iuNu+LtvC6fV
         VrAV1oJh/ST0giMqbudQgioYPmQvVm7MJX3mIVueVWmZMa8r9kBdcwiP/jpDEIeMkZDX
         Ynl9HijTBTrFq0Pvdt+uGvDNdH8QJlc+YderzbW6hoSJIh1l5Fzugvg7aTY42XmgVMAW
         Dlsw6JMvXgKA0vCfQHNcyRjYVnGdh/snExMj4Zq4oaUL2MvDRqQ76bpZixu/of0KySvL
         lfZA==
X-Forwarded-Encrypted: i=1; AJvYcCV6UCbBtiC7z+TRWy0ZmdJLAnb4GBhE+mlVPU0sWvHYNRhs495l+6jczmwwS4hjFEvwU7xv3SOL2dNihnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YygeDrTJ6z2F1zP/ePmqoroacAv7ryH9gKuTNYmnNIeEnElpQld
	o0lKyLtKsyqd83VZiPYIDq6fs+VyYersroEJKM1p6Jdz9nejPRn/z3d4cVL3+oBD+H7qs+XU9NR
	VCkYlyiKTH6pfj+Zap65dXNHZnaSRbVWge7iVWIJgN1JJFWeJ9UTPnvcHaCgmksQ=
X-Gm-Gg: ASbGncvKKJYtfnQ62TJySzAKd4CFKCGZiCvklgFt3tl3hjEYbZHntCsblGpuZmAKHf9
	IbXX2XqfCUKlIwR9oiLU+zDlFllWukPw6Jr/CLbPjiV+0NvrMC6GYiEr/0LbwugYS0nYAqfuSNI
	2UmV3Wtc+WfI6CSJ2WYEySsIojR2huVuOBOuiWZS4BlreRryJzOqoGH5xYn/e/Q0NlQa6KAc+If
	Azg4X3v+A8MJSKUML3TxT7VO+hDuwQGmY1jfZ7+3kKDI0N0ukuhGfmSxEh5HEW6CK8pufxnMX6C
	FThURuuz44c6NZ8Ma492QWNXDML50yxyCrs6WInPgf5lgSCGoNXALYBGY4kd2mIfDg==
X-Received: by 2002:a05:6214:1ccc:b0:6e4:449c:ab1d with SMTP id 6a1803df08f44-6f230cb46cfmr64487986d6.2.1744624160753;
        Mon, 14 Apr 2025 02:49:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhADRsGTwzKbE5j8WsaRwODBqXHXEGGv9BGd3uEhWTHB0foPltVfzAR/8ilB2KcoK3NHYsZg==
X-Received: by 2002:a05:6214:1ccc:b0:6e4:449c:ab1d with SMTP id 6a1803df08f44-6f230cb46cfmr64487836d6.2.1744624160216;
        Mon, 14 Apr 2025 02:49:20 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb422asm875859166b.115.2025.04.14.02.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 02:49:19 -0700 (PDT)
Message-ID: <60239482-cc86-495c-9184-11f3453251aa@oss.qualcomm.com>
Date: Mon, 14 Apr 2025 11:49:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Add support for X1-based Asus
 Zenbook A14
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, maud_spierings@hotmail.com,
        dmitry.baryshkov@oss.qualcomm.com
References: <20250402084646.10098-1-alex.vinarskis@gmail.com>
 <20250402084646.10098-4-alex.vinarskis@gmail.com>
 <2b9128be-1989-4511-995c-103c8ba71af7@oss.qualcomm.com>
 <CAMcHhXrBw6a7gSndG2F-JNgnNsYrDN3nTJjM+NjuT=s9FFWZkw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAMcHhXrBw6a7gSndG2F-JNgnNsYrDN3nTJjM+NjuT=s9FFWZkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1y6yRtIyrXYIJkjlSNiW0CpUD_q2ioui
X-Authority-Analysis: v=2.4 cv=C7DpyRP+ c=1 sm=1 tr=0 ts=67fcda21 cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=OOIuroA6IYICTT_mFq8A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: 1y6yRtIyrXYIJkjlSNiW0CpUD_q2ioui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140070

On 4/12/25 1:47 PM, Aleksandrs Vinarskis wrote:
> On Sat, 12 Apr 2025 at 01:36, Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 4/2/25 10:44 AM, Aleksandrs Vinarskis wrote:
>>> Initial support for Asus Zenbook A14. Particular moddel exists
>>> in X1-26-100, X1P-42-100 (UX3407QA) and X1E-78-100 (UX3407RA).
>>>
>>> Mostly similar to other X1-based laptops. Notable differences are:
>>> * Wifi/Bluetooth combo being Qualcomm FastConnect 6900 on UX3407QA
>>>   and Qualcomm FastConnect 7800 on UX3407RA
>>> * USB Type-C retimers are Parade PS8833, appear to behave identical
>>>   to Parade PS8830
>>> * gpio90 is TZ protected
>>>
>>> Working:
>>> * Keyboard
>>> * Touchpad
>>> * NVME
>>> * Lid switch
>>> * Camera LED
>>> * eDP (FHD OLED, SDC420D) with brightness control
>>> * Bluetooth, WiFi (WCN6855)
>>> * USB Type-A port
>>> * USB Type-C ports in USB2/USB3/DP (both orientations)
>>> * aDSP/cDPS firmware loading, battery info
>>> * Sleep/suspend, nothing visibly broken on resume
>>>
>>> Out of scope of this series:
>>> * Audio (Speakers/microphones/headphone jack)
>>> * Camera (OmniVision OV02C10)
>>> * HDMI (Parade PS185HDM)
>>> * EC
>>>
>>> Add dtsi and create two configurations for UX3407QA, UX3407RA.
>>> Tested on UX3407QA with X1-26-100.
>>>
>>> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
>>> ---
>>
>> [...]
>>
>>> +     /* Left-side display-adjacent port, PS8833 */
>>> +     typec-mux@8 {
>>> +             compatible = "parade,ps8830";
>>
>> What Krzysztof referred to with fallback compatible is this:
>>
>> diff --git a/Documentation/devicetree/bindings/usb/parade,ps8830.yaml b/Documentation/devicetree/bindings/usb/parade,ps8830.yaml
>> index 935d57f5d26f..aeb33667818e 100644
>> --- a/Documentation/devicetree/bindings/usb/parade,ps8830.yaml
>> +++ b/Documentation/devicetree/bindings/usb/parade,ps8830.yaml
>> @@ -11,8 +11,11 @@ maintainers:
>>
>>  properties:
>>    compatible:
>> -    enum:
>> -      - parade,ps8830
>> +    oneOf:
>> +      - items:
>> +          - const: parade,ps8833
>> +          - const: parade,ps8830
>> +      - const: parade,ps8830
>>
>>
>> so that in case there are any sw changes down the line, people with older
>> DT receive the fixes, as if "parade,ps8833" is attributed to a driver, it
>> will match (due to being the primary entry) and if it's not (like today),
>> it will fall back to matching the next compatible (and the driver currently
>> looks for just that)
>>
> 
> Hi,
> 
> Thanks, was not aware of that, found it in the examples now, will update.
> As Krzysztof suggested to drop the patch adding compatible from
> driver's code, If I understand correctly I also need the following dts
> change, could you please confirm:
> 
> ```
> compatible = "parade,ps8833", "parade,ps8830";
> ```

Yep!

>>> +     eusb6_repeater: redriver@4f {
>>> +             compatible = "nxp,ptn3222";
>>> +             reg = <0x4f>;
>>> +             #phy-cells = <0>;
>>> +
>>> +             vdd3v3-supply = <&vreg_l13b_3p0>;
>>> +             vdd1v8-supply = <&vreg_l4b_1p8>;
>>> +
>>> +             reset-gpios = <&tlmm 184 GPIO_ACTIVE_LOW>;
>>> +
>>> +             pinctrl-0 = <&eusb6_reset_n>;
>>> +             pinctrl-names = "default";
>>> +     };
>>> +
>>> +     /* EC */
>>
>> It's customary to leave the i2c address to make it slightly easier for
>> the next tinkerer ;)
> 
> I am unsure about the address. There are multiple addresses showing up
> when discovering the bus, 0x1d, 0x5b, 0x61, 0x6a. Did a quick SMBUS
> analysis, they all have non-zero registers responding... My best guess
> right now is its 0x5b, as messing with it enabled backlight and broke
> the keyboard. Will add that one.

It may be that there are also some 'dumb' devices, like program-and-forget
regulators or similar components, that aren't even described in your [SD]SDT

>>> +&uart14 {
>>> +     status = "okay";
>>> +
>>> +     bluetooth {
>>> +             compatible = "qcom,wcn7850-bt";
>>> +             pinctrl-names = "default";
>>> +             pinctrl-0 = <&bt_en_default>;
>>> +             enable-gpios = <&tlmm 116 GPIO_ACTIVE_HIGH>;
>>> +             max-speed = <3000000>;
>>
>> You'll need to provide some supplies, coming out of a pwrseq device, see
>> e.g. the QCP
>>
> 
> I assume you are referring to change like this [1]. There were some
> discussions on whether the supplies are modelled correctly as it seems
> to be different when using m.2 card, so as I was not sure about this
> platform I did not add it. At least in the variant that I have, the
> wcn6855 is soldered onboard, so I would assume so is the wcn7850
> variant.
> It seems that the two use quite different supplies - are the platform
> dependent, or only wlan card dependent? Ie. Can I just copy pwrseq for
> wcn6855 from a different platform?

The power sequencer is a description of the hardware that's part of the
same die as the wifi logic, IIUC

The inputs are most likely fixed per SoC+PMIC combo for various reasons

> For  wcn7850's pwrseq, I can add similarly to other platforms, but
> cannot verify it. Should I still add it in this case?

Let's not introduce it then

> A bit unrelated question: in the meantime I managed to bring-up the
> sound on Zenbook as well. Would it be more correct to wait for this
> series to land, and then send it separately, or is it okay to add it
> in directly on re-spin?

Let's get what we have merged first

Konrad

