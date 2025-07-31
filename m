Return-Path: <linux-kernel+bounces-751819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19150B16DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B1816824F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE6B22069A;
	Thu, 31 Jul 2025 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ot9m3uLM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69D42192EF
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753951542; cv=none; b=hl+4DVYK72y89ooPVNpFkaB07Un3Zh6l3Fe9uiFUBNYE3RZPyQ0lG0qgsElBNOwxQOvXqEU0xtHYKzD6xwTmnvvbGTVD2z1zhj6RtbsHGP/J0YsEsJUObY9KTP5l5RdozjRaWruVN6yjGw5ZX4Ur4MOgop4mlOGB3l9OZ53/DQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753951542; c=relaxed/simple;
	bh=18D46RaLmbTlUnUGui7/qF33DpRxEz3EaP4PJ+ve7B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISIsSroyMhvKPkKohMBp/RBan6d14/O8S+wzHaRpsZEbbWHSwsayS831McNpVT6Y2rxHQT5Oi96FxiM1/NSKaJ3JUNPhR2FXia5Pr+wBuaVHXbzCaRbSJ4EcntDL9KE38mhNvRMb+xDf95/WMS8EcdzZ834fMGVls5SI92mZ+C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ot9m3uLM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V1fOnF003704
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bXRoKDrQ98QDaWIGvaODl1kClGzq84AWkTwEHfO4DTA=; b=ot9m3uLMrt8Swrv2
	JW6MQcgM+0WjzL5mck7edWratKuyybPRZeNAfc3SyrqVrtLZDM8fMs7XpT3ssBWc
	1NRs+IhVfiN2TO299ROTelBckYrboEaCP5p0iYOFYBDFHEPcnMQX5oTjCiWjs518
	u7KPkCb72yI3w6af6yAxCEdpXPollx/q4b5zcKfGDDJf2S1NtB0x3iNueuAF4x6r
	iagv5OryYRO03kfTDGO5PqCNy5qTdjN40+bgs4wF8gJenf2X81Fyru/mPA2HHpQa
	iaYQ6Vf62yDneMHbLrlWdJ4JNjk8nRMCgoRm+u4cFOGwUF0yT22PjLWA48wXaiVF
	p/lvSA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pbm6v8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:45:39 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b34fa832869so1499971a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753951538; x=1754556338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bXRoKDrQ98QDaWIGvaODl1kClGzq84AWkTwEHfO4DTA=;
        b=V2KauHxfOMj23nWl4qPxeF8iKGFmHdfdwXJ6ioYkYKYbE1UlfJ/DfP0BsGHMjuAaQv
         IYTxyjOgHvIRct5udY4VcgebocJT6LKZk/1aLMtBVcopYhQ3sj3yb3lMsSTJynjRoC6+
         KgPOjyQGwMaq7+QNxuvhblFuPUqdne0MjhcHnNmTzLern5dPqMEN5f0OUuj0Y3JPpjHQ
         rs445NadBnwCpLgsDQSXi2I2V+/MdFWw6fSujpAjcOvq3p8iTwO0bemdMdr/6D7tWOQH
         ELNrHfAizXPd6N2b0cHsBYMePlKDtlGQje/nukWLKvc7Jp8acXxx43uPBaeN2AMshCKm
         rJfA==
X-Forwarded-Encrypted: i=1; AJvYcCUBhQDEOgTkv2OQtfjvoqz5VSRudlh/27BIlsM0HYbuFKO5ZjbuW0QNqMixEDZY4cLVVwyAoy/QA7j7wRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJZ5uBH9sLb79cCo/6j4KH8VCTusR3neWj2W3y7QdvlLtN22dE
	NYCc1LmtEnfPDkAGaCFkZNQY9C6D0yZhgcqr9LcQT0Sz2MxPKqYY0lOeOmeUUB9hrC8THT6AIMp
	E9NUCRTP0hgHsy3/f0yLsGnHV2oex46h4md0FUX2zVqwWbsZESsr45KRvinOX85b9YuQ=
X-Gm-Gg: ASbGncseUZ3yrpZBiSS1+LSB9k5fZt8LkjkftLUFo8AnYa0EfuBlWp6AtCaDmPEc4TK
	DuB9hGeceb/ZQ87ZK5HUV8ptbB4/bGxs7Hgraq2FyxIcoN8yOLVDa6eI/l5MsI64BXQsb/Q9nV7
	H2l2zCbJ25ZaHGiYL5a75RWy08SDYL5Yixsvstx73PZ+lrO+3Iztp2xk8DnYS6RZznoZrcfi2Tv
	CFE/zhmMbTxJJRVwIz0q5UUb5c3vZ1XrR//Z4e6soLQ03YZRHNotSyBFC6yiAHn8PSYEkvIjMAf
	mdo8eWq0hh69uEdz3LX97WGXNBclre0khAgTUYQx7SVLJuUM4ZUoQLvZv+l5adWL6ckJT5h1fbJ
	gyCpIZ0KTDDF5RLH7wJ3+ljAUHIwB
