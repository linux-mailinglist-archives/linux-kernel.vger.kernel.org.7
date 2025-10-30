Return-Path: <linux-kernel+bounces-877922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E1EC1F5B3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 91B2F34DA31
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016A93446A3;
	Thu, 30 Oct 2025 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c+q61kk0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fiOaS1Id"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E07343D9D
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817318; cv=none; b=oQdILCzAOiPN/AzmI5/QdIbF+E9exHH063TUySkMxltHItOsdcafv/YOVNSFw3424ZfL3XJu7stu9T9LB9CJI8u+rs5cTR917ZHD2EYla4SHETlg1NXYtKWADQ+ucQmCYvi/am+Ou4krFqi2hSndf68NDTClobCwkQ1pjamjRHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817318; c=relaxed/simple;
	bh=xxO2m+K4+X6ZywsuL0npJO5qkxo6MOVOHSO7y5HDfbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Myf1VYO72/RMF510SbuvlIHWYvJ6IWfxrGe8gwrnsRh2Y1j1kZfFyJnNi7QCh/sWMYqM6xmaMvMHqN4LiRzlhWq0+p7vrSS3cW9c7eOJHclWF8GbTXSh4BnOmb7x1WMpjroHBXBCjz3UShsr/oWxl5rwdKGZmGLN9W8YUcG3fts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c+q61kk0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fiOaS1Id; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U9WJ2H3117019
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bh/NrdqFUpU9wVwB3r8i3vqn0tl54Ze3lOlTg9aA8Wk=; b=c+q61kk0F0tX/xhN
	1d9JzSJos6pXN7B3bV+DMQOcjZAo0iU/Y677CvVXMm3CSbBgTXKaG9ls4ZMv0+uf
	249Sr0OHPR0ni0JKEl5YHKto7uqsc0cz2cb4rsLmEwIXVwBeDsjC5w07Iv5wXhWC
	V1C/BIyfKkeFr5kJg4kLFZ6Ygi/7zehL+ra4Tor+B3Xp9kF7bv8dZANY0IdrXTY7
	CWN0D+ZsIgJEWEsjagGwfaqvCjWWVWxycRX9/XfbJ8/KXNZFS2diNlX2x1uKvInD
	E7n1QUlPb2JAFRENAz8VQI1cmA2xYqQ9dIx9J3SxYZ0S93Ye4Df7M4epCEv8wew1
	NXZtvA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45frg17t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:41:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed0633c433so1948011cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761817315; x=1762422115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bh/NrdqFUpU9wVwB3r8i3vqn0tl54Ze3lOlTg9aA8Wk=;
        b=fiOaS1IdZRCiEmI0lDBzrClscpZuQZNe53xEjWSk1cQlIebrZ4UrsZoW7rQuvk0HuC
         FWDiT3prx5DZ8Emo0A1bhNlfy2rnjjE5ZYZBCGv/CJ2myzTBu72csLFqEmKtVUbElQUs
         W13uueWkNEtIxnAFbbgfDi5Uye1uuMu6qu21Ool+lscLrvvsKvxwCJ1DkIDMLYVhrpxw
         rzWIHzguxVF/1jzCqwg3YlaWUdjTTV8wTQXO9XqxIYnSrokKgL5ULbRBk5g5RfUIId7N
         cOjOGG1R1AHqIcJoPgw4G/sR/a6GwdnhPu1sxRwyQmLFmugI9Qbk4T2ZJ80rp9iwmHhc
         esbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761817315; x=1762422115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bh/NrdqFUpU9wVwB3r8i3vqn0tl54Ze3lOlTg9aA8Wk=;
        b=nIHMl9+AXf+5HYG4du74GHmWaOzzDOjB/5/HP+bezXJVRlBxargD0s9zkYDE6EsW3O
         2bexTpCygON/taap19kWjC4wyu7dNigh+fm9+O//vkvAVMzgvfBO9CG4oPlsYfZPCL8d
         2chibbi+I0vGvJCaQMUnzEpFF2w8t1i/3Vtvz6SLwMEykT5cezve3+bSGV87X1N+xwBn
         BwjuYXZtVH7GR8G352Sp6M3uhhR/yAGeTLu+sJsMAnO35pSEJevmYc6ywK9F/W2/eFwL
         RQRQDL+FB+IOrCy4unBt2aEL4yQpao1YiF7dI+TQHHjdoRinea4b/v4MZufoRPZcav6k
         myOw==
X-Forwarded-Encrypted: i=1; AJvYcCXo8bTYxxEMFS9OrYzMR5mqWeBUbUyy4smTNET4whgW7KH1JvQMhyU3lFo4a28saljGk5tW58TfsxOdrDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUJOEuXopQTkmcBfbyI3SjcnZD6N5vyt8aN4/ZpiXc+f6CiV+G
	frkvU1av8Ap5fF3N3JC++tHwGHwxciOwGZtTMRgzKuBMo+C4eIY9TdUWXMWae6+EjEBJPngDHzi
	/m5YNU8jzOxg150fWTzOF3vKE+23/aBCyv+FFd6xBK4dAbOTbr1uTBfQFegyCp8YV1uo=
