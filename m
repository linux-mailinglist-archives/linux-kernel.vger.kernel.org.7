Return-Path: <linux-kernel+bounces-846546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6220FBC84F8
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7CE0E3497F7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10082D2397;
	Thu,  9 Oct 2025 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TR8wKMrg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C35E2D061A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760002208; cv=none; b=lByz4qs4Mi6pbPEMe8stqBCNX4ABDEiXdugXNjYwcpTSn3aI+Fgu/s/sKA5h7JDgw0nCKNPTncyl5DeoN1/brdTnCKD3fAfgC+Jb2Q9Gq6Ud7SDjdHu77KbHTwkIbOH1fpXynw2ifoi1QrDJura0WTWooIghczpSzKuXq3g+vf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760002208; c=relaxed/simple;
	bh=el0ASqmaTvmfPJXD4hKNf4F8hGWxKWMWrZAUEtGEOAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OoCJOT/KjO+/f0j4K7PlhDdv+uDp2iRZEXAruNbYGmjD2KoUVM8bFR3F4XUumiQtjSYOiHMz8POyOwC4g4JLtu08BTmGADSuwpez5VJpjRR2hpDUBO3bpt5p2HUu4BtLPojkX6AyTGpKUhvruPkLxWwOyHhJFmXECkPyMPcxVww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TR8wKMrg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EHIO004912
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 09:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Q2RvLUP1TRoeCdEklVO8kA/8Vk/VvKeXscAp6CMzmk=; b=TR8wKMrg4tr+wdgQ
	6VYKTMn3aFA064VFzGRZIE+jkvygmm9+Cfbvw5MvYzvVS3al5MoMT2JIDSSMPPTc
	vHIWZhMZNLo2aPIl2HnPoYm7fRW+GVrAvs6qIm48a9ewfI8GSqI/Az7SDkqLmqoL
	f4EgWIsAcBugFvRw3M4ei7Ip0xoRBtblDpIYAZxAPGJh9omh81Xs6Qj6zlFmMpv5
	sSKXtNSe25a4jVdYvA4DUUY0nWPQ/oojXaCLKrcVAfieZt0c3h6r6ba3wsunmnIb
	WGkosrqj9D3XQD5JMwxLyyAOjOQi48B2J/wYXYG0TNc2VRyJmmfUCWlJ9h0fJ2PI
	HA9x9A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4u28cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:30:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ddf2a2d95fso2760961cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760002205; x=1760607005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Q2RvLUP1TRoeCdEklVO8kA/8Vk/VvKeXscAp6CMzmk=;
        b=hcc+6zDroe4gVHCGbQ8XHv16DaA7WUCM3HTrDNTLnBrV+pCPAwvd8mArW8rQ+pSdGH
         YkAa7faNpDrtjCi4I4nyXdlvBC61MSpc0b5ro6xL/0vB1PBj1+7+T1verXyjeY+qbZ7u
         tBFByXHDnznn8htwYL1nZoYD/QzQdvcNo60NB2nd28gI2jLUx6ArzvE6L8FTTcok0djY
         /2ncfUYONHCRwsiRAaIJ5tcLeqk4M44psA4G4C9vWU9Op/sUeb2nxiZijWhyiLaIc731
         XryZKauCNiPyzNJDBwnBmgQhyTutWuaWT07YCOWFWdu/NRfggHAUJHZvigZRfZdcSvXW
         Ekpw==
X-Forwarded-Encrypted: i=1; AJvYcCVplQfqbughHXYn/5hFLk48Ek3yzpmpA+b4dk7u+5qPz8ln4cPQsKSN+bkgeP1f/B+EGy6dnlDamLJ9Kbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz/pioLGEcs2ntVMGl2uFZLvu06LPDAukjC9UjtDP6MZ9nQA2J
	XrFduIRwRjgNgl4qZOwe9kl1JDfLspad+FLT+Pw4EQ4Ap1kfdisVS2zeTslYBMBVDGZMxejYqBv
	R0slQNq3a3QVP+t1DkEn/RjsDG+1eBvVR6X0XqqV0NQOfn2ncgTVfhpcGwldqPwm/OU0=
X-Gm-Gg: ASbGncsmY8AysJ4mwSmdogyimRduPHbO/5GHUGL2aPMY7mvycmfp9il3eUqESP7fPxt
	bG4/BqJckV9zE8Xe5WtYHJ/vyGjWlAYn2w3ujbWY543YEPk19ifd02XcmfB0SCkyWVnfPGo7fpm
	if4TpLDG5pMzI9JgE3w7gh3GI4YsLc3Ct+v1ihLnsmFzSqAG3uNof4d3GkeLwBfbHpSKcW5W0wi
	EBVEY/zKUNMNLMuqNvLq6TDtrlY+OCbUfORLfcpyjLtBqigMMX7EH8LTmXJj9C4Y67nR4S5T76g
	v6/qL1odo5WExsKuIEpJzzzy7aGKqmHwuEFzEuth6xs/fTRcjIz2GBExezRTsfRbIIHIOsI0uKw
	RNcpCVJ6373dlwewv6nJi4wbqE8g=
