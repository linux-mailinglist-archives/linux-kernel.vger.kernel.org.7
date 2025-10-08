Return-Path: <linux-kernel+bounces-845734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276F0BC5FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777CF42334C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C082BDC15;
	Wed,  8 Oct 2025 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QxgL5eC1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332FA2BD029
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759939730; cv=none; b=LG+6745oRVZJiMt45jHvDTIi7fr5lJmJ3UXJSk67Z1ne5c9i5iO+cZmZpx4rNB11RvPM3DUVIFJeIn7oYIHzRlvW3+TicuI5gP5mPl6DIs8ZuwSpA12ZcDYjepwZyWue8ZPI9D8gPea5xdaAqoHF9klXIhlrpyEtOPPmGDjQedQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759939730; c=relaxed/simple;
	bh=/8QRT4JYvQJoEiFUqoKv6XYp3suGZTvOAD9gkcmDGbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZifbpoC7R0wzVDGR1gYl7XZvIK+oqyPWVys4TXgTkctBQp23x9Ydz8h1Fg/G94lQ9AofLhZtghbeVn52i3PKKP49lCqpjhXWkHZHckmMB6oIpII2qRta0UXm4wJ4JU8BuKTYWJEAA1nSsgKP1TYzOX4XXVl0yaUROndfVt/qT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QxgL5eC1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890Nrn009319
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 16:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EadjyGqEoA7yy7p0yBcMwTqor+vd8CVmNzzcVZ8d0bM=; b=QxgL5eC1Tp2tsIRI
	fFqGDVkgK1KGlVN+dQx+kF6PSCff7xqz8YtjLMBW0XXfDEBtXeVthaY0Q+/jnKHF
	F0Ep2yCoxNXA2Ec1L8NLfjvno9IXrsaz8vST1l7Sk4Jbj1/w3mnzjU67vjeP2+oA
	Kqh7cJnAi513maPQE9K79cVzgczjvjN9eFtaybkKSejRWESr4i1kZ2fcVA35D5pa
	VU4k3y6xptzmTyf9bWpjQEYszVQamskZOXJBoOmjLQprzs1/fhM7JzfDwQHfhVXQ
	5VwDQM2gFamWjUS+c95JV+8cHolO0dY+/0G4hp2ucNrM/uOvtN+9FNN22qB2NCY9
	7Tfamw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49junub701-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 16:08:47 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eb18b5500so99161a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759939727; x=1760544527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EadjyGqEoA7yy7p0yBcMwTqor+vd8CVmNzzcVZ8d0bM=;
        b=Unvl7Oz9onHN0WERtWs5FEZk6DrT+H632G/Oksdg2hWNLG30IMmm09xEpz5vjt8mrC
         850q4bL0KGSgaSPGZOPRoEQlBm9O2G4UIYaJZutXDciSecZJ29CfwjdxB/wQ6tztjd1p
         LUjZfMDWEwGj9gZrf2m14IaAVeYIy2ySQ/FHBVJei7MzN/5gOoHvmE91+2kR+HOex1Ol
         RfD3U0NLdg0rH/AQGvf+hDE5s6BJSabwk6XQ95jGtJYZX3JncToIQrQy4dLNS60/0vuW
         v1l3v/uJc0OyJg0VzL1MJYjq1ZOUZ+tDyXHI5+KggcUQ5TXsQuC0FSUPNGGCIC0ehVgL
         rO0g==
X-Forwarded-Encrypted: i=1; AJvYcCVbC+yL3OLHqST58Isgci/Xa+hhZaVikLM7XaEp7cevw+/1rWkeFBtm5+61u7NgjRRsMCXtKX7rMDZ31fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJox7BLnBVBnrmU4lEFy2S7gyHm96iKgL8kg20NGWxq8K3rFYe
	p7fG0xOUypc1bDf/ocbUfTvRi/GTvTRJ12+bTrt/rUKiP1nQo+hKX+8Loi4Q0/8BCBct9a/mYol
	T13ofTTrZacdgyPwLTcgVIGAhMC+TQL9rzHETQrMtI/heS69lhwBzAHcC30+lsoVU+/0=
X-Gm-Gg: ASbGncv0uf2oGSkWdFkU6k0K0S4bgLCrPx5dcdb5yXmKSMsMtC3Z4T1MwRKYN4FexkI
	nVvHldwsX35ZVYPj2GwyfH3vNYg3xHFXySfOg/5wIUEANVFr0fGqB8GTahYEFLTB/lZuN46COsx
	/QSp4yUhXsNI5zBEUqn2xNG32rdU/W+UApt8Rw5soJy1KX1dnu9I6OxfniDFfsdW2mvHh0WCkos
	l1aOGiT5VncMsBISmbt8sjlAccEwNkKoeGsKnqrKjCXmi19hDZzfG9y6a8Fw/JuKNGjlhgI/zxQ
	3pZPil+SVFMCIQq5bWbqlNhcIJBJOIjacRLzn72XEBShRjQiojD3MpD0lyyLchYyTfvbludtA8O
	5YTF0CQwn8w==
X-Received: by 2002:a17:90b:1d0a:b0:332:50e7:9d00 with SMTP id 98e67ed59e1d1-33b51118f31mr5680182a91.11.1759939726570;
        Wed, 08 Oct 2025 09:08:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsdh5wKz6+TIrygmcHpwH5Y/NXlAXm9029ErhADPyESV1HZY16vtvxPYKuUeH7km1h74G+9A==