X-Received: by 2002:a17:902:ecc4:b0:240:4d19:8774 with SMTP id d9443c01a7336-24200d6b5a3mr17928145ad.24.1753951538163;
        Thu, 31 Jul 2025 01:45:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxMh58HMEu0FMobtYPpOQsJHvULEpFZ2FEA2ttpq4ZgGpHgUPWBls1eoQk0R3ywX13zcmFSQ==
X-Received: by 2002:a17:902:ecc4:b0:240:4d19:8774 with SMTP id d9443c01a7336-24200d6b5a3mr17927845ad.24.1753951537675;
        Thu, 31 Jul 2025 01:45:37 -0700 (PDT)
Received: from [10.133.33.143] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aca205sm11696515ad.193.2025.07.31.01.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 01:45:37 -0700 (PDT)
Message-ID: <391b8214-37f2-460d-94d0-3bd0daa00066@oss.qualcomm.com>
Date: Thu, 31 Jul 2025 16:45:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250729-hamoa_initial-v3-0-806e092789dc@oss.qualcomm.com>
 <20250729-hamoa_initial-v3-4-806e092789dc@oss.qualcomm.com>
 <pbvyog477v32s4lu72z52dhsond5yud5w3nxmcouvr6ljlndlh@ws46dncy35c6>
 <b4a3f568-f41f-4141-b421-8b158973f810@oss.qualcomm.com>
 <cawg456ucsvssm2ngbcjvpprxke7s3sfqf4fzoj5dtfj2flnzw@2e3h5ojgn4s5>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <cawg456ucsvssm2ngbcjvpprxke7s3sfqf4fzoj5dtfj2flnzw@2e3h5ojgn4s5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LsaSymdc c=1 sm=1 tr=0 ts=688b2d33 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Uz-00NkV9YIIZGY-jFMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA2MCBTYWx0ZWRfX6oXPocOmft+P
 tkoHQvMp4oxXHA5Mg/nRVmEVaY68AvXUEcX2WfkXTlgXW/NL7WgJm9vVGgSfEAAjpnj9h19+jVl
 Q93SXuA6+vemaHBD8aPJ0rYMHYvxFLxdh88wpKMG/8TeTI7pLlYiIHQmSGMvqgqoWNIMbwQ6mt3
 AIBB6S4eLhucrLiT+VCgDTM88r+DICnPsp0gSy8FWWpUAGG03CLRyYaBjfC2DGtnFGKP0m5PeeI
 8HxSvCJ4Jjuxmz1SZO79aWHDiba+N8OeeXQPgq0gMKK01EWwaAwKEXK6IWb6uJAytSKb05VMFsr
 f+a4OHAqiOkXQvdOC2v6MZqVgOW5mMNbhQyB3xLnn5ny5CD1t4ZPdktmWfVhKu+mkUIaMgrV2ab
 KoX35WNdFVNNwRJq2Lsg0MQuZPj1AGIon/EiWJonnleuaIdaNbOSPheoZFSQIgWv6sVO/wzm
X-Proofpoint-ORIG-GUID: RCmcoYMrZ8d3u4XVXTEk_1EQ71SqfTi1
X-Proofpoint-GUID: RCmcoYMrZ8d3u4XVXTEk_1EQ71SqfTi1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507310060



