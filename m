Return-Path: <linux-kernel+bounces-804673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D1BB47B72
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 14:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B10F7B2D39
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 12:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B5A270EBC;
	Sun,  7 Sep 2025 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iXCNPexG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F4C23BD1F
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757249295; cv=none; b=fHIhpGDWa15CqSQj874kvZqAl88Pn9ae7ufsYkJglnBbi+KR2x8mkA4ozepviETY/ed6jW0JxvNcvPPle4OQigdDTShTM7GQ7HrXE4+Kqf6Aezp1RFRyQzA60bWa56ha4Vhg0E/W6wvftTLVtO+afhzn8JnCaORhoUtf7Tc2xbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757249295; c=relaxed/simple;
	bh=fovseDpu+uBVSyhkPuz3suEFYJtmdGB3aLws1MqwV/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cX44Mzp6s+Zt6dEpR5d8DMLvywgktb2m4IzHDJ+oQgJHhRH0uJhyZNTJRuGCkZSwsZ+/JbrHz4fX1pf/GiLBgffZOez0ZtTLondMY6hua3YgF2NrkIxgK3yD6WJWQpFYdIzrk+XjUyrHFGzKLw3+xd4sJu970GkZf0MTpSNAulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iXCNPexG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587AQ5hS018465
	for <linux-kernel@vger.kernel.org>; Sun, 7 Sep 2025 12:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pfAmweq7JyBuIK2YLoea3uL1qJZjl0HZWJilg59gpOM=; b=iXCNPexGVnqjEcB5
	P527Jno7dswx6qeEqQNsuqyAM8ckrRJhKTDnflfzV7vgDmw9P2GUtv5u6bIN9vja
	8e5sYYjMwgUhas75XLDhK3PYL8N80ssjVLpJR2uh7kbiXLzBfYDuzWN6qkGn31cK
	PLMxu95wtcMla57HF/tmJubrn8kuMUiRL41kWKgQEpy4AGwRM5LJByIiYxF8koxY
	onu0KfDjSMOGTBqtViZli9I6vwXOvquICLqYtMcHgwKZ8lJzFDMc+iCzCt8XEgY6
	2geBnMQwmOz05n4EjXHTW3y97yVYiVnBjiwwCzbLoC7OY1Hpv0h2u45QXyi3HG11
	m2emAA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j25hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 12:48:11 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b47253319b8so2726433a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 05:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757249290; x=1757854090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfAmweq7JyBuIK2YLoea3uL1qJZjl0HZWJilg59gpOM=;
        b=FcbBSEK+za8lxQfWh0e01YxpKqtccPfo8F4qRsrE/rYdfq6jYFEcqu1grM8eWnGO2o
         gESPphlAkt/krlRqGS/fGPpMsWqVXHHQR8Ja9Tcj01wegRosGQys2aaiPxiE8gerNFUm
         hukPHcsV81Fn2hsMw5PX04r2MqY+qG3yjjIVwPMk4cxLowpNQk4+i7J91CIQfr70Z3kq
         Ef44g4A5gfAS/h1yudqIav5r2OK9BoCIEjrD7uF8d6/yZWuCVkp5jdPE76BOYN/kEuBa
         7y5irvInTyKNkqllztPMrGAlN58qhEEap5J56sEJpbkq+5tiZJWLCUX0vERChh+RtbyM
         3G4w==
X-Forwarded-Encrypted: i=1; AJvYcCUH5DDMJRK0tRAtWlw81ifj2/w+0BaROkQrKoExkOHTz0MwxtZ+Oh+EHy9Z88TdvuxBNeBhhJ8PLwFS4vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLcN5uZ3jSfdI31uiWPgLZ+c6xKJlchoeatrAv7fak9THrM1cx
	Fb3tNotMNyfaMyoyyEtGQST/swXBubO36XSHeYCvp/a0IShMyrecYDUg0ETDsuWAbEdCGHY3e4G
	GhrldS3Dzz+TUtirr51lqqDFfHAt2OJrTUeAr537TdHv/r0QEBwwHi7ullJEJuY3HnLY=
X-Gm-Gg: ASbGncueuH8T/szjun3aUuRJehxIMETtwNFOJQv6lCNNzqAd2RCHz6wqTNd8ZvqZfDs
	hTS3qTQnN2S2lkGy5C3IDItxdiNgmxzs9O7TvASqJr3kaRDMHT1JyoizHUHUXjZ4T9UomgIT+Lm
	4aZOfOcWll7mLmpG4JX91r8H6qIPnMXd8OrWS6CZFZmCNIc5TBHH1GN5BMmcSBRGp1SAwc62y4z
	Oxfni21tGpMY0x1+0NtqnhzRDzEZesTzbaFumkN9jv1ctL+jX7R9hEnSs0LlzifjbxTi9Fj21to
	Pd/N+rseVwbR6d5JCotlrGGlFTMrMMTeIBymUjP/3XzfWocYjWm7/poqpijnaKa1pxc++u6VTv5
	q+RF2
