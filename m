Return-Path: <linux-kernel+bounces-790366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2260B3A615
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881783BE1CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78122322C7F;
	Thu, 28 Aug 2025 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n6/z6yMr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8FF321F53
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398073; cv=none; b=hS9/CtLODX87p8Cx4Edbcv/qrDSc8uTdm7Ns2sDlDxnoJinI3ubxpooZb85BdeaMSZk4wirGyAzOLgGgIu0Zl8pi9jI4HbHeDs0eoo5kK3upA++V71mubvUPBFl+YA3oiY/FEbPnTqc5q8Di8pQDNQ+m+IsGTti+splj1Puvezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398073; c=relaxed/simple;
	bh=vTIbUfp/TwWtKVCv1PBkdes53gCsIg9GIJLhd4qrAtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYV62gY9k5A7O6B1g+nLE7u8+CPxjjPSmDyA/lYPhyGZZOsCDQw1IragnEFChZcMnNl4Kwwn9pbIzc/dCVi+vvH11suaM4Mocj1EJJby0x4d3wuUs+UOEouupRPs8/ZA2qXjJVMenuYlqge6iEK+V0m8B+1Ne6u/jaANMmkO2As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n6/z6yMr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SESp14008214
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	znAsb+ZopRvgTds/k9cU0hyb9L+YL0iI3cUXpo7Sukg=; b=n6/z6yMr2x4wO8ff
	1MQHumuiEMAEzF/ryFPkmifwGexjDIkRYnJFNGv806Z2cuxP1QA9RYtNW0FU2ZwR
	TzYcI6ay0DA0VrHLnQgSwte5HAUkGXmQy+1GP9vdpi61yDPCfHUMXZ4018IFqUcp
	bgN6RYYcnaExMR9TUvZ5mu+lv9UK+Vp7FRGgugYXg/69qqSjyx8MPhkHjQobUIIZ
	DX6av4rlEZOaARaIVD7g24PYfxHjTlykgHY5QMsLeCIAZ14D49wQqjSJvEHsp5/k
	hDPzdRjguLR+5XawKvUIthuZJJENfQMSdsMeeY3mfSi7lagd4lfI4r1DOQIMuUA0
	HIAULg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48sh8aq59b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:21:10 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7720c7cc099so1955918b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398069; x=1757002869;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=znAsb+ZopRvgTds/k9cU0hyb9L+YL0iI3cUXpo7Sukg=;
        b=iSKDMMYPhyuGb5mH96BT/iWqAZpokqCRfm1u3SZpxRheLQz/YAGbQPAeMD6UeToHHE
         AjHes6GwUy8QqO8ce14ndr6tvKcb/SMpVxD1zVIoZfbIPSCatc91i48QTMZ5HdPOO2lq
         5J00agP0VSrB5b7em/NS6jFQVsk3bc1YNjkRxpgqg2FFJuKGnvPcB+50pOdDmNRo5sbc
         r7NhxHeCd++7bxdrecb6A2yf0LeDKNOsvmjxxSOXBdMZdcdEv3YAiW5Xey+dgKMLatZ/
         ea2hYAcEkmhtOqCAEiYb5yKeJD5jmQxvRqGf6H4gpazpNBE6LTT+q7oSygk0gI1FGYyU
         s7zg==
X-Forwarded-Encrypted: i=1; AJvYcCXJiCp+hWWaktYQF8wbfx3KmoepU7FmtD/C/HOlAz2R3L+4Ka9gbZdvFY+ijkQ+bYtlQs1kM1fNrCBih8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpgTrQaCW1THTQVq82aZMT0IPGBSGlxSJpdS0xaJ5A0JC+eYFf
	2+T4VepDvYskx8RaogE2nfolwRE5L97rY5qHBddXCeBQCUT0UNf/y1PDr9n5roRXeKd08jx/lIS
	fzESNjayoOSRuytd3m8kROs1PBdnwx9LuV+qsnSy7gaeSm9jdW5O0VdFTXNKi9uEYubQ=