On 2025-07-31 02:42, Dmitry Baryshkov wrote:
> On Wed, Jul 30, 2025 at 02:28:25PM +0800, Yijie Yang wrote:
>>
>>
>> On 2025-07-29 18:37, Dmitry Baryshkov wrote:
>>> On Tue, Jul 29, 2025 at 09:32:00AM +0800, Yijie Yang wrote:
>>>> The HAMOA-IOT-EVK is an evaluation platform for IoT products, composed of
>>>> the Hamoa IoT SoM and a carrier board. Together, they form a complete
>>>> embedded system capable of booting to UART.
>>>>
>>>> This change enables and overlays the following peripherals on the carrier
>>>> board:
>>>> - UART
>>>> - On-board regulators
>>>> - USB Type-C mux
>>>> - Pinctrl
>>>> - Embedded USB (EUSB) repeaters
>>>> - NVMe
>>>> - pmic-glink
>>>> - USB DisplayPorts
>>>>
> 
> 
>>>> +	vreg_rtmr0_1p15: regulator-rtmr0-1p15 {
>>>
>>> Hmm, so there are regulators for the retimer, but they are not used.
>>> Could you please point out, why?
>>
>> According to the schematic, there is a regulator and a retimer (PS8830).
>> However, as mentioned above, the retimer is not connected to USB 0 and is
>> therefore not used in the EVK. As a result, the regulator is left unused in
>> this context.
> 
> What is connected to the retimer then?

All data lines are broken, except for some power lines.

> 
>>
>>>
>>>> +		compatible = "regulator-fixed";
>>>> +
> 
> [...]
> 
>>>> +
>>>> +	usb_1_ss0_sbu_default: usb-1-ss0-sbu-state {
>>>> +		mode-pins {
>>>> +			pins = "gpio166";
>>>> +			function = "gpio";
>>>> +			bias-disable;
>>>> +			drive-strength = <2>;
>>>> +			output-high;
>>>
>>> What does this pin do? It's not recommended to set GPIO values through
>>> pinctrl.
>>
>> It is used to switch data lines between USB Type-C orientation detection and
>> DisplayPort AUX channels.
> 
> I don't think I follow it here. Which data lines? Type-C orientation
> detection uses CC1 / CC2, DP AUX use SBU lines.

I made a mistake here — this pin switches between two data sources: one 
is DP AUX, and the other is a GPIO pair configured with the function 
usb0_sbrx/usb0_sbtx. Both data sources originate from the SoC and are 
routed to the USB0_SBU1 and USB0_SBU2 lines of the USB Type-C connector.

> 
>> When this GPIO is high, USB0 operates in
>> orientation detection mode.
> 
> What does this mean?

This means the switch will select the GPIO pair configured as 
usb0_sbrx/usb0_sbtx.

> 
>>
>>>
>>>> +		};
>>>> +
>>>> +		oe-n-pins {
>>>> +			pins = "gpio168";
>>>> +			function = "gpio";
>>>> +			bias-disable;
>>>> +			drive-strength = <2>;
>>>> +		};
>>>> +
>>>> +		sel-pins {
>>>> +			pins = "gpio167";
>>>> +			function = "gpio";
>>>> +			bias-disable;
>>>> +			drive-strength = <2>;
>>>> +		};
>>>> +	};
>>>> +
>>>> +	wcn_bt_en: wcn-bt-en-state {
>>>> +		pins = "gpio116";
>>>> +		function = "gpio";
>>>> +		drive-strength = <2>;
>>>> +		bias-disable;
>>>> +	};
>>>> +
>>>> +	wwan_sw_en: wwan-sw-en-state {
>>>> +		pins = "gpio221";
>>>> +		function = "gpio";
>>>> +		drive-strength = <4>;
>>>> +		bias-disable;
>>>> +	};
>>>> +
>>>> +	wcn_sw_en: wcn-sw-en-state {
>>>> +		pins = "gpio214";
>>>> +		function = "gpio";
>>>> +		drive-strength = <2>;
>>>> +		bias-disable;
>>>> +	};
>>>> +
>>>> +	wcn_usb_sw_n: wcn-usb-sw-n-state {
>>>
>>> What does this pin do? Using pinctrl to set GPIO values is not
>>> recommended AFAIR.
>>
>> This pin functions similarly to usb-1-ss0-sbu-state; it controls the data
>> switch between signals from the USB connector and WLAN data.
> 
> Could you please explain it? Does it toggle USB2 signals(you've added it
> to the USB2 PHY) being routed either to the USB connector or to the WiFi
> card? Or do you mean something else?

Yes, that's right. It routes signals between the USB connector and the 
M.2 Wi-Fi card.

> 
>>>> +&usb_2_hsphy {
>>>> +	phys = <&eusb5_repeater>;
>>>> +
>>>> +	pinctrl-0 = <&wcn_usb_sw_n>;
>>>> +	pinctrl-names = "default";
>>>> +};
>>>> +
>>>> +&usb_mp_hsphy0 {
>>>> +	phys = <&eusb6_repeater>;
>>>> +};
>>>> +
>>>> +&usb_mp_hsphy1 {
>>>> +	phys = <&eusb3_repeater>;
>>>> +};
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
>>>
>>
>> -- 
>> Best Regards,
>> Yijie
>>
> 

-- 
Best Regards,
Yijie


