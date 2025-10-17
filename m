Return-Path: <linux-kernel+bounces-857778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF70BE7EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40A8119C5FCD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794542D661D;
	Fri, 17 Oct 2025 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eWC4xYmJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1012641FB
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695075; cv=none; b=fsK7oJJ6bH5dd7AgCwYIz7WZCwbbFjqcBHncqKwFgfKRA2MSJ4PHGdnlmGJtAhe9sohkD2ZzKUc369Ik/qfmMYugw+FcU/NFPSomHEHCWQrXBDrb+qsAEFZOlvTm1EPoB0O4luzFtT0Um+oDPMFEWG/EW8A6xzrpfy3tHlhr4Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695075; c=relaxed/simple;
	bh=79n+Qc5yBix+U3wmFnS6g8a/6+I1OaBQNl/w9qZHo+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=If1UO+SZJVsnaevEILFyIhTXWOn+2HlUzVmc6zbEt20oDb6aPZGjXN5afK3ZgRA1w0Y2tY/Kh5uegKgZ5jQjEBoZ9iyIOTOaaX0vwhyx/CFKh91AUaicmp+ksy5tGbA5rGxYNSqa8yLK+zGG2OCZTb7T2xqFc/NUdYeoZquqZFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eWC4xYmJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8I5vF002515
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZIs6t3bvk1JRGW3dHYxMA/phlwEXTSoBjQ3c0yvwb9U=; b=eWC4xYmJNDSDSXpD
	oLv9F3SyfQXF43GJxe9B4XT19cWMzUJLWOuV69V+TTnNlRUuIBmdrGnvuQaejN7W
	jxgm5gQBM12gFJAKBHCrCPPTj3l3WckIEMYeUpGbTUYQKug6AQsqlNF2A4QM8FPK
	gHSA52Cb9lEtnT52KMgHa9ERYWazEon3O4M/OudfvHj+cD72OBphNbekX/KqoFNR
	QDvjGk498O0zkLvunJZfXZvNWzmLeP0X2ldyygaesGjMt93xoUgiUAa7iK4vRSNV
	13xEsjFb9ojoaYdONuhW7j+Gw08XPOv2T08B0YaY2UcY2SsMCabVIAGXOToTLkLM
	42fA8A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa8kt1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:57:52 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c262c72b5so1141426d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760695072; x=1761299872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIs6t3bvk1JRGW3dHYxMA/phlwEXTSoBjQ3c0yvwb9U=;
        b=H5NP37LnVCwH6503acPwfZKr20v4agBMf4vTdYNv2EiYxn4zAtnuv3A5mVrHy5MjrP
         I9QzmzuvSAL2wuBKiNcNV60n7it92bg5kKm3U2f/ugcSTsNj9UVAc31ZLtfJthqIBToG
         /JlJ1TlVEZ69CEnQfG5PX5jH+6bm02Etoj5eEv/t7yJFUj42cY9jvxE+JZBS2PA1Ux1d
         yV7IQaHueEXlkZ8n000LFnYNVP/qRlnRrrWWRosMFBn7fowH0Zjb9/EGB+mKh3y1I4EZ
         tmfsl/a/l4fRRz9dUCvSTDgVjjU/93uxjjFPDQjf1hkvU5lP6uQX3XGU+2BWirOaKAgm
         VDCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+8wsyHeeVZnRlgt2WANfDBm0XotDbGkqjs9cyJLhEgcURVsUK92O16K2dQe5M6G7ILyWu1G10m7ZLNGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzofI00SEbTJWNaDtemfhILbbs6JI3Vi6CNS3pyoYs8sxldjYtJ
	wfUe60vMvcGxgcWBZ6GU2icSnsMwzINgzz1uPG+WZY9hRmjTQNFERYvTo0DrSLGV8ByfQahq+vz
	+FB2mi1cF/Ai7HzxS29O0n3iVZ855G/7W5Nr7X2TDz9oyWuGE1U60r7MBCCkZSvR535Y=
X-Gm-Gg: ASbGncsH430ZMYOW9rxKVN2MIhI8X6m7EpHPoqX0h90ozHm9+9u/XZeOuDkEgJmlm1f
	i9fIgRVGruTNkG6d5zQShzjtNNje222NBspi52MlRDKuIeWdV45h8y0tsV6yR2KjCpSFqrFrTI9
	9QtsviVXyCoPIMe16/mDA3UH1Dl6KdIhXxPc41EOOp8/KZBXgzaiIAHp/RoMQzMf6bjAue6N4I+
	IvoEeFsXvlWFFWeXIkjiHRBvpl5gdKB09qhkiAUsykXAdbVf7LFZEvTkexvStWF3plNCGWs259b
	/EHAb9vBtze8kaSeWAvWyL2OELPIu4kJ7Yr0TYY9xuAhvab/YMnuaMNg/EXn5aOctNNFCDb0DKH
	+prBqtywdtZaCkz9qUwj8NzLbFWjiFOJ00SKYvzBQsKX08YSXrb5oTg7j
X-Received: by 2002:a05:6214:5093:b0:794:3dd3:a98f with SMTP id 6a1803df08f44-87c20554074mr28562636d6.1.1760695071633;
        Fri, 17 Oct 2025 02:57:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+uuhZ2faNWvGjsfla4IBwM8DyZoVgJS2ll2X9Y+bS8GMrP2glkecYidQ6wG3U6fUy/3KYNw==
