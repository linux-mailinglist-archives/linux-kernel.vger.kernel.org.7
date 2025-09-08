Return-Path: <linux-kernel+bounces-806444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE22B496DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC8B443AF2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38C43128D3;
	Mon,  8 Sep 2025 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bq0l7xzn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFDE312819
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 17:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352069; cv=none; b=GAeRfC6G/PcMNR6vXYxyBZKYbwjDKjl8S2Br/UDy9QkSMmdf5VXpiSSElUukJX5wVG8KobdncdijIjKPRzQEwawm4CJXK6LNTX70fiJpR0wgWl6qfd2ooQdb74ZGykvCHSToEwk+9xTvFN0HoIoVPAXuGxMhv3j4lc1iBbpZXf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352069; c=relaxed/simple;
	bh=G4BrLvgleWaxxht72XKMAEEw2IxbTnc795ofruBpdCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjpPjb5KaqFGop8BLoKBD2Euv/QRew9TAofAKkimpgk5wq/VR+XAne7tXfCMvoQziurUiroke0UlKmBW38hPZ/6wl2oujKwWOGvxN0Q/ikjlK0rTMKVJGp+46df3KWMo0OYKaRlBa4TrHuxa9gaWRyWcyOBv7Br6V+hYc5rozXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bq0l7xzn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588BE8pM013569
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 17:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ODZs9h0J4Tt9rKYM/lsBJZbKSKYYe/vF4vwiFuP4OVE=; b=bq0l7xznvGgqX4MF
	xG4StxRIL4s8AdMobbe01/TBgehMgPWm23PWSnnPksEcTPbDIQFf/rmLzlyhETcB
	DTS+nrNeSyEhrBMiV6d/baQyRKZ/qCg+nAjW/kf++s2qwAOnuO/G06zGWeqhSg7m
	MzEDCgoV/4CpWFqoOPW6lJ9ESFo7jX7N/tqoNqLqihEFaNVp6inuirYb+mF9IVAP
	RzbmuU9DPCep9rAdJU9xu456VsY7NwIvQ+ZK1MtKuwUuhGPVpyyEkz1cQsNcekeW
	t+W2TmHpPAt8z0v0HDU15WClPOhiOFmyrFVfJzRTkEw8vDcXDfNzv5gZDBQ5CbCz
	+K92Pw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491qhdt879-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 17:21:06 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24ced7cfa07so45160885ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 10:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757352066; x=1757956866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODZs9h0J4Tt9rKYM/lsBJZbKSKYYe/vF4vwiFuP4OVE=;
        b=kxf5YRAzujcxSceg09FaDIysm6wKIoKIvmtDDYqfHav1hXcfK0BcmnIPJQTxLgDMsO
         zpaMfCl7Ljxb5yX9spjVoxfqrD6mpY87b2JVC+4KmNA4WB+gNHV7HwjBGbQxWsq1Nteb
         5Kktpi52Dgg+iqaqC5q0HZXwQCPNpOjXHLIToJGNTKVv9AuurVE6sBG8z5N7HbCJuvze
         kWhtmO1A1jMfZg1WAyPORacILrHHaFz6Cb4nfeTZlxp+qnAzp45rtGBwIZ9TtnICz9/u
         gpc9oO2MsGQ3VWUKX38Ud/NI1PA1AgB/u8NLmZmWcROOCkQpwlyeRxa3SWbNFY/g+5Ii
         i05w==
X-Forwarded-Encrypted: i=1; AJvYcCU/6igUt4wD6poEUZ2w4KlvjafWhDJIynWTa3Javo/p7ouuhrp9NYEWHV+iqu8lpBGZfL/LKrUHXC725i4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4SwEnpu4qh2QTNWb/ld1VuRWkbFIdZLiSDj8IOhkWSbdMvqk8
	SQWIJItV0KpIZKryywcLXPLuITMIUTT1+7g2Z4ER41XqC8ne6iYF4JRSee/VPNAIqCP14I8PBMI
	ekwvMZXBcJE0nHZVyjVdHBLFJp5xxZwawU61ELuiz4bj6KUD8H3UZOXcdovLDZc/6i9g=
