Return-Path: <linux-kernel+bounces-897837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11156C53B4D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C9CA344181
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC7534676E;
	Wed, 12 Nov 2025 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UXw3yd9c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eiU9JIau"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8F020A5E5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968720; cv=none; b=qajplQprc4vIiGGNajcAhMLgUyRYYgDA57IrrArmP2Yq/lpLjkg4EPrLfWnm+8Vg/I7YxUP1wVCyC3yZ9o3CKGSjv+jKUcHvNjSEbXvQOj6yMdGLhf9qzQpve+BKsmbEdbWs+JDuRfZDbBoqM0dvyq4Rpf5skbYHPxW8kwMXigY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968720; c=relaxed/simple;
	bh=hzVZxAQsYGT+Jc1xNwFigB8FYEOlInLVTTrbWelcrKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cRrlVkvYIIA+U9MXQ9r9Urr3IXM6C5gPuxg4ixe5gQc8ceLEZaJ5faAEMKPGLxrZBKofTBZ0nlov5mcl6RI5wGlXjV8k0OMHtbk35Y2WY+zfG4fuhQ93SWP2a8OJ7qhJjI9/2u/PbLiq5Zfrm0QkIsWaK0Oy+ZXw9IXo/lpAFnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UXw3yd9c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eiU9JIau; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACEJ6vj1382152
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oRq7N9zEd4E6O7kii0K2QODDGUwp+okVrUJjhuRm9ts=; b=UXw3yd9c0V+CqXAv
	Qe9i4LF/MLsW60UiDZBzcgtoCOTc/ZVEKiO9MgbzgjvbHprTk20LPZeI2oolYwTv
	bfhfJMi8Jjls2/z7pimUXEEms6aw0FJc9JuJWkHWoWRvwL7T1wpLYUAzz6bltjoM
	2vgUG9yu4mlzmWV+IHCWXTBjiSZ/dM6YDBC6V7SsGTsRVxHrbi/FD44S5h6jphaN
	+/3M/uHTuwoJhmjeklSBFsTul42ZVMOKRfiBgvjovp3obD8rK3ahGXB47+M2I9Rv
	0k3+RpQkIWz6WJ+oiM8NSYvHffqyGvvUrTZpbN/qJIDPWt+IepLuE89hr3rN219m
	qX5C8A==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acuw48pee-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:31:58 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5dfb407f2faso122254137.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762968718; x=1763573518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oRq7N9zEd4E6O7kii0K2QODDGUwp+okVrUJjhuRm9ts=;
        b=eiU9JIauWEbifiV3OdtEVXYqhd1fOyoba4y/nwcxqnqNaRV0AGDEpARgR1WoojNtao
         2FREh14ULEO77JXp3RtZSou16xA5ytc6qd9jUMcYR/AYECMDqOhXjUmt8LJ6rhc/KkYx
         GWcS6uOAu1CQhjtoGXJtQzifKTqYy3ChrvxCenfeRxzRxeCULTfRmROP/Raa2iYrNczF
         zYLM184Mezg1ykSBVZyJ+IDAOOIpzK06y5vwjNJz+63t/rAfhRSyuGd1zOtv4jqpv6AM
         wkMaOptLti88Z4G6XfI5A9uo/bCW/Xsx1Hosc9Goh55rJ5zZZTp2V6d5gVZaCGsEe2ip
         jXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762968718; x=1763573518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRq7N9zEd4E6O7kii0K2QODDGUwp+okVrUJjhuRm9ts=;
        b=N5WIRBjt/krRjDLuJpkjB36gml6in6hQscRz8YUtXObkZg/NodswAJpsqcvlbVZFWg
         udEOth8hc51NAuVkK0TLZwCsJget0c5S0Bx50eSfZmyyOa5o4o9T1UulCG2wzlXWZOtt
         po8dm+dUgSzYClZDSnTfhkh9gWcJDD/NMXuaRsP7b7mP3jYBHQYhIB9pCTO4lfz6okRY
         l5e6KGcBPu9VwRkR89w247ikYyo/QYoNLq006mu1wX1Kq9tJ7k4bd/GB4GH4w6XnhoI9
         /+g0HgAD+CHUQpbAYHNIBm4PirbkBnol/QgpVW+GTsgFUyf8atcb/k/NOJxp6nGFgZQP
         sGDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXldEDUbSLOzqSvUGng/eSJ019kKV3UVupn000xJp4EMXpEXpeFF0ojHAlyXxC2MPwGbdCw2IowtiifGyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEyDtzsecysp13kFkw5aUkfxqJdDkM844Anx3GdVh2tBO1aere
	m3abnSU3Eka7uR7ueSxpetttlyg7HuJx+7eXlZklPFqTzX1IS5idk4daFbwWmXs+mlanKFnxDAq
	5D5byZdR6vilzXHL0IQXEOOvoyfwRfeQyvKaLLaW0NX/W70rhOtXvYu/ci+IzkRpui70=