X-Received: by 2002:a05:6a20:3943:b0:243:f5ba:aa9c with SMTP id adf61e73a8af0-2534073ed6cmr7506758637.25.1757249289772;
        Sun, 07 Sep 2025 05:48:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENWjF4ugvYWq1kcweui34vJDpxHEqv2vVeVqYw4aUXOwqNAELGDOT7480x/k7bScPoBqYfsg==
X-Received: by 2002:a05:6a20:3943:b0:243:f5ba:aa9c with SMTP id adf61e73a8af0-2534073ed6cmr7506730637.25.1757249289290;
        Sun, 07 Sep 2025 05:48:09 -0700 (PDT)
Received: from [192.168.1.5] ([122.169.129.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4d6cde2f0fsm22929103a12.13.2025.09.07.05.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 05:48:08 -0700 (PDT)
Message-ID: <eaa235f2-b6be-46e9-bee2-1a4818736d42@oss.qualcomm.com>
Date: Sun, 7 Sep 2025 18:18:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ASoC: qcom: sc8280xp: Fix DAI format setting for
 MI2S interfaces
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
        ajay.nandam@oss.qualcomm.com
References: <20250905150445.2596140-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250905150445.2596140-4-mohammad.rafi.shaik@oss.qualcomm.com>
 <899db9f0-27f5-4404-8357-4985e084ac99@oss.qualcomm.com>
Content-Language: en-US
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
In-Reply-To: <899db9f0-27f5-4404-8357-4985e084ac99@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX912zXkUyamBw
 Rexf58pEuQBaZMMJOslCClrDG0bAupBnpty9IyImmKb0NoskFAAMMC9NuYnvc+7oZe6qGmWYKrt
 1/hI2Gb49YR/WT8WsblFMJRyWEiPoCnBQNwzQwWwIkBNf7sSDcP4zRM6LeG3EZ9Du/AqU1eCgLA
 IfkpApG4P5BvVHMWTMV638iTrCsHBQyaoBnKuepnVykLtb/5ZtmpwgoR+D4Jydv+klpBXhjSmE6
 grXbEpRWoGBIIs7urAPiuzrxTjFj3x0W5VlXpFtWH2cEC2TJFJGXuPND4Qxq3Ow7i81MPXiulCq
 nieIVxhPeCYQhnZq8v0J29JizG/JrVZ0tpokdCBBuxSDZGHeTClYMOTF/VtS+wkUN3cz2/HNjzb
 bqRp62KI
X-Proofpoint-ORIG-GUID: SmfsEmRsZBBR6Ku-SK60pRDqKaIZMUBP
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68bd7f0b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=/ZFYPCvVo1eZwIJTb8k6Sw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=YKXIHFROM69d4h8Ztm0A:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: SmfsEmRsZBBR6Ku-SK60pRDqKaIZMUBP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022



On 9/7/2025 3:30 PM, Srinivas Kandagatla wrote:
> On 9/5/25 4:04 PM, Mohammad Rafi Shaik wrote:
>> The current implementation does not configure the CPU DAI format for
>> MI2S interfaces, resulting in -EIO errors during audio playback and
>> capture. This prevents the correct clock from being enabled for the
>> MI2S interface. Configure the required DAI format to enable proper
>> clock settings. Tested on Lemans evk platform.
>>
>> Fixes: 295aeea6646ad ("ASoC: qcom: add machine driver for sc8280xp")
> 
> Am really not sure if this is a fix, because sc8280xp does not have any
> Mi2S support. If you have added support for MI2S on any other platform
> that uses sc8280xp machine driver, then that is the right fixes tag.
> 

ACK.

You're right, thanks for the clarification.

I'll update the patch based on the inputs provided.

Thanks & Regards,
Rafi.

> --srini
>> Cc: <stable@vger.kernel.org>
>> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
>> ---
>>   sound/soc/qcom/sc8280xp.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
>> index 73f9f82c4e25..3067b95bcdbb 100644
>> --- a/sound/soc/qcom/sc8280xp.c
>> +++ b/sound/soc/qcom/sc8280xp.c
>> @@ -32,6 +32,10 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
>>   	int dp_pcm_id = 0;
>>   
>>   	switch (cpu_dai->id) {
>> +	case PRIMARY_MI2S_RX...QUATERNARY_MI2S_TX:
>> +	case QUINARY_MI2S_RX...QUINARY_MI2S_TX:
>> +		snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_BP_FP);
>> +		break;
>>   	case WSA_CODEC_DMA_RX_0:
>>   	case WSA_CODEC_DMA_RX_1:
>>   		/*
> 