X-Gm-Gg: ASbGncsVkeYwR6MRMP9Eb0t5fwCb3M8zxLO9JiG1iYNU7bCrAJqBIYDmBdbm3lAKa9a
	6y2b+9mZB1jTYLYWdYrsRHtSzBSiXy8gwRbIUnHgncfGml6RWc99p5TsfP/JBXho3OK7v0xC6lb
	RqKwDIL2murQ3xpmtP1fnFbBnLlO4FkPPrjKu+U2/d/7+2HXTteCYVDViI+6WgZvnAkWo9CmL7i
	tqea5G6Z14B2wt/UDvD76ZIayERjlADelvCeV3TOyddPVjMJRVBB4oMvDJU43OOTjDjR6+WB/Jr
	qBELpbdJEU/tqjp4NtIfDnEad1gcz4OvUuDaINj1rcpwrukmSUYbB0rAET77ZrfwqEFzHuqN6Ex
	3LGc=
X-Received: by 2002:a17:902:f545:b0:250:6d0e:1e4d with SMTP id d9443c01a7336-2516dbf1ec0mr110154015ad.4.1757352065833;
        Mon, 08 Sep 2025 10:21:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQkPNfzkAlHEBiLtjeXJpfUmFQcP93l7F9njp/9qBA4losfZNr9ZSj7Wz9mErmHUlusFnO5A==
X-Received: by 2002:a17:902:f545:b0:250:6d0e:1e4d with SMTP id d9443c01a7336-2516dbf1ec0mr110153605ad.4.1757352065134;
        Mon, 08 Sep 2025 10:21:05 -0700 (PDT)