X-Gm-Gg: ASbGncvBU0deg+XQePcKZKBOgl9Gwxt5f4iU+NrfoGo80VRMo4d/R3uyG1IqbX2QyHO
	aVcOTwncn8W+v+sc5BeD64oUB890vvVLYIYRYRGVb731p0QLkpmyAv4oqd8NlglGAxmVQPxkVA3
	db5Ms2zDTnzMf6TNee1hBf+mRReUIocNYQKN70TI3Jtb1JLa+LdZ7Xn41VQXGSiIwgL/wdcYrFr
	WiHWHDQSlQ+aSkzrRTsfApJSTFR1zZ2OnNUlsWJ+cUa8dRQa939q9v3SVTFcqtRft++/zi+datT
	a9BNAmfPRgsOBz/BZ8w/ZzlBWGbNs1/jtua4M7ncKErv9yyJ2slK+4JeBy2cXNNj/nw1yf0u7AC
	lXYJG6z5fqyyDcHxYC7pyUF1KRg==
X-Received: by 2002:a05:6102:4414:b0:5dd:888a:5d54 with SMTP id ada2fe7eead31-5de07e67c33mr1391607137.33.1762968717578;
        Wed, 12 Nov 2025 09:31:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiJyUMMrNVOX6ffx/lvBQ51RUGJEu6SBGxM1Dx1h6AXQTQL9O09CpizEhbeAdj5d3AN71GVw==
X-Received: by 2002:a05:6102:4414:b0:5dd:888a:5d54 with SMTP id ada2fe7eead31-5de07e67c33mr1391569137.33.1762968717168;
        Wed, 12 Nov 2025 09:31:57 -0800 (PST)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47787e3a62esm47050655e9.3.2025.11.12.09.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 09:31:56 -0800 (PST)
Message-ID: <f474c182-3a9d-4540-86b3-1f84ae3d14de@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 17:31:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] ASoC: codecs: wsa881x: split into common and
 soundwire drivers
To: Alexey Klimov <alexey.klimov@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20250522-rb2_audio_v3-v3-0-9eeb08cab9dc@linaro.org>
 <20250522-rb2_audio_v3-v3-5-9eeb08cab9dc@linaro.org>
 <f1337654-ff69-4489-840a-a1b38efb7f74@oss.qualcomm.com>
 <DE6W0RIF2Y26.1MENYDV2RIAIP@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <DE6W0RIF2Y26.1MENYDV2RIAIP@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rt7oQq4VCr-bm6sjIsl_QWZ-C0ohI8mq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0MSBTYWx0ZWRfX9mAbNoWEY3J4
 xMbjVBeKPvLgElLINXmPcgpbKWDP8tHpOJqVStsJGtU7Vd7Grx8+LcNfmBt3Y3UnfqcaQU6o2ii
 aMJmJkZVlMp1/DqbbPaDxu3t+rTeQ7EMfXX9kqcSw0IlY8gsCy1NG+LuNVQik4kaFAjWwUdHzTT
 SE153yUu8znSZM5RZrRWxk+G+nXrbV5U+zEmLbvl1iPmzbr1ozn+0PSkzDok6oRnHif8cT992R8
 UxcvxaKs5pIrso7a+NiqQtSuFHtd1eJgL2GEqTy2v2GWv//ykdXq7mE3fvMX/p6nGIQ48KKvkMm
 46e3iLBpPzkVQLUynHXOY0/2WL4Vplh07pKTMZqFlgSopcRoYPnIvL2w+VsKLKVGhA6VqafRRuH
 NmaNCba2xRtMD32vjCrE8mk6IX6Ozg==
X-Authority-Analysis: v=2.4 cv=F+Bat6hN c=1 sm=1 tr=0 ts=6914c48e cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
 a=Kxc87NqaCDsCGrhekR4A:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: rt7oQq4VCr-bm6sjIsl_QWZ-C0ohI8mq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120141

On 11/12/25 5:21 PM, Alexey Klimov wrote:
> On Thu May 29, 2025 at 11:05 AM BST, Srinivas Kandagatla wrote:
>>
>>
>> On 5/22/25 6:40 PM, Alexey Klimov wrote:
>>> This is required in order to introduce wsa881x driver that works
>>> in analog mode and is configurable via i2c only.
>>> Functional changes, if any, are kept to be minimal and common
>>> parts or parts that can be shared are moved into wsa881x-common
>>> helper driver.
>>> The regmap config structure now contains 0x3000 offset as required
>>> by soundwire spec.
>>>
>>> While at this, also fix the typo in WSA881X_ADC_EN_SEL_IBIAS
>>> register name and rename wsa881x_set_sdw_stream() to
>>> wsa881x_set_stream() and update registers description in the
>>> header and use the new defines in wsa881x_init_common() and
>>> in wsa881x_digital_mute().
>>>
>>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Cc: Srinivas Kandagatla <srini@kernel.org>
>>> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
>>> ---
>>>  sound/soc/codecs/Kconfig          |   4 +
>>>  sound/soc/codecs/Makefile         |   2 +
>>>  sound/soc/codecs/wsa881x-common.c | 193 +++++++++++++++
>>>  sound/soc/codecs/wsa881x-common.h | 458 +++++++++++++++++++++++++++++++++++
>>>  sound/soc/codecs/wsa881x.c        | 493 +-------------------------------------
>>
>> How about we have something like wsa881x.c wsa881x-sdw.c wsa881x-i2c.c ?
> 
> I am totaly open to suggestions. Splitting to wsa881x-{sdw,i2c}.c sounds
> good to me.
thanks, and it makes it more aligned with what other codecs do too.

--srini> I kept the original name to keep the changes minimal.
> 
> 
> 
> [...] (the rest of the patch was quoted and sent but I didn't find any
> comments there, please let me know if I missed something there)
> 
> Best regards,
> Alexey
> 