X-Gm-Gg: ASbGncvvquivXcPgJfsPem8i/YsvQs6PHzOQIFkEWavsMPulpi4LgSPtqGDLZwl1qXo
	QmQqO/90eiV+XmT2ZIKc8WDlZoGSYei/uZ9K9QAof0Ck8bIe+yDvqA0UXu58TCchCxSQjwyemZu
	CbFbiCXYUflOYRFnQbpwb3zZFB/1EJ3V/i4NDmuATSLj/mTaAyzo7pvPA5V8l8OQuYxNRjt+DFm
	9+3Um3iyL82qn1Qz8DZMGpsaV+g8X8I4GUwz37+eK5HiF2n5tiq6vkYZI/lNQo9tXTXZ+WE6RnY
	D2iHQ3WMqQ5SxS4UvBd6g7ESliiRb7krxRnKaTOfMwb18cR+lhW/b3FgxT4fCSjJxtQkbGip17B
	lBIxtZ14=
X-Received: by 2002:a05:6a20:12c1:b0:23f:f7ae:6e3e with SMTP id adf61e73a8af0-24340b5b1cdmr36905319637.24.1756398069275;
        Thu, 28 Aug 2025 09:21:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExqmXUxvYw5B6SH7k7jHDWdLt86kgIQlso126aaCZiyRaXqp/vbw3rwGx74MyI6sC7Kdf75w==
X-Received: by 2002:a05:6a20:12c1:b0:23f:f7ae:6e3e with SMTP id adf61e73a8af0-24340b5b1cdmr36905266637.24.1756398068796;
        Thu, 28 Aug 2025 09:21:08 -0700 (PDT)