Received: from [192.168.1.5] ([223.184.71.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327da8e71a8sm31147628a91.15.2025.09.08.10.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 10:21:04 -0700 (PDT)
Message-ID: <2f29addf-881a-4aae-9f3c-d8f20f8fbad4@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 22:50:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] arm64: dts: qcom: monaco-evk: Add sound card
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250905192350.1223812-1-umang.chheda@oss.qualcomm.com>
 <20250905192350.1223812-5-umang.chheda@oss.qualcomm.com>
 <7bzlof2wyqqorhh4xck46wd43zlehm4vhej2oaxajo4dxn5p7p@oc3vikzxcwke>
 <nphea3rtl3z2tgpyn4g4hf7ticbg4kyhgv4ht25etfxspsgkv6@dm67wp7x4mdt>
 <5bbe50f6-5fa3-4685-8f2c-67986c5171ab@oss.qualcomm.com>
Content-Language: en-US
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
In-Reply-To: <5bbe50f6-5fa3-4685-8f2c-67986c5171ab@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: uBQp2zG8S5y3KyqeLXT_PUA0ssH_04Yd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNCBTYWx0ZWRfX0K14aJg4EQix
 of5OE9OcwCpCFRyyz6lDACn2s4CfqzzSlIj6CcB6TnwMdrSDO8ZTGSM9YuYlm24WLgHR7fKeNb9
 gJkz4pcN5mm99kP0XBVK8ZHhOpZ8mX7mRUJXv4crR14P5ODJZpUOTphy9H/J8tUU20OUb+ptj84
 +xFS8pYIjm2Y8TJC+epoBRvOSxUY23yf7bDA2iiFt9reC9pioCV2BZozKyk+BGCJyHkjFg081h+
 Ul+9FPQoGVywvz2Yknfh6ZUzVZ5CJTCAtl9p5/LxfAPs56Frs3j4Qzc21Ed6zM+EmxHRYW90f/o
 PSwLHbnhb7298XKdTyMVjHTHw3V0myQa/w8BZk1y+Vl1wYQKmAO4IblPlEYK73JTwRg9km1lROv
 Q1C9pw7A
X-Authority-Analysis: v=2.4 cv=YOCfyQGx c=1 sm=1 tr=0 ts=68bf1082 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xi+emkTUnFkL6NAgZCPIgw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=lD4_i0t_BDgHsDeZWuoA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: uBQp2zG8S5y3KyqeLXT_PUA0ssH_04Yd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080034



On 9/8/2025 9:25 PM, Konrad Dybcio wrote:
> On 9/8/25 4:55 PM, Bjorn Andersson wrote:
>> On Sat, Sep 06, 2025 at 10:26:23PM +0300, Dmitry Baryshkov wrote:
>>> On Sat, Sep 06, 2025 at 12:53:50AM +0530, Umang Chheda wrote:
>>>> From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
>>>>
>>>> Add the sound card for monaco-evk board and verified playback
>>>> functionality using the max98357a I2S speaker amplifier and I2S
>>>> microphones. The max98357a speaker amplifier is connected via
>>>> High-Speed MI2S HS0 interface, while the microphones utilize the
>>>> Secondary MI2S interface and also enable required pin controller
>>>> gpios for audio.
>>>>
>>>> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
>>>> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
>>>> ---
>>>>   arch/arm64/boot/dts/qcom/monaco-evk.dts | 52 +++++++++++++++++++++++++
>>>>   arch/arm64/boot/dts/qcom/qcs8300.dtsi   | 37 ++++++++++++++++++
>>>>   2 files changed, 89 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/monaco-evk.dts b/arch/arm64/boot/dts/qcom/monaco-evk.dts
>>>> index 93e9e5322a39..f3c5d363921e 100644
>>>> --- a/arch/arm64/boot/dts/qcom/monaco-evk.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/monaco-evk.dts
>>>> @@ -6,6 +6,7 @@
>>>>   /dts-v1/;
>>>>
>>>>   #include <dt-bindings/gpio/gpio.h>
>>>> +#include <dt-bindings/sound/qcom,q6afe.h>
>>>>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>>>
>>>>   #include "qcs8300.dtsi"
>>>> @@ -24,6 +25,57 @@ aliases {
>>>>   	chosen {
>>>>   		stdout-path = "serial0:115200n8";
>>>>   	};
>>>> +
>>>> +	dmic: audio-codec-0 {
>>>> +		compatible = "dmic-codec";
>>>> +		#sound-dai-cells = <0>;
>>>> +		num-channels = <1>;
>>>> +	};
>>>> +
>>>> +	max98357a: audio-codec-1 {
>>>> +		compatible = "maxim,max98357a";
>>>> +		#sound-dai-cells = <0>;
>>>> +	};
>>>> +
>>>> +	sound {
>>>> +		compatible = "qcom,qcs8275-sndcard";
>>>
>>> qcs8300
>>>

ACK,

>>
>> If the Monaco EVK actually is QCS8300... But, I presume qcs8275 and
>> qcs8300 are identical when it comes to sound?
>>
>> @Mohammad, if this is the case can't we just support the
>> qcom,monaco-sndcard instead to avoid this confusion?
>

The Monaco-EVK board is based on Qualcomm's QCS8300 SoC.

Although the Monaco-EVK platform was previously associated with the 
QCS8275 sound card, the QCS8275 re-use was based on existing coverage. 
However, according to the naming guidelines, sound card compatibility 
should be based on the SoC rather than the board.

Therefore, it's necessary to use the SoC name in the sound card 
compatible string. I will update the DTS to use qcom,qcs8300-sndcard to 
align with the convention and avoid confusion.


> Commit 34d340d48e59 ("ASoC: qcom: sc8280xp: Add support for QCS8275")
> 
> Unless we choose to ignore that compatible and add "monaco", but I don't
> think dt maintainers will love that
> 

Agree. We used the existing qcom,qcs8275-sndcard compatible string 
instead of adding a new one, but this needs to be changed.

The sound card compatible should be SoC specific in this case, qcs8300.

I will update the patch with qcom,qcs8300-sndcard.


Thanks & Regards,
Rafi.


> Konrad


