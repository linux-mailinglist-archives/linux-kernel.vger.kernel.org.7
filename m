Return-Path: <linux-kernel+bounces-802655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7967B45539
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A525C1E7D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E562EB5B4;
	Fri,  5 Sep 2025 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fILQNVkA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1482EAB83
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069175; cv=none; b=r6dxkLMR8Jr2TFD/wqBNmP1jOYsfEj0WqwghjtsgwVZCrn8MEsuXn9DbxtddCL2mngFWVymve6uSjkY+dqVz1XbV9Iy8NZpRqNxF+Oll3TUvMPU8EcOYeaG64NHMUo1mCAS8c7mqbv6HhDjd/Jdi8X6huGw4ynmebMJq9r+wWXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069175; c=relaxed/simple;
	bh=6duR9AAEjGMbDChCm8l0AFz9pGIbE/3Wj9Ss016HRu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GXJ2Jai50t73JPqRvRSnzOsOv0Freyuvhm0fjY5r7waCQDG1rXieRje3gOD4HAPvi9Oo2AUtTAKHesH6BNHuF0GLIGtVmIyfGLjS2YizRJC2HIloyyBZdkpD9eq1euQHlLRhd/Zj/gJUk9+24GtcloimcGgQQJF2GxS2MPGYl94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fILQNVkA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857KOV5012118
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 10:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J/7Fvq0+FlOaEckovLs1a380VDNkHEU+i14RtfKNleU=; b=fILQNVkAxHT0ZY6O
	jRGEvytkX82/e3eFG6T8msjXcbkGYPu5eTCcgwcbcJU1V3XKXOSgWBYFhYhcMPNj
	FbZowFTJ4+z8+OIWv07RrkRTB3ImRPMbkme2+CvYolzH574tz2r7jQ1FgE1/FYIC
	k6SW/ZVhvnHl6cUD2U3wOuTDqejnuVeGwcoO3EIV1nNSP/Ye3UVx8MGUdful/60g
	oLxuHJZ33m29xrO4iUsx1ktEJWhtYQARmdz69XpCqGLsaxiZGRmAUoP16v9cwlxo
	bd18I6oKU+YdTZ0g1zCZU9fmfA55XsrbhP4pbQTJUvnGqL7Rrb3QU9bDRJPt4w+s
	K56NQg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj76hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:46:12 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-720408622e2so37436956d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757069171; x=1757673971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/7Fvq0+FlOaEckovLs1a380VDNkHEU+i14RtfKNleU=;
        b=lkvY/aMijwT0/rBta9fpzdYJ9n0m2ArgJ+YRTEa8tj5+xmOATRbmArydDxXP5oc0UM
         3GEpO5CSRgWZTQTx2T4idP7CSQtOWQn4PW2xj//F/KzxGEf6LQwihoqStLJv8xbS2mK8
         Bx+4neK7H1yBjMumys7AAXaWVc7SNwdz7OSysPZiPB0deMrxO2u2iczDtEmcdG1LH+lN
         k2m2zMKS003Usx+bWYx7Iw5yqiJOhbztCEvUfBEKmfUPP2lAq5DcJVI2TnJ+urtUQUnz
         KJ5qyAP7Jyoh/RV1xs6y24dIAQM/CY9qiGBVwlTcNgGTFX1RkCk2KG+hk2SQyYFlkLty
         j3Fw==
X-Forwarded-Encrypted: i=1; AJvYcCU9htZGjT9wH8rWycbiVGbOnT/NJZtU+d/yt0SykiM4VyS/nJ28x2Khh+26j5Q4pNhnT0wChFaNzz59Wf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeCCYdREeMSmeRuk3GUiZ2DNuUp5JNutWn/+yq0+bhDvdIrnbA
	VRMFu4fx61naQeQzSbO+J2nhTTcRaDMtuiAD93FwKreyEWNAROZgHKqyl3RsKBULF2IU2y+xp/f
	YqkWfIygEZazm5PiE82XCmNkQbN76Mh2rRmKIQo+ZNeWXqD3s6UFsUNNlsQ2WjBZU8L0+TWR9Bo
	E=