Received: from [192.168.62.36] ([223.228.107.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8ca240sm14446086a12.25.2025.08.28.09.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 09:21:08 -0700 (PDT)
Message-ID: <4cc22d40-d071-45c2-8618-3d93ae4797e2@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 21:51:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: lemans-evk: Add sound card
To: Bjorn Andersson <andersson@kernel.org>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-5-08016e0d3ce5@oss.qualcomm.com>
 <kckx3uwj2zdc4iagsxhb6osyv2ki7n4qubyldnvwokkkftda77@ixrgr7vapwxj>
Content-Language: en-US
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
In-Reply-To: <kckx3uwj2zdc4iagsxhb6osyv2ki7n4qubyldnvwokkkftda77@ixrgr7vapwxj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cLDgskeN c=1 sm=1 tr=0 ts=68b081f6 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Tcuekwa6JFTrCABMbcRULg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=wk-bp5ZmwQyaC1E5B0gA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDE1MyBTYWx0ZWRfX8ta2csIc++O8
 RXDingFl/CrfwHV3ZXgqfYhqC+RxI12rSHk1cRrl3cC3lJwddQLN4JXqCs1xTgdPj2mfyFB6NDU
 I97azE8eBmtGzoQHQuRZ1xpxZw7GTR/c+kyebChwHJQ5UtfCWDAKPkRvrR3B+X3nbLtshpJJf+6
 N1pbStXVk/SmjyisVtZEAup2rxlkq1Zw1v6Smee4o/oYdLQPNbvrqo7Xfw6n7BrWiZTIA4bb2AX
 HRHhi4mA8bHvKJndYV2+tCcFY9zNhyZohsBO90Vkjiet+o3fvVbiHkdW91Qat7csiPib8PyIzvH
 AxajiuF7BWMtAGTVImYQlTuJqZmYqu6QQYv5OJGLi/HtBjj/rWXve/tApIVdNJaiJypphe1xG+W
 tXZLDvEN
X-Proofpoint-GUID: 6y91RCnzwu90UBQsNwbuHzGzVOeTh5rF
X-Proofpoint-ORIG-GUID: 6y91RCnzwu90UBQsNwbuHzGzVOeTh5rF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260153



On 8/28/2025 4:37 AM, Bjorn Andersson wrote:
> On Tue, Aug 26, 2025 at 11:51:04PM +0530, Wasim Nazir wrote:
>> From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
>>
>> Add the sound card node with tested playback over max98357a
>> I2S speakers amplifier and I2S mic.
>>
>> Introduce HS (High-Speed) MI2S pin control support.
>> The I2S max98357a speaker amplifier is connected via HS0 and I2S
>> microphones utilize the HS2 interface.
> 
> Please rewrite this as one fluent description of the hardware, not as 3
> separate things thrown into the same commit message.
> 
ACK,

Sure, will rewrite proper commit description in next version.

Thanks & Regards,
Rafi.

> Regards,
> Bjorn
> 
>>
>> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/lemans-evk.dts | 52 +++++++++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/lemans.dtsi    | 14 +++++++++
>>   2 files changed, 66 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
>> index 642b66c4ad1e..4adf0f956580 100644
>> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
>> @@ -7,6 +7,7 @@
>>   
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> +#include <dt-bindings/sound/qcom,q6afe.h>
>>   
>>   #include "lemans.dtsi"
>>   #include "lemans-pmics.dtsi"
>> @@ -26,6 +27,17 @@ chosen {
>>   		stdout-path = "serial0:115200n8";
>>   	};
>>   
>> +	dmic: audio-codec-0 {
>> +		compatible = "dmic-codec";
>> +		#sound-dai-cells = <0>;
>> +		num-channels = <1>;
>> +	};
>> +
>> +	max98357a: audio-codec-1 {
>> +		compatible = "maxim,max98357a";
>> +		#sound-dai-cells = <0>;
>> +	};
>> +
>>   	edp0-connector {
>>   		compatible = "dp-connector";
>>   		label = "EDP0";
>> @@ -73,6 +85,46 @@ vreg_sdc: regulator-vreg-sdc {
>>   		states = <1800000 0x1
>>   			  2950000 0x0>;
>>   	};
>> +
>> +	sound {
>> +		compatible = "qcom,qcs9100-sndcard";
>> +		model = "LEMANS-EVK";
>> +
>> +		pinctrl-0 = <&hs0_mi2s_active>, <&hs2_mi2s_active>;
>> +		pinctrl-names = "default";
>> +
>> +		hs0-mi2s-playback-dai-link {
>> +			link-name = "HS0 MI2S Playback";
>> +
>> +			codec {
>> +				sound-dai = <&max98357a>;
>> +			};
>> +
>> +			cpu {
>> +				sound-dai = <&q6apmbedai PRIMARY_MI2S_RX>;
>> +			};
>> +
>> +			platform {
>> +				sound-dai = <&q6apm>;
>> +			};
>> +		};
>> +
>> +		hs2-mi2s-capture-dai-link {
>> +			link-name = "HS2 MI2S Capture";
>> +
>> +			codec {
>> +				sound-dai = <&dmic>;
>> +			};
>> +
>> +			cpu {
>> +				sound-dai = <&q6apmbedai TERTIARY_MI2S_TX>;
>> +			};
>> +
>> +			platform {
>> +				sound-dai = <&q6apm>;
>> +			};
>> +		};
>> +	};
>>   };
>>   
>>   &apps_rsc {
>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
>> index 28f0976ab526..c8e6246b6062 100644
>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
>> @@ -5047,6 +5047,20 @@ dp1_hot_plug_det: dp1-hot-plug-det-state {
>>   				bias-disable;
>>   			};
>>   
>> +			hs0_mi2s_active: hs0-mi2s-active-state {
>> +				pins = "gpio114", "gpio115", "gpio116", "gpio117";
>> +				function = "hs0_mi2s";
>> +				drive-strength = <8>;
>> +				bias-disable;
>> +			};
>> +
>> +			hs2_mi2s_active: hs2-mi2s-active-state {
>> +				pins = "gpio122", "gpio123", "gpio124", "gpio125";
>> +				function = "hs2_mi2s";
>> +				drive-strength = <8>;
>> +				bias-disable;
>> +			};
>> +
>>   			qup_i2c0_default: qup-i2c0-state {
>>   				pins = "gpio20", "gpio21";
>>   				function = "qup0_se0";
>>
>> -- 
>> 2.51.0
>>