X-Gm-Gg: ASbGncsqMXHXSj3bG1EXyuBjYGWGh+8MnZiOw2Q4K4OlEuVnEeAQ1Vap72ct2eQtjEj
	/he1EeUkNtxK99n+JHe5CNSC9c/h62+5LvJWPNGEvLLSCW42bwNNJ9h2ZrlEr8eD7HkpFPstzXn
	F/CPmXNHfk4XzG2s4n2p6GuwvZR+pJlCMsqhUBdpMIITW3iTnsBzrOfOKeThR1d5yAwq5N/HAjq
	hEQwF5h+jIhAISUoUuuWBSZVtRl2qbt2+aE6ZiXvl249bTNY2IjSzXEBYbeOnrosPabFvfhW+dy
	1SSHj4bUrS5p1F43es7dJYRWTeRW4hmlXRbbbq2ibZD3/SBwdXfVGETEYNd/hZEjVwFDPGZPNZc
	5yp05fQ+Mw15B7Vte2MWeeO15dMEU2c7YdBjFp3obl1QSnepR3p969vBm
X-Received: by 2002:ac8:5d44:0:b0:4ec:f9c2:c200 with SMTP id d75a77b69052e-4ed15c4618bmr51538131cf.11.1761817314919;
        Thu, 30 Oct 2025 02:41:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPSY2Bg5pdYdfgMg5cODIfPC2xkNzl0pPizTea4lv1QOx7SeLeYOM+cfOYw/kdroIHDn+x6g==
X-Received: by 2002:ac8:5d44:0:b0:4ec:f9c2:c200 with SMTP id d75a77b69052e-4ed15c4618bmr51537991cf.11.1761817314386;
        Thu, 30 Oct 2025 02:41:54 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85308cb0sm1743866166b.9.2025.10.30.02.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 02:41:53 -0700 (PDT)
Message-ID: <8caa1cec-d881-4e77-8d77-be043f8d13d6@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 10:41:51 +0100
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <0cf2521b-8d05-42f0-aab8-35cd370e599e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KupAGGWN c=1 sm=1 tr=0 ts=690332e3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=gZJ2WMP_fuF1vj9OyeAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: mhAbO71xEFgJWq3XRRD62-9yJLIL_z2r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA3NyBTYWx0ZWRfXxnU+OVv567lZ
 CbwJ0B+EyCBQDVTvkj0pA8p0ZbmAEgqTItwvINsh5yyGqcDhzhlFo1IxGeqgSGv4TtgLstqXSFL
 M43Vj66hsd1UJ/pIQWSi47WGX50Lker16DI06/ioonCpmdW3RoOuu3rh4lwp8JtTtdH0vM7neJK
 ReiVb3q0TIBNeXtTM01DWu08SffnyO/QMlodukfwxuKg0c+ovJM3MZFMTlbifRIgRK8CKvdKte4
 qQjoIIi4MvusmKZSU4NqTFEH7q0BbzyfQZTt+igRnjc8x/OFO2dqTmMGkBq+ZqAdexYA+SrcS0S
 jG4EB/fKI7Q0fZn+SeBtTWme7nR1asiUbOVREDwFyJzll8IwqumflzVXP/KwoSQ/S7TQgDyH3Q/
 YNb+577/QQ3B1lyLZETTkRNDZaQebQ==
X-Proofpoint-GUID: mhAbO71xEFgJWq3XRRD62-9yJLIL_z2r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300077

On 10/30/25 10:08 AM, Yongxing Mou wrote:
> 
> 
> On 10/28/2025 5:08 PM, Konrad Dybcio wrote:
>> On 10/28/25 8:04 AM, Yongxing Mou wrote:
>>> Previously, the eDP panel backlight was enabled via UEFI. Added backlight
>>> control node in kernel DTS due to some meta may not enable the backlight.
>>>
>>> Aligned with other x1e80100-based platforms: the PWM signal is controlled
>>> by PMK8550, and the backlight enable signal is handled by PMC8380.
>>>
>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>> ---
>>
>> The subject must say "hamoa-iot-evk:"
> Thanks and got it , will fix it in next version.>> arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 55 ++++++++++++++++++++++++++++++
>>>   1 file changed, 55 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>>> index 36dd6599402b4650b7f8ad2c0cd22212116a25fe..fda1b3a3c7673be74832c27849231cba4bc1f25f 100644
>>> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>>> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>>> @@ -17,6 +17,16 @@ aliases {
>>>           serial1 = &uart14;
>>>       };
>>>   +    backlight: backlight {
>>> +        compatible = "pwm-backlight";
>>> +        pwms = <&pmk8550_pwm 0 5000000>;
>>
>> Try adjusting the backlight value.. you'll find some funny behavior
>> near the max level.. which reminds me I should send some fixes for
>> some laptop DTs
>>
>  I tried sliding the backlight between the maximum and minimum values. It seems that at a certain sliding speed, when approaching the maximum value, there is some brightness flickering. Is this the phenomenon you’re referring to?> [...]

"maybe" - for me it was the brightness actually going down beyond ~80%

The issue is that the PWM hardware can't really do a period that's
== 5000000 ns

But it seems like this is no longer an issue since the driver now
rounds up to the closest supported value, see last couple commits
to drivers/leds/rgb/leds-qcom-lpg.c

Konrad