X-Gm-Gg: ASbGncvufoyLHWhcf+7kQivm/2Ko08zmdxMOL24/3u2RZZZ3Aofz8zsFDx+Dv4arxPF
	dVxSRebfnt2XVYaGG8rfygdgdIvVz5ao51RIIpLxNn5yDpy86+0H1ocq6UtAqJtE2bxyZwjhKO/
	MVtl+ibpCBTxW7R0D2gi/c8+zuVUCtAgpNumCw2iqR2k1yzUlW483dqtwNgBC20Dd2pP3XeGLtQ
	e4HbEajO0ZbxURemccUPsY8mhw1ih2/BGIi30FUmojaTfchx5srmtGHvuvs5dAQ+YIimPJaK3aB
	Iy4N/Z6+5EC4BlBZFGITI66S+LkQaXunLP+ANLynyJctFW+PLKKXBe5kVNSMkzGfFhk=
X-Received: by 2002:ad4:594a:0:b0:72c:cc04:c3b6 with SMTP id 6a1803df08f44-72ccc04c48dmr22169846d6.31.1757069171487;
        Fri, 05 Sep 2025 03:46:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENRTTCwihhjXzgztLbzF3k7QDm2kkG3ZKRYNv9pLyaHqZ4H+c5PLsgbiWtYQtvOUfDYu5mfA==
X-Received: by 2002:ad4:594a:0:b0:72c:cc04:c3b6 with SMTP id 6a1803df08f44-72ccc04c48dmr22168666d6.31.1757069169201;
        Fri, 05 Sep 2025 03:46:09 -0700 (PDT)
Received: from [192.168.68.119] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45dd05d0c43sm37831165e9.2.2025.09.05.03.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 03:46:08 -0700 (PDT)
Message-ID: <fb126ef2-aa44-4a67-9188-3483b07b73d6@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 11:46:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ASoC: qcom: sc8280xp: Fix DAI format setting for
 MI2S interfaces
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com, ajay.nandam@oss.qualcomm.com
References: <20250905104020.2463473-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250905104020.2463473-4-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20250905104020.2463473-4-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfX24tFy80r8SQO
 nCG70TIC5PUU6ynaI84oO6UV6wMrx9KfVF22UWgJ8xPxR5M+K91iMqmgmm4of7Nm338g4WiYIgd
 801kn7nEtfQuBV00vqZIm21QXmdMMgy3YjfchS1m7bvaRx4iFp1z+cf+56wmhWPqXsg79fnVMJ7
 QwClIQQtjLzqC2+akJCE8a1TO6rWCfLlk4TsflMX/7eSBSnIQS6xl/vvBgUf0OVO3LM86L4x+wg
 TIexsHE3fz+gqE3YqTPk2O6L5brIVrIxTZsQh7fDiZ2opUS+IQJrFenk8/ET1Y0N+Ng7O0E75K4
 0S1ZwMgcxlJTl73q1IVLqgylvmWT3Nd29TEkAjnxAA8SHsFlIfSDL7SSk6aEDvt2MTiefF7LYg9
 APaR6cI0
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68babf75 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=4EjxHe3qrgCn2qlGiy0A:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: sZAU4FMDnHd_6p4YMdyyw_bwCLLQA1GC
X-Proofpoint-ORIG-GUID: sZAU4FMDnHd_6p4YMdyyw_bwCLLQA1GC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

On 9/5/25 11:40 AM, Mohammad Rafi Shaik wrote:
> The current implementation does not configure the CPU DAI format for
> MI2S interfaces, resulting in -EIO errors during audio playback and
> capture. This prevents the correct clock from being enabled for the
> MI2S interface. Configure the required DAI format to enable proper
> clock settings. Tested on Lemans evk platform.
> 
> Fixes: 295aeea6646ad ("ASoC: qcom: add machine driver for sc8280xp")
Why? this is not a fix, this is an enhancement to the machine driver.

> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> ---

other than that,  LGTM

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

--srini

>  sound/soc/qcom/sc8280xp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
> index 73f9f82c4e25..2fd06354923a 100644
> --- a/sound/soc/qcom/sc8280xp.c
> +++ b/sound/soc/qcom/sc8280xp.c
> @@ -32,6 +32,9 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
>  	int dp_pcm_id = 0;
>  
>  	switch (cpu_dai->id) {
> +	case PRIMARY_MI2S_RX...QUATERNARY_MI2S_TX:
> +		snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_BP_FP);
> +		break;
>  	case WSA_CODEC_DMA_RX_0:
>  	case WSA_CODEC_DMA_RX_1:
>  		/*


