Return-Path: <linux-kernel+bounces-877849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5533DC1F30E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 044044E84F0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A921B33FE0F;
	Thu, 30 Oct 2025 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JocMXsx1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gTT95cfO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E512EE5F4
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815316; cv=none; b=MYbtSC9ilC0X9Spa3Y1KJoXE23TuaJ3+IFi4wuEygpI+0BL0EsD9u8CtEcjk4Gc5jfjd8bMAjJuDK8XTm6W2YDQPB+cBveg1pch9RHkYcM67s2z5gLmnjmJGqf3qIxAaVnpe9ZgqYybdIEWYNwi4vN9KDAl0PZNQxyzP+1wGGkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815316; c=relaxed/simple;
	bh=ZbUSH8YEtVpK+SB1ksdbnsza3iM7iPgVjadp9NMUzMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bf7kmCrz66vXLpVSFCJPnkHGm3pykdJNr7KADunuQO/bKYdwgzrOpIDCIFwVeoum4NQFk+FqmJiHbi7z8qhYKdH6vxsQcrJgdZo5NT1xzokkvxc43AMTwREQ17FIeRb9i3uJIplqduMrlhmhPdQ5FzRtqYXLGbmA8p3XS+nNKUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JocMXsx1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gTT95cfO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U5u7XC1324771
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XfUwVbPs51AL4l2LdxpZRB9YbMrAh0PTO+r90p+nVoE=; b=JocMXsx1Mnl2mZuo
	IEnYdS5aSXbBRlPSRX6Ne+0uvSEfhF6k0OWSJKZA14XD9b/j02RQ4wT25ugmSUj0
	7aoxyGrQUFxxgv6iA0mfY1OX/c+20/wRjJFq3vtBs2fNqOhdj0LaJhry757tB+mL
	9Gdfk7nqHYDWQKvGGFGZ+2/pSUNpZLIq6l/UCUfkmh3+2iPEHc28ljWoc/RlakwL
	T2DklDuNCUNhOaSZ3kHWuA7eggdgk19qBmVFwi2v91VC4jxGcvMfO+ZR4t5tgskb
	VzfRT69lNaS08mDEOU5F8djDjZZBkr9/0yh+uv1bCKmm7mOl+SQrINwJSD9sQeMg
	/P/nOw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3rkut5v1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:08:34 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso636224a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761815313; x=1762420113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XfUwVbPs51AL4l2LdxpZRB9YbMrAh0PTO+r90p+nVoE=;
        b=gTT95cfOi1G8r0d6VE/LK8QU0iRmiWUS1UwOwMowuzXmzaofCKvX0IXGj0Bf2Vj+8D
         Y+ihRugemqIpDeqTuzxbQvfQAHjFoBWtsBfIg7XG+GLKoWQ+TmGBYL5GybaYGcCIX+mC
         UqSf1PyUR+mGT1oEr6NHi/GQgu7Vtsk7YA1ZYKr11RxQtlECWYU0Fxfh+gYzQutjCmQF
         m25FmpJDqb92VKfGBeRX7tY/bQmMVPbkzF5fg4QLFLe8TL8vKoO70d+TXR3eZwCd7Yjl
         mrzDRfZXwLXNakxe82CEexIx4HEsOEMQzEdxR4vw9+ebGBoa3pjKWxoFq9ZQrfXYvDDI
         Le2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761815313; x=1762420113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XfUwVbPs51AL4l2LdxpZRB9YbMrAh0PTO+r90p+nVoE=;
        b=GHZjQmr/ndz1ZTkWW1gz3wWNqUnQD86/7oognfZjwxeqQVsKPFobIcHHskf0+ioJus
         jW1aqV9xIU7l48D82eNkuplYPYXbE5OYQtAUH5X0v+8GwV0akJLQM4soKrEoZNIPdWcV
         KAyq6Iu+12EAcuV2lhNdG36CRPZxz9tg546UJTTMUA3xD0T5ZjVm0nBn3DQ1gdRfKsgY
         gEdzQx1LVlsgjoq6gPe/exc7sPg/FgzeocTiXnJHWrONc/DnUEFgFy9Koj2jbLi9Ze/z
         9fmOz5U1N1hcrPWBF5Hv/gcFli5QEdrNMOc6RAujhtJjoGPTGGo+cd01HZDirTWwAiaw
         VRaA==
X-Forwarded-Encrypted: i=1; AJvYcCXdjLDudNo5OdrtvKpzU/6J2IiORAOW6AdbTZe1KgR4ULj2xIa5VgtrMyOhHmn/guSK8SIGFr/ETmg9PdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ8HzOqKO9flkm+G/UsL2ZULokTbBAOG1r+DlYF9LX/AHULfuP
	UVc37V1kpQrz6zN84Awp3y/sB66CtEVYP18lFPOeSiaND9V+g9RbSorr58gYluQm+D2nCPC4y6y
	Vn4hHGOXRFTe0+kdyAV9Xo6KkkqQOROFra5nwS8Eig3iKQ4KGur/rkv9oJaxslINGjzg=