X-Received: by 2002:a17:90b:1d0a:b0:332:50e7:9d00 with SMTP id 98e67ed59e1d1-33b51118f31mr5680122a91.11.1759939725888;
        Wed, 08 Oct 2025 09:08:45 -0700 (PDT)
Received: from [192.168.1.5] ([122.171.120.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b51115ad2sm3930345a91.12.2025.10.08.09.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 09:08:45 -0700 (PDT)
Message-ID: <b257d715-cc12-46cc-ba31-7f7fc257f763@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 21:38:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ASoC: soc-pcm: Fix mute and unmute control for
 non-dynamic DAI links
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
        ajay.nandam@oss.qualcomm.com, stable@vger.kernel.org
References: <20251007023325.853640-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <d9971ca4-1911-4204-b175-1ceeaae7c238@kernel.org>
Content-Language: en-US
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
In-Reply-To: <d9971ca4-1911-4204-b175-1ceeaae7c238@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3j2BEpFqubhXyw-O2nGbGvjz_tLWYR3c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMyBTYWx0ZWRfX4WSIZNNHthMI
 7WMpVLscDqM2anTM3GzMlcc48Uf9KqYeIaEQE1jM+H6HrPRy/1J4co21WM0CGbe+q13yL6hqWe0
 H+eai+yvB9JcyC907vB4djqz6C3juw4qK1rUWRgRCqyLOFHmk/Tjm5XWsoqwpTi2Z5LtmiFs3W/
 39E8x4/29zdabtGIQBZ8Xgdsd/r8ny9MQhA2S8Gd8uj3ZFFffBqpSSWcUealUTwEUEHP2zpistM
 DGOKwJ0hFze6qcUnNy6Y7+SdK3OqJ4paFKl/k7LGJ/EPxFL9r5B6I/SViEXJrtibzlpedteR7PA
 xHqqN4RJojdaG3wNdIu6KmyTNmmVkP71It6v/9Cz5Ttl8BZwBhFBEOyRwAUv9FgwAD19BLHWnJz
 xAGIFTHvf7ZM/Q29tFxwrFvseEHlxQ==
X-Authority-Analysis: v=2.4 cv=CbIFJbrl c=1 sm=1 tr=0 ts=68e68c8f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=x3w4O99MFjH9QQBP9/sZlw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=4Xw4QKfpzqBY54n6qe8A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 3j2BEpFqubhXyw-O2nGbGvjz_tLWYR3c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040023



On 10/8/2025 7:16 PM, Srinivas Kandagatla wrote:
> 
> 
> On 10/7/25 3:33 AM, Mohammad Rafi Shaik wrote:
>> In setups where the same codec DAI is reused across multiple DAI
>> links, mute controls via `snd_soc_dai_digital_mute()` is skipped for
> 
> Please explain the problem.
> 
In Qualcomm audioreach setup, if platform dai not specified in DT, then
cpu dai using as platform and initialize as static dai-link and created
pcm device and link-dynamic == false by default.

In existing setup if dynamic==false, it's skipping trigger snd-ops and 
the codec is always on mute state.

>> non-dynamic links. The trigger operations are not invoked when
>> `dai_link->dynamic == 0`, and mute controls is currently conditioned
> 
> I dont think any of the Qualcomm upstream platforms use this flag.
> 

Yes, we are using dynamic flag and it's set to true in Qualcomm platforms.

Please check: 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/tree/sound/soc/qcom/qdsp6/topology.c#n1093

>> only on `snd_soc_dai_mute_is_ctrled_at_trigger()`. This patch ensures
>> that mute and unmute is applied explicitly for non-dynamic links.
> How is this resolving the issue, mute on these codecs happens at trigger
> level instead of prepare.
> 
yes agree, but if link->dynamic==false the trigger ops not getting 
called, which leading to codec always on mute state.

Thanks & Regards,
Rafi.

> --srini
>>
>> Fixes: f0220575e65a ("ASoC: soc-dai: add flag to mute and unmute stream during trigger")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
>> ---
>>   sound/soc/soc-pcm.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
>> index 2c21fd528afd..4ed829b49bc2 100644
>> --- a/sound/soc/soc-pcm.c
>> +++ b/sound/soc/soc-pcm.c
>> @@ -949,7 +949,7 @@ static int __soc_pcm_prepare(struct snd_soc_pcm_runtime *rtd,
>>   			SND_SOC_DAPM_STREAM_START);
>>   
>>   	for_each_rtd_dais(rtd, i, dai) {
>> -		if (!snd_soc_dai_mute_is_ctrled_at_trigger(dai))
>> +		if (!snd_soc_dai_mute_is_ctrled_at_trigger(dai) || !rtd->dai_link->dynamic)
>>   			snd_soc_dai_digital_mute(dai, 0, substream->stream);
>>   	}
>>   
>> @@ -1007,7 +1007,7 @@ static int soc_pcm_hw_clean(struct snd_soc_pcm_runtime *rtd,
>>   			soc_pcm_set_dai_params(dai, NULL);
>>   
>>   		if (snd_soc_dai_stream_active(dai, substream->stream) == 1) {
>> -			if (!snd_soc_dai_mute_is_ctrled_at_trigger(dai))
>> +			if (!snd_soc_dai_mute_is_ctrled_at_trigger(dai) || !rtd->dai_link->dynamic)
>>   				snd_soc_dai_digital_mute(dai, 1, substream->stream);
>>   		}
>>   	}
> 