X-Received: by 2002:ac8:5847:0:b0:4d2:c24f:8495 with SMTP id d75a77b69052e-4e6ead5a000mr58399581cf.10.1760002204751;
        Thu, 09 Oct 2025 02:30:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFr0wEaBL2XbLULBN8fCQQoMulUdbLu/EIkIvWun7NFXx/+YOoZKhrRMhgISJJafb8hTw0mg==
X-Received: by 2002:ac8:5847:0:b0:4d2:c24f:8495 with SMTP id d75a77b69052e-4e6ead5a000mr58399341cf.10.1760002204261;
        Thu, 09 Oct 2025 02:30:04 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9ffbsm1838680266b.10.2025.10.09.02.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 02:30:03 -0700 (PDT)
Message-ID: <84d7ab07-4026-4313-8919-b5f9205132c6@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 11:30:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ARM: dts: qcom: msm8974pro-htc-m8: add touchscreen
To: Alexandre Messier <alex@me.ssier.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Luca Weiss <luca@lucaweiss.eu>, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251007-m8-dts-additions-v1-0-53d7ab3594e7@me.ssier.org>
 <20251007-m8-dts-additions-v1-4-53d7ab3594e7@me.ssier.org>
 <5a9a2ed9-9e95-4bb0-b5b9-e4e0edcfa8d8@oss.qualcomm.com>
 <1d60b78e-136f-4051-8296-245d111ca49f@me.ssier.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <1d60b78e-136f-4051-8296-245d111ca49f@me.ssier.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vrcuwu2n c=1 sm=1 tr=0 ts=68e7809e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=8poMKPHdAAAA:8 a=nTsu3JDRWy1omu5sJsEA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=fyZPtLC9JlAwSkJ5-iUD:22
X-Proofpoint-GUID: 0_LHLyGQKJzjw6AfwGpmSirk68Xthprz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX7FdTUSm6QAZ8
 AN8Do1gZThgyAA1baIkyme0SVdeq5jxWYPYr5yniqzhRLAS1tTZ1XcGnkK4hns5DJyStSUr8Z/2
 tR+lUG88n7qo8QSm7Z3rGzjFaSkMf3dAHvZ2+PACxrvFDsBMff1cf8qwuLGYJcJiMp4aWU/HWO0
 QdXB+ncZVNBHH9A0W0kzgGmRllz4hFj6GbGEn45DEPz0Qs55kXeBBsplZDe4DZ0MyFcu+mEIOmu
 osdnv6ESdd0weBLvkI415qtVCSblvAWvVI5hmdox/OKptsIF/T3vWBuzeo4psn7W819O1LzCmVL
 mzqC7bw/QlfVugACULg7e1u7MNnno5Fuprnrb6aGXEGLSK1B8zCfVLQSdv4YKsgd5WX+GetEtVm
 fFDyqrjqJr5kIdeAyb3NCZcST7Ld/w==
X-Proofpoint-ORIG-GUID: 0_LHLyGQKJzjw6AfwGpmSirk68Xthprz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/9/25 7:50 AM, Alexandre Messier wrote:
> On 2025-10-07 06:04, Konrad Dybcio wrote:
>> On 10/7/25 7:55 AM, Alexandre Messier via B4 Relay wrote:
>>> From: Alexandre Messier <alex@me.ssier.org>
>>>
>>> Add the touchscreen device node for the HTC One (M8).
>>>
>>> Signed-off-by: Alexandre Messier <alex@me.ssier.org>
>>> ---
>>>  arch/arm/boot/dts/qcom/qcom-msm8974pro-htc-m8.dts | 36 +++++++++++++++++++++++
>>>  1 file changed, 36 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-htc-m8.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-htc-m8.dts
>>> index 36eb42f0f3d9..040a256f9465 100644
>>> --- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-htc-m8.dts
>>> +++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-htc-m8.dts
>>> @@ -65,6 +65,35 @@ vreg_vph_pwr: vreg-vph-pwr {
>>>  	};
>>>  };
>>>  
>>> +&blsp1_i2c2 {
>>> +	clock-frequency = <384000>;
>>
>> This is not a valid I2C frequency
>>
>> You're looking for 100/400/1000 kHz
> 
> Hello Konrad,
> 
> This frequency value is used in the vendor kernel [1], hence why I used it.
> 
> I did a test at 400 kHz, and the I2C devices (touchscreen here, and NFC in the
> other patch) are still detected, with basic functions still working.
> 
> Let me know if I should still update to use 400 kHz. I would prefer to keep
> the value from the vendor kernel (and in that case, I will update the commit
> message to add that information).

Hm, I grepped around in old vendor trees, and it seems like there was
a period of horrid wild west wrt this..

I see 355 kHz, 384 kHz, next to "normal" values of 100/400..

Let's just keep it as-is, but please note in the commit message that this
is intended and that's what the downstream sets too

Konrad