X-Gm-Gg: ASbGnct+J/pl51ZMcGjUdY38J1i9Z0JwOVSkgSis//W98kJSZvsLAkTbDhRvEAHPTq9
	2ToOWHniNMUtXYfHUVmp7JS2xTIbwr13ZvdL4Hus+m2lYoEplrIRuWFCQXLAZK79ik7tSgoT+tn
	gnQ5BPHFyAjcWH68dhw06fsCVnoV3vQtmltORruX50KcG8G64E5S8Y8wIYoabhC17zwoRZLeePq
	YL8yr+6YEpxFUrxL77MHESC1+JMjnRYN/cL+qrxgzng5bVUYhlUIIJBPNRBXdmgxzxpi7advdHn
	cZbnMGz8WdmXJCjBWiWyMVLCQtdrYQrkxvK98yD7ITmmIu05qYZtuyZOPuyh/g5Bd9xYmbe2cgb
	ctId7aXj8E9IX6oL6bNxpZDaY/L+hU7zzuE8llBqisK8uDB53xiBAnq6D2KEdro2c8OxlPw==
X-Received: by 2002:a17:902:db07:b0:264:befb:829c with SMTP id d9443c01a7336-294dedf483bmr67053225ad.9.1761815313030;
        Thu, 30 Oct 2025 02:08:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu3xXjROAG0AbuxZKF8uMAd203m14ukKjCiRnjsSl7vJd3tLAM/xmr4opVRmTBwC3GqV5ybQ==
X-Received: by 2002:a17:902:db07:b0:264:befb:829c with SMTP id d9443c01a7336-294dedf483bmr67052785ad.9.1761815312406;
        Thu, 30 Oct 2025 02:08:32 -0700 (PDT)
Received: from [10.133.33.50] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0967fsm177213595ad.26.2025.10.30.02.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 02:08:32 -0700 (PDT)
Message-ID: <0cf2521b-8d05-42f0-aab8-35cd370e599e@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 17:08:25 +0800
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
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <b5d9d47b-7fb2-4ce4-9bc8-0d28395b78db@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: J9p3gA86iUbZ8qoFoNDipitfo75TP6mO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA3NCBTYWx0ZWRfX2/SJ+dZXXeDM
 lUA1AZsPuW/D6ewrni/z9ltVKwcmuFcmszJFc0n+kbAylmq4MxnMMtbVKH+XBfylgxZlpHIm47H
 UjG1UGVSbhPm3INS9rr0j/vDAAQsCs2PGA6wbec/FT9WfidFsc4si6RoRdR+MO6ohCyv/SB/hv9
 iPYdB947Jcx+Si54FD2AQT98q9PkZnHTY1e1l6tei514agrP1xsKGMBEFoAOe4ikr/JgN116HoW
 ksu5lsTQv2Ww2rHQd1F3GgGE1oOH01ByzHrBarcMQ1p/8mijzQ8BKBJ0SbP0buuv6eSbYXn1GAM
 puOTnz93BjTep9bjaqZMSVdbH86Ewoo71oWuCeKFXccpkyZE2Jgca8W9vOncoT25taY2xwX6V2o
 7XP1TfZLFk9VXdpqsjUU3AqmvRqSfg==
X-Proofpoint-GUID: J9p3gA86iUbZ8qoFoNDipitfo75TP6mO
X-Authority-Analysis: v=2.4 cv=adZsXBot c=1 sm=1 tr=0 ts=69032b12 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=81pMHEbCwSLrc7DcvnsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300074



On 10/28/2025 5:08 PM, Konrad Dybcio wrote:
> On 10/28/25 8:04 AM, Yongxing Mou wrote:
>> Previously, the eDP panel backlight was enabled via UEFI. Added backlight
>> control node in kernel DTS due to some meta may not enable the backlight.
>>
>> Aligned with other x1e80100-based platforms: the PWM signal is controlled
>> by PMK8550, and the backlight enable signal is handled by PMC8380.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
> 
> The subject must say "hamoa-iot-evk:"
Thanks and got it , will fix it in next version.>> 
arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 55 
++++++++++++++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>> index 36dd6599402b4650b7f8ad2c0cd22212116a25fe..fda1b3a3c7673be74832c27849231cba4bc1f25f 100644
>> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>> @@ -17,6 +17,16 @@ aliases {
>>   		serial1 = &uart14;
>>   	};
>>   
>> +	backlight: backlight {
>> +		compatible = "pwm-backlight";
>> +		pwms = <&pmk8550_pwm 0 5000000>;
> 
> Try adjusting the backlight value.. you'll find some funny behavior
> near the max level.. which reminds me I should send some fixes for
> some laptop DTs
> 
  I tried sliding the backlight between the maximum and minimum values. 
It seems that at a certain sliding speed, when approaching the maximum 
value, there is some brightness flickering. Is this the phenomenon 
you’re referring to?> [...]
> 
>> +	vreg_edp_bl: regulator-edp-bl {
>> +		compatible = "regulator-fixed";
>> +
>> +		regulator-name = "VBL9";
>> +		regulator-min-microvolt = <3600000>;
>> +		regulator-max-microvolt = <3600000>;
>> +
>> +		gpio = <&pmc8380_3_gpios 10 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&edp_bl_reg_en>;
> 
> property-n
> property-names
> 
> in this order, please
> 
> KonradThanks and got it ,will fix it in next version.