X-Received: by 2002:a05:6214:5093:b0:794:3dd3:a98f with SMTP id 6a1803df08f44-87c20554074mr28562496d6.1.1760695071129;
        Fri, 17 Oct 2025 02:57:51 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63b6b1f5b24sm16496480a12.20.2025.10.17.02.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 02:57:50 -0700 (PDT)
Message-ID: <8fd387f5-5b4c-48ea-aa3e-f453ddd5b159@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 11:57:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-shift-axolotl: fix touchscreen
 properties
To: Joel Selvaraj <foss@joelselvaraj.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250919-shift-axolotl-fix-touchscreen-dts-v1-1-60e26ad4e038@joelselvaraj.com>
 <8a5eecdd-d80f-4955-8ab7-cf6fd991a3b7@oss.qualcomm.com>
 <267eb29d-b506-43df-9380-3d79798c772c@joelselvaraj.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <267eb29d-b506-43df-9380-3d79798c772c@joelselvaraj.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UbZI4DgNGkd6i4NSOUv87tVPG06xn_fm
X-Proofpoint-ORIG-GUID: UbZI4DgNGkd6i4NSOUv87tVPG06xn_fm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX9PXmkR001GCi
 eNsBK3K2NorW0pgg5aRD0KO9kV7ffTdiOq9XmvqvwyvanRFWdpRO48DtRXWkPYASevd4CSznmH7
 5f6+vI8k3AEHBiehK1D59MihEZSyVaDPNQhMOIdUoWwjVs395bL2M0XTyJuqt2HISGhU9q3e5eZ
 tv2qqn2T2wXpvPgMXmdm6NpIm4KL9mhOg7qMR/e1NrbneM11w6W7C0pELO9XYAPp+5uPYkqSXEB
 cufQekcplc5+5SAIhBGWaLUbByevOdnHJRbcNYyA/f/62rO0kMlNcGCqnOLJe/O9oceyLU8ZNHJ
 PK4VbYqo/RJMQLLqCnCjkeHTlDzYFf82c+FDYQaqCIEuFYTsfnG/8bsIgNgQUJXBo4FRs1GEcvr
 NeLFaD6z6DT9hWs867/K7SKUlPcBtw==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68f21320 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=WFa1dZBpAAAA:8 a=PdSRdi2-gu5LpHnKsfMA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=MZguhEFr_PtxzKXayD1K:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

On 10/17/25 9:13 AM, Joel Selvaraj wrote:
> Hi Konrad Dybcio,
> 
> On 10/6/25 9:49 AM, Konrad Dybcio wrote:
>> On 9/19/25 11:02 AM, Joel Selvaraj via B4 Relay wrote:
>>> From: Joel Selvaraj <foss@joelselvaraj.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 17 ++++++++---------
>>>   1 file changed, 8 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
>>> index 89260fce6513937224f76a94e1833a5a8d59faa4..d4062844234e33b0d501bcb7d0b6d5386c822937 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
>>> @@ -434,20 +434,19 @@ &i2c5 {
>>>   	status = "okay";
>>>
>>>   	touchscreen@38 {
>>> -		compatible = "focaltech,fts8719";
>>> +		compatible = "focaltech,ft5452";
>>>   		reg = <0x38>;
>>> -		wakeup-source;
>>
>> All the changes look good given your commit message, but you dropped
>> this wakeup-source property without explanation. It's fine to do so
>> if it's intended, but please mention it if so
> 
> In reference to the touchscreen/edt-ft5x06.c driver which is used here, 
> I am bit confused how wakeup-source works. Does specifying wakeup-source 
> in dts automatically makes "device_may_wakeup(dev)" return true, even if 
> device_init_wakeup is NOT configured in the driver? I noticed some 
> drivers do:
> 
> device_init_wakeup(dev,device_property_read_bool(dev, "wakeup-source"));
> 
> but the edt-ft5x06 driver doesnt do the init, but directly checks for 
> may_wakeup in suspend/resume.
> 
> Few scenarios based on the driver code and my understanding:
> 1. if device_may_wakeup will return true when wakeup-source is 
> specified, I probably want to just remove it, because irq and regulator 
> is not disabled during suspend and this will likely cause power drain.

I think this may be the case

> 2. The driver has an option to specify wake-gpio. In which case, the 
> touchscreen is put in some low power hibernate mode with irq and 
> regulators still enabled. But the touchscreen controller used in this 
> device doesn't seem to have support for a wake-gpio (atleast based on 
> downstream code). So that is not an option.

IIRC Shift was pretty open about development collaboration.. maybe you
could reach out to them to confirm on schematics that the GPIO is
absent?

> 3. if device_may_wakeup will always return false since 
> device_init_wakeup is not configured and since no wake-gpio is 
> available, the irq and regulators will be disabled during suspend. 
> Therefore, the device will not wake up from sleep even if wakeup-source 
> is specified as the irq is not going to be triggered.
> 
> So probably no point in specifying wakeup-source either way I think? But 
> I am not sure which of these explanation is correct and thus not sure 
> what to mention in the v2 patch commit message. Also, there is a 
> possibility I am not understanding something. A little help from someone 
> will be very nice and sorry if I am obviously missing something.

I think this is intended for things like double-tap-to-wake, which
obviously need some hw backing if you don't want to just keep the
touchscreen online at "full power" 24/7

Konrad

